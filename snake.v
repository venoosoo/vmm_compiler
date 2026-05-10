import "std/std.v"
import "std/vector.v"

struct vec2 {
    int x;
    int y;
}

global long time_sec;
global long time_nsec;

fn update_time() {
    asm {
        "lea rsi, [time_sec]"
        "mov rax, 228"
        "xor rdi, rdi"
        "syscall"
    }
}

global long start_sec;
global long start_nsec;

fn init_timer() {
    update_time();
    start_sec = time_sec;
    start_nsec = time_nsec;
}

fn get_elapsed_ms() -> long {
    update_time();
    long sec_diff = time_sec - start_sec;
    long nsec_diff = time_nsec - start_nsec;
    if nsec_diff < 0 {
        sec_diff = sec_diff - 1;
        nsec_diff = nsec_diff + 1000000000;
    }
    return sec_diff * 1000 + nsec_diff / 1000000;
}


struct GameData {
    int score;
    long time;
}


global long rand_seed;

fn rand(int min, int max) -> int {
    rand_seed = rand_seed * 6364136223846793005 + 1442695040888963407;
    long r = rand_seed;
    if r < 0 { r = r * -1; }
    int range = max - min;
    int result = (r % range) + min;
    return result;
}

fn rand_init() {
    asm {
        "rdtsc"
        "shl rdx, 32"
        "or rax, rdx"
        "mov [rand_seed], rax"
    }
}

global char termios[60];

fn set_raw_mode() {
    syscall(16,0,0x5401,termios as long,0,0);
    termios[12] = termios[12] & 0xF5;
    termios[23] = 1;
    termios[22] = 0;
    syscall(16,0,0x5402,termios as long,0,0);
}

fn set_nonblocking() {
    syscall(72,0,4,0x800,0,0);
}

global char buf[3];

fn read_key() -> int {
    int n = syscall(0, 0, buf as long, 3,0,0);
    if n <= 0 { return 0; }
    if buf[0] == 0x1B {
        if buf[1] == 0x5B {
            if buf[2] == 0x41 { return 1; }
            if buf[2] == 0x42 { return 2; }
            if buf[2] == 0x43 { return 3; }
            if buf[2] == 0x44 { return 4; }
        }
    }
    return 0;
}

fn check_collision(Vector<vec2>* player) -> int {
    vec2* head = vec_get_element<vec2>(player,0);
    if head->x == 4294967295 {
        head->x = 9;
    }
    if head->x > 9 {
        head->x = 0;
    }
    if head->y == 4294967295 {
        head->y = 19;
    }
    if head->y > 19 {
        head->y = 0;
    }

    if player->length <= 2 {
        return 0;
    }
    for (int i = 1; i < player->length; i = i + 1) {
        vec2* el = vec_get_element<vec2>(player,i);
        if head->x == el->x and head->y == el->y {
            return 1;
        }
    }
    return 0;
}

fn change_player_pos(Vector<vec2>* player,int* key,int previous_key) {
    vec2* head = vec_get_element<vec2>(player,0);
    
    if *key == 1 and previous_key == 2 { *key = previous_key; } 
    else if *key == 2 and previous_key == 1 { *key = previous_key; } 
    else if *key == 3 and previous_key == 4 { *key = previous_key; } 
    else if *key == 4 and previous_key == 3 { *key = previous_key; }

    if player->length > 1 {
        for (int i = player->length - 1; i > 0; i = i - 1) {
            vec2* pos = vec_get_element<vec2>(player,i);

            vec2* next_pos = vec_get_element<vec2>(player,i-1);
            pos->x = next_pos->x;
            pos->y = next_pos->y;
        }
    }
    
    if *key == 1 {
        if head->x < 0 {
            head->x = 9;
        } else {
            head->x = head->x - 1;
        }
        
    } else if *key == 2 {
        head->x = head->x + 1;
    } else if *key == 3 {
        head->y = head->y + 1;
    } else if *key == 4 {
        if head->y < 0 {
            head->y = 19;
        } else {
            head->y = head->y - 1;
        }
    }
}

fn respawn_apple(Vector<vec2>* player,vec2* apple_pos) {
    int isTaken = 1;
    while isTaken {
        int x = rand(0,9);
        int y = rand(0,19);
        int temp = 1;
        for (int i = 0; i < player->length; i = i + 1) {
            vec2* el = vec_get_element<vec2>(player,i);
            if el->x == x and el->y == y {
                temp = 0;
            }
        }
        if temp {
            isTaken = 0;
            apple_pos->x = x;
            apple_pos->y = y;
        }
    }
}

fn render_screen(GameData* game_data,Vector<vec2>* vec, vec2* apple_pos) {
    for (int i = 0; i < 10; i = i + 1) {
        for (int j = 0; j < 20; j = j + 1) {
            int found = 0;
            for (int k = 0; k < vec->length; k = k + 1) {
                vec2* player_pos = vec_get_element<vec2>(vec, k);
                if player_pos->x == i and player_pos->y == j {
                    found = 1;
                }
            }

            vec2* head = vec_get_element<vec2>(vec,0);
            if (found == 1) and (apple_pos->x == head->x and apple_pos->y == head->y) {
                vec2* new_pos = malloc(sizeof(vec2));
                vec2* last_el = vec_get_element<vec2>(vec,vec->length - 1);
                new_pos->x = last_el->x;
                new_pos->y = last_el->y;
                game_data->score = game_data->score + 1;
                vector_push<vec2>(vec,new_pos);
                respawn_apple(vec,apple_pos);
            }
            if found == 1 {
                if head->x == i and head->y == j {
                    print_char('@' as char);
                } else {
                    print_char('|' as char);
                }
            } else if apple_pos->x == i and apple_pos->y == j {
                print_char('*' as char);
            } else {
                print_char('.' as char);
            }
            print_char(' ' as char);
        }
        println("");
    }
    print("score: ");
    print(game_data->score);
    print("                        ");
    print("time: ");
    println(game_data->time);
}



fn clear_screen() {
    for (int i = 0; i < 5; i = i + 1) {
        println("");
    }
}

fn main() {
    init_timer();
    set_raw_mode();
    set_nonblocking();
    vec2 player_pos = vec2 {
        x: 1,
        y: 1,
    };

    GameData game_data = GameData {
        score: 0,
        time: 0,
    };


    vec2 apple = vec2 {
        x: 2,
        y: 4,
    };

    Vector<vec2>* vec = create_vector<vec2>();
    vector_push<vec2>(vec,&player_pos);

    render_screen(&game_data,vec,&apple);

    int last_pressed = 3;
    long last_tick = 0;

    int interval = 300;
    int previous_key = 0;
    while 1 {

        long now = get_elapsed_ms();
        int key = read_key();
        if key != 0 {
            last_pressed = key
        }
        if now - last_tick > interval - (game_data.score * 2) {
            game_data.time = get_elapsed_ms() / 1000;
            last_tick = now;

            change_player_pos(vec,&last_pressed,previous_key);
            if check_collision(vec) {
                println("you lose");
                exit(0);
            }
            clear_screen();
            previous_key = last_pressed;
            render_screen(&game_data,vec,&apple);
            
        }
    }
}
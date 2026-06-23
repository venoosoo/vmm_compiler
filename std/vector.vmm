import "std.v"

struct Vector<T> {
    T* data;
    i64 length;
    i64 capacity;
    i64 element_size;
}



fn create_vector<T>() -> *Vector<T> {
    i32 el_size = sizeof(T);
    i64 base_capacity = 8;
    T* memory = malloc(el_size * base_capacity) as T*;
    Vector<T>* res = malloc(sizeof(Vector<T>));
    res->data = memory;
    res->length = 0;
    res->capacity = base_capacity;
    res->element_size = el_size;
    return res;
}

fn vector_push<T>(Vector<T>* vec, T element) {
    if vec->length == vec->capacity {
        i64 new_capacity = vec->capacity * 2;
        T* new_data = malloc(new_capacity * vec->element_size);
        memcpy(new_data, vec->data, vec->length * vec->element_size);
        vec->data = new_data;
        vec->capacity = new_capacity;
    }
    i64 offset = vec->length * vec->element_size;
    T* dest = vec->data + offset;
    memcpy(dest, &element, vec->element_size);
    vec->length = vec->length + 1;
}


fn vector_pop<T>(Vector<T>* vec) -> *T {
    if vec->length == 0 {
        exit(1);
    }
    vec->length = vec->length - 1;
    long offset = vec->length * vec->element_size;
    i32* element = vec->data + offset;
    return *element;
}

fn vec_get_element<T>(Vector<T>* vec, i32 element_pos) -> T {
    if vec->length < element_pos {
        exit(1);
    }
    i64 offset = vec->element_size * element_pos;
    T* element = vec->data + offset;
    return *element;
}
export default {
    methods: {
        isUnique(array, key, value) {
            return !array.some(item => item[key] === value);
        },
        validateInput(value) {
            return value === null || value === undefined || value === '';
        },
        // {{ edit_1 }}
        validateInputs(obj, keys) { // Metode baru untuk memvalidasi input
            return keys.some(key => !obj[key]);
        },
    },
};
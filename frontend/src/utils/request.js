import axios from 'axios'

const service = axios.create({
    baseURL: 'http://localhost:8080/',
})

axios.interceptors.request.use(
    function (config) {
        return config
    },
    function (error) {
        return Promise.reject(error)
    }
)

axios.interceptors.response.use(
    function (config) {
        return config
    },
    function (error) {
        return Promise.reject(error)
    }
)

export default service


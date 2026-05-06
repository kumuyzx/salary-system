import axios from 'axios'

const baseURL = import.meta.env.VITE_API_BASE_URL || '/api'

const service = axios.create({
    baseURL,
    timeout: 10000,
})

service.interceptors.request.use(
    function (config) {
        return config
    },
    function (error) {
        return Promise.reject(error)
    }
)

service.interceptors.response.use(
    function (config) {
        return config
    },
    function (error) {
        return Promise.reject(error)
    }
)

export default service


import service from  '../utils/request'


export function selectWords (obj) {
    return service.post('/select/selectWords', JSON.stringify(obj), {
        headers: { 'Content-Type': 'application/json' }
    })
}
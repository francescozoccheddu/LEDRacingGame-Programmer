.pragma library

function fromInt(val) {
    var vals = []
    while (val !== 0){
        vals.push(val & 0xFF)
        val >>= 8
    }
    return vals
}

function zeroPad(vals, lenght) {
    while (vals.length < lenght)
        vals.push(0)
    return vals
}

function toInt(vals) {
    var val = 0
    for (var i = 0; i < vals.length; i++)
        val |= vals[i] << (i * 8)
    return val
}

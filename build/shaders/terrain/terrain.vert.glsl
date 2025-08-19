// terrain.vert.glsl
precision highp float;
precision highp int;

varying vec4 vPosition;
varying vec3 vNormal;
varying vec2 vUv;
#ifdef USE_COLOR
varying vec4 vColor;
#endif

uniform sampler2D heightMap;
uniform bool heightMapProvided;

void main() {
    #ifdef USE_COLOR
    vColor = color;
    #endif

    vec3 dposition = position.xyz;
    
    if(heightMapProvided){
        float heightOffset = texture(heightMap, uv).x;
        dposition.z = heightOffset;
    }
    
    vPosition = modelViewMatrix * vec4(dposition, 1.0);
    vNormal = normalMatrix * normal;
    vUv = uv;
    
    gl_Position = projectionMatrix * vPosition;
}

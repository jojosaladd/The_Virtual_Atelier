// terrain.frag.glsl
precision highp float;
precision highp int;

uniform float ambient;
uniform float diffuse;
uniform float specular;
uniform float specularExp;
uniform float texCoordScale;

uniform sampler2D diffuseMap;
uniform bool diffuseMapProvided;

#if ( NUM_POINT_LIGHTS > 0 )
struct PointLight {
    vec3 color;
    vec3 position;
    float distance;
    float intensity;
    float decay;
};
uniform PointLight pointLights[NUM_POINT_LIGHTS];
#endif

varying vec4 vPosition;
varying vec3 vNormal;
varying vec2 vUv;

void main() {
    vec3 N = normalize(vNormal);
    vec3 V = normalize(-vPosition.xyz);
    
    vec4 textureColor = diffuseMapProvided ? 
        texture2D(diffuseMap, vUv * texCoordScale) : 
        vec4(0.25, 0.25, 0.27, 1.0);
    
    textureColor.rgb = mix(textureColor.rgb, vec3(0.3, 0.3, 0.32), 0.4);
    
    float reflection = pow(1.0 - abs(dot(N, V)), 1.8); 
    
    vec3 totalLight = vec3(0.0);
    
    #if ( NUM_POINT_LIGHTS > 0 )
    for(int i = 0; i < NUM_POINT_LIGHTS; i++) {
        vec3 L = normalize(pointLights[i].position - vPosition.xyz);
        vec3 H = normalize(L + V);
        
        float diff = max(dot(N, L), 0.0);
        float spec = pow(max(dot(N, H), 0.0), specularExp);
        
        float dist = length(pointLights[i].position - vPosition.xyz);
        float attenuation = pow(max(0.0, 1.0 - dist/pointLights[i].distance), pointLights[i].decay);
        
        totalLight += pointLights[i].color * pointLights[i].intensity * attenuation * (
            diff * diffuse + 
            spec * specular * 2.0 
        );
    }
    #endif
    
    vec3 ambientColor = textureColor.rgb * ambient * 0.8; 
    vec3 reflectionColor = mix(textureColor.rgb, vec3(1.0), reflection * 0.8); 
    vec3 finalColor = ambientColor + totalLight * reflectionColor;
    
    float edge = pow(1.0 - abs(dot(N, V)), 1.8);
    finalColor += edge * vec3(0.9);
    
    gl_FragColor = vec4(finalColor, textureColor.a);
}
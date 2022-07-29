using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Burning_Dissolve : MonoBehaviour
{
    [SerializeField] private Renderer target;
    void Start()
    {
        
    }
    float value = 0f;
    // Update is called once per frame
    void Update()
    {
        if(Input.GetKey(KeyCode.Alpha1))
        {            
            target.material.SetFloat("_Cut",value);
            value += Time.deltaTime;
        }
        else if(Input.GetKey(KeyCode.Alpha2))
        {
            target.material.SetFloat("_Cut", value);
            if (value <= 0)
                value = 0;
            else
                value -= Time.deltaTime;
        }

    }
}

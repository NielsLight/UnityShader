using UnityEngine;
using System.Collections;
using UnityEditor;
[ExecuteInEditMode]
public class ShaderingInWorldSpace : MonoBehaviour {

	public GameObject obj;
	// Use this for initialization
	void Start () {		
	}

	// Update is called once per frame
	void Update () {
		if(obj!=null)
		{
			Debug.Log ("Set");
			GetComponent<Renderer>().sharedMaterial.SetVector("_Point",new Vector4(obj.transform.position.x,obj.transform.position.y,obj.transform.position.z,1));   
		}
	}
}

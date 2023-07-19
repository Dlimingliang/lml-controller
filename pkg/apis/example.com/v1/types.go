package v1

import metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

// +genclient
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object
type Lml struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`
	Spec              LmlSpec   `json:"spec"`
	Status            LmlStatus `json:"status"`
}

type LmlSpec struct {
	DeploymentName string `json:"deploymentName"`
	Image          string `json:"image"`
	Replicas       *int32 `json:"replicas"`
}

type LmlStatus struct {
	AvailableReplicas int32 `json:"availableReplicas"`
}

// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object
type LmlList struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata"`
	Items             []Lml `json:"items"`
}

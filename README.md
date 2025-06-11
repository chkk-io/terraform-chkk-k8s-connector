## Chkk K8s Connector Terraform Module

This Terraform module simplifies the creation of a Chkk K8s Connector.

## Providers

| Name | Version |
|------|---------|
| helm | >= 2.10.0 |
| gavinbunney/kubectl | >= 1.7.0 |

## Usage

The following snippet will deploy the Chkk Operator with the specified access token. The operator will install the Chkk K8s Connector in the namespace `chkk-system`. The specified access token will be stored in a newly created secret resource and will be mounted in the Chkk Operator and the ChkkAgent resources.

```
module "chkk_k8s_connector" {
  source     = "git::https://github.com/chkk-io/terraform-chkk-k8s-connector.git?ref=v0.1.6"

  create_namespace = true
  namespace        = "chkk-system"

  chkk_operator_config = {
    secret = {
      chkkAccessToken = <TOKEN>
    }
  }
}
```

The following snippet will deploy the Chkk Operator using the `chkk-operator-secret` secret object. The operator will install the Chkk K8s Connector in the namespace `chkk-system`. The secret will be mounted in both the Chkk Operator and the ChkkAgent resource.

```
module "chkk_k8s_connector" {
  source     = "git::https://github.com/chkk-io/terraform-chkk-k8s-connector.git?ref=v0.1.6"

  create_namespace = true
  namespace        = "chkk-system"

  chkk_operator_config = {
    secret = {
      create = false,
      ref = {
        secretName = chkk-operator-secret,
        keyName = accessToken
      }
    }
  }
}
```

The following snippet will deploy the Chkk Operator using the `chkk-operator-secret` secret object. The operator will install the Chkk K8s Connector in the namespace `chkk-system`. The `chkk-operator-secret` secret will be mounted in the Chkk Operator and `chkk-agent-secret` will be used in the ChkkAgent resource.

```
module "chkk_k8s_connector" {
  source     = "git::https://github.com/chkk-io/terraform-chkk-k8s-connector.git?ref=v0.1.6"

  create_namespace = true
  namespace        = "chkk-system"

  chkk_operator_config = {
    secret = {
      create = false,
      ref = {
        secretName = chkk-operator-secret,
        keyName = accessToken
      }
    }
  }

  chkk_agent_config = {
    secret = {
      secretName = chkk-agent-secret,
      keyName = accessToken
    }
  }
}
```

The following snippet will deploy the Chkk Operator with the specified access token and a mounted Service Account. The operator will install the Chkk K8s Connector in the namespace `chkk-system`. The Service Account `chkk-operator-custom-sa` will be used for the Chkk Operator and a new Service Account will be created for the ChkkAgent resource.

```
module "chkk_k8s_connector" {
  source     = "git::https://github.com/chkk-io/terraform-chkk-k8s-connector.git?ref=v0.1.6"

  create_namespace = true
  namespace        = "chkk-system"

  chkk_operator_config = {
    secret = {
      chkkAccessToken = <TOKEN>
    }
    serviceAccount = {
      create = true,
      name = chkk-operator-custom-sa
    }
  }
}
```

The following snippet will deploy the Chkk Operator with the specified access token and mounted Service Accounts. The operator will install the Chkk K8s Connector in the namespace `chkk-system`. The Service Account `chkk-operator-custom-sa` will be used for the Chkk Operator and the Service Account `chkk-agent-custom-sa` will be used for the ChkkAgent resource. No new Service Accounts will be created.

```
module "chkk_k8s_connector" {
  source     = "git::https://github.com/chkk-io/terraform-chkk-k8s-connector.git?ref=v0.1.6"

  create_namespace = true
  namespace        = "chkk-system"

  chkk_operator_config = {
    secret = {
      chkkAccessToken = <TOKEN>
    }
    serviceAccount = {
      create = false,
      name = chkk-operator-custom-sa
    }
  }

  chkk_agent_config = {
    serviceAccount = {
      create = false,
      name = chkk-agent-custom-sa
    }
  }
}
```

The following snippet will deploy the Chkk Operator with the specified access token. The operator will install the Chkk K8s Connector in the namespace `chkk-system`. The specified access token will be stored in a newly created secret resource and will be mounted in the Chkk Operator and the ChkkAgent resources. The ChkkAgent will override the default cluster name and environment.

```
module "chkk_k8s_connector" {
  source     = "git::https://github.com/chkk-io/terraform-chkk-k8s-connector.git?ref=v0.1.6"

  create_namespace = true
  namespace        = "chkk-system"

  operator_config = {
    secret = {
      chkkAccessToken : <TOKEN>
    }
  }

  cluster_name = "eks-prod-uswest2"
  cluster_environment = "prod"
}
```

The following snippet will deploy the Chkk Kubernetes Connector with custom images for: Chkk Operator, Chkk Agent, and Chkk Agent Manager. 

```
module "chkk_k8s_connector" {
  source     = "git::https://github.com/chkk-io/terraform-chkk-k8s-connector.git?ref=v0.1.6"

  create_namespace = true     
  namespace        = "chkk-system"

  chkk_agent_config = {
    agent_image = {
      name = "public.ecr.aws/chkk/cluster-agent:v0.1.10"
    }
    manager_image = {
      name = "public.ecr.aws/chkk/cluster-agent-manager:v0.1.10"
    }
  }

  chkk_operator_config = {
    secret = {
      chkkAccessToken = <TOKEN>
    }
    image = {
      repository = "public.ecr.aws/chkk/operator"
      tag        = "v0.0.10"
    }
  }
}
```

The following snippet will deploy the Chkk Operator with a custom schedule (every 6 hours) for the ChkkAgent. The agent by default runs every 12 hours.

```
module "chkk_k8s_connector" {
  source     = "git::https://github.com/chkk-io/terraform-chkk-k8s-connector.git?ref=v0.1.6"

  create_namespace = true
  namespace        = "chkk-system"

  chkk_operator_config = {
    secret = {
      chkkAccessToken = <TOKEN>
    }
  }

  chkk_agent_config = {
    schedule = "0 */6 * * *"  # Every 6 hours
  }
}
```

For a complete reference, see the section below.

## Inputs
The module accepts following variables: <br>
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| release_name | The name of the helm release | `string` | chkk-operator | no |
| namespace | The namespace to deploy resources | `string` | chkk-system | no |
| chart_version | The version of the helm chart to deploy | `string` | n/a | no |
| create\_namespace | Whether to create namespace if it doesn't exist | `bool` | true | no |
| filter | Override the default filter for the ChkkAgent| `string` | n\a | no |
| cluster_name | Override the default cluster name for the ChkkAgent | `string` | n\a | no |
| cluster_environment | Override the default cluster environment for the ChkkAgent | `string` | n\a | no |
| chkk\_operator\_config | Values for the Chkk Operator Helm chart | `map` | {} | no |
| chkk\_operator\_config.secret | Secret object for Chkk Operator | `map` | {} | no |
| chkk\_operator\_config.secret.create | Whether to create secret resource or use existing resource | `boolean` | true | no |
| chkk\_operator\_config.secret.accessToken | If create is set to true, this value will be used as secret | `string` | "" | no |
| chkk\_operator\_config.secret.ref.secretName | If create is set to false, this should be the secret object resource name | `string` | "" | no |
| chkk\_operator\_config.secret.ref.keyName | If create is set to false, this should be the secret object key name | `string` | "" | no |
| chkk\_operator\_config.serviceAccount | Service Account object for Chkk Operator | `map` | {} | no |
| chkk\_operator\_config.serviceAccount.create | Whether to create service account resource or use an existing resource | `boolean` | true | no |
| chkk\_operator\_config.serviceAccount.name | Name for the service account | `string` | chkk-operator-sa | no |
| chkk\_agent_\_config | Override default ChkkAgent config | `map` | {} | no |
| chkk\_agent_\_config.secret | Secret object for ChkkAgent | `string` | "" | no |
| chkk\_agent_\_config.secret.accesToken | Access Token to be used for in ChkkAgent resource | `string` | "" | no |
| chkk\_agent_\_config.secret.secretName | Name of the secret object to be used in ChkkAgent, this takes precedence over "accessToken"  | `string` | "" | no |
| chkk\_agent_\_config.secret.keyName | Name of the key inside the secret object to be used in ChkkAgent, this takes precedence over "accessToken" | `string` | "" | no |
| chkk\_agent_\_config.serviceAccount | Service Account object for ChkkAgent | `map` | {} | no |
| chkk\_agent_\_config.serviceAccount.create | Whether to create RBAC (Service Account, Role, etc) for ChkkAgent or use an existing resource | `boolean` | true | no |
| chkk\_agent_\_config.serviceAccount.serviceAccountName | If create is false, this should be the name of the existing Service Account | `string` | "" | no |
| chkk\_agent_\_config.agent_image | Agent Image object for ChkkAgent | `map` | {} | no |
| chkk\_agent_\_config.agent_image.name | Full image name for the agent image (repository:tag) | `string` | "" | no |
| chkk\_agent_\_config.manager_image | Manager Image object for ChkkAgent | `map` | {} | no |
| chkk\_agent_\_config.manager_image.name | Full image name for the manager image (repository:tag) | `string` | "" | no |
| chkk\_agent_\_config.schedule | Cron schedule for ChkkAgent execution | `string` | "" | no |

## Outputs
No output.

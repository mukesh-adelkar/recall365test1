## VARIABLES DESCRIPTION

variable "**enabled**"  
  type        = "string"   
  description = "Set to false to prevent the module from creating any resources"  
  default = "true"

variable "**namespace**"  
  type        = "string"  
  "Namespace (_e.g._ `eg` or `cp`)"  
  default     = ""

variable "**stage**"  
type        = "string"  
  description = "Stage (_e.g._ `prod`, `dev`, `staging`)"  
  default     = ""

variable "**name**"  
  type        = "string"  
  description = "EFS cluster name"

variable "**eks_security_groups**"  
  type        = "list"

variable "**vpc_id**"  
  type        = "string"

variable "**region**"  
  type        = "string"

variable "**subnets**"  
  type    = "list"

variable "**availability_zones**"  
  type        = "list"

variable "**delimiter**"  
  type        = "string"  
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
  default     = "-"

variable "**attributes**"  
  type        = "list"  
  description = "Additional attributes (e.g. `1`)"  
  default     = []

variable "**tags**"  
  type        = "map"  
  description = "Additional tags (e.g. `{ BusinessUnit = \"XYZ\" }`"

variable "**encrypted**"  
  type        = "string"  
  description = "If true, the disk will be encrypted"  
  default     = "false"

variable "**performance_mode**"  
  type        = "string"  
  description = "The file system performance mode. Can be either `generalPurpose` or `maxIO`"  
  default     = "generalPurpose"

variable "**provisioned_throughput_in_mibps**"  
  default     = 0  
  description = "The throughput, measured in MiB/s, that you want to provision for the file system. Only applicable with throughput_mode set to provisioned"

variable "**throughput_mode**"  
  type        = "string"  
  description = "Throughput mode for the file system. Defaults to bursting. Valid values: bursting, provisioned. When using provisioned, also set provisioned_throughput_in_mibps"  
  default     = "bursting"

variable "**mount_target_ip_address**"  
  type        = "string"  
  description = "The address (within the address range of the specified subnet) at which the file system may be mounted via the mount target"  
  default     = ""
Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F197A20CF
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:26:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9lW-0004NR-Hq; Fri, 15 Sep 2023 10:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qh9l9-0004Lp-5e; Fri, 15 Sep 2023 10:25:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qh9l5-0001mt-JE; Fri, 15 Sep 2023 10:25:26 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnGYn0Jn4z6D901;
 Fri, 15 Sep 2023 22:20:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 15 Sep
 2023 15:25:11 +0100
Date: Fri, 15 Sep 2023 15:25:09 +0100
To: <ankita@nvidia.com>
CC: <jgg@nvidia.com>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>, <ani@anisinha.ca>,
 <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/4] vfio: new command line params for device memory
 NUMA nodes
Message-ID: <20230915152509.00003788@Huawei.com>
In-Reply-To: <20230915024559.6565-2-ankita@nvidia.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-2-ankita@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, 14 Sep 2023 19:45:56 -0700
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> The CPU cache coherent device memory can be added as a set of
> NUMA nodes distinct from the system memory nodes. The Qemu currently
> do not provide a mechanism to support node creation for a vfio-pci
> device.
> 
> Introduce new command line parameters to allow host admin provide
> the desired starting NUMA node id (pxm-ns) and the number of such
> nodes (pxm-nc) associated with the device. In this implementation,
> a numerically consecutive nodes from pxm-ns to pxm-ns + pxm-nc
> is created. Also validate the requested range of nodes to check


Hi Ankit,

That's not a particularly intuitive bit of interface!

pxm-start
pxm-number
perhaps?  However, in QEMU commmand lines the node terminology is used so
numa-node-start
numa-node-number

Though in general this feels backwards compared to how the rest of
the numa definition is currently done.

Could the current interface be extended.

-numa node,vfio-device=X

at the cost of a bit of house keeping and lookup.

We need something similar for generic initiators, so maybe
vfio-mem=X? (might not even need to be vfio specific - even
if we only support it for now on VFIO devices).
leaving
initiator=X available for later...

Also, good to say why multiple nodes per device are needed.

Jonathan

> for conflict with other nodes and to ensure that the id do not cross
> QEMU limit.
> 
> Since the QEMU's SRAT and DST builder code needs the proximity
> domain (PXM) id range, expose PXM start and count as device object
> properties.
> 
> The device driver module communicates support for such feature through
> sysfs. Check the presence of the feature to activate the code.
> 
> E.g. the following argument adds 8 PXM nodes starting from id 0x10.
> -device vfio-pci-nohotplug,host=<pci-bdf>,pxm-ns=0x10,pxm-nc=8
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  hw/vfio/pci.c               | 144 ++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.h               |   2 +
>  include/hw/pci/pci_device.h |   3 +
>  3 files changed, 149 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a205c6b113..cc0c516161 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -42,6 +42,8 @@
>  #include "qapi/error.h"
>  #include "migration/blocker.h"
>  #include "migration/qemu-file.h"
> +#include "qapi/visitor.h"
> +#include "include/hw/boards.h"
>  
>  #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>  
> @@ -2955,6 +2957,22 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>      }
>  }
>  
> +static void vfio_pci_get_dev_mem_pxm_start(Object *obj, Visitor *v,
> +                                           const char *name,
> +                                           void *opaque, Error **errp)
> +{
> +    uint64_t pxm_start = (uintptr_t) opaque;
> +    visit_type_uint64(v, name, &pxm_start, errp);
> +}
> +
> +static void vfio_pci_get_dev_mem_pxm_count(Object *obj, Visitor *v,
> +                                           const char *name,
> +                                           void *opaque, Error **errp)
> +{
> +    uint64_t pxm_count = (uintptr_t) opaque;
> +    visit_type_uint64(v, name, &pxm_count, errp);
> +}
> +
>  static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>  {
>      Error *err = NULL;
> @@ -2974,6 +2992,125 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>      vdev->req_enabled = false;
>  }
>  
> +static int validate_dev_numa(uint32_t dev_node_start, uint32_t num_nodes)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int i;
> +
> +    if (num_nodes >= MAX_NODES) {
> +        return -EINVAL;
> +    }
> +
> +    for (i = 0; i < num_nodes; i++) {
> +        if (ms->numa_state->nodes[dev_node_start + i].present) {
> +            return -EBUSY;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int mark_dev_node_present(uint32_t dev_node_start, uint32_t num_nodes)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int i;
> +
> +    for (i = 0; i < num_nodes; i++) {
> +        ms->numa_state->nodes[dev_node_start + i].present = true;
> +    }
> +
> +    return 0;
> +}
> +
> +
> +static bool vfio_pci_read_cohmem_support_sysfs(VFIODevice *vdev)
> +{
> +    gchar *contents = NULL;
> +    gsize length;
> +    char *path;
> +    bool ret = false;
> +    uint32_t supported;
> +
> +    path = g_strdup_printf("%s/coherent_mem", vdev->sysfsdev);

If someone has asked for it, why should we care if they specify it on a
device where it doesn't do anything useful?  This to me feels like something
to check at a higher level of the stack.

> +    if (g_file_get_contents(path, &contents, &length, NULL) && length > 0) {
> +        if ((sscanf(contents, "%u", &supported) == 1) && supported) {
> +            ret = true;
> +        }
> +    }
> +
> +    if (length) {
> +        g_free(contents);

g_autofree will clean this up for you I think

> +    }
> +    g_free(path);

and this.

> +
> +    return ret;
> +}
> +
> +static int vfio_pci_dev_mem_probe(VFIOPCIDevice *vPciDev,
> +                                         Error **errp)
> +{
> +    Object *obj = NULL;
> +    VFIODevice *vdev = &vPciDev->vbasedev;
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    int ret = 0;
> +    uint32_t dev_node_start = vPciDev->dev_node_start;
> +    uint32_t dev_node_count = vPciDev->dev_nodes;
> +
> +    if (!vdev->sysfsdev || !vfio_pci_read_cohmem_support_sysfs(vdev)) {
> +        ret = -ENODEV;
return -ENODEV; 

and similar in all the other cases as no cleanup to do.

> +        goto done;
> +    }
> +
> +    if (vdev->type == VFIO_DEVICE_TYPE_PCI) {

nicer to handle one condition at a time.

    if (vdev->type != VFIO_DEVICE_TYPE_PCI) {
        return -EINVAL;
    }

    obj = vfio_pci_get_object(vdev);
this can't fail

Also get rid of assigning it to NULL above.

   if (DEVICE_CLASS(object...)) {
      return -EINVAL;
   }


> +        obj = vfio_pci_get_object(vdev);
> +    }
> +
> +    /* Since this device creates new NUMA node, hotplug is not supported. */
> +    if (!obj || DEVICE_CLASS(object_get_class(obj))->hotpluggable) {
> +        ret = -EINVAL;
> +        goto done;
> +    }
> +
> +    /*
> +     * This device has memory that is coherently accessible from the CPU.
> +     * The memory can be represented seperate memory-only NUMA nodes.
> +     */
> +    vPciDev->pdev.has_coherent_memory = true;
> +
> +    /*
> +     * The device can create several NUMA nodes with consecutive IDs
> +     * from dev_node_start to dev_node_start + dev_node_count.
> +     * Verify
> +     * - whether any node ID is occupied in the desired range.
> +     * - Node ID is not crossing MAX_NODE.
> +     */
> +    ret = validate_dev_numa(dev_node_start, dev_node_count);
> +    if (ret) {
> +        goto done;
        return ret;

> +    }
> +
> +    /* Reserve the node by marking as present */
> +    mark_dev_node_present(dev_node_start, dev_node_count);
> +
> +    /*
> +     * To have multiple unique nodes in the VM, a series of PXM nodes are
> +     * required to be added to VM's SRAT. Send the information about the
> +     * starting node ID and the node count to the ACPI builder code.
> +     */
> +    object_property_add(OBJECT(vPciDev), "dev_mem_pxm_start", "uint64",
> +                        vfio_pci_get_dev_mem_pxm_start, NULL, NULL,
> +                        (void *) (uintptr_t) dev_node_start);
> +
> +    object_property_add(OBJECT(vPciDev), "dev_mem_pxm_count", "uint64",
> +                        vfio_pci_get_dev_mem_pxm_count, NULL, NULL,
> +                        (void *) (uintptr_t) dev_node_count);
> +
> +    ms->numa_state->num_nodes += dev_node_count;
> +
> +done:
> +    return ret;
> +}
> +
>  static void vfio_realize(PCIDevice *pdev, Error **errp)
>  {
>      VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> @@ -3291,6 +3428,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          }
>      }
>  
> +    ret = vfio_pci_dev_mem_probe(vdev, errp);
> +    if (ret && ret != -ENODEV) {
> +        error_report("Failed to setup device memory with error %d", ret);
> +    }
> +
>      vfio_register_err_notifier(vdev);
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
> @@ -3454,6 +3596,8 @@ static Property vfio_pci_dev_properties[] = {
>      DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>                         sub_device_id, PCI_ANY_ID),
>      DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
> +    DEFINE_PROP_UINT32("pxm-ns", VFIOPCIDevice, dev_node_start, 0),
> +    DEFINE_PROP_UINT32("pxm-nc", VFIOPCIDevice, dev_nodes, 0),
>      DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
>                                     nv_gpudirect_clique,
>                                     qdev_prop_nv_gpudirect_clique, uint8_t),
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index a2771b9ff3..eef5ddfd06 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -158,6 +158,8 @@ struct VFIOPCIDevice {
>      uint32_t display_yres;
>      int32_t bootindex;
>      uint32_t igd_gms;
> +    uint32_t dev_node_start;
> +    uint32_t dev_nodes;
>      OffAutoPCIBAR msix_relo;
>      uint8_t pm_cap;
>      uint8_t nv_gpudirect_clique;
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index d3dd0f64b2..aacd2279ae 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -157,6 +157,9 @@ struct PCIDevice {
>      MSIVectorReleaseNotifier msix_vector_release_notifier;
>      MSIVectorPollNotifier msix_vector_poll_notifier;
>  
> +    /* GPU coherent memory */
> +    bool has_coherent_memory;
> +
>      /* ID of standby device in net_failover pair */
>      char *failover_pair_id;
>      uint32_t acpi_index;



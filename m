Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DACA897EE
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 11:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4cYi-0000nm-Ru; Tue, 15 Apr 2025 05:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u4cYK-0000hL-6F; Tue, 15 Apr 2025 05:26:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u4cYG-0002NX-7E; Tue, 15 Apr 2025 05:25:59 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcJZL5lXcz6M4jR;
 Tue, 15 Apr 2025 17:21:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 1C8CA140114;
 Tue, 15 Apr 2025 17:25:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 11:25:43 +0200
Date: Tue, 15 Apr 2025 10:25:42 +0100
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 4/5] hw/arm/virt: Add support for smmuv3 device
Message-ID: <20250415102542.00007fd7@huawei.com>
In-Reply-To: <20250415081104.71708-5-shameerali.kolothum.thodi@huawei.com>
References: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
 <20250415081104.71708-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 15 Apr 2025 09:11:03 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> Allow cold-plug of smmuv3 device to virt If the machine wide smmuv3
> or a virtio-iommu is not specified.
> 
> Also restrict the usage if virt <= 9.2. This will prevent accidently
> creating a SMMUv3 device on machines prior to 9.2 and cause failure
> on migrating to machines with same version but has a legacy smmuv3
> device.

Hi,

As we discussed internally I'm not convinced we need to prevent this particular
way for a user to shoot themselves in the foot.

To be a problem they have to specifically request an old machine + the
device that didn't exist for that machine, then migrate to a real old
version of QEMU.  Agreed it is possible but I'm not sure we need to
prevent that particular crazy.

Jonathan


> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> ToDo: probably need to change virt <= 9.2 to 10.0 considering the 
> Qemu cycle we are at now.
> ---
>  hw/arm/virt.c         | 54 +++++++++++++++++++++++++++++++++++++++++++
>  hw/core/sysbus-fdt.c  |  3 +++
>  include/hw/arm/virt.h |  1 +
>  3 files changed, 58 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 729f192558..8d0ae79f4d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -56,6 +56,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> +#include "hw/pci/pci_bus.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/core/sysbus-fdt.h"
> @@ -1445,6 +1446,31 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
>      g_free(node);
>  }
>  
> +static void create_smmuv3_dev_dtb(VirtMachineState *vms,
> +                                  DeviceState *dev)
> +{
> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> +    SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
> +    int irq = platform_bus_get_irqn(pbus, sbdev, 0);
> +    hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    MachineState *ms = MACHINE(vms);
> +    PCIBus *bus;
> +
> +    bus = PCI_BUS(object_property_get_link(OBJECT(dev), "primary-bus",
> +                                           &error_abort));
> +    if (strcmp("pcie.0", bus->qbus.name)) {
> +        warn_report("SMMUv3 device only supported with pcie.0 for DT");
> +        return;
> +    }
> +    base += vms->memmap[VIRT_PLATFORM_BUS].base;
> +    irq += vms->irqmap[VIRT_PLATFORM_BUS];
> +
> +    vms->iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> +    create_smmuv3_dt_bindings(vms, base, irq);
> +    qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
> +                           0x0, vms->iommu_phandle, 0x0, 0x10000);
> +}
> +
>  static void create_smmu(const VirtMachineState *vms,
>                          PCIBus *bus)
>  {
> @@ -2944,6 +2970,18 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>          qlist_append_str(reserved_regions, resv_prop_str);
>          qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
>          g_free(resv_prop_str);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3_DEV)) {
> +        VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> +
> +        if (vmc->no_smmuv3_device) {
> +            error_setg(errp, "virt machine does not support arm-smmuv3-device");
> +        } else if ((vms->iommu == VIRT_IOMMU_VIRTIO) ||
> +                   (vms->iommu == VIRT_IOMMU_SMMUV3)) {
> +            error_setg(errp, "virt machine already has %s set."
> +                       "Doesn't support multiple incompatible iommus",
> +                       (vms->iommu == VIRT_IOMMU_VIRTIO) ?
> +                       "virtio-iommu" : "iommu=smmuv3");
> +        }
>      }
>  }
>  
> @@ -2967,6 +3005,19 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>          virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
>      }
>  
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3_DEV)) {
> +        VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> +
> +        create_smmuv3_dev_dtb(vms, dev);
> +        if (vms->iommu != VIRT_IOMMU_SMMUV3_DEV) {
> +            vms->iommu = VIRT_IOMMU_SMMUV3_DEV;
> +        }
> +        if (!vmc->no_nested_smmu) {
> +            object_property_set_str(OBJECT(dev), "stage", "nested",
> +                                    &error_fatal);
> +        }
> +    }
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>          PCIDevice *pdev = PCI_DEVICE(dev);
>  
> @@ -3169,6 +3220,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3_DEV);
>  #ifdef CONFIG_TPM
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>  #endif
> @@ -3418,8 +3470,10 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 0)
>  
>  static void virt_machine_9_2_options(MachineClass *mc)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
>      virt_machine_10_0_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len);
> +    vmc->no_smmuv3_device = true;
>  }
>  DEFINE_VIRT_MACHINE(9, 2)
>  
> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> index e85066b905..ec90ed2c14 100644
> --- a/hw/core/sysbus-fdt.c
> +++ b/hw/core/sysbus-fdt.c
> @@ -31,6 +31,7 @@
>  #include "qemu/error-report.h"
>  #include "system/device_tree.h"
>  #include "system/tpm.h"
> +#include "hw/arm/smmuv3.h"
>  #include "hw/platform-bus.h"
>  #include "hw/vfio/vfio-platform.h"
>  #include "hw/vfio/vfio-calxeda-xgmac.h"
> @@ -512,6 +513,8 @@ static const BindingEntry bindings[] = {
>  #ifdef CONFIG_LINUX
>      TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
>      TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
> +    /* No generic DT support for smmuv3 dev. Support added for arm virt only */
> +    TYPE_BINDING(TYPE_ARM_SMMUV3_DEV, no_fdt_node),
>      VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
>  #endif
>  #ifdef CONFIG_TPM
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 12395c7594..9f98345c92 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -136,6 +136,7 @@ struct VirtMachineClass {
>      bool no_tcg_lpa2;
>      bool no_ns_el2_virt_timer_irq;
>      bool no_nested_smmu;
> +    bool no_smmuv3_device;
>  };
>  
>  struct VirtMachineState {



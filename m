Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3667B0346
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:42:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSvn-00077a-J3; Wed, 27 Sep 2023 07:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qlSvh-00074c-1Z; Wed, 27 Sep 2023 07:42:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qlSvf-0000C3-5H; Wed, 27 Sep 2023 07:42:08 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RwZTQ16PYz6J9CV;
 Wed, 27 Sep 2023 19:42:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 27 Sep
 2023 12:42:02 +0100
Date: Wed, 27 Sep 2023 12:42:01 +0100
To: <ankita@nvidia.com>
CC: <jgg@nvidia.com>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>, <ani@anisinha.ca>,
 <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 4/4] acpi/gpex: patch guest DSDT for dev mem information
Message-ID: <20230927124201.00006d5b@Huawei.com>
In-Reply-To: <20230915024559.6565-5-ankita@nvidia.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-5-ankita@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Thu, 14 Sep 2023 19:45:59 -0700
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> To add the memory in the guest as NUMA nodes, it needs the PXM node index
> and the total count of nodes associated with the memory. The range of
> proximity domains are communicated to the VM as part of the guest ACPI
> using the nvidia,gpu-mem-pxm-start and nvidia,gpu-mem-pxm-count DSD
> properties. These value respectively represent the staring proximity
> domain id and the count. Kernel modules can then fetch this information
> and determine the numa node id using pxm_to_node().
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>

Hi Ankit,

I'm not a fan of reading AML blobs, but they are better than reading
code that is generating AML.  Can we have an example of the DSDT blob
this generates?

In particular I'm not sure what the relationship of this new device
is to the related PCI bits and pieces.  Looks like it's not doing what
I'd normally expect which would be to add the _DSD to an entry for the
PCI EP.  Obviously might be too late to do that given need to match
physical system, but I'd like the opportunity to moan about it anyway :)

As a note we have various _DSD and _DSM associated with PCI devices on our
Kunpeng servers (usually for odd power control or reset corner cases or
errata work arounds) and they work very well without needing to put
the stuff in a separate device - hence I'm not really understanding
why you'd do it this way...

Jonathan

> ---
>  hw/pci-host/gpex-acpi.c | 69 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 7c7316bc96..0548feace1 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -49,6 +49,72 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
>      }
>  }
>  
> +static void acpi_dsdt_add_cohmem_device(Aml *dev, int32_t devfn,
> +                                        uint64_t dev_mem_pxm_start,
> +                                        uint64_t dev_mem_pxm_count)
> +{
> +    Aml *memdev = aml_device("CMD%X", PCI_SLOT(devfn));
> +    Aml *pkg = aml_package(2);
> +    Aml *pkg1 = aml_package(2);
> +    Aml *pkg2 = aml_package(2);
> +    Aml *dev_pkg = aml_package(2);
> +    Aml *UUID;
> +
> +    aml_append(memdev, aml_name_decl("_ADR", aml_int(PCI_SLOT(devfn) << 16)));
> +
> +    aml_append(pkg1, aml_string("dev-mem-pxm-start"));
> +    aml_append(pkg1, aml_int(dev_mem_pxm_start));
> +
> +    aml_append(pkg2, aml_string("dev-mem-pxm-count"));
> +    aml_append(pkg2, aml_int(dev_mem_pxm_count));
> +
> +    aml_append(pkg, pkg1);
> +    aml_append(pkg, pkg2);
> +
> +    UUID = aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301");
> +    aml_append(dev_pkg, UUID);
> +    aml_append(dev_pkg, pkg);
> +
> +    aml_append(memdev, aml_name_decl("_DSD", dev_pkg));
> +    aml_append(dev, memdev);
> +}
> +
> +static void find_mem_device(PCIBus *bus, PCIDevice *pdev,
> +                            void *opaque)
> +{
> +    Aml *dev = (Aml *)opaque;
> +
> +    if (bus == NULL) {
> +        return;
> +    }
> +
> +    if (pdev->has_coherent_memory) {
> +        Object *po = OBJECT(pdev);
> +
> +        if (po == NULL) {
> +            return;
> +        }
> +
> +        uint64_t pxm_start
> +           = object_property_get_uint(po, "dev_mem_pxm_start", NULL);
> +        uint64_t pxm_count
> +           = object_property_get_uint(po, "dev_mem_pxm_count", NULL);
> +
> +        acpi_dsdt_add_cohmem_device(dev, pdev->devfn, pxm_start, pxm_count);
> +    }
> +}
> +
> +static void acpi_dsdt_find_and_add_cohmem_device(PCIBus *bus, Aml *dev)
> +{
> +    if (bus == NULL) {
> +        return;
> +    }
> +
> +    pci_for_each_device_reverse(bus, pci_bus_num(bus),
> +                                find_mem_device, dev);
> +
> +}
> +
>  static void acpi_dsdt_add_pci_osc(Aml *dev)
>  {
>      Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
> @@ -207,7 +273,10 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>  
>      acpi_dsdt_add_pci_route_table(dev, cfg->irq);
>  
> +    acpi_dsdt_find_and_add_cohmem_device(cfg->bus, dev);
> +
>      method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
> +
>      aml_append(method, aml_return(aml_int(cfg->ecam.base)));
>      aml_append(dev, method);
>  



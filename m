Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 564BC724783
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 17:21:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6YSm-00022V-Io; Tue, 06 Jun 2023 11:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q6YSj-00021u-Td
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q6YSh-0002r9-Vs
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686064746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TX2l+C5m89/P40WVYyvUaRW/0GYByO5EcjOBoLA+e7c=;
 b=dG7MR0HbkDt6rjuoZbAcyWBgRMiwmgszmRd5jsFc6ly+mqdIW9bsEdpaYSxrdaF1Pl36p1
 Aa6qXiv/fcppUCFnGQ9IWLLBr5+aWWzRp/zBnVuO3eKAY8nxyGDKVBpmR9VaLHGNLnqgLq
 D04rapXVTPzmWEEoL0HC2umo0in5fpU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-_dOEkXwDORSOYM2SzA-hCg-1; Tue, 06 Jun 2023 11:19:05 -0400
X-MC-Unique: _dOEkXwDORSOYM2SzA-hCg-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-33bccb5e25fso55393795ab.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 08:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686064744; x=1688656744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TX2l+C5m89/P40WVYyvUaRW/0GYByO5EcjOBoLA+e7c=;
 b=TgNsodHpm68Cxr2EVvlqdgZ8pAsxEKx6Tx4KcreBnPXMjhUPyoCsjjX8uwEOxSOZ5I
 hD7bbCFRXh13nxBNAAbhR+PMvyYnmtEFvUPq1pWabV5THNQFbaWXGjPNn36bLp64wUOo
 Vm/csr62GbXuqRqw2c7ywnklPmV6YAUvn+GitJVFpkb9A4xO1M+Ur0UMXqfsTVkaOJ3e
 JzjDZ6qkkbCOOrNmVc+7bDBWWrhEpwCwQoKyBas4LA3y5WGi81cbhmSl1foyJ+31JRJn
 iDkN9bDhtP65f1f0tr+Fl0stShmut+YFfhLRgE+fpmFnjVWW4uAiklNUMKsY+1z+UuMW
 jVzw==
X-Gm-Message-State: AC+VfDwfnbepA0mLiEbXpw1QVkSqNRJXxmU2Twty7RGIp970LL7k3rhX
 z30XCx+0IYqSoKLMrOwZYqNchGApn8RSeEcNPUUH4r60c2n0e8Q8PEo3MDdns7Ev3E2IlfmjglZ
 SOfCLbWMGpKAbNOU=
X-Received: by 2002:a92:dcc5:0:b0:33c:5182:6cf1 with SMTP id
 b5-20020a92dcc5000000b0033c51826cf1mr3322614ilr.27.1686064744328; 
 Tue, 06 Jun 2023 08:19:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78wvu1JDap0g2re0f2e2qiJX7bBM8shpeRzvVEpOLGwSO7x0EFPA2fN2rICK1Bqi82FPSWTA==
X-Received: by 2002:a92:dcc5:0:b0:33c:5182:6cf1 with SMTP id
 b5-20020a92dcc5000000b0033c51826cf1mr3322605ilr.27.1686064744029; 
 Tue, 06 Jun 2023 08:19:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 l1-20020a922901000000b0033d136f248esm831533ilg.5.2023.06.06.08.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 08:19:03 -0700 (PDT)
Date: Tue, 6 Jun 2023 09:19:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: <ankita@nvidia.com>
Cc: <jgg@nvidia.com>, <qemu-devel@nongnu.org>
Subject: Re: [RFC v1 1/4] qemu: add GPU memory information as object
Message-ID: <20230606091901.22bc6deb.alex.williamson@redhat.com>
In-Reply-To: <20230605235005.20649-2-ankita@nvidia.com>
References: <20230605235005.20649-1-ankita@nvidia.com>
 <20230605235005.20649-2-ankita@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 5 Jun 2023 16:50:02 -0700
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> The GPU memory is exposed as device BAR1 to the VM and is discovered
> by QEMU through the VFIO_DEVICE_GET_REGION_INFO ioctl. QEMU performs
> the mapping to it.
> 
> The GPU memory can be added in the VM as (upto 8) separate NUMA nodes.
> To achieve this, QEMU inserts a series of the PXM domains in the SRAT
> and communicate this range of nodes to the VM through DSD properties.
> 
> These PXM start and count are added as object properties and pushed to
> the SRAT and DST builder code.
> 
> The code is activated only for a set of NVIDIA devices supporting the
> feature.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  hw/vfio/pci-quirks.c        | 13 +++++++
>  hw/vfio/pci.c               | 72 +++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.h               |  1 +
>  include/hw/pci/pci_device.h |  3 ++
>  4 files changed, 89 insertions(+)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index f0147a050a..b7334ccd1d 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1751,3 +1751,16 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
>  
>      return 0;
>  }
> +
> +bool vfio_has_cpu_coherent_devmem(VFIOPCIDevice *vdev)
> +{
> +    switch (vdev->device_id) {
> +    /* Nvidia */
> +    case 0x2342:
> +    case 0x2343:
> +    case 0x2345:
> +        return true;
> +    }
> +
> +    return false;
> +}

I'm not sure why all of this isn't in pci-quirks.c, but the above
function is misleadingly NVIDIA specific by not testing the vendor ID
here.

Also, none of this looks compatible with hotplug, so shouldn't any of
this only be enabled only for the vfio-pci-nohotplug device type?
Thanks,

Alex

> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ec9a854361..403516ffb3 100644
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
> @@ -2824,6 +2826,22 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>      }
>  }
>  
> +static void vfio_pci_get_gpu_mem_pxm_start(Object *obj, Visitor *v,
> +                                           const char *name,
> +                                           void *opaque, Error **errp)
> +{
> +    uint64_t pxm_start = (uintptr_t) opaque;
> +    visit_type_uint64(v, name, &pxm_start, errp);
> +}
> +
> +static void vfio_pci_get_gpu_mem_pxm_count(Object *obj, Visitor *v,
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
> @@ -2843,6 +2861,53 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>      vdev->req_enabled = false;
>  }
>  
> +static int vfio_pci_nvidia_dev_mem_probe(VFIOPCIDevice *vPciDev,
> +                                         Error **errp)
> +{
> +    unsigned int num_nodes;
> +    MemoryRegion *nv2mr = g_malloc0(sizeof(*nv2mr));
> +    Object *obj = NULL;
> +    VFIODevice *vdev = &vPciDev->vbasedev;
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +
> +    if (!vfio_has_cpu_coherent_devmem(vPciDev)) {
> +        return -ENODEV;
> +    }
> +
> +    if (vdev->type == VFIO_DEVICE_TYPE_PCI) {
> +        obj = vfio_pci_get_object(vdev);
> +    }
> +
> +    if (!obj) {
> +        return -EINVAL;
> +    }
> +
> +    /*
> +     * This device has memory that is coherently accessible from the CPU.
> +     * The memory can be represented by upto 8 seperate memory-only
> +     * NUMA nodes.
> +     */
> +    vPciDev->pdev.has_coherent_memory = true;
> +    num_nodes = 8;
> +
> +    /*
> +     * To have 8 unique nodes in the VM, a series of PXM nodes are
> +     * required to be added to VM's SRAT. Send the information about
> +     * the starting PXM ID and the count to the ACPI builder code.
> +     */
> +    object_property_add(OBJECT(vPciDev), "gpu_mem_pxm_start", "uint64",
> +                        vfio_pci_get_gpu_mem_pxm_start, NULL, NULL,
> +                        (void *) (uintptr_t) ms->numa_state->num_nodes);
> +
> +    object_property_add(OBJECT(vPciDev), "gpu_mem_pxm_count", "uint64",
> +                        vfio_pci_get_gpu_mem_pxm_count, NULL, NULL,
> +                        (void *) (uintptr_t) num_nodes);
> +
> +    ms->numa_state->num_nodes += num_nodes;
> +
> +    return 0;
> +}
> +
>  static void vfio_realize(PCIDevice *pdev, Error **errp)
>  {
>      VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> @@ -3151,6 +3216,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          }
>      }
>  
> +    if (vdev->vendor_id == PCI_VENDOR_ID_NVIDIA) {
> +        ret = vfio_pci_nvidia_dev_mem_probe(vdev, errp);
> +        if (ret && ret != -ENODEV) {
> +            error_report("Failed to setup NVIDIA dev_mem with error %d", ret);
> +        }
> +    }
> +
>      vfio_register_err_notifier(vdev);
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 177abcc8fb..d8791f8f1f 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -226,4 +226,5 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
>  int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
>  void vfio_display_finalize(VFIOPCIDevice *vdev);
>  
> +bool vfio_has_cpu_coherent_devmem(VFIOPCIDevice *vdev);
>  #endif /* HW_VFIO_VFIO_PCI_H */
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



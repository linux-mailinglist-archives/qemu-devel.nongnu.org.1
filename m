Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 802FF7E4ABF
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 22:35:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Thd-0006BR-NY; Tue, 07 Nov 2023 16:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1r0Thc-0006BA-AG
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 16:33:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1r0Tha-0005rT-2n
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 16:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699392816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyzdKboo+DhHfYIRs4ZCugTHtWy4Ah/VcPH/1LZVsfA=;
 b=dlg7oXrmeopgDIWt7HvCzrDIeqz1oKIEKfA8TwbHFyU7uhtk3GPicAxdqfDJeTR0HU/TKn
 tiDMBT9T0KDazrYBJZhd5ovPWM3Fp0y19U+ywwnnFBKkS+WLX4vGD6AHUOC2BP6kGdd71e
 LFa86nc+5nHPuwUGiVHMIkanALuQFHE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-F_a1TwDJPoi38wBl-ff30Q-1; Tue, 07 Nov 2023 16:33:35 -0500
X-MC-Unique: F_a1TwDJPoi38wBl-ff30Q-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7a9618a6685so562075439f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 13:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699392814; x=1699997614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyzdKboo+DhHfYIRs4ZCugTHtWy4Ah/VcPH/1LZVsfA=;
 b=SCp+T2yTB0vbu1Weu3rmMAsP4D8PIr6Krosr28kgbtlHijcAUZZJdQ+rGSlkyEmCSH
 o1saiuG6tuPHQCPayzkRm+h2W3fLbCR2cO8ug1t39WKm28LOXN6JpvJf1GPL61Q8zg5u
 vjZojP/KHtelrDMi5byrsHFCfGZwjzY9AHMERIuReveBeJ5Acih/PI3cZIwjqrhMLiXs
 Xw+jewidPr4MCN4dPKpXexGruHRSGasEwev9jle0j5IvfC7faHj5FOhMfH6eSoRrTmSz
 PgA/ajvxKp8O+VHNDTkIjYiW4lPloEHihGsa8zO9wvJOn4oa8atSMaD1RLTImP9sSLv9
 BozQ==
X-Gm-Message-State: AOJu0YyMyNK1Cvez8eQt5DrrNLGR/bwpvCr5SmKea1vWxOnxxwspr0S5
 ce97xMgPY056ORXOxtEMzr9Qn1hflOS5L9GVQxuJ17pSZT6Z9Hg2VAI+8dYJojX8nr/DnDapaP8
 OAGBuxFEv3QW06d4=
X-Received: by 2002:a6b:4e0b:0:b0:7a6:889e:c4b7 with SMTP id
 c11-20020a6b4e0b000000b007a6889ec4b7mr131218iob.11.1699392814262; 
 Tue, 07 Nov 2023 13:33:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqlcaqWXJ3Edu1wZ4l77EeXNpmapd+CZczU7Nlb+SnpjAwfE9l6KUldf5xKlHsJlaGWg+Q0w==
X-Received: by 2002:a6b:4e0b:0:b0:7a6:889e:c4b7 with SMTP id
 c11-20020a6b4e0b000000b007a6889ec4b7mr131184iob.11.1699392813910; 
 Tue, 07 Nov 2023 13:33:33 -0800 (PST)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 q1-20020a6bd201000000b00791e6ae3aa4sm3178628iob.23.2023.11.07.13.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:33:33 -0800 (PST)
Date: Tue, 7 Nov 2023 14:33:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: <ankita@nvidia.com>
Cc: <jgg@nvidia.com>, <clg@redhat.com>, <shannon.zhaosl@gmail.com>,
 <peter.maydell@linaro.org>, <ani@anisinha.ca>, <berrange@redhat.com>,
 <eduardo@habkost.net>, <imammedo@redhat.com>, <mst@redhat.com>,
 <eblake@redhat.com>, <armbru@redhat.com>, <david@redhat.com>,
 <gshan@redhat.com>, <Jonathan.Cameron@huawei.com>, <aniketa@nvidia.com>,
 <cjia@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <vsethi@nvidia.com>, <acurrid@nvidia.com>, <dnigam@nvidia.com>,
 <udhoke@nvidia.com>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 2/2] hw/acpi: Implement the SRAT GI affinity structure
Message-ID: <20231107143332.0c00bbdc.alex.williamson@redhat.com>
In-Reply-To: <20231107190039.19434-3-ankita@nvidia.com>
References: <20231107190039.19434-1-ankita@nvidia.com>
 <20231107190039.19434-3-ankita@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 8 Nov 2023 00:30:39 +0530
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> ACPI spec provides a scheme to associate "Generic Initiators" [1]
> (e.g. heterogeneous processors and accelerators, GPUs, and I/O devices with
> integrated compute or DMA engines GPUs) with Proximity Domains. This is
> achieved using Generic Initiator Affinity Structure in SRAT. During bootup,
> Linux kernel parse the ACPI SRAT to determine the PXM ids and create a NUMA
> node for each unique PXM ID encountered. Qemu currently do not implement
> these structures while building SRAT.
> 
> Add GI structures while building VM ACPI SRAT. The association between
> devices and nodes are stored using acpi-generic-initiator object. Lookup
> presence of all such objects and use them to build these structures.
> 
> The structure needs a PCI device handle [2] that consists of the device BDF.
> The vfio-pci device corresponding to the acpi-generic-initiator object is
> located to determine the BDF.
> 
> [1] ACPI Spec 6.5, Section 5.2.16.6
> [2] ACPI Spec 6.5, Table 5.66
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  hw/acpi/acpi-generic-initiator.c         | 79 ++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c                 |  3 +
>  include/hw/acpi/acpi-generic-initiator.h | 21 +++++++
>  3 files changed, 103 insertions(+)
> 
> diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initiator.c
> index 0699c878e2..6d0a8fd818 100644
> --- a/hw/acpi/acpi-generic-initiator.c
> +++ b/hw/acpi/acpi-generic-initiator.c
> @@ -78,3 +78,82 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
>      object_class_property_add_str(oc, ACPI_GENERIC_INITIATOR_NODELIST_PROP,
>                                    NULL, acpi_generic_initiator_set_nodelist);
>  }
> +
> +static int acpi_generic_initiator_list(Object *obj, void *opaque)
> +{
> +    GSList **list = opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> +        *list = g_slist_append(*list, ACPI_GENERIC_INITIATOR(obj));
> +    }
> +
> +    object_child_foreach(obj, acpi_generic_initiator_list, opaque);
> +    return 0;
> +}
> +
> +/*
> + * Identify Generic Initiator objects and link them into the list which is
> + * returned to the caller.
> + *
> + * Note: it is the caller's responsibility to free the list to avoid
> + * memory leak.
> + */
> +static GSList *acpi_generic_initiator_get_list(void)
> +{
> +    GSList *list = NULL;
> +
> +    object_child_foreach(object_get_root(), acpi_generic_initiator_list, &list);
> +    return list;
> +}
> +
> +/*
> + * ACPI spec, Revision 6.5
> + * 5.2.16.6 Generic Initiator Affinity Structure
> + */
> +static
> +void build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
> +                                               PCIDeviceHandle *handle)
> +{
> +    uint8_t index;
> +
> +    build_append_int_noprefix(table_data, 5, 1);     /* Type */
> +    build_append_int_noprefix(table_data, 32, 1);    /* Length */
> +    build_append_int_noprefix(table_data, 0, 1);     /* Reserved */
> +    build_append_int_noprefix(table_data, 1, 1);     /* Device Handle Type */

/* Device Handle Type: PCI */

> +    build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain */
> +    build_append_int_noprefix(table_data, handle->segment, 2);
> +    build_append_int_noprefix(table_data, handle->bdf, 2);
> +
> +    /* Reserved */
> +    for (index = 0; index < 12; index++) {
> +        build_append_int_noprefix(table_data, handle->res[index], 1);
> +    }
> +
> +    build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* Flags */
> +    build_append_int_noprefix(table_data, 0, 4);     /* Reserved */
> +}
> +
> +void build_srat_generic_pci_initiator(GArray *table_data)
> +{
> +    GSList *gi_list, *list = acpi_generic_initiator_get_list();
> +    for (gi_list = list; gi_list; gi_list = gi_list->next) {
> +        AcpiGenericInitiator *gi = gi_list->data;
> +        Object *o;
> +        uint16List *l;
> +
> +        o = object_resolve_path_type(gi->device, TYPE_VFIO_PCI, NULL);

As per previous comments, this should not be tied to vfio.  This should
be able to describe an association between any PCI device and various
proximity domains, even those beyond this current use case.

It also looks like this support just silently fails if the device
string isn't the right type or isn't found.  That's not good.  Should
the previous patch validate the device where the Error return is more
readily available rather than only doing a strdup there?  Maybe then we
should store the object there rather than a char buffer.

Don't we also still need to enforce that the device is not hotpluggable
since we're tying it to this fixed ACPI object?  That was implicit when
previously testing for the non-hotpluggable vfio-pci device type, but
should rely on something like device_get_hotpluggable() now.

Also the ACPI Generic Initiator supports either a PCI or ACPI device
handle, where we're only adding PCI support here.  What do we want ACPI
device support to look like?  Is it sufficient that device= only
accepts a PCI device now and fails on anything else and would later be
updated to accept an ACPI device or should the object have different
entry points, ex. pci_dev = vs acpi_dev= where it might later be
introspected whether ACPI device support exists?

> +        if (!o) {
> +            continue;
> +        }
> +
> +        for (l = gi->nodelist; l; l = l->next) {
> +            PCIDeviceHandle dev_handle = {0};
> +            PCIDevice *pci_dev = PCI_DEVICE(o);

I'd explicitly set the segment to zero just to make it more apparent
that it would need to be addressed when QEMU adds multi-segment
support.  Thanks,

Alex

> +            dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
> +                                                       pci_dev->devfn);
> +            build_srat_generic_pci_initiator_affinity(table_data,
> +                                                      l->value, &dev_handle);
> +        }
> +    }
> +    g_slist_free(list);
> +}
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6b674231c2..bd53788cef 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -58,6 +58,7 @@
>  #include "migration/vmstate.h"
>  #include "hw/acpi/ghes.h"
>  #include "hw/acpi/viot.h"
> +#include "hw/acpi/acpi-generic-initiator.h"
>  
>  #define ARM_SPI_BASE 32
>  
> @@ -558,6 +559,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          }
>      }
>  
> +    build_srat_generic_pci_initiator(table_data);
> +
>      if (ms->nvdimms_state->is_enabled) {
>          nvdimm_build_srat(table_data);
>      }
> diff --git a/include/hw/acpi/acpi-generic-initiator.h b/include/hw/acpi/acpi-generic-initiator.h
> index bb127b2541..545f46ade5 100644
> --- a/include/hw/acpi/acpi-generic-initiator.h
> +++ b/include/hw/acpi/acpi-generic-initiator.h
> @@ -26,4 +26,25 @@ typedef struct AcpiGenericInitiatorClass {
>          ObjectClass parent_class;
>  } AcpiGenericInitiatorClass;
>  
> +/*
> + * ACPI 6.5: Table 5-68 Flags - Generic Initiator
> + */
> +typedef enum {
> +    GEN_AFFINITY_NOFLAGS = 0,
> +    GEN_AFFINITY_ENABLED = (1 << 0),
> +    GEN_AFFINITY_ARCH_TRANS = (1 << 1),
> +} GenericAffinityFlags;
> +
> +/*
> + * ACPI 6.5: Table 5-66 Device Handle - PCI
> + * Device Handle definition
> + */
> +typedef struct PCIDeviceHandle {
> +    uint16_t segment;
> +    uint16_t bdf;
> +    uint8_t res[12];
> +} PCIDeviceHandle;
> +
> +void build_srat_generic_pci_initiator(GArray *table_data);
> +
>  #endif



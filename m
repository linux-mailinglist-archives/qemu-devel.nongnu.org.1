Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 137E37E4B9F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 23:21:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0UR0-0004rq-SF; Tue, 07 Nov 2023 17:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0UQy-0004rC-U7
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 17:20:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0UQw-00064e-5c
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 17:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699395629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AB+JCiaZyEhDH5omPPRiPG2VigOZB7R/SkpUzk015f8=;
 b=Y0iNV5vZMqClJAScUzo6N3ZoRuCg/q2Bf1afM8iQn/G04/B9nfCFk83O40y1i6rp3m51qq
 zyx9Ayjj3D3hoo83lJVVX1ClN3foXcIJ9Ida3DOn5NeSF8EuW9/7rfQl7v8yfBFq/QN8Ju
 mvOFUa9niuV+BOAbrGfbI4rlHZQq7dc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-LZ0dZz-3MQKc1XO-LIx9mg-1; Tue, 07 Nov 2023 17:20:27 -0500
X-MC-Unique: LZ0dZz-3MQKc1XO-LIx9mg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507bd5f4b2dso6807793e87.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 14:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699395625; x=1700000425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AB+JCiaZyEhDH5omPPRiPG2VigOZB7R/SkpUzk015f8=;
 b=Is5OsxZb/BNnyS44VdRkAZHqXST0TMsaL6NzJ7UuPtLSCudXcnCRK9CuaCfrC2W1jg
 MZ0e2dCzhjF33wK1OohaScY8Rjwt/D7+wi2zDSWxvPlE1HnpAPSjSteF9OofJVZ3MqdR
 V2Ue6PtXhKmMYND08WFw0szZK8yHaL9NoIeFDxincvgxRlzSWF46kAYpFHrvIgTlCBey
 47hZufmBTuOhe5SmU+glFnxvtzc6NqzPP67fQWVxl+jZ7l41C6LxTERgxDG1LKIxaBBS
 bobmd++8PpWLR1e3ed7z4+NlEk4ZBPLBG4BqvlGW2hHokS3zStSCyiq0qD/Mzb/unr6l
 pB7g==
X-Gm-Message-State: AOJu0YwcGK4oZSgQPQUaDvsDYP05+HwnWp6kYprMSY4t2A7Zdi7m8aq6
 JZRFPeZWqlXyfl/o2qrOSz6tvxumWfAvJp8m3k2Erg1hFaqr5d56UPGcb2g78E8g3we9RchMWkB
 OOeeY5AvNdk4uIP4=
X-Received: by 2002:ac2:5488:0:b0:502:ffdf:b098 with SMTP id
 t8-20020ac25488000000b00502ffdfb098mr24429264lfk.6.1699395625387; 
 Tue, 07 Nov 2023 14:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjHxleQuK/xYBJuVZrRx3TforrQARWviEeTie8Gxp2f8ttCUmUy10bbBA5qO8dkExYWymahA==
X-Received: by 2002:ac2:5488:0:b0:502:ffdf:b098 with SMTP id
 t8-20020ac25488000000b00502ffdfb098mr24429235lfk.6.1699395624970; 
 Tue, 07 Nov 2023 14:20:24 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:206a:ec71:ae4a:c04f:d4f2])
 by smtp.gmail.com with ESMTPSA id
 e12-20020adffd0c000000b0032196c508e3sm3407720wrr.53.2023.11.07.14.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 14:20:23 -0800 (PST)
Date: Tue, 7 Nov 2023 17:20:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: ankita@nvidia.com
Cc: jgg@nvidia.com, alex.williamson@redhat.com, clg@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org, ani@anisinha.ca,
 berrange@redhat.com, eduardo@habkost.net, imammedo@redhat.com,
 eblake@redhat.com, armbru@redhat.com, david@redhat.com,
 gshan@redhat.com, Jonathan.Cameron@huawei.com, aniketa@nvidia.com,
 cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 vsethi@nvidia.com, acurrid@nvidia.com, dnigam@nvidia.com,
 udhoke@nvidia.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/2] hw/acpi: Implement the SRAT GI affinity structure
Message-ID: <20231107171202-mutt-send-email-mst@kernel.org>
References: <20231107190039.19434-1-ankita@nvidia.com>
 <20231107190039.19434-3-ankita@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107190039.19434-3-ankita@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 08, 2023 at 12:30:39AM +0530, ankita@nvidia.com wrote:
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

we normally just say ACPI 6.5 even though a couple of places are more
verbose.

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
> +        if (!o) {
> +            continue;
> +        }
> +
> +        for (l = gi->nodelist; l; l = l->next) {
> +            PCIDeviceHandle dev_handle = {0};
> +            PCIDevice *pci_dev = PCI_DEVICE(o);
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

Don't add these one-time use flags. They are impossible to match to
spec without reading and memorizing all of it. The way we do it in ACPI
code is this:

(1 << 0) /* [text matching ACPI spec verbatim ] */

this also means you will not add a ton of dead code just because it is
in the spec.

> +
> +/*
> + * ACPI 6.5: Table 5-66 Device Handle - PCI

In ACPI we document *earliest* spec version that includes this, not just
a random one you looked at. I checked 6.3 and it's there.
Pls find earliest one.

Same applies everywhere


> + * Device Handle definition

Again match spec text exactly. one line, and "definition" is not there.

> + */
> +typedef struct PCIDeviceHandle {
> +    uint16_t segment;
> +    uint16_t bdf;
> +    uint8_t res[12];

what is this "res" and why do you need to pass it? It's always 0 isn't
it?

> +} PCIDeviceHandle;
> +
> +void build_srat_generic_pci_initiator(GArray *table_data);
> +
>  #endif
> -- 
> 2.17.1



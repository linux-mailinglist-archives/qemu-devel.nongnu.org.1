Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D120A7FADD4
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 23:59:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7kYL-0006Cv-MD; Mon, 27 Nov 2023 17:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1r7kYJ-0006CE-7r
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 17:58:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1r7kYF-0004pt-Rf
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 17:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701125883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gTlu0aOGE1bV6w881vRHPnLuuvyOM4DDe/rTu2ULrOk=;
 b=ZrAz8ma3AN1ngXYQ4jlXRtuQDa0aaresemgM6iHMluwLHAoAZ63VE49tIc6xUbhCW9YS81
 CVQygm5SRhqG7OadBCxCvvOLmeOddDp+wqwvoJH+/vH0Kf3Qr0g4+lmJgZDs7yySKY2yyN
 Rvf/zT8wzf21KT9WQlPcqvdsAObiI78=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-LRurrpavNeaiFCdJKov1kA-1; Mon, 27 Nov 2023 17:58:01 -0500
X-MC-Unique: LRurrpavNeaiFCdJKov1kA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6ce0c99f117so5166766a34.2
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 14:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701125881; x=1701730681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTlu0aOGE1bV6w881vRHPnLuuvyOM4DDe/rTu2ULrOk=;
 b=eRk0HX101Zt0SsWcrXOMG6hv2n9wHDc+Bao7eAe3QwcqHhHn0hkQ3rzaNN3h4WBEIV
 SGAtjkk/8+D526x8VCrVTlrvj0EcMgClzifNnYo0ZErTQCVCo1xsoSnVe8ma4+gnFrTu
 WoRMggPaBgP6gx9Se6sTE8UOfu1lATCCESLUXC9IyJZifkj+pZiKyl+QRNvSzhHv/lxl
 +jTJ9rsfiE4YTmCmScaAxE8WtLXBbcNQLElyYQGDLGgLH0nNYW70Zg99fiiRJR02Cd8H
 +ZQMXF0JdRheaKJhSjxP03iRjVbkfrA5kcPVq3oGteoZ10iSokYlnU3Gq8wCnnRV48mv
 6fCg==
X-Gm-Message-State: AOJu0YzjtF9dPJ4bVs+8ijTGuYLgwSey60eD/ulWSwTz2HAtxM+RG9xx
 DQ6JnQ29fGFlmX8/WQqkS0O6T07euFpp9zucselxcP4oDaYVBLjehBUCual4lt3WbMyiFGpn0PJ
 axQBtspHfyL46g9o=
X-Received: by 2002:a05:6830:4390:b0:6d8:1889:72af with SMTP id
 s16-20020a056830439000b006d8188972afmr8056031otv.2.1701125880874; 
 Mon, 27 Nov 2023 14:58:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEki1TVIOB47T8MQW+gtosklEHID9TIXfoZp/bq9mTyoGHLltzIuiDdAiDEdTi8efGLFIHqQQ==
X-Received: by 2002:a05:6830:4390:b0:6d8:1889:72af with SMTP id
 s16-20020a056830439000b006d8188972afmr8055995otv.2.1701125880587; 
 Mon, 27 Nov 2023 14:58:00 -0800 (PST)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 v10-20020a056830140a00b006d834fd3399sm199108otp.59.2023.11.27.14.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 14:58:00 -0800 (PST)
Date: Mon, 27 Nov 2023 15:57:58 -0700
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
Subject: Re: [PATCH v4 2/2] hw/acpi: Implement the SRAT GI affinity structure
Message-ID: <20231127155758.54066105.alex.williamson@redhat.com>
In-Reply-To: <20231119130111.761-3-ankita@nvidia.com>
References: <20231119130111.761-1-ankita@nvidia.com>
 <20231119130111.761-3-ankita@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sun, 19 Nov 2023 18:31:11 +0530
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
>=20
> ACPI spec provides a scheme to associate "Generic Initiators" [1]
> (e.g. heterogeneous processors and accelerators, GPUs, and I/O devices wi=
th
> integrated compute or DMA engines GPUs) with Proximity Domains. This is
> achieved using Generic Initiator Affinity Structure in SRAT. During bootu=
p,
> Linux kernel parse the ACPI SRAT to determine the PXM ids and create a NU=
MA
> node for each unique PXM ID encountered. Qemu currently do not implement
> these structures while building SRAT.
>=20
> Add GI structures while building VM ACPI SRAT. The association between
> devices and nodes are stored using acpi-generic-initiator object. Lookup
> presence of all such objects and use them to build these structures.
>=20
> The structure needs a PCI device handle [2] that consists of the device B=
DF.
> The vfio-pci device corresponding to the acpi-generic-initiator object is
> located to determine the BDF.
>=20
> [1] ACPI Spec 6.3, Section 5.2.16.6
> [2] ACPI Spec 6.3, Table 5.80
>=20
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  hw/acpi/acpi-generic-initiator.c         | 100 +++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c                 |   3 +
>  include/hw/acpi/acpi-generic-initiator.h |  26 ++++++
>  3 files changed, 129 insertions(+)
>=20
> diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-init=
iator.c
> index 5ea51cb81e..a9222438ec 100644
> --- a/hw/acpi/acpi-generic-initiator.c
> +++ b/hw/acpi/acpi-generic-initiator.c
> @@ -16,6 +16,7 @@
>  #include "hw/pci/pci_device.h"
>  #include "sysemu/numa.h"
>  #include "hw/acpi/acpi-generic-initiator.h"
> +#include "qemu/error-report.h"
> =20
>  OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_in=
itiator,
>                     ACPI_GENERIC_INITIATOR, OBJECT,
> @@ -82,3 +83,102 @@ static void acpi_generic_initiator_class_init(ObjectC=
lass *oc, void *data)
>          acpi_generic_initiator_set_host_nodes,
>          NULL, NULL);
>  }
> +
> +static int acpi_generic_initiator_list(Object *obj, void *opaque)
> +{
> +    GSList **list =3D opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> +        *list =3D g_slist_append(*list, ACPI_GENERIC_INITIATOR(obj));
> +    }
> +
> +    object_child_foreach(obj, acpi_generic_initiator_list, opaque);
> +    return 0;
> +}
> +
> +/*
> + * Identify Generic Initiator objects and link them into the list which =
is
> + * returned to the caller.
> + *
> + * Note: it is the caller's responsibility to free the list to avoid
> + * memory leak.
> + */
> +static GSList *acpi_generic_initiator_get_list(void)
> +{
> +    GSList *list =3D NULL;
> +
> +    object_child_foreach(object_get_root(), acpi_generic_initiator_list,=
 &list);
> +    return list;
> +}
> +
> +/*
> + * ACPI 6.3:
> + * Table 5-78 Generic Initiator Affinity Structure
> + */
> +static
> +void build_srat_generic_pci_initiator_affinity(GArray *table_data, int n=
ode,
> +                                               PCIDeviceHandle *handle)
> +{
> +    uint8_t index;
> +
> +    build_append_int_noprefix(table_data, 5, 1);  /* Type */
> +    build_append_int_noprefix(table_data, 32, 1); /* Length */
> +    build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
> +    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type:=
 PCI */
> +    build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain=
 */
> +
> +    /* Device Handle - PCI */
> +    build_append_int_noprefix(table_data, handle->segment, 2);
> +    build_append_int_noprefix(table_data, handle->bdf, 2);
> +    for (index =3D 0; index < 12; index++) {
> +        build_append_int_noprefix(table_data, 0, 1);
> +    }
> +
> +    build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* F=
lags */
> +    build_append_int_noprefix(table_data, 0, 4);     /* Reserved */
> +}
> +
> +void build_srat_generic_pci_initiator(GArray *table_data)
> +{
> +    GSList *gi_list, *list =3D acpi_generic_initiator_get_list();
> +    AcpiGenericInitiator *gi;
> +
> +    for (gi_list =3D list; gi_list; gi_list =3D gi_list->next) {
> +        Object *o;
> +        uint16List *l;
> +        PCIDevice *pci_dev;
> +        bool node_specified =3D false;
> +
> +        gi =3D gi_list->data;
> +
> +        /* User fails to provide a device. */
> +        g_assert(gi->device);
> +
> +        o =3D object_resolve_path_type(gi->device, TYPE_PCI_DEVICE, NULL=
);
> +        if (!o) {
> +            error_printf("Specified device must be a PCI device.\n");
> +            g_assert(o);
> +        }
> +        pci_dev =3D PCI_DEVICE(o);
> +
> +        for (l =3D gi->nodelist; l; l =3D l->next) {
> +            PCIDeviceHandle dev_handle;
> +            dev_handle.segment =3D 0;
> +            dev_handle.bdf =3D PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci=
_dev)),
> +                                                       pci_dev->devfn);
> +            build_srat_generic_pci_initiator_affinity(table_data,
> +                                                      l->value, &dev_han=
dle);
> +            node_specified =3D true;
> +        }
> +
> +        if (!node_specified) {
> +            error_report("Generic Initiator device 0:%x:%x.%x has no ass=
ociated"
> +                         " NUMA node.", pci_bus_num(pci_get_bus(pci_dev)=
),
> +                         PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev->dev=
fn));
> +            error_printf("Specify NUMA node with -nodelist option.\n");

No such option, -nodelist?

> +            g_assert(node_specified);

I won't claim expertise in QEMU error handling, but an assert is a
pretty harsh way to handle failures.  Thanks,

Alex


> +        }
> +    }
> +
> +    g_slist_free(list);
> +}
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 8bc35a483c..00d77327e0 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -58,6 +58,7 @@
>  #include "migration/vmstate.h"
>  #include "hw/acpi/ghes.h"
>  #include "hw/acpi/viot.h"
> +#include "hw/acpi/acpi-generic-initiator.h"
> =20
>  #define ARM_SPI_BASE 32
> =20
> @@ -558,6 +559,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>          }
>      }
> =20
> +    build_srat_generic_pci_initiator(table_data);
> +
>      if (ms->nvdimms_state->is_enabled) {
>          nvdimm_build_srat(table_data);
>      }
> diff --git a/include/hw/acpi/acpi-generic-initiator.h b/include/hw/acpi/a=
cpi-generic-initiator.h
> index db3ed02c80..6fdaf887cd 100644
> --- a/include/hw/acpi/acpi-generic-initiator.h
> +++ b/include/hw/acpi/acpi-generic-initiator.h
> @@ -27,4 +27,30 @@ typedef struct AcpiGenericInitiatorClass {
>          ObjectClass parent_class;
>  } AcpiGenericInitiatorClass;
> =20
> +/*
> + * ACPI 6.3:
> + * Table 5-81 Flags =E2=80=93 Generic Initiator Affinity Structure
> + */
> +typedef enum {
> +    GEN_AFFINITY_ENABLED =3D (1 << 0), /*
> +                                      * If clear, the OSPM ignores the c=
ontents
> +                                      * of the Generic Initiator/Port Af=
finity
> +                                      * Structure. This allows system fi=
rmware
> +                                      * to populate the SRAT with a stat=
ic
> +                                      * number of structures, but only e=
nable
> +                                      * them as necessary.
> +                                      */
> +} GenericAffinityFlags;
> +
> +/*
> + * ACPI 6.3:
> + * Table 5-80 Device Handle - PCI
> + */
> +typedef struct PCIDeviceHandle {
> +    uint16_t segment;
> +    uint16_t bdf;
> +} PCIDeviceHandle;
> +
> +void build_srat_generic_pci_initiator(GArray *table_data);
> +
>  #endif



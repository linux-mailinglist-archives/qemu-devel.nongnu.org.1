Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE907A218C
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:54:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhACe-0002gv-Mx; Fri, 15 Sep 2023 10:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qhABp-0001zJ-7I
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qhABn-0006iG-KS
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTOrmKKo+HGAxRzsz3wN9/dnEzpfC+xf06tTSqq1A80=;
 b=TBIt8JZsUVxr9SlIyB3SUZNlVmhrw8zlr0zHIad+KtMKc+CypGau0kHJrztm5DrCVP24vv
 PaER1O9dHRXe9+9larLHekRf4P+nzz51NYgPQX0hNuxPE4W/HoynyxojJJczmjghpIhHM1
 YRLg3KLtvSyBi0u1ktufgvdIe0eiCj0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-qS6dpzhKMlmO3L10VsBeiw-1; Fri, 15 Sep 2023 10:52:57 -0400
X-MC-Unique: qS6dpzhKMlmO3L10VsBeiw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-52310058f1eso5239797a12.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 07:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694789573; x=1695394373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTOrmKKo+HGAxRzsz3wN9/dnEzpfC+xf06tTSqq1A80=;
 b=QJVmmAwiBISMMlqF+UlDBVVsvWzksQv6BXMn3dCggbxHJ2aIS+Mzn+1HcSkUu5oXLk
 I6WMMb7sj9sT1mzUoajOZ4gPsnHor5i3QUontGN3wFIwEQC5KR9cTlB5R2sCYekJYtE8
 5T6/kq0RPSSJUUMMisImMhf+hp7HVSQ8GKU4139rjPSCdKRCXF2Lw0OeRliX7lGfHX0P
 HSBJ1M2jVQtN7j0RFEXUCJvOND5DWYk0hCXD66RS54mT9A4bf/IZVXxcjWUaZVo/PkxY
 Jv0ZiqaK+Ti3NVyOLe8QoSusUHlU3mFWVx+QBt+PT3hB0Onz7qXxqKfHg0bReqKRpmCQ
 17+Q==
X-Gm-Message-State: AOJu0YzFLcFPRl/ka7eXuX4s6VgSmGsl9vJw4X7shaVnBNlUDfALxWXk
 He2sX/4iqQfNbbgwI+6wLsncQo8hShy8hepqZ363y+w/YpDJhkF/NWfTKgDTV3fTq6e5BWFCnOO
 LI0q37pQXR/J1ClQ=
X-Received: by 2002:aa7:c913:0:b0:525:8124:20fe with SMTP id
 b19-20020aa7c913000000b00525812420femr2611987edt.18.1694789573645; 
 Fri, 15 Sep 2023 07:52:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd7fnAkAhjUB/AnECxpeI/qvVOOHT0zBPP/tjk/JDGec1/QnvQEtANtwzZjbW7JA4lDHhScw==
X-Received: by 2002:aa7:c913:0:b0:525:8124:20fe with SMTP id
 b19-20020aa7c913000000b00525812420femr2611950edt.18.1694789573301; 
 Fri, 15 Sep 2023 07:52:53 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 i23-20020a50fc17000000b005256d4d58a6sm2350910edr.18.2023.09.15.07.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 07:52:52 -0700 (PDT)
Date: Fri, 15 Sep 2023 16:52:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: <ankita@nvidia.com>
Cc: <jgg@nvidia.com>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>, <ani@anisinha.ca>,
 <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, David Hildenbrand
 <david@redhat.com>
Subject: Re: [PATCH v1 3/4] hw/arm/virt-acpi-build: patch guest SRAT for
 NUMA nodes
Message-ID: <20230915165251.688fea5e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230915024559.6565-4-ankita@nvidia.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-4-ankita@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 14 Sep 2023 19:45:58 -0700
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> During bootup, Linux kernel parse the ACPI SRAT to determine the PXM ids.
> This allows for the creation of NUMA nodes for each unique id.
> 
> Insert a series of the unique PXM ids in the VM SRAT ACPI table. The
> range of nodes can be determined from the "dev_mem_pxm_start" and
> "dev_mem_pxm_count" object properties associated with the device. These
> nodes as made MEM_AFFINITY_HOTPLUGGABLE. This allows the kernel to create
> memory-less NUMA nodes on bootup to which a subrange (or entire range) of
> device memory can be added/removed.

QEMU already has 'memory devices'. perhaps this case belongs to the same class
CCing David.

> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  hw/arm/virt-acpi-build.c | 54 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6b674231c2..6d1e3b6b8a 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -46,6 +46,7 @@
>  #include "hw/acpi/hmat.h"
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
> +#include "hw/vfio/pci.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/arm/virt.h"
> @@ -515,6 +516,57 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      acpi_table_end(linker, &table);
>  }
>  
> +static int devmem_device_list(Object *obj, void *opaque)
> +{
> +    GSList **list = opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
> +        *list = g_slist_append(*list, DEVICE(obj));
> +    }
> +
> +    object_child_foreach(obj, devmem_device_list, opaque);
> +    return 0;
> +}
> +
> +static GSList *devmem_get_device_list(void)
> +{
> +    GSList *list = NULL;
> +
> +    object_child_foreach(qdev_get_machine(), devmem_device_list, &list);
> +    return list;
> +}
> +
> +static void build_srat_devmem(GArray *table_data)
> +{
> +    GSList *device_list, *list = devmem_get_device_list();
> +
> +    for (device_list = list; device_list; device_list = device_list->next) {
> +        DeviceState *dev = device_list->data;
> +        Object *obj = OBJECT(dev);
> +        VFIOPCIDevice *pcidev
> +            = ((VFIOPCIDevice *)object_dynamic_cast(OBJECT(obj),
> +               TYPE_VFIO_PCI));
> +
> +        if (pcidev->pdev.has_coherent_memory) {
> +            uint64_t start_node = object_property_get_uint(obj,
> +                                  "dev_mem_pxm_start", &error_abort);
> +            uint64_t node_count = object_property_get_uint(obj,
> +                                  "dev_mem_pxm_count", &error_abort);
> +            uint64_t node_index;
> +
> +            /*
> +             * Add the node_count PXM domains starting from start_node as
> +             * hot pluggable. The VM kernel parse the PXM domains and
> +             * creates NUMA nodes.
> +             */
> +            for (node_index = 0; node_index < node_count; node_index++)
> +                build_srat_memory(table_data, 0, 0, start_node + node_index,
> +                    MEM_AFFINITY_ENABLED | MEM_AFFINITY_HOTPLUGGABLE);
> +        }
> +    }
> +    g_slist_free(list);
> +}
> +
>  /*
>   * ACPI spec, Revision 5.1
>   * 5.2.16 System Resource Affinity Table (SRAT)
> @@ -569,6 +621,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                            MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>      }
>  
> +    build_srat_devmem(table_data);
> +
>      acpi_table_end(linker, &table);
>  }
>  



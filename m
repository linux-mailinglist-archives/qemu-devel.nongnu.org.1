Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D53D97A2215
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAVd-0003mG-KS; Fri, 15 Sep 2023 11:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qhAVV-0003gW-5d
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qhAVT-00030s-4F
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694790798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NrmuwfORkHV088XJeZg8fDdUukeiMUFR5uqXJlDPelc=;
 b=LFkCCX0h8MnNOxy3LAvWF/mG555T9tPzXp68DKGPo1lDJgguTNOzolUmCbpfmlM+9ln9lb
 lxxylDNISd71pXX11EGYUWz1CAk4cGboz9vBBX8faRxesL78P8Yp+f5NxYEqBKQwHjwuId
 1WP1XyrrE9Sz6QozZ108d+texnYuwvM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-qBNZkPJJNIOI1X2uWCrWZw-1; Fri, 15 Sep 2023 11:13:16 -0400
X-MC-Unique: qBNZkPJJNIOI1X2uWCrWZw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5301927ab91so1372636a12.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694790795; x=1695395595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NrmuwfORkHV088XJeZg8fDdUukeiMUFR5uqXJlDPelc=;
 b=NLSacLmek0KSmcd2mbZzOGnVc26+gn9G+UVGkoED9MrXvLtoIy36uFeyk2DZcNmn5Z
 R+zt6lvR9xLuCt2/wu+ceRE6wwmL2GZDK8OBRR1PcKO5c27efFF/pzdYONBUASjsLdSa
 886onbJ6fizdTlMXltf4MXqjPG8R+1WaRqhZhClv6YDH3N4TJSJWApq6nA6k+sconGdA
 YCgIvEUnSbf5VxHwSBDM+qTVqfuV3sE1Uqb9jf/iYiRnlh97uQ90kxEq7B3jXhwqiz5L
 zhihaM/udMdeHpbJx9QJTj6GtRYqLAdd1D8Vu6SUMWlBGyDNg2/uo6NGi6KW4HCSTzYH
 xd2Q==
X-Gm-Message-State: AOJu0YwQhMUvD+YLglpjUGRe7EYdS03gSKvwip9bkzDHe0ALC8JXNoPu
 z81fmG0gOZUtkpdj6rXu9QPVthqeBMUW02vVVUq4EsMQn1iIxGhnDB33VoI1aSWdomcx+PpfGo8
 CbWRC7XSmntzwvvI=
X-Received: by 2002:a05:6402:d61:b0:530:9e59:5795 with SMTP id
 ec33-20020a0564020d6100b005309e595795mr1285265edb.4.1694790795407; 
 Fri, 15 Sep 2023 08:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrG1LCJli3OUzC0RwtPVtkJWBrrD47FDT/9isfLrosF9OBSOzCQ1de03l0poJXJ4QvBtLA5w==
X-Received: by 2002:a05:6402:d61:b0:530:9e59:5795 with SMTP id
 ec33-20020a0564020d6100b005309e595795mr1285235edb.4.1694790795106; 
 Fri, 15 Sep 2023 08:13:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 q18-20020aa7da92000000b0052cdc596652sm2390205eds.23.2023.09.15.08.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 08:13:14 -0700 (PDT)
Date: Fri, 15 Sep 2023 17:13:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: <ankita@nvidia.com>
Cc: <jgg@nvidia.com>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>, <ani@anisinha.ca>,
 <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 4/4] acpi/gpex: patch guest DSDT for dev mem information
Message-ID: <20230915171313.1a6cb98b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230915024559.6565-5-ankita@nvidia.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-5-ankita@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 14 Sep 2023 19:45:59 -0700
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> To add the memory in the guest as NUMA nodes, it needs the PXM node index
> and the total count of nodes associated with the memory. The range of
> proximity domains are communicated to the VM as part of the guest ACPI

> using the nvidia,gpu-mem-pxm-start and nvidia,gpu-mem-pxm-count DSD
above examples should use devices that are (or to be) available in QEMU,
not some out of tree ones.

> properties. These value respectively represent the staring proximity
> domain id and the count. Kernel modules can then fetch this information
> and determine the numa node id using pxm_to_node().
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
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

PCI devices (especially endpoints) are typically enumerated by
bus specific means (i.e not by ACPI).

And whether OSPM will honor the remainder of AML here is very questionable.

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

I'm not a fun of free form UUIDs and above one seems to be the case:
https://uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf

looking at above doc this UUID also requires HID/ACPI ID
to describe data structure definition which this patch is missing.
It's also questionable whether _HID and _ADR are allowed to go together.

PS:
Commit message and comments here should have appropriate pointers
to relevant specs.

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



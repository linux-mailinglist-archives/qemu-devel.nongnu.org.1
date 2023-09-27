Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDBA7B082B
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:27:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWQN-0008VK-8t; Wed, 27 Sep 2023 11:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qlWQH-0008VA-3J
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qlWQF-000398-DB
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695828354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=phVKXWJDSz6DD2mcZ6/RvuiAYWdu06WewvwLnSI+RGs=;
 b=O7tPZo1KtMqaYb4hexS6WBxhCSFe+xTf6F2PvupObd/bcE/b9bwQ9MtV1Ip3+E7c5w2w0H
 bCIvUqUJSxN1kNVc9av057lrgVksImiklxODR7UdyTrc+kVTOAMF0Li1gCksT90N6bfGOv
 Peg7L2nq1CR7xNttK5Sd8nPO5d7E5aI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-OkIn7va2OBeiI5zwD-A5kg-1; Wed, 27 Sep 2023 11:25:52 -0400
X-MC-Unique: OkIn7va2OBeiI5zwD-A5kg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-321726b0238so8301586f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695828351; x=1696433151;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=phVKXWJDSz6DD2mcZ6/RvuiAYWdu06WewvwLnSI+RGs=;
 b=d4txBqkOgIadeXD1UjgrfjEW6qKG8lSw1yrp86kh3gKR1Z0rJ9caEsavDaDfAaipMl
 NT7k6oOr9jn/OMUWqA1c5W6w8Xr+zb9MUhaX+m5pziiellR1W4vfuJCdZ8QsiomOsdUu
 warDSXnaLnYSeP8qW3uTMOKBq87A/b5XiS6RNWRwmnmKjlE9CRSNPqmjEsJ8c/nAtgGb
 OzRV9T5YgzRD+fQUvhNFEruCNhG5K8rwBYEfNQhmPWoVFrYD0OiREHoZVMQKl/+CD9Dn
 rVmQq2lptBCHMia9dCfOQzQywlma7r1iicKa1f6Fx6IeTb+/Xx4E/bqvp2S32mqDhqXE
 NiRw==
X-Gm-Message-State: AOJu0YzejvWnF6e9L5Vm7ixfw9acry6NViomRjCB1HLYgwBspVgxWG7W
 PNI6pGzYgyKWQ+uE4zWLwRkg0qVne3pn2MQhMR20941kT7+2WxakO7cFEA+Ku0OiMsux6i/qm32
 QGR8EA7f4GMHxAiA=
X-Received: by 2002:adf:ef07:0:b0:323:1d6e:bd02 with SMTP id
 e7-20020adfef07000000b003231d6ebd02mr2264966wro.57.1695828351478; 
 Wed, 27 Sep 2023 08:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlgdoJNmQ9gUaNiIsPIErhEBh7OjakjLcC+rsozNjXefr9Xz62PRDBN0CZohgW9wcM2EVNYw==
X-Received: by 2002:adf:ef07:0:b0:323:1d6e:bd02 with SMTP id
 e7-20020adfef07000000b003231d6ebd02mr2264948wro.57.1695828351153; 
 Wed, 27 Sep 2023 08:25:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16e:b9f6:556e:c001:fe18:7e0a])
 by smtp.gmail.com with ESMTPSA id
 bg10-20020a05600c3c8a00b00405323d47fdsm18317248wmb.21.2023.09.27.08.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:25:50 -0700 (PDT)
Date: Wed, 27 Sep 2023 11:25:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/i386: changes towards enabling -Wshadow=local
Message-ID: <20230927112144-mutt-send-email-mst@kernel.org>
References: <20230926055235.9164-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926055235.9164-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 26, 2023 at 11:22:35AM +0530, Ani Sinha wrote:
> Code changes that addresses all compiler complaints coming from enabling
> -Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
> other local variables or parameters. These makes the code confusing and/or adds

These make

> bugs that are difficult to catch.
> 
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Philippe Mathieu-Daude <philmd@linaro.org>
> CC: mst@redhat.com
> Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---


chunks seem unrelated. why not split them up?

>  hw/i386/acpi-microvm.c | 12 ++++++------
>  hw/i386/intel_iommu.c  |  8 ++++----
>  hw/i386/pc.c           |  1 -
>  hw/i386/x86.c          |  2 --
>  4 files changed, 10 insertions(+), 13 deletions(-)
> 
> changelog:
> v2: kept Peter's changes from https://lore.kernel.org/r/20230922160410.138786-1-peterx@redhat.com
> and removed mine.
> 
> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> index a075360d85..6e4f8061eb 100644
> --- a/hw/i386/acpi-microvm.c
> +++ b/hw/i386/acpi-microvm.c
> @@ -78,18 +78,18 @@ static void acpi_dsdt_add_virtio(Aml *scope,
>              hwaddr base = VIRTIO_MMIO_BASE + index * 512;
>              hwaddr size = 512;
>  
> -            Aml *dev = aml_device("VR%02u", (unsigned)index);
> -            aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
> -            aml_append(dev, aml_name_decl("_UID", aml_int(index)));
> -            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> +            Aml *adev = aml_device("VR%02u", (unsigned)index);
> +            aml_append(adev, aml_name_decl("_HID", aml_string("LNRO0005")));
> +            aml_append(adev, aml_name_decl("_UID", aml_int(index)));
> +            aml_append(adev, aml_name_decl("_CCA", aml_int(1)));
>  
>              Aml *crs = aml_resource_template();
>              aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
>              aml_append(crs,
>                         aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
>                                       AML_EXCLUSIVE, &irq, 1));
> -            aml_append(dev, aml_name_decl("_CRS", crs));
> -            aml_append(scope, dev);
> +            aml_append(adev, aml_name_decl("_CRS", crs));
> +            aml_append(scope, adev);
>          }
>      }
>  }

I would prefer to just drop the devicestate dev pointer, use kid->child inside the
macro.

> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c0ce896668..2c832ab68b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3744,7 +3744,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>  /* Unmap the whole range in the notifier's scope. */
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>  {
> -    hwaddr size, remain;
> +    hwaddr total, remain;
>      hwaddr start = n->start;
>      hwaddr end = n->end;
>      IntelIOMMUState *s = as->iommu_state;
> @@ -3765,7 +3765,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>      }
>  
>      assert(start <= end);
> -    size = remain = end - start + 1;
> +    total = remain = end - start + 1;
>  
>      while (remain >= VTD_PAGE_SIZE) {
>          IOMMUTLBEvent event;
> @@ -3793,10 +3793,10 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>      trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
>                               VTD_PCI_SLOT(as->devfn),
>                               VTD_PCI_FUNC(as->devfn),
> -                             n->start, size);
> +                             n->start, total);
>  
>      map.iova = n->start;
> -    map.size = size - 1; /* Inclusive */
> +    map.size = total - 1; /* Inclusive */
>      iova_tree_remove(as->iova_tree, map);
>  }
>


arguably an improvement

  
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3db0743f31..e7a233e886 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1116,7 +1116,6 @@ void pc_memory_init(PCMachineState *pcms,
>  
>      if (machine->device_memory) {
>          uint64_t *val = g_malloc(sizeof(*val));
> -        PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>          uint64_t res_mem_end = machine->device_memory->base;
>  
>          if (!pcmc->broken_reserved_end) {
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index f034df8bf6..b3d054889b 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -365,8 +365,6 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>  
>      cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
>      if (!cpu_slot) {
> -        MachineState *ms = MACHINE(x86ms);
> -
>          x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>          error_setg(errp,
>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"


killing dead code, nice

> -- 
> 2.39.3



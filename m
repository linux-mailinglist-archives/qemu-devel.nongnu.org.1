Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1612772C8F9
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 16:53:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8iu3-0005dA-QP; Mon, 12 Jun 2023 10:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q8iu1-0005cI-Nn
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 10:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q8itq-00055N-Q6
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 10:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686581525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DJZFzt/FbS5ADzADTcZ3bqokzzOImk2x83ZZ9jCPuM=;
 b=SLAiXKE+t9663JqLdPbPvoukeumfUuTkRltayx9SPu3KLFnE1dfFi3VsqOPFE/dy5Qr131
 hIcCeeFjfhVwxDy1t1ZtvtpmAGO8syZnCS9UkWtk2nJBIcZbk6GGdoR8eabAZN1lObjxr3
 YBwN6o3cxlclWd3xOAFZM0iFxeywXzk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-yNmcu-_aMky0biYKSSV_Xg-1; Mon, 12 Jun 2023 10:51:58 -0400
X-MC-Unique: yNmcu-_aMky0biYKSSV_Xg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a355c9028so498791566b.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 07:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686581517; x=1689173517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5DJZFzt/FbS5ADzADTcZ3bqokzzOImk2x83ZZ9jCPuM=;
 b=TPKvCVfqTQdPtSR0R7uh4HKisi6DrJaiQx1/kzdyfq1WLbI8nnNY+DJIWwLeQHSJKH
 8IPbis4ch1usVHGl18AcV2iG/VXVzXd3ku+QY99rXpbPUHfGRhDF3w1nhmWojaZIys7d
 p4uDh1Ou+kexSJ3t/ofFREvLWb5wbxPbuqnuYT/7nf06ny7IrgiM2earATpz3s+H4xRR
 2hruLoFo66hJUHgim58kL+capEjkJXI3lR4a50m1MutnuBnszYA+gplexPTiralru79f
 SITK/wnmPtjpfpKdjnEvFO9OOo22uGINsCUHHFcN5JHK3p+qCDXhnfduGwJqJn4IX8oF
 icSg==
X-Gm-Message-State: AC+VfDxHjNJv3HIum4LEg1I4htabYQ/YxCJDMKXUjnHSbjO/qUkuLp+C
 G30zs4E+upCneIeGMumz2YIktxrQIyNspqA282RiNEMVsYJfAZCRNzzgbJKTNWoA0+MLVN3IIvA
 QgggMKT4e9AWNq+8=
X-Received: by 2002:a17:907:984:b0:974:1c99:7d3 with SMTP id
 bf4-20020a170907098400b009741c9907d3mr8279888ejc.25.1686581517168; 
 Mon, 12 Jun 2023 07:51:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7H4RzJCNARVdEzfYFSU8vqXMAAzsA+IBVLFi7F/nu7gg/Rgx3who8qsNkiKUvicA+67M3U8w==
X-Received: by 2002:a17:907:984:b0:974:1c99:7d3 with SMTP id
 bf4-20020a170907098400b009741c9907d3mr8279877ejc.25.1686581516855; 
 Mon, 12 Jun 2023 07:51:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 f13-20020a170906390d00b009584c5bcbc7sm5275772eje.49.2023.06.12.07.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 07:51:56 -0700 (PDT)
Date: Mon, 12 Jun 2023 16:51:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 15/15] hw/i386/pc_piix: Move i440fx' realize near its
 qdev_new()
Message-ID: <20230612165155.087ba275@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230611103412.12109-16-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-16-shentey@gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, 11 Jun 2023 12:34:12 +0200
Bernhard Beschow <shentey@gmail.com> wrote:

> I440FX realization is currently mixed with PIIX3 creation. Furthermore, it is
> common practice to only set properties between a device's qdev_new() and
> qdev_realize(). Clean up to resolve both issues.
> 
> Since I440FX spawns a PCI bus let's also move the pci_bus initialization there.
> 
> Note that when running `qemu-system-x86_64 -M pc -S` before and after this
> patch, `info mtree` in the QEMU console doesn't show any differences except that
> the ordering is different.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/i386/pc_piix.c | 57 ++++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 22173b122b..23b9725c94 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -126,7 +126,6 @@ static void pc_init1(MachineState *machine,
>      MemoryRegion *rom_memory;
>      ram_addr_t lowmem;
>      uint64_t hole64_size;
> -    Object *i440fx_host;
>  
>      /*
>       * Calculate ram split, for memory below and above 4G.  It's a bit
> @@ -198,17 +197,43 @@ static void pc_init1(MachineState *machine,
>      }
>  
>      if (pcmc->pci_enabled) {
> +        Object *phb;
> +
>          pci_memory = g_new(MemoryRegion, 1);
>          memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
>          rom_memory = pci_memory;
> -        i440fx_host = OBJECT(qdev_new(host_type));
> -        hole64_size = object_property_get_uint(i440fx_host,
> +
> +        phb = OBJECT(qdev_new(host_type));
> +        object_property_add_child(OBJECT(machine), "i440fx", phb);
> +        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
> +                                 OBJECT(ram_memory), &error_fatal);
> +        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
> +                                 OBJECT(pci_memory), &error_fatal);
> +        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
> +                                 OBJECT(system_memory), &error_fatal);
> +        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
> +                                 OBJECT(system_io), &error_fatal);
> +        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
> +                                 x86ms->below_4g_mem_size, &error_fatal);
> +        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
> +                                 x86ms->above_4g_mem_size, &error_fatal);
> +        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
> +                                &error_fatal);
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
> +
> +        pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
> +        pci_bus_map_irqs(pci_bus,
> +                         xen_enabled() ? xen_pci_slot_get_pirq
> +                                       : pc_pci_slot_get_pirq);
> +        pcms->bus = pci_bus;
> +
> +        hole64_size = object_property_get_uint(phb,
>                                                 PCI_HOST_PROP_PCI_HOLE64_SIZE,
>                                                 &error_abort);

before patch memory region links were set after the original
regions were initialized by pc_memory_init(), but after this
patch you 1st set links and only later pc_memory_init().
I doesn't look to me as a safe thing to do.

>      } else {


>          pci_memory = NULL;
>          rom_memory = system_memory;
> -        i440fx_host = NULL;
> +        pci_bus = NULL;
>          hole64_size = 0;

is it possible to turn these into initializers, and get rid of 
'else'  branch?

>      }
>  
> @@ -243,29 +268,6 @@ static void pc_init1(MachineState *machine,
>          PIIX3State *piix3;
>          PCIDevice *pci_dev;
>  
> -        object_property_add_child(OBJECT(machine), "i440fx", i440fx_host);
> -        object_property_set_link(i440fx_host, PCI_HOST_PROP_RAM_MEM,
> -                                 OBJECT(ram_memory), &error_fatal);
> -        object_property_set_link(i440fx_host, PCI_HOST_PROP_PCI_MEM,
> -                                 OBJECT(pci_memory), &error_fatal);
> -        object_property_set_link(i440fx_host, PCI_HOST_PROP_SYSTEM_MEM,
> -                                 OBJECT(system_memory), &error_fatal);
> -        object_property_set_link(i440fx_host, PCI_HOST_PROP_IO_MEM,
> -                                 OBJECT(system_io), &error_fatal);
> -        object_property_set_uint(i440fx_host, PCI_HOST_BELOW_4G_MEM_SIZE,
> -                                 x86ms->below_4g_mem_size, &error_fatal);
> -        object_property_set_uint(i440fx_host, PCI_HOST_ABOVE_4G_MEM_SIZE,
> -                                 x86ms->above_4g_mem_size, &error_fatal);
> -        object_property_set_str(i440fx_host, I440FX_HOST_PROP_PCI_TYPE,
> -                                pci_type, &error_fatal);
> -        sysbus_realize_and_unref(SYS_BUS_DEVICE(i440fx_host), &error_fatal);
> -
> -        pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(i440fx_host), "pci.0"));
> -        pci_bus_map_irqs(pci_bus,
> -                         xen_enabled() ? xen_pci_slot_get_pirq
> -                                       : pc_pci_slot_get_pirq);
> -        pcms->bus = pci_bus;
> -
>          pci_dev = pci_create_simple_multifunction(pci_bus, -1, true,
>                                                    TYPE_PIIX3_DEVICE);
>  
> @@ -290,7 +292,6 @@ static void pc_init1(MachineState *machine,
>          rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
>                                                               "rtc"));
>      } else {
> -        pci_bus = NULL;
>          isa_bus = isa_bus_new(NULL, system_memory, system_io,
>                                &error_abort);
>  



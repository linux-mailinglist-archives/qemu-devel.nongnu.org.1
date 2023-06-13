Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5027072E115
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:15:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90i1-0007A9-Tl; Tue, 13 Jun 2023 05:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q90hz-00079z-HE
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q90ht-0007oQ-TN
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686649975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WP1xCac9DEhlLgUxNdwl5p6sn0F+GuhsVzgzd71Ofkc=;
 b=TPv+azNpUi3KkTluNSxsXbKEEvrC/sycIeJZR2DmQMoKiF6koL8kRfICKVslWcqt4EK41Z
 NthXQjLoWw8goOvJHXEtdKeLX7mkGwOiFdUEZkTTlc7iAak/qcu1p9AzSFEx7udlOHxt2U
 sTjmyvEs8uCy2ukIEoQ0/4gcnOeNOcM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-aEYu0osjMp-jBT7vCO9yXA-1; Tue, 13 Jun 2023 05:52:53 -0400
X-MC-Unique: aEYu0osjMp-jBT7vCO9yXA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9715654ab36so473557366b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649972; x=1689241972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WP1xCac9DEhlLgUxNdwl5p6sn0F+GuhsVzgzd71Ofkc=;
 b=IHW7flbzqsEN73J81lT2PAbe9Dt+sfB9sBUu7/KS30ddEd78YCdWnzlOaU0es6rBHA
 J/Q5vSOcl6sn6nzaOza3zy/S8fqmujuJCP9dKdqFvlTLNqjrP8XuRQ1UKcMC5JrnKjxd
 wxYU6PYJGVF2eDlNjbGlRRLDwmIPQrZNMSXtsB8lEkw7XgnLz6qACyy9HuHIEmatrMXt
 F2IwsKHFSRAdXtBvw0HJ+LQ6lD/nikrWSgblo6CPaMavpZ3DVyD7WxVhq23CfWrEkXtY
 FtI44b6bmIQZrjK0AMRg0wCYNastbLV7PxO7WqPiH8WjZk/DkDOZ9aEmFiArzosSn5Oj
 2a/Q==
X-Gm-Message-State: AC+VfDyz8qthXosKBpq7hY2g4WNX1GZ+k+8F/RaZHpdpH174407vOYSq
 SynVLR70mrkHIePgW9Yu+ZZaZ9/ZDZWgtA4pvDTJea3V1PxpTIwYkcV+nBZBoR8X79Dt3UBg/cu
 M6RExy43WVIXUiDA=
X-Received: by 2002:a17:906:fd84:b0:977:bf09:279 with SMTP id
 xa4-20020a170906fd8400b00977bf090279mr11833045ejb.41.1686649972603; 
 Tue, 13 Jun 2023 02:52:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5M6lxQIM2O9rppJ1E4OL9WLUxbOw8rcveOGYJqDjtCFujwRQCFlD/jDxn78hdCeYPFnCQTMw==
X-Received: by 2002:a17:906:fd84:b0:977:bf09:279 with SMTP id
 xa4-20020a170906fd8400b00977bf090279mr11833033ejb.41.1686649972275; 
 Tue, 13 Jun 2023 02:52:52 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 u2-20020a17090663c200b009662b4230cesm6486933ejk.148.2023.06.13.02.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 02:52:51 -0700 (PDT)
Date: Tue, 13 Jun 2023 11:52:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 15/15] hw/i386/pc_piix: Move i440fx' realize near its
 qdev_new()
Message-ID: <20230613115250.08e03e9b@imammedo.users.ipa.redhat.com>
In-Reply-To: <4F200210-F39C-49CD-B7FD-AF9F556C8493@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-16-shentey@gmail.com>
 <20230612165155.087ba275@imammedo.users.ipa.redhat.com>
 <20230612172119.5b9e6d7e@imammedo.users.ipa.redhat.com>
 <4F200210-F39C-49CD-B7FD-AF9F556C8493@gmail.com>
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

On Mon, 12 Jun 2023 17:49:10 +0000
Bernhard Beschow <shentey@gmail.com> wrote:

> Am 12. Juni 2023 15:21:19 UTC schrieb Igor Mammedov <imammedo@redhat.com>:
> >On Mon, 12 Jun 2023 16:51:55 +0200
> >Igor Mammedov <imammedo@redhat.com> wrote:
> >  
> >> On Sun, 11 Jun 2023 12:34:12 +0200
> >> Bernhard Beschow <shentey@gmail.com> wrote:
> >>   
> >> > I440FX realization is currently mixed with PIIX3 creation. Furthermore, it is
> >> > common practice to only set properties between a device's qdev_new() and
> >> > qdev_realize(). Clean up to resolve both issues.
> >> > 
> >> > Since I440FX spawns a PCI bus let's also move the pci_bus initialization there.
> >> > 
> >> > Note that when running `qemu-system-x86_64 -M pc -S` before and after this
> >> > patch, `info mtree` in the QEMU console doesn't show any differences except that
> >> > the ordering is different.
> >> > 
> >> > Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> >> > ---
> >> >  hw/i386/pc_piix.c | 57 ++++++++++++++++++++++++-----------------------
> >> >  1 file changed, 29 insertions(+), 28 deletions(-)
> >> > 
> >> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> >> > index 22173b122b..23b9725c94 100644
> >> > --- a/hw/i386/pc_piix.c
> >> > +++ b/hw/i386/pc_piix.c
> >> > @@ -126,7 +126,6 @@ static void pc_init1(MachineState *machine,
> >> >      MemoryRegion *rom_memory;
> >> >      ram_addr_t lowmem;
> >> >      uint64_t hole64_size;
> >> > -    Object *i440fx_host;
> >> >  
> >> >      /*
> >> >       * Calculate ram split, for memory below and above 4G.  It's a bit
> >> > @@ -198,17 +197,43 @@ static void pc_init1(MachineState *machine,
> >> >      }
> >> >  
> >> >      if (pcmc->pci_enabled) {
> >> > +        Object *phb;
> >> > +
> >> >          pci_memory = g_new(MemoryRegion, 1);
> >> >          memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
> >> >          rom_memory = pci_memory;
> >> > -        i440fx_host = OBJECT(qdev_new(host_type));
> >> > -        hole64_size = object_property_get_uint(i440fx_host,
> >> > +
> >> > +        phb = OBJECT(qdev_new(host_type));
> >> > +        object_property_add_child(OBJECT(machine), "i440fx", phb);
> >> > +        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
> >> > +                                 OBJECT(ram_memory), &error_fatal);
> >> > +        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
> >> > +                                 OBJECT(pci_memory), &error_fatal);
> >> > +        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
> >> > +                                 OBJECT(system_memory), &error_fatal);
> >> > +        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
> >> > +                                 OBJECT(system_io), &error_fatal);
> >> > +        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
> >> > +                                 x86ms->below_4g_mem_size, &error_fatal);
> >> > +        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
> >> > +                                 x86ms->above_4g_mem_size, &error_fatal);
> >> > +        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
> >> > +                                &error_fatal);
> >> > +        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
> >> > +
> >> > +        pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
> >> > +        pci_bus_map_irqs(pci_bus,
> >> > +                         xen_enabled() ? xen_pci_slot_get_pirq
> >> > +                                       : pc_pci_slot_get_pirq);
> >> > +        pcms->bus = pci_bus;
> >> > +
> >> > +        hole64_size = object_property_get_uint(phb,
> >> >                                                 PCI_HOST_PROP_PCI_HOLE64_SIZE,
> >> >                                                 &error_abort);    
> >> 
> >> before patch memory region links were set after the original
> >> regions were initialized by pc_memory_init(), but after this
> >> patch you 1st set links and only later pc_memory_init().
> >> I doesn't look to me as a safe thing to do.  
> >
> >or maybe it doesn't matter, but still I have hard time
> >convincing myself that it is so.   
> 
> AFAICS both pc_memory_init() and i440fx_pcihost_realize() rely on memory_region_init*() having been called on these pointers already. All they seem to do is adding their sub regions. The order in which this happens seems to be irrelevant, otherwise we'd see changes in the QOM console calls I guess.

that's why I said it might not matter, but  ...
the thing is that now mapping into AS happens in reversed order
and with overlapped mappings reversed I'm quite unsure if
that is correct. 

> 
> >  
> >>   
> >> >      } else {    
> >> 
> >>   
> >> >          pci_memory = NULL;
> >> >          rom_memory = system_memory;
> >> > -        i440fx_host = NULL;
> >> > +        pci_bus = NULL;
> >> >          hole64_size = 0;    
> >> 
> >> is it possible to turn these into initializers, and get rid of 
> >> 'else'  branch?  
> 
> Sure, this is possible. I'd add another patch before this one.
> 
> Best regards,
> Bernhard
> >>   
> >> >      }
> >> >  
> >> > @@ -243,29 +268,6 @@ static void pc_init1(MachineState *machine,
> >> >          PIIX3State *piix3;
> >> >          PCIDevice *pci_dev;
> >> >  
> >> > -        object_property_add_child(OBJECT(machine), "i440fx", i440fx_host);
> >> > -        object_property_set_link(i440fx_host, PCI_HOST_PROP_RAM_MEM,
> >> > -                                 OBJECT(ram_memory), &error_fatal);
> >> > -        object_property_set_link(i440fx_host, PCI_HOST_PROP_PCI_MEM,
> >> > -                                 OBJECT(pci_memory), &error_fatal);
> >> > -        object_property_set_link(i440fx_host, PCI_HOST_PROP_SYSTEM_MEM,
> >> > -                                 OBJECT(system_memory), &error_fatal);
> >> > -        object_property_set_link(i440fx_host, PCI_HOST_PROP_IO_MEM,
> >> > -                                 OBJECT(system_io), &error_fatal);
> >> > -        object_property_set_uint(i440fx_host, PCI_HOST_BELOW_4G_MEM_SIZE,
> >> > -                                 x86ms->below_4g_mem_size, &error_fatal);
> >> > -        object_property_set_uint(i440fx_host, PCI_HOST_ABOVE_4G_MEM_SIZE,
> >> > -                                 x86ms->above_4g_mem_size, &error_fatal);
> >> > -        object_property_set_str(i440fx_host, I440FX_HOST_PROP_PCI_TYPE,
> >> > -                                pci_type, &error_fatal);
> >> > -        sysbus_realize_and_unref(SYS_BUS_DEVICE(i440fx_host), &error_fatal);
> >> > -
> >> > -        pci_bus = PCI_BUS(qdev_get_child_bus(DEVICE(i440fx_host), "pci.0"));
> >> > -        pci_bus_map_irqs(pci_bus,
> >> > -                         xen_enabled() ? xen_pci_slot_get_pirq
> >> > -                                       : pc_pci_slot_get_pirq);
> >> > -        pcms->bus = pci_bus;
> >> > -
> >> >          pci_dev = pci_create_simple_multifunction(pci_bus, -1, true,
> >> >                                                    TYPE_PIIX3_DEVICE);
> >> >  
> >> > @@ -290,7 +292,6 @@ static void pc_init1(MachineState *machine,
> >> >          rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
> >> >                                                               "rtc"));
> >> >      } else {
> >> > -        pci_bus = NULL;
> >> >          isa_bus = isa_bus_new(NULL, system_memory, system_io,
> >> >                                &error_abort);
> >> >      
> >>   
> >  
> 



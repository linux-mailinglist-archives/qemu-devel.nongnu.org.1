Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B26F72CF51
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 21:26:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8nAO-00009Q-12; Mon, 12 Jun 2023 15:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8nAL-00006o-Rp
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:25:25 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8nAJ-0004HN-UE
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:25:25 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-977d0ee1736so675951166b.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686597921; x=1689189921;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQGdZN6jI3DI7itlh6AY+L0yx3TyJXhKv8QEiC6mHRg=;
 b=FyAFZasaz6Lk2PdGzcPbPCRanIKIOVzm4QhAdh2EC4In/iVnrtyj4Hk4iZOhz+pEpY
 TvCghekHlfAHjJA4MQLbfSqUPxKNFsl8biHagxIERBRdyaOPh+TE68sWJfvnBknX6Ke8
 G1id89plOUJfQLo0nRv3LQKjKULUNy6mQxFypSeeGGqOylo4R/2FExB0CRzrAxpDcWKK
 P+uOPtk+lb9j5PpHAr1uE7eCwTzg5S2FdRvInGu+CF/WmC0dUPD2j3JZo2hvXnIuh5/h
 LTkkytZCWiSFHD/H1eBnYGgBWFh2M8RWuf6Xsg/vr4Ie0RwUExBB4XQB8qZw/xXahb7W
 r73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686597921; x=1689189921;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQGdZN6jI3DI7itlh6AY+L0yx3TyJXhKv8QEiC6mHRg=;
 b=RZCobzFpXMDq1ekslT8StpJ+HLUo44iN3gJ3qNLBvstJRHeGmfAX9bygz3EREphbsm
 o/FRZnHIDiGzTlVd0z8UkI8FkFKX04bKbD7qqJHkeKJrlVF06lFbQZhKxGinsynmqajb
 8pi75dsG+BGfWdHb3x5D23CjtryocfZspNfbAgdTib3+yHsr4pYEHMyDi78NFwlpkIZp
 8qat52vgqEnB06YedmqKUR/7jiKuPcQqrYljIkQ6gc5MGvmZ8U1Hhwg806C3ef7S94A2
 9Rqpc5mSnCfMWe2MvtDR5BwT1HbCxVit7wFtB4oUyPtsdPqkklzfcpSIqL6o8KJUc9Mf
 S2pA==
X-Gm-Message-State: AC+VfDyrwumsv0zgi6teYqGFQuAa9IpqQqK2SDvjoG0g2IiSfcsyKfQ6
 FdEUlnl3+dzXjLivv3uC2OU=
X-Google-Smtp-Source: ACHHUZ40PB7Pa9idj7KIlsaiLstlnjVxLSu7OSK0ZIiUWAjmRXJvkQqHK+CeYOGs0La9IKD04XkTuA==
X-Received: by 2002:a17:906:fd84:b0:977:bf09:279 with SMTP id
 xa4-20020a170906fd8400b00977bf090279mr10158159ejb.41.1686597921374; 
 Mon, 12 Jun 2023 12:25:21 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-123-197.77.13.pool.telefonica.de.
 [77.13.123.197]) by smtp.gmail.com with ESMTPSA id
 h26-20020a170906829a00b00965c529f103sm5512101ejx.86.2023.06.12.12.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 12:25:21 -0700 (PDT)
Date: Mon, 12 Jun 2023 17:49:10 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_15/15=5D_hw/i386/pc=5Fpiix=3A_Mo?=
 =?US-ASCII?Q?ve_i440fx=27_realize_near_its_qdev=5Fnew=28=29?=
In-Reply-To: <20230612172119.5b9e6d7e@imammedo.users.ipa.redhat.com>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-16-shentey@gmail.com>
 <20230612165155.087ba275@imammedo.users.ipa.redhat.com>
 <20230612172119.5b9e6d7e@imammedo.users.ipa.redhat.com>
Message-ID: <4F200210-F39C-49CD-B7FD-AF9F556C8493@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 12=2E Juni 2023 15:21:19 UTC schrieb Igor Mammedov <imammedo@redhat=2Ec=
om>:
>On Mon, 12 Jun 2023 16:51:55 +0200
>Igor Mammedov <imammedo@redhat=2Ecom> wrote:
>
>> On Sun, 11 Jun 2023 12:34:12 +0200
>> Bernhard Beschow <shentey@gmail=2Ecom> wrote:
>>=20
>> > I440FX realization is currently mixed with PIIX3 creation=2E Furtherm=
ore, it is
>> > common practice to only set properties between a device's qdev_new() =
and
>> > qdev_realize()=2E Clean up to resolve both issues=2E
>> >=20
>> > Since I440FX spawns a PCI bus let's also move the pci_bus initializat=
ion there=2E
>> >=20
>> > Note that when running `qemu-system-x86_64 -M pc -S` before and after=
 this
>> > patch, `info mtree` in the QEMU console doesn't show any differences =
except that
>> > the ordering is different=2E
>> >=20
>> > Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> > ---
>> >  hw/i386/pc_piix=2Ec | 57 ++++++++++++++++++++++++-------------------=
----
>> >  1 file changed, 29 insertions(+), 28 deletions(-)
>> >=20
>> > diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>> > index 22173b122b=2E=2E23b9725c94 100644
>> > --- a/hw/i386/pc_piix=2Ec
>> > +++ b/hw/i386/pc_piix=2Ec
>> > @@ -126,7 +126,6 @@ static void pc_init1(MachineState *machine,
>> >      MemoryRegion *rom_memory;
>> >      ram_addr_t lowmem;
>> >      uint64_t hole64_size;
>> > -    Object *i440fx_host;
>> > =20
>> >      /*
>> >       * Calculate ram split, for memory below and above 4G=2E  It's a=
 bit
>> > @@ -198,17 +197,43 @@ static void pc_init1(MachineState *machine,
>> >      }
>> > =20
>> >      if (pcmc->pci_enabled) {
>> > +        Object *phb;
>> > +
>> >          pci_memory =3D g_new(MemoryRegion, 1);
>> >          memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
>> >          rom_memory =3D pci_memory;
>> > -        i440fx_host =3D OBJECT(qdev_new(host_type));
>> > -        hole64_size =3D object_property_get_uint(i440fx_host,
>> > +
>> > +        phb =3D OBJECT(qdev_new(host_type));
>> > +        object_property_add_child(OBJECT(machine), "i440fx", phb);
>> > +        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
>> > +                                 OBJECT(ram_memory), &error_fatal);
>> > +        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
>> > +                                 OBJECT(pci_memory), &error_fatal);
>> > +        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
>> > +                                 OBJECT(system_memory), &error_fatal=
);
>> > +        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
>> > +                                 OBJECT(system_io), &error_fatal);
>> > +        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
>> > +                                 x86ms->below_4g_mem_size, &error_fa=
tal);
>> > +        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
>> > +                                 x86ms->above_4g_mem_size, &error_fa=
tal);
>> > +        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_=
type,
>> > +                                &error_fatal);
>> > +        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
>> > +
>> > +        pci_bus =3D PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci=2E0=
"));
>> > +        pci_bus_map_irqs(pci_bus,
>> > +                         xen_enabled() ? xen_pci_slot_get_pirq
>> > +                                       : pc_pci_slot_get_pirq);
>> > +        pcms->bus =3D pci_bus;
>> > +
>> > +        hole64_size =3D object_property_get_uint(phb,
>> >                                                 PCI_HOST_PROP_PCI_HOL=
E64_SIZE,
>> >                                                 &error_abort); =20
>>=20
>> before patch memory region links were set after the original
>> regions were initialized by pc_memory_init(), but after this
>> patch you 1st set links and only later pc_memory_init()=2E
>> I doesn't look to me as a safe thing to do=2E
>
>or maybe it doesn't matter, but still I have hard time
>convincing myself that it is so=2E=20

AFAICS both pc_memory_init() and i440fx_pcihost_realize() rely on memory_r=
egion_init*() having been called on these pointers already=2E All they seem=
 to do is adding their sub regions=2E The order in which this happens seems=
 to be irrelevant, otherwise we'd see changes in the QOM console calls I gu=
ess=2E

>
>>=20
>> >      } else { =20
>>=20
>>=20
>> >          pci_memory =3D NULL;
>> >          rom_memory =3D system_memory;
>> > -        i440fx_host =3D NULL;
>> > +        pci_bus =3D NULL;
>> >          hole64_size =3D 0; =20
>>=20
>> is it possible to turn these into initializers, and get rid of=20
>> 'else'  branch?

Sure, this is possible=2E I'd add another patch before this one=2E

Best regards,
Bernhard
>>=20
>> >      }
>> > =20
>> > @@ -243,29 +268,6 @@ static void pc_init1(MachineState *machine,
>> >          PIIX3State *piix3;
>> >          PCIDevice *pci_dev;
>> > =20
>> > -        object_property_add_child(OBJECT(machine), "i440fx", i440fx_=
host);
>> > -        object_property_set_link(i440fx_host, PCI_HOST_PROP_RAM_MEM,
>> > -                                 OBJECT(ram_memory), &error_fatal);
>> > -        object_property_set_link(i440fx_host, PCI_HOST_PROP_PCI_MEM,
>> > -                                 OBJECT(pci_memory), &error_fatal);
>> > -        object_property_set_link(i440fx_host, PCI_HOST_PROP_SYSTEM_M=
EM,
>> > -                                 OBJECT(system_memory), &error_fatal=
);
>> > -        object_property_set_link(i440fx_host, PCI_HOST_PROP_IO_MEM,
>> > -                                 OBJECT(system_io), &error_fatal);
>> > -        object_property_set_uint(i440fx_host, PCI_HOST_BELOW_4G_MEM_=
SIZE,
>> > -                                 x86ms->below_4g_mem_size, &error_fa=
tal);
>> > -        object_property_set_uint(i440fx_host, PCI_HOST_ABOVE_4G_MEM_=
SIZE,
>> > -                                 x86ms->above_4g_mem_size, &error_fa=
tal);
>> > -        object_property_set_str(i440fx_host, I440FX_HOST_PROP_PCI_TY=
PE,
>> > -                                pci_type, &error_fatal);
>> > -        sysbus_realize_and_unref(SYS_BUS_DEVICE(i440fx_host), &error=
_fatal);
>> > -
>> > -        pci_bus =3D PCI_BUS(qdev_get_child_bus(DEVICE(i440fx_host), =
"pci=2E0"));
>> > -        pci_bus_map_irqs(pci_bus,
>> > -                         xen_enabled() ? xen_pci_slot_get_pirq
>> > -                                       : pc_pci_slot_get_pirq);
>> > -        pcms->bus =3D pci_bus;
>> > -
>> >          pci_dev =3D pci_create_simple_multifunction(pci_bus, -1, tru=
e,
>> >                                                    TYPE_PIIX3_DEVICE)=
;
>> > =20
>> > @@ -290,7 +292,6 @@ static void pc_init1(MachineState *machine,
>> >          rtc_state =3D ISA_DEVICE(object_resolve_path_component(OBJEC=
T(pci_dev),
>> >                                                               "rtc"))=
;
>> >      } else {
>> > -        pci_bus =3D NULL;
>> >          isa_bus =3D isa_bus_new(NULL, system_memory, system_io,
>> >                                &error_abort);
>> >   =20
>>=20
>


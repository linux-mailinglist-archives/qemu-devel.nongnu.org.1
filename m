Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5948073D803
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDg3B-0006CQ-Eb; Mon, 26 Jun 2023 02:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qDg39-0006By-6P
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 02:50:11 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qDg37-0004hz-4l
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 02:50:10 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-98e39784a85so197797066b.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687762207; x=1690354207;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3kPqGOLOlPXUgswAx72tUX/dQ7UDQYLySrxPAMlH95Y=;
 b=iiFaNQy5ITqFJ3ZE5tUb56HTkzW3uhC/Ou4C2ejMmoAS88oyYDxKSyB7j5fNDw+SDE
 xu2mJAyl0mwemXsmD/LA6k2q98A08tOP+YyN5djQ5qa4yrAoNlAp3YNbPaWE0v3iMkIs
 GlQr940Vciy4E7hEtDVKmbjE/lZxcEtJrk696bLWSv0PlFiYE7uT9KyLaEiDxSzGoYCO
 8QNJi5/34lTEZsPg2/Ge8hrZAR7xtRKy2rOpBtOuNE160beKhhZ+ZdHugqHoNVYl5obg
 ocQI82AiltmBQp9RNmSBEO8GodN2tYF9rH7BichVrmOEbVkv5lfU2ZFRF2QsSblURe3o
 udZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687762207; x=1690354207;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3kPqGOLOlPXUgswAx72tUX/dQ7UDQYLySrxPAMlH95Y=;
 b=ViqTW8ErQCoRjD7FZXYNoZh+HMw68fBq6TeDUAT0sRVHS6MBpvuwbzKdfvJs6gp2At
 E7zWRkF4HSPXe4nYJo3EzXIjv5StH0vDkXnfxs0PgirirEafNGrgBqe7QXaZ6Ae237+Y
 sr11EpyQ1K55C4ahvRvhY3hWeYaXcFKnuWJEu1iHF0evT/U9BNGgznbDG7qc+/DlunAb
 ckb8fQ1JdEdjW2OOsWGKi6vgp9/kw+srsR5/7hmTCHZJtooKyvckVOo6wAdJX1srqlhw
 usbNOF2Xe4VZsKzGVvG662TNihU5EJUR2CH1UOYfBeQjXNzitKOmYajv/7G8xWujOZgA
 Q/mQ==
X-Gm-Message-State: AC+VfDxZfbccLmIotQsO0Ym5pCO5F19z2Op03PF8tMDqHE7RTQW8yZqH
 wfrO8KDswky0apPAoW+3OzLj6Te8KxM=
X-Google-Smtp-Source: ACHHUZ4XGG80qetg8j+7WJlR+7d7vPnWa5W+YR6rhMeFQSlxsF3oHjdPN5+CuXy/GDKT6DeQunwD9w==
X-Received: by 2002:a17:907:944c:b0:953:834d:899b with SMTP id
 dl12-20020a170907944c00b00953834d899bmr31123183ejc.29.1687762206631; 
 Sun, 25 Jun 2023 23:50:06 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-176-230.77.191.pool.telefonica.de.
 [77.191.176.230]) by smtp.gmail.com with ESMTPSA id
 rn19-20020a170906d93300b0098822e05eddsm2850374ejb.100.2023.06.25.23.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jun 2023 23:50:06 -0700 (PDT)
Date: Mon, 26 Jun 2023 06:50:02 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_15/15=5D_hw/i386/pc=5Fpiix=3A_Mo?=
 =?US-ASCII?Q?ve_i440fx=27_realize_near_its_qdev=5Fnew=28=29?=
In-Reply-To: <20230613115250.08e03e9b@imammedo.users.ipa.redhat.com>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-16-shentey@gmail.com>
 <20230612165155.087ba275@imammedo.users.ipa.redhat.com>
 <20230612172119.5b9e6d7e@imammedo.users.ipa.redhat.com>
 <4F200210-F39C-49CD-B7FD-AF9F556C8493@gmail.com>
 <20230613115250.08e03e9b@imammedo.users.ipa.redhat.com>
Message-ID: <89C3A050-4FA6-45B0-96B3-9040A7476DC1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
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



Am 13=2E Juni 2023 09:52:50 UTC schrieb Igor Mammedov <imammedo@redhat=2Ec=
om>:
>On Mon, 12 Jun 2023 17:49:10 +0000
>Bernhard Beschow <shentey@gmail=2Ecom> wrote:
>
>> Am 12=2E Juni 2023 15:21:19 UTC schrieb Igor Mammedov <imammedo@redhat=
=2Ecom>:
>> >On Mon, 12 Jun 2023 16:51:55 +0200
>> >Igor Mammedov <imammedo@redhat=2Ecom> wrote:
>> > =20
>> >> On Sun, 11 Jun 2023 12:34:12 +0200
>> >> Bernhard Beschow <shentey@gmail=2Ecom> wrote:
>> >>  =20
>> >> > I440FX realization is currently mixed with PIIX3 creation=2E Furth=
ermore, it is
>> >> > common practice to only set properties between a device's qdev_new=
() and
>> >> > qdev_realize()=2E Clean up to resolve both issues=2E
>> >> >=20
>> >> > Since I440FX spawns a PCI bus let's also move the pci_bus initiali=
zation there=2E
>> >> >=20
>> >> > Note that when running `qemu-system-x86_64 -M pc -S` before and af=
ter this
>> >> > patch, `info mtree` in the QEMU console doesn't show any differenc=
es except that
>> >> > the ordering is different=2E
>> >> >=20
>> >> > Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> >> > ---
>> >> >  hw/i386/pc_piix=2Ec | 57 ++++++++++++++++++++++++----------------=
-------
>> >> >  1 file changed, 29 insertions(+), 28 deletions(-)
>> >> >=20
>> >> > diff --git a/hw/i386/pc_piix=2Ec b/hw/i386/pc_piix=2Ec
>> >> > index 22173b122b=2E=2E23b9725c94 100644
>> >> > --- a/hw/i386/pc_piix=2Ec
>> >> > +++ b/hw/i386/pc_piix=2Ec
>> >> > @@ -126,7 +126,6 @@ static void pc_init1(MachineState *machine,
>> >> >      MemoryRegion *rom_memory;
>> >> >      ram_addr_t lowmem;
>> >> >      uint64_t hole64_size;
>> >> > -    Object *i440fx_host;
>> >> > =20
>> >> >      /*
>> >> >       * Calculate ram split, for memory below and above 4G=2E  It'=
s a bit
>> >> > @@ -198,17 +197,43 @@ static void pc_init1(MachineState *machine,
>> >> >      }
>> >> > =20
>> >> >      if (pcmc->pci_enabled) {
>> >> > +        Object *phb;
>> >> > +
>> >> >          pci_memory =3D g_new(MemoryRegion, 1);
>> >> >          memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
>> >> >          rom_memory =3D pci_memory;
>> >> > -        i440fx_host =3D OBJECT(qdev_new(host_type));
>> >> > -        hole64_size =3D object_property_get_uint(i440fx_host,
>> >> > +
>> >> > +        phb =3D OBJECT(qdev_new(host_type));
>> >> > +        object_property_add_child(OBJECT(machine), "i440fx", phb)=
;
>> >> > +        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
>> >> > +                                 OBJECT(ram_memory), &error_fatal=
);
>> >> > +        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
>> >> > +                                 OBJECT(pci_memory), &error_fatal=
);
>> >> > +        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
>> >> > +                                 OBJECT(system_memory), &error_fa=
tal);
>> >> > +        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
>> >> > +                                 OBJECT(system_io), &error_fatal)=
;
>> >> > +        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
>> >> > +                                 x86ms->below_4g_mem_size, &error=
_fatal);
>> >> > +        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
>> >> > +                                 x86ms->above_4g_mem_size, &error=
_fatal);
>> >> > +        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, p=
ci_type,
>> >> > +                                &error_fatal);
>> >> > +        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fata=
l);
>> >> > +
>> >> > +        pci_bus =3D PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci=
=2E0"));
>> >> > +        pci_bus_map_irqs(pci_bus,
>> >> > +                         xen_enabled() ? xen_pci_slot_get_pirq
>> >> > +                                       : pc_pci_slot_get_pirq);
>> >> > +        pcms->bus =3D pci_bus;
>> >> > +
>> >> > +        hole64_size =3D object_property_get_uint(phb,
>> >> >                                                 PCI_HOST_PROP_PCI_=
HOLE64_SIZE,
>> >> >                                                 &error_abort);   =
=20
>> >>=20
>> >> before patch memory region links were set after the original
>> >> regions were initialized by pc_memory_init(), but after this
>> >> patch you 1st set links and only later pc_memory_init()=2E
>> >> I doesn't look to me as a safe thing to do=2E =20
>> >
>> >or maybe it doesn't matter, but still I have hard time
>> >convincing myself that it is so=2E  =20
>>=20
>> AFAICS both pc_memory_init() and i440fx_pcihost_realize() rely on memor=
y_region_init*() having been called on these pointers already=2E All they s=
eem to do is adding their sub regions=2E The order in which this happens se=
ems to be irrelevant, otherwise we'd see changes in the QOM console calls I=
 guess=2E
>
>that's why I said it might not matter, but  =2E=2E=2E
>the thing is that now mapping into AS happens in reversed order
>and with overlapped mappings reversed I'm quite unsure if
>that is correct=2E

Hi Igor,

sorry for the late answer=2E I think I have missed your reply so far due t=
o KVM forum ;)

The order in which the overlapped mappings are added shouldn't matter as l=
ong as different priorities are supplied=2E AFAIR adding overlapping region=
s with the same priority would be a programming mistake (in existing code)=
=2E To rule this out I compared the memory mappings before and after the pa=
tch and put the result in the commit message=2E It was the same for `info m=
tree -f`: no difference except the order of the printout=2E

I might be able to send an updated version of this series later today=2E I=
f you'd have further comments after it is out we can continue discussing th=
ere=2E

Best regards,
Bernhard

>
>>=20
>> > =20
>> >>  =20
>> >> >      } else {   =20
>> >>=20
>> >>  =20
>> >> >          pci_memory =3D NULL;
>> >> >          rom_memory =3D system_memory;
>> >> > -        i440fx_host =3D NULL;
>> >> > +        pci_bus =3D NULL;
>> >> >          hole64_size =3D 0;   =20
>> >>=20
>> >> is it possible to turn these into initializers, and get rid of=20
>> >> 'else'  branch? =20
>>=20
>> Sure, this is possible=2E I'd add another patch before this one=2E
>>=20
>> Best regards,
>> Bernhard
>> >>  =20
>> >> >      }
>> >> > =20
>> >> > @@ -243,29 +268,6 @@ static void pc_init1(MachineState *machine,
>> >> >          PIIX3State *piix3;
>> >> >          PCIDevice *pci_dev;
>> >> > =20
>> >> > -        object_property_add_child(OBJECT(machine), "i440fx", i440=
fx_host);
>> >> > -        object_property_set_link(i440fx_host, PCI_HOST_PROP_RAM_M=
EM,
>> >> > -                                 OBJECT(ram_memory), &error_fatal=
);
>> >> > -        object_property_set_link(i440fx_host, PCI_HOST_PROP_PCI_M=
EM,
>> >> > -                                 OBJECT(pci_memory), &error_fatal=
);
>> >> > -        object_property_set_link(i440fx_host, PCI_HOST_PROP_SYSTE=
M_MEM,
>> >> > -                                 OBJECT(system_memory), &error_fa=
tal);
>> >> > -        object_property_set_link(i440fx_host, PCI_HOST_PROP_IO_ME=
M,
>> >> > -                                 OBJECT(system_io), &error_fatal)=
;
>> >> > -        object_property_set_uint(i440fx_host, PCI_HOST_BELOW_4G_M=
EM_SIZE,
>> >> > -                                 x86ms->below_4g_mem_size, &error=
_fatal);
>> >> > -        object_property_set_uint(i440fx_host, PCI_HOST_ABOVE_4G_M=
EM_SIZE,
>> >> > -                                 x86ms->above_4g_mem_size, &error=
_fatal);
>> >> > -        object_property_set_str(i440fx_host, I440FX_HOST_PROP_PCI=
_TYPE,
>> >> > -                                pci_type, &error_fatal);
>> >> > -        sysbus_realize_and_unref(SYS_BUS_DEVICE(i440fx_host), &er=
ror_fatal);
>> >> > -
>> >> > -        pci_bus =3D PCI_BUS(qdev_get_child_bus(DEVICE(i440fx_host=
), "pci=2E0"));
>> >> > -        pci_bus_map_irqs(pci_bus,
>> >> > -                         xen_enabled() ? xen_pci_slot_get_pirq
>> >> > -                                       : pc_pci_slot_get_pirq);
>> >> > -        pcms->bus =3D pci_bus;
>> >> > -
>> >> >          pci_dev =3D pci_create_simple_multifunction(pci_bus, -1, =
true,
>> >> >                                                    TYPE_PIIX3_DEVI=
CE);
>> >> > =20
>> >> > @@ -290,7 +292,6 @@ static void pc_init1(MachineState *machine,
>> >> >          rtc_state =3D ISA_DEVICE(object_resolve_path_component(OB=
JECT(pci_dev),
>> >> >                                                               "rtc=
"));
>> >> >      } else {
>> >> > -        pci_bus =3D NULL;
>> >> >          isa_bus =3D isa_bus_new(NULL, system_memory, system_io,
>> >> >                                &error_abort);
>> >> >     =20
>> >>  =20
>> > =20
>>=20
>


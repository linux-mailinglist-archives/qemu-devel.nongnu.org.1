Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFCB7AC730
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Sep 2023 10:54:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkKs8-0003CD-Mv; Sun, 24 Sep 2023 04:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkKs6-0003Bj-En
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 04:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkKs4-0005hU-AJ
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 04:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695545622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l1IQCraLpL+rSMmlu5ovwNapuzcDCT4B2MmMdy4mIig=;
 b=Fr7Ga2Ov1JjQDNrE6l7YP6+vDinZdC5hbH3nZKlRCq8yGvz1rdE2lz8ZbIuocq/7o8l9p6
 Qs5qGsWpErNE5DxpDNhuhADRU0snf6f1XQXFpUAkj/1AulKudATyPAH2/ApV2uynFcu8C4
 qFoYktjRKKGv1cVPm6STanCWaM12OrA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-t1MVDiHnM0S7vWlaveXelw-1; Sun, 24 Sep 2023 04:53:40 -0400
X-MC-Unique: t1MVDiHnM0S7vWlaveXelw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-774105f6fb1so636655285a.3
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 01:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695545620; x=1696150420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l1IQCraLpL+rSMmlu5ovwNapuzcDCT4B2MmMdy4mIig=;
 b=X/umqgQqdlpYsnHa7zCd52avRKhcLougj647pTThwSoC0Ud9Qq/5jIlXcM/31v0r8Z
 2VS1VwqWyGiYJG2PNe53cybxD1XVA9DRXuxM+C6lsJlhRCQ0KMLAP0zr91tw/IxhtcPS
 9oaV4ck4EwBmOkSIfPd7tVaJqy4CwCi66c4DKGHHZaQbaw2/ycArzE/6uWsETJbuyofI
 /FqkB6nZph0OWfOKtt8atUfX5zBWcZLmRb/JvRqzxr8K/uUBVuBVSCofg5IccezIhGb3
 rAqCq7I6LXwaKMzfzpK6325cTsJNoToI4yRBpg51Ln25uFHhwkkSEQFPpvgZLaQexNhQ
 Axhg==
X-Gm-Message-State: AOJu0Yxrp50N8z1EX2KAwYI9J5k5ldvxsDifExlt5wQHvTzQNyMCKqiX
 5XrGzY7WGZ8RB6soJ6BN6serRxkw+mofUNZou5sCMDjEkJ264rrJfwaXidN7TtovGA+DICjREn/
 8cK5uKhGjz6ctS0NWdnijgmssrvTFmVQ=
X-Received: by 2002:a05:620a:3905:b0:773:cc16:ef11 with SMTP id
 qr5-20020a05620a390500b00773cc16ef11mr4400110qkn.13.1695545619971; 
 Sun, 24 Sep 2023 01:53:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGarBnrS+g/ipROBEvkcpNn838EKssUen91lzlSAdNYNb8Gz5+VOEVeSGMqoWTdWZndCDVa4OLklEJOj9yNeMI=
X-Received: by 2002:a05:620a:3905:b0:773:cc16:ef11 with SMTP id
 qr5-20020a05620a390500b00773cc16ef11mr4400100qkn.13.1695545619698; Sun, 24
 Sep 2023 01:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230923085507.399260-1-pbonzini@redhat.com>
 <20230923085507.399260-12-pbonzini@redhat.com>
 <8395a8cf-c902-7da6-cb4e-0d4488a2a5dd@eik.bme.hu>
In-Reply-To: <8395a8cf-c902-7da6-cb4e-0d4488a2a5dd@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 24 Sep 2023 10:53:27 +0200
Message-ID: <CABgObfZeRzae78jKvDzyhWv9oVS_OS8Zo4Mfn7rtnFqG0UqK8A@mail.gmail.com>
Subject: Re: [PATCH 11/13] vt82c686: Support machine-default audiodev with
 fallback
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: multipart/alternative; boundary="0000000000005ced2c060616fa97"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000005ced2c060616fa97
Content-Type: text/plain; charset="UTF-8"

Il sab 23 set 2023, 14:23 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:

> On Sat, 23 Sep 2023, Paolo Bonzini wrote:
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> > hw/isa/vt82c686.c   |  2 ++
> > hw/mips/fuloong2e.c | 13 ++++++++++---
> > hw/ppc/pegasos2.c   | 10 ++++++++--
> > 3 files changed, 20 insertions(+), 5 deletions(-)
>
> This looks better but I still wonder if this machine audiodev propery is
> needed at all. If there's one -audiodev option specified it's already
> picked up by default devices and if there are more one could use -global
> to set it. Why isn't that enough?
>

Mostly because it's less predictable. Ideally all the state of the emulator
would be visible and settable via explicit links.

You were absolutely right that we still need to keep some level of magic in
softmmu/vl.c to make QEMU easier to use for the command line. However, a
while ago there was an idea of making an alternative binary that is
entirely configurable via QMP, and past work in that direction resulted in
*lots* of cleanups that actually made softmmu/vl.c understandable. While I
am not sure this QMP binary is ever going to happen, I would like to make
it possible to avoid the magic.

If you still want a machine audiodev propery then could the device handle
> it without needing changes to the machine? Like in via_isa_realize() add
>
> if (current_machine->audiodev) {
>      qdev_prop_set_string(DEVICE(pci_dev), "audiodev", machine->audiodev);
> }
>
> before qdev_realize(DEVICE(&s->ac97) then no need to change the device
> creation in board code.
>

No, current_machine should not be used at all outside board code.

Paolo


> Regards,
> BALATON Zoltan
>
> > diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> > index 57bdfb4e78c..3ec8e43708a 100644
> > --- a/hw/isa/vt82c686.c
> > +++ b/hw/isa/vt82c686.c
> > @@ -578,6 +578,8 @@ static void via_isa_init(Object *obj)
> >     object_initialize_child(obj, "uhci2", &s->uhci[1],
> TYPE_VT82C686B_USB_UHCI);
> >     object_initialize_child(obj, "ac97", &s->ac97, TYPE_VIA_AC97);
> >     object_initialize_child(obj, "mc97", &s->mc97, TYPE_VIA_MC97);
> > +
> > +    object_property_add_alias(obj, "audiodev", OBJECT(&s->ac97),
> "audiodev");
> > }
> >
> > static const TypeInfo via_isa_info = {
> > diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> > index c827f615f3b..df2be188257 100644
> > --- a/hw/mips/fuloong2e.c
> > +++ b/hw/mips/fuloong2e.c
> > @@ -41,6 +41,7 @@
> > #include "sysemu/reset.h"
> > #include "sysemu/sysemu.h"
> > #include "qemu/error-report.h"
> > +#include "audio/audio.h"
> >
> > #define ENVP_PADDR              0x2000
> > #define ENVP_VADDR              cpu_mips_phys_to_kseg0(NULL, ENVP_PADDR)
> > @@ -295,9 +296,13 @@ static void mips_fuloong2e_init(MachineState
> *machine)
> >     pci_bus = bonito_init((qemu_irq *)&(env->irq[2]));
> >
> >     /* South bridge -> IP5 */
> > -    pci_dev = pci_create_simple_multifunction(pci_bus,
> > -
> PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
> > -                                              TYPE_VT82C686B_ISA);
> > +    pci_dev = pci_new_multifunction(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
> > +                                    TYPE_VT82C686B_ISA);
> > +    if (machine->audiodev) {
> > +        qdev_prop_set_string(DEVICE(pci_dev), "audiodev",
> machine->audiodev);
> > +    }
> > +    pci_realize_and_unref(pci_dev, pci_bus, &error_abort);
> > +
> >     object_property_add_alias(OBJECT(machine), "rtc-time",
> >
>  object_resolve_path_component(OBJECT(pci_dev),
> >                                                             "rtc"),
> > @@ -337,6 +342,8 @@ static void mips_fuloong2e_machine_init(MachineClass
> *mc)
> >     mc->default_ram_size = 256 * MiB;
> >     mc->default_ram_id = "fuloong2e.ram";
> >     mc->minimum_page_bits = 14;
> > +
> > +    machine_add_audiodev_property(mc);
> > }
> >
> > DEFINE_MACHINE("fuloong2e", mips_fuloong2e_machine_init)
> > diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> > index bd397cf2b5c..61c302895c9 100644
> > --- a/hw/ppc/pegasos2.c
> > +++ b/hw/ppc/pegasos2.c
> > @@ -37,6 +37,7 @@
> > #include "qemu/datadir.h"
> > #include "sysemu/device_tree.h"
> > #include "hw/ppc/vof.h"
> > +#include "audio/audio.h"
> >
> > #include <libfdt.h>
> >
> > @@ -180,8 +181,11 @@ static void pegasos2_init(MachineState *machine)
> >     pci_bus_irqs(pci_bus, pegasos2_pci_irq, pm, PCI_NUM_PINS);
> >
> >     /* VIA VT8231 South Bridge (multifunction PCI device) */
> > -    via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(12,
> 0),
> > -                                                 TYPE_VT8231_ISA));
> > +    via = OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0),
> TYPE_VT8231_ISA));
> > +    if (machine->audiodev) {
> > +        qdev_prop_set_string(DEVICE(via), "audiodev",
> machine->audiodev);
> > +    }
> > +    pci_realize_and_unref(PCI_DEVICE(via), pci_bus, &error_abort);
> >     for (i = 0; i < PCI_NUM_PINS; i++) {
> >         pm->via_pirq[i] = qdev_get_gpio_in_named(DEVICE(via), "pirq", i);
> >     }
> > @@ -564,6 +568,8 @@ static void pegasos2_machine_class_init(ObjectClass
> *oc, void *data)
> >     vhc->encode_hpt_for_kvm_pr = vhyp_encode_hpt_for_kvm_pr;
> >
> >     vmc->setprop = pegasos2_setprop;
> > +
> > +    machine_add_audiodev_property(mc);
> > }
> >
> > static const TypeInfo pegasos2_machine_info = {
> >
>
>

--0000000000005ced2c060616fa97
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 23 set 2023, 14:23 BALATON Zoltan &lt;<a href=
=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt; ha scritto:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On Sat, 23 Sep 2023, Paolo Bonzini wrote=
:<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; hw/isa/vt82c686.c=C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt; hw/mips/fuloong2e.c | 13 ++++++++++---<br>
&gt; hw/ppc/pegasos2.c=C2=A0 =C2=A0| 10 ++++++++--<br>
&gt; 3 files changed, 20 insertions(+), 5 deletions(-)<br>
<br>
This looks better but I still wonder if this machine audiodev propery is <b=
r>
needed at all. If there&#39;s one -audiodev option specified it&#39;s alrea=
dy <br>
picked up by default devices and if there are more one could use -global <b=
r>
to set it. Why isn&#39;t that enough?<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Mostly because it&#39;s less predicta=
ble. Ideally all the state of the emulator would be visible and settable vi=
a explicit links.</div><div dir=3D"auto"><br></div><div dir=3D"auto">You we=
re absolutely right that we still need to keep some level of magic in softm=
mu/vl.c to make QEMU easier to use for the command line. However, a while a=
go there was an idea of making an alternative binary that is entirely confi=
gurable via QMP, and past work in that direction resulted in *lots* of clea=
nups that actually made softmmu/vl.c understandable. While I am not sure th=
is QMP binary is ever going to happen,=C2=A0I would like to make it possibl=
e to avoid the magic.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">If you still want a=
 machine audiodev propery then could the device handle <br>
it without needing changes to the machine? Like in via_isa_realize() add<br=
>
<br>
if (current_machine-&gt;audiodev) {<br>
=C2=A0 =C2=A0 =C2=A0qdev_prop_set_string(DEVICE(pci_dev), &quot;audiodev&qu=
ot;, machine-&gt;audiodev);<br>
}<br>
<br>
before qdev_realize(DEVICE(&amp;s-&gt;ac97) then no need to change the devi=
ce <br>
creation in board code.<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">No, current_machine should not be used at all outsid=
e board code.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
&gt; diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c<br>
&gt; index 57bdfb4e78c..3ec8e43708a 100644<br>
&gt; --- a/hw/isa/vt82c686.c<br>
&gt; +++ b/hw/isa/vt82c686.c<br>
&gt; @@ -578,6 +578,8 @@ static void via_isa_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;uhci2&quot;, &am=
p;s-&gt;uhci[1], TYPE_VT82C686B_USB_UHCI);<br>
&gt;=C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;ac97&quot;, &amp=
;s-&gt;ac97, TYPE_VIA_AC97);<br>
&gt;=C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;mc97&quot;, &amp=
;s-&gt;mc97, TYPE_VIA_MC97);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_alias(obj, &quot;audiodev&quot;, OB=
JECT(&amp;s-&gt;ac97), &quot;audiodev&quot;);<br>
&gt; }<br>
&gt;<br>
&gt; static const TypeInfo via_isa_info =3D {<br>
&gt; diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c<br>
&gt; index c827f615f3b..df2be188257 100644<br>
&gt; --- a/hw/mips/fuloong2e.c<br>
&gt; +++ b/hw/mips/fuloong2e.c<br>
&gt; @@ -41,6 +41,7 @@<br>
&gt; #include &quot;sysemu/reset.h&quot;<br>
&gt; #include &quot;sysemu/sysemu.h&quot;<br>
&gt; #include &quot;qemu/error-report.h&quot;<br>
&gt; +#include &quot;audio/audio.h&quot;<br>
&gt;<br>
&gt; #define ENVP_PADDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2=
000<br>
&gt; #define ENVP_VADDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu=
_mips_phys_to_kseg0(NULL, ENVP_PADDR)<br>
&gt; @@ -295,9 +296,13 @@ static void mips_fuloong2e_init(MachineState *mac=
hine)<br>
&gt;=C2=A0 =C2=A0 =C2=A0pci_bus =3D bonito_init((qemu_irq *)&amp;(env-&gt;i=
rq[2]));<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0/* South bridge -&gt; IP5 */<br>
&gt; -=C2=A0 =C2=A0 pci_dev =3D pci_create_simple_multifunction(pci_bus,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TYPE_VT82C686B_ISA);<br>
&gt; +=C2=A0 =C2=A0 pci_dev =3D pci_new_multifunction(PCI_DEVFN(FULOONG2E_V=
IA_SLOT, 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_VT82C686B_ISA=
);<br>
&gt; +=C2=A0 =C2=A0 if (machine-&gt;audiodev) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(pci_dev), &qu=
ot;audiodev&quot;, machine-&gt;audiodev);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 pci_realize_and_unref(pci_dev, pci_bus, &amp;error_abor=
t);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0object_property_add_alias(OBJECT(machine), &quot;rt=
c-time&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_resolve_path_component(OBJE=
CT(pci_dev),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&q=
uot;rtc&quot;),<br>
&gt; @@ -337,6 +342,8 @@ static void mips_fuloong2e_machine_init(MachineCla=
ss *mc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0mc-&gt;default_ram_size =3D 256 * MiB;<br>
&gt;=C2=A0 =C2=A0 =C2=A0mc-&gt;default_ram_id =3D &quot;fuloong2e.ram&quot;=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0mc-&gt;minimum_page_bits =3D 14;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 machine_add_audiodev_property(mc);<br>
&gt; }<br>
&gt;<br>
&gt; DEFINE_MACHINE(&quot;fuloong2e&quot;, mips_fuloong2e_machine_init)<br>
&gt; diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c<br>
&gt; index bd397cf2b5c..61c302895c9 100644<br>
&gt; --- a/hw/ppc/pegasos2.c<br>
&gt; +++ b/hw/ppc/pegasos2.c<br>
&gt; @@ -37,6 +37,7 @@<br>
&gt; #include &quot;qemu/datadir.h&quot;<br>
&gt; #include &quot;sysemu/device_tree.h&quot;<br>
&gt; #include &quot;hw/ppc/vof.h&quot;<br>
&gt; +#include &quot;audio/audio.h&quot;<br>
&gt;<br>
&gt; #include &lt;libfdt.h&gt;<br>
&gt;<br>
&gt; @@ -180,8 +181,11 @@ static void pegasos2_init(MachineState *machine)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0pci_bus_irqs(pci_bus, pegasos2_pci_irq, pm, PCI_NUM=
_PINS);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0/* VIA VT8231 South Bridge (multifunction PCI devic=
e) */<br>
&gt; -=C2=A0 =C2=A0 via =3D OBJECT(pci_create_simple_multifunction(pci_bus,=
 PCI_DEVFN(12, 0),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_VT8231_ISA));<br>
&gt; +=C2=A0 =C2=A0 via =3D OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0), =
TYPE_VT8231_ISA));<br>
&gt; +=C2=A0 =C2=A0 if (machine-&gt;audiodev) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_string(DEVICE(via), &quot;a=
udiodev&quot;, machine-&gt;audiodev);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 pci_realize_and_unref(PCI_DEVICE(via), pci_bus, &amp;er=
ror_abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; PCI_NUM_PINS; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm-&gt;via_pirq[i] =3D qdev_get_gpio_=
in_named(DEVICE(via), &quot;pirq&quot;, i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -564,6 +568,8 @@ static void pegasos2_machine_class_init(ObjectClas=
s *oc, void *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0vhc-&gt;encode_hpt_for_kvm_pr =3D vhyp_encode_hpt_f=
or_kvm_pr;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmc-&gt;setprop =3D pegasos2_setprop;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 machine_add_audiodev_property(mc);<br>
&gt; }<br>
&gt;<br>
&gt; static const TypeInfo pegasos2_machine_info =3D {<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--0000000000005ced2c060616fa97--



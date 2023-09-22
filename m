Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDC37AADB4
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:21:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcKE-0000Gr-9u; Fri, 22 Sep 2023 05:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcKC-0000F8-M1
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcKA-0000dQ-NR
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695374385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53rY/Mmg8rF2vlMlkoZfmGurJi9nAqUG1CDk+zRxgk0=;
 b=bE2xH5ndrOI/dma9BQMIrROw1FejjTk/pzBdgnQfgiur3wVMfhnoFMWHuC+5FPlPAfDq5f
 DKb2NNzTIt4vXgYKXvKDmWczxYpohng9kf8wbbtTFMRrp9zUl/gmTuU+U5nSJ6DVDjYTeM
 Cl377Q638tOnsGCqtQUAy5a7uOoCTTQ=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-MqS5UsfRMyuUA9FDLSHMDg-1; Fri, 22 Sep 2023 05:19:43 -0400
X-MC-Unique: MqS5UsfRMyuUA9FDLSHMDg-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-45289b05c67so828994137.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695374382; x=1695979182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=53rY/Mmg8rF2vlMlkoZfmGurJi9nAqUG1CDk+zRxgk0=;
 b=tjbQAjMpqAIvc7qRCPHqm2gvoW5gKyim11A5nsKxQZmXUNqkz+q8B518RiZ/tkxh9s
 BLZC2BrzYwOz1XynG8X7ZdXUOzGilywqHmO7uU7zyWfBBgh6sqbQ/v6n29QAQGnk3J86
 4YaDmTnkj0eSSY2mBIqFsLSBOiZI85Nm2JMIOs6PfzHHdmDjcj/cd1Xarh6ORovAZYKB
 L7xip5IrzSYScA2Q7CB4wuIWd051yWAxupKtTOpGLWWVCiC7TgtA/hpoEXVAUfxZuI19
 z5tS+V50bLx6Cb9llZNmecY97tTxfXJUMQi9EKSgIHG6gboS2vF2wohIa4AHN+zeQ5v3
 6/TA==
X-Gm-Message-State: AOJu0YxRGjh+zA9L0EnF496/aUTRvkKLA5mNBKhYCzvcnB4pL36rinF6
 7J2kRl01PFtE7TdwpNkPQgryQnZlDIL5cjruF2AKfQsUvEmmGqZbNZApGXCY8LS0Cwp36gIs4na
 nqxAqKoblkyIdiUH1ZdlSIxqXpzDceYE=
X-Received: by 2002:a05:6102:284c:b0:450:f96c:f238 with SMTP id
 az12-20020a056102284c00b00450f96cf238mr8961040vsb.8.1695374382492; 
 Fri, 22 Sep 2023 02:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv76pzzfFaXq2pazgFwfVCFZ50LgEsjtZhdWsHFnOsON3+v6WWcs2Rw5C8iIZUFx3+s+OAltTgBDKBOKTJyrk=
X-Received: by 2002:a05:6102:284c:b0:450:f96c:f238 with SMTP id
 az12-20020a056102284c00b00450f96cf238mr8961027vsb.8.1695374382185; Fri, 22
 Sep 2023 02:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230921121051.192355-1-pbonzini@redhat.com>
 <20230921121051.192355-2-pbonzini@redhat.com>
 <052e2425-f2fa-76ee-dd40-639d88210b4c@redhat.com>
In-Reply-To: <052e2425-f2fa-76ee-dd40-639d88210b4c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2023 11:19:31 +0200
Message-ID: <CABgObfYgc2iF-89rPGL1siqvwXCGWPgP9Zs-2uOjj0j6jXVEfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pc_piix: remove pc-i440fx-1.4 up to pc-i440fx-1.7
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Hoffmann, Gerd" <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cfd52e0605ef1b5d"
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

--000000000000cfd52e0605ef1b5d
Content-Type: text/plain; charset="UTF-8"

Il ven 22 set 2023, 08:43 Thomas Huth <thuth@redhat.com> ha scritto:

>
> While you're at it ... do we maybe want to start deprecating the next
> batch
> of machine types already? (Say pc-i440fx-2.0 up to pc-i440fx-2.2 maybe?)
>

It depends on the benefit. We would have to check the compat options that
are not needed anymore, and whether they'd be something that is useful
anyway for debugging.

Also it would be useful to check if isapc can drop some of the compat code
and realign itself to the 2.0 i440fx machine in terms of QEMU-specific
features.

Because of all this todo, I decided not to proceed further with
deprecations. The 128k ROM on the other hand does provide immediate benefit.

Paolo


> > -
> >   Backend options
> >   ---------------
> >
> > diff --git a/docs/about/removed-features.rst
> b/docs/about/removed-features.rst
> > index 39468b6e926..56e078ad126 100644
> > --- a/docs/about/removed-features.rst
> > +++ b/docs/about/removed-features.rst
> > @@ -730,7 +730,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
> >
> >   This machine has been renamed ``fuloong2e``.
> >
> > -``pc-0.10`` up to ``pc-1.3`` (removed in 4.0 up to 6.0)
> > +``pc-0.10`` up to ``pc-1.7`` (removed in 4.0 up to 8.2)
> >   '''''''''''''''''''''''''''''''''''''''''''''''''''''''
>
> The names started to change with version 1.4, so it's "pc-i440fx-1.7" and
> not "pc-1.7".
>
> >   These machine types were very old and likely could not be used for live
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 54838c0c411..1c7898a2d34 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -359,60 +359,6 @@ GlobalProperty pc_compat_2_0[] = {
> >   };
> >   const size_t pc_compat_2_0_len = G_N_ELEMENTS(pc_compat_2_0);
> >
> > -GlobalProperty pc_compat_1_7[] = {
> > -    PC_CPU_MODEL_IDS("1.7.0")
> > -    { TYPE_USB_DEVICE, "msos-desc", "no" },
> > -    { "PIIX4_PM", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" },
> > -    { "hpet", HPET_INTCAP, "4" },
> > -};
> > -const size_t pc_compat_1_7_len = G_N_ELEMENTS(pc_compat_1_7);
> > -
> > -GlobalProperty pc_compat_1_6[] = {
> > -    PC_CPU_MODEL_IDS("1.6.0")
> > -    { "e1000", "mitigation", "off" },
> > -    { "qemu64-" TYPE_X86_CPU, "model", "2" },
> > -    { "qemu32-" TYPE_X86_CPU, "model", "3" },
> > -    { "i440FX-pcihost", "short_root_bus", "1" },
> > -    { "q35-pcihost", "short_root_bus", "1" },
> > -};
> > -const size_t pc_compat_1_6_len = G_N_ELEMENTS(pc_compat_1_6);
> > -
> > -GlobalProperty pc_compat_1_5[] = {
> > -    PC_CPU_MODEL_IDS("1.5.0")
> > -    { "Conroe-" TYPE_X86_CPU, "model", "2" },
> > -    { "Conroe-" TYPE_X86_CPU, "min-level", "2" },
> > -    { "Penryn-" TYPE_X86_CPU, "model", "2" },
> > -    { "Penryn-" TYPE_X86_CPU, "min-level", "2" },
> > -    { "Nehalem-" TYPE_X86_CPU, "model", "2" },
> > -    { "Nehalem-" TYPE_X86_CPU, "min-level", "2" },
> > -    { "virtio-net-pci", "any_layout", "off" },
> > -    { TYPE_X86_CPU, "pmu", "on" },
> > -    { "i440FX-pcihost", "short_root_bus", "0" },
> > -    { "q35-pcihost", "short_root_bus", "0" },
> > -};
> > -const size_t pc_compat_1_5_len = G_N_ELEMENTS(pc_compat_1_5);
> > -
> > -GlobalProperty pc_compat_1_4[] = {
> > -    PC_CPU_MODEL_IDS("1.4.0")
> > -    { "scsi-hd", "discard_granularity", "0" },
> > -    { "scsi-cd", "discard_granularity", "0" },
> > -    { "ide-hd", "discard_granularity", "0" },
> > -    { "ide-cd", "discard_granularity", "0" },
> > -    { "virtio-blk-pci", "discard_granularity", "0" },
> > -    /* DEV_NVECTORS_UNSPECIFIED as a uint32_t string: */
> > -    { "virtio-serial-pci", "vectors", "0xFFFFFFFF" },
> > -    { "virtio-net-pci", "ctrl_guest_offloads", "off" },
> > -    { "e1000", "romfile", "pxe-e1000.rom" },
> > -    { "ne2k_pci", "romfile", "pxe-ne2k_pci.rom" },
> > -    { "pcnet", "romfile", "pxe-pcnet.rom" },
> > -    { "rtl8139", "romfile", "pxe-rtl8139.rom" },
> > -    { "virtio-net-pci", "romfile", "pxe-virtio.rom" },
> > -    { "486-" TYPE_X86_CPU, "model", "0" },
> > -    { "n270" "-" TYPE_X86_CPU, "movbe", "off" },
> > -    { "Westmere" "-" TYPE_X86_CPU, "pclmulqdq", "off" },
> > -};
> > -const size_t pc_compat_1_4_len = G_N_ELEMENTS(pc_compat_1_4);
>
> It might be worth to have a closer look at the above settings in the
> various
> devices - maybe we can get rid of some compatibility handling code in the
> devices now, in case the properties are not set by other targets as well.
>
>   Thomas
>
>

--000000000000cfd52e0605ef1b5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 22 set 2023, 08:43 Thomas Huth &lt;<a href=3D"m=
ailto:thuth@redhat.com">thuth@redhat.com</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><br>
While you&#39;re at it ... do we maybe want to start deprecating the next b=
atch <br>
of machine types already? (Say pc-i440fx-2.0 up to pc-i440fx-2.2 maybe?)<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It =
depends on the benefit. We would have to check the compat options that are =
not needed anymore, and whether they&#39;d be something that is useful anyw=
ay for debugging.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Also i=
t would be useful to check if isapc can drop some of the compat code and re=
align itself to the 2.0 i440fx machine in terms of QEMU-specific features.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Because of all this todo=
, I decided not to proceed further with deprecations. The 128k ROM on the o=
ther hand does provide immediate benefit.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0Backend options<br>
&gt;=C2=A0 =C2=A0---------------<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/docs/about/removed-features.rst b/docs/about/removed-feat=
ures.rst<br>
&gt; index 39468b6e926..56e078ad126 100644<br>
&gt; --- a/docs/about/removed-features.rst<br>
&gt; +++ b/docs/about/removed-features.rst<br>
&gt; @@ -730,7 +730,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)<b=
r>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0This machine has been renamed ``fuloong2e``.<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -``pc-0.10`` up to ``pc-1.3`` (removed in 4.0 up to 6.0)<br>
&gt; +``pc-0.10`` up to ``pc-1.7`` (removed in 4.0 up to 8.2)<br>
&gt;=C2=A0 =C2=A0&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#3=
9;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#3=
9;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#3=
9;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
<br>
The names started to change with version 1.4, so it&#39;s &quot;pc-i440fx-1=
.7&quot; and <br>
not &quot;pc-1.7&quot;.<br>
<br>
&gt;=C2=A0 =C2=A0These machine types were very old and likely could not be =
used for live<br>
&gt; diff --git a/hw/i386/pc.c b/hw/i386/pc.c<br>
&gt; index 54838c0c411..1c7898a2d34 100644<br>
&gt; --- a/hw/i386/pc.c<br>
&gt; +++ b/hw/i386/pc.c<br>
&gt; @@ -359,60 +359,6 @@ GlobalProperty pc_compat_2_0[] =3D {<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0const size_t pc_compat_2_0_len =3D G_N_ELEMENTS(pc_compat_=
2_0);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -GlobalProperty pc_compat_1_7[] =3D {<br>
&gt; -=C2=A0 =C2=A0 PC_CPU_MODEL_IDS(&quot;1.7.0&quot;)<br>
&gt; -=C2=A0 =C2=A0 { TYPE_USB_DEVICE, &quot;msos-desc&quot;, &quot;no&quot=
; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;PIIX4_PM&quot;, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,=
 &quot;off&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;hpet&quot;, HPET_INTCAP, &quot;4&quot; },<br>
&gt; -};<br>
&gt; -const size_t pc_compat_1_7_len =3D G_N_ELEMENTS(pc_compat_1_7);<br>
&gt; -<br>
&gt; -GlobalProperty pc_compat_1_6[] =3D {<br>
&gt; -=C2=A0 =C2=A0 PC_CPU_MODEL_IDS(&quot;1.6.0&quot;)<br>
&gt; -=C2=A0 =C2=A0 { &quot;e1000&quot;, &quot;mitigation&quot;, &quot;off&=
quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;qemu64-&quot; TYPE_X86_CPU, &quot;model&quot;, =
&quot;2&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;qemu32-&quot; TYPE_X86_CPU, &quot;model&quot;, =
&quot;3&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;i440FX-pcihost&quot;, &quot;short_root_bus&quot=
;, &quot;1&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;q35-pcihost&quot;, &quot;short_root_bus&quot;, =
&quot;1&quot; },<br>
&gt; -};<br>
&gt; -const size_t pc_compat_1_6_len =3D G_N_ELEMENTS(pc_compat_1_6);<br>
&gt; -<br>
&gt; -GlobalProperty pc_compat_1_5[] =3D {<br>
&gt; -=C2=A0 =C2=A0 PC_CPU_MODEL_IDS(&quot;1.5.0&quot;)<br>
&gt; -=C2=A0 =C2=A0 { &quot;Conroe-&quot; TYPE_X86_CPU, &quot;model&quot;, =
&quot;2&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;Conroe-&quot; TYPE_X86_CPU, &quot;min-level&quo=
t;, &quot;2&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;Penryn-&quot; TYPE_X86_CPU, &quot;model&quot;, =
&quot;2&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;Penryn-&quot; TYPE_X86_CPU, &quot;min-level&quo=
t;, &quot;2&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;Nehalem-&quot; TYPE_X86_CPU, &quot;model&quot;,=
 &quot;2&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;Nehalem-&quot; TYPE_X86_CPU, &quot;min-level&qu=
ot;, &quot;2&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;virtio-net-pci&quot;, &quot;any_layout&quot;, &=
quot;off&quot; },<br>
&gt; -=C2=A0 =C2=A0 { TYPE_X86_CPU, &quot;pmu&quot;, &quot;on&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;i440FX-pcihost&quot;, &quot;short_root_bus&quot=
;, &quot;0&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;q35-pcihost&quot;, &quot;short_root_bus&quot;, =
&quot;0&quot; },<br>
&gt; -};<br>
&gt; -const size_t pc_compat_1_5_len =3D G_N_ELEMENTS(pc_compat_1_5);<br>
&gt; -<br>
&gt; -GlobalProperty pc_compat_1_4[] =3D {<br>
&gt; -=C2=A0 =C2=A0 PC_CPU_MODEL_IDS(&quot;1.4.0&quot;)<br>
&gt; -=C2=A0 =C2=A0 { &quot;scsi-hd&quot;, &quot;discard_granularity&quot;,=
 &quot;0&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;scsi-cd&quot;, &quot;discard_granularity&quot;,=
 &quot;0&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;ide-hd&quot;, &quot;discard_granularity&quot;, =
&quot;0&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;ide-cd&quot;, &quot;discard_granularity&quot;, =
&quot;0&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;virtio-blk-pci&quot;, &quot;discard_granularity=
&quot;, &quot;0&quot; },<br>
&gt; -=C2=A0 =C2=A0 /* DEV_NVECTORS_UNSPECIFIED as a uint32_t string: */<br=
>
&gt; -=C2=A0 =C2=A0 { &quot;virtio-serial-pci&quot;, &quot;vectors&quot;, &=
quot;0xFFFFFFFF&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;virtio-net-pci&quot;, &quot;ctrl_guest_offloads=
&quot;, &quot;off&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;e1000&quot;, &quot;romfile&quot;, &quot;pxe-e10=
00.rom&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;ne2k_pci&quot;, &quot;romfile&quot;, &quot;pxe-=
ne2k_pci.rom&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;pcnet&quot;, &quot;romfile&quot;, &quot;pxe-pcn=
et.rom&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;rtl8139&quot;, &quot;romfile&quot;, &quot;pxe-r=
tl8139.rom&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;virtio-net-pci&quot;, &quot;romfile&quot;, &quo=
t;pxe-virtio.rom&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;486-&quot; TYPE_X86_CPU, &quot;model&quot;, &qu=
ot;0&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;n270&quot; &quot;-&quot; TYPE_X86_CPU, &quot;mo=
vbe&quot;, &quot;off&quot; },<br>
&gt; -=C2=A0 =C2=A0 { &quot;Westmere&quot; &quot;-&quot; TYPE_X86_CPU, &quo=
t;pclmulqdq&quot;, &quot;off&quot; },<br>
&gt; -};<br>
&gt; -const size_t pc_compat_1_4_len =3D G_N_ELEMENTS(pc_compat_1_4);<br>
<br>
It might be worth to have a closer look at the above settings in the variou=
s <br>
devices - maybe we can get rid of some compatibility handling code in the <=
br>
devices now, in case the properties are not set by other targets as well.<b=
r>
<br>
=C2=A0 Thomas<br>
<br>
</blockquote></div></div></div>

--000000000000cfd52e0605ef1b5d--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA92738D67
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 19:41:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC1pD-0002UH-Bc; Wed, 21 Jun 2023 13:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qC1pB-0002Tn-0C
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 13:40:57 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qC1p8-0004gZ-WC
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 13:40:56 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51be4a42b9bso612330a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687369253; x=1689961253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5nPtxSD4ZVOZVNM0E+WnVLEyBw3eHMTeyxkcubUDaHU=;
 b=YafN0cHPxg0tbKc3+zDH1KgRpprWjN7adenH3NY1fpfhGRtuinTY1QD9ij1jOHoqmW
 0kAVWaXR8c/Pf1KebqFKZrxRN9foupmf1r0t9eR+6UFUaki2o/JOyO7J8lpftO6d1gTN
 /s5xMjljjqlHwRKhilGP0tVYpkUvALVPslwSSchU9MfOF2txIAn4RYxwk9kxsQTsPYDH
 TtS3IYfl+dij3wzP0zRHpOvPFLrrJhGoYKyj8lLgOjDxAd5VLXcyz2lA2KT5H3Vh2HO3
 2r9sMDtrXOl/DFGQW/F1G2Y9Cu6KchOoI4UIq6enxZTWe2t2uCAPamRNaVvgMxySZ9t9
 0+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687369253; x=1689961253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5nPtxSD4ZVOZVNM0E+WnVLEyBw3eHMTeyxkcubUDaHU=;
 b=YBGoJfPBO6sJR/4RERhCp2dyJyulRc3jKZ5FJUSRe32pF05smtyFUhemyzPPawOHhQ
 HWtVGap8N2P+LgnygTeCEafrAF4xkQ8JMIHJjGvC3ps0OlM0S+6+gd9D3W0U66usnFCM
 u4n1ki+z4nVJ702aCr1CcbTVhdlKDZPwTpRYVujSO7DLUdkOFMsoDfryPWwNC76wfPKq
 Ks/M8t0riYnQnSatagostz/bJD6ES69j44QCWU3SKMXqurYcd/R+FuJpShkOL3fyi8c7
 vNb0WwIBiLDBLLdRWn8J10GhknJ5AAAog6wON0gcLaG7OdJHPHeSSF/axEYpI9o54/hY
 NjoA==
X-Gm-Message-State: AC+VfDy3gprrN8MjLT44MXWr3gadgWxlqtx16wZPX2CIrnuRexIsR2F5
 q3uN3rwQ7RF3oDYO2ue9g7jWv+1zVxu3R8JooHI=
X-Google-Smtp-Source: ACHHUZ5wV0KEbWd8YM7rf7vHpBM1Dd3Z7U3A54BtjEao58XWwZzSXY8eToxrppiO3kSbdNi73ckt/BnloreBLMjepr0=
X-Received: by 2002:aa7:c3c2:0:b0:51a:411f:4a97 with SMTP id
 l2-20020aa7c3c2000000b0051a411f4a97mr10354267edr.28.1687369253091; Wed, 21
 Jun 2023 10:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687278381.git.jupham125@gmail.com>
 <109921db6ea7bfbb46130cbd3734f41068d38fe5.1687278381.git.jupham125@gmail.com>
 <20230621133427.5091fbf7@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230621133427.5091fbf7@imammedo.users.ipa.redhat.com>
From: Joel Upham <jupham125@gmail.com>
Date: Wed, 21 Jun 2023 13:40:41 -0400
Message-ID: <CADPhr0m9NKLVYgxOszWwmfFD70ZTizLNAMB9O5VX8QURV4RpZg@mail.gmail.com>
Subject: Re: [PATCH v1 23/23] s3 support: enabling s3 with q35
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Ani Sinha <anisinha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ef7e6705fea74415"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=jupham125@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000ef7e6705fea74415
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 7:34=E2=80=AFAM Igor Mammedov <imammedo@redhat.com>=
 wrote:

> On Tue, 20 Jun 2023 13:24:57 -0400
> Joel Upham <jupham125@gmail.com> wrote:
>
> > Resetting pci devices after s3 causes guest freezes, as xen usually
> > likes to handle resetting devices.
>
> I'd prefer Xen side being fixed instead of hacking reset logic in qemu/q3=
5.
>
> Handling of ACPI and initialization of memory is done in hvmloader from m=
y
understanding.
What I noticed was when qemu attempted to reset devices, they became
unusable or would freeze the guest. It is very possible
that I am missing something that piix is doing to correctly reset, so any
input I can get to make this better
is welcome.

>
> > Signed-off-by: Joel Upham <jupham125@gmail.com>
> > ---
> >  hw/acpi/ich9.c    | 12 ++++++++----
> >  hw/pci-host/q35.c |  3 ++-
> >  2 files changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> > index 1c236be1c7..234706a191 100644
> > --- a/hw/acpi/ich9.c
> > +++ b/hw/acpi/ich9.c
> > @@ -143,7 +143,8 @@ static int ich9_pm_post_load(void *opaque, int
> version_id)
> >  {
> >      ICH9LPCPMRegs *pm =3D opaque;
> >      uint32_t pm_io_base =3D pm->pm_io_base;
> > -    pm->pm_io_base =3D 0;
> > +    if (!xen_enabled())
> > +        pm->pm_io_base =3D 0;
> >      ich9_pm_iospace_update(pm, pm_io_base);
> >      return 0;
> >  }
> > @@ -274,7 +275,10 @@ static void pm_reset(void *opaque)
> >      acpi_pm1_evt_reset(&pm->acpi_regs);
> >      acpi_pm1_cnt_reset(&pm->acpi_regs);
> >      acpi_pm_tmr_reset(&pm->acpi_regs);
> > -    acpi_gpe_reset(&pm->acpi_regs);
> > +    /* Noticed guest freezing in xen when this was reset after S3. */
> > +    if (!xen_enabled()) {
> > +        acpi_gpe_reset(&pm->acpi_regs);
> > +    }
> >
> >      pm->smi_en =3D 0;
> >      if (!pm->smm_enabled) {
> > @@ -322,7 +326,7 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs
> *pm, qemu_irq sci_irq)
> >          acpi_pm_tco_init(&pm->tco_regs, &pm->io);
> >      }
> >
> > -    if (pm->acpi_pci_hotplug.use_acpi_hotplug_bridge) {
> > +    if (pm->acpi_pci_hotplug.use_acpi_hotplug_bridge || xen_enabled())=
 {
> >          acpi_pcihp_init(OBJECT(lpc_pci),
> >                          &pm->acpi_pci_hotplug,
> >                          pci_get_bus(lpc_pci),
> > @@ -345,7 +349,7 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs
> *pm, qemu_irq sci_irq)
> >      legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
> >          OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
> >
> > -    if (pm->acpi_memory_hotplug.is_enabled) {
> > +    if (pm->acpi_memory_hotplug.is_enabled || xen_enabled()) {
> >          acpi_memory_hotplug_init(pci_address_space_io(lpc_pci),
> OBJECT(lpc_pci),
> >                                   &pm->acpi_memory_hotplug,
> >                                   ACPI_MEMORY_HOTPLUG_BASE);
> > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> > index 1fe4e5a5c9..5891839ce9 100644
> > --- a/hw/pci-host/q35.c
> > +++ b/hw/pci-host/q35.c
> > @@ -580,7 +580,8 @@ static void mch_reset(DeviceState *qdev)
> >      d->config[MCH_HOST_BRIDGE_F_SMBASE] =3D 0;
> >      d->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D 0xff;
> >
> > -    mch_update(mch);
> > +    if (!xen_enabled())
> > +        mch_update(mch);
> >  }
> >
> >  static void mch_realize(PCIDevice *d, Error **errp)
>
>

--000000000000ef7e6705fea74415
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 21, 2023 at 7:34=E2=80=AFAM I=
gor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On Tue, 20 Jun 2023 13:24:57 -0400<br>
Joel Upham &lt;<a href=3D"mailto:jupham125@gmail.com" target=3D"_blank">jup=
ham125@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Resetting pci devices after s3 causes guest freezes, as xen usually<br=
>
&gt; likes to handle resetting devices.<br>
<br>
I&#39;d prefer Xen side being fixed instead of hacking reset logic in qemu/=
q35.<br>
<br></blockquote><div>Handling of ACPI and initialization of memory is done=
 in hvmloader from my understanding. <br></div><div>What I noticed was when=
 qemu attempted to reset devices, they became unusable or would freeze the =
guest. It is very possible</div><div>that I am missing something that piix =
is doing to correctly reset, so any input I can get to make this better</di=
v><div>is welcome. =C2=A0 <br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt; Signed-off-by: Joel Upham &lt;<a href=3D"mailto:jupham125@gmail.com" t=
arget=3D"_blank">jupham125@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/acpi/ich9.c=C2=A0 =C2=A0 | 12 ++++++++----<br>
&gt;=C2=A0 hw/pci-host/q35.c |=C2=A0 3 ++-<br>
&gt;=C2=A0 2 files changed, 10 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c<br>
&gt; index 1c236be1c7..234706a191 100644<br>
&gt; --- a/hw/acpi/ich9.c<br>
&gt; +++ b/hw/acpi/ich9.c<br>
&gt; @@ -143,7 +143,8 @@ static int ich9_pm_post_load(void *opaque, int ver=
sion_id)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ICH9LPCPMRegs *pm =3D opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t pm_io_base =3D pm-&gt;pm_io_base;<br>
&gt; -=C2=A0 =C2=A0 pm-&gt;pm_io_base =3D 0;<br>
&gt; +=C2=A0 =C2=A0 if (!xen_enabled())<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pm-&gt;pm_io_base =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ich9_pm_iospace_update(pm, pm_io_base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt; @@ -274,7 +275,10 @@ static void pm_reset(void *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 acpi_pm1_evt_reset(&amp;pm-&gt;acpi_regs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 acpi_pm1_cnt_reset(&amp;pm-&gt;acpi_regs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 acpi_pm_tmr_reset(&amp;pm-&gt;acpi_regs);<br>
&gt; -=C2=A0 =C2=A0 acpi_gpe_reset(&amp;pm-&gt;acpi_regs);<br>
&gt; +=C2=A0 =C2=A0 /* Noticed guest freezing in xen when this was reset af=
ter S3. */<br>
&gt; +=C2=A0 =C2=A0 if (!xen_enabled()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_gpe_reset(&amp;pm-&gt;acpi_regs);<br=
>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 pm-&gt;smi_en =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!pm-&gt;smm_enabled) {<br>
&gt; @@ -322,7 +326,7 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMReg=
s *pm, qemu_irq sci_irq)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_pm_tco_init(&amp;pm-&gt;tco_reg=
s, &amp;pm-&gt;io);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (pm-&gt;acpi_pci_hotplug.use_acpi_hotplug_bridge) {<=
br>
&gt; +=C2=A0 =C2=A0 if (pm-&gt;acpi_pci_hotplug.use_acpi_hotplug_bridge || =
xen_enabled()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_pcihp_init(OBJECT(lpc_pci),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;pm-&gt;acpi_pci_hotplug,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 pci_get_bus(lpc_pci),<br>
&gt; @@ -345,7 +349,7 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMReg=
s *pm, qemu_irq sci_irq)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 legacy_acpi_cpu_hotplug_init(pci_address_space_io(=
lpc_pci),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OBJECT(lpc_pci), &amp;pm-&gt;gpe_cpu=
, ICH9_CPU_HOTPLUG_IO_BASE);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (pm-&gt;acpi_memory_hotplug.is_enabled) {<br>
&gt; +=C2=A0 =C2=A0 if (pm-&gt;acpi_memory_hotplug.is_enabled || xen_enable=
d()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_memory_hotplug_init(pci_address=
_space_io(lpc_pci), OBJECT(lpc_pci),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;pm-&gt;acpi_mem=
ory_hotplug,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ACPI_MEMORY_HOTPLUG_=
BASE);<br>
&gt; diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c<br>
&gt; index 1fe4e5a5c9..5891839ce9 100644<br>
&gt; --- a/hw/pci-host/q35.c<br>
&gt; +++ b/hw/pci-host/q35.c<br>
&gt; @@ -580,7 +580,8 @@ static void mch_reset(DeviceState *qdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 d-&gt;config[MCH_HOST_BRIDGE_F_SMBASE] =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 d-&gt;wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D 0xff;<br=
>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 mch_update(mch);<br>
&gt; +=C2=A0 =C2=A0 if (!xen_enabled())<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mch_update(mch);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void mch_realize(PCIDevice *d, Error **errp)<br>
<br>
</blockquote></div></div>

--000000000000ef7e6705fea74415--


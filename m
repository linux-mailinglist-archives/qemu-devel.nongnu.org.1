Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D65738D10
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 19:27:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC1cD-0008J1-Qe; Wed, 21 Jun 2023 13:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qC1cB-0008Iq-AD
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 13:27:31 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qC1c9-0007mj-Dj
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 13:27:30 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-518b69d5b5dso8316962a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 10:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687368447; x=1689960447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oytnNK2DpucSKPtKsiqSbAC4dbI6QxtRJ9u4gohCy7o=;
 b=o7XA7Syt4TVZdJ8xXb59AXUVJwfQMxDIFXkTxwVMOCDUtQIu7XIUW7WvmcAZUo8vG7
 frZoIvUlrCZE/mzzVT9XrwPM+LwaGeFe4Sd5JMfid5am17LstQ3caK1Ytbyy7vgFOvHf
 29l0Ntn0nfTvloS/oBrfSigmsPgz9GcyfyaxzuCBcPr6Ezqg6M5RqFdhG/Hy4xpIHYRU
 lslJd8S2SH/CXXVgYBjvEHTE6cA7nf7n2MwlEIr1iwzV9Y5H3ALSev3H8nJwm3E08Fxj
 9/0evaK3XH/5riu7t+bnQjzQpDuPK1i+TooFR93xkOE9QBdysBIDq+g5VFH/6Eu5Zo//
 Bo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687368447; x=1689960447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oytnNK2DpucSKPtKsiqSbAC4dbI6QxtRJ9u4gohCy7o=;
 b=F2+UwUEIqTlV/HVCHiK25JokWfO4V++Bz7p2jTHiHocValrziFlILnXa+tjU6L/wnn
 RPpzFQA1hWU/9gVSIdBykaEc1qE596XbPRoRGf/8tVTVpBf3eS63KXpkSNmAmz26/Om9
 oPmO4VBy+O6Dhf5AAtBzC16MLxsBB3dcBXBNQddblh05TejH6wSWfLdxM64F9Q+BWtcr
 LiodVdKXAF92t8TaaghAPR70wfhrGcdXAky7iM+drmuaUUS1rMMn7VE+ba4eoSG72BHY
 T4O1vXlkVIZo1IsLcvlrRZpnaQDpms1pH2IEyhjgxtmXNcIsme2zaiO/vsFDzd/xYITZ
 HHww==
X-Gm-Message-State: AC+VfDwuRT8mYhClVT252GzOqDfr0A1qsvPR5n7K+s6fbGxVyihuIf3J
 WATCSzCuSlrzamowZJRlPKEVVYtZtZRWelpHuLw=
X-Google-Smtp-Source: ACHHUZ4LzNjJOcf4QngDW5YrRPOHi2CBSfZCtPB4SpRgMuvL8I8w5/gzEheECup2QYeCdWnsqzgRQjH29lzcAyQ7kOg=
X-Received: by 2002:a50:fe84:0:b0:51a:200b:d8ff with SMTP id
 d4-20020a50fe84000000b0051a200bd8ffmr11132639edt.13.1687368447034; Wed, 21
 Jun 2023 10:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687278381.git.jupham125@gmail.com>
 <5e066d5cfb355656a8704f4d07ba697507613568.1687278381.git.jupham125@gmail.com>
 <20230621132840.7cf3e05f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230621132840.7cf3e05f@imammedo.users.ipa.redhat.com>
From: Joel Upham <jupham125@gmail.com>
Date: Wed, 21 Jun 2023 13:27:15 -0400
Message-ID: <CADPhr0=aAdnL28sA1BMc-g5fqF2+dioHVeK-rNmK+-fy_dHYXA@mail.gmail.com>
Subject: Re: [PATCH v1 03/23] q35/acpi/xen: Provide ACPI PCI hotplug interface
 for Xen on Q35
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000e4168c05fea7142f"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=jupham125@gmail.com; helo=mail-ed1-x531.google.com
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

--000000000000e4168c05fea7142f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 7:28=E2=80=AFAM Igor Mammedov <imammedo@redhat.com>=
 wrote:

> On Tue, 20 Jun 2023 13:24:37 -0400
> Joel Upham <jupham125@gmail.com> wrote:
>
> > This patch allows to use ACPI PCI hotplug functionality for Xen on Q35.
> > All added code depends on xen_enabled(), so no functionality change for
> > non-Xen usage.
> >
> > We need to call the acpi_set_pci_info function from ich9_pm_init as wel=
l,
> > so it was made globally visible again (as it was before).
>
> this patch is also likely obsolete
>

Ok, I can attempt removing it.

> >
> > Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
> > Signed-off-by: Joel Upham <jupham125@gmail.com>
> > ---
> >  hw/acpi/ich9.c          | 10 ++++++++++
> >  hw/acpi/pcihp.c         |  2 +-
> >  include/hw/acpi/pcihp.h |  2 ++
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> > index 25e2c7243e..1c236be1c7 100644
> > --- a/hw/acpi/ich9.c
> > +++ b/hw/acpi/ich9.c
> > @@ -39,6 +39,8 @@
> >  #include "hw/southbridge/ich9.h"
> >  #include "hw/mem/pc-dimm.h"
> >  #include "hw/mem/nvdimm.h"
> > +#include "hw/xen/xen.h"
> > +#include "sysemu/xen.h"
> >
> >  //#define DEBUG
> >
> > @@ -67,6 +69,10 @@ static void ich9_gpe_writeb(void *opaque, hwaddr
> addr, uint64_t val,
> >      ICH9LPCPMRegs *pm =3D opaque;
> >      acpi_gpe_ioport_writeb(&pm->acpi_regs, addr, val);
> >      acpi_update_sci(&pm->acpi_regs, pm->irq);
> > +
> > +    if (xen_enabled()) {
> > +        acpi_pcihp_reset(&pm->acpi_pci_hotplug);
> > +    }
> >  }
> >
> >  static const MemoryRegionOps ich9_gpe_ops =3D {
> > @@ -332,6 +338,10 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMReg=
s
> *pm, qemu_irq sci_irq)
> >      pm->powerdown_notifier.notify =3D pm_powerdown_req;
> >      qemu_register_powerdown_notifier(&pm->powerdown_notifier);
> >
> > +    if (xen_enabled()) {
> > +            acpi_set_pci_info(true);
> > +    }
> > +
> >      legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
> >          OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
> >
> > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > index f4e39d7a9c..5b065d670c 100644
> > --- a/hw/acpi/pcihp.c
> > +++ b/hw/acpi/pcihp.c
> > @@ -99,7 +99,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
> >      return info;
> >  }
> >
> > -static void acpi_set_pci_info(bool has_bridge_hotplug)
> > +void acpi_set_pci_info(bool has_bridge_hotplug)
> >  {
> >      static bool bsel_is_set;
> >      Object *host =3D acpi_get_i386_pci_host();
> > diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> > index ef59810c17..d35a517c9e 100644
> > --- a/include/hw/acpi/pcihp.h
> > +++ b/include/hw/acpi/pcihp.h
> > @@ -72,6 +72,8 @@ void
> acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> >  /* Called on reset */
> >  void acpi_pcihp_reset(AcpiPciHpState *s);
> >
> > +void acpi_set_pci_info(bool has_bridge_hotplug);
> > +
> >  void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus);
> >
> >  extern const VMStateDescription vmstate_acpi_pcihp_pci_status;
>
>

--000000000000e4168c05fea7142f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Wed, Jun 21, 2023 at 7:28=E2=80=AFAM Igor Mammedov &lt;<a hre=
f=3D"mailto:imammedo@redhat.com" target=3D"_blank">imammedo@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tu=
e, 20 Jun 2023 13:24:37 -0400<br>
Joel Upham &lt;<a href=3D"mailto:jupham125@gmail.com" target=3D"_blank">jup=
ham125@gmail.com</a>&gt; wrote:<br>
<br>
&gt; This patch allows to use ACPI PCI hotplug functionality for Xen on Q35=
.<br>
&gt; All added code depends on xen_enabled(), so no functionality change fo=
r<br>
&gt; non-Xen usage.<br>
&gt; <br>
&gt; We need to call the acpi_set_pci_info function from ich9_pm_init as we=
ll,<br>
&gt; so it was made globally visible again (as it was before).<br>
<br>
this patch is also likely obsolete <br>=C2=A0</blockquote><div>Ok, I can at=
tempt removing it. <br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
&gt; <br>
&gt; Signed-off-by: Alexey Gerasimenko &lt;x1917x@xxxxxxxxx&gt;<br>
&gt; Signed-off-by: Joel Upham &lt;<a href=3D"mailto:jupham125@gmail.com" t=
arget=3D"_blank">jupham125@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/acpi/ich9.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ++++++++++=
<br>
&gt;=C2=A0 hw/acpi/pcihp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br=
>
&gt;=C2=A0 include/hw/acpi/pcihp.h |=C2=A0 2 ++<br>
&gt;=C2=A0 3 files changed, 13 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c<br>
&gt; index 25e2c7243e..1c236be1c7 100644<br>
&gt; --- a/hw/acpi/ich9.c<br>
&gt; +++ b/hw/acpi/ich9.c<br>
&gt; @@ -39,6 +39,8 @@<br>
&gt;=C2=A0 #include &quot;hw/southbridge/ich9.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/mem/pc-dimm.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/mem/nvdimm.h&quot;<br>
&gt; +#include &quot;hw/xen/xen.h&quot;<br>
&gt; +#include &quot;sysemu/xen.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 //#define DEBUG<br>
&gt;=C2=A0 <br>
&gt; @@ -67,6 +69,10 @@ static void ich9_gpe_writeb(void *opaque, hwaddr ad=
dr, uint64_t val,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ICH9LPCPMRegs *pm =3D opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 acpi_gpe_ioport_writeb(&amp;pm-&gt;acpi_regs, addr=
, val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 acpi_update_sci(&amp;pm-&gt;acpi_regs, pm-&gt;irq)=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (xen_enabled()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_pcihp_reset(&amp;pm-&gt;acpi_pci_hot=
plug);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static const MemoryRegionOps ich9_gpe_ops =3D {<br>
&gt; @@ -332,6 +338,10 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRe=
gs *pm, qemu_irq sci_irq)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pm-&gt;powerdown_notifier.notify =3D pm_powerdown_=
req;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_register_powerdown_notifier(&amp;pm-&gt;power=
down_notifier);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (xen_enabled()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_set_pci_info(true);<br=
>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 legacy_acpi_cpu_hotplug_init(pci_address_space_io(=
lpc_pci),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OBJECT(lpc_pci), &amp;pm-&gt;gpe_cpu=
, ICH9_CPU_HOTPLUG_IO_BASE);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c<br>
&gt; index f4e39d7a9c..5b065d670c 100644<br>
&gt; --- a/hw/acpi/pcihp.c<br>
&gt; +++ b/hw/acpi/pcihp.c<br>
&gt; @@ -99,7 +99,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return info;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static void acpi_set_pci_info(bool has_bridge_hotplug)<br>
&gt; +void acpi_set_pci_info(bool has_bridge_hotplug)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 static bool bsel_is_set;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Object *host =3D acpi_get_i386_pci_host();<br>
&gt; diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h<br>
&gt; index ef59810c17..d35a517c9e 100644<br>
&gt; --- a/include/hw/acpi/pcihp.h<br>
&gt; +++ b/include/hw/acpi/pcihp.h<br>
&gt; @@ -72,6 +72,8 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHand=
ler *hotplug_dev,<br>
&gt;=C2=A0 /* Called on reset */<br>
&gt;=C2=A0 void acpi_pcihp_reset(AcpiPciHpState *s);<br>
&gt;=C2=A0 <br>
&gt; +void acpi_set_pci_info(bool has_bridge_hotplug);<br>
&gt; +<br>
&gt;=C2=A0 void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus);<b=
r>
&gt;=C2=A0 <br>
&gt;=C2=A0 extern const VMStateDescription vmstate_acpi_pcihp_pci_status;<b=
r>
<br>
</blockquote></div></div>

--000000000000e4168c05fea7142f--


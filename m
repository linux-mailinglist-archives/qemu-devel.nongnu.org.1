Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FAE738C3C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:49:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC11F-00074C-0O; Wed, 21 Jun 2023 12:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qC11C-00073n-QU
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:49:18 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qC11A-00080y-0Q
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:49:18 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51bdf6336d2so744769a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687366154; x=1689958154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HgbnY6Q6STwEL8TlZBTbtUT3Iq7Nv0s7MP/bko+bZvU=;
 b=ka5YuqqV0vQRS3Lt4iM0HOoUy9tHXnDRFeiiyjo8ZetKHZuj7l0fa7KzlcPK0OFDsP
 0mFwyCyX9/QQuKImvRWIraDpcpsceKkaiavBQQ3HrNL+H5QnU4c7I+opAg2ZrBSVowko
 wkkBE9xx689Qe7drNaq5fpIPHn32m3Gs9bRCqucgm9hzxYToxcugiDt19i85iGMXxaOv
 WMrfqggRsRvCa/K4D74yF/mE+f3Cs46DIS44E/PJZKgsgzeF3IUZLZtWzThNlnuep8ne
 kYImzX+0No1PDZ+FrdPfAvLDVQsN2/+sXPjbgOtiyG5hCcZwm8PKXTo79LIVxj2jv2y1
 roqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687366154; x=1689958154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HgbnY6Q6STwEL8TlZBTbtUT3Iq7Nv0s7MP/bko+bZvU=;
 b=EXei9I/BDBrP8E1xNypJVXwlIe7smrDYt2lZ7passtS3vDb6H39xLBgAy+FMudpTRN
 RDCAs6TPvOMGZUv0BLz36grPXlJvsridlPotDs4qPbAjke1o0Yjbml6/wl02B/vojNhT
 r7MJPhNPiEKNx3ZTxRkzyaOBo7zPEjrQdGytH1u8yB/jB80DICq8xF6Q2GHJvCl4eeWJ
 QNJBPU1UvdJrRPqjLb2zafbHelFaMdPhO+DUBK6No6bNpLpMZnaFk6+bG6IgJ4W6s8JE
 mHV+wtClYWEfE6EFkIYcD5A12kl5q7h20jkfPWgIiOIucecnvx/xrH0tUMaLlOCYNGvZ
 Q56A==
X-Gm-Message-State: AC+VfDwuo0z1LLmGqY9qP8or4LPEIlTWqIY/s4Om2rGpncVeG5wlnjph
 +sZk1z3idFSjgNOTt61ulFzxnBkb+iRYBUyEWSs=
X-Google-Smtp-Source: ACHHUZ6w34ErMCxy63b9vo61XuTwhs0fgJJglWPiTgu3qCibjoSzzND2W5pSgxdkw71AcXcEceWmJ+p7eeXFMn372nk=
X-Received: by 2002:aa7:c706:0:b0:51a:3fc2:f60f with SMTP id
 i6-20020aa7c706000000b0051a3fc2f60fmr8371411edq.42.1687366154019; Wed, 21 Jun
 2023 09:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687278381.git.jupham125@gmail.com>
 <1c547c5581ce6192b70c68f39de108cdb2c73f7e.1687278381.git.jupham125@gmail.com>
 <ZJKj9YQfOVzVXOno@redhat.com>
In-Reply-To: <ZJKj9YQfOVzVXOno@redhat.com>
From: Joel Upham <jupham125@gmail.com>
Date: Wed, 21 Jun 2023 12:49:03 -0400
Message-ID: <CADPhr0myn5XPcb1fkU4dNJ=bOjTJzEzDAyjhoTSM1qMht48BXw@mail.gmail.com>
Subject: Re: [PATCH v1 01/23] pc/xen: Xen Q35 support: provide IRQ handling
 for PCI devices
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000037653b05fea68c7f"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=jupham125@gmail.com; helo=mail-ed1-x536.google.com
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

--00000000000037653b05fea68c7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you, I was working off the Xen-devel and didn=E2=80=99t find his emai=
l. I
will update my qemu and xen patches for the next version.

-Joel

On Wed, Jun 21, 2023 at 3:17 AM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Tue, Jun 20, 2023 at 01:24:34PM -0400, Joel Upham wrote:
> >
> > Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
>
> This isn't a valid email address for Alexey - I presume you grabbed
> these patches from the xen-devel mail archives, which have mangled
> the addresses for anti-spam reasons.
>
> Fortunately there are alternative archives which don't mangle the
> patches:
>
>
> https://lore.kernel.org/xen-devel/6067bc3c91c9ee629a35723dfb474ef168ff4eb=
f.1520867955.git.x1917x@gmail.com/
>
>   Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
>
> This affects all patches in the series, but I won't repeat my
> comment on each one.
>
> > Signed-off-by: Joel Upham <jupham125@gmail.com>
> > ---
> >  hw/i386/pc_piix.c             |  3 +-
> >  hw/i386/xen/xen-hvm.c         |  7 +++--
> >  hw/isa/lpc_ich9.c             | 53 ++++++++++++++++++++++++++++++++---
> >  hw/isa/piix3.c                |  2 +-
> >  include/hw/southbridge/ich9.h |  1 +
> >  include/hw/xen/xen.h          |  4 +--
> >  stubs/xen-hw-stub.c           |  4 +--
> >  7 files changed, 61 insertions(+), 13 deletions(-)
> >
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index d5b0dcd1fe..8c1b20f3bc 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -62,6 +62,7 @@
> >  #endif
> >  #include "hw/xen/xen-x86.h"
> >  #include "hw/xen/xen.h"
> > +#include "sysemu/xen.h"
> >  #include "migration/global_state.h"
> >  #include "migration/misc.h"
> >  #include "sysemu/numa.h"
> > @@ -233,7 +234,7 @@ static void pc_init1(MachineState *machine,
> >                                x86ms->above_4g_mem_size,
> >                                pci_memory, ram_memory);
> >          pci_bus_map_irqs(pci_bus,
> > -                         xen_enabled() ? xen_pci_slot_get_pirq
> > +                         xen_enabled() ? xen_cmn_pci_slot_get_pirq
> >                                         : pc_pci_slot_get_pirq);
> >          pcms->bus =3D pci_bus;
> >
> > diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> > index 56641a550e..540ac46639 100644
> > --- a/hw/i386/xen/xen-hvm.c
> > +++ b/hw/i386/xen/xen-hvm.c
> > @@ -15,6 +15,7 @@
> >  #include "hw/pci/pci.h"
> >  #include "hw/pci/pci_host.h"
> >  #include "hw/i386/pc.h"
> > +#include "hw/southbridge/ich9.h"
> >  #include "hw/irq.h"
> >  #include "hw/hw.h"
> >  #include "hw/i386/apic-msidef.h"
> > @@ -136,14 +137,14 @@ typedef struct XenIOState {
> >      Notifier wakeup;
> >  } XenIOState;
> >
> > -/* Xen specific function for piix pci */
> > +/* Xen-specific functions for pci dev IRQ handling */
> >
> > -int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
> > +int xen_cmn_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
> >  {
> >      return irq_num + (PCI_SLOT(pci_dev->devfn) << 2);
> >  }
> >
> > -void xen_piix3_set_irq(void *opaque, int irq_num, int level)
> > +void xen_cmn_set_irq(void *opaque, int irq_num, int level)
> >  {
> >      xen_set_pci_intx_level(xen_domid, 0, 0, irq_num >> 2,
> >                             irq_num & 3, level);
> > diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> > index 9c47a2f6c7..733a99d443 100644
> > --- a/hw/isa/lpc_ich9.c
> > +++ b/hw/isa/lpc_ich9.c
> > @@ -51,6 +51,9 @@
> >  #include "hw/core/cpu.h"
> >  #include "hw/nvram/fw_cfg.h"
> >  #include "qemu/cutils.h"
> > +#include "hw/xen/xen.h"
> > +#include "sysemu/xen.h"
> > +#include "hw/southbridge/piix.h"
> >  #include "hw/acpi/acpi_aml_interface.h"
> >  #include "trace.h"
> >
> > @@ -535,11 +538,49 @@ static int ich9_lpc_post_load(void *opaque, int
> version_id)
> >      return 0;
> >  }
> >
> > +static void ich9_lpc_config_write_xen(PCIDevice *d,
> > +                                  uint32_t addr, uint32_t val, int len=
)
> > +{
> > +    static bool pirqe_f_warned =3D false;
> > +    if (ranges_overlap(addr, len, ICH9_LPC_PIRQA_ROUT, 4)) {
> > +        /* handle PIRQA..PIRQD routing */
> > +        /* Scan for updates to PCI link routes (0x60-0x63). */
> > +        int i;
> > +        for (i =3D 0; i < len; i++) {
> > +            uint8_t v =3D (val >> (8 * i)) & 0xff;
> > +            if (v & 0x80) {
> > +                v =3D 0;
> > +            }
> > +            v &=3D 0xf;
> > +            if (((addr + i) >=3D PIIX_PIRQCA) && ((addr + i) <=3D
> PIIX_PIRQCD)) {
> > +                xen_set_pci_link_route(addr + i - PIIX_PIRQCA, v);
> > +            }
> > +        }
> > +    } else if (ranges_overlap(addr, len, ICH9_LPC_PIRQE_ROUT, 4)) {
> > +        while (len--) {
> > +            if (range_covers_byte(ICH9_LPC_PIRQE_ROUT, 4, addr) &&
> > +                (val & 0x80) =3D=3D 0) {
> > +                /* print warning only once */
> > +                if (!pirqe_f_warned) {
> > +                    pirqe_f_warned =3D true;
> > +                    fprintf(stderr, "WARNING: guest domain attempted t=
o
> use PIRQ%c "
> > +                            "routing which is not supported for Xen/Q3=
5
> currently\n",
> > +                            (char)(addr - ICH9_LPC_PIRQE_ROUT + 'E'));
> > +                    break;
> > +                }
> > +            }
> > +            addr++, val >>=3D 8;
> > +        }
> > +    }
> > +}
> > +
> >  static void ich9_lpc_config_write(PCIDevice *d,
> >                                    uint32_t addr, uint32_t val, int len=
)
> >  {
> >      ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(d);
> >      uint32_t rcba_old =3D pci_get_long(d->config + ICH9_LPC_RCBA);
> > +    if (xen_enabled())
> > +        ich9_lpc_config_write_xen(d, addr, val, len);
> >
> >      pci_default_write_config(d, addr, val, len);
> >      if (ranges_overlap(addr, len, ICH9_LPC_PMBASE, 4) ||
> > @@ -731,10 +772,14 @@ static void ich9_lpc_realize(PCIDevice *d, Error
> **errp)
> >          return;
> >      }
> >
> > -    pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d, ICH9_LPC_NB_PIRQS);
> > -    pci_bus_map_irqs(pci_bus, ich9_lpc_map_irq);
> > -    pci_bus_set_route_irq_fn(pci_bus, ich9_route_intx_pin_to_irq);
> > -
> > +    if (xen_enabled()) {
> > +        pci_bus_irqs(pci_bus, xen_cmn_set_irq, d,
> ICH9_XEN_NUM_IRQ_SOURCES);
> > +        pci_bus_map_irqs(pci_bus, xen_cmn_pci_slot_get_pirq);
> > +    } else {
> > +        pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d, ICH9_LPC_NB_PIRQS);
> > +        pci_bus_map_irqs(pci_bus, ich9_lpc_map_irq);
> > +        pci_bus_set_route_irq_fn(pci_bus, ich9_route_intx_pin_to_irq);
> > +    }
> >      ich9_lpc_pm_init(lpc);
> >  }
> >
> > diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
> > index f9103ea45a..3d0545eb0e 100644
> > --- a/hw/isa/piix3.c
> > +++ b/hw/isa/piix3.c
> > @@ -420,7 +420,7 @@ static void piix3_xen_realize(PCIDevice *dev, Error
> **errp)
> >       * connected to the IOAPIC directly.
> >       * These additional routes can be discovered through ACPI.
> >       */
> > -    pci_bus_irqs(pci_bus, xen_piix3_set_irq, piix3, XEN_PIIX_NUM_PIRQS=
);
> > +    pci_bus_irqs(pci_bus, xen_cmn_set_irq, piix3, XEN_PIIX_NUM_PIRQS);
> >  }
> >
> >  static void piix3_xen_class_init(ObjectClass *klass, void *data)
> > diff --git a/include/hw/southbridge/ich9.h
> b/include/hw/southbridge/ich9.h
> > index fd01649d04..07b84d5227 100644
> > --- a/include/hw/southbridge/ich9.h
> > +++ b/include/hw/southbridge/ich9.h
> > @@ -130,6 +130,7 @@ struct ICH9LPCState {
> >
> >  #define ICH9_A2_LPC_REVISION                    0x2
> >  #define ICH9_LPC_NB_PIRQS                       8       /* PCI A-H */
> > +#define ICH9_XEN_NUM_IRQ_SOURCES                128
> >
> >  #define ICH9_LPC_PMBASE                         0x40
> >  #define ICH9_LPC_PMBASE_BASE_ADDRESS_MASK       ICH9_MASK(32, 15, 7)
> > diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> > index 2bd8ec742d..a2c3d98eaa 100644
> > --- a/include/hw/xen/xen.h
> > +++ b/include/hw/xen/xen.h
> > @@ -37,9 +37,9 @@ extern uint32_t xen_domid;
> >  extern enum xen_mode xen_mode;
> >  extern bool xen_domid_restrict;
> >
> > -int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
> > +int xen_cmn_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
> >  int xen_set_pci_link_route(uint8_t link, uint8_t irq);
> > -void xen_piix3_set_irq(void *opaque, int irq_num, int level);
> > +void xen_cmn_set_irq(void *opaque, int irq_num, int level);
> >  void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
> >  int xen_is_pirq_msi(uint32_t msi_data);
> >
> > diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c
> > index 34a22f2ad7..f06fbf48c8 100644
> > --- a/stubs/xen-hw-stub.c
> > +++ b/stubs/xen-hw-stub.c
> > @@ -10,12 +10,12 @@
> >  #include "hw/xen/xen.h"
> >  #include "hw/xen/xen-x86.h"
> >
> > -int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
> > +int xen_cmn_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
> >  {
> >      return -1;
> >  }
> >
> > -void xen_piix3_set_irq(void *opaque, int irq_num, int level)
> > +void xen_cmn_set_irq(void *opaque, int irq_num, int level)
> >  {
> >  }
> >
> > --
> > 2.34.1
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--00000000000037653b05fea68c7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thank you, I was working off the Xen-devel and didn=E2=80=
=99t find his email. I will update my qemu and xen patches for the next ver=
sion.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">-Joel</div><=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Wed, Jun 21, 2023 at 3:17 AM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto=
:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">On Tue, Jun 20, 2023 at 01:24:34PM -0400, Joel Upham =
wrote:<br>
&gt; <br>
&gt; Signed-off-by: Alexey Gerasimenko &lt;x1917x@xxxxxxxxx&gt;<br>
<br>
This isn&#39;t a valid email address for Alexey - I presume you grabbed<br>
these patches from the xen-devel mail archives, which have mangled<br>
the addresses for anti-spam reasons.<br>
<br>
Fortunately there are alternative archives which don&#39;t mangle the<br>
patches:<br>
<br>
=C2=A0 <a href=3D"https://lore.kernel.org/xen-devel/6067bc3c91c9ee629a35723=
dfb474ef168ff4ebf.1520867955.git.x1917x@gmail.com/" rel=3D"noreferrer" targ=
et=3D"_blank">https://lore.kernel.org/xen-devel/6067bc3c91c9ee629a35723dfb4=
74ef168ff4ebf.1520867955.git.x1917x@gmail.com/</a><br>
<br>
=C2=A0 Signed-off-by: Alexey Gerasimenko &lt;<a href=3D"mailto:x1917x@gmail=
.com" target=3D"_blank">x1917x@gmail.com</a>&gt;<br>
<br>
This affects all patches in the series, but I won&#39;t repeat my<br>
comment on each one.<br>
<br>
&gt; Signed-off-by: Joel Upham &lt;<a href=3D"mailto:jupham125@gmail.com" t=
arget=3D"_blank">jupham125@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/i386/pc_piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 3 +-<br>
&gt;=C2=A0 hw/i386/xen/xen-hvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7=
 +++--<br>
&gt;=C2=A0 hw/isa/lpc_ich9.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 53 ++++++++++++++++++++++++++++++++---<br>
&gt;=C2=A0 hw/isa/piix3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 include/hw/southbridge/ich9.h |=C2=A0 1 +<br>
&gt;=C2=A0 include/hw/xen/xen.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4=
 +--<br>
&gt;=C2=A0 stubs/xen-hw-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 +--<br>
&gt;=C2=A0 7 files changed, 61 insertions(+), 13 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c<br>
&gt; index d5b0dcd1fe..8c1b20f3bc 100644<br>
&gt; --- a/hw/i386/pc_piix.c<br>
&gt; +++ b/hw/i386/pc_piix.c<br>
&gt; @@ -62,6 +62,7 @@<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 #include &quot;hw/xen/xen-x86.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/xen/xen.h&quot;<br>
&gt; +#include &quot;sysemu/xen.h&quot;<br>
&gt;=C2=A0 #include &quot;migration/global_state.h&quot;<br>
&gt;=C2=A0 #include &quot;migration/misc.h&quot;<br>
&gt;=C2=A0 #include &quot;sysemu/numa.h&quot;<br>
&gt; @@ -233,7 +234,7 @@ static void pc_init1(MachineState *machine,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x86ms-&gt;above_4g_mem_size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_memory, ram_memory);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_bus_map_irqs(pci_bus,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0xen_enabled() ? xen_pci_slot_get_pirq<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0xen_enabled() ? xen_cmn_pci_slot_get_pirq<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0: pc_pci_slot_get_pirq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcms-&gt;bus =3D pci_bus;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c<br>
&gt; index 56641a550e..540ac46639 100644<br>
&gt; --- a/hw/i386/xen/xen-hvm.c<br>
&gt; +++ b/hw/i386/xen/xen-hvm.c<br>
&gt; @@ -15,6 +15,7 @@<br>
&gt;=C2=A0 #include &quot;hw/pci/pci.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/pci/pci_host.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/i386/pc.h&quot;<br>
&gt; +#include &quot;hw/southbridge/ich9.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/irq.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/hw.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/i386/apic-msidef.h&quot;<br>
&gt; @@ -136,14 +137,14 @@ typedef struct XenIOState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Notifier wakeup;<br>
&gt;=C2=A0 } XenIOState;<br>
&gt;=C2=A0 <br>
&gt; -/* Xen specific function for piix pci */<br>
&gt; +/* Xen-specific functions for pci dev IRQ handling */<br>
&gt;=C2=A0 <br>
&gt; -int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)<br>
&gt; +int xen_cmn_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return irq_num + (PCI_SLOT(pci_dev-&gt;devfn) &lt;=
&lt; 2);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -void xen_piix3_set_irq(void *opaque, int irq_num, int level)<br>
&gt; +void xen_cmn_set_irq(void *opaque, int irq_num, int level)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 xen_set_pci_intx_level(xen_domid, 0, 0, irq_num &g=
t;&gt; 2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_num &amp; 3, level);<br>
&gt; diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c<br>
&gt; index 9c47a2f6c7..733a99d443 100644<br>
&gt; --- a/hw/isa/lpc_ich9.c<br>
&gt; +++ b/hw/isa/lpc_ich9.c<br>
&gt; @@ -51,6 +51,9 @@<br>
&gt;=C2=A0 #include &quot;hw/core/cpu.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/nvram/fw_cfg.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/cutils.h&quot;<br>
&gt; +#include &quot;hw/xen/xen.h&quot;<br>
&gt; +#include &quot;sysemu/xen.h&quot;<br>
&gt; +#include &quot;hw/southbridge/piix.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/acpi/acpi_aml_interface.h&quot;<br>
&gt;=C2=A0 #include &quot;trace.h&quot;<br>
&gt;=C2=A0 <br>
&gt; @@ -535,11 +538,49 @@ static int ich9_lpc_post_load(void *opaque, int =
version_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void ich9_lpc_config_write_xen(PCIDevice *d,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t addr, uint32_t v=
al, int len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 static bool pirqe_f_warned =3D false;<br>
&gt; +=C2=A0 =C2=A0 if (ranges_overlap(addr, len, ICH9_LPC_PIRQA_ROUT, 4)) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* handle PIRQA..PIRQD routing */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Scan for updates to PCI link routes (0=
x60-0x63). */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; len; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t v =3D (val &gt;&gt;=
 (8 * i)) &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (v &amp; 0x80) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v &amp;=3D 0xf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((addr + i) &gt;=3D PII=
X_PIRQCA) &amp;&amp; ((addr + i) &lt;=3D PIIX_PIRQCD)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xen_set_pci_l=
ink_route(addr + i - PIIX_PIRQCA, v);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else if (ranges_overlap(addr, len, ICH9_LPC_PIRQE_ROU=
T, 4)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (len--) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (range_covers_byte(ICH9_=
LPC_PIRQE_ROUT, 4, addr) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (val &amp; 0x=
80) =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* print warn=
ing only once */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pirqe_f_=
warned) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 pirqe_f_warned =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 fprintf(stderr, &quot;WARNING: guest domain attempted to use PIRQ%c &quot;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;routing which is not supported for Xen/Q=
35 currently\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (char)(addr - ICH9_LPC_PIRQE_ROUT + &#39;E&#39=
;));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr++, val &gt;&gt;=3D 8;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void ich9_lpc_config_write(PCIDevice *d,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t addr, uint=
32_t val, int len)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(d);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t rcba_old =3D pci_get_long(d-&gt;config + =
ICH9_LPC_RCBA);<br>
&gt; +=C2=A0 =C2=A0 if (xen_enabled())<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ich9_lpc_config_write_xen(d, addr, val, l=
en);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 pci_default_write_config(d, addr, val, len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ranges_overlap(addr, len, ICH9_LPC_PMBASE, 4) =
||<br>
&gt; @@ -731,10 +772,14 @@ static void ich9_lpc_realize(PCIDevice *d, Error=
 **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d, ICH9_LPC_NB_=
PIRQS);<br>
&gt; -=C2=A0 =C2=A0 pci_bus_map_irqs(pci_bus, ich9_lpc_map_irq);<br>
&gt; -=C2=A0 =C2=A0 pci_bus_set_route_irq_fn(pci_bus, ich9_route_intx_pin_t=
o_irq);<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 if (xen_enabled()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_bus_irqs(pci_bus, xen_cmn_set_irq, d,=
 ICH9_XEN_NUM_IRQ_SOURCES);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_bus_map_irqs(pci_bus, xen_cmn_pci_slo=
t_get_pirq);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d=
, ICH9_LPC_NB_PIRQS);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_bus_map_irqs(pci_bus, ich9_lpc_map_ir=
q);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_bus_set_route_irq_fn(pci_bus, ich9_ro=
ute_intx_pin_to_irq);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ich9_lpc_pm_init(lpc);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c<br>
&gt; index f9103ea45a..3d0545eb0e 100644<br>
&gt; --- a/hw/isa/piix3.c<br>
&gt; +++ b/hw/isa/piix3.c<br>
&gt; @@ -420,7 +420,7 @@ static void piix3_xen_realize(PCIDevice *dev, Erro=
r **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* connected to the IOAPIC directly.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* These additional routes can be discovered =
through ACPI.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 pci_bus_irqs(pci_bus, xen_piix3_set_irq, piix3, XEN_PII=
X_NUM_PIRQS);<br>
&gt; +=C2=A0 =C2=A0 pci_bus_irqs(pci_bus, xen_cmn_set_irq, piix3, XEN_PIIX_=
NUM_PIRQS);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void piix3_xen_class_init(ObjectClass *klass, void *data)=
<br>
&gt; diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ic=
h9.h<br>
&gt; index fd01649d04..07b84d5227 100644<br>
&gt; --- a/include/hw/southbridge/ich9.h<br>
&gt; +++ b/include/hw/southbridge/ich9.h<br>
&gt; @@ -130,6 +130,7 @@ struct ICH9LPCState {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define ICH9_A2_LPC_REVISION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2<br>
&gt;=C2=A0 #define ICH9_LPC_NB_PIRQS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 PCI A-H */<br>
&gt; +#define ICH9_XEN_NUM_IRQ_SOURCES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 128<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define ICH9_LPC_PMBASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x40<br>
&gt;=C2=A0 #define ICH9_LPC_PMBASE_BASE_ADDRESS_MASK=C2=A0 =C2=A0 =C2=A0 =
=C2=A0ICH9_MASK(32, 15, 7)<br>
&gt; diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h<br>
&gt; index 2bd8ec742d..a2c3d98eaa 100644<br>
&gt; --- a/include/hw/xen/xen.h<br>
&gt; +++ b/include/hw/xen/xen.h<br>
&gt; @@ -37,9 +37,9 @@ extern uint32_t xen_domid;<br>
&gt;=C2=A0 extern enum xen_mode xen_mode;<br>
&gt;=C2=A0 extern bool xen_domid_restrict;<br>
&gt;=C2=A0 <br>
&gt; -int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);<br>
&gt; +int xen_cmn_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);<br>
&gt;=C2=A0 int xen_set_pci_link_route(uint8_t link, uint8_t irq);<br>
&gt; -void xen_piix3_set_irq(void *opaque, int irq_num, int level);<br>
&gt; +void xen_cmn_set_irq(void *opaque, int irq_num, int level);<br>
&gt;=C2=A0 void xen_hvm_inject_msi(uint64_t addr, uint32_t data);<br>
&gt;=C2=A0 int xen_is_pirq_msi(uint32_t msi_data);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/stubs/xen-hw-stub.c b/stubs/xen-hw-stub.c<br>
&gt; index 34a22f2ad7..f06fbf48c8 100644<br>
&gt; --- a/stubs/xen-hw-stub.c<br>
&gt; +++ b/stubs/xen-hw-stub.c<br>
&gt; @@ -10,12 +10,12 @@<br>
&gt;=C2=A0 #include &quot;hw/xen/xen.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/xen/xen-x86.h&quot;<br>
&gt;=C2=A0 <br>
&gt; -int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)<br>
&gt; +int xen_cmn_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -void xen_piix3_set_irq(void *opaque, int irq_num, int level)<br>
&gt; +void xen_cmn_set_irq(void *opaque, int irq_num, int level)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -- <br>
&gt; 2.34.1<br>
&gt; <br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div>

--00000000000037653b05fea68c7f--


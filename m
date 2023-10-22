Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B65CC7D220C
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:19:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUbw-0006BP-N4; Sun, 22 Oct 2023 05:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quUbt-0006B9-PV
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:19:01 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quUbr-0007wV-Kp
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:19:01 -0400
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so6979313a12.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966338; x=1698571138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F13wbX4Z12wrWcyLid1TJ2QAnyD8a02io7TDxPwN3fk=;
 b=AbSz9fWXKqJJXfhGwy71hl0et7RQzpF/NrgCACWnkmwb9lu0f7LrwNDQmnrsAJ9TZQ
 ubHcREcGATpX+KXFBQeBsDRge3wJGUJmFiICILv0yI7LszDrg182m6YGX+Pud3NHzlGF
 pFarSpIduFouKlJiwhDpzJugoaPBVed2hCx9VaEHQ29yUT72Nv6S/VtznAFwSePVbSs+
 I9hYWjHWwLg4WkaaeKQQr1rq8ufw0c+SJSP04Tj6/O8KCDOjIDr3QEaZncRxIdHBfSpE
 AaRy/DFDdKPjGaqH3eauwOqx+JZxw5pOLJ8HbqBzmrw6LNuC9G6gMtMszcZ1/HXa/AQk
 nOpg==
X-Gm-Message-State: AOJu0YzWDujNOzC8VTmnDUFCHqEMffZaVgP01EunZ92PaSzJJ0rTejuT
 YJGJ16yYQt3sgdifUltKDPA=
X-Google-Smtp-Source: AGHT+IHcSlKdYokxve9G7zx/hhXrkzd8bTiyquFd/zSCUvHn+OAFBnVNEN+K4o/5MAnlSPY81fJSoQ==
X-Received: by 2002:a17:907:7e8d:b0:9bb:a243:e6fb with SMTP id
 qb13-20020a1709077e8d00b009bba243e6fbmr4511633ejc.3.1697966337497; 
 Sun, 22 Oct 2023 02:18:57 -0700 (PDT)
Received: from fedora (ip-109-43-176-141.web.vodafone.de. [109.43.176.141])
 by smtp.gmail.com with ESMTPSA id
 jy20-20020a170907763400b009b97d9ae329sm4805451ejc.198.2023.10.22.02.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:18:57 -0700 (PDT)
Date: Sun, 22 Oct 2023 11:18:55 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 1/6] hw/m68k/irqc: Pass CPU using QOM link property
Message-ID: <20231022111855.0411838c@fedora>
In-Reply-To: <20231020150627.56893-2-philmd@linaro.org>
References: <20231020150627.56893-1-philmd@linaro.org>
 <20231020150627.56893-2-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.44; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f44.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Fri, 20 Oct 2023 17:06:21 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> Avoid the interrupt controller directly access the 'first_cpu'
> global. Pass it from the board code.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/intc/m68k_irqc.h |  1 +
>  hw/intc/m68k_irqc.c         | 10 +++++++++-
>  hw/m68k/virt.c              |  2 ++
>  3 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/intc/m68k_irqc.h b/include/hw/intc/m68k_irqc.h
> index ef91f21812..693e33b0aa 100644
> --- a/include/hw/intc/m68k_irqc.h
> +++ b/include/hw/intc/m68k_irqc.h
> @@ -33,6 +33,7 @@ typedef struct M68KIRQCState {
>      SysBusDevice parent_obj;
> =20
>      uint8_t ipr;
> +    ArchCPU *cpu;
> =20
>      /* statistics */
>      uint64_t stats_irq_count[M68K_IRQC_LEVEL_NUM];
> diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
> index 0c515e4ecb..e09705eeaf 100644
> --- a/hw/intc/m68k_irqc.c
> +++ b/hw/intc/m68k_irqc.c
> @@ -11,6 +11,7 @@
>  #include "cpu.h"
>  #include "migration/vmstate.h"
>  #include "monitor/monitor.h"
> +#include "hw/qdev-properties.h"
>  #include "hw/nmi.h"
>  #include "hw/intc/intc.h"
>  #include "hw/intc/m68k_irqc.h"
> @@ -35,7 +36,7 @@ static void m68k_irqc_print_info(InterruptStatsProvider=
 *obj, Monitor *mon)
>  static void m68k_set_irq(void *opaque, int irq, int level)
>  {
>      M68KIRQCState *s =3D opaque;
> -    M68kCPU *cpu =3D M68K_CPU(first_cpu);
> +    M68kCPU *cpu =3D M68K_CPU(s->cpu);
>      int i;
> =20
>      if (level) {
> @@ -85,12 +86,19 @@ static const VMStateDescription vmstate_m68k_irqc =3D=
 {
>      }
>  };
> =20
> +static Property m68k_irqc_properties[] =3D {
> +    DEFINE_PROP_LINK("m68k-cpu", M68KIRQCState, cpu,
> +                     TYPE_M68K_CPU, ArchCPU *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void m68k_irqc_class_init(ObjectClass *oc, void *data)
>   {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
>      NMIClass *nc =3D NMI_CLASS(oc);
>      InterruptStatsProviderClass *ic =3D INTERRUPT_STATS_PROVIDER_CLASS(o=
c);
> =20
> +    device_class_set_props(dc, m68k_irqc_properties);
>      nc->nmi_monitor_handler =3D m68k_nmi;
>      dc->reset =3D m68k_irqc_reset;
>      dc->vmsd =3D &vmstate_m68k_irqc;
> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
> index 2dd3c99894..da35e74bd9 100644
> --- a/hw/m68k/virt.c
> +++ b/hw/m68k/virt.c
> @@ -155,6 +155,8 @@ static void virt_init(MachineState *machine)
>      /* IRQ Controller */
> =20
>      irqc_dev =3D qdev_new(TYPE_M68K_IRQC);
> +    object_property_set_link(OBJECT(irqc_dev), "m68k-cpu",
> +                             OBJECT(first_cpu), &error_abort);

I'd rather use the local variable "cpu" instead of "first_cpu" here.

Apart from that:
Reviewed-by: Thomas Huth <huth@tuxfamily.org>



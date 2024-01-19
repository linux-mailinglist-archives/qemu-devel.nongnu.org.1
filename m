Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6947C83295D
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 13:07:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnda-0001e2-Rg; Fri, 19 Jan 2024 07:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQndM-0001c9-4R
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 07:06:06 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQndJ-0002dk-I9
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 07:06:03 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e9fd483e2so2877435e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 04:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705665959; x=1706270759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvWej7bqp2tBvdbO5jG2VETcBqegge3qAm1efvItTO8=;
 b=JOu6EPCioSAPu3lo+wm6vX/j6aS2Ek0156YTEDmM6PJJXOgMaZ9XVV5Ii1VhfkmHmj
 alKjdLTDkmkAyrZ1YeTK/uSnD2CZjdVmSROVX0Kkgn0MFCqNkdtp7a1INvo0EiEI6nWm
 x71GF1DIU6QSDkZKrlglZueFnT9ntXRi0ZChe3GYy4tkj4QcRSWTdY6TL2llVlOT+HyT
 Ov8N2Pi0aE2Wq8B1Ko/U3ktWeuUjbKAqaGj+LA/b3+/NJJ1Hat/k9wHoHnjuEuVX9inY
 sRdDEFSMIDZK5bHpQUnQ57oC/XN49Jf2J78QRTJqLDZKbbouAdCri3zkVYhQOhcSK45h
 mDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705665959; x=1706270759;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CvWej7bqp2tBvdbO5jG2VETcBqegge3qAm1efvItTO8=;
 b=BsVNuE/czRmVeXSQXBxgCRqbhnkH/b27ATYbVzK1sRUuEKfLQdoIWzNi5VnJXFlwpZ
 cwEtXar5Ona9UEEFx7PjCTiZotjIuUB0GMcXzLnl/SK4/FuU0zdNdR1tKFVhZ57Sdew7
 CNhZ2gPiYPsc04EfT+Mx05RDJPMvIQGdyK30ngWGq80EYxQSWV/6cA5tfM88g8QS5ij+
 DN8cmoXoQQmznIjOk17b02LpSLgzC7DS3tLLSBByTMWW5wG3Uc0BHE2W8z06Cfce64PV
 N/b+1WR2+R91jr/1TIn9+c3z/WYdOK1UoVgJW0ssTi1Ri0f8Jzz7H72ym6qNCAgEnVTk
 mdTQ==
X-Gm-Message-State: AOJu0YwQl0qlXk5b07NooLty/wOhj9uMk2BMjA1nCoM+jzBHciGrxSNT
 caBiJD83hXPWEasD6vlUBUXh+cGjCEM6Fx/s+q3uwNK0XNJoc7hj+kBAYghNNHk=
X-Google-Smtp-Source: AGHT+IF8zEmIotHS7lvz2gq00EFG1CWQSxNDUA7u07UNLyIbyNq9MTJYWrVPJN/z1eqfjzb6qp/cgw==
X-Received: by 2002:a05:600c:4fc4:b0:40e:88b2:922a with SMTP id
 o4-20020a05600c4fc400b0040e88b2922amr1495129wmq.127.1705665959416; 
 Fri, 19 Jan 2024 04:05:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f12-20020adfb60c000000b00336b8461a5esm6331586wre.88.2024.01.19.04.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 04:05:59 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BD6095F8C8;
 Fri, 19 Jan 2024 12:05:58 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-arm@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/6] hw/arm/xen_arm.c: convert DPRINTF to tracepoints
In-Reply-To: <49905a0d22aa80956645d6dd74e9bc098c56555b.1705662313.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Fri, 19 Jan 2024 13:14:21 +0200")
References: <cover.1705662313.git.manos.pitsidianakis@linaro.org>
 <49905a0d22aa80956645d6dd74e9bc098c56555b.1705662313.git.manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 19 Jan 2024 12:05:58 +0000
Message-ID: <87jzo5fryx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Tracing DPRINTFs to stderr might not be desired. A developer that relies
> on tracepoints should be able to opt-in to each tracepoint and rely on
> QEMU's log redirection, instead of stderr by default.
>
> This commit converts DPRINTFs in this file that are used for tracing
> into tracepoints.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/arm/trace-events |  7 +++++++
>  hw/arm/xen_arm.c    | 26 +++++++++++++++-----------
>  2 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index a6a67d5f16..e3f5d677d7 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -81,3 +81,10 @@ strongarm_ssp_read(uint64_t addr) "Bad register 0x%zu"
>  strongarm_ssp_write_wrong_data_size(int v) "Wrong data size: %i bits"
>  strongarm_ssp_write_wrong_data_size_invalid(void) "Attempt to use SSP LB=
M mode"
>  strongarm_ssp_write_bad_register(uint64_t addr) "Bad register 0x%zu"
> +
> +# xen_arm.c
> +xen_create_virtio_mmio_devices(int i, int irq, uint64_t base) "Created v=
irtio-mmio device %d: irq %d base 0x%lx"
> +xen_init_ram(const char *hi_xor_low, uint64_t base, uint64_t size) "Init=
ialized region xen.ram.%s: base 0x%lx size 0x%lx"
> +xen_enable_tpm_not_found(void) "Couldn't find tmp0 backend"
> +xen_enable_tpm(uint64_t addr) "Connected tpmdev at address 0x%lx"
> +xen_arm_init(const char *msg) "%s"
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index a5631529d0..a024117d22 100644
> --- a/hw/arm/xen_arm.c
> +++ b/hw/arm/xen_arm.c
> @@ -34,6 +34,7 @@
>  #include "hw/xen/xen-hvm-common.h"
>  #include "sysemu/tpm.h"
>  #include "hw/xen/arch_hvm.h"
> +#include "trace.h"
>=20=20
>  #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
>  OBJECT_DECLARE_SIMPLE_TYPE(XenArmState, XEN_ARM)
> @@ -91,8 +92,9 @@ static void xen_create_virtio_mmio_devices(XenArmState =
*xam)
>=20=20
>          sysbus_create_simple("virtio-mmio", base, irq);
>=20=20
> -        DPRINTF("Created virtio-mmio device %d: irq %d base 0x%lx\n",
> -                i, GUEST_VIRTIO_MMIO_SPI_FIRST + i, base);
> +        trace_xen_create_virtio_mmio_devices(i,
> +                                             GUEST_VIRTIO_MMIO_SPI_FIRST=
 + i,
> +                                             base);
>      }
>  }
>=20=20
> @@ -117,15 +119,13 @@ static void xen_init_ram(MachineState *machine)
>      memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo", &ram_memory,
>                               GUEST_RAM0_BASE, ram_size[0]);
>      memory_region_add_subregion(sysmem, GUEST_RAM0_BASE, &ram_lo);
> -    DPRINTF("Initialized region xen.ram.lo: base 0x%llx size 0x%lx\n",
> -            GUEST_RAM0_BASE, ram_size[0]);
> +    trace_xen_init_ram("lo", GUEST_RAM0_BASE, ram_size[0]);
>=20=20
>      if (ram_size[1] > 0) {
>          memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi", &ram_memor=
y,
>                                   GUEST_RAM1_BASE, ram_size[1]);
>          memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
> -        DPRINTF("Initialized region xen.ram.hi: base 0x%llx size 0x%lx\n=
",
> -                GUEST_RAM1_BASE, ram_size[1]);
> +        trace_xen_init_ram("hi", GUEST_RAM1_BASE, ram_size[1]);
>      }

I wonder if a single trace_xen_init_ram(machine->ram_size) at the top
would be better as everything can be inferred from that.

>  }
>=20=20
> @@ -158,7 +158,7 @@ static void xen_enable_tpm(XenArmState *xam)
>=20=20
>      TPMBackend *be =3D qemu_find_tpm_be("tpm0");
>      if (be =3D=3D NULL) {
> -        DPRINTF("Couldn't fine the backend for tpm0\n");
> +        trace_xen_enable_tpm_not_found();

This smells like it should be an error_report (or maybe warn_report) as
its a misconfiguration the user/tools should know about.

>          return;
>      }
>      dev =3D qdev_new(TYPE_TPM_TIS_SYSBUS);
> @@ -168,7 +168,7 @@ static void xen_enable_tpm(XenArmState *xam)
>      sysbus_realize_and_unref(busdev, &error_fatal);
>      sysbus_mmio_map(busdev, 0, xam->cfg.tpm_base_addr);
>=20=20
> -    DPRINTF("Connected tpmdev at address 0x%lx\n", xam->cfg.tpm_base_add=
r);
> +    trace_xen_enable_tpm(xam->cfg.tpm_base_addr);
>  }
>  #endif
>=20=20
> @@ -179,8 +179,11 @@ static void xen_arm_init(MachineState *machine)
>      xam->state =3D  g_new0(XenIOState, 1);
>=20=20
>      if (machine->ram_size =3D=3D 0) {
> -        DPRINTF("ram_size not specified. QEMU machine started without IO=
REQ"
> -                "(no emulated devices including Virtio)\n");
> +        trace_xen_arm_init("ram_size not specified. "
> +                           "QEMU machine started "
> +                           "without IOREQ "
> +                           "(no emulated devices"
> +                           "including Virtio)");

again at least an warn_report...

>          return;
>      }
>=20=20
> @@ -194,7 +197,8 @@ static void xen_arm_init(MachineState *machine)
>      if (xam->cfg.tpm_base_addr) {
>          xen_enable_tpm(xam);
>      } else {
> -        DPRINTF("tpm-base-addr is not provided. TPM will not be enabled\=
n");
> +        trace_xen_arm_init("tpm-base-addr is not provided."
> +                           "TPM will not be enabled");

warn_report.

>      }
>  #endif
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


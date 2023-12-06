Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 082F7806346
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 01:14:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAfWz-00028U-G6; Tue, 05 Dec 2023 19:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rAfWo-00027z-M0; Tue, 05 Dec 2023 19:12:40 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rAfWm-0005hE-LL; Tue, 05 Dec 2023 19:12:38 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54cfb03f1a8so2306181a12.2; 
 Tue, 05 Dec 2023 16:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701821552; x=1702426352; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tW6Cd12MXB5PCxO+UaaPdPzClXdA9Q9EfHV9KZoB9+I=;
 b=dROR4/GOWLW4D7bUDvhVerNqymgtGjzGS3izx5OCEm3m4we9f1kkoHMF47rxdTDM5k
 MgF5fM/Rn9WbPmE7gIMVGykfE3PN+rLbG50QBbTJHBsv2m6auVvv4HY+FKXHzT0eLh1r
 z5fGXUIvmH0M5PjjsSWNCdwCCc/lbenswXqr4f27c/671ZuwiX2x9UGo2KLLEx2tCFTd
 ozakrkdlJIKJAwnPFUTi9NRJ2LSh9f5wCsmZddKpd8EcpLcPtIk1GbSTFqygPwUDdEIM
 gsNOCLQfsoFxrpjYhmFl56BmF3LDlZ/dIbWko0W7ag4rKyRxXv97kjVnW16DliEfBSVH
 Z3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701821552; x=1702426352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tW6Cd12MXB5PCxO+UaaPdPzClXdA9Q9EfHV9KZoB9+I=;
 b=RkL9aOWCE4VXLFp+Pbhtu0qFnAt2G0+CDUqQ9O7ODqPwGKkfxgO2pS9QwJcT1tT+Y9
 u84Mtg9Cm7ZR3p0JTZbu76cpeG9p17RimcT82YPqCVTtxU50CzokG2f2NOfg07vZpUxu
 Fh/Vjx4dMuGyTTl4Cnq/Nq+Anpx/jBYvS4tj8S5nDf4O90tUjU7xm3QQiYTLn1ZudbG6
 f10EfHmPV89cJIqGXmv+EKJEDfvOWYRURXDGc97L3+g1kf3xuF1Tf/Yc1kRs2/K0j8rg
 xGzJc+eXghpnTA4aSpP8QxnYqO/YL1OC4vOO3KMSKOOSwPYwpIfMbM4+roNOOfDHHsDt
 RTng==
X-Gm-Message-State: AOJu0YwpmMQPtLo5XjmzvQykzNFV6wTIqoOYUdtGANRVwghOpYOxk19I
 qLAYKMGg2uMKlVqMwKSfB8vL4Nfrf6aulGX0pF8=
X-Google-Smtp-Source: AGHT+IG6V3fUP4vQaxP/tPY+f6H1OrVCh8YJ/nToyjq6ABSs0CB4Ws6FGBPpavoVdqcltY4IXuAgvUXAns2nAqvClOM=
X-Received: by 2002:a50:d79b:0:b0:54c:6e99:1b27 with SMTP id
 w27-20020a50d79b000000b0054c6e991b27mr66425edi.23.1701821552147; Tue, 05 Dec
 2023 16:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20231117071704.35040-1-philmd@linaro.org>
 <20231117071704.35040-3-philmd@linaro.org>
In-Reply-To: <20231117071704.35040-3-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Dec 2023 10:12:04 +1000
Message-ID: <CAKmqyKOkbo7chHmupT+Sp8phJcoLNSTysrbcKarmV0EQX3+nbw@mail.gmail.com>
Subject: Re: [PATCH-for-8.2? v2 2/4] hw/arm/stm32f405: Report error when
 incorrect CPU is used
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Igor Mammedov <imammedo@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Felipe Balbi <balbi@kernel.org>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Alistair Francis <alistair@alistair23.me>, Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Nov 17, 2023 at 5:18=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Both 'netduinoplus2' and 'olimex-stm32-h405' machines ignore the
> CPU type requested by the command line. This might confuse users,
> since the following will create a machine with a Cortex-M4 CPU:
>
>   $ qemu-system-aarch64 -M netduinoplus2 -cpu cortex-r5f
>
> Set the MachineClass::valid_cpu_types field (introduced in commit
> c9cf636d48 "machine: Add a valid_cpu_types property").
> Remove the now unused MachineClass::default_cpu_type field.
>
> We now get:
>
>   $ qemu-system-aarch64 -M netduinoplus2 -cpu cortex-r5f
>   qemu-system-aarch64: Invalid CPU type: cortex-r5f-arm-cpu
>   The valid types are: cortex-m4-arm-cpu
>
> Since the SoC family can only use Cortex-M4 CPUs, hard-code the
> CPU type name at the SoC level, removing the QOM property
> entirely.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/arm/stm32f405_soc.h | 4 ----
>  hw/arm/netduinoplus2.c         | 7 ++++++-
>  hw/arm/olimex-stm32-h405.c     | 8 ++++++--
>  hw/arm/stm32f405_soc.c         | 8 +-------
>  4 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/include/hw/arm/stm32f405_soc.h b/include/hw/arm/stm32f405_so=
c.h
> index c968ce3ab2..d15c03c4b5 100644
> --- a/include/hw/arm/stm32f405_soc.h
> +++ b/include/hw/arm/stm32f405_soc.h
> @@ -51,11 +51,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(STM32F405State, STM32F405_S=
OC)
>  #define CCM_SIZE (64 * 1024)
>
>  struct STM32F405State {
> -    /*< private >*/
>      SysBusDevice parent_obj;
> -    /*< public >*/
> -
> -    char *cpu_type;
>
>      ARMv7MState armv7m;
>
> diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
> index 515c081605..2e58984947 100644
> --- a/hw/arm/netduinoplus2.c
> +++ b/hw/arm/netduinoplus2.c
> @@ -44,7 +44,6 @@ static void netduinoplus2_init(MachineState *machine)
>      clock_set_hz(sysclk, SYSCLK_FRQ);
>
>      dev =3D qdev_new(TYPE_STM32F405_SOC);
> -    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4")=
);
>      qdev_connect_clock_in(dev, "sysclk", sysclk);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
> @@ -55,8 +54,14 @@ static void netduinoplus2_init(MachineState *machine)
>
>  static void netduinoplus2_machine_init(MachineClass *mc)
>  {
> +    static const char * const valid_cpu_types[] =3D {
> +        ARM_CPU_TYPE_NAME("cortex-m4"),
> +        NULL
> +    };
> +
>      mc->desc =3D "Netduino Plus 2 Machine (Cortex-M4)";
>      mc->init =3D netduinoplus2_init;
> +    mc->valid_cpu_types =3D valid_cpu_types;
>  }
>
>  DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
> diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
> index 3aa61c91b7..d793de7c97 100644
> --- a/hw/arm/olimex-stm32-h405.c
> +++ b/hw/arm/olimex-stm32-h405.c
> @@ -47,7 +47,6 @@ static void olimex_stm32_h405_init(MachineState *machin=
e)
>      clock_set_hz(sysclk, SYSCLK_FRQ);
>
>      dev =3D qdev_new(TYPE_STM32F405_SOC);
> -    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4")=
);
>      qdev_connect_clock_in(dev, "sysclk", sysclk);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
> @@ -58,9 +57,14 @@ static void olimex_stm32_h405_init(MachineState *machi=
ne)
>
>  static void olimex_stm32_h405_machine_init(MachineClass *mc)
>  {
> +    static const char * const valid_cpu_types[] =3D {
> +        ARM_CPU_TYPE_NAME("cortex-m4"),
> +        NULL
> +    };
> +
>      mc->desc =3D "Olimex STM32-H405 (Cortex-M4)";
>      mc->init =3D olimex_stm32_h405_init;
> -    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-m4");
> +    mc->valid_cpu_types =3D valid_cpu_types;
>
>      /* SRAM pre-allocated as part of the SoC instantiation */
>      mc->default_ram_size =3D 0;
> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
> index cef23d7ee4..a65bbe298d 100644
> --- a/hw/arm/stm32f405_soc.c
> +++ b/hw/arm/stm32f405_soc.c
> @@ -149,7 +149,7 @@ static void stm32f405_soc_realize(DeviceState *dev_so=
c, Error **errp)
>
>      armv7m =3D DEVICE(&s->armv7m);
>      qdev_prop_set_uint32(armv7m, "num-irq", 96);
> -    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
> +    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m=
4"));
>      qdev_prop_set_bit(armv7m, "enable-bitband", true);
>      qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
>      qdev_connect_clock_in(armv7m, "refclk", s->refclk);
> @@ -287,17 +287,11 @@ static void stm32f405_soc_realize(DeviceState *dev_=
soc, Error **errp)
>      create_unimplemented_device("RNG",         0x50060800, 0x400);
>  }
>
> -static Property stm32f405_soc_properties[] =3D {
> -    DEFINE_PROP_STRING("cpu-type", STM32F405State, cpu_type),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static void stm32f405_soc_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->realize =3D stm32f405_soc_realize;
> -    device_class_set_props(dc, stm32f405_soc_properties);
>      /* No vmstate or reset required: device has no internal state */
>  }
>
> --
> 2.41.0
>
>


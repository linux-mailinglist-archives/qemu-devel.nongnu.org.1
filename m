Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E13297F74A6
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 14:14:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Vzi-0003Es-3X; Fri, 24 Nov 2023 08:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6Vzb-0003EL-V6
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6VzY-0005D6-KW
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700831586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JtKOKYDPw9PaTcVRoYq2NeTmiRsDSB0p4DffXoS/qRA=;
 b=UrHyFdbwQjMF0zwlcJYln+SogxvOVED2jIaslu88BqKrIsumogRfKlKG5VhEdDyK+KWOcX
 Zc8bSroGcRivggcdhOEFrzlWwK15MpNGIAupXjGH0XYMibzw77MpeUZRWMXLcr4CBgRgXv
 AiNyvGIrfrKdM+xBOz5qlJdy1Hp7cJM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-stJR6erWNueUQ0Gf15pmsg-1; Fri, 24 Nov 2023 08:13:05 -0500
X-MC-Unique: stJR6erWNueUQ0Gf15pmsg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-54554ea191bso1153873a12.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 05:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700831584; x=1701436384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtKOKYDPw9PaTcVRoYq2NeTmiRsDSB0p4DffXoS/qRA=;
 b=uRNcwou6PcVgD22LhR+hkCCSHAlAzWPvwd9cLjYJKaZUNysiT6OW1/CLfyIvteRstT
 o7tIUCtDxHDqgg8wpX1IPUGCK3EiZnm2q3hutSbbF8QwWYzRnnNTGKh23o9UyVUWCpAo
 yQDBJoCOnHZ78EfbfkiElmaVUxVEqbup8yuXmeOSHMJMHEY8m3DkYG8h6STk+90QQ4IO
 f+XdxQJ8DLzdHJn6ptQKu41ueYpCnnrpjwbcYERQs68jFVF1DJ1BohZzI8X3RAOFNdRg
 Nle2/PuKNrjMF6VfgP0Wd23g1A+oWhaVqYvEcmqyKAc1MTc3v6wfY9TpPP3od03hh29T
 XENg==
X-Gm-Message-State: AOJu0YyzLQ74n2qGt/ZVIDcPMPHnA/8DBk6fZorJe+cnuZdS03zehbjF
 QKIj6AJ/tAWNF8k4IQzD+DsWnf555lr3q76498OlK4lDJLar2qZ4NtSyhCvNNmpjjFMT0J/hEar
 VYabrehgqDBCsqbE=
X-Received: by 2002:a50:d091:0:b0:540:2b93:af85 with SMTP id
 v17-20020a50d091000000b005402b93af85mr2029686edd.26.1700831583872; 
 Fri, 24 Nov 2023 05:13:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxBcSltw3HW99KbELA2CY7A3TnvefQ8pu2zLXXOT83rGqJwm2SxLxf0XNPQ7tN/u7yvObAuQ==
X-Received: by 2002:a50:d091:0:b0:540:2b93:af85 with SMTP id
 v17-20020a50d091000000b005402b93af85mr2029657edd.26.1700831583360; 
 Fri, 24 Nov 2023 05:13:03 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a056402104700b00542db304680sm1759051edu.63.2023.11.24.05.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 05:13:02 -0800 (PST)
Date: Fri, 24 Nov 2023 14:13:01 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, Laurent Vivier
 <laurent@vivier.eu>, Tyrone Ting <kfting@nuvoton.com>, Hao Wu
 <wuhaotsh@google.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Felipe Balbi <balbi@kernel.org>, qemu-arm@nongnu.org, =?UTF-8?B?SW7DqHM=?=
 Varhol <ines.varhol@telecom-paris.fr>, Alistair Francis
 <alistair@alistair23.me>, Yanan Wang <wangyanan55@huawei.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>, Helge
 Deller <deller@gmx.de>, Subbaraya Sundeep <sbhatta@marvell.com>, Alexandre
 Iooss <erdnaxe@crans.org>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH-for-8.2? v2 2/4] hw/arm/stm32f405: Report error when
 incorrect CPU is used
Message-ID: <20231124141301.5e03527b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231117071704.35040-3-philmd@linaro.org>
References: <20231117071704.35040-1-philmd@linaro.org>
 <20231117071704.35040-3-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 17 Nov 2023 08:17:02 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Both 'netduinoplus2' and 'olimex-stm32-h405' machines ignore the
> CPU type requested by the command line. This might confuse users,
> since the following will create a machine with a Cortex-M4 CPU:
>=20
>   $ qemu-system-aarch64 -M netduinoplus2 -cpu cortex-r5f
>=20
> Set the MachineClass::valid_cpu_types field (introduced in commit
> c9cf636d48 "machine: Add a valid_cpu_types property").
> Remove the now unused MachineClass::default_cpu_type field.

Why default_cpu_type is removed?
what if user didn't user -cpu at all?

>=20
> We now get:
>=20
>   $ qemu-system-aarch64 -M netduinoplus2 -cpu cortex-r5f
>   qemu-system-aarch64: Invalid CPU type: cortex-r5f-arm-cpu
>   The valid types are: cortex-m4-arm-cpu
>=20
> Since the SoC family can only use Cortex-M4 CPUs, hard-code the
> CPU type name at the SoC level, removing the QOM property
> entirely.
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/arm/stm32f405_soc.h | 4 ----
>  hw/arm/netduinoplus2.c         | 7 ++++++-
>  hw/arm/olimex-stm32-h405.c     | 8 ++++++--
>  hw/arm/stm32f405_soc.c         | 8 +-------
>  4 files changed, 13 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/hw/arm/stm32f405_soc.h b/include/hw/arm/stm32f405_so=
c.h
> index c968ce3ab2..d15c03c4b5 100644
> --- a/include/hw/arm/stm32f405_soc.h
> +++ b/include/hw/arm/stm32f405_soc.h
> @@ -51,11 +51,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(STM32F405State, STM32F405_S=
OC)
>  #define CCM_SIZE (64 * 1024)
> =20
>  struct STM32F405State {
> -    /*< private >*/
>      SysBusDevice parent_obj;
> -    /*< public >*/
> -
> -    char *cpu_type;
> =20
>      ARMv7MState armv7m;
> =20
> diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
> index 515c081605..2e58984947 100644
> --- a/hw/arm/netduinoplus2.c
> +++ b/hw/arm/netduinoplus2.c
> @@ -44,7 +44,6 @@ static void netduinoplus2_init(MachineState *machine)
>      clock_set_hz(sysclk, SYSCLK_FRQ);
> =20
>      dev =3D qdev_new(TYPE_STM32F405_SOC);
> -    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4")=
);
>      qdev_connect_clock_in(dev, "sysclk", sysclk);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> =20
> @@ -55,8 +54,14 @@ static void netduinoplus2_init(MachineState *machine)
> =20
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
> =20
>  DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
> diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
> index 3aa61c91b7..d793de7c97 100644
> --- a/hw/arm/olimex-stm32-h405.c
> +++ b/hw/arm/olimex-stm32-h405.c
> @@ -47,7 +47,6 @@ static void olimex_stm32_h405_init(MachineState *machin=
e)
>      clock_set_hz(sysclk, SYSCLK_FRQ);
> =20
>      dev =3D qdev_new(TYPE_STM32F405_SOC);
> -    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4")=
);
>      qdev_connect_clock_in(dev, "sysclk", sysclk);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> =20
> @@ -58,9 +57,14 @@ static void olimex_stm32_h405_init(MachineState *machi=
ne)
> =20
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
> =20
>      /* SRAM pre-allocated as part of the SoC instantiation */
>      mc->default_ram_size =3D 0;
> diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
> index cef23d7ee4..a65bbe298d 100644
> --- a/hw/arm/stm32f405_soc.c
> +++ b/hw/arm/stm32f405_soc.c
> @@ -149,7 +149,7 @@ static void stm32f405_soc_realize(DeviceState *dev_so=
c, Error **errp)
> =20
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
> =20
> -static Property stm32f405_soc_properties[] =3D {
> -    DEFINE_PROP_STRING("cpu-type", STM32F405State, cpu_type),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static void stm32f405_soc_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
>      dc->realize =3D stm32f405_soc_realize;
> -    device_class_set_props(dc, stm32f405_soc_properties);
>      /* No vmstate or reset required: device has no internal state */
>  }
> =20



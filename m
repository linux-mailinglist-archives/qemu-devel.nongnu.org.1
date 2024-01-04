Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54819824B3F
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 23:57:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLWd8-00031u-QL; Thu, 04 Jan 2024 17:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rLWd6-00031g-ON; Thu, 04 Jan 2024 17:56:00 -0500
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rLWd4-00089Y-VS; Thu, 04 Jan 2024 17:56:00 -0500
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4676a37e2c4so269636137.1; 
 Thu, 04 Jan 2024 14:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704408956; x=1705013756; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8S+JfPjRwqg4UIYq6sBhs6JXVD132NFyg7FFxV9kAG0=;
 b=l9wmG10qZfRdunzpwpF6uY2HnEQaKUpDaxDNQkSOJE7Oy1lfvkEohAoPGgdWbXe3Yl
 VvxRQjcjFC4uAy4asNNMM/TGsgFfYCxRt6WSHDK5ZVT5Bs2k7HE1AWDtT2nmMB9MKr/t
 yqGA+cpnQ5eyzr2nudWW+o+puLhkLuYNEDRFKBpTv2VUprtDTLZxlQb6zZ7+6Vgdfn0k
 gPowc4aX9DKlFwufUtI0kdAinUOAizZfd071Z96Vp5hHG68MmuylN+Fqb7lLmQ5TlYeo
 gNyHvB2pmEwD7ypoo2xIeZjf8QK9skUjYfVPPcKSxrxfsM5cVUdSuBT2R1It/WQWCSZv
 lFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704408956; x=1705013756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8S+JfPjRwqg4UIYq6sBhs6JXVD132NFyg7FFxV9kAG0=;
 b=Yowl8b+TJ+YQvehkHPW72BF9bTDnn4brzwpmttGk20YhiofJtXf1H1yTBwWjltz8ig
 +3UKMqEBCQGK5jp8/DVqm18Cp8dT2PtE+6ykiWMV4acGpWWNNKf4AQab8WEDmnufOtoi
 by6wCHwhzV8A0wYQXI3VlbRpHZdnP9OYOZALnRqkMlTx4tHT1FejSgW7Ww8VSiLK5k19
 t9nDXq7QGJJm7mwr6+mlJ73udkelcDAtlCyNL6COAr1B741EWIor1gwXyiMnzVDl2Sj3
 doxji7ptqKx0KSawHsoI1GFnJwMqUH6hBe6gZpX4rRx3Vc+1jgqK2e9ZkmwhXrR+4Jd1
 3yjw==
X-Gm-Message-State: AOJu0YyHOCxyzMgtMM54nPL1Nxf174W/3nligE+/VOjx6WP6xKoN+z4a
 hO+KVoSoKvDS7oRgZZoRRhn4viRFuJp0F66X6Jw=
X-Google-Smtp-Source: AGHT+IEVfeBLyMwXUPbDf5oiYShIUOMW75J/hG3d5IXvq2NIHNK0JPyadB7ayTStuSs3PXWxXc7HZJZqBco7zhLPCW4=
X-Received: by 2002:a05:6102:14a7:b0:466:f402:3db7 with SMTP id
 d39-20020a05610214a700b00466f4023db7mr1301113vsv.35.1704408956577; Thu, 04
 Jan 2024 14:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20240104141159.53883-1-philmd@linaro.org>
In-Reply-To: <20240104141159.53883-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 5 Jan 2024 08:55:30 +1000
Message-ID: <CAKmqyKPqbU6ik7WbJv9OiFqtDr=Sm5pz686a-Y+emtjAQNSp1A@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Add missing QOM parent for v7-M SoCs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 qemu-arm@nongnu.org, 
 Felipe Balbi <balbi@kernel.org>, Alexandre Iooss <erdnaxe@crans.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Fri, Jan 5, 2024 at 12:12=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> QDev objects created with qdev_new() need to manually add
> their parent relationship with object_property_add_child().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/msf2-som.c          | 1 +
>  hw/arm/netduino2.c         | 1 +
>  hw/arm/netduinoplus2.c     | 1 +
>  hw/arm/olimex-stm32-h405.c | 1 +
>  hw/arm/stm32vldiscovery.c  | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
> index 7b3106c790..e93c83c410 100644
> --- a/hw/arm/msf2-som.c
> +++ b/hw/arm/msf2-som.c
> @@ -66,6 +66,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machi=
ne)
>      memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
>
>      dev =3D qdev_new(TYPE_MSF2_SOC);
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
>      qdev_prop_set_string(dev, "part-name", "M2S010");
>      qdev_prop_set_string(dev, "cpu-type", mc->default_cpu_type);
>
> diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
> index 501f63a77f..8b1a9a2437 100644
> --- a/hw/arm/netduino2.c
> +++ b/hw/arm/netduino2.c
> @@ -44,6 +44,7 @@ static void netduino2_init(MachineState *machine)
>      clock_set_hz(sysclk, SYSCLK_FRQ);
>
>      dev =3D qdev_new(TYPE_STM32F205_SOC);
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
>      qdev_connect_clock_in(dev, "sysclk", sysclk);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
> diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
> index 2e58984947..bccd100354 100644
> --- a/hw/arm/netduinoplus2.c
> +++ b/hw/arm/netduinoplus2.c
> @@ -44,6 +44,7 @@ static void netduinoplus2_init(MachineState *machine)
>      clock_set_hz(sysclk, SYSCLK_FRQ);
>
>      dev =3D qdev_new(TYPE_STM32F405_SOC);
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
>      qdev_connect_clock_in(dev, "sysclk", sysclk);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
> diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
> index d793de7c97..4ad7b043be 100644
> --- a/hw/arm/olimex-stm32-h405.c
> +++ b/hw/arm/olimex-stm32-h405.c
> @@ -47,6 +47,7 @@ static void olimex_stm32_h405_init(MachineState *machin=
e)
>      clock_set_hz(sysclk, SYSCLK_FRQ);
>
>      dev =3D qdev_new(TYPE_STM32F405_SOC);
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
>      qdev_connect_clock_in(dev, "sysclk", sysclk);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
> diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
> index 190db6118b..cc41935160 100644
> --- a/hw/arm/stm32vldiscovery.c
> +++ b/hw/arm/stm32vldiscovery.c
> @@ -47,6 +47,7 @@ static void stm32vldiscovery_init(MachineState *machine=
)
>      clock_set_hz(sysclk, SYSCLK_FRQ);
>
>      dev =3D qdev_new(TYPE_STM32F100_SOC);
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
>      qdev_connect_clock_in(dev, "sysclk", sysclk);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
> --
> 2.41.0
>
>


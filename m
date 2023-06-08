Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 041C572827C
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:18:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GRl-0004pF-2C; Thu, 08 Jun 2023 10:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GRj-0004oM-S8
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:17:03 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GRh-0001wC-1M
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:17:03 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5147f7d045bso1002556a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686233819; x=1688825819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QJMTqjxEuld/cPGA+RU9MRan9RmH9/ugPN5i3rn0OVY=;
 b=SKBsbiIB6nSwE2amisKsiN8EbgqT2OhQXd1O3ro4ec6kRGKvwNcFDIvciGHi8g+pkk
 awpSZkKW/Kw7RouIpJrhPLwKvzzYyJjcjK27U5DOB/UtKb7V4bcQQuTAAM5ghhio+zTe
 Cg7Jnc/xYn1GtnMbCRC/0fryXL9184VulI6VzI11vxq7C2vdorlpsbHOe33UVhHTZTFg
 hidzMDmJSckY0lJ7rJqFsQBT6S5Ugvzxq4KgZDDFML0As6fQLE8Ywl02vIRsnKFcwjlz
 ul/ryd/Gw5FcPSd51hRrn2gYTiQLmZV7IwW9sOF6QD5zhXA6XdPpgN9gOZXN2xghRqTG
 yUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686233819; x=1688825819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QJMTqjxEuld/cPGA+RU9MRan9RmH9/ugPN5i3rn0OVY=;
 b=CeP5oFgJjrEhMpXTk9YtNl1HmqJrSzN6vGJSVPbiBHctfZL/Ym7B8S0B352ZMzx+mP
 itEXpYjdpnGh6DkLROaw67WqAdWmFwc+IfCZM0BPImNVFK1HPdGkGwsgvhtt//Ty8Bho
 g4Ww8omCWgej5W0/70UMFU4FTfcu7BATg/hNnaBqltgo9wV4e5kYp7QdFs/BnIPnkYEC
 iZwI+VLxssHTzlu9P3piP/hTUsKMwq43TQvBRuEHVZjpL9yLm2k9XBVEECfVgWiE4bzR
 zBUil92BJrCYmeokRs7Fl0sMCQncXYKySIYQycEN2rTlVNPI8oidxmzeiRaV5qcALKbw
 md5A==
X-Gm-Message-State: AC+VfDxFlhJyOukVcBx+POKZKUAT+lU3BWyE+uhifP+OYvD1s3502gBq
 aQeZ2VL6l1JxvQU1aQHe6nkAjIn/jfIuI03YYiWtMGot31GQX83RQhM=
X-Google-Smtp-Source: ACHHUZ4yezcKa2fd3j/FM+aOC52llwyAP6LiGTNaPAsMXfdL2J2mshSf00W71G6pIPCIKzlmS5Gpg2tZEfdQdwsRtnU=
X-Received: by 2002:a05:6402:1390:b0:514:a244:2915 with SMTP id
 b16-20020a056402139000b00514a2442915mr8215109edv.1.1686233819250; Thu, 08 Jun
 2023 07:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230517081204.30333-1-m.elsayed4420@gmail.com>
 <20230517081204.30333-9-m.elsayed4420@gmail.com>
In-Reply-To: <20230517081204.30333-9-m.elsayed4420@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:16:48 +0100
Message-ID: <CAFEAcA_Tg3F6Q65eAGWtDONjcu8Lyd0BarhA4b10mF+gHzAJKg@mail.gmail.com>
Subject: Re: [PATCH 8/8] adding tiva c to the qemu build system and adding my
 info to the maintainers list
To: Mohamed ElSayed <m.elsayed4420@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Wed, 17 May 2023 at 09:14, Mohamed ElSayed <m.elsayed4420@gmail.com> wrote:
>
> Signed-off-by: Mohamed ElSayed <m.elsayed4420@gmail.com>
> ---
>  MAINTAINERS                             |  9 +++++++++
>  configs/devices/arm-softmmu/default.mak |  1 +
>  hw/arm/Kconfig                          | 13 +++++++++++++
>  hw/arm/meson.build                      |  3 +++
>  hw/char/Kconfig                         |  3 +++
>  hw/char/meson.build                     |  1 +
>  hw/gpio/Kconfig                         |  3 +++
>  hw/gpio/meson.build                     |  1 +
>  hw/misc/Kconfig                         |  3 +++
>  hw/misc/meson.build                     |  1 +
>  hw/timer/Kconfig                        |  3 +++
>  hw/timer/meson.build                    |  1 +
>  hw/watchdog/Kconfig                     |  3 +++
>  hw/watchdog/meson.build                 |  1 +
>  14 files changed, 46 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b22b85bc3a..dcd902fadf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1008,6 +1008,15 @@ F: include/hw/misc/zynq_slcr.h
>  F: include/hw/adc/zynq-xadc.h
>  X: hw/ssi/xilinx_*
>
> +Tiva C
> +M: Mohamed ElSayed <m.elsayed4420@gmail.com>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/*/tm4c123*
> +F: include/hw/*/tm4c123*
> +F: hw/arm/tivac.c
> +F: docs/system/arm/tivac.rst
> +

Subsections inside this file are in alphabetical order,
so this should go a little further up, between
"STM32VLDISCOVERY" and "Versatile Express".

>  Xilinx ZynqMP and Versal
>  M: Alistair Francis <alistair@alistair23.me>
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
> index 1b49a7830c..d3490f6d11 100644
> --- a/configs/devices/arm-softmmu/default.mak
> +++ b/configs/devices/arm-softmmu/default.mak
> @@ -43,3 +43,4 @@ CONFIG_FSL_IMX6UL=y
>  CONFIG_SEMIHOSTING=y
>  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
>  CONFIG_ALLWINNER_H3=y
> +CONFIG_TIVAC=y

This file has changed recently, so now you only need
a commented out line
# CONFIG_TIVAC=n

> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index b53bd7f0b2..ef8046ab1b 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -581,3 +581,16 @@ config ARMSSE
>      select UNIMP
>      select SSE_COUNTER
>      select SSE_TIMER
> +
> +config TM4C123GH6PM_SOC
> +    bool
> +    select ARM_V7M
> +    select TM4C123_USART
> +    select TM4C123_SYSCTL
> +    select TM4C123_GPIO
> +    select TM4C123_WDT
> +    select TM4C123_GPTM
> +
> +config TIVAC
> +    bool
> +    select TM4C123GH6PM_SOC

The same recent change that means the handling in default.mak
is different also means that the config stanza for a board
(but not for a SoC) also needs two new lines:

       default y
       depends on TCG && ARM

(These go just below the 'bool' line -- check eg STM32VLDISCOVERY
for an example).

> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index b545ba0e4f..29503388a5 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -62,10 +62,13 @@ arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.
>  arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>  arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>  arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
> +arm_ss.add(when: 'CONFIG_TM4C123GH6PM_SOC', if_true: files('tm4c123gh6pm_soc.c'))
> +arm_ss.add(when: 'CONFIG_TIVAC', if_true: files('tivac.c'))
>
>  softmmu_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
>  softmmu_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
>  softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
>  softmmu_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
>
> +
>  hw_arch += {'arm': arm_ss}
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 6b6cf2fc1d..88da979b75 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -71,3 +71,6 @@ config GOLDFISH_TTY
>
>  config SHAKTI_UART
>      bool
> +
> +config TM4C123_USART
> +    bool
> diff --git a/hw/char/meson.build b/hw/char/meson.build
> index 0807e00ae4..8461748c8d 100644
> --- a/hw/char/meson.build
> +++ b/hw/char/meson.build
> @@ -33,6 +33,7 @@ softmmu_ss.add(when: 'CONFIG_SH_SCI', if_true: files('sh_serial.c'))
>  softmmu_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
>  softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
>  softmmu_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
> +softmmu_ss.add(when: 'CONFIG_TM4C123_USART', if_true: files('tm4c123_usart.c'))
>  softmmu_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
>
>  specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))

As I noted earlier, changes to meson.build and Kconfig for each
device should go in that device's patch. The changes for
the top level board go in the patch that adds the board
(which should come last in the patch series).

thanks
-- PMM


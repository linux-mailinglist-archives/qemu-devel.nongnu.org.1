Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B147E3757
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:18:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IDP-0001O7-77; Tue, 07 Nov 2023 04:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0IDM-0001N4-Qg
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:17:40 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0IDK-0000Ez-VS
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:17:40 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-509109104e2so7111617e87.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 01:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699348656; x=1699953456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OciHAjrx74uh9NksX3r4zUgupKsq6Ci9K8lpm2JMuIg=;
 b=fsoo8lSikEKuJqY64ct0qe9d6QZDbbfG/lC8dAHcxECTdgNw0kmzsQVlMmtjiP6PIQ
 NWi7IlleTA2BH4geMGLEv7EUVLrOebXBYOSfvyJjl6qJxUcuPacG32KUYburqrKdO5bS
 V6IzuxrEqu4Wxordq4fbaX++w40LrlvNNGZ6rjhNCB2JVHTHly94SD3vCMQri3BithGy
 s2lPv35TGypLVDeCsTHQYhY6nW7YC7k/neSSktRKnFIrIplWvzIZDDF0mvA2Md56TOiU
 fwVQl1nPoCYL9bT9jICJHXhUAWPuf69rtT3EIiZukIjJMhSE79sbN/MUUB67DCDpsBpx
 R8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699348656; x=1699953456;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OciHAjrx74uh9NksX3r4zUgupKsq6Ci9K8lpm2JMuIg=;
 b=YMtULGOJFmHEt6MjyFmXHooa87sRusM/ed1Eq6HoXzbs+iF2UPJzfLcskTNdTkfOZP
 T4kJWDy626Pg0QxyjYGEyTw4/R/4jlxyFGTiPoDhyawauYxM6tMdS8N/2Td0PJ83QP4P
 1jJw8kv7VUMK3LcE6RPFvkylocaqwmJ6xRq4dkTmwRP7Fm9IaBv56h8BXfwfjlbEcABV
 X3lhvmDaTaWCD+xGx2+XLtCjlmZ2mtOWoDhZfiB4yQGa2SLRE/eNI4zxBGE8OgyLb5Wb
 nojvqTQ1dmE/kUYUlMWBH1YKvhUNiJlq1wiWPVvj12IGihCDh43VKPUf1Ey0n2IbgyBj
 zYJg==
X-Gm-Message-State: AOJu0YzJt1pt/EOXu2njATeFuJfyNq02IUDB8lbRvCgbfB10ZgNYENsU
 9+Wb7d9H0La0xU+K2LqWj7Om+Q==
X-Google-Smtp-Source: AGHT+IEua1zniq4vMGj8p4gE4isPehjGzGas8jV4WzIIQhEObirvfuh+azuL3V3S6GzYGgS1Wg2dmQ==
X-Received: by 2002:a19:4f5c:0:b0:507:aad2:96af with SMTP id
 a28-20020a194f5c000000b00507aad296afmr20200193lfk.21.1699348656454; 
 Tue, 07 Nov 2023 01:17:36 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a05651212c800b0050420eff124sm282243lfg.152.2023.11.07.01.17.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 01:17:36 -0800 (PST)
Message-ID: <83af2168-b7ad-4608-a531-18373a19c9f4@linaro.org>
Date: Tue, 7 Nov 2023 10:17:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 20/24] arm/kconfig: XLNX_ZYNQMP_ARM depends on PIXMAN
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, stefanha@gmail.com,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20231107071915.2459115-1-marcandre.lureau@redhat.com>
 <20231107071915.2459115-21-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107071915.2459115-21-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Marc-André,

On 7/11/23 08:19, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The Display Port has some strong PIXMAN dependency.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/arm/Kconfig         | 3 ++-
>   hw/display/Kconfig     | 5 +++++
>   hw/display/meson.build | 2 +-
>   3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index e35007ed41..8ce288a40c 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -451,7 +451,7 @@ config STM32F405_SOC
>   config XLNX_ZYNQMP_ARM
>       bool
>       default y
> -    depends on TCG && AARCH64
> +    depends on TCG && AARCH64 && PIXMAN

NACK, this should be:

-- >8 --
  config XLNX_ZYNQMP_ARM
      bool
-    default y
+    default y if PIXMAN
      depends on TCG && AARCH64
      select AHCI
      select ARM_GIC
---

>       select AHCI
>       select ARM_GIC
>       select CADENCE
> @@ -463,6 +463,7 @@ config XLNX_ZYNQMP_ARM
>       select XILINX_AXI
>       select XILINX_SPIPS
>       select XLNX_CSU_DMA
> +    select XLNX_DISPLAYPORT

OK.

>       select XLNX_ZYNQMP
>       select XLNX_ZDMA
>       select USB_DWC3
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 4d8b0cec40..1aafe1923d 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -134,3 +134,8 @@ config MACFB
>       bool
>       select FRAMEBUFFER
>       depends on NUBUS
> +
> +config XLNX_DISPLAYPORT
> +    bool
> +    # defaults to "N", enabled by specific boards
> +    depends on PIXMAN

OK (XLNX_ZYNQMP_ARM gets the dependency from here).

Conditional to using "default y if PIXMAN":
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



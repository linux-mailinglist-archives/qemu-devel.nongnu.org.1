Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D30786AD7
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 10:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ69W-0006GQ-IJ; Thu, 24 Aug 2023 04:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uRq4=EJ=kaod.org=clg@ozlabs.org>)
 id 1qZ69V-0006GI-EP
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:57:17 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uRq4=EJ=kaod.org=clg@ozlabs.org>)
 id 1qZ69R-0003N7-4A
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:57:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RWcQr5zjCz4x0W;
 Thu, 24 Aug 2023 18:57:08 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RWcQn5Qffz4wxn;
 Thu, 24 Aug 2023 18:57:05 +1000 (AEST)
Message-ID: <85737b61-ac22-8381-eaef-27eba26307ec@kaod.org>
Date: Thu, 24 Aug 2023 10:57:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] hw/misc/Kconfig: add switch for i2c-echo
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Klaus Jensen <k.jensen@samsung.com>
References: <20230823-i2c-echo-fixes-v2-0-ff404db1bf99@samsung.com>
 <20230823-i2c-echo-fixes-v2-2-ff404db1bf99@samsung.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230823-i2c-echo-fixes-v2-2-ff404db1bf99@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=uRq4=EJ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-2.684, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/23/23 11:01, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Associate i2c-echo with TEST_DEVICES and add a dependency on I2C.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/misc/Kconfig     | 5 +++++
>   hw/misc/meson.build | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 6996d265e4c5..9ec7a40f973a 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -34,6 +34,11 @@ config PCA9552
>       bool
>       depends on I2C
>   
> +config I2C_ECHO
> +    bool
> +    default y if TEST_DEVICES
> +    depends on I2C
> +
>   config PL310
>       bool
>   
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 892f8b91c572..fbea23f8b27f 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -132,7 +132,7 @@ system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_rng.c'))
>   
>   system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_ahb_apb_pnp.c'))
>   
> -system_ss.add(when: 'CONFIG_I2C', if_true: files('i2c-echo.c'))
> +system_ss.add(when: 'CONFIG_I2C_ECHO', if_true: files('i2c-echo.c'))
>   
>   specific_ss.add(when: 'CONFIG_AVR_POWER', if_true: files('avr_power.c'))
>   
> 



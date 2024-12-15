Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DB59F1DE6
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Dec 2024 11:05:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMP1a-0002rc-Ku; Sat, 14 Dec 2024 05:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YvF0=TH=kaod.org=clg@ozlabs.org>)
 id 1tMP1X-0002qn-OZ; Sat, 14 Dec 2024 05:05:23 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YvF0=TH=kaod.org=clg@ozlabs.org>)
 id 1tMP1V-0001R9-OD; Sat, 14 Dec 2024 05:05:23 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Y9MJp2q5mz4wbr;
 Sat, 14 Dec 2024 21:05:14 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Y9MJg4C3pz4wbx;
 Sat, 14 Dec 2024 21:05:07 +1100 (AEDT)
Message-ID: <54f71e2c-06d4-4855-8595-183c207022d3@kaod.org>
Date: Sat, 14 Dec 2024 11:04:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 56/71] hw/sd: Constify all Property
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, "open list:Allwinner-a10"
 <qemu-arm@nongnu.org>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-61-richard.henderson@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241213190750.2513964-61-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=YvF0=TH=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/13/24 20:07, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/sd/allwinner-sdhost.c | 2 +-
>   hw/sd/aspeed_sdhci.c     | 2 +-
>   hw/sd/sd.c               | 6 +++---
>   hw/sd/sdhci-pci.c        | 2 +-
>   hw/sd/sdhci.c            | 2 +-
>   5 files changed, 7 insertions(+), 7 deletions(-)


For the aspeed part,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.
> 
> diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
> index bcfb4c1322..be39ec2e71 100644
> --- a/hw/sd/allwinner-sdhost.c
> +++ b/hw/sd/allwinner-sdhost.c
> @@ -808,7 +808,7 @@ static const VMStateDescription vmstate_allwinner_sdhost = {
>       }
>   };
>   
> -static Property allwinner_sdhost_properties[] = {
> +static const Property allwinner_sdhost_properties[] = {
>       DEFINE_PROP_LINK("dma-memory", AwSdHostState, dma_mr,
>                        TYPE_MEMORY_REGION, MemoryRegion *),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
> index f82b05397e..99703f1842 100644
> --- a/hw/sd/aspeed_sdhci.c
> +++ b/hw/sd/aspeed_sdhci.c
> @@ -204,7 +204,7 @@ static const VMStateDescription vmstate_aspeed_sdhci = {
>       },
>   };
>   
> -static Property aspeed_sdhci_properties[] = {
> +static const Property aspeed_sdhci_properties[] = {
>       DEFINE_PROP_UINT8("num-slots", AspeedSDHCIState, num_slots, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index f9bd03f3fd..b994ef581e 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2798,18 +2798,18 @@ static void emmc_realize(DeviceState *dev, Error **errp)
>       sd_realize(dev, errp);
>   }
>   
> -static Property sdmmc_common_properties[] = {
> +static const Property sdmmc_common_properties[] = {
>       DEFINE_PROP_DRIVE("drive", SDState, blk),
>       DEFINE_PROP_END_OF_LIST()
>   };
>   
> -static Property sd_properties[] = {
> +static const Property sd_properties[] = {
>       DEFINE_PROP_UINT8("spec_version", SDState,
>                         spec_version, SD_PHY_SPECv3_01_VERS),
>       DEFINE_PROP_END_OF_LIST()
>   };
>   
> -static Property emmc_properties[] = {
> +static const Property emmc_properties[] = {
>       DEFINE_PROP_UINT64("boot-partition-size", SDState, boot_part_size, 0),
>       DEFINE_PROP_UINT8("boot-config", SDState, boot_config, 0x0),
>       DEFINE_PROP_END_OF_LIST()
> diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
> index 9b7bee8b3f..83892a7a15 100644
> --- a/hw/sd/sdhci-pci.c
> +++ b/hw/sd/sdhci-pci.c
> @@ -22,7 +22,7 @@
>   #include "hw/sd/sdhci.h"
>   #include "sdhci-internal.h"
>   
> -static Property sdhci_pci_properties[] = {
> +static const Property sdhci_pci_properties[] = {
>       DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 37875c02c3..e697ee05b3 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1544,7 +1544,7 @@ void sdhci_common_class_init(ObjectClass *klass, void *data)
>   
>   /* --- qdev SysBus --- */
>   
> -static Property sdhci_sysbus_properties[] = {
> +static const Property sdhci_sysbus_properties[] = {
>       DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
>       DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
>                        false),



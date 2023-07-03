Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D91745CF4
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:15:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJO9-0003IY-Ls; Mon, 03 Jul 2023 09:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGJO7-0003HH-4h
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:14:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGJO5-0006Ra-7T
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:14:42 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742bso41831755e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688390079; x=1690982079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oCYxlF78xUYVt6WaeDiTHhnZ024hFtuGZwy5ReNrRvI=;
 b=vclKF0UtgaeLgJqB7Z/r+XLsqGf0JZ0v4t1gnTZGMoF8ORqiJ0NcjEqgZJ9LjWgtpU
 YGKj9oBMCs5oMUfGa4gn0623/JdiyUN/6wecUxCx4f6vXb2n5n5lnf0BZWZCQ2Fu0YEH
 CpeXCb9y2+pMPujgGnp0lBRkkH65u5nC/yD6b2/IYJ+qr7XpJd3Zzj79Ljwz2KCrRNR6
 /N+75GrMAxD1kvYSmzeeMgM0ANlaSoL1hC/y+Z6ynVSb58RCQkqinZgL97+ea6brnq6g
 duZC3fA8njCWjKzxZd7Ic79/vdlLK4qaMIanEAei04ew7h1AJdPZuS3KrbuIA+yo/szI
 x3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688390079; x=1690982079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oCYxlF78xUYVt6WaeDiTHhnZ024hFtuGZwy5ReNrRvI=;
 b=OzwgazEE1DP/C97ZgIzczdgJySVu4lek39/7+lDmLnVf0qtbhSNDRIr7S+Q+qNYAWi
 WgGZpdAVPiR8JWLtq1cyyDsn1k3+SQfayWPuO6pM8D5EozzeaPVSFRgkcXMzK9dvCllF
 pme7Qf+XA8V2J9Wb00Uo3sBFSeL+rL5sLcrONUAehxqjFH8WeJQ4VLsaQCd2buZ2TZe9
 liemGV4IvRTcE6RKxUn0xPqc2espK/ypRVJ4FjqnuvYIfDB3DI1UTkQGGApSQ8dFYR4R
 cr35mkfhH2GhbIysqx3Yi9Ipk4fmjxTGD0fuzMu7er8+xkabxxXDamSy5GGdXsgBJtEI
 KnCw==
X-Gm-Message-State: AC+VfDztYvcCwojRvejtqNcaJlBxw0fxGSzdcueRR9H7C9c2/mCUZLhf
 7OIK4kqRt2D0Pg4JEOlxKAkt6A==
X-Google-Smtp-Source: ACHHUZ6XiVmyn10oMZVi9NbhhJ+Zp3nroxP326G8aJSZ+UUIfstmyRdQBLaewGZKbImVKj2jJZAaOA==
X-Received: by 2002:a7b:cd11:0:b0:3f7:b1df:26d with SMTP id
 f17-20020a7bcd11000000b003f7b1df026dmr8564248wmj.38.1688390079219; 
 Mon, 03 Jul 2023 06:14:39 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a1c730b000000b003fb416d732csm19423559wmb.6.2023.07.03.06.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 06:14:38 -0700 (PDT)
Message-ID: <273b7114-9d38-3fc3-5c15-56047c058992@linaro.org>
Date: Mon, 3 Jul 2023 15:14:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] aspeed: Introduce helper for 32-bit hosts limitation
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
References: <20230703124746.2456684-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230703124746.2456684-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 3/7/23 14:47, Cédric Le Goater wrote:
> On 32-bit hosts, RAM has a 2047 MB limit. Use a macro to define the
> default ram size of machines (AST2600 SoC) that can have 2 GB.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/arm/aspeed.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 6880998484cd..9fca644d920e 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -47,6 +47,13 @@ struct AspeedMachineState {
>       char *spi_model;
>   };
>   
> +/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
> +#if HOST_LONG_BITS == 32
> +#define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
> +#else
> +#define ASPEED_RAM_SIZE(sz) (sz)
> +#endif
> +
>   /* Palmetto hardware value: 0x120CE416 */
>   #define PALMETTO_BMC_HW_STRAP1 (                                        \
>           SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_256MB) |               \
> @@ -1423,12 +1430,7 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
>           aspeed_soc_num_cpus(amc->soc_name);
>   };
>   
> -/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
> -#if HOST_LONG_BITS == 32
> -#define FUJI_BMC_RAM_SIZE (1 * GiB)
> -#else
> -#define FUJI_BMC_RAM_SIZE (2 * GiB)
> -#endif
> +#define FUJI_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
>   
>   static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
>   {
> @@ -1450,12 +1452,7 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
>           aspeed_soc_num_cpus(amc->soc_name);
>   };
>   
> -/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
> -#if HOST_LONG_BITS == 32
> -#define BLETCHLEY_BMC_RAM_SIZE (1 * GiB)
> -#else
> -#define BLETCHLEY_BMC_RAM_SIZE (2 * GiB)
> -#endif
> +#define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
>   
>   static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void *data)
>   {

Ah! I've this patch in some branch:

-- >8 --
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6b267c21ce..9eaa736a21 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -385,6 +385,10 @@ struct MachineState {
      } \
      type_init(machine_initfn##_register_types)

+/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
+#define RAM_SIZE_2GB_IF_POSSIBLE_ON_HOST_OTHERWISE_1GB \
+        ((HOST_LONG_BITS == 32) ? (1 * GiB) : (2 * GiB))
+
  extern GlobalProperty hw_compat_8_0[];
  extern const size_t hw_compat_8_0_len;

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6880998484..66dedd7e99 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1423,13 +1423,6 @@ static void 
aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
          aspeed_soc_num_cpus(amc->soc_name);
  };

-/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
-#if HOST_LONG_BITS == 32
-#define FUJI_BMC_RAM_SIZE (1 * GiB)
-#else
-#define FUJI_BMC_RAM_SIZE (2 * GiB)
-#endif
-
  static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
  {
      MachineClass *mc = MACHINE_CLASS(oc);
@@ -1445,18 +1438,11 @@ static void 
aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
      amc->macs_mask = ASPEED_MAC3_ON;
      amc->i2c_init = fuji_bmc_i2c_init;
      amc->uart_default = ASPEED_DEV_UART1;
-    mc->default_ram_size = FUJI_BMC_RAM_SIZE;
+    mc->default_ram_size = RAM_SIZE_2GB_IF_POSSIBLE_ON_HOST_OTHERWISE_1GB;
      mc->default_cpus = mc->min_cpus = mc->max_cpus =
          aspeed_soc_num_cpus(amc->soc_name);
  };

-/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
-#if HOST_LONG_BITS == 32
-#define BLETCHLEY_BMC_RAM_SIZE (1 * GiB)
-#else
-#define BLETCHLEY_BMC_RAM_SIZE (2 * GiB)
-#endif
-
  static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void 
*data)
  {
      MachineClass *mc = MACHINE_CLASS(oc);
@@ -1471,7 +1457,7 @@ static void 
aspeed_machine_bletchley_class_init(ObjectClass *oc, void *data)
      amc->num_cs    = 2;
      amc->macs_mask = ASPEED_MAC2_ON;
      amc->i2c_init  = bletchley_bmc_i2c_init;
-    mc->default_ram_size = BLETCHLEY_BMC_RAM_SIZE;
+    mc->default_ram_size = RAM_SIZE_2GB_IF_POSSIBLE_ON_HOST_OTHERWISE_1GB;
      mc->default_cpus = mc->min_cpus = mc->max_cpus =
          aspeed_soc_num_cpus(amc->soc_name);
  }
@@ -1513,8 +1499,7 @@ static void 
aspeed_machine_fby35_class_init(ObjectClass *oc, void *data)
      amc->num_cs    = 2;
      amc->macs_mask = ASPEED_MAC3_ON;
      amc->i2c_init  = fby35_i2c_init;
-    /* FIXME: Replace this macro with something more general */
-    mc->default_ram_size = FUJI_BMC_RAM_SIZE;
+    mc->default_ram_size = RAM_SIZE_2GB_IF_POSSIBLE_ON_HOST_OTHERWISE_1GB;
  }

  #define AST1030_INTERNAL_FLASH_SIZE (1024 * 1024)
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 07aecd9497..e2da27d4e9 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -177,11 +177,7 @@ OBJECT_DECLARE_TYPE(MPS2TZMachineState, 
MPS2TZMachineClass, MPS2TZ_MACHINE)
   * The MPS3 DDR is 2GiB, but on a 32-bit host QEMU doesn't permit
   * emulation of that much guest RAM, so artificially make it smaller.
   */
-#if HOST_LONG_BITS == 32
-#define MPS3_DDR_SIZE (1 * GiB)
-#else
-#define MPS3_DDR_SIZE (2 * GiB)
-#endif
+#define MPS3_DDR_SIZE RAM_SIZE_2GB_IF_POSSIBLE_ON_HOST_OTHERWISE_1GB

  static const uint32_t an505_oscclk[] = {
      40000000,
---

I'll rebase on top of yours :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 551438389F0
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 10:04:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSChH-00036v-NP; Tue, 23 Jan 2024 04:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9HdW=JB=kaod.org=clg@ozlabs.org>)
 id 1rSChE-00036b-QB; Tue, 23 Jan 2024 04:03:52 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9HdW=JB=kaod.org=clg@ozlabs.org>)
 id 1rSChC-00081V-Of; Tue, 23 Jan 2024 04:03:52 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TK1NN20wGz4wcJ;
 Tue, 23 Jan 2024 20:03:48 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TK1NJ6tB4z4wc6;
 Tue, 23 Jan 2024 20:03:44 +1100 (AEDT)
Message-ID: <6c22b5f1-6c72-4b31-85a0-d4d7acf02aab@kaod.org>
Date: Tue, 23 Jan 2024 10:03:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] hw/arm/aspeed/2500: Check for CPU types in
 machine_run_board_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Gavin Shan <gshan@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>
References: <20240123063842.35255-1-philmd@linaro.org>
 <20240123063842.35255-6-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240123063842.35255-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=9HdW=JB=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 1/23/24 07:38, Philippe Mathieu-Daudé wrote:
> Restrict MachineClass::valid_cpu_types[] to the single
> valid CPU type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/arm/aspeed.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index e0e0877b1d..df627096d2 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -1152,6 +1152,11 @@ static const char * const ast2400_a1_valid_cpu_types[] = {
>       NULL
>   };
>   
> +static const char * const ast2500_a1_valid_cpu_types[] = {
> +    ARM_CPU_TYPE_NAME("arm1176"),
> +    NULL
> +};
> +
>   static void aspeed_machine_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1236,6 +1241,7 @@ static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
>       amc->num_cs    = 1;
>       amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
>       amc->i2c_init  = palmetto_bmc_i2c_init;
> +    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
>       mc->default_ram_size = 512 * MiB;
>       mc->default_cpus = mc->min_cpus = mc->max_cpus =
>           aspeed_soc_num_cpus(amc->soc_name);
> @@ -1253,6 +1259,7 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
>       amc->spi_model = "mx25l25635f";
>       amc->num_cs    = 1;
>       amc->i2c_init  = ast2500_evb_i2c_init;
> +    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
>       mc->default_ram_size       = 512 * MiB;
>       mc->default_cpus = mc->min_cpus = mc->max_cpus =
>           aspeed_soc_num_cpus(amc->soc_name);
> @@ -1271,6 +1278,7 @@ static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc, void *data)
>       amc->spi_model = "mx25l25635e";
>       amc->num_cs    = 2;
>       amc->i2c_init  = yosemitev2_bmc_i2c_init;
> +    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
>       mc->default_ram_size       = 512 * MiB;
>       mc->default_cpus = mc->min_cpus = mc->max_cpus =
>           aspeed_soc_num_cpus(amc->soc_name);
> @@ -1288,6 +1296,7 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
>       amc->spi_model = "mx66l1g45g";
>       amc->num_cs    = 2;
>       amc->i2c_init  = romulus_bmc_i2c_init;
> +    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
>       mc->default_ram_size       = 512 * MiB;
>       mc->default_cpus = mc->min_cpus = mc->max_cpus =
>           aspeed_soc_num_cpus(amc->soc_name);
> @@ -1306,6 +1315,7 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc, void *data)
>       amc->spi_model = "mx25l25635e";
>       amc->num_cs    = 2;
>       amc->i2c_init  = tiogapass_bmc_i2c_init;
> +    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
>       mc->default_ram_size       = 1 * GiB;
>       mc->default_cpus = mc->min_cpus = mc->max_cpus =
>           aspeed_soc_num_cpus(amc->soc_name);
> @@ -1324,6 +1334,7 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
>       amc->spi_model = "mx66l1g45g";
>       amc->num_cs    = 2;
>       amc->i2c_init  = sonorapass_bmc_i2c_init;
> +    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
>       mc->default_ram_size       = 512 * MiB;
>       mc->default_cpus = mc->min_cpus = mc->max_cpus =
>           aspeed_soc_num_cpus(amc->soc_name);
> @@ -1341,6 +1352,7 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
>       amc->spi_model = "mx66l1g45g";
>       amc->num_cs    = 2;
>       amc->i2c_init  = witherspoon_bmc_i2c_init;
> +    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
>       mc->default_ram_size = 512 * MiB;
>       mc->default_cpus = mc->min_cpus = mc->max_cpus =
>           aspeed_soc_num_cpus(amc->soc_name);
> @@ -1398,6 +1410,7 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 2;
>       amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
>       amc->i2c_init  = g220a_bmc_i2c_init;
> +    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
>       mc->default_ram_size = 1024 * MiB;
>       mc->default_cpus = mc->min_cpus = mc->max_cpus =
>           aspeed_soc_num_cpus(amc->soc_name);
> @@ -1416,6 +1429,7 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc, void *data)
>       amc->num_cs    = 2;
>       amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
>       amc->i2c_init  = fp5280g2_bmc_i2c_init;
> +    mc->valid_cpu_types = ast2500_a1_valid_cpu_types;
>       mc->default_ram_size = 512 * MiB;
>       mc->default_cpus = mc->min_cpus = mc->max_cpus =
>           aspeed_soc_num_cpus(amc->soc_name);



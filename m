Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3CC745C97
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 14:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJ2C-0001bW-M3; Mon, 03 Jul 2023 08:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJ1z-0001PR-Oj; Mon, 03 Jul 2023 08:51:52 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGJ1v-0000Mn-VY; Mon, 03 Jul 2023 08:51:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qvm5W1GFpz4wqZ;
 Mon,  3 Jul 2023 22:51:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qvm5S35Spz4wZw;
 Mon,  3 Jul 2023 22:51:39 +1000 (AEST)
Message-ID: <00a65b4f-0f03-8c72-810b-dce16d7f01e8@kaod.org>
Date: Mon, 3 Jul 2023 14:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH qemu v2] aspeed add montblanc bmc reference from fuji
Content-Language: en-US
To: ~ssinprem <ssinprem@celestica.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: ssumet@celestica.com, srikanth@celestica.com, kgengan@celestica.com,
 andrew@aj.id.au, joel@jms.id.au
References: <168838628582.4303.2511941115126164692-0@git.sr.ht>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <168838628582.4303.2511941115126164692-0@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mKPa=CV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello Sittisak,

On 7/3/23 13:55, ~ssinprem wrote:
> From: Sittisak Sinprem <ssinprem@celestica.com>
> 
> - I2C list follow I2C Tree v1.6 20230320
> - fru eeprom data use FB FRU format version 4
> 
> Signed-off-by: Sittisak Sinprem <ssinprem@celestica.com>

Looks good,

Could please rebase and use this patch :

  https://lore.kernel.org/qemu-devel/20230703124746.2456684-1-clg@kaod.org/T/#u

docs/system/arm/aspeed.rst needs an update also.

Thanks,

C.


> ---
>   hw/arm/aspeed.c        | 67 ++++++++++++++++++++++++++++++++++++++++++
>   hw/arm/aspeed_eeprom.c | 50 +++++++++++++++++++++++++++++++
>   hw/arm/aspeed_eeprom.h |  7 +++++
>   3 files changed, 124 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 6880998484..e54685b9e6 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -182,6 +182,10 @@ struct AspeedMachineState {
>   #define FUJI_BMC_HW_STRAP1    0x00000000
>   #define FUJI_BMC_HW_STRAP2    0x00000000
>   
> +/* Montblanc hardware value */
> +#define MONTBLANC_BMC_HW_STRAP1    0x00000000
> +#define MONTBLANC_BMC_HW_STRAP2    0x00000000
> +
>   /* Bletchley hardware value */
>   /* TODO: Leave same as EVB for now. */
>   #define BLETCHLEY_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
> @@ -918,6 +922,39 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
>       }
>   }
>   
> +static void montblanc_bmc_i2c_init(AspeedMachineState *bmc)
> +{
> +    AspeedSoCState *soc = &bmc->soc;
> +    I2CBus *i2c[16] = {};
> +
> +    for (int i = 0; i < 16; i++) {
> +        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
> +    }
> +
> +    /* Ref from Minipack3_I2C_Tree_V1.6 20230320 */
> +    at24c_eeprom_init_rom(i2c[3], 0x56, 8192, montblanc_scm_fruid, true);
> +    at24c_eeprom_init_rom(i2c[6], 0x53, 8192, montblanc_fcm_fruid, true);
> +
> +    /* CPLD and FPGA */
> +    at24c_eeprom_init(i2c[1], 0x35, 256);  /* SCM CPLD */
> +    at24c_eeprom_init(i2c[5], 0x35, 256);  /* COMe CPLD TODO: need to update */
> +    at24c_eeprom_init(i2c[12], 0x60, 256); /* MCB PWR CPLD */
> +    at24c_eeprom_init(i2c[13], 0x35, 256); /* IOB FPGA */
> +
> +    /* on BMC board */
> +    at24c_eeprom_init_rom(i2c[8], 0x51, 8192, montblanc_bmc_fruid, true);
> +                                                      /* BMC EEPROM */
> +    i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x48); /* Thermal Sensor */
> +
> +    /* COMe Sensor/EEPROM */
> +    at24c_eeprom_init(i2c[0], 0x56, 16384);          /* FRU EEPROM */
> +    i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x48); /* INLET Sensor */
> +    i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x4A); /* OUTLET Sensor */
> +
> +    /* It expects a pca9555 but a pca9552 is compatible */
> +    create_pca9552(soc, 4, 0x27);
> +}
> +
>   #define TYPE_TMP421 "tmp421"
>   
>   static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
> @@ -1450,6 +1487,32 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
>           aspeed_soc_num_cpus(amc->soc_name);
>   };
>   
> +/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
> +#if HOST_LONG_BITS == 32
> +#define MONTBLANC_BMC_RAM_SIZE (1 * GiB)
> +#else
> +#define MONTBLANC_BMC_RAM_SIZE (2 * GiB)
> +#endif
> +static void aspeed_machine_montblanc_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc = "Facebook Montblanc BMC (Cortex-A7)";
> +    amc->soc_name = "ast2600-a3";
> +    amc->hw_strap1 = MONTBLANC_BMC_HW_STRAP1;
> +    amc->hw_strap2 = MONTBLANC_BMC_HW_STRAP2;
> +    amc->fmc_model = "mx66l1g45g";
> +    amc->spi_model = "mx66l1g45g";
> +    amc->num_cs = 2;
> +    amc->macs_mask = ASPEED_MAC3_ON;
> +    amc->i2c_init = montblanc_bmc_i2c_init;
> +    amc->uart_default = ASPEED_DEV_UART1;
> +    mc->default_ram_size = MONTBLANC_BMC_RAM_SIZE;
> +    mc->default_cpus = mc->min_cpus = mc->max_cpus =
> +        aspeed_soc_num_cpus(amc->soc_name);
> +};
> +
>   /* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
>   #if HOST_LONG_BITS == 32
>   #define BLETCHLEY_BMC_RAM_SIZE (1 * GiB)
> @@ -1706,6 +1769,10 @@ static const TypeInfo aspeed_machine_types[] = {
>           .name          = MACHINE_TYPE_NAME("fuji-bmc"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_fuji_class_init,
> +    }, {
> +        .name          = MACHINE_TYPE_NAME("montblanc-bmc"),
> +        .parent        = TYPE_ASPEED_MACHINE,
> +        .class_init    = aspeed_machine_montblanc_class_init,
>       }, {
>           .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
>           .parent        = TYPE_ASPEED_MACHINE,
> diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
> index ace5266cec..6b3ffba0f8 100644
> --- a/hw/arm/aspeed_eeprom.c
> +++ b/hw/arm/aspeed_eeprom.c
> @@ -161,6 +161,53 @@ const uint8_t rainier_bmc_fruid[] = {
>       0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
>   };
>   
> +/* Montblanc BMC FRU */
> +const uint8_t montblanc_scm_fruid[8192] = {
> +    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50, 0x41,
> +    0x43, 0x4b, 0x33, 0x5f, 0x53, 0x43, 0x4d, 0x02, 0x08, 0x32, 0x30, 0x30,
> +    0x30, 0x32, 0x39, 0x34, 0x35, 0x04, 0x0c, 0x31, 0x33, 0x32, 0x30, 0x30,
> +    0x30, 0x31, 0x36, 0x34, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, 0x33, 0x31,
> +    0x30, 0x30, 0x30, 0x31, 0x32, 0x37, 0x30, 0x31, 0x20, 0x06, 0x0c, 0x52,
> +    0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x30, 0x33, 0x30, 0x31, 0x07,
> +    0x0d, 0x41, 0x30, 0x33, 0x31, 0x33, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,
> +    0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, 0x00, 0x0b,
> +    0x0d, 0x4d, 0x32, 0x32, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, 0x30, 0x30,
> +    0x30, 0x32, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32,
> +    0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03,
> +    0x43, 0x54, 0x48, 0x10, 0x06, 0x01, 0x00, 0x00, 0x91, 0xdb, 0xb4, 0x13,
> +    0x03, 0x53, 0x43, 0x4d, 0xfa, 0x02, 0x02, 0x61,
> +};
> +
> +const uint8_t montblanc_fcm_fruid[8192] = {
> +    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50, 0x41,
> +    0x43, 0x4b, 0x33, 0x5f, 0x46, 0x43, 0x42, 0x02, 0x08, 0x33, 0x30, 0x30,
> +    0x30, 0x30, 0x31, 0x36, 0x31, 0x04, 0x0c, 0x31, 0x33, 0x32, 0x30, 0x30,
> +    0x30, 0x31, 0x36, 0x33, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, 0x33, 0x31,
> +    0x30, 0x30, 0x30, 0x31, 0x33, 0x30, 0x30, 0x31, 0x20, 0x06, 0x0c, 0x52,
> +    0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x31, 0x32, 0x30, 0x31, 0x07,
> +    0x0d, 0x41, 0x31, 0x32, 0x31, 0x32, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,
> +    0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, 0x00, 0x0b,
> +    0x0d, 0x46, 0x35, 0x30, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, 0x30, 0x30,
> +    0x30, 0x35, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32,
> +    0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03,
> +    0x43, 0x54, 0x48, 0x10, 0x06, 0x02, 0x00, 0x00, 0x91, 0xdb, 0xb4, 0x11,
> +    0x06, 0x03, 0x00, 0x00, 0x91, 0xdb, 0xb4, 0x12, 0x02, 0x8a, 0x00, 0x13,
> +    0x03, 0x46, 0x43, 0x42, 0xfa, 0x02, 0x50, 0x47,
> +};
> +
> +const uint8_t montblanc_bmc_fruid[8192] = {
> +    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50, 0x41,
> +    0x43, 0x4b, 0x33, 0x5f, 0x42, 0x4d, 0x43, 0x04, 0x0c, 0x31, 0x33, 0x32,
> +    0x30, 0x30, 0x30, 0x31, 0x33, 0x36, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31,
> +    0x33, 0x31, 0x30, 0x30, 0x30, 0x30, 0x38, 0x36, 0x30, 0x35, 0x20, 0x06,
> +    0x0c, 0x52, 0x33, 0x30, 0x39, 0x37, 0x47, 0x30, 0x30, 0x30, 0x32, 0x30,
> +    0x37, 0x07, 0x0d, 0x42, 0x30, 0x32, 0x37, 0x34, 0x58, 0x58, 0x58, 0x58,
> +    0x58, 0x58, 0x58, 0x58, 0x08, 0x01, 0x04, 0x09, 0x01, 0x00, 0x0a, 0x01,
> +    0x00, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32, 0x33,
> +    0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03, 0x43,
> +    0x54, 0x48, 0x13, 0x03, 0x42, 0x4d, 0x43, 0xfa, 0x02, 0xef, 0xba,
> +};
> +
>   const size_t tiogapass_bmc_fruid_len = sizeof(tiogapass_bmc_fruid);
>   const size_t fby35_nic_fruid_len = sizeof(fby35_nic_fruid);
>   const size_t fby35_bb_fruid_len = sizeof(fby35_bb_fruid);
> @@ -168,3 +215,6 @@ const size_t fby35_bmc_fruid_len = sizeof(fby35_bmc_fruid);
>   const size_t yosemitev2_bmc_fruid_len = sizeof(yosemitev2_bmc_fruid);
>   const size_t rainier_bb_fruid_len = sizeof(rainier_bb_fruid);
>   const size_t rainier_bmc_fruid_len = sizeof(rainier_bmc_fruid);
> +const size_t montblanc_scm_fruid_len = sizeof(montblanc_scm_fruid);
> +const size_t montblanc_fcm_fruid_len = sizeof(montblanc_fcm_fruid);
> +const size_t montblanc_bmc_fruid_len = sizeof(montblanc_bmc_fruid);
> diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
> index bbf9e54365..b8fbdd0734 100644
> --- a/hw/arm/aspeed_eeprom.h
> +++ b/hw/arm/aspeed_eeprom.h
> @@ -27,4 +27,11 @@ extern const size_t rainier_bb_fruid_len;
>   extern const uint8_t rainier_bmc_fruid[];
>   extern const size_t rainier_bmc_fruid_len;
>   
> +extern const uint8_t montblanc_scm_fruid[];
> +extern const uint8_t montblanc_fcm_fruid[];
> +extern const uint8_t montblanc_bmc_fruid[];
> +extern const size_t montblanc_scm_fruid_len;
> +extern const size_t montblanc_fcm_fruid_len;
> +extern const size_t montblanc_bmc_fruid_len;
> +
>   #endif



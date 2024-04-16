Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E43718A6FE3
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Apr 2024 17:35:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwkpV-0003qZ-S2; Tue, 16 Apr 2024 11:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=29bf=LV=kaod.org=clg@ozlabs.org>)
 id 1rwkpS-0003pk-Pu; Tue, 16 Apr 2024 11:34:38 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=29bf=LV=kaod.org=clg@ozlabs.org>)
 id 1rwkpQ-0002UN-DG; Tue, 16 Apr 2024 11:34:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VJp4V0Vcbz4x1t;
 Wed, 17 Apr 2024 01:34:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJp4N51T5z4wx5;
 Wed, 17 Apr 2024 01:34:28 +1000 (AEST)
Message-ID: <965df006-7689-4e9d-b30f-39a4566388ae@kaod.org>
Date: Tue, 16 Apr 2024 17:34:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/16] aspeed/sdmc: Add AST2700 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
 <20240416091904.935283-6-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240416091904.935283-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=29bf=LV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 4/16/24 11:18, Jamin Lin wrote:
> The SDRAM memory controller(DRAMC) controls the access to external
> DDR4 and DDR5 SDRAM and power up to DDR4 and DDR5 PHY.
> 
> The DRAM memory controller of AST2700 is not backward compatible
> to previous chips such AST2600, AST2500 and AST2400.
> 
> Max memory is now 8GiB on the AST2700. Introduce new
> aspeed_2700_sdmc and class with read/write operation and
> reset handlers.
> 
> Define DRAMC necessary protected registers and
> unprotected registers for AST2700 and increase
> the register set to 0x1000.
> 
> Add unlocked property to change controller protected status.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/misc/aspeed_sdmc.c         | 190 +++++++++++++++++++++++++++++++++-
>   include/hw/misc/aspeed_sdmc.h |   5 +-
>   2 files changed, 193 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index 873d67c592..69a34903db 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -27,6 +27,7 @@
>   #define   PROT_SOFTLOCKED    0x00
>   
>   #define   PROT_KEY_UNLOCK     0xFC600309
> +#define   PROT_2700_KEY_UNLOCK  0x1688A8A8
>   #define   PROT_KEY_HARDLOCK   0xDEADDEAD /* AST2600 */
>   
>   /* Configuration Register */
> @@ -54,6 +55,46 @@
>   #define R_DRAM_TIME       (0x8c / 4)
>   #define R_ECC_ERR_INJECT  (0xb4 / 4)
>   
> +/* AST2700 Register */
> +#define R_2700_PROT                 (0x00 / 4)
> +#define R_INT_STATUS                (0x04 / 4)
> +#define R_INT_CLEAR                 (0x08 / 4)
> +#define R_INT_MASK                  (0x0c / 4)
> +#define R_MAIN_CONF                 (0x10 / 4)
> +#define R_MAIN_CONTROL              (0x14 / 4)
> +#define R_MAIN_STATUS               (0x18 / 4)
> +#define R_ERR_STATUS                (0x1c / 4)
> +#define R_ECC_FAIL_STATUS           (0x78 / 4)
> +#define R_ECC_FAIL_ADDR             (0x7c / 4)
> +#define R_ECC_TESTING_CONTROL       (0x80 / 4)
> +#define R_PROT_REGION_LOCK_STATUS   (0x94 / 4)
> +#define R_TEST_FAIL_ADDR            (0xd4 / 4)
> +#define R_TEST_FAIL_D0              (0xd8 / 4)
> +#define R_TEST_FAIL_D1              (0xdc / 4)
> +#define R_TEST_FAIL_D2              (0xe0 / 4)
> +#define R_TEST_FAIL_D3              (0xe4 / 4)
> +#define R_DBG_STATUS                (0xf4 / 4)
> +#define R_PHY_INTERFACE_STATUS      (0xf8 / 4)
> +#define R_GRAPHIC_MEM_BASE_ADDR     (0x10c / 4)
> +#define R_PORT0_INTERFACE_MONITOR0  (0x240 / 4)
> +#define R_PORT0_INTERFACE_MONITOR1  (0x244 / 4)
> +#define R_PORT0_INTERFACE_MONITOR2  (0x248 / 4)
> +#define R_PORT1_INTERFACE_MONITOR0  (0x2c0 / 4)
> +#define R_PORT1_INTERFACE_MONITOR1  (0x2c4 / 4)
> +#define R_PORT1_INTERFACE_MONITOR2  (0x2c8 / 4)
> +#define R_PORT2_INTERFACE_MONITOR0  (0x340 / 4)
> +#define R_PORT2_INTERFACE_MONITOR1  (0x344 / 4)
> +#define R_PORT2_INTERFACE_MONITOR2  (0x348 / 4)
> +#define R_PORT3_INTERFACE_MONITOR0  (0x3c0 / 4)
> +#define R_PORT3_INTERFACE_MONITOR1  (0x3c4 / 4)
> +#define R_PORT3_INTERFACE_MONITOR2  (0x3c8 / 4)
> +#define R_PORT4_INTERFACE_MONITOR0  (0x440 / 4)
> +#define R_PORT4_INTERFACE_MONITOR1  (0x444 / 4)
> +#define R_PORT4_INTERFACE_MONITOR2  (0x448 / 4)
> +#define R_PORT5_INTERFACE_MONITOR0  (0x4c0 / 4)
> +#define R_PORT5_INTERFACE_MONITOR1  (0x4c4 / 4)
> +#define R_PORT5_INTERFACE_MONITOR2  (0x4c8 / 4)
> +
>   /*
>    * Configuration register Ox4 (for Aspeed AST2400 SOC)
>    *
> @@ -101,6 +142,19 @@
>        ASPEED_SDMC_AST2500_RESERVED | ASPEED_SDMC_VGA_COMPAT |            \
>        ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB))
>   
> +/*
> + * Main Configuration register Ox10 (for Aspeed AST2700 SOC and higher)
> + *
> + */
> +#define ASPEED_SDMC_AST2700_RESERVED        0xFFFF2082 /* 31:16, 13, 7, 1 */
> +#define ASPEED_SDMC_AST2700_DATA_SCRAMBLE           (1 << 8)
> +#define ASPEED_SDMC_AST2700_ECC_ENABLE              (1 << 6)
> +#define ASPEED_SDMC_AST2700_PAGE_MATCHING_ENABLE    (1 << 5)
> +#define ASPEED_SDMC_AST2700_DRAM_SIZE(x)            ((x & 0x7) << 2)
> +
> +#define ASPEED_SDMC_AST2700_READONLY_MASK   \
> +     (ASPEED_SDMC_AST2700_RESERVED)
> +
>   static uint64_t aspeed_sdmc_read(void *opaque, hwaddr addr, unsigned size)
>   {
>       AspeedSDMCState *s = ASPEED_SDMC(opaque);
> @@ -216,7 +270,7 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
>       AspeedSDMCState *s = ASPEED_SDMC(dev);
>       AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
>   
> -    assert(asc->max_ram_size < 4 * GiB); /* 32-bit address bus */
> +    assert(asc->max_ram_size < 4 * GiB || asc->is_bus64bit);
>       s->max_ram_size = asc->max_ram_size;
>   
>       memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops, s,
> @@ -236,6 +290,7 @@ static const VMStateDescription vmstate_aspeed_sdmc = {
>   
>   static Property aspeed_sdmc_properties[] = {
>       DEFINE_PROP_UINT64("max-ram-size", AspeedSDMCState, max_ram_size, 0),
> +    DEFINE_PROP_BOOL("unlocked", AspeedSDMCState, unlocked, false),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> @@ -500,12 +555,145 @@ static const TypeInfo aspeed_2600_sdmc_info = {
>       .class_init = aspeed_2600_sdmc_class_init,
>   };
>   
> +static void aspeed_2700_sdmc_reset(DeviceState *dev)
> +{
> +    AspeedSDMCState *s = ASPEED_SDMC(dev);
> +    AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +
> +    /* Set ram size bit and defaults values */
> +    s->regs[R_MAIN_CONF] = asc->compute_conf(s, 0);
> +
> +    if (s->unlocked) {
> +        s->regs[R_2700_PROT] = PROT_UNLOCKED;
> +    }
> +}
> +
> +static uint32_t aspeed_2700_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
> +{
> +    uint32_t fixed_conf = ASPEED_SDMC_AST2700_PAGE_MATCHING_ENABLE |
> +        ASPEED_SDMC_AST2700_DRAM_SIZE(aspeed_sdmc_get_ram_bits(s));
> +
> +    /* Make sure readonly bits are kept */
> +    data &= ~ASPEED_SDMC_AST2700_READONLY_MASK;
> +
> +    return data | fixed_conf;
> +}
> +
> +static void aspeed_2700_sdmc_write(AspeedSDMCState *s, uint32_t reg,
> +                                   uint32_t data)
> +{
> +    /* Unprotected registers */
> +    switch (reg) {
> +    case R_INT_STATUS:
> +    case R_INT_CLEAR:
> +    case R_INT_MASK:
> +    case R_MAIN_STATUS:
> +    case R_ERR_STATUS:
> +    case R_ECC_FAIL_STATUS:
> +    case R_ECC_FAIL_ADDR:
> +    case R_PROT_REGION_LOCK_STATUS:
> +    case R_TEST_FAIL_ADDR:
> +    case R_TEST_FAIL_D0:
> +    case R_TEST_FAIL_D1:
> +    case R_TEST_FAIL_D2:
> +    case R_TEST_FAIL_D3:
> +    case R_DBG_STATUS:
> +    case R_PHY_INTERFACE_STATUS:
> +    case R_GRAPHIC_MEM_BASE_ADDR:
> +    case R_PORT0_INTERFACE_MONITOR0:
> +    case R_PORT0_INTERFACE_MONITOR1:
> +    case R_PORT0_INTERFACE_MONITOR2:
> +    case R_PORT1_INTERFACE_MONITOR0:
> +    case R_PORT1_INTERFACE_MONITOR1:
> +    case R_PORT1_INTERFACE_MONITOR2:
> +    case R_PORT2_INTERFACE_MONITOR0:
> +    case R_PORT2_INTERFACE_MONITOR1:
> +    case R_PORT2_INTERFACE_MONITOR2:
> +    case R_PORT3_INTERFACE_MONITOR0:
> +    case R_PORT3_INTERFACE_MONITOR1:
> +    case R_PORT3_INTERFACE_MONITOR2:
> +    case R_PORT4_INTERFACE_MONITOR0:
> +    case R_PORT4_INTERFACE_MONITOR1:
> +    case R_PORT4_INTERFACE_MONITOR2:
> +    case R_PORT5_INTERFACE_MONITOR0:
> +    case R_PORT5_INTERFACE_MONITOR1:
> +    case R_PORT5_INTERFACE_MONITOR2:
> +        s->regs[reg] = data;
> +        return;
> +    }
> +
> +    if (s->regs[R_2700_PROT] == PROT_HARDLOCKED) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: SDMC is locked until system reset!\n",
> +                      __func__);
> +        return;
> +    }
> +
> +    if (reg != R_2700_PROT && s->regs[R_2700_PROT] == PROT_SOFTLOCKED) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: SDMC is locked! (write to MCR%02x blocked)\n",
> +                      __func__, reg * 4);
> +        return;
> +    }
> +
> +    switch (reg) {
> +    case R_2700_PROT:
> +        if (data == PROT_2700_KEY_UNLOCK)  {
> +            data = PROT_UNLOCKED;
> +        } else if (data == PROT_KEY_HARDLOCK) {
> +            data = PROT_HARDLOCKED;
> +        } else {
> +            data = PROT_SOFTLOCKED;
> +        }
> +        break;
> +    case R_MAIN_CONF:
> +        data = aspeed_2700_sdmc_compute_conf(s, data);
> +        break;
> +    case R_MAIN_STATUS:
> +        /* Will never return 'busy'. */
> +        data &= ~PHY_BUSY_STATE;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    s->regs[reg] = data;
> +}
> +
> +static const uint64_t
> +    aspeed_2700_ram_sizes[] = { 256 * MiB, 512 * MiB, 1024 * MiB,
> +                                2048 * MiB, 4096 * MiB, 8192 * MiB, 0};
> +
> +static void aspeed_2700_sdmc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedSDMCClass *asc = ASPEED_SDMC_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 SDRAM Memory Controller";
> +    dc->reset = aspeed_2700_sdmc_reset;
> +
> +    asc->is_bus64bit = true;
> +    asc->max_ram_size = 8 * GiB;
> +    asc->compute_conf = aspeed_2700_sdmc_compute_conf;
> +    asc->write = aspeed_2700_sdmc_write;
> +    asc->valid_ram_sizes = aspeed_2700_ram_sizes;
> +}
> +
> +static const TypeInfo aspeed_2700_sdmc_info = {
> +    .name = TYPE_ASPEED_2700_SDMC,
> +    .parent = TYPE_ASPEED_SDMC,
> +    .class_init = aspeed_2700_sdmc_class_init,
> +};
> +
>   static void aspeed_sdmc_register_types(void)
>   {
>       type_register_static(&aspeed_sdmc_info);
>       type_register_static(&aspeed_2400_sdmc_info);
>       type_register_static(&aspeed_2500_sdmc_info);
>       type_register_static(&aspeed_2600_sdmc_info);
> +    type_register_static(&aspeed_2700_sdmc_info);
>   }
>   
>   type_init(aspeed_sdmc_register_types);
> diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
> index ec2d59a14f..61c979583a 100644
> --- a/include/hw/misc/aspeed_sdmc.h
> +++ b/include/hw/misc/aspeed_sdmc.h
> @@ -17,6 +17,7 @@ OBJECT_DECLARE_TYPE(AspeedSDMCState, AspeedSDMCClass, ASPEED_SDMC)
>   #define TYPE_ASPEED_2400_SDMC TYPE_ASPEED_SDMC "-ast2400"
>   #define TYPE_ASPEED_2500_SDMC TYPE_ASPEED_SDMC "-ast2500"
>   #define TYPE_ASPEED_2600_SDMC TYPE_ASPEED_SDMC "-ast2600"
> +#define TYPE_ASPEED_2700_SDMC TYPE_ASPEED_SDMC "-ast2700"
>   
>   /*
>    * SDMC has 174 documented registers. In addition the u-boot device tree
> @@ -29,7 +30,7 @@ OBJECT_DECLARE_TYPE(AspeedSDMCState, AspeedSDMCClass, ASPEED_SDMC)
>    * time, and the other is in the DDR-PHY IP which is used during DDR-PHY
>    * training.
>    */
> -#define ASPEED_SDMC_NR_REGS (0x500 >> 2)
> +#define ASPEED_SDMC_NR_REGS (0x1000 >> 2)
>   
>   struct AspeedSDMCState {
>       /*< private >*/
> @@ -41,6 +42,7 @@ struct AspeedSDMCState {
>       uint32_t regs[ASPEED_SDMC_NR_REGS];
>       uint64_t ram_size;
>       uint64_t max_ram_size;
> +    bool unlocked;
>   };
>   
>   
> @@ -51,6 +53,7 @@ struct AspeedSDMCClass {
>       const uint64_t *valid_ram_sizes;
>       uint32_t (*compute_conf)(AspeedSDMCState *s, uint32_t data);
>       void (*write)(AspeedSDMCState *s, uint32_t reg, uint32_t data);
> +    bool is_bus64bit;
>   };
>   
>   #endif /* ASPEED_SDMC_H */



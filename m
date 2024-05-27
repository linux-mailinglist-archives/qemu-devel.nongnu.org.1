Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9B48D0078
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 14:53:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBZq8-0005Q0-Fd; Mon, 27 May 2024 08:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=e5bn=M6=kaod.org=clg@ozlabs.org>)
 id 1sBZq3-0005Oi-IL; Mon, 27 May 2024 08:52:31 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=e5bn=M6=kaod.org=clg@ozlabs.org>)
 id 1sBZpz-0008Hv-Fe; Mon, 27 May 2024 08:52:31 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VnwXQ4vj4z4x2d;
 Mon, 27 May 2024 22:52:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VnwXJ2t5yz4wcS;
 Mon, 27 May 2024 22:52:15 +1000 (AEST)
Message-ID: <fe0e3579-defd-4b42-8182-83ca7d5af649@kaod.org>
Date: Mon, 27 May 2024 14:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/16] aspeed/smc: support dma start length and 1 byte
 length unit
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
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-8-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240527080231.1576609-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=e5bn=M6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 5/27/24 10:02, Jamin Lin wrote:
> DMA length is from 1 byte to 32MB for AST2600 and AST10x0
> and DMA length is from 4 bytes to 32MB for AST2500.
> 
> In other words, if "R_DMA_LEN" is 0, it should move at least 1 byte
> data for AST2600 and AST10x0 and 4 bytes data for AST2500.
> To support all ASPEED SOCs, adds dma_start_length parameter to store
> the start length, add helper routines function to compute the dma length
> and update DMA_LENGTH mask to "1FFFFFF" to support dma 1 byte
> length unit for AST2600 and AST1030.
> Currently, only supports dma length 4 bytes aligned.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ssi/aspeed_smc.c         | 43 ++++++++++++++++++++++++++++++-------
>   include/hw/ssi/aspeed_smc.h |  1 +
>   2 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 8a8d77b480..ffb13a12e8 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -178,13 +178,17 @@
>    * DMA flash addresses should be 4 bytes aligned and the valid address
>    * range is 0x20000000 - 0x2FFFFFFF.
>    *
> - * DMA length is from 4 bytes to 32MB
> + * DMA length is from 4 bytes to 32MB (AST2500)
>    *   0: 4 bytes
> - *   0x7FFFFF: 32M bytes
> + *   0x1FFFFFC: 32M bytes
> + *
> + * DMA length is from 1 byte to 32MB (AST2600, AST10x0)
> + *   0: 1 byte
> + *   0x1FFFFFF: 32M bytes
>    */
>   #define DMA_DRAM_ADDR(asc, val)   ((val) & (asc)->dma_dram_mask)
>   #define DMA_FLASH_ADDR(asc, val)  ((val) & (asc)->dma_flash_mask)
> -#define DMA_LENGTH(val)         ((val) & 0x01FFFFFC)
> +#define DMA_LENGTH(val)         ((val) & 0x01FFFFFF)
>   
>   /* Flash opcodes. */
>   #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
> @@ -843,6 +847,13 @@ static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
>       }
>   }
>   
> +static uint32_t aspeed_smc_dma_len(AspeedSMCState *s)
> +{
> +    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
> +
> +    return QEMU_ALIGN_UP(s->regs[R_DMA_LEN] + asc->dma_start_length, 4);
> +}
> +
>   /*
>    * Accumulate the result of the reads to provide a checksum that will
>    * be used to validate the read timing settings.
> @@ -850,6 +861,7 @@ static bool aspeed_smc_inject_read_failure(AspeedSMCState *s)
>   static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>   {
>       MemTxResult result;
> +    uint32_t dma_len;
>       uint32_t data;
>   
>       if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
> @@ -861,7 +873,9 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>           aspeed_smc_dma_calibration(s);
>       }
>   
> -    while (s->regs[R_DMA_LEN]) {
> +    dma_len = aspeed_smc_dma_len(s);
> +
> +    while (dma_len) {
>           data = address_space_ldl_le(&s->flash_as, s->regs[R_DMA_FLASH_ADDR],
>                                       MEMTXATTRS_UNSPECIFIED, &result);
>           if (result != MEMTX_OK) {
> @@ -877,7 +891,8 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>            */
>           s->regs[R_DMA_CHECKSUM] += data;
>           s->regs[R_DMA_FLASH_ADDR] += 4;
> -        s->regs[R_DMA_LEN] -= 4;
> +        dma_len -= 4;
> +        s->regs[R_DMA_LEN] = dma_len;
>       }
>   
>       if (s->inject_failure && aspeed_smc_inject_read_failure(s)) {
> @@ -889,14 +904,17 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>   static void aspeed_smc_dma_rw(AspeedSMCState *s)
>   {
>       MemTxResult result;
> +    uint32_t dma_len;
>       uint32_t data;
>   
> +    dma_len = aspeed_smc_dma_len(s);
> +
>       trace_aspeed_smc_dma_rw(s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE ?
>                               "write" : "read",
>                               s->regs[R_DMA_FLASH_ADDR],
>                               s->regs[R_DMA_DRAM_ADDR],
> -                            s->regs[R_DMA_LEN]);
> -    while (s->regs[R_DMA_LEN]) {
> +                            dma_len);
> +    while (dma_len) {
>           if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
>               data = address_space_ldl_le(&s->dram_as, s->regs[R_DMA_DRAM_ADDR],
>                                           MEMTXATTRS_UNSPECIFIED, &result);
> @@ -937,7 +955,8 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
>            */
>           s->regs[R_DMA_FLASH_ADDR] += 4;
>           s->regs[R_DMA_DRAM_ADDR] += 4;
> -        s->regs[R_DMA_LEN] -= 4;
> +        dma_len -= 4;
> +        s->regs[R_DMA_LEN] = dma_len;
>           s->regs[R_DMA_CHECKSUM] += data;
>       }
>   }
> @@ -1381,6 +1400,7 @@ static void aspeed_2400_fmc_class_init(ObjectClass *klass, void *data)
>       asc->features          = ASPEED_SMC_FEATURE_DMA;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x1FFFFFFC;
> +    asc->dma_start_length  = 4;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_smc_reg_to_segment;
> @@ -1464,6 +1484,7 @@ static void aspeed_2500_fmc_class_init(ObjectClass *klass, void *data)
>       asc->features          = ASPEED_SMC_FEATURE_DMA;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x3FFFFFFC;
> +    asc->dma_start_length  = 4;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_smc_reg_to_segment;
> @@ -1620,6 +1641,7 @@ static void aspeed_2600_fmc_class_init(ObjectClass *klass, void *data)
>                                ASPEED_SMC_FEATURE_WDT_CONTROL;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x3FFFFFFC;
> +    asc->dma_start_length  = 1;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
> @@ -1658,6 +1680,7 @@ static void aspeed_2600_spi1_class_init(ObjectClass *klass, void *data)
>                                ASPEED_SMC_FEATURE_DMA_GRANT;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x3FFFFFFC;
> +    asc->dma_start_length  = 1;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
> @@ -1697,6 +1720,7 @@ static void aspeed_2600_spi2_class_init(ObjectClass *klass, void *data)
>                                ASPEED_SMC_FEATURE_DMA_GRANT;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x3FFFFFFC;
> +    asc->dma_start_length  = 1;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
> @@ -1778,6 +1802,7 @@ static void aspeed_1030_fmc_class_init(ObjectClass *klass, void *data)
>       asc->features          = ASPEED_SMC_FEATURE_DMA;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x000BFFFC;
> +    asc->dma_start_length  = 1;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_1030_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_1030_smc_reg_to_segment;
> @@ -1815,6 +1840,7 @@ static void aspeed_1030_spi1_class_init(ObjectClass *klass, void *data)
>       asc->features          = ASPEED_SMC_FEATURE_DMA;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x000BFFFC;
> +    asc->dma_start_length  = 1;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
> @@ -1851,6 +1877,7 @@ static void aspeed_1030_spi2_class_init(ObjectClass *klass, void *data)
>       asc->features          = ASPEED_SMC_FEATURE_DMA;
>       asc->dma_flash_mask    = 0x0FFFFFFC;
>       asc->dma_dram_mask     = 0x000BFFFC;
> +    asc->dma_start_length  = 1;
>       asc->nregs             = ASPEED_SMC_R_MAX;
>       asc->segment_to_reg    = aspeed_2600_smc_segment_to_reg;
>       asc->reg_to_segment    = aspeed_2600_smc_reg_to_segment;
> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
> index 8e1dda556b..f359ed22cc 100644
> --- a/include/hw/ssi/aspeed_smc.h
> +++ b/include/hw/ssi/aspeed_smc.h
> @@ -106,6 +106,7 @@ struct AspeedSMCClass {
>       uint32_t features;
>       hwaddr dma_flash_mask;
>       hwaddr dma_dram_mask;
> +    uint32_t dma_start_length;
>       uint32_t nregs;
>       uint32_t (*segment_to_reg)(const AspeedSMCState *s,
>                                  const AspeedSegments *seg);



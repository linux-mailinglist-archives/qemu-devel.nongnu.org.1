Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 441267773F7
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 11:15:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU1jO-0008OK-LR; Thu, 10 Aug 2023 05:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YB0G=D3=kaod.org=clg@ozlabs.org>)
 id 1qU1jM-0008Na-CZ; Thu, 10 Aug 2023 05:13:20 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=YB0G=D3=kaod.org=clg@ozlabs.org>)
 id 1qU1jJ-0007AL-OS; Thu, 10 Aug 2023 05:13:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RM1Rl4qC4z4wy7;
 Thu, 10 Aug 2023 19:13:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RM1Rj4F8Zz4wxm;
 Thu, 10 Aug 2023 19:13:04 +1000 (AEST)
Message-ID: <7683a189-53cb-63f4-486b-534abbd5fd1d@kaod.org>
Date: Thu, 10 Aug 2023 11:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Aspeed: i2c: Fixed Tx and Rx error in BUFF Mode
Content-Language: en-US
To: Hang Yu <1339236493@qq.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
References: <20230804081142.52539-1-1339236493@qq.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230804081142.52539-1-1339236493@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=YB0G=D3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-4.14, SPF_HELO_PASS=-0.001,
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

Hello,

On 8/4/23 10:11, Hang Yu via wrote:
> 1. Fixed inconsistency between the bit field definition in register
> I2CD_POOL_CTRL and the ast2600 datasheet
> 2. Fixed issue of confusing RXSIZE and RXCOUNT, as well as forgetting
> to add one to TXCOUNT and RXSIZE in buff mode
> 3. Fixed issue with TXBUF transmission start position error in buff mode
> 4. Added support for the BUFFER ORGANIZATION option in reg I2CC_POOL_CTRL


This looks like 4 patches. Could split and resend a series please ?

Also, Cc: these persons

   Joe Komlodi <komlodi@google.com>
   Peter Delevoryas <peter@pjd.dev>

since they have been involved with the AST2600 I2C implementation.

> After adding these changes, QEMU can support driver code:
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v5.15
> /drivers/i2c/busses/i2c-ast2600.c
> 
> Signed-off-by: Hang Yu <1339236493@qq.com>

  This is very cryptic. Don't you have a corporate email ?

Thanks,

C.



> ---
>   hw/i2c/aspeed_i2c.c         | 21 ++++++---------------
>   include/hw/i2c/aspeed_i2c.h |  5 +++--
>   2 files changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 1f071a3811..0e380d0bba 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -236,7 +236,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
>       uint32_t reg_byte_buf = aspeed_i2c_bus_byte_buf_offset(bus);
>       uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
>       int pool_tx_count = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl,
> -                                                TX_COUNT);
> +                                                TX_COUNT)+1;
>   
>       if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_BUFF_EN)) {
>           for (i = pool_start; i < pool_tx_count; i++) {
> @@ -293,10 +293,12 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>       uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
>       uint32_t reg_dma_addr = aspeed_i2c_bus_dma_addr_offset(bus);
>       int pool_rx_count = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl,
> -                                                RX_COUNT);
> +                                                RX_SIZE)+1;
>   
>       if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_BUFF_EN)) {
> -        uint8_t *pool_base = aic->bus_pool_base(bus);
> +        uint8_t *pool_base ;
> +        if(ARRAY_FIELD_EX32(bus->regs,I2CC_POOL_CTRL,BUF_ORGANIZATION))pool_base=aic->bus_pool_base(bus)+16;
> +        else pool_base= aic->bus_pool_base(bus);
>   
>           for (i = 0; i < pool_rx_count; i++) {
>               pool_base[i] = i2c_recv(bus->bus);
> @@ -418,7 +420,7 @@ static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
>       uint32_t reg_intr_sts = aspeed_i2c_bus_intr_sts_offset(bus);
>       uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
>       if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_BUFF_EN)) {
> -        count = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl, TX_COUNT);
> +        count = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl, TX_COUNT)+1;
>       } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_DMA_EN)) {
>           count = bus->regs[reg_dma_len];
>       } else { /* BYTE mode */
> @@ -449,7 +451,6 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>       uint8_t pool_start = 0;
>       uint32_t reg_intr_sts = aspeed_i2c_bus_intr_sts_offset(bus);
>       uint32_t reg_cmd = aspeed_i2c_bus_cmd_offset(bus);
> -    uint32_t reg_pool_ctrl = aspeed_i2c_bus_pool_ctrl_offset(bus);
>       uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
>   
>       if (!aspeed_i2c_check_sram(bus)) {
> @@ -489,16 +490,6 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>            * else needs to be sent in this sequence.
>            */
>           if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_BUFF_EN)) {
> -            if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl, TX_COUNT)
> -                == 1) {
> -                SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, M_TX_CMD, 0);
> -            } else {
> -                /*
> -                 * Increase the start index in the TX pool buffer to
> -                 * skip the address byte.
> -                 */
> -                pool_start++;
> -            }
>           } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_DMA_EN)) {
>               if (bus->regs[reg_dma_len] == 0) {
>                   SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, M_TX_CMD, 0);
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index 51c944efea..88b144a599 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -139,9 +139,9 @@ REG32(I2CD_CMD, 0x14) /* I2CD Command/Status */
>   REG32(I2CD_DEV_ADDR, 0x18) /* Slave Device Address */
>       SHARED_FIELD(SLAVE_DEV_ADDR1, 0, 7)
>   REG32(I2CD_POOL_CTRL, 0x1C) /* Pool Buffer Control */
> -    SHARED_FIELD(RX_COUNT, 24, 5)
> +    SHARED_FIELD(RX_COUNT, 24, 6)
>       SHARED_FIELD(RX_SIZE, 16, 5)
> -    SHARED_FIELD(TX_COUNT, 9, 5)
> +    SHARED_FIELD(TX_COUNT, 8, 5)
>       FIELD(I2CD_POOL_CTRL, OFFSET, 2, 6) /* AST2400 */
>   REG32(I2CD_BYTE_BUF, 0x20) /* Transmit/Receive Byte Buffer */
>       SHARED_FIELD(RX_BUF, 8, 8)
> @@ -162,6 +162,7 @@ REG32(I2CC_MS_TXRX_BYTE_BUF, 0x08)
>       /* 15:0  shared with I2CD_BYTE_BUF[15:0] */
>   REG32(I2CC_POOL_CTRL, 0x0c)
>       /* 31:0 shared with I2CD_POOL_CTRL[31:0] */
> +    FIELD(I2CC_POOL_CTRL, BUF_ORGANIZATION, 0, 1) /* AST2600 */
>   REG32(I2CM_INTR_CTRL, 0x10)
>   REG32(I2CM_INTR_STS, 0x14)
>       FIELD(I2CM_INTR_STS, PKT_STATE, 28, 4)



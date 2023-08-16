Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF7D77DC5E
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 10:35:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWByP-000658-6t; Wed, 16 Aug 2023 04:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=V02R=EB=kaod.org=clg@ozlabs.org>)
 id 1qWBy2-00062V-W9; Wed, 16 Aug 2023 04:33:28 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=V02R=EB=kaod.org=clg@ozlabs.org>)
 id 1qWBxz-0006E9-Oz; Wed, 16 Aug 2023 04:33:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RQhGv530qz4wy4;
 Wed, 16 Aug 2023 18:33:11 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQhGq70G0z4wxn;
 Wed, 16 Aug 2023 18:33:04 +1000 (AEST)
Message-ID: <73d307ba-263c-b059-06f7-244ee4c4aa45@kaod.org>
Date: Wed, 16 Aug 2023 10:32:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/3] hw/i2c/aspeed: Fix Tx count and Rx size error in
 buffer pool mode
Content-Language: en-US
To: Hang Yu <francis_yuu@stu.pku.edu.cn>, qemu-devel@nongnu.org
Cc: komlodi@google.com, peter@pjd.dev,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, qemu-stable@nongnu.org
References: <20230812065230.8839-1-francis_yuu@stu.pku.edu.cn>
 <20230812065230.8839-2-francis_yuu@stu.pku.edu.cn>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230812065230.8839-2-francis_yuu@stu.pku.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=V02R=EB=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-1.045,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On 8/12/23 08:52, Hang Yu wrote:
> Fixed inconsistency between the regisiter bit field definition header file
> and the ast2600 datasheet. The reg name is I2CD1C:Pool Buffer Control
> Register in old register mode and  I2CC0C: Master/Slave Pool Buffer Control
> Register in new register mode. They share bit field
> [12:8]:Transmit Data Byte Count and bit field
> [29:24]:Actual Received Pool Buffer Size according to the datasheet.
> According to the ast2600 datasheet,the actual Tx count is
> Transmit Data Byte Count plus 1, and the max Rx size is
> Receive Pool Buffer Size plus 1, both in Pool Buffer Control Register.
> The version before forgot to plus 1, and mistake Rx count for Rx size.
> 
> Signed-off-by: Hang Yu <francis_yuu@stu.pku.edu.cn>
> Fixes: 3be3d6ccf2ad ("aspeed: i2c: Migrate to registerfields API")

This is -stable material with the following patch. It fixes support for
the v08.06 SDK.

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
> v2-->v3:
> 1. Merged patch1 and patch2 in v2
> 2. added fixes tag
> 3. Fixed typos
> 
>   hw/i2c/aspeed_i2c.c         | 8 ++++----
>   include/hw/i2c/aspeed_i2c.h | 4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 1f071a3811..e485d8bfb8 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -236,7 +236,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
>       uint32_t reg_byte_buf = aspeed_i2c_bus_byte_buf_offset(bus);
>       uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
>       int pool_tx_count = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl,
> -                                                TX_COUNT);
> +                                                TX_COUNT) + 1;
>   
>       if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_BUFF_EN)) {
>           for (i = pool_start; i < pool_tx_count; i++) {
> @@ -293,7 +293,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>       uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
>       uint32_t reg_dma_addr = aspeed_i2c_bus_dma_addr_offset(bus);
>       int pool_rx_count = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl,
> -                                                RX_COUNT);
> +                                                RX_SIZE) + 1;
>   
>       if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_BUFF_EN)) {
>           uint8_t *pool_base = aic->bus_pool_base(bus);
> @@ -418,7 +418,7 @@ static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
>       uint32_t reg_intr_sts = aspeed_i2c_bus_intr_sts_offset(bus);
>       uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
>       if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_BUFF_EN)) {
> -        count = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl, TX_COUNT);
> +        count = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl, TX_COUNT) + 1;
>       } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_DMA_EN)) {
>           count = bus->regs[reg_dma_len];
>       } else { /* BYTE mode */
> @@ -490,7 +490,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>            */
>           if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_BUFF_EN)) {
>               if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl, TX_COUNT)
> -                == 1) {
> +                == 0) {
>                   SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, M_TX_CMD, 0);
>               } else {
>                   /*
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index 51c944efea..2e1e15aaf0 100644
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



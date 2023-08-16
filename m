Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D25C77DC5D
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 10:35:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWByL-000646-0X; Wed, 16 Aug 2023 04:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=V02R=EB=kaod.org=clg@ozlabs.org>)
 id 1qWBy3-00062X-Fk; Wed, 16 Aug 2023 04:33:29 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=V02R=EB=kaod.org=clg@ozlabs.org>)
 id 1qWBxz-0006E7-Ls; Wed, 16 Aug 2023 04:33:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RQhGv4v2jz4wy3;
 Wed, 16 Aug 2023 18:33:11 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQhGq6Wkbz4wxN;
 Wed, 16 Aug 2023 18:33:07 +1000 (AEST)
Message-ID: <1780d401-ffe0-d1a6-54cf-93709848b056@kaod.org>
Date: Wed, 16 Aug 2023 10:33:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] hw/i2c/aspeed: Fix TXBUF transmission start
 position error
Content-Language: en-US
To: Hang Yu <francis_yuu@stu.pku.edu.cn>, qemu-devel@nongnu.org
Cc: komlodi@google.com, peter@pjd.dev,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, qemu-stable@nongnu.org
References: <20230812065230.8839-1-francis_yuu@stu.pku.edu.cn>
 <20230812065230.8839-3-francis_yuu@stu.pku.edu.cn>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230812065230.8839-3-francis_yuu@stu.pku.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=V02R=EB=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-1.045, SPF_HELO_PASS=-0.001,
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
> According to the ast2600 datasheet and the linux aspeed i2c driver,
> the TXBUF transmission start position should be TXBUF[0] instead
> of TXBUF[1],so the arg pool_start is useless,and the address is not
> included in TXBUF.So even if Tx Count equals zero,there is at least
> 1 byte data needs to be transmitted,and M_TX_CMD should not be cleared
> at this condition.The driver url is:
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v5.15/drivers/i2c/busses/i2c-ast2600.c
> 
> Signed-off-by: Hang Yu <francis_yuu@stu.pku.edu.cn>

This is -stable material with the previous patch. It fixes support for
the v08.06 SDK.

Fixes: 6054fc73e8f4 ("aspeed/i2c: Add support for pool buffer transfers")

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
> v2-->v3:
> No change.
> 
>   hw/i2c/aspeed_i2c.c | 30 ++++++------------------------
>   1 file changed, 6 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index e485d8bfb8..44905d7899 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -226,7 +226,7 @@ static int aspeed_i2c_dma_read(AspeedI2CBus *bus, uint8_t *data)
>       return 0;
>   }
>   
> -static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
> +static int aspeed_i2c_bus_send(AspeedI2CBus *bus)
>   {
>       AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
>       int ret = -1;
> @@ -239,7 +239,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
>                                                   TX_COUNT) + 1;
>   
>       if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_BUFF_EN)) {
> -        for (i = pool_start; i < pool_tx_count; i++) {
> +        for (i = 0; i < pool_tx_count; i++) {
>               uint8_t *pool_base = aic->bus_pool_base(bus);
>   
>               trace_aspeed_i2c_bus_send("BUF", i + 1, pool_tx_count,
> @@ -273,7 +273,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
>           }
>           SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, TX_DMA_EN, 0);
>       } else {
> -        trace_aspeed_i2c_bus_send("BYTE", pool_start, 1,
> +        trace_aspeed_i2c_bus_send("BYTE", 0, 1,
>                                     bus->regs[reg_byte_buf]);
>           ret = i2c_send(bus->bus, bus->regs[reg_byte_buf]);
>       }
> @@ -446,10 +446,8 @@ static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
>    */
>   static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>   {
> -    uint8_t pool_start = 0;
>       uint32_t reg_intr_sts = aspeed_i2c_bus_intr_sts_offset(bus);
>       uint32_t reg_cmd = aspeed_i2c_bus_cmd_offset(bus);
> -    uint32_t reg_pool_ctrl = aspeed_i2c_bus_pool_ctrl_offset(bus);
>       uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
>   
>       if (!aspeed_i2c_check_sram(bus)) {
> @@ -483,27 +481,11 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>   
>           SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, M_START_CMD, 0);
>   
> -        /*
> -         * The START command is also a TX command, as the slave
> -         * address is sent on the bus. Drop the TX flag if nothing
> -         * else needs to be sent in this sequence.
> -         */
> -        if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_BUFF_EN)) {
> -            if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl, TX_COUNT)
> -                == 0) {
> -                SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, M_TX_CMD, 0);
> -            } else {
> -                /*
> -                 * Increase the start index in the TX pool buffer to
> -                 * skip the address byte.
> -                 */
> -                pool_start++;
> -            }
> -        } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_DMA_EN)) {
> +        if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_DMA_EN)) {
>               if (bus->regs[reg_dma_len] == 0) {
>                   SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, M_TX_CMD, 0);
>               }
> -        } else {
> +        } else if (!SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, TX_BUFF_EN)) {
>               SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, M_TX_CMD, 0);
>           }
>   
> @@ -520,7 +502,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>   
>       if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, M_TX_CMD)) {
>           aspeed_i2c_set_state(bus, I2CD_MTXD);
> -        if (aspeed_i2c_bus_send(bus, pool_start)) {
> +        if (aspeed_i2c_bus_send(bus)) {
>               SHARED_ARRAY_FIELD_DP32(bus->regs, reg_intr_sts, TX_NAK, 1);
>               i2c_end_transfer(bus->bus);
>           } else {



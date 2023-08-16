Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7715777DC5F
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 10:35:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWByM-00064K-BK; Wed, 16 Aug 2023 04:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=V02R=EB=kaod.org=clg@ozlabs.org>)
 id 1qWByB-00062w-Fc; Wed, 16 Aug 2023 04:33:37 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=V02R=EB=kaod.org=clg@ozlabs.org>)
 id 1qWBy9-0006FS-3h; Wed, 16 Aug 2023 04:33:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RQhHG4K6rz4wxy;
 Wed, 16 Aug 2023 18:33:30 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQhHC5trfz4wxN;
 Wed, 16 Aug 2023 18:33:27 +1000 (AEST)
Message-ID: <0a693a50-1e27-d5d4-2036-fa580def0557@kaod.org>
Date: Wed, 16 Aug 2023 10:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] hw/i2c/aspeed: Add support for buffer organization
Content-Language: en-US
To: Hang Yu <francis_yuu@stu.pku.edu.cn>, qemu-devel@nongnu.org
Cc: komlodi@google.com, peter@pjd.dev,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
References: <20230812065230.8839-1-francis_yuu@stu.pku.edu.cn>
 <20230812065230.8839-4-francis_yuu@stu.pku.edu.cn>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230812065230.8839-4-francis_yuu@stu.pku.edu.cn>
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
> Added support for the buffer organization option in pool buffer control
> register.when set to 1,The buffer is split into two parts: Lower 16 bytes
> for Tx and higher 16 bytes for Rx.
> 
> Signed-off-by: Hang Yu <francis_yuu@stu.pku.edu.cn>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
> v2-->v3:
> 1. Fixed typos
> 2. Simplified the judgment logic of buffer organization.
> 3. Change the buffer organization field to a shared field, and move it
> from I2CC_POOL_CTRL to I2CD_POOL_CTRL.
> 
>   hw/i2c/aspeed_i2c.c         | 3 +++
>   include/hw/i2c/aspeed_i2c.h | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 44905d7899..5d84797027 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -297,6 +297,9 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>   
>       if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_BUFF_EN)) {
>           uint8_t *pool_base = aic->bus_pool_base(bus);
> +        if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl, BUF_ORGANIZATION)) {
> +            pool_base += 16;
> +        }
>   
>           for (i = 0; i < pool_rx_count; i++) {
>               pool_base[i] = i2c_recv(bus->bus);
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index 2e1e15aaf0..a064479e59 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -143,6 +143,7 @@ REG32(I2CD_POOL_CTRL, 0x1C) /* Pool Buffer Control */
>       SHARED_FIELD(RX_SIZE, 16, 5)
>       SHARED_FIELD(TX_COUNT, 8, 5)
>       FIELD(I2CD_POOL_CTRL, OFFSET, 2, 6) /* AST2400 */
> +    SHARED_FIELD(BUF_ORGANIZATION, 0, 1) /* AST2600 */
>   REG32(I2CD_BYTE_BUF, 0x20) /* Transmit/Receive Byte Buffer */
>       SHARED_FIELD(RX_BUF, 8, 8)
>       SHARED_FIELD(TX_BUF, 0, 8)



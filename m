Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D03F1778A9A
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 12:03:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUOzd-0002sk-PW; Fri, 11 Aug 2023 06:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qHib=D4=kaod.org=clg@ozlabs.org>)
 id 1qUOza-0002XU-M0; Fri, 11 Aug 2023 06:03:38 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qHib=D4=kaod.org=clg@ozlabs.org>)
 id 1qUOzY-0002bl-DY; Fri, 11 Aug 2023 06:03:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RMfWR2nPQz4wy4;
 Fri, 11 Aug 2023 20:03:31 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RMfWP0mkyz4wbj;
 Fri, 11 Aug 2023 20:03:28 +1000 (AEST)
Message-ID: <f0bb3402-2681-c043-823f-6ede6673fbc2@kaod.org>
Date: Fri, 11 Aug 2023 12:03:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/4] hw/i2c/aspeed: Add support for BUFFER ORGANIZATION
 in new register mode
Content-Language: en-US
To: Hang Yu <francis_yuu@stu.pku.edu.cn>, qemu-devel@nongnu.org
Cc: komlodi@google.com, peter@pjd.dev,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
References: <20230811054220.99562-1-francis_yuu@stu.pku.edu.cn>
 <20230811054220.99562-4-francis_yuu@stu.pku.edu.cn>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230811054220.99562-4-francis_yuu@stu.pku.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=qHib=D4=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.156, SPF_HELO_PASS=-0.001,
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

On 8/11/23 07:42, Hang Yu wrote:
> Added support for the BUFFER ORGANIZATION option in reg I2CC_POOL_CTRL,

BUFFER ORGANIZATION could be lower case

> when set to 1,The buffer is split into two parts: Lower 16 bytes for Tx
> and higher 16 bytes for Rx.
> 
> Signed-off-by: Hang Yu <francis_yuu@stu.pku.edu.cn>
> ---
>   hw/i2c/aspeed_i2c.c         | 7 ++++++-
>   include/hw/i2c/aspeed_i2c.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 44905d7899..26fefb8f9e 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -296,7 +296,12 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>                                                   RX_SIZE) + 1;
>   
>       if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_BUFF_EN)) {
> -        uint8_t *pool_base = aic->bus_pool_base(bus);
> +        uint8_t *pool_base;
> +        if (ARRAY_FIELD_EX32(bus->regs, I2CC_POOL_CTRL, BUF_ORGANIZATION)) {
> +            pool_base = aic->bus_pool_base(bus) + 16;
> +        } else {
> +            pool_base = aic->bus_pool_base(bus);
> +        }

or simply add :

         if (ARRAY_FIELD_EX32(bus->regs, I2CC_POOL_CTRL, BUF_ORGANIZATION)) {
             pool_base += 16;
	}


>   
>           for (i = 0; i < pool_rx_count; i++) {
>               pool_base[i] = i2c_recv(bus->bus);
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index 2e1e15aaf0..88b144a599 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -162,6 +162,7 @@ REG32(I2CC_MS_TXRX_BYTE_BUF, 0x08)
>       /* 15:0  shared with I2CD_BYTE_BUF[15:0] */
>   REG32(I2CC_POOL_CTRL, 0x0c)
>       /* 31:0 shared with I2CD_POOL_CTRL[31:0] */
> +    FIELD(I2CC_POOL_CTRL, BUF_ORGANIZATION, 0, 1) /* AST2600 */
>   REG32(I2CM_INTR_CTRL, 0x10)
>   REG32(I2CM_INTR_STS, 0x14)
>       FIELD(I2CM_INTR_STS, PKT_STATE, 28, 4)



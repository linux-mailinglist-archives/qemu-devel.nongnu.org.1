Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C770D222
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 05:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1IH2-0002Zq-Eg; Mon, 22 May 2023 23:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qianfanguijin@163.com>)
 id 1q1IGz-0002ZR-L9; Mon, 22 May 2023 23:01:17 -0400
Received: from m12.mail.163.com ([220.181.12.216])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qianfanguijin@163.com>)
 id 1q1IGu-00088I-Tc; Mon, 22 May 2023 23:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
 Content-Type; bh=bD7LCmjarHc3GspW/K/ywaTnvTlvW7tewcROnSzG1kA=;
 b=hPH4SRIzsQFPRnR8Sr4Ys3+ujh+wrZOK29Rf5W5PJKp65AYbAq/4SlzihHwmDy
 O2wHixli3hSmy2/VTuHa5WRx8vW0x7ehDLa+wJeFWMUk4QhgyG2IiXbjdr4DJPJo
 oSZ/ekK+KBNtCKekQb22U6g7Yt1aD/q6IpW+dXVCI98BU=
Received: from [172.21.25.67] (unknown [218.201.129.19])
 by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wC3v9tLLGxkqpuFAQ--.9305S2; 
 Tue, 23 May 2023 11:00:28 +0800 (CST)
Message-ID: <e321de21-0fbb-ca0b-b449-4752d7633625@163.com>
Date: Tue, 23 May 2023 11:00:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 03/11] hw: allwinner-r40: Complete uart devices
Content-Language: en-US
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230510103004.30015-1-qianfanguijin@163.com>
 <20230510103004.30015-4-qianfanguijin@163.com>
 <CAPan3WrHGhcTWh5R3Uw1BFuVmTLf=jbXpTKTWSz0qNx8JrPszw@mail.gmail.com>
From: qianfan <qianfanguijin@163.com>
In-Reply-To: <CAPan3WrHGhcTWh5R3Uw1BFuVmTLf=jbXpTKTWSz0qNx8JrPszw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3v9tLLGxkqpuFAQ--.9305S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy8Ww4DWrWfAr15Cw4DArb_yoWrWry8pr
 s0k390gr4jgw1fArWxKws3XrWSyF18Gr12ya42kayUtF1UXr40qrWIqa15Gr43Krs3GFW7
 Zr95Kr47W3W2qwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTHqxUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiGhF47VaEFUeF3QAAsG
Received-SPF: pass client-ip=220.181.12.216;
 envelope-from=qianfanguijin@163.com; helo=m12.mail.163.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



在 2023/5/15 2:55, Niek Linnenbank 写道:
> Hi Qianfan,
>
>
> On Wed, May 10, 2023 at 12:30 PM <qianfanguijin@163.com> wrote:
>
>     From: qianfan Zhao <qianfanguijin@163.com>
>
>     R40 has eight UARTs, support both 16450 and 16550 compatible modes.
>
>     Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
>     ---
>      hw/arm/allwinner-r40.c         | 31 ++++++++++++++++++++++++++++---
>      include/hw/arm/allwinner-r40.h |  8 ++++++++
>      2 files changed, 36 insertions(+), 3 deletions(-)
>
>     diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
>     index 128c0ca470..537a90b23d 100644
>     --- a/hw/arm/allwinner-r40.c
>     +++ b/hw/arm/allwinner-r40.c
>     @@ -45,6 +45,13 @@ const hwaddr allwinner_r40_memmap[] = {
>          [AW_R40_DEV_CCU]        = 0x01c20000,
>          [AW_R40_DEV_PIT]        = 0x01c20c00,
>          [AW_R40_DEV_UART0]      = 0x01c28000,
>     +    [AW_R40_DEV_UART1]      = 0x01c28400,
>     +    [AW_R40_DEV_UART2]      = 0x01c28800,
>     +    [AW_R40_DEV_UART3]      = 0x01c28c00,
>     +    [AW_R40_DEV_UART4]      = 0x01c29000,
>     +    [AW_R40_DEV_UART5]      = 0x01c29400,
>     +    [AW_R40_DEV_UART6]      = 0x01c29800,
>     +    [AW_R40_DEV_UART7]      = 0x01c29c00,
>
>
> After adding the uarts to the memory map here, you should remove them 
> from the unimplemented array.
Hi:

I had tried this including remove UART0 from allwinner_r40_memmap, but 
that will make qemu
for R40 doesn't work again. Only a few registers are implemented in 
hw/char/serial.c,
so we still need this.
>
>          [AW_R40_DEV_GIC_DIST]   = 0x01c81000,
>          [AW_R40_DEV_GIC_CPU]    = 0x01c82000,
>          [AW_R40_DEV_GIC_HYP]    = 0x01c84000,
>     @@ -160,6 +167,10 @@ enum {
>          AW_R40_GIC_SPI_UART1     =  2,
>          AW_R40_GIC_SPI_UART2     =  3,
>          AW_R40_GIC_SPI_UART3     =  4,
>
>
> Since you put the addition of UART1-7 in this patch, probably it makes 
> sense to have adding the lines 'AW_R40_GIC_SPI_UART1/2/3' also part of 
> this patch.
>
> With the two above remarks resolved, the patch looks good to me.
>
> Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>
> Regards,
> Niek
>
>     +    AW_R40_GIC_SPI_UART4     = 17,
>     +    AW_R40_GIC_SPI_UART5     = 18,
>     +    AW_R40_GIC_SPI_UART6     = 19,
>     +    AW_R40_GIC_SPI_UART7     = 20,
>          AW_R40_GIC_SPI_TIMER0    = 22,
>          AW_R40_GIC_SPI_TIMER1    = 23,
>          AW_R40_GIC_SPI_MMC0      = 32,
>     @@ -387,9 +398,23 @@ static void allwinner_r40_realize(DeviceState
>     *dev, Error **errp)
>          }
>
>          /* UART0. For future clocktree API: All UARTS are connected
>     to APB2_CLK. */
>     -    serial_mm_init(get_system_memory(),
>     s->memmap[AW_R40_DEV_UART0], 2,
>     -                   qdev_get_gpio_in(DEVICE(&s->gic),
>     AW_R40_GIC_SPI_UART0),
>     -                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
>     +    for (int i = 0; i < AW_R40_NUM_UARTS; i++) {
>     +        static const int uart_irqs[AW_R40_NUM_UARTS] = {
>     +            AW_R40_GIC_SPI_UART0,
>     +            AW_R40_GIC_SPI_UART1,
>     +            AW_R40_GIC_SPI_UART2,
>     +            AW_R40_GIC_SPI_UART3,
>     +            AW_R40_GIC_SPI_UART4,
>     +            AW_R40_GIC_SPI_UART5,
>     +            AW_R40_GIC_SPI_UART6,
>     +            AW_R40_GIC_SPI_UART7,
>     +        };
>     +        const hwaddr addr = s->memmap[AW_R40_DEV_UART0 + i];
>     +
>     +        serial_mm_init(get_system_memory(), addr, 2,
>     +  qdev_get_gpio_in(DEVICE(&s->gic), uart_irqs[i]),
>     +                       115200, serial_hd(i), DEVICE_NATIVE_ENDIAN);
>     +    }
>
>          /* Unimplemented devices */
>          for (i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
>     diff --git a/include/hw/arm/allwinner-r40.h
>     b/include/hw/arm/allwinner-r40.h
>     index 3be9dc962b..959b5dc4e0 100644
>     --- a/include/hw/arm/allwinner-r40.h
>     +++ b/include/hw/arm/allwinner-r40.h
>     @@ -41,6 +41,13 @@ enum {
>          AW_R40_DEV_CCU,
>          AW_R40_DEV_PIT,
>          AW_R40_DEV_UART0,
>     +    AW_R40_DEV_UART1,
>     +    AW_R40_DEV_UART2,
>     +    AW_R40_DEV_UART3,
>     +    AW_R40_DEV_UART4,
>     +    AW_R40_DEV_UART5,
>     +    AW_R40_DEV_UART6,
>     +    AW_R40_DEV_UART7,
>          AW_R40_DEV_GIC_DIST,
>          AW_R40_DEV_GIC_CPU,
>          AW_R40_DEV_GIC_HYP,
>     @@ -70,6 +77,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AwR40State, AW_R40)
>       * which are currently emulated by the R40 SoC code.
>       */
>      #define AW_R40_NUM_MMCS         4
>     +#define AW_R40_NUM_UARTS        8
>
>      struct AwR40State {
>          /*< private >*/
>     -- 
>     2.25.1
>
>
>
> -- 
> Niek Linnenbank
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B25487C56CF
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:28:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaBn-0001Ig-Ao; Wed, 11 Oct 2023 10:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=T27U=FZ=kaod.org=clg@ozlabs.org>)
 id 1qqaBd-0001Hz-7V; Wed, 11 Oct 2023 10:27:45 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=T27U=FZ=kaod.org=clg@ozlabs.org>)
 id 1qqaBY-0003Mp-W4; Wed, 11 Oct 2023 10:27:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S5FTv3n7mz4xZl;
 Thu, 12 Oct 2023 01:27:31 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S5FTs6HmMz4xWt;
 Thu, 12 Oct 2023 01:27:29 +1100 (AEDT)
Message-ID: <e5d37f40-fcf1-5843-ea66-d50fa2353424@kaod.org>
Date: Wed, 11 Oct 2023 16:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] misc/pca9552: Fix inverted input status
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, andrew@codeconstruct.com.au,
 Joel Stanley <joel@jms.id.au>
References: <20230927203221.3286895-1-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230927203221.3286895-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=T27U=FZ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.339,
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

On 9/27/23 22:32, Glenn Miles wrote:
> The pca9552 INPUT0 and INPUT1 registers are supposed to
> hold the logical values of the LED pins.  A logical 0
> should be seen in the INPUT0/1 registers for a pin when
> its corresponding LSn bits are set to 0, which is also
> the state needed for turning on an LED in a typical
> usage scenario.  Existing code was doing the opposite
> and setting INPUT0/1 bit to a 1 when the LSn bit was
> set to 0, so this commit fixes that.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>

Looks OK to me.

May be you could mention that the ON/OFF values are reversed on
the pca953x family. This is good to know if one wants to model
these devices one day.

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/misc/pca9552.c          | 13 +++++++++----
>   tests/qtest/pca9552-test.c |  6 +++---
>   2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index fff19e369a..ad811fb249 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -112,13 +112,18 @@ static void pca955x_update_pin_input(PCA955xState *s)
>   
>           switch (config) {
>           case PCA9552_LED_ON:
> -            qemu_set_irq(s->gpio[i], 1);
> -            s->regs[input_reg] |= 1 << input_shift;
> -            break;
> -        case PCA9552_LED_OFF:
> +            /* Pin is set to 0V to turn on LED */
>               qemu_set_irq(s->gpio[i], 0);
>               s->regs[input_reg] &= ~(1 << input_shift);
>               break;
> +        case PCA9552_LED_OFF:
> +            /*
> +             * Pin is set to Hi-Z to turn off LED and
> +             * pullup sets it to a logical 1.
> +             */
> +            qemu_set_irq(s->gpio[i], 1);
> +            s->regs[input_reg] |= 1 << input_shift;
> +            break;
>           case PCA9552_LED_PWM0:
>           case PCA9552_LED_PWM1:
>               /* TODO */
> diff --git a/tests/qtest/pca9552-test.c b/tests/qtest/pca9552-test.c
> index d80ed93cd3..ccca2b3d91 100644
> --- a/tests/qtest/pca9552-test.c
> +++ b/tests/qtest/pca9552-test.c
> @@ -60,7 +60,7 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
>       g_assert_cmphex(value, ==, 0x55);
>   
>       value = i2c_get8(i2cdev, PCA9552_INPUT0);
> -    g_assert_cmphex(value, ==, 0x0);
> +    g_assert_cmphex(value, ==, 0xFF);
>   
>       pca9552_init(i2cdev);
>   
> @@ -68,13 +68,13 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
>       g_assert_cmphex(value, ==, 0x54);
>   
>       value = i2c_get8(i2cdev, PCA9552_INPUT0);
> -    g_assert_cmphex(value, ==, 0x01);
> +    g_assert_cmphex(value, ==, 0xFE);
>   
>       value = i2c_get8(i2cdev, PCA9552_LS3);
>       g_assert_cmphex(value, ==, 0x54);
>   
>       value = i2c_get8(i2cdev, PCA9552_INPUT1);
> -    g_assert_cmphex(value, ==, 0x10);
> +    g_assert_cmphex(value, ==, 0xEF);
>   }
>   
>   static void pca9552_register_nodes(void)



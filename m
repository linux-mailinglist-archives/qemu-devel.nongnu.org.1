Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E667C5A0B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 19:07:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqcen-0004xA-Ls; Wed, 11 Oct 2023 13:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=T27U=FZ=kaod.org=clg@ozlabs.org>)
 id 1qqcel-0004wU-MG; Wed, 11 Oct 2023 13:05:59 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=T27U=FZ=kaod.org=clg@ozlabs.org>)
 id 1qqcej-00040W-2t; Wed, 11 Oct 2023 13:05:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S5K0Z2mqQz4xPY;
 Thu, 12 Oct 2023 04:05:50 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S5K0X2Dqsz4xPh;
 Thu, 12 Oct 2023 04:05:48 +1100 (AEDT)
Message-ID: <08fe62cf-7301-6f44-4239-2dd76a2436cf@kaod.org>
Date: Wed, 11 Oct 2023 19:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] misc/pca9552: Let external devices set pca9552 inputs
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, andrew@codeconstruct.com.au,
 Joel Stanley <joel@jms.id.au>
References: <20231005204129.3522685-1-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231005204129.3522685-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/5/23 22:41, Glenn Miles wrote:
> Allow external devices to drive pca9552 input pins by adding
> input GPIO's to the model.  This allows a device to connect
> its output GPIO's to the pca9552 input GPIO's.
> 
> In order for an external device to set the state of a pca9552
> pin, the pin must first be configured for high impedance (LED
> is off).  If the pca9552 pin is configured to drive the pin low
> (LED is on), then external input will be ignored.
> 
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>

Why an extra ext_state array ? The input handler should simply update
the PCA9552_INPUT* registers if the PCA9552_LS* register is programmed
in input mode ?

It would be nice to add some test case also.

Thanks,

C.



> ---
> Based-on: <20230927203221.3286895-1-milesg@linux.vnet.ibm.com>
> ([PATCH] misc/pca9552: Fix inverted input status)
>   hw/misc/pca9552.c         | 39 ++++++++++++++++++++++++++++++++++-----
>   include/hw/misc/pca9552.h |  3 ++-
>   2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index ad811fb249..f28b5ecd7e 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -113,16 +113,22 @@ static void pca955x_update_pin_input(PCA955xState *s)
>           switch (config) {
>           case PCA9552_LED_ON:
>               /* Pin is set to 0V to turn on LED */
> -            qemu_set_irq(s->gpio[i], 0);
> +            qemu_set_irq(s->gpio_out[i], 0);
>               s->regs[input_reg] &= ~(1 << input_shift);
>               break;
>           case PCA9552_LED_OFF:
>               /*
>                * Pin is set to Hi-Z to turn off LED and
> -             * pullup sets it to a logical 1.
> +             * pullup sets it to a logical 1 unless
> +             * external device drives it low.
>                */
> -            qemu_set_irq(s->gpio[i], 1);
> -            s->regs[input_reg] |= 1 << input_shift;
> +            if (s->ext_state[i] == 0) {
> +                qemu_set_irq(s->gpio_out[i], 0);
> +                s->regs[input_reg] &= ~(1 << input_shift);
> +            } else {
> +                qemu_set_irq(s->gpio_out[i], 1);
> +                s->regs[input_reg] |= 1 << input_shift;
> +            }
>               break;
>           case PCA9552_LED_PWM0:
>           case PCA9552_LED_PWM1:
> @@ -337,6 +343,7 @@ static const VMStateDescription pca9552_vmstate = {
>           VMSTATE_UINT8(len, PCA955xState),
>           VMSTATE_UINT8(pointer, PCA955xState),
>           VMSTATE_UINT8_ARRAY(regs, PCA955xState, PCA955X_NR_REGS),
> +        VMSTATE_UINT8_ARRAY(ext_state, PCA955xState, PCA955X_PIN_COUNT_MAX),
>           VMSTATE_I2C_SLAVE(i2c, PCA955xState),
>           VMSTATE_END_OF_LIST()
>       }
> @@ -355,6 +362,7 @@ static void pca9552_reset(DeviceState *dev)
>       s->regs[PCA9552_LS2] = 0x55;
>       s->regs[PCA9552_LS3] = 0x55;
>   
> +    memset(s->ext_state, 1, PCA955X_PIN_COUNT_MAX);
>       pca955x_update_pin_input(s);
>   
>       s->pointer = 0xFF;
> @@ -377,6 +385,26 @@ static void pca955x_initfn(Object *obj)
>       }
>   }
>   
> +static void pca955x_set_ext_state(PCA955xState *s, int pin, int level)
> +{
> +    if (s->ext_state[pin] != level) {
> +        uint16_t pins_status = pca955x_pins_get_status(s);
> +        s->ext_state[pin] = level;
> +        pca955x_update_pin_input(s);
> +        pca955x_display_pins_status(s, pins_status);
> +    }
> +}
> +
> +static void pca955x_gpio_in_handler(void *opaque, int pin, int level)
> +{
> +
> +    PCA955xState *s = PCA955X(opaque);
> +    PCA955xClass *k = PCA955X_GET_CLASS(s);
> +
> +    assert((pin >= 0) && (pin < k->pin_count));
> +    pca955x_set_ext_state(s, pin, level);
> +}
> +
>   static void pca955x_realize(DeviceState *dev, Error **errp)
>   {
>       PCA955xClass *k = PCA955X_GET_CLASS(dev);
> @@ -386,7 +414,8 @@ static void pca955x_realize(DeviceState *dev, Error **errp)
>           s->description = g_strdup("pca-unspecified");
>       }
>   
> -    qdev_init_gpio_out(dev, s->gpio, k->pin_count);
> +    qdev_init_gpio_out(dev, s->gpio_out, k->pin_count);
> +    qdev_init_gpio_in(dev, pca955x_gpio_in_handler, k->pin_count);
>   }
>   
>   static Property pca955x_properties[] = {
> diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
> index b6f4e264fe..c36525f0c3 100644
> --- a/include/hw/misc/pca9552.h
> +++ b/include/hw/misc/pca9552.h
> @@ -30,7 +30,8 @@ struct PCA955xState {
>       uint8_t pointer;
>   
>       uint8_t regs[PCA955X_NR_REGS];
> -    qemu_irq gpio[PCA955X_PIN_COUNT_MAX];
> +    qemu_irq gpio_out[PCA955X_PIN_COUNT_MAX];
> +    uint8_t ext_state[PCA955X_PIN_COUNT_MAX];
>       char *description; /* For debugging purpose only */
>   };
>   



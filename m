Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2948B7BFB7C
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:32:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBue-0006Lv-Qr; Tue, 10 Oct 2023 08:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qqBuY-0006IC-IW; Tue, 10 Oct 2023 08:32:30 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qqBuW-0008KW-8z; Tue, 10 Oct 2023 08:32:30 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-41b2bf4e9edso8467681cf.1; 
 Tue, 10 Oct 2023 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1696941146; x=1697545946; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnNg1WWEKE4nbQnSe80qpKag1DGJWcbRH3ffujcOVKg=;
 b=IjHqmVYvrSqKVJ4eQ3VL/ay9lYdORtGF0EbS+2th2p/IaT5k/LkZ02nrjUkXSC15Xj
 l5SurQgvD26jlghKvg6BKJwHClKNzo2OC83uMxuXWw7QUJVHbl/+qGv9/ek9D6xUECMl
 An751e1z8b8jNHm7HWCMZR7omVxpLo47rle24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696941146; x=1697545946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fnNg1WWEKE4nbQnSe80qpKag1DGJWcbRH3ffujcOVKg=;
 b=X7r8Kb77GoRkiFwEiyIccLUhBTCah9oY8lB0lEe5h1k4dGWPqSp+qhpdgIhQd+2klD
 Nnu75Z2m9H2vaziloDAoVP40T9KEejWczRaT4GJDpQLOTUokWN8BxoAFiv03fnbvKvaf
 8WcaxM9Lss6tILn2jxbxYIxyrWGpUCvrYMVdsXZ2GzJHQVBnEaoZ7mbB2TD178lcoiK2
 jTNIXAbkfBA17GKyfcxKZpt/iUuQ+s+tk5xNIIMlDzvkPQMlIBs33de7Qy0sE2Rd2TXq
 KWuTDmduf/w2VQWdeL9arBk7WNz+4xYGAWL4DlKtLuMtsuqBmtDfIq0Puxc14du3ABXa
 BQtw==
X-Gm-Message-State: AOJu0Yy1gffa3/EylK3EqGuqmP3Tui9hlgvuGxkBVOoc2e29d/2OziQy
 UrYmsTusjUKadOQRDf01HFJErftuSFFChjJddJg=
X-Google-Smtp-Source: AGHT+IF1mbKI0muT+a740RrkUnR9gLPC06ldWjq9lz0pi0b1IaAwfX0OYQrjDysu8WSS+Mxntxo3SmRxpoTgvQ+qKlw=
X-Received: by 2002:a05:622a:142:b0:412:1c5f:478b with SMTP id
 v2-20020a05622a014200b004121c5f478bmr21741987qtw.15.1696941146469; Tue, 10
 Oct 2023 05:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231005204129.3522685-1-milesg@linux.vnet.ibm.com>
In-Reply-To: <20231005204129.3522685-1-milesg@linux.vnet.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 10 Oct 2023 23:02:13 +1030
Message-ID: <CACPK8XfLSBGJvV340SN3V442YgRNS3rHXSDGFeGAyx5r1wE-9A@mail.gmail.com>
Subject: Re: [PATCH v2] misc/pca9552: Let external devices set pca9552 inputs
To: Glenn Miles <milesg@linux.vnet.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, andrew@codeconstruct.com.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=joel.stan@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 6 Oct 2023 at 07:23, Glenn Miles <milesg@linux.vnet.ibm.com> wrote:
>
> Allow external devices to drive pca9552 input pins by adding
> input GPIO's to the model.  This allows a device to connect
> its output GPIO's to the pca9552 input GPIO's.
>
> In order for an external device to set the state of a pca9552
> pin, the pin must first be configured for high impedance (LED
> is off).  If the pca9552 pin is configured to drive the pin low
> (LED is on), then external input will be ignored.

Does this let us use qom-set from the monitor, and have the guest see
the state change?

An example in the commit message, or even better would be a test.

Some other comments below.

>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
> Based-on: <20230927203221.3286895-1-milesg@linux.vnet.ibm.com>
> ([PATCH] misc/pca9552: Fix inverted input status)
>  hw/misc/pca9552.c         | 39 ++++++++++++++++++++++++++++++++++-----
>  include/hw/misc/pca9552.h |  3 ++-
>  2 files changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index ad811fb249..f28b5ecd7e 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -113,16 +113,22 @@ static void pca955x_update_pin_input(PCA955xState *=
s)
>          switch (config) {
>          case PCA9552_LED_ON:
>              /* Pin is set to 0V to turn on LED */
> -            qemu_set_irq(s->gpio[i], 0);
> +            qemu_set_irq(s->gpio_out[i], 0);
>              s->regs[input_reg] &=3D ~(1 << input_shift);
>              break;
>          case PCA9552_LED_OFF:
>              /*
>               * Pin is set to Hi-Z to turn off LED and
> -             * pullup sets it to a logical 1.
> +             * pullup sets it to a logical 1 unless
> +             * external device drives it low.
>               */
> -            qemu_set_irq(s->gpio[i], 1);
> -            s->regs[input_reg] |=3D 1 << input_shift;
> +            if (s->ext_state[i] =3D=3D 0) {
> +                qemu_set_irq(s->gpio_out[i], 0);
> +                s->regs[input_reg] &=3D ~(1 << input_shift);
> +            } else {
> +                qemu_set_irq(s->gpio_out[i], 1);
> +                s->regs[input_reg] |=3D 1 << input_shift;
> +            }
>              break;
>          case PCA9552_LED_PWM0:
>          case PCA9552_LED_PWM1:
> @@ -337,6 +343,7 @@ static const VMStateDescription pca9552_vmstate =3D {
>          VMSTATE_UINT8(len, PCA955xState),
>          VMSTATE_UINT8(pointer, PCA955xState),
>          VMSTATE_UINT8_ARRAY(regs, PCA955xState, PCA955X_NR_REGS),
> +        VMSTATE_UINT8_ARRAY(ext_state, PCA955xState, PCA955X_PIN_COUNT_M=
AX),
>          VMSTATE_I2C_SLAVE(i2c, PCA955xState),
>          VMSTATE_END_OF_LIST()
>      }
> @@ -355,6 +362,7 @@ static void pca9552_reset(DeviceState *dev)
>      s->regs[PCA9552_LS2] =3D 0x55;
>      s->regs[PCA9552_LS3] =3D 0x55;
>
> +    memset(s->ext_state, 1, PCA955X_PIN_COUNT_MAX);
>      pca955x_update_pin_input(s);
>
>      s->pointer =3D 0xFF;
> @@ -377,6 +385,26 @@ static void pca955x_initfn(Object *obj)
>      }
>  }
>
> +static void pca955x_set_ext_state(PCA955xState *s, int pin, int level)
> +{
> +    if (s->ext_state[pin] !=3D level) {
> +        uint16_t pins_status =3D pca955x_pins_get_status(s);
> +        s->ext_state[pin] =3D level;
> +        pca955x_update_pin_input(s);
> +        pca955x_display_pins_status(s, pins_status);
> +    }
> +}
> +
> +static void pca955x_gpio_in_handler(void *opaque, int pin, int level)
> +{
> +
> +    PCA955xState *s =3D PCA955X(opaque);
> +    PCA955xClass *k =3D PCA955X_GET_CLASS(s);
> +
> +    assert((pin >=3D 0) && (pin < k->pin_count));
> +    pca955x_set_ext_state(s, pin, level);
> +}
> +
>  static void pca955x_realize(DeviceState *dev, Error **errp)
>  {
>      PCA955xClass *k =3D PCA955X_GET_CLASS(dev);
> @@ -386,7 +414,8 @@ static void pca955x_realize(DeviceState *dev, Error *=
*errp)
>          s->description =3D g_strdup("pca-unspecified");
>      }
>
> -    qdev_init_gpio_out(dev, s->gpio, k->pin_count);
> +    qdev_init_gpio_out(dev, s->gpio_out, k->pin_count);
> +    qdev_init_gpio_in(dev, pca955x_gpio_in_handler, k->pin_count);
>  }
>
>  static Property pca955x_properties[] =3D {
> diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
> index b6f4e264fe..c36525f0c3 100644
> --- a/include/hw/misc/pca9552.h
> +++ b/include/hw/misc/pca9552.h
> @@ -30,7 +30,8 @@ struct PCA955xState {
>      uint8_t pointer;
>
>      uint8_t regs[PCA955X_NR_REGS];
> -    qemu_irq gpio[PCA955X_PIN_COUNT_MAX];
> +    qemu_irq gpio_out[PCA955X_PIN_COUNT_MAX];

I wondered if the renaming of gpio to gpio_out could be a separate
patch, but once I'd read the entire patch it made sense, so don't
bother.

I think C=C3=A9dric has some magic for sorting the header file changes at
the start of the diff output. Here it is:

https://gitlab.com/qemu-project/qemu/-/blob/master/scripts/git.orderfile?re=
f_type=3Dheads

We should add that to the tips and tricks part of
docs/devel/submitting-a-patch.rst

> +    uint8_t ext_state[PCA955X_PIN_COUNT_MAX];

State is 0 or 1, representing driving the pin low, or high impedance?
I think some #defines or enums would make the states clearer.

>      char *description; /* For debugging purpose only */
>  };
>
> --
> 2.31.1
>
>


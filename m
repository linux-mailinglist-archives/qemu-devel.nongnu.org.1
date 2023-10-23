Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 550B07D4341
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4S5-0003ZT-16; Mon, 23 Oct 2023 19:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qv4S0-0003Yx-10; Mon, 23 Oct 2023 19:35:12 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qv4Rv-0000p4-T8; Mon, 23 Oct 2023 19:35:11 -0400
Received: from [192.168.68.112]
 (ppp118-210-136-142.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.136.142])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 73DD320059;
 Tue, 24 Oct 2023 07:34:52 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1698104094;
 bh=PrhhsoMwtf7fni5RNvl4eHhvdLaa5t3ue7ZCbGm1iBc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=PHvz62yjnvJQvReGzOCwQfQrhQ91nbaIjxddpgt26uJzAYv12YWPn3Q2GAVBiMfS4
 lsFDYzOkWuu+cmn5Mx04UGmQQMRxAGBlNBXX+kays6F9pyOEvf1P4QSDYmSkHPGs+h
 +fTcgI09QMKnSlOYXYhMBpIXDGlEPRV3HbyZ9mMrNYlNvHJt9g6CDwAKj8ogpJsiTs
 l+fMUgPd6jtyf+Vx16LXEdgzrG4MG0Lrs/6kMz4mjuTH38eMFKGTaL6hPlCyEtHT+u
 P/+ydKFDBYPaMPrRyAvNJlq2jbtVKnxjGbZgqeA2DusDn/ttB3NvUUZkKUCzMl8FaF
 P/Rm+tMTaPzQw==
Message-ID: <47ec73eb44a8b5f5cd894f97d1e88677845cbd7a.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] misc/pca9552: Fix inverted input status
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Miles Glenn <milesg@linux.vnet.ibm.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, f4bug@amsat.org
Date: Tue, 24 Oct 2023 10:04:51 +1030
In-Reply-To: <53fccc103ab72cfd93e98fd28bd0a869a43b6a83.camel@linux.vnet.ibm.com>
References: <20231019204011.3174115-1-milesg@linux.vnet.ibm.com>
 <20231019204011.3174115-2-milesg@linux.vnet.ibm.com>
 <e0f36ef6336df26d5c123c5861d6a779c94e3eb9.camel@codeconstruct.com.au>
 <01edf713-6bec-adec-5fa5-5195b5dd4273@linaro.org>
 <53fccc103ab72cfd93e98fd28bd0a869a43b6a83.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Fri, 2023-10-20 at 11:32 -0500, Miles Glenn wrote:
> On Fri, 2023-10-20 at 11:42 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 20/10/23 04:51, Andrew Jeffery wrote:
> > > On Thu, 2023-10-19 at 15:40 -0500, Glenn Miles wrote:
> > > > > The pca9552 INPUT0 and INPUT1 registers are supposed to
> > > > > hold the logical values of the LED pins.  A logical 0
> > > > > should be seen in the INPUT0/1 registers for a pin when
> > > > > its corresponding LSn bits are set to 0, which is also
> > > > > the state needed for turning on an LED in a typical
> > > > > usage scenario.  Existing code was doing the opposite
> > > > > and setting INPUT0/1 bit to a 1 when the LSn bit was
> > > > > set to 0, so this commit fixes that.
> > > > >=20
> > > > > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > > > > ---
> > > > >=20
> > > > > Changes from prior version:
> > > > >      - Added comment regarding pca953X
> > > > >      - Added cover letter
> > > > >=20
> > > > >   hw/misc/pca9552.c          | 18 +++++++++++++-----
> > > > >   tests/qtest/pca9552-test.c |  6 +++---
> > > > >   2 files changed, 16 insertions(+), 8 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> > > > > index fff19e369a..445f56a9e8 100644
> > > > > --- a/hw/misc/pca9552.c
> > > > > +++ b/hw/misc/pca9552.c
> > > > > @@ -36,7 +36,10 @@ typedef struct PCA955xClass PCA955xClass;
> > > > >  =20
> > > > >   DECLARE_CLASS_CHECKERS(PCA955xClass, PCA955X,
> > > > >                          TYPE_PCA955X)
> > > > > -
> > > > > +/*
> > > > > + * Note:  The LED_ON and LED_OFF configuration values for the
> > > > > PCA955X
> > > > > + *        chips are the reverse of the PCA953X family of
> > > > > chips.
> > > > > + */
> > > > >   #define PCA9552_LED_ON   0x0
> > > > >   #define PCA9552_LED_OFF  0x1
> > > > >   #define PCA9552_LED_PWM0 0x2
> > > > > @@ -112,13 +115,18 @@ static void
> > > > > pca955x_update_pin_input(PCA955xState *s)
> > > > >  =20
> > > > >           switch (config) {
> > > > >           case PCA9552_LED_ON:
> > > > > -            qemu_set_irq(s->gpio[i], 1);
> > > > > -            s->regs[input_reg] |=3D 1 << input_shift;
> > > > > -            break;
> > > > > -        case PCA9552_LED_OFF:
> > > > > +            /* Pin is set to 0V to turn on LED */
> > > > >               qemu_set_irq(s->gpio[i], 0);
> > > > >               s->regs[input_reg] &=3D ~(1 << input_shift);
> > > > >               break;
> > > > > +        case PCA9552_LED_OFF:
> > > > > +            /*
> > > > > +             * Pin is set to Hi-Z to turn off LED and
> > > > > +             * pullup sets it to a logical 1.
> > > > > +             */
> > > > > +            qemu_set_irq(s->gpio[i], 1);
> > > > > +            s->regs[input_reg] |=3D 1 << input_shift;
> > > > > +            break;
> > >=20
> > > So the witherspoon-bmc machine was a user of the PCA9552 outputs as
> > > LEDs. I guess its LEDs were in the wrong state the whole time? That
> > > looks like the only user though, and shouldn't be negatively
> > > affected.
> >=20
> > Usually GPIO polarity is a machine/board property, not a device
> > one.
> >=20
> > We could use the LED API (hw/misc/led.h) which initialize each
> > output with GpioPolarity.
> >=20
>=20
> Thanks for your comments!   This piqued my curiosity so I decided to
> run a test with the witherspoon-bmc machine.  Without my changes, I ran
> the following command to turn off LED13 on the pca9552 which I had
> previously set to "on":
>=20
>   qom-set /machine/unattached/device[18] led13 off
>=20
> I had GDB connected at the time with a breakpoint set on
> led_set_state() so that I could see what was happening.  Due to the
> inversion bug, I expected the pca9552 code to set the pin low and also
> set the irq low, which it did.  The connected LED's on this pca9552
> were all configured as GPIO_POLARITY_ACTIVE_LOW, so I expected that
> setting the irq state low would actually turn on the LED.  Instead it
> turned off the LED.
>=20
> Reviewing the LED code, I believe the problem lies here:
>=20
> static void led_set_state_gpio_handler(void *opaque, int line, int
> new_state)
> {
>     LEDState *s =3D LED(opaque);
>=20
>     assert(line =3D=3D 0);
>     led_set_state(s, !!new_state !=3D s->gpio_active_high);
> }
>=20
>=20
> In my test, new_state was 0 and gpio_active_high was 0, resulting in
> the boolean expression of ( 0 !=3D 0 ) which is false and results in
> turning off the LED.  So, this looks like a bug to me.
>=20
> For another simpler example, if the LED polarity was set to
> GPIO_POLARITY_ACTIVE_HIGH, then s->gpio_active_high would be 1.  Then,
> if we set the irq line to 1, wouldn't we expect the LED to turn on?=20
> However, as the code stands, it would actually turn the LED off.  So, I
> think we can remove one of the "!"'s from in front of new_state.  Then,
> if the LED is active high and the irq line is set high, it would turn
> on the LED.  Correct?

Seems reasonable to me. Looks like Philippe added the LED behaviour in
Fddb67f6402b8 ("hw/misc/led: Allow connecting from GPIO output"), so
his input would be helpful. Perhaps send a fix for review?

Andrew


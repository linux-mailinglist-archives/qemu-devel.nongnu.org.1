Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0D7D4368
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:44:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4aS-0001B6-7A; Mon, 23 Oct 2023 19:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qv4aO-0001AM-Tq; Mon, 23 Oct 2023 19:43:53 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qv4aM-0002Dv-LO; Mon, 23 Oct 2023 19:43:52 -0400
Received: from [192.168.68.112]
 (ppp118-210-136-142.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.136.142])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 50ACE20059;
 Tue, 24 Oct 2023 07:43:43 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1698104623;
 bh=vVQ6R0s6mgvK7aJB8O+3GzfbNvo+mvSprNLad1Ie9pc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=Py08vbpPh/l4MVZELML74anp3r4p/ewMSNNgkF4mm6MKtqfnuj5J49f/3DA6HLv2q
 7w1/pCSIy+gGKditQCfSsF8vOONhVIorleVfXhlz1uCYsTrWmsySOTVcwiIiWdEhB6
 mMTEgNYtzOL8saZyDzNDRrdxUkDcTvW3hEwHnH3uZ+OFsm65KGk1tx6bf1mnf0O7de
 pu49orJIuRNCCs+LewCoNcZkwhwgNJKYui6OnGu4OlJ01tZ+dpZy7pTbkv93QloYvN
 bb0w32qO8VWRspkhu7dVmv49t1jxDPwRKFkCIEeW3LnpvhweHdt9NzYlZ0jkKv5pMS
 5QupV5MARpa5A==
Message-ID: <7ba3d0298be8edbfbbc16882aa17fa38e70662be.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 3/3] misc/pca9552: Only update output GPIOs if state
 changed
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, philmd@linaro.org
Date: Tue, 24 Oct 2023 10:13:41 +1030
In-Reply-To: <20231020182321.163109-4-milesg@linux.vnet.ibm.com>
References: <20231020182321.163109-1-milesg@linux.vnet.ibm.com>
 <20231020182321.163109-4-milesg@linux.vnet.ibm.com>
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

On Fri, 2023-10-20 at 13:23 -0500, Glenn Miles wrote:
> The pca9552 code was updating output GPIO states whenever
> the pin state was updated even if the state did not change.
> This commit adds a check so that we only update the GPIO
> output when the pin state actually changes.

Given this is intertwined with patch 2/3 that adds the input mode
capability, I think they should be squashed together?

>=20
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
>=20
> New commit in v2
>=20
>  hw/misc/pca9552.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
> index ed814d1f98..4ed6903404 100644
> --- a/hw/misc/pca9552.c
> +++ b/hw/misc/pca9552.c
> @@ -112,14 +112,15 @@ static void pca955x_update_pin_input(PCA955xState *=
s)
> =20
>      for (i =3D 0; i < k->pin_count; i++) {
>          uint8_t input_reg =3D PCA9552_INPUT0 + (i / 8);
> -        uint8_t input_shift =3D (i % 8);
> +        uint8_t bit_mask =3D 1 << (i % 8);
>          uint8_t config =3D pca955x_pin_get_config(s, i);
> +        uint8_t old_value =3D s->regs[input_reg] & bit_mask;
> +        uint8_t new_value;
> =20
>          switch (config) {
>          case PCA9552_LED_ON:
>              /* Pin is set to 0V to turn on LED */
> -            qemu_set_irq(s->gpio_out[i], 0);
> -            s->regs[input_reg] &=3D ~(1 << input_shift);
> +            s->regs[input_reg] &=3D ~bit_mask;
>              break;
>          case PCA9552_LED_OFF:
>              /*
> @@ -128,11 +129,9 @@ static void pca955x_update_pin_input(PCA955xState *s=
)
>               * external device drives it low.
>               */
>              if (s->ext_state[i] =3D=3D PCA9552_PIN_LOW) {
> -                qemu_set_irq(s->gpio_out[i], 0);
> -                s->regs[input_reg] &=3D ~(1 << input_shift);
> +                s->regs[input_reg] &=3D ~bit_mask;
>              } else {
> -                qemu_set_irq(s->gpio_out[i], 1);
> -                s->regs[input_reg] |=3D 1 << input_shift;
> +                s->regs[input_reg] |=3D  bit_mask;
>              }
>              break;
>          case PCA9552_LED_PWM0:
> @@ -141,6 +140,18 @@ static void pca955x_update_pin_input(PCA955xState *s=
)
>          default:
>              break;
>          }
> +
> +        /* update irq state only if pin state changed */
> +        new_value =3D s->regs[input_reg] & bit_mask;
> +        if (new_value !=3D old_value) {
> +            if (new_value) {
> +                /* changed from 0 to 1 */
> +                qemu_set_irq(s->gpio_out[i], 1);
> +            } else {
> +                /* changed from 1 to 0 */
> +                qemu_set_irq(s->gpio_out[i], 0);
> +            }

Slightly code-golf-y, but the inner if-else here may be compressed to:

    qemu_set_irq(s->gpio_out[i], !!new_value);

Andrew


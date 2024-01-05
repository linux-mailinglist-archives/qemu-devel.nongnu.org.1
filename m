Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1D2825905
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 18:28:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLnxx-0008Po-Gh; Fri, 05 Jan 2024 12:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLnxo-0008PL-0r
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:26:32 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLnxl-0000Qo-Va
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:26:31 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5569472f775so2139679a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704475588; x=1705080388; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ca/KSmdg+t73to0c+0RcEgkeIdXUcFDWCT3dpOFVbjI=;
 b=gU3Q20jJx/HOcjs3/Mybc6sVeL/g0sNYyjENYOy7PhTUt1v3o9AHN9htLzcDJDQE3e
 McWf2x0V98ifSTXxVetj4EJYlc+/bsUuXInFkwcyPyUckQyBw1xSvA/Ke7yDbrCmEiNN
 qeXznFKBGwpp12iBMhRivfzhRXUWgOK9OfQLQjFbMKT/J/6G9JikJtXiQ68dASbMJ3yN
 6r70CeXLLpiLaZMRYxlwjEXfxRs8Y34x5GOJKsY1Zf3bhsPiQtCAuzvO1b7xqfWeKkj7
 6UG3EHq93Mty4DzYaAY+Joz9nMAI3akA77VNpNgfa2oHtXdNMOTP3m/Bcjil6hXEaFSW
 1BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704475588; x=1705080388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ca/KSmdg+t73to0c+0RcEgkeIdXUcFDWCT3dpOFVbjI=;
 b=CWozzSS6BzKlnEQgfl0ubadBIevGubjJiU4UG6X+3RYMvRKvVtQPw+uVy/yivmJ2Nj
 D1XLLEi5VWakxYXHM2Ob/ER/G3+1CQcesLDexPL24d6b4vHnnLrNR6d3bIMGMOXyeYnW
 drsqDJRoYJK4/6E//YzehOKz+Mbtt0Hq524uvhPIuw3Wn2vvoZtgKK0eOu7daryk62+i
 2RzHa8CUKSV6gueQ7qLoiXgK16upxbVR+u9tsWBdeWKJ4B5TURELQpAVTVS4z3OdSzxD
 2nKUWR1dSOC0P4F2pRIcKGEciDALuSMGKQaS6SnBYXN4L2uAKcyBhpE5G2CpwEqLlQkV
 wONQ==
X-Gm-Message-State: AOJu0YwdPqKteCDfqjj5bB65jhburpF0Kl16KtiJ98OJ9xatBGpQVjto
 gt0q8ocFqq+192A/SbJ9HI8Ddzl2u5PEnLOwrVsGV08X1gYfJA==
X-Google-Smtp-Source: AGHT+IHqvWFTrMRsCigEpAlA8qmsrN50QgcEptwBVfHa8J8pA4q8rit/h738RsX9Uy8wqL3Fsfk6EV56WgOSuc4RCBo=
X-Received: by 2002:a50:c04a:0:b0:554:877e:b7f with SMTP id
 u10-20020a50c04a000000b00554877e0b7fmr1661522edd.39.1704475587946; Fri, 05
 Jan 2024 09:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20231220064735.387346-1-ah@immunant.com>
In-Reply-To: <20231220064735.387346-1-ah@immunant.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jan 2024 17:26:17 +0000
Message-ID: <CAFEAcA-XPfOX-=dutD5zO1_zRs4ciYzLL8zHwwTAnBSxvywD7g@mail.gmail.com>
Subject: Re: [PATCH] arm_gic: Implement GICC_AIAR, GICC_AEOIR and GICC_AHPPIR
To: Andrei Homescu <ah@immunant.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, armellel@google.com, 
 jansene@google.com, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 20 Dec 2023 at 06:47, Andrei Homescu <ah@immunant.com> wrote:
>
> From: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
>
> Implement aliased registers so group 1 interrupts can be used in secure
> mode.

Hi; thanks for this patch.

> GICC_AEOIR is only implemented as a direct alias to GICC_EOIR for now as
> gic_complete_irq does not currently check if the cpu is in secure mode.

I'm not really sure what this comment has in mind, but I think
perhaps it is alluding to the issue that https://r.android.com/859189
fixes ? In any case, we should either expand it to be clearer about
what problem it's referring to or else delete it as no longer
relevant.

> Upstreamed from https://r.android.com/705890 and
> https://r.android.com/859189.
>
> Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

Hmm, I'm not entirely sure if we should be creating signed-off-by
lines if they've not been provided by the original authors.
(We can take the code because it's from a GPL2'd fork, and we
should credit the original authors, but a signed-off-by tag
says a bit more than that.)

> Signed-off-by: Andrei Homescu <ah@immunant.com>
> ---
>  hw/intc/arm_gic.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 074cf50af2..d0e267a4b2 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -854,7 +854,8 @@ static void gic_deactivate_irq(GICState *s, int cpu, =
int irq, MemTxAttrs attrs)
>      gic_clear_active(s, irq, cpu);
>  }
>
> -static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs a=
ttrs)
> +static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs a=
ttrs,
> +                             bool ns_irq)

I think this argument should be called group1_only (see later).

>  {
>      int cm =3D 1 << cpu;
>      int group;

There's a codepath here for "gic_is_vcpu())"; we should
add a comment somewhere there that says something like:

 /*
  * Acknowledging a group 0 interrupt via GICV_AEOIR is
  * UNPREDICTABLE; we choose to treat it as if the guest
  * had acknowledged it via GICV_EOIR, i.e. we ignore
  * the group1_only flag.
  */

> @@ -922,7 +923,7 @@ static void gic_complete_irq(GICState *s, int cpu, in=
t irq, MemTxAttrs attrs)
>
>      group =3D gic_has_groups(s) && gic_test_group(s, irq, cpu);
>
> -    if (gic_cpu_ns_access(s, cpu, attrs) && !group) {
> +    if (ns_irq && !group) {
>          DPRINTF("Non-secure EOI for Group0 interrupt %d ignored\n", irq)=
;
>          return;
>      }

> @@ -1647,6 +1648,22 @@ static MemTxResult gic_cpu_read(GICState *s, int c=
pu, int offset,
>              *data =3D s->abpr[cpu];
>          }
>          break;
> +    case 0x20: /* Aliased Interrupt Acknowledge */
> +        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {

This doesn't look like the right condition -- the spec
says GICC_AIAR is only present in GICv2. gic_has_groups()
will return true for GICv2 or for a GICv1 with the security
extensions. (That's the right check for GICC_ABPR, but not
for GICC_AIAR or GICC_AHPPIR or GIC_AEOIR.)

It will also mean we incorrectly return 0 for the case
of the GICV_AIAR vcpu interface register. (This is why the
existing code for the GICC_ABPR uses gic_cpu_ns_access() in
this part of its check.)

> +            *data =3D 0;
> +        } else {
> +            attrs.secure =3D false;
> +            *data =3D gic_acknowledge_irq(s, cpu, attrs);

This doesn't do the right thing I think for the GICV_AIAR
vcpu interface, or for a GICv2 which doesn't have the security
extensions, because gic_cpu_ns_access() will return false
for both of those cases even if attrs.secure is false, and
so when gic_acknowledge_irq() calls gic_get_current_pending_irq()
it won't get the group 1 IRQ it's supposed to.

> +        }
> +        break;
> +    case 0x28: /* Aliased Highest Priority Pending Interrupt */
> +        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
> +            *data =3D 0;
> +        } else {
> +            attrs.secure =3D false;
> +            *data =3D gic_get_current_pending_irq(s, cpu, attrs);
> +        }

Similarly this isn't correct for the GICv2-no-security-interface
and the GICV-vcpu-interface cases.

I think we probably need to plumb through more of the "what
behaviour do we need" rather than trying to do it by setting
attrs.secure. My first thought is a 'bool group1_only' argument
to gic_get_current_pending_irq() and gic_acknowledge_irq(),
so that those functions can give the behaviour we want for
the alias registers.

> +        break;
>      case 0xd0: case 0xd4: case 0xd8: case 0xdc:
>      {
>          int regno =3D (offset - 0xd0) / 4;
> @@ -1724,7 +1741,15 @@ static MemTxResult gic_cpu_write(GICState *s, int =
cpu, int offset,
>          }
>          break;
>      case 0x10: /* End Of Interrupt */
> -        gic_complete_irq(s, cpu, value & 0x3ff, attrs);
> +        gic_complete_irq(s, cpu, value & 0x3ff, attrs,
> +                         gic_cpu_ns_access(s, cpu, attrs));
> +        return MEMTX_OK;
> +    case 0x24: /* Aliased End Of Interrupt */
> +        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
> +            /* unimplemented, or NS access: RAZ/WI */

Same remark applies here about the condition to use.

> +        } else {
> +            gic_complete_irq(s, cpu, value & 0x3ff, attrs, true);

Here we are passing through the equivalent of a
"group1_only" argument, so my suggestion above pretty
much is to bring the AHPPIR and AIAR into line with this.

> +        }

>          return MEMTX_OK;
>      case 0x1c: /* Aliased Binary Point */
>          if (!gic_has_groups(s) || (gic_cpu_ns_access(s, cpu, attrs))) {
> --
> 2.42.1

thanks
-- PMM


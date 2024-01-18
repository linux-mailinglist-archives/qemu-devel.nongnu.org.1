Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4468321A9
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 23:41:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQb3n-0003Ow-6U; Thu, 18 Jan 2024 17:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1rQb3k-0003OQ-N6
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 17:40:28 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1rQb3j-0001kR-0Y
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 17:40:28 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5ed10316e22so1360827b3.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 14:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705617625; x=1706222425;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Ax+R6EbI+a1jnNIwSZ04wxLUysLiBkhsAMXiU7HmZY=;
 b=O6BKnazs9g9fgEXISO4Rd3VV9tqecBSl6/fuy5H0vNgdd1jbiyRchihTH30mqUxt/W
 GGZHjRkc0+bmAfocJnoQPan7rSJKivJji+qQhijPAf9dqgpd0qu273aH1UN8jvVFRX+r
 jIPqQrCybL3YP3lAYjsoTpX78/r7hnWBtxdZDt/VWJ0x9Js6ALBkTY3rrpflFgmDLcVB
 YG4GHB5w8wwf0VagTiPQLZ9sk0HB5fC6EY3uRY7NUmP6CH1A/pEYcs+YS+xx1rSXOyd6
 jfUQOiXE2U+KxhpWKodjBQvSetZpfe8s4ZPkwAr8nyhMDjsQA4AkKH0F+32ASfqlWa1Y
 rRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705617625; x=1706222425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Ax+R6EbI+a1jnNIwSZ04wxLUysLiBkhsAMXiU7HmZY=;
 b=AoqwhGIBC8zeqh6sWqe6rehUS0D+DtITo1cohXI/VeP70DqyhEry3Bz5x8TgsgrgmV
 lfNe0uFSga9E0FKvui40JNQccHp4CnPBZ2kEm1Og5lbu7whTXdtwSFemu4MSlENHrP0T
 wvhxreM28WMZ0lLpXsaeWZtH6EfOq2XfiEMIhRTKgn8lxzPjKR+alLc5NGPEK1SPq0eD
 WyCKtnBY1hqh+zSEAd3ARaGyXtW+HekYjElXGZmqWvQaF2jypTd6nNCb2Gay2JaWOoUd
 Yw+azJFDuZtzwuypRS7K8e5FYM6Axj5bd/5oZ8/30BxzSsplWq/yIwaj4JJIn4xP+RNu
 xilw==
X-Gm-Message-State: AOJu0YwmygCLkbMxxLtv+SemOOT6nQpfLvDXqZKWhq1L1bzRL50orh2i
 oRbwB9b5kykYO6otcJWgYWsRVvC+PZ9lCmg0c1oRX2DjaCxwlrGvYjEc3h6zjJ/znOppBtGsG8R
 ze0KFMr/G9tgON6gBKZAC1bS5d//9LHeDDRDyJA==
X-Google-Smtp-Source: AGHT+IHhFFplzhvq72mJqar8oTkdG+XMDN/NxvBHGYupx3hiJHpMRBs+hfgF/aUrhAA87UcBMGQPCXxn+CyfJMtpRSw=
X-Received: by 2002:a25:aa8d:0:b0:dc2:4e83:e6a4 with SMTP id
 t13-20020a25aa8d000000b00dc24e83e6a4mr1294879ybi.3.1705617625638; Thu, 18 Jan
 2024 14:40:25 -0800 (PST)
MIME-Version: 1.0
References: <20240109102930.405323-1-me@deliversmonkey.space>
 <20240109102930.405323-4-me@deliversmonkey.space>
 <CAKC1njSLR614zQk0_DAgYN1jjdg=0eUa7N1AEwwXZVNN6BwjmA@mail.gmail.com>
 <3cb918ca-27cd-4f1e-8738-306dc5280f42@linaro.org>
In-Reply-To: <3cb918ca-27cd-4f1e-8738-306dc5280f42@linaro.org>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 18 Jan 2024 14:40:14 -0800
Message-ID: <CAKC1njRXPi1Roch=T+NwQk-TOzN=gSjmPh2KCVsemKdex9CamA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alexey Baturo <baturo.alexey@gmail.com>, zhiwei_liu@linux.alibaba.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=debug@rivosinc.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Jan 18, 2024 at 12:50=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/19/24 04:21, Deepak Gupta wrote:
> > On Tue, Jan 9, 2024 at 2:31=E2=80=AFAM Alexey Baturo <baturo.alexey@gma=
il.com> wrote:
> >>
> >> From: Alexey Baturo <baturo.alexey@gmail.com>
> >>
> >> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> >> ---
> >
> >> +
> >> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
> >> +{
> >> +    bool virt_mem_en =3D false;
> >> +#ifndef CONFIG_USER_ONLY
> >> +    int satp_mode =3D 0;
> >> +    int priv_mode =3D cpu_address_mode(env);
> >> +    /* Get current PMM field */
> >> +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> >> +        satp_mode =3D get_field(env->satp, SATP32_MODE);
> >> +    } else {
> >> +        satp_mode =3D get_field(env->satp, SATP64_MODE);
> >> +    }
> >> +    virt_mem_en =3D ((satp_mode !=3D VM_1_10_MBARE) && (priv_mode !=
=3D PRV_M));
> >> +#endif
> >> +    return virt_mem_en;
> >
> > Obsessing a little bit on how to test PM enabled binaries with qemu-use=
r.
> > If we return false above then we're not allowed to test binaries with
> > pointer masking enabled with qemu-user.
> > That use case is not required?
>
> In a previous round I suggested that the ifdefs are not necessary.
> But for now it will always be off for qemu-user.
>
> At some point pointer masking will be in hardware, and the kernel will ga=
in support for
> it, and there will likely be a prctl() added for it.  At the point the ke=
rnel finalizes
> the API, you will be able to enable pointer masking for qemu-user.

I am sure I am missing some important detail here, BUT...

How is it different from aarch64 "top byte ignore".
I think commit: 16c8497 enables top byte ignore for user pointers and
by default for qemu-user for aarch64 target.

IIRC, user <--> kernel abi is only needed for pointers that are passed
to the kernel.

And in the case of qemu-user, we are talking about the host kernel.
Since arm64 had TBI enabled for qemu-user for a while and I imagine it
works on x86 host kernel
(assuming qemu-user is sanitizing pointers)
Same should work for risc-v qemu-user, right?

>
>
> r~


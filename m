Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE57274758B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:45:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGiD2-0001My-11; Tue, 04 Jul 2023 11:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGiCz-0001L9-3T
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:44:53 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGiCx-0006RC-Dc
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:44:52 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4fbc0314a7bso399832e87.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688485488; x=1691077488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2n43NzrRMUeCvFkdouayT6vAz0ieP1Csbq1cNy23Ha0=;
 b=VZWOlHnhKARRv8p24Kl0p5WFsE4Ksc2xr1e89m+0UhlLrBINr9EpN1SSZr3rlWv+CS
 ygzOnMr5Mj7IT8jbr36caNzRAjF80pVNi40mbexDyk0RpO7ngJvW4JuZnzmmtb2v9jOB
 2DOZdBsDJitr8V8TRIXyC+15SS2fXIXQW/aQhBQMHg6Y1i1WBzfwxdRDj/2R8NwdxtBI
 1VUCMDi6V1DUfdyau/wBkohB6ESmDJlSj06h3kcfgAyEyPp66qZ1acmyZbZn1tmAWJIK
 aABi0tDI2cjhONnpnsR4pgfR7/1p8m1VWqkpOWk/XS0rS1nu/AI4SJKnaMZLIwQanf5Q
 1BNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688485488; x=1691077488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2n43NzrRMUeCvFkdouayT6vAz0ieP1Csbq1cNy23Ha0=;
 b=W3YGpLWVkozemyx2Cyw9jP4J/l8ozu+/uBRY4BUp2UDsr1FnCdPTUjSPbIUUQgGZxh
 kvgZPrCxflAcCF5oQquAYwiZYvNR4GpF/zdyN9gmicNattKi3N5pgPj4qT95LmYve8Lz
 xnEgMnf4CRAVAVeOZSTW0prihic1nZm13fjg49mCDGhwpu9vRJMRrx46iqGO0wPcLHKh
 kuAVaeE4B+j5yWBtpwzPnPhpPk5GPyfrOTGex2GknEdHX3AMiOneUcCG5yoMRxuMbghz
 H7U7b3+KF6RA81OYhGB+q7oqOOJlhDUvajmc/kCJPe1FjIejxNMrSvVXuCC0lPY7WJx3
 KU8A==
X-Gm-Message-State: ABy/qLZgivqRs7F/NliHlERfYEmbk/cDuwj1TLyJATA+0YgRcwuRwjHr
 rHfpdXx1cC69uSap3q1YxbYBeMKHXKBGMm3cFR4w4g==
X-Google-Smtp-Source: APBJJlGZNppg2bSuypfeJZxu1QJ66B3JWkCAusb9XVktazbs6in5qYkyQ81eLft6sNJfZBiLvTYp1cdJoM2O1IkiZGY=
X-Received: by 2002:ac2:4f0e:0:b0:4fb:8bea:f5f6 with SMTP id
 k14-20020ac24f0e000000b004fb8beaf5f6mr11057784lfr.34.1688485488627; Tue, 04
 Jul 2023 08:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230628164821.16771-1-farosas@suse.de>
 <d8f954dc-8a69-7593-716c-e360d2c8e47b@linaro.org>
In-Reply-To: <d8f954dc-8a69-7593-716c-e360d2c8e47b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2023 16:44:37 +0100
Message-ID: <CAFEAcA9QSS7qs2kcCuyrDrRc6tb_0euMD3vFJ=_Q8s8dJYBRfw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: gdbstub: Guard M-profile code with CONFIG_TCG
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 4 Jul 2023 at 16:21, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 28/6/23 18:48, Fabiano Rosas wrote:
> > This code is only relevant when TCG is present in the build. Building
> > with --disable-tcg --enable-xen on an x86 host we get:
> >
> > $ ../configure --target-list=3Dx86_64-softmmu,aarch64-softmmu --disable=
-tcg --enable-xen
> > $ make -j$(nproc)
> > ...
> > libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `m_sys=
reg_ptr':
> >   ../target/arm/gdbstub.c:358: undefined reference to `arm_v7m_get_sp_p=
tr'
> >   ../target/arm/gdbstub.c:361: undefined reference to `arm_v7m_get_sp_p=
tr'
> >
> > libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `arm_g=
db_get_m_systemreg':
> > ../target/arm/gdbstub.c:405: undefined reference to `arm_v7m_mrs_contro=
l'
> >
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> > This is a respin of:
> > https://lore.kernel.org/r/20230313151058.19645-5-farosas@suse.de
> > ---
> >   target/arm/gdbstub.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> > index 03b17c814f..f421c5d041 100644
> > --- a/target/arm/gdbstub.c
> > +++ b/target/arm/gdbstub.c
> > @@ -324,6 +324,7 @@ static int arm_gen_dynamic_sysreg_xml(CPUState *cs,=
 int base_reg)
> >       return cpu->dyn_sysreg_xml.num;
> >   }
> >
> > +#ifdef CONFIG_TCG
>
> OK.
>
> >   typedef enum {
> >       M_SYSREG_MSP,
> >       M_SYSREG_PSP,
> > @@ -481,6 +482,7 @@ static int arm_gen_dynamic_m_secextreg_xml(CPUState=
 *cs, int orig_base_reg)
> >       return cpu->dyn_m_secextreg_xml.num;
> >   }
> >   #endif
> > +#endif /* CONFIG_TCG */
> >
> >   const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname=
)
> >   {
> > @@ -561,6 +563,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU =
*cpu)
> >                                arm_gen_dynamic_sysreg_xml(cs, cs->gdb_n=
um_regs),
> >                                "system-registers.xml", 0);
> >
> > +#ifdef CONFIG_TCG
>
> IIUC tcg_enabled(), this guard shouldn't be necessary; if CONFIG_TCG
> is not defined, tcg_enabled() evaluates to 0, and the compiler should
> elide the whole block.

IME it's a bit optimistic to assume that the compiler will always
do that, especially with no optimisation enabled.

thanks
-- PMM


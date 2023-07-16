Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81038755017
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 19:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL5c8-0004Iy-Q1; Sun, 16 Jul 2023 13:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qL5c7-0004IL-5e
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 13:32:55 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qL5c5-0000jp-G5
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 13:32:54 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9939fbb7191so769552166b.0
 for <qemu-devel@nongnu.org>; Sun, 16 Jul 2023 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689528771; x=1692120771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vKvbMGmmRrOOTNb1sMK5QlmckBw9cy/Thit34ZnRTY=;
 b=rj5vCF9qH1WW1BNmTaIoiJnLeEDhWr+nJB1xx1VdvFGVMy1rI/9JdvGsa77rv0YoKa
 DHQTUDvCcMJLOztx8JXf+TNNbZb7W+VfSfXKvE11/qe6eA+l5f+4UGSoQZoj62Z7DkPu
 HgUDBI4DG+GPQJJYop0jN3+/Q9SIiyYOvbcterH4u32Q4LLrvjn+SX1RuuTYnM4IYxLD
 EMgLY/vVaN1b66UAdRTqH1C1N2wFWcq4Pqo1kON8ka3e0LsWMLmA3pVjS0tIfjOQcGfs
 OJrMXaG/m5kCGziWtAEGTPDVe4HiJdo8hQjbhakAePOFYd11OvlR2r7rO7Ufge3mXnXd
 EUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689528771; x=1692120771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6vKvbMGmmRrOOTNb1sMK5QlmckBw9cy/Thit34ZnRTY=;
 b=OfTt0fW73gWGOvf4xLEVR4Mv0G85uCKjq3xCmwv9SiXzP4P0pgj1/aBrf6VjFK787Z
 8l9w/xT7vaCicIkEnwUjrpWf148XM24e7P5SNJ59jsAWqZxwYhDHTj4dC1cMiDBV+wzO
 xzScYm0hbwdVvFL2lnl1zOIcLU5HNz90TCgFtj9iftUOUSo2MJotLhacxp68iYkVtsSt
 Hb2+JQE4xQBA8VjTbWn7/R5qo3abZ3RxfoTCWvnw2AVyeToAw1qyjIpEw7h31T2SLinQ
 Kd+9DJMEHE4KCMSntnV6OuyApDdpffyhvGB0aZDChgINHQFiPkVkXUbgFPTIwyhz2RRg
 kBlw==
X-Gm-Message-State: ABy/qLYWDtPPrATsZGm/Zp8w34/yA3299Jl/f5PxBzZB6UjMxUW8eNkb
 vAlLQJ8Z0FKhi1byhOqwupdgGiCWpQdMzRNYEt1yfA==
X-Google-Smtp-Source: APBJJlGvAwcXAN/eOMbIQ6VfGh1pLrYQS6QndtFIn+oAeFcnwzgbuM9/V6UlABnvy+XLlwW/OZelFD+WWh/d8ZbbtzU=
X-Received: by 2002:a17:907:97d5:b0:98e:1c4b:10e2 with SMTP id
 js21-20020a17090797d500b0098e1c4b10e2mr8344537ejc.20.1689528770999; Sun, 16
 Jul 2023 10:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230714172602.397267-1-peter.maydell@linaro.org>
 <869d9cf9-003a-b721-651c-b5bb82ed593d@linaro.org>
In-Reply-To: <869d9cf9-003a-b721-651c-b5bb82ed593d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 16 Jul 2023 18:32:40 +0100
Message-ID: <CAFEAcA9UdPwdJpXg3EFUEvvWji-bs_fCok=M+k=Tf_ej9w+j2w@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: Handle FPRS correctly on big-endian hosts
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

On Fri, 14 Jul 2023 at 18:52, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 14/7/23 19:26, Peter Maydell wrote:
> > In CPUSparcState we define the fprs field as uint64_t.  However we
> > then refer to it in translate.c via a TCGv_i32 which we set up with
> > tcg_global_mem_new_ptr().  This means that on a big-endian host when
> > the guest does something to writo te the FPRS register this value
> > ends up in the wrong half of the uint64_t, and the QEMU C code that
> > refers to env->fprs sees the wrong value.  The effect of this is that
> > guest code that enables the FPU crashes with spurious FPU Disabled
> > exceptions.  In particular, this is why
> >   tests/avocado/machine_sparc64_sun4u.py:Sun4uMachine.test_sparc64_sun4=
u
> > times out on an s390 host.
> >
> > There are multiple ways we could fix this; since there are actually
> > only three bits in the FPRS register and the code in translate.c
> > would be a bit painful to convert to dealing with a TCGv_i64, change
> > the type of the CPU state struct field to match what translate.c is
> > expecting.
> >
> > (None of the other fields referenced by the r32[] array in
> > sparc_tcg_init() have the wrong type.)
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Another in my occasional series of "fix an avocado failure on
> > s390" Friday afternoon patches :-)
>
> :)
>
> > diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
> > index a1c8fdc4d55..bddb9609b7b 100644
> > --- a/target/sparc/gdbstub.c
> > +++ b/target/sparc/gdbstub.c
> > @@ -96,7 +96,10 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteA=
rray *mem_buf, int n)
> >       case 83:
> >           return gdb_get_regl(mem_buf, env->fsr);
> >       case 84:
> > -        return gdb_get_regl(mem_buf, env->fprs);
> > +    {
> > +        target_ulong fprs =3D env->fprs;
> > +        return gdb_get_regl(mem_buf, fprs);
>
> Why not return gdb_get_reg32() ?

Because that would cause different on-the-wire data to be
sent to gdb -- gdb_get_reg32() puts 4 bytes of data into
the gdb remote protocol packet, whereas gdb_get_regl() puts
either 4 or 8 bytes depending on TARGET_LONG_BITS (as
it happens, here we'll always send 8 because this register
is sparc64- specific).

Anyway, Richard is correct and we don't need to change this
at all, because gdb_get_regl() takes an integer argument,
it isn't a magic macro that implicitly takes the address
or looks at the type of what it gets passed. So passing
it env->fprs will zero-extend that and DTRT.

thanks
-- PMM


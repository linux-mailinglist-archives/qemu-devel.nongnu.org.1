Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DAF82D482
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 08:23:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPHIr-0005hD-Ak; Mon, 15 Jan 2024 02:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1rPHIo-0005gr-Tk
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:22:35 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1rPHIm-0007IQ-WE
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:22:34 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-28e0786edb3so2135346a91.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 23:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705303351; x=1705908151;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjZSbqFEowWXu6XFc2f+ocrIJQeAT7IyN3HafnOniFc=;
 b=0UigZlX1OrIv7eBpJqqcCBhiZVCetbYaZuq/x1FE4Ixux4o65/RQL4POtT55Z8G5wm
 2XtG33dxzNZ+42l86QZXylhLSOcI/vJAfMtzIjCRdZlvJuxMu4vFXTZ4Gn4khXpK6lgl
 ufVc/VVV2Xy+4Lds7wLLiR9iOSrw8g0UgRRp2dlf2sSPqwo/q6AXN0MBND6NmYiLDIeS
 cWah2eVcidRzDwmvTFFf82WoCR9IM6fELUQgmwQH4wN0gY8HobTCrfPlJ+vy23Qu5FBs
 yLC8OmVae4cGWQQ0vlLHB7XP+/UAV+TDzM2tZmZYgKE6xfs9XA8fJaW//rUjtTxRlvMd
 V/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705303351; x=1705908151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LjZSbqFEowWXu6XFc2f+ocrIJQeAT7IyN3HafnOniFc=;
 b=JCyflAWUfz3q4Prp1r/cm+P1YfvRdxYuBv/xvNhsmLe0usqGUoeduMX9h/iPgCzDWE
 OUH4JGS3O905PtxlPnbwmzqDqtzYstsizJEKsp5GlAe6GanQNUQqBE90+XVMUBoXLSv9
 6UBwSC/Fj0nkq4NBhF0p7Yp4Z4rUKtdeYaFe5L7gsr3JWv4TPk+EHGH5b3+f22o5Q8ec
 NAg3bq5o5+V3DitVvFSnbOXngEIzpbao8UIOuJUSiDJktYGd5vFsida0D7Nl4AbKIId3
 P/LvSqcfmPLeLVeYub3CzoEwjlbTPMGo3rawlHeQHiadMjrhJeiMUSyfY0VAdGiR02gp
 nsfQ==
X-Gm-Message-State: AOJu0YynUPqHClFBjDHIzUd6A+Xy377y3GN3/xvUtXkLTrFPYC9u/bxL
 Qp7TgXT80XgoMu7cvUgpIUZ7ra3UbuQE102Dy5gF0kyMPSQV+A==
X-Google-Smtp-Source: AGHT+IF7/tiZz9uW1UIcgSo7CeFyRtQuG+a7A5TRd81/9maRUwduvNsdDNtsRmowTzWLjDpe/r0mYGb8DzOw8taT/ec=
X-Received: by 2002:a17:90a:6506:b0:28e:f6f:615b with SMTP id
 i6-20020a17090a650600b0028e0f6f615bmr2296899pjj.83.1705303350799; Sun, 14 Jan
 2024 23:22:30 -0800 (PST)
MIME-Version: 1.0
References: <33f27425878fb529b9e39ef22c303f6e0d90525f.camel@rivosinc.com>
 <mhng-5bf9ebaf-017e-4d04-b287-ac40a32859b7@palmer-ri-x1c9>
In-Reply-To: <mhng-5bf9ebaf-017e-4d04-b287-ac40a32859b7@palmer-ri-x1c9>
From: Robbin Ehn <rehn@rivosinc.com>
Date: Mon, 15 Jan 2024 08:22:19 +0100
Message-ID: <CAEEvPLC7u09ODf6uhU-=hcGFp3_hLpfvkvMcHo-dG+nS65h-=w@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fixed cpu restore with pc 0 on SIGBUS
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=rehn@rivosinc.com; helo=mail-pj1-x1036.google.com
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

Hi, Palmer,

On Fri, Jan 12, 2024 at 10:03=E2=80=AFPM Palmer Dabbelt <palmer@rivosinc.co=
m> wrote:
>
> On Fri, 12 Jan 2024 12:57:22 PST (-0800), rehn@rivosinc.com wrote:
> > Commit f4e1168198 (linux-user: Split out host_sig{segv,bus}_handler)
> > introduced a bug, when returning from host_sigbus_handler the PC is
>
> So we should probably have a
>
> Fixes: f4e1168198 ("linux-user: Split out host_sig{segv,bus}_handler")

You are correct.

>
> > never set. Thus cpu_loop_exit_restore is called with a zero PC and
> > we immediate get a SIGSEGV.
> >
> > Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
> > ---
> >  linux-user/signal.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/linux-user/signal.c b/linux-user/signal.c
> > index b35d1e512f..c9527adfa3 100644
> > --- a/linux-user/signal.c
> > +++ b/linux-user/signal.c
> > @@ -925,7 +925,7 @@ static void host_sigsegv_handler(CPUState *cpu, sig=
info_t *info,
> >      cpu_loop_exit_sigsegv(cpu, guest_addr, access_type, maperr, pc);
> >  }
> >
> > -static void host_sigbus_handler(CPUState *cpu, siginfo_t *info,
> > +static uintptr_t host_sigbus_handler(CPUState *cpu, siginfo_t *info,
> >                                  host_sigcontext *uc)
> >  {
> >      uintptr_t pc =3D host_signal_pc(uc);
> > @@ -947,6 +947,7 @@ static void host_sigbus_handler(CPUState *cpu, sigi=
nfo_t *info,
> >          sigprocmask(SIG_SETMASK, host_signal_mask(uc), NULL);
> >          cpu_loop_exit_sigbus(cpu, guest_addr, access_type, pc);
> >      }
> > +    return pc;
> >  }
> >
> >  static void host_signal_handler(int host_sig, siginfo_t *info, void *p=
uc)
> > @@ -974,7 +975,7 @@ static void host_signal_handler(int host_sig, sigin=
fo_t *info, void *puc)
> >              host_sigsegv_handler(cpu, info, uc);
>
> Do we have the same problem for SEGV?  They both used to set

Yea, it's not easy to follow the different paths... this code needs
another refactor, I was tempted but refrained myself.
So in the switch state if we have SEGV (and si_code>0) we always long
jump or return.
Only SIGBUS sets sync_sig to true, and thus calls
cpu_loop_exit_restore, hence needs a PC.
But the comment makes you think it's for multiple signals.

>
>     pc =3D host_signal_pc(uc);
>
> but with this it's only SIGBUS.  Maybe the same for the others, so just
> something like
>
>     diff --git a/linux-user/signal.c b/linux-user/signal.c
>     index b35d1e512f..55840bdf31 100644
>     --- a/linux-user/signal.c
>     +++ b/linux-user/signal.c
>     @@ -968,6 +968,8 @@ static void host_signal_handler(int host_sig, sig=
info_t *info, void *puc)
>           * SIGFPE, SIGTRAP are always host bugs.
>           */
>          if (info->si_code > 0) {
>     +        pc =3D host_signal_pc(uc);
>     +
>              switch (host_sig) {
>              case SIGSEGV:
>                  /* Only returns on handle_sigsegv_accerr_write success. =
*/
>

Only those (SIGBUS) setting sync_sig need a PC.

> as it just does the PC chasing for everyone?
>

The sneaky return below.
Let me know if you still think setting the PC before the switch
statement is better.

> >              return;
> >          case SIGBUS:
> > -            host_sigbus_handler(cpu, info, uc);
> > +            pc =3D host_sigbus_handler(cpu, info, uc);
> >              sync_sig =3D true;
> >              break;
> >          case SIGILL:
> > --
> > 2.40.1
>
> Either way,
>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!

>
> Thanks!


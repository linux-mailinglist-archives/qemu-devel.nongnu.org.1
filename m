Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FDF76A209
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 22:38:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQZeV-0002Jd-Mv; Mon, 31 Jul 2023 16:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qQZeT-0002J1-Fn
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 16:38:01 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qQZeR-0008EJ-Ce
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 16:38:01 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3178dd81ac4so3485176f8f.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690835877; x=1691440677;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UwWbkKef2bg+0OOuHjMxCBeq3VQyMFXC7saiZMO7998=;
 b=qg0ZmxEFpBBQjKqkwT+B4jwOlpYp3Kn7M+iRKpcP+o8adfdnXicB6jELOhS9146bZS
 z39qYTYzcvlOs2c0yWzn8nmKKqd0vy+EME+Nfyw/ovlftK4Rv5nd1+uhOk0NwCznrpuF
 sukm+ciMUAZv30vsFibIKcXi9YJwDZiaX5H/EuoAbctWfXHLTG/d7WFYATc9eSYDpR7p
 Vd6jNQNNVp6XtRhdObNu4hX2X/lbfCFZx8CDoiU415z3wyjqPEA8tBKvK74QCBte9IEu
 g6Ct9MbHC5jxcNTwi1DYRGG+SaHoydFivm+FGhTGT7QumJBQLdH2svMH9IW6qxedixOJ
 qyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690835877; x=1691440677;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwWbkKef2bg+0OOuHjMxCBeq3VQyMFXC7saiZMO7998=;
 b=P6tP1+x6CljWw2zrTiuHdLRtXhe3VxOyti7sYtrsUb20YCCdzPdHoz04T8JvpUdge1
 saT4eQzNp053jl2+WcfAb6vdRi/9Ud5Rlx0cplIwbYDQKFTxmrcil3CCglhXl1Sdcj/O
 bHaVe22y6ZGjTmgoNJp2MzTFdOGvnx5tv6SkgXuUHvSenwuQE0B0V7U+eGBblUyTyUAV
 aiyeHsTgJVFXln3X3G6V0oAuTFKuTg9rYH/T1MmKoT97lidM90bsvxRH0XpOvYGMiEqm
 i6uZuiMbZx4Vgo6bzx/iGtegrbJoIBfjic63n9afoPhofpW45GqF65IYZ9R+8fLqHHoo
 5O3Q==
X-Gm-Message-State: ABy/qLaahWbR6f45Pdc/afbSqdFA1waZe4WWWPpnguwTBJ/i0aM2nz7u
 pCib4zTEMRXLAWgZNuBUIIFfVQGMQ82IxQ==
X-Google-Smtp-Source: APBJJlHe1vQxLBnvdTnsfSPbwv5i5Yt2s60ebL4a6tzoMn75DPfe9mX7OhqqFCMH+b2JK/1vgfyBzw==
X-Received: by 2002:a05:6000:cc:b0:314:4473:5bad with SMTP id
 q12-20020a05600000cc00b0031444735badmr675287wrx.65.1690835876855; 
 Mon, 31 Jul 2023 13:37:56 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 k17-20020a7bc311000000b003fc02218d6csm14945433wmj.25.2023.07.31.13.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 13:37:56 -0700 (PDT)
Date: Mon, 31 Jul 2023 21:37:56 +0100
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/openrisc: Set EPCR to next PC on FPE exceptions
Message-ID: <ZMgbpMryd755fkvu@antec>
References: <20230729210851.3097340-1-shorne@gmail.com>
 <19b913a1-57d1-1631-06bb-04149b8a7bd1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b913a1-57d1-1631-06bb-04149b8a7bd1@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Jul 30, 2023 at 10:43:45AM -0700, Richard Henderson wrote:
> On 7/29/23 14:08, Stafford Horne wrote:
> > The architecture specification calls for the EPCR to be set to "Address
> > of next not executed instruction" when there is a floating point
> > exception (FPE).  This was not being done, so fix it by using the same
> > method as syscall.  Note, this may need a lot more work if we start
> > seeing floating point operations in delay slots which exceptions
> > enabled.
> > 
> > Without this patch FPU exceptions will loop, as the exception hanlding
> > will always return back to the failed floating point instruction.
> > 
> > This was not noticed in earlier testing because:
> > 
> >   1. The compiler usually generates code which clobbers the input operand
> >      such as:
> > 
> >        lf.div.s r19,r17,r19
> > 
> >   2. The target will store the operation output before to the register
> >      before handling the exception.  So an operation such as:
> > 
> >        float a = 100.0f;
> >        float b = 0.0f;
> >        float c = a / b;    /* lf.div.s r19,r17,r19 */
> > 
> >      Will first execute:
> > 
> >        100 / 0    -> Store inf to c (r19)
> >                   -> triggering divide by zero exception
> >                   -> handle and return
> > 
> >      Then it will exectute:
> > 
> >        100 / inf  -> Store 0 to c  (no exception)
> > 
> > To confirm the looping behavoid and the fix I used the following:
> > 
> >      float fpu_div(float a, float b) {
> > 	float c;
> > 	asm volatile("lf.div.s %0, %1, %2"
> > 		      : "+r" (c)
> > 		      : "r" (a), "r" (b));
> > 	return c;
> >      }
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >   target/openrisc/interrupt.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
> > index 3887812810..9b14b8a2c6 100644
> > --- a/target/openrisc/interrupt.c
> > +++ b/target/openrisc/interrupt.c
> > @@ -34,7 +34,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
> >       int exception = cs->exception_index;
> >       env->epcr = env->pc;
> > -    if (exception == EXCP_SYSCALL) {
> > +    if (exception == EXCP_SYSCALL || exception == EXCP_FPE) {
> >           env->epcr += 4;
> >       }
> >       /* When we have an illegal instruction the error effective address
> 
> According to Table 6-3, when in a delay slot the EPCR should be the address
> of the jump, for both syscall and fpe.  This whole block should be moved
> down...
> 
> >     /* Set/clear dsx to indicate if we are in a delay slot exception.  */
> >     if (env->dflag) {
> >         env->dflag = 0;
> >         env->sr |= SR_DSX;
> >         env->epcr -= 4;
> >     } else {
> >         env->sr &= ~SR_DSX;
> >     }
> 
> ... into the else.

Thanks for looking at this.  This is correct.  I will fix it this way, though
this points to an issue in the architecture (in the manual as "Particular delay
slot issues").  If we have instructions causing exceptions in delay slots like
l.sys it will cause looping.

> With that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thank you.

-Stafford


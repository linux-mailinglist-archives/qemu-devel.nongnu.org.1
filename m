Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8A67A417E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 08:45:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi7zQ-0004sy-UK; Mon, 18 Sep 2023 02:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qi7zO-0004ol-QA
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 02:44:10 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qi7zN-0001RJ-4G
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 02:44:10 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68fb6fd2836so3859883b3a.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 23:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695019445; x=1695624245; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8YHI0lNCMUcAkTBv/45jqxGPuNMP5wtHE3oxepT/ag=;
 b=g5sedAVgWCbxhgBBZcAZHegvv1cDkcfXjzrw0doPvg9qhOU4let9dr86MzQjFdRuv/
 uE4bLO23I6VR3wC+YvAmkgwPvFd9l+0MZmOM0TwV5mEWST9FIZTvHG/RgQyh6doPc2is
 CUC1zqB9MCf6blfdOk492Zt/cYHpeyZvFZkaLO4K3thYXBWdlkqJB+Ub8WDWME5wHUOb
 RnXwipakvLZX0j1eyKx7Fb8v0SA4ewSj3F6Q8qG9apSs7BQzkjrSOpLjqtUTi1yr9BHT
 tqc3Be5CpvkxXnL6m5hG3hRnbpgDiFEdg9HSF8VHcTS5Bq0iETXS5Ho3n+U21zbjXYZO
 B9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695019445; x=1695624245;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G8YHI0lNCMUcAkTBv/45jqxGPuNMP5wtHE3oxepT/ag=;
 b=EI41kzu2Rr4i5fc0z4MRe3kRCS0C1JKGgCW9wmkAjfX1uwgqMEU3iMCbcbISiUIGb4
 Zuwm+TTJ2XVdfjWg64LeYXNCxCFcadaMl2Bz+5dAq8fUn8yosNcehqsnM2QL/NJrkkpY
 QH4mQhQEfF3eUaHI2pQTNOGr/SQYufc6dUFQQVlu8tLUxxwzMjmIiU7vvA2ks4dHaI9q
 3H8I9ISjDzzej8jb0AGZNRFyn5ShZHvvJ/zZ5ocLdb4T0JbCRxCBY0hw6bQmcWlJtvae
 7+sNyzAGI96+ChkF6xqYlkLvJO5na9a0VtIYAI5nhvRz8v0fECIMsHc3JbLF7wxhIW31
 J6DA==
X-Gm-Message-State: AOJu0Yx1oOGYQfosLKCIqHiTvRxPL3QaF4VUttE97KxdXagvTyTqPcXw
 W1nBB15wFT5eHyAm4niBn06kOUjSGQg=
X-Google-Smtp-Source: AGHT+IEcYH2JQpRfw9PPtuqmesruxq99fOcd7rm4vLW+WPhQTkt8RAYMEhKm2GUSR5PqJh4plOv2UA==
X-Received: by 2002:a05:6a00:124a:b0:68f:e121:b37c with SMTP id
 u10-20020a056a00124a00b0068fe121b37cmr9937471pfi.4.1695019444637; 
 Sun, 17 Sep 2023 23:44:04 -0700 (PDT)
Received: from localhost (61-68-209-218.tpgi.com.au. [61.68.209.218])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a62e802000000b00653fe2d527esm6534400pfi.32.2023.09.17.23.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Sep 2023 23:44:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Sep 2023 16:44:00 +1000
Message-Id: <CVLU8T2IALFW.1BIYIZ1T0NEJ6@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
Cc: "Ivan Warren" <ivan@vmfacility.fr>
Subject: Re: [PULL 01/39] accel/tcg: mttcg remove false-negative halted
 assertion
X-Mailer: aerc 0.15.2
References: <20230916033011.479144-1-richard.henderson@linaro.org>
 <20230916033011.479144-2-richard.henderson@linaro.org>
In-Reply-To: <20230916033011.479144-2-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sat Sep 16, 2023 at 1:29 PM AEST, Richard Henderson wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
>
> mttcg asserts that an execution ending with EXCP_HALTED must have
> cpu->halted. However between the event or instruction that sets
> cpu->halted and requests exit and the assertion here, an
> asynchronous event could clear cpu->halted.
>
> This leads to crashes running AIX on ppc/pseries because it uses
> H_CEDE/H_PROD hcalls, where H_CEDE sets self->halted =3D 1 and
> H_PROD sets other cpu->halted =3D 0 and kicks it.
>
> H_PROD could be turned into an interrupt to wake, but several other
> places in ppc, sparc, and semihosting follow what looks like a similar
> pattern setting halted =3D 0 directly. So remove this assertion.
>
> Reported-by: Ivan Warren <ivan@vmfacility.fr>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Message-Id: <20230829010658.8252-1-npiggin@gmail.com>
> [rth: Keep the case label and adjust the comment.]

Hey Richard,

Thanks for picking this up.

I think EXCP_HLT and EXCP_HALTED are effectively the same, so they could
be merged after this.

I couldn't quite decipher the intended difference between them, HLT is
"hlt instruction reached", but it does tend to go into a mode where it
is halted waiting for external event. Is there some useful difference in
semantics we should retain (and at least try to find a way to assert)?

I did look at how to avoid the halted race and keep the assert, e.g.,
have the CPU only modify its own halted, and external events would have
a wakeup field to set. In the end it wasn't clear that that was any
simpler and you still have races to reason about, now between the two
fields. So unless someone wants to keep both, should we merge?

Thanks,
Nick

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tcg-accel-ops-mttcg.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mt=
tcg.c
> index b276262007..4b0dfb4be7 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -100,14 +100,9 @@ static void *mttcg_cpu_thread_fn(void *arg)
>                  break;
>              case EXCP_HALTED:
>                  /*
> -                 * during start-up the vCPU is reset and the thread is
> -                 * kicked several times. If we don't ensure we go back
> -                 * to sleep in the halted state we won't cleanly
> -                 * start-up when the vCPU is enabled.
> -                 *
> -                 * cpu->halted should ensure we sleep in wait_io_event
> +                 * Usually cpu->halted is set, but may have already been
> +                 * reset by another thread by the time we arrive here.
>                   */
> -                g_assert(cpu->halted);
>                  break;
>              case EXCP_ATOMIC:
>                  qemu_mutex_unlock_iothread();



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD72798A25
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 17:43:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qedcI-0003wE-98; Fri, 08 Sep 2023 11:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qedcF-0003lP-Ph
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:41:51 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qedc9-0003w2-5j
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:41:47 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-500913779f5so3796938e87.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694187697; x=1694792497; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pBgTHklQNbdjDjd8eoz0tW/JQGecWV1WEnHbYq378R8=;
 b=LqNg8T6CQ/FxuuXT1l4Kz0BOyidcsM97YG5VFFBu/qEJnYt2XctKxd8uy7QwTSR4FO
 wAfwV5syahcvVG2qNECLSIOdCziODuQNgkfnHMTk/4cV0xfZe9HaqS4o+jmlezZUhoY3
 aXkvuJ8fmnHOqW0IYdht5E86iJFj+fT6AOlmkywk85iOwIe3ibOO1WrTP7kxCn9V7oWq
 MKl/ESIlK2aJfFsGE7ZfT+zrPRs9PGDan07xTJcGnxmNaRRtYVo/GqKw6QKER4lu/rSn
 A/R6+2S5v9Y3flOi+yvfM/olqxub49yJbafy/izBJIwpQekvPmJzA7DzFBLBOmRcigWz
 H16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694187697; x=1694792497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pBgTHklQNbdjDjd8eoz0tW/JQGecWV1WEnHbYq378R8=;
 b=kLjHRgtfaNhRD87I73H7TRRO52XVSZdS3ja2mAuLmeNSNlZHKxKZHlGA9TtCxaVFvz
 q+OZEmhlCXE4nR8XQ3wdD6USp85wXfkN48t97fFoajjIvm6gxuUyOQgUVC0JfFmdDuH+
 iXDMum2qMoM0SpV6th5FfLw0tgm+3g9t+wag5CH1QwqxXs6V2h2Ocjwt+wId87znECXM
 U4RYgcZPWlk5zazRpaMVwML3rscck38v85jsQdvvSplt71218moOBVy1NgU3lmvAqRm7
 gThI1UnP/Z5l+4hZYsIfponu8Og22tf5zzNSbvvS1M7sE27mYavpDMrFrjSIBgQVxs1r
 OGdw==
X-Gm-Message-State: AOJu0YxGZMCDWt5nWQIT4KvRAQpp08cF5o2gOkWSJYZWetKpfWHfGqC6
 J4m9ZrF9sJC2XNzQuMVUUqj8hnAc9Ey+hN6JLUFFB+GlW1YyBHj/
X-Google-Smtp-Source: AGHT+IECmaQLoL0Fs5RP0mpmWZiAsvuPBsWjbbiyx90HcRMpy4BmRmR/e3dcfdf4+Lp3wCo1CunNSucSE0snttigre4=
X-Received: by 2002:ac2:5de9:0:b0:4fb:7c40:9f97 with SMTP id
 z9-20020ac25de9000000b004fb7c409f97mr2106235lfq.27.1694187697112; Fri, 08 Sep
 2023 08:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230829232335.965414-1-richard.henderson@linaro.org>
 <CAFEAcA9K6+c24rEORCF1vNav38kS5UBBVtSeC9T=DjV1_i0PDg@mail.gmail.com>
In-Reply-To: <CAFEAcA9K6+c24rEORCF1vNav38kS5UBBVtSeC9T=DjV1_i0PDg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 16:41:26 +0100
Message-ID: <CAFEAcA_PTJ69+LexN_Ca=GwjRfQyT_N-+qg34QEyQLgpCEUSwQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] Implement Most ARMv8.3 Pointer Authentication
 Features
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, aaron@os.amperecomputing.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 8 Sept 2023 at 12:55, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 30 Aug 2023 at 00:24, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Changes for v5:
> >   * Updates for review.
> >   * Include linux-user ESR changes.
> >
> > Patch 10 is the only one without review.
> >
> >
> > r~
>
> Applied to target-arm.next. Thanks to both you and Aaron
> for this work.

It turns out that there's something wrong in the linux-user
ESR changes and they trip the clang sanitizer:
https://gitlab.com/pm215/qemu/-/jobs/5047578129

TEST linux-test on aarch64
../linux-user/aarch64/signal.c:583:21: runtime error: member access
within null pointer of type 'target_siginfo_t' (aka 'struct
target_siginfo')
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../linux-user/aarch64/signal.c:583:21 in
make[1]: *** [Makefile:178: run-linux-test] Error 1

where that line number is in need_save_esr() on the
first line "int sig = info->si_signo;".

On non-sanitizer CI runs you just get a straight SEGV:
https://gitlab.com/pm215/qemu/-/jobs/5047578115

TEST linux-test on alpha
timeout: the monitored command dumped core
Segmentation fault
make[1]: *** [Makefile:178: run-linux-test] Error 139
make: *** [/builds/pm215/qemu/tests/Makefile.include:56:
run-tcg-tests-aarch64-linux-user] Error 2
make: *** Waiting for unfinished jobs....

I'm going to drop the 3 linux-user patches from
target-arm.next.

thanks
-- PMM


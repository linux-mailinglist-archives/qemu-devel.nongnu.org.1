Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4201A73FA7C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:48:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6FE-0007m1-16; Tue, 27 Jun 2023 06:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE6FB-0007lL-VZ
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:48:21 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE6FA-0006pR-Er
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:48:21 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51d804c7d14so3636941a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687862898; x=1690454898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aCvwh8ISYeNmmapRBIHhlct0MLWF0qCkci0E1akVbJw=;
 b=lMzOuLMGoXLx8nHitgq3lg8p09BO/DMT0u5t5TzZe0wJQoj+DxNEX10i9Z84p3AD9O
 ZEbmPiE4UmLi4m4VGgl5x355KYYnqYZLY5Qt5SBtuPKUQGk5g4BkABNaQuPV9u6gBAtn
 ySB31F/uoWXWZ2B/BND1KgOY+skoeWkuYf2raEXE16CFrVLwBih8/9MTvR94JipK3i7n
 F1aq+I2o7SeJgT3w86CSw4qrhPMbYra3fqkWhadciNWPzDy2UcymVavf25x9CaLuNszE
 vTA1jI+8iI3qaWIfdhG/XF/+7rG4E8F0BkY++0wZd+3GiH9qPje2xnXaPFbzsnsIHI6R
 456w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687862898; x=1690454898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aCvwh8ISYeNmmapRBIHhlct0MLWF0qCkci0E1akVbJw=;
 b=jnWZQm6lUIh+VlwILw2YtMm78Dri+S0DGmZUdPgWWhUclhAoXqiRPmuWguA9qdesW3
 ZEchlqkRC9qobWJkLqXHuYZu6OXSAXRGhsFbeMw7kRw5IVmW6gh4d8yp97fdZfJriP48
 720lDA2+AfZST1ZvDDySWuMseI5prNSv7e1estQVp2SiBhD4Hj8fDF1i4r9eQ+cFvb7E
 pXcQu9A4G8nai9L7TKmGjSK3rVWnAXuvLwI+mDe+1eoXlnyp/rhhHxGFHtRSSmm5Xj13
 jsSZSUmt9eilBkh/DYpnH5MRkf1JUs15ew5Lgj/sNaevuz3avWtWIhVUwX0PucID2im3
 Pc1g==
X-Gm-Message-State: AC+VfDyp5YBL+dY0FWBqtp+ghfkfGQ/ptCkiFFphdzmhqjIXlnQJNc72
 aT6Uw/l90USdJySlL6dQjHer7y94R3HKsmpS27HPCA==
X-Google-Smtp-Source: ACHHUZ5jj4hJpqOSavWDIJIebDBaod3mKU6LjvKcTks8+tZmnhee/9Ili5Xw3ZwOPfV0gLuLfP4Dd1sdIhzSj9EUfaE=
X-Received: by 2002:aa7:cf1a:0:b0:51d:91d2:335b with SMTP id
 a26-20020aa7cf1a000000b0051d91d2335bmr5143205edy.1.1687862898657; Tue, 27 Jun
 2023 03:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230623035304.279833-1-npiggin@gmail.com>
 <5a4ff40f5adc9aa4a1b173fdfb4e179a53c922f3.1687522225.git.quic_mathbern@quicinc.com>
In-Reply-To: <5a4ff40f5adc9aa4a1b173fdfb4e179a53c922f3.1687522225.git.quic_mathbern@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 11:48:07 +0100
Message-ID: <CAFEAcA-jxGXzkyti3k-P=fOwcmJ+fSa1abKFvNHodYzA+VS+bA@mail.gmail.com>
Subject: Re: [PATCH] gdbstub: Permit reverse step/break to provide stop
 response
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Cc: npiggin@gmail.com, alex.bennee@linaro.org, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, tsimpson@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 23 Jun 2023 at 13:19, Matheus Tavares Bernardino
<quic_mathbern@quicinc.com> wrote:
>
> > Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > The final part of the reverse step and break handling is to bring
> > the machine back to a debug stop state. gdb expects a response.
> >
> > A gdb 'rsi' command hangs forever because the gdbstub filters out
> > the response (also observable with reverse_debugging.py avocado
> > tests).
> >
> > Fix by setting allow_stop_reply for the gdb backward packets.
>
> Ah, it's interesting that [1] doesn't include 'bc' and 'bs' in the list
> of cmds that may respond with a stop-reply packet:
>
>     "The 'C', 'c', 'S', 's', 'vCont', 'vAttach', 'vRun', 'vStopped', and
>     '?' packets can receive any of the below as a reply."
>
> But their definitions at [2] do say the following:
>
>     'bc' (and 'bc')
>     [...]
>     Reply: See Stop Reply Packets, for the reply specifications.
>
> So I guess the list from [1] is not exhaustive. Anyway, thanks for the
> fix!

That looks like it's probably a gdb docs bug (forgetting to
update that list when the bc/bs packets were added); we
should probably report that to upstream gdb.

thanks
-- PMM


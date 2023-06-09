Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D82CB7297D0
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 13:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Zwg-0004eK-VQ; Fri, 09 Jun 2023 07:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Zwa-0004cu-QB
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 07:06:14 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7ZwY-0005u5-RL
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 07:06:12 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b203891b2cso17603981fa.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686308768; x=1688900768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VCWmmOH099LoMnFejNB7Wrepsh2izdQnSDpyFHuq4YU=;
 b=w+ceYkYQ55DtIYH0wix1hmPWkOqX0M3CJM3V8gSrd+WNmWU4XcO5bUUqCjXBiXK0+S
 BoleNeI7Z1PTki28i9ZH20OkNrWfBuGzyhN8G446wW+qBXmy0F5CxcJklwXQp/0jglHq
 SWOFJHFPnAgJNumJICIx9GCiWghF1cNj01TsHDx7CkKY2K6QqBXlwcGpB9NPKbrlS9kq
 XBJdjtaUxmm86H0I5zBiK+3r6DbjA4OtAdvkIlW8Emq4F2/7gOy1h+3tC9vazusSKim1
 b9jbCExhAUKrt+1mVo0pj53mEAwKwkh2EzQd511yHoGdXsufNx6wozqOmPQHWMxbg+AZ
 TIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686308768; x=1688900768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VCWmmOH099LoMnFejNB7Wrepsh2izdQnSDpyFHuq4YU=;
 b=OvnfKyKk9HyRLrwaw43ZSxBV811RhBE8DJtsGK2RNfKOZBSdDcNZlFVqqq+PJRMgU0
 yKmrfTH85vJ3hfWBw+BdJpqEYEYBRlrMWqHjnyim7UdnCnhFKHHVJSFRBCDxjzvqlPA1
 0N3AcnlX48GE6CiHC9za/cVLIrusHQTZ9BMJFQaOmXXCErR6mlZS3rI1uCayzyggdeTr
 7gYq5HtULSAzeVlMJfsBgEPHCZG9uOiSNujVj8baxAMFTP+SxNCRwbEajZHOCpgMR9U7
 z77UtCOE0m4Cgm20zfla5BfaMrN4dhYMacbWgrkluGGSR50JJGViqmZu6wtxN8pZJzsy
 mZpg==
X-Gm-Message-State: AC+VfDw2dIw14ATXUzKtiDM+h/zzAR08pFxiMtM6XVVhhLHvD1LsqW7/
 B6JWOn5cetr8Eo0j6h1dFZR0Nf/X24WFG78fQjTSjhgCQn7/KhWJjIk=
X-Google-Smtp-Source: ACHHUZ7sY4UsIEXfYK2LqgfZ1aWgWPFL3/1qhFzPaflQ0RtfAXb452iLrQfphzJyqyPZcloggZCak+69WDVTep9InU4=
X-Received: by 2002:a2e:9d4a:0:b0:2b1:e369:40 with SMTP id
 y10-20020a2e9d4a000000b002b1e3690040mr810502ljj.27.1686308768510; 
 Fri, 09 Jun 2023 04:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8oS7fOr9Ro6Z9G5UW6FbgwTo3BTcGL4ELdVc_G7O5Obg@mail.gmail.com>
In-Reply-To: <CAFEAcA8oS7fOr9Ro6Z9G5UW6FbgwTo3BTcGL4ELdVc_G7O5Obg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Jun 2023 12:05:57 +0100
Message-ID: <CAFEAcA9=P+P09Gi+gO7PhSm==L5-4VZyujujEUCLN1HfprA0XQ@mail.gmail.com>
Subject: Re: vmovqdu/vmovqda inline asm doesn't compile on macos catalina
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

Richard: ping, any idea if we can get rid of these errors?

I have a simple standalone reproducer if you want to try different
asm syntax:

$ cat atomic.c
__int128_t atomic16_read_ro(const __int128_t *ptr)
{
    __int128_t i;
    asm("vmovqda %1, %0" : "=x" (i) : "m" (*ptr));
    return i;
}
$ cc -o /tmp/atomic.o atomic.c
atomic.c:4:9: error: couldn't allocate output register for constraint 'x'

thanks
-- PMM

On Mon, 5 Jun 2023 at 11:55, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> I just noticed that the recent atomicity changes introduce a build
> failure on x86 macos (Catalina). Now if we wanted to, we can say "this
> is too old and outside our support policy", of course...
> (I don't know if newer x86 macos is OK -- this machine can't
> upgrade to anything newer than Catalina. So it's due to be
> decommissioned pretty soon anyway.)
>
> In file included from ../../accel/tcg/cputlb.c:1673:
> In file included from ../../accel/tcg/ldst_atomicity.c.inc:12:
> /Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:38:13:
> error: couldn't allocate output register for constraint 'x'
>         asm("vmovdqu %1, %0" : "=x" (r.i) : "m" (*ptr_align));
>             ^
> /Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:40:13:
> error: couldn't allocate output register for constraint 'x'
>         asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
>             ^
> In file included from ../../accel/tcg/cputlb.c:34:
> In file included from /Users/pm215/src/qemu/include/qemu/atomic128.h:62:
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
> error: couldn't allocate output register for constraint 'x'
>     asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr));
>         ^
> In file included from ../../accel/tcg/cputlb.c:1673:
> In file included from ../../accel/tcg/ldst_atomicity.c.inc:12:
> /Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:38:13:
> error: couldn't allocate output register for constraint 'x'
>         asm("vmovdqu %1, %0" : "=x" (r.i) : "m" (*ptr_align));
>             ^
> /Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:40:13:
> error: couldn't allocate output register for constraint 'x'
>         asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
>             ^
> In file included from ../../accel/tcg/cputlb.c:34:
> In file included from /Users/pm215/src/qemu/include/qemu/atomic128.h:62:
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
> error: couldn't allocate output register for constraint 'x'
>     asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr));
>         ^
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
> error: couldn't allocate output register for constraint 'x'
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
> error: couldn't allocate output register for constraint 'x'
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:55:13:
> error: couldn't allocate input reg for constraint 'x'
>         asm("vmovdqa %1, %0" : "=m"(*ptr_align) : "x" (new.i));
>             ^
> In file included from ../../accel/tcg/cputlb.c:1673:
> In file included from ../../accel/tcg/ldst_atomicity.c.inc:12:
> /Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:38:13:
> error: couldn't allocate output register for constraint 'x'
>         asm("vmovdqu %1, %0" : "=x" (r.i) : "m" (*ptr_align));
>             ^
> /Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:40:13:
> error: couldn't allocate output register for constraint 'x'
>         asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
>             ^
> In file included from ../../accel/tcg/cputlb.c:34:
> In file included from /Users/pm215/src/qemu/include/qemu/atomic128.h:62:
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
> error: couldn't allocate output register for constraint 'x'
>     asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr));
>         ^
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
> error: couldn't allocate output register for constraint 'x'
> 13 errors generated.
>
> -- PMM


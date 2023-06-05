Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0787223FE
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:56:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67st-0001yv-KR; Mon, 05 Jun 2023 06:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q67sp-0001xY-MB
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:56:19 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q67so-0000kY-1U
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:56:19 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b1ac373c9eso40299671fa.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685962576; x=1688554576;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9Mag1kA0xuclkS5aULarCQDOHIrW/8N/WV3BvNF6fjc=;
 b=QJNdv0SE6fXXTkBSS6IA9yeyBIDiqkiC+BMqerg/moH/UScEjovZUgu4y/9h6kenKd
 J0JssmTGzDiVCECnAUHrcLMrQaTSzSeDoVpq8efkrkE9zCI9Ot49xJP1DNwFdg5m8v/U
 vs013TFIYanu1qS/MRuR+LzvFXQZKs6LXjp3fmxwYsJXQUTnSsdS4X5jauKj+NXSA7Xm
 XR9Yzl4Lu/ERZP3IsjGftNGVtjHEsYZQfMa3rSKJYUX+QMORFuGeWBOHNdW5ZNf1xqut
 y1Xt4CgkQG9GWLK3JsVFwoUx/DeSS/Cln/WRjI6Cw5hFbAJvgrYZXtJ/Lzd/WyX6tz+q
 WjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685962576; x=1688554576;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Mag1kA0xuclkS5aULarCQDOHIrW/8N/WV3BvNF6fjc=;
 b=RQG9NBttsfy2IPOsccj1hgjze1MN77SkTgbGq1K1lqcPoYK6n7Pv45jXWxze6OWEkw
 3vi8GcE1ulE7SlXAhc/FtFuPMCRPs4iaOuOEQ2R51P/J/qRnnkts/NiIqPhRmxZn6pHo
 XR4uS/dSnAIKawcfSXi01h3VoPZ5R7Y7NuGSJeumgxKnx/KG5ynFHwiyAEySdQVgSJoj
 AhOva9AUZl0Br6Dx6dx7liqBvED3ZmvwAd96CIC8Y385zMttoutxiPBBnOeQpn/MpVWE
 fBZ/idR1/mETKyB109+UCp9LY1Hge/y8A6yk5kzSNfe8LACvuBiKQFuoV35LTXQONicU
 oYcg==
X-Gm-Message-State: AC+VfDy1xWScTla7rS7rJx2sgfmYgP6ErCs0DlY0FLFwFM5+bMwnRqWz
 NN70XhmSly+mf2cp2uSvfBhxqVg4goltLerFj9tCHlgFhsJM19yMoJc=
X-Google-Smtp-Source: ACHHUZ67wqkNXTRrvKi5dH4thYP+qHWsV7zJ/nYCPrxM5sNoseLFe04aL1qzG6tMZSuEqZFQm2oepgxMh0rgxqzb7CE=
X-Received: by 2002:a05:651c:1023:b0:2a8:a9f7:205b with SMTP id
 w3-20020a05651c102300b002a8a9f7205bmr4248257ljm.36.1685962576260; Mon, 05 Jun
 2023 03:56:16 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 11:55:43 +0100
Message-ID: <CAFEAcA8oS7fOr9Ro6Z9G5UW6FbgwTo3BTcGL4ELdVc_G7O5Obg@mail.gmail.com>
Subject: vmovqdu/vmovqda inline asm doesn't compile on macos catalina
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

I just noticed that the recent atomicity changes introduce a build
failure on x86 macos (Catalina). Now if we wanted to, we can say "this
is too old and outside our support policy", of course...
(I don't know if newer x86 macos is OK -- this machine can't
upgrade to anything newer than Catalina. So it's due to be
decommissioned pretty soon anyway.)

In file included from ../../accel/tcg/cputlb.c:1673:
In file included from ../../accel/tcg/ldst_atomicity.c.inc:12:
/Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:38:13:
error: couldn't allocate output register for constraint 'x'
        asm("vmovdqu %1, %0" : "=x" (r.i) : "m" (*ptr_align));
            ^
/Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:40:13:
error: couldn't allocate output register for constraint 'x'
        asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
            ^
In file included from ../../accel/tcg/cputlb.c:34:
In file included from /Users/pm215/src/qemu/include/qemu/atomic128.h:62:
/Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
error: couldn't allocate output register for constraint 'x'
    asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr));
        ^
In file included from ../../accel/tcg/cputlb.c:1673:
In file included from ../../accel/tcg/ldst_atomicity.c.inc:12:
/Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:38:13:
error: couldn't allocate output register for constraint 'x'
        asm("vmovdqu %1, %0" : "=x" (r.i) : "m" (*ptr_align));
            ^
/Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:40:13:
error: couldn't allocate output register for constraint 'x'
        asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
            ^
In file included from ../../accel/tcg/cputlb.c:34:
In file included from /Users/pm215/src/qemu/include/qemu/atomic128.h:62:
/Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
error: couldn't allocate output register for constraint 'x'
    asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr));
        ^
/Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
error: couldn't allocate output register for constraint 'x'
/Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
error: couldn't allocate output register for constraint 'x'
/Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:55:13:
error: couldn't allocate input reg for constraint 'x'
        asm("vmovdqa %1, %0" : "=m"(*ptr_align) : "x" (new.i));
            ^
In file included from ../../accel/tcg/cputlb.c:1673:
In file included from ../../accel/tcg/ldst_atomicity.c.inc:12:
/Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:38:13:
error: couldn't allocate output register for constraint 'x'
        asm("vmovdqu %1, %0" : "=x" (r.i) : "m" (*ptr_align));
            ^
/Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:40:13:
error: couldn't allocate output register for constraint 'x'
        asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
            ^
In file included from ../../accel/tcg/cputlb.c:34:
In file included from /Users/pm215/src/qemu/include/qemu/atomic128.h:62:
/Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
error: couldn't allocate output register for constraint 'x'
    asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr));
        ^
/Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
error: couldn't allocate output register for constraint 'x'
13 errors generated.

-- PMM


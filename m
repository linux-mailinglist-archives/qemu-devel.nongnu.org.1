Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E17777E80
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:42:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8jG-0003iN-0L; Thu, 10 Aug 2023 12:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8j9-0003h0-2Q
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:41:35 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8j7-0000V4-EI
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:41:34 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fe82ac3ab4so1644882e87.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691685692; x=1692290492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b8AAX1HEkupo+tqEtWJV6eUhNeCUQbFrc488Z8Uoplo=;
 b=O3Hx7YHmUJBdo6PTg+ECeZY/1GC78bhftaBNe7ttUVRfWTUJiJrjU+8t0gJrKDFEzg
 FRlVq/fmMQzWn3I3sbD4qNbbL7H/krAWg/uCJTadtY6icV7ysQgeVlSpNbTMM/b2gL1N
 LPD6bkyDjXuxylruTYnEuPlRxHZ19GliPq2S2pH0Atndc8nwtZqfdZKQwW/SkLkerzAi
 rMOARP7LbZmCNT+CHfDoHlcCIs/VWm7IW7tny+g8HXJPX34x6Wb6w6p1+h1ZpHEMNTDm
 /bt64NM5M5z10Ru1sJwNbwNLvRWXYi1/XQrPfN7EbukuRmGph4S8qiKHLQeMdZYg7uLT
 BSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691685692; x=1692290492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b8AAX1HEkupo+tqEtWJV6eUhNeCUQbFrc488Z8Uoplo=;
 b=OfE27FF8Pvi1gXCmBejBNqL1GyDiVBEpzUZU9E3IV+7xesz/aslwUkAZ3ox4BCtnSx
 z5Xy/LHbrryejAlug7Lo3qCmxn74wi8wopW5CMcUykWuzSP8tyeWUUga8j9BBGbqPPzg
 Ui5bN7qtgB66SlOF8tS/WUfRvn58qtzmAuIofvG8uTPLE+kjrf4mcbW8b1rJNb1IPZhZ
 LscKVvmL/HrbQeDafmuS6O4pGCsFjElOC3NYUfWUADojk3bl4VrArEidOXdZQS28+uDk
 Iew4M21hI+GuzE21afCvO6tPgJKffYyKFycvGF4QxTFoTQKrx0/vtinzuX4ivzYRfZtE
 urxQ==
X-Gm-Message-State: AOJu0YxTZVFXSd12/j602B27dILmKKEo2yPbPCdquxOONgQWAyUgKxfY
 SPX1dqsqXT3Vc0B9/yW8gyPzMLw/lb24alEws7qCw3efFInOFhlx
X-Google-Smtp-Source: AGHT+IHnES09lIDN7GdSyko7mSIUhxBNsBoJIBUEHvuS456VM7pXHr3/iTbYctTlhnsW1nghs6h3IKE/EoM84FkJ6fw=
X-Received: by 2002:a05:6512:3696:b0:4f8:5cde:a44f with SMTP id
 d22-20020a056512369600b004f85cdea44fmr1880839lfs.10.1691685691596; Thu, 10
 Aug 2023 09:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-14-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 17:41:20 +0100
Message-ID: <CAFEAcA9j4NcpwLudKc8kDEdEV2itXS1UTyR2u97hROWJ_n9=pg@mail.gmail.com>
Subject: Re: [PATCH 13/24] tcg/arm: Implement negsetcond_i32
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On Tue, 8 Aug 2023 at 04:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Trivial, as we simply need to load a different constant
> in the conditional move.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/arm/tcg-target.h     | 2 +-
>  tcg/arm/tcg-target.c.inc | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


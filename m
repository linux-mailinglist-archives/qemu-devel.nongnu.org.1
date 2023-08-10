Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D39777E25
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:24:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8SS-0006V9-7X; Thu, 10 Aug 2023 12:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8SP-0006Ti-Fr
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:24:17 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8SO-00054j-3G
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:24:17 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-522ab557632so1369135a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691684654; x=1692289454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i2mcToMniKLoxJuyIOSXHvvMNrpA05EweuAGyGbT8dM=;
 b=Q60wI34sMiXv3pG/2PBj71fExmDk90yyeELgAFBl72RA+fo9HZYGOeXL4S0nbeijQ7
 M//Qzwv74oI/HI8yDKF32iBpWnAElQFO+Qh/FUt5KqPEcn2dE5xqr2nNk2Sn+B+7DJSz
 +mu/ziuKfaKFeGZuNZlrtsk6bbouis3oOCMWZEu166QtFtRFYSCNJLCJSFRn+NGJQMzU
 OYJLd3J/pAoijvuE6Ga6vsKw/QQRgAAjumsKRU3x+D36nxyntyy/wrvzPvVTWmXFtuHt
 sGkuDBBDjQJriQO7g3FOOaWzPzCCVeeMSrp+gFvmdVoIIueQVrcElVkZdKQAVwF4m3LQ
 NsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691684654; x=1692289454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i2mcToMniKLoxJuyIOSXHvvMNrpA05EweuAGyGbT8dM=;
 b=H8lS4mU4QsoQgumHjI0J00Xbe99wzZSmFkN4OB9KP8vIMnTKms9NYeMUCLNYPTqi+4
 yCjPC8hfx59HLRv5Vw9fic4vNa/wwZJSUNAXaBDjFNDpeikAiLJBK6qTMnhUsDyr3yLz
 mY8br38pFjhZapUH/X/CH5LS638aDSwjL8vJgnCrMWx9iUYtUC36v38AMXS1jzlnpGDx
 PJ/8GxcTVHQ3UNypGuhlt23aaESKn6xUGpNhauQ8TnASYQg/i4LJVJf1y2FPggzmjcvT
 sVDMk8YVhwdPaFbgBdzDyDfqE156/nwqUqT4J6av1d9qRMx5RYpPJIy2l6OGwrEYurNz
 nW6w==
X-Gm-Message-State: AOJu0Yzt/aOok8iKR/UIbzhi5+CDNO1N5E0pFROPb5vWD14mFN9w/85V
 qd5SJpCdPUABwKSz/YTALD5dHvdsvq7CBTT59ufObQ==
X-Google-Smtp-Source: AGHT+IGBn/YeSP/Dq2VOo/oYIO5zmecaqh33bf5nTZgvqtyTVVtyXoKDMHGSlyjiLoUSPUsdOHQVsLDHnSTqhfDYMzw=
X-Received: by 2002:a05:6402:31eb:b0:523:4c93:1c0f with SMTP id
 dy11-20020a05640231eb00b005234c931c0fmr2404412edb.21.1691684654604; Thu, 10
 Aug 2023 09:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-6-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 17:24:03 +0100
Message-ID: <CAFEAcA-OH--irvgpBP6BFLsCZf+2XT=1s=u+xsivRdNi8jwxPg@mail.gmail.com>
Subject: Re: [PATCH 05/24] target/m68k: Use tcg_gen_negsetcond_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 8 Aug 2023 at 04:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/m68k/translate.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


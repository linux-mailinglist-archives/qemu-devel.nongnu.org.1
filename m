Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F1E79880E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 15:44:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qebmO-0001oQ-1i; Fri, 08 Sep 2023 09:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebmL-0001ed-S5
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:44:09 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebmJ-0007WM-Kj
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:44:09 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2bd0d19a304so36790681fa.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694180646; x=1694785446; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JnWAPaytL47BZJ5aTLD4mxXO1BCTndRYvryRSYsMG5I=;
 b=zfL3wdy7U0rplZwZr2nD41wfTTmGvsGo6fbYMnI7OdhPTjJfh3ckWBOgo08kfYHb5g
 hshxDrq5OVGCsCCjAL65FC7d0TyCSahsIfKySZEBwwmcvCK34r6wABnYQDNsMxUygDiz
 8r5/lEOo5bM1cxXtPTQ1+FY/xNVXDFNmLtXik2awYnOtzEXM2KF0SUS7hQ0L3ghl90wm
 oNIkzDZRbPgMs/ZWckk6cmil82ldkJYzIZRmTOKgBRmtW+PXGdnWMUPFz/8rqlZvuCzF
 XA06rguFGLWx2kiQstU8nrzuDv10cmWf0Houttiupu4U4JT4pGCHT6JyGpNE1dla5WL5
 lVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694180646; x=1694785446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JnWAPaytL47BZJ5aTLD4mxXO1BCTndRYvryRSYsMG5I=;
 b=dvxLVh9TYD8hxMEr/4kkdJJ7PVYvhtku7fL0xamqQa9pqVrRPdHBTdrmSykgvxm6SC
 yPfzDaATjublqr/mOmLpNVddbTXuEkZLlxJfsnYadM0d+B6WOZlFlvfdzv5LcCO7Su6N
 2vYpAVAtrSI/AdvOGONxeJz0efH+u6o/RZJYMnrT4NLw0FicYLoR2B9yRMncsjN/jIXS
 QRtS0sKaBie3YhGq3LlP/F8ujuWPj7OlNLJt8icWQvMrQb/7un+Go1R/KiT8c4GH4dkI
 E6XI0iAqm5ZEWLYcTqYPTGW4Q1BKtBigGx6EWwC4tRH3dC5aO0QZjHe3gjKcVhe8JtsV
 FIeg==
X-Gm-Message-State: AOJu0YxsPUo7LLmhwpe4Fqk9Rj4SIf2Q1PVelSnmvAbqS/xt7U+PNf1P
 wJ/QuReEWaqf2VPQHo4B5OuJVtTmfhQi23AYUFBdtA==
X-Google-Smtp-Source: AGHT+IFIyPlWAF5WBYRuFxVR6ADVVCJJRBOAffsQvpFujSbijIbNRX8jU65CPoBXqh194nOH0niRCl4eamglurZ/itI=
X-Received: by 2002:ac2:488f:0:b0:502:9253:c56f with SMTP id
 x15-20020ac2488f000000b005029253c56fmr1625867lfc.44.1694180645761; Fri, 08
 Sep 2023 06:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230831232441.66020-1-richard.henderson@linaro.org>
In-Reply-To: <20230831232441.66020-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 14:43:54 +0100
Message-ID: <CAFEAcA-ZH6ufnN7wMrFN_vkWRZoAFkhOzuUchhKBwcXYNdkiUw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] target/arm: Implement cortex-a710
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Fri, 1 Sept 2023 at 00:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v3:
>   * 9 patches upstreamed
>   * Implement RMR_ELx generically, as a stub.
>   * Implement TIDCP and the closely related v8.8 FEAT_TIDCP1.
>
>
> r~
>
>
> Richard Henderson (5):
>   target/arm: Implement RMR_ELx
>   target/arm: Implement cortex-a710
>   target/arm: Implement HCR_EL2.TIDCP
>   target/arm: Implement FEAT_TIDCP1
>   target/arm: Enable SCTLR_EL1.TIDCP for user-only
>



Applied to target-arm.next, thanks.

-- PMM


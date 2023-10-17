Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D81F37CC35D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:40:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjNC-0005aO-Kl; Tue, 17 Oct 2023 08:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsjN7-0005Vd-Uz
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:40:30 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsjN2-0007Ub-Uv
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:40:26 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53da72739c3so9418923a12.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697546423; x=1698151223; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r0QIgBtowzSJ55PrgABlXL74OTmeFvX5QvUBMAW1EAs=;
 b=Dki+A9eETXuuFsYC00WEh0/vQr9VEV77vFoZJbIgdAjZSCc5X2gVeTzdRtFPAigOaD
 EE+3RXWQxUnlx7BXugU2dMqdVuwsy6LTsPGF6Pe1snaKtRlRMotOIluzXrvC44zzTlM3
 Pb5jDP5DJ3L6GZjnRT76DSBkYpwfpmXINNUXwd/CIj7unel/WlZm+fhbTXeIY1HcNP+5
 IVFCX142m9Gyn59WU20P6WgqfMa5zCOju/Gza0sdNt5FB2oQYe3v7Usud0Kxd36FVqah
 mPDawGdQQISIUSJfsYQQJe7FmgD86z4h7OktqbVFIRC5aNNSZ6l7YLwGL2prQwMFg3lI
 sBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697546423; x=1698151223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r0QIgBtowzSJ55PrgABlXL74OTmeFvX5QvUBMAW1EAs=;
 b=GN9qzMB5llZ7oOQa2JEyJFjK1WudPq3EIww/S//gVOvoW3n4fl2wOVEPLg8By9OCVh
 wVOjisg/uBSjdEuC0mvMGcBC3YBHoCMdfBw+gwCaNKv1ksgKSgDS1t02JaYiMj+OaoYP
 7J357NDOQVL/ZwKm2wtrFgSUpCsGDZVHWxVyZ0tgVFIR7nmCMKpPHXtPwSoxm/57Dx9Y
 57KKiDUSABmEQf/HMppvaTdf+WNzPuto6mK8K6AXA/jvaAEQ+RxpAATq2WT3ZL3bH19W
 V0JXmxriOAQbMW78ugY/1X3XxEJkF8wc3yVYqhNB8ZPUKqL7f0u7xRBY1TaZu7+3airc
 7d0g==
X-Gm-Message-State: AOJu0YyBZxtZObg4ArVXMO5wPxNKHxvVYPgCmOza/1mibyTyuVdWdya/
 zepuxagBAuwBQ1tTbXZJ98DmCQoV990s7xrRJiByOg==
X-Google-Smtp-Source: AGHT+IGCIAMcIuVHuVdGJhWmnffWavr+gGhpF0aBbYnLS8xnH4MidD3t/6krAOzIG2H016Zgf+fqJIN4YdRpFGN8rHE=
X-Received: by 2002:a05:6402:5194:b0:53e:395:59d with SMTP id
 q20-20020a056402519400b0053e0395059dmr1782315edd.8.1697546422752; Tue, 17 Oct
 2023 05:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230915185453.1871167-1-peter.maydell@linaro.org>
In-Reply-To: <20230915185453.1871167-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 13:40:11 +0100
Message-ID: <CAFEAcA_Lppdk-aEXRC1vd0OZpiCvh3kK+mqz8OpaAe01Vy_bFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/arm: Implement Neoverse-N2
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Ping for code review -- Richard or Alex, maybe ?

thanks
-- PMM

On Fri, 15 Sept 2023 at 19:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset implements a model of the Neoverse-N2 CPU.
> Because it's very similar to the Cortex-A710 we don't
> need to implement any new features for it; but because it
> supports 48 bit physical addresses we can use it in the
> sbsa-ref board.
>
> Patch 1 fixes a few minor errors in the A710 definition
> that I spotted while I was cross-checking it against the
> N2 TRM to see what had changed.
>
> Patch 2 is the new CPU model.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   target/arm: Correct minor errors in Cortex-A710 definition
>   target/arm: Implement Neoverse N2 CPU model
>
>  docs/system/arm/virt.rst |   1 +
>  hw/arm/sbsa-ref.c        |   1 +
>  hw/arm/virt.c            |   1 +
>  target/arm/tcg/cpu64.c   | 114 ++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 115 insertions(+), 2 deletions(-)


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D326375F820
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:23:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvWu-0001vA-B5; Mon, 24 Jul 2023 09:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNvWq-0001ug-OG
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:23:12 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNvWp-0006qu-C3
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:23:12 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52229d3b8c8so1820977a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690204990; x=1690809790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZlVVeA8pxJcSsaXJkjJqU//lud0o163HYU+YUc9VGi0=;
 b=AbWBVMIqujzxGNcMHsata1Xm0Zb/+N/vBl/fNHtSyNpKTJHlZaMXchV10BA0fCVKLz
 M896KlbQWuSoSXMZvYSJCrouqtFGoL6MCuYR/fA9+YMhJUpPPutz/m4D6SMev8GJSvIf
 z4/L3w+jujVFJ0dGr3CrYJU4/KnmK4jPkBuBFqA7IVs5I9js5wi6juY0liYNYRjVdZtZ
 +e6DOIsqoHkrCLixFNcyipL0GSA+V8D92ikPGVOY9OGSMSb297RygYDHDtPTmgAyylBG
 CKw1EJLciWMip61yKo5yJnRSvGNa9sV8EEqj84nmLMFJCBFfn7obeIqn31AbdZydfJFR
 SIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690204990; x=1690809790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZlVVeA8pxJcSsaXJkjJqU//lud0o163HYU+YUc9VGi0=;
 b=GymxfYZx5QXLPay6tJEs3DVQzZZTh0MBGt4ywTPVZ+E1QMjHBLQd7CTuavRl9AquIl
 OXPWsggHADZvrFmKJqQ50rydRm75l9x2lc0Wcv0OZkR2o0uVOkt0AIVjyEy43EVOBqH2
 aszPrYagu3vKi6pLw57y/jqIPYqEw5Ev7b5RxfTiWgSgkyIFIIqQf3Pr+95BWQot7dQD
 PxwnaARYeVfwHzkHzo+WlhZ+tCREgtgs2am8Z6aR54hq567ZsTkTQr7vvIIV8PAIYwYQ
 bQAKMek2oj36xbUVJ+rGQAMtifSb0p0W0rizXcL9dUfmiciwqrdn69sSi8IU2IProrBM
 SOag==
X-Gm-Message-State: ABy/qLY7/tetgK/t2C+TDKVV6R5l61zUcn2nFdkIOjKjl/q7UpErLuei
 eCNCxR7aIS7pwraNQDGv4YtaV2BAMXthglOwcWKoW1eFY84ec1ED
X-Google-Smtp-Source: APBJJlE/giDOLEKHyWeflVX0hoQEE4K2bs/Wtj9IBxh6nmPq8j9jrB7bRFHN79nsWHK7Yp2aLbLI5G6pxbICVEBT7+c=
X-Received: by 2002:a05:6402:10cb:b0:51f:f1a4:edc6 with SMTP id
 p11-20020a05640210cb00b0051ff1a4edc6mr8080045edu.37.1690204989736; Mon, 24
 Jul 2023 06:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230720131521.1325905-1-peter.maydell@linaro.org>
In-Reply-To: <20230720131521.1325905-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 14:22:58 +0100
Message-ID: <CAFEAcA8BiD6dwVns9DR5R4DyNXV6yheXhJ1vigkvg+WgALTYvQ@mail.gmail.com>
Subject: Re: [PATCH] tests/decode: Suppress "error: " string for
 expected-failure tests
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 20 Jul 2023 at 14:15, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The "expected failure" tests for decodetree result in the
> error messages from decodetree ending up in logs and in
> V=1 output:
>

I'll put this in my arm pullreq since it makes pullreq
handling easier and I see you've just sent a tcg pullreq
(unless you'd rather take it yourself).

thanks
-- PMM


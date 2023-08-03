Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DD376E53C
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 12:08:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRVEK-0006K2-Mh; Thu, 03 Aug 2023 06:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRVEI-0006Jm-PQ
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 06:06:50 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRVEH-00014p-AX
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 06:06:50 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-523108efb36so265462a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 03:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691057207; x=1691662007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EeGHumsL6RKRv70AOHucMcqH2IfRT3xwXR3Wp90QxTo=;
 b=VEMZwdo8mSurR8BfudVdWrqMF22ongLGJgwukxYm1FSm9uSM4zBhov9NR648fYr1pK
 HE8o1xcpTutAUbAB02fz+gSmZAIKbvO1kLdJqH3ASn+fplG0muvDgK8dA0nK4hfi65Rv
 amCj0xZajiVoUEK7tNqF/nxAtmyhiN+8HMNzSQhfk2LMUiFEl0PW5bYBHVB5A5Tzc9gt
 3uuvCvwVJ91YS7p3YeUjYzrfxXIZ8NnD9GioCYbc4lzmGl7ZtChMyahKLb7kHt/I5Gt3
 tqkyvpIaJHoNpfD3uP1IFuGicHY99uiL7hKBFAYfWSIY0TlRSOIIjUK8RZM7fjfZXKTz
 HePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691057207; x=1691662007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EeGHumsL6RKRv70AOHucMcqH2IfRT3xwXR3Wp90QxTo=;
 b=KeWXBtmcqtuRMo1Dq5GJqbKpCqJnA1G+LKuFwsHJNezQYT5oy8ka/4XiNj+AMb9yKW
 f0INgBUtn1PxLq3uerCiG/TGUoeLXEoAmLIa4cZkq3vcwt29sGsSyAT4j0t8EixnBowZ
 4+x+E76HkUAkpYei0SmGgtAjjlu6GKPwaK4S7I5JofMA/TwkZvTy6yPGdEukGF4NQcog
 XxIb4I/jiBymVm7NEWGITWDUo1ICCVxmelg4vaMFRHDrIA8ievoITuTdq1QzuKWmXP6/
 UzL6VAj9I7U9wn6j3g3tzO1G+z6o09y3o2IxgBaHvGKjDwrC/apr10+ggvdm7Jk01JrU
 TSNA==
X-Gm-Message-State: ABy/qLY61Z8x+SfpJzqDsUZocL8G90NL3yluEh7nUzYWTQ7TSoK13agv
 nR2sdFlxoko9Nx2Q0P0gX+3zoBZ17SmmCDPEWvuRmQ==
X-Google-Smtp-Source: APBJJlE7+zYrMk3avilbrfbRq4sP/fAj1EK/edXBA2z4nEN5I4cZ9l+ymVp4Q7vqjFRpP3hZpcEimNlk9AKSjix46dc=
X-Received: by 2002:aa7:d702:0:b0:51e:d4b:3c9d with SMTP id
 t2-20020aa7d702000000b0051e0d4b3c9dmr7791887edq.23.1691057207351; Thu, 03 Aug
 2023 03:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230802161914.395443-1-keithp@keithp.com>
In-Reply-To: <20230802161914.395443-1-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 11:06:36 +0100
Message-ID: <CAFEAcA_OjEUctUkmmotx=SnvMFAPFSP32Lo5nh1VWODyDqb3Kg@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/m68k: Fix a few semihosting bugs
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
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

On Wed, 2 Aug 2023 at 17:20, Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> The first two patches mirror similar patches I recently sent for nios2.
>
>  1. Use correct parameter for EXIT (d1 instead of d0)
>  2. Fix use of deposit64 in LSEEK (argument order was incorrect)
>
> The second patch has also been submitted by Peter Maydell, it's
> included here because it was required to get things working.

The usual way we do that is that you include my patch in your
series, and add your signed-off-by line (indicating it has
come via you).

thanks
-- PMM


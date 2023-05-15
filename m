Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D50967036D3
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 19:14:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybl1-0007rO-82; Mon, 15 May 2023 13:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybky-0007qw-Rq
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:13:09 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybkl-000083-3E
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:13:08 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-50bd37ca954so113778599a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684170773; x=1686762773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n0yFH9lSaRKccPrFdBwhG6G3+Dm6iFRS5dy4vBW488g=;
 b=a5pyiJrZAAFcoFVtc2Mw2cdyeaDZbnetlhItn1gG1puXoqvwkyYM/wt/bvUshMCBMv
 saEFB76GNyTFezl4pPWCkgga14HND29Le6wGgmZa2KbnhW8bFQ5qn9L3/aGKk7jaWetV
 Zflm/O/Zl3su7X5EYeI3e4kuz4UXFt+dPwc8x1yCOayLoFWqcsJM4WS3FMlz1L6sEISb
 pAbgTJgQHgPLhtTplWpn6q9J/r6srr14x5Q5L7XCLqpDQPmfAL3lsUQM+yD7o2OLku2w
 s6kO/qsJteC6ZLaGM+4BwhfMJ+1AlcT7DIjBgBrQ8rrDy+9l7OEobOgEw9IUX8mNCf/q
 e4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684170773; x=1686762773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n0yFH9lSaRKccPrFdBwhG6G3+Dm6iFRS5dy4vBW488g=;
 b=bNjfWKfz4tw9k1MFurudvTkErcGqKQouhyQlTc9o2yGsFy1TxzzKJM3EIneqfmAfnF
 hdD+8Naul9p5EofLvRdCv67FrprbDdmrMtQ6FvBX37X4wJU7/bP2N/eiZV0V7FzOyYwC
 j/rFhXrQzOJvO+2d0kiYqJei1hzqnNl7fPaT8YGSCvdtJTVKn8JAeJMEevBp207ca8P6
 AR4Obx5NtDUpk451idOvTrJn13Zhc8yCD8FKFFdERhiFAibxQc2ke2DWz5k6q3vqQe0J
 iyEZDFkf/YWsmF3H8VeOyCcp3EeURuJ7AwgHMiQxp16kf7vFg5iFEQGGn1giRw6VxK71
 0vlQ==
X-Gm-Message-State: AC+VfDzcLwV97fABQ49zs7oekggpke4GUBQpmfHnphF9dvD2VeUFn8sL
 nqqmKB/edTJ30RCKcwsuUanXPJ+g+h3W8HUiQjD8xQ==
X-Google-Smtp-Source: ACHHUZ70CvALpy7i2oVl5uwH46j39QSH5yyV6gB/vhVACIZrgH6/AqAstmChcUy0H9Uyc4N8TQhpY4O4/xJhS1No0CM=
X-Received: by 2002:a05:6402:742:b0:50d:89d5:bf95 with SMTP id
 p2-20020a056402074200b0050d89d5bf95mr23916291edy.20.1684170773255; Mon, 15
 May 2023 10:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-27-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 May 2023 18:12:42 +0100
Message-ID: <CAFEAcA_LARwtJuieWCkwLGG4hVGH0dKTE7g++o0Cd=Mhf1vswg@mail.gmail.com>
Subject: Re: [PATCH v5 26/54] target/sparc64: Remove tcg_out_movi_s13 case
 from tcg_out_movi_imm32
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 15 May 2023 at 15:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Shuffle the order in tcg_out_movi_int to check s13 first, and
> drop this check from tcg_out_movi_imm32.  This might make the
> sequence for in_prologue larger, but not with worrying about.

"worth"

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


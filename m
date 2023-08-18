Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D1078077F
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 10:52:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWvCe-0003mT-3v; Fri, 18 Aug 2023 04:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qWvCc-0003mF-O7
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 04:51:30 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qWvCa-0003Qi-Jm
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 04:51:30 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5234f46c6f9so815910a12.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 01:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692348686; x=1692953486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0yHkRs5QgjksIu8x/sQiIvjSeNm63Cx5gLquvDCuTwI=;
 b=KW/Ndg/99eFO9hqFqW9p5mKaQUuVptrV0cZzQFQsjrsKCKXiEdBPqrBz6ORdjNj572
 9faKCaeZO9kmEnyYGOotR/FwYD0ZaiDCHmKxQzc3LIULj+qDn5xnzI377TxJ+bEZMNkr
 zbZr5LEPXgGBS/Sc+ogxc+TUzF/RSd6A2Z31RQfe5cLsHEY1S2XC7Ri1JI12X4MQ8Dqg
 2nsGGoc9M+Dt/0rTEiZqM2MtQhSRCc5LjRv/kcf0qrx+L7Oj0Az88z0zn3rv3zE38nFB
 cxcMjUES115M2lSukdAkLnJMkrYwCd4/a7mHqjQ/3U0s32m2XzSTlL650SH6WmkOdc6n
 eqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692348686; x=1692953486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0yHkRs5QgjksIu8x/sQiIvjSeNm63Cx5gLquvDCuTwI=;
 b=I9XBmHXI6JV5Sozk0MFpA8b9QY40DgLdaABClmIvUjmYF6+vRpS1QAkXZEpJzrnOuT
 uTJEZr2hiCzIYjJSaJ1x2PuYwA++N49FF9A3ab6RL8XilB6v/NQvIcTe9fuWjm0oI6ey
 OoRC+DWZlihVIJ3y9Ws8ZXE0Q8BzEIblm6UFZz51EI7x/uIv9v5jI++tLxTS1/1IA7i9
 w3wtpsOv9xyW3yYxfS0IjQq0kk4BMMpSVA3ofMUJIUkubBbq9VxUjB1Z8sJrkU5X621k
 wP/wWj+3//JmioD1n0hw+6mca/89rfEBjWtIrwNvIiP8zjv8qcmmoJrx+7iDMV2UwI5f
 gDUQ==
X-Gm-Message-State: AOJu0YxGE2yZqN9h1y9NM4kIeEzL5GcE3cjMU8QrPSgC3YAUjmoK/2xi
 mIvINZ770zN6adsixf++m5NUBauc7db0bBu30vJjyRu3oB+mWmzh
X-Google-Smtp-Source: AGHT+IEkuzhSmmV0y4pTvry1jklkKH4Y1WMTYB9TQ0XEczpsjBx0nEze25qoJHQ53J3jXljTvMmb2rzVtBjzqE22c+A=
X-Received: by 2002:aa7:cc8f:0:b0:51e:4439:f474 with SMTP id
 p15-20020aa7cc8f000000b0051e4439f474mr1664246edt.35.1692348686458; Fri, 18
 Aug 2023 01:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230816145547.477974-1-richard.henderson@linaro.org>
 <20230816145547.477974-3-richard.henderson@linaro.org>
 <CAFEAcA9WUcJzrfQXnjM0Jw8CjaY6BW9hAKWGDRrMVU3BR2u6Vw@mail.gmail.com>
 <c03f11e3-847c-a792-51e0-16679485b43e@linaro.org>
In-Reply-To: <c03f11e3-847c-a792-51e0-16679485b43e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Aug 2023 09:51:15 +0100
Message-ID: <CAFEAcA-D5J6TR1CfgmomrSRDJ+62ShE4-VJUuw8=xBr1wmJTAg@mail.gmail.com>
Subject: Re: [PATCH 2/3] tcg: Fold deposit with zero to and
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 17 Aug 2023 at 23:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/17/23 08:50, Peter Maydell wrote:
> >> +    if (arg_is_const(op->args[1])
> >> +        && arg_info(op->args[1])->val == 0
> >> +        && op->args[3] == 0) {
> >> +        uint64_t mask = MAKE_64BIT_MASK(0, op->args[4]);
> >
> > The docs for the TCG deposit op don't say what the restrictions on the
> > immediate args are, but this will be UB for QEMU if args[4] is 0.
> > Have we already sanitized those somewhere?
>
> tcg_gen_deposit_{i32,i64} do so.

Cool.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


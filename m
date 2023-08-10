Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85460777DDF
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:14:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8Hb-0008D8-GH; Thu, 10 Aug 2023 12:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8HZ-0008C4-AZ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:13:05 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8HW-0002e8-MN
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:13:05 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4fe2de785e7so1688949e87.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691683981; x=1692288781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S+DK/m+jscP/AP0BmZqeAxyMSJZTabVUzOqp4jitSag=;
 b=BSYfEY2M6NYfqFRvDvlrUNoCO//r2CCbZK9OZn0s0xnGxtXB+5Bb2Mk2hAzUHKPEDo
 97eMLK1EbXVgKkMIjjt3fxV/j96gbF/rl9R+uMlLkG7dm+UvBxaYtKWMSQhA4E95t4o1
 xxG8NbvW6S2CY3nn+l87QqIhr26Cff/y+MTkDKlogL0d+LOE8eB5PMd4Ee8qlr2Eki9d
 +fmORue5GXR/LgtmO366Pu/qFpVLm+rWrjIpagxHQww3OFaET47dNllb6GrcEX7Vnw8p
 GIUqYSorhqyONtV2ilhMsPMY8KeuPwJIG6URlc4enm6GndmGOaFzFeIUymmQf0YDNXIg
 1O6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691683981; x=1692288781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+DK/m+jscP/AP0BmZqeAxyMSJZTabVUzOqp4jitSag=;
 b=Z1fmVUlt+S3mNQpisl5W9dFtFWpoWvtr6Lkb1eRpFo/TkopGozqOwqFaawXSJRf5wy
 Vz74bp/djMys2vWOtvzk36L7ZuXk6hi3+Eoix+L3YEWDcnYnGsYyGan3TzK9yyvTo3U7
 J4wcODC5sEzZnoxPnuuLuLGFlkZEtxhFKChwTGd+msDPKG2cefbb086gQ7DC/y0cKfy0
 xNHNjVXf+LZq5jvVz5CwcAiAJbAQRz8N4yMX2TF8WSoUmT5dIg6Jma54FXY3iNjg2Bhj
 W63+vt0EtAMsQl+IqRasCRdLf6Jdenz2OuyhYH0WiIZXm8S+J9+T9nLF5U7itKNpb/hY
 p5Jg==
X-Gm-Message-State: AOJu0YxP7pnGnPGid7ftEa8gBNfJMyD/asKZzxRWJWZ+zXNo4l9dv0K1
 tr8vyKFz7Qyg+Z7pht3WXF1bIqGd/bOVVaUiRGmVGA==
X-Google-Smtp-Source: AGHT+IEjZJOZwXi++dffudXz2C5+TWZOfz4XmglxA/RTQ/ANwbyYApbsSgpqnuUWPwnzvlEXM6hW3OxH+4bs91bHPok=
X-Received: by 2002:a05:6512:36cc:b0:4f9:6528:fb15 with SMTP id
 e12-20020a05651236cc00b004f96528fb15mr2062967lfs.12.1691683980651; Thu, 10
 Aug 2023 09:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-2-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 17:12:49 +0100
Message-ID: <CAFEAcA93xKE8xaYEwED2Wwj0-3QiOfnfN7Zgvf=KMYgO1tnz-Q@mail.gmail.com>
Subject: Re: [PATCH 01/24] tcg: Introduce negsetcond opcodes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Tue, 8 Aug 2023 at 04:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Introduce a new opcode for negative setcond.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>




> +static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
> +{
> +    TCGCond cond = op->args[3];
> +    int i;
> +
> +    if (swap_commutative(op->args[0], &op->args[1], &op->args[2])) {
> +        op->args[3] = cond = tcg_swap_cond(cond);
> +    }
> +
> +    i = do_constant_folding_cond(ctx->type, op->args[1], op->args[2], cond);
> +    if (i >= 0) {
> +        return tcg_opt_gen_movi(ctx, op, op->args[0], -i);
> +    }
> +
> +    /* Value is {0,-1} so all bits are repititions of the sign. */

"repetitions"

> +    ctx->s_mask = -1;

Do we not also need to set z_mask to something here (presumably -1)?
(I'm not very familiar with the optimizer internals.)

> +    return false;
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


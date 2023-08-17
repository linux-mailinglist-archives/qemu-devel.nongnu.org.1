Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB8077FB2C
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 17:52:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWfHE-00040r-7E; Thu, 17 Aug 2023 11:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qWfHB-00040S-0E
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:51:09 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qWfH7-00088Z-71
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:51:07 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5254f9eda36so6889844a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692287463; x=1692892263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OKg0oaG4PfC7AfjPNk0IiqMNUqQO6AI4B3N9qAeE0vY=;
 b=e6hZRmDUikOHExloc9BtbTMvsGN8TccLrfQHvsZaq68hO2BZtPGeQiiF1IZU2EvfH3
 gPp2Yr2/x60+4yF2+GFutQ3hSaOdVx/iuq0KtIkMvaotid8rHDIIIH0M1YmXR402YSXz
 hfwlcp6WI9AnPyKQCs46gFg+8lRWrdA2xjHkewdL7V7/oQuWL+44t+W0VccZQalFOo4m
 5O2z3LirPwj4syNMQ/dK5dnWcPCde4XOSJaAvORwG7VNqB/k9LgXQUm2gVONNZDVfVUx
 dZF2KaUjZP/7I6MuuOkUYCpZOynv1mfhyYuq0NGJYHEl0MFcgB6pDD1hImLhkSCz1f9d
 Pp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692287463; x=1692892263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OKg0oaG4PfC7AfjPNk0IiqMNUqQO6AI4B3N9qAeE0vY=;
 b=ELLJebqbDKxNiCCEe94lSF/0FYFc74GtXCswmRkPqmU2doNmLaXZVovzu86lJ6Hhaj
 wrzU8UzlpctqtKzcCNzJ11yHc7odA8dNPCXbzGVhFIaBwcyESPa1rIulVoXb0dOM74au
 jdEK/kolA+0iBG152M8UUGvv7V1AW9W/FlseDUekThRGmniGXWCngRhL6bOdmvLeNLHN
 cA8nmaPubUqT1oty8B61Cmv/vBd8CohvAVMVULwvYif+Pm63GWv3BG3/+P3b2wU/eT26
 CjjrXuj7uS1m7KbY/UKGq1tdfug5hMY+3LKC6YX5PxJlOG5XZlXo1KmsrC77ergiYzOj
 9+ig==
X-Gm-Message-State: AOJu0Yz/TiWL6pVcb2+WMwj6DQcfh7oM4aTD+/Qxrru6Pw6fLAtdEgdz
 7sOkb3/ho0hThO3dAQ1xoTZt5wSmaImWVYb1u82lsg==
X-Google-Smtp-Source: AGHT+IE3yeQTr6R4RdjOcTXQojLW4yN15MV5K56LSeFx9FCT5Ftbz3gljya2SGJvznEk9BbfVaawLpqtr63Y5qZ74g4=
X-Received: by 2002:a05:6402:10c5:b0:523:c10d:1d5b with SMTP id
 p5-20020a05640210c500b00523c10d1d5bmr93059edu.37.1692287463034; Thu, 17 Aug
 2023 08:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230816145547.477974-1-richard.henderson@linaro.org>
 <20230816145547.477974-3-richard.henderson@linaro.org>
In-Reply-To: <20230816145547.477974-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Aug 2023 16:50:51 +0100
Message-ID: <CAFEAcA9WUcJzrfQXnjM0Jw8CjaY6BW9hAKWGDRrMVU3BR2u6Vw@mail.gmail.com>
Subject: Re: [PATCH 2/3] tcg: Fold deposit with zero to and
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 16 Aug 2023 at 15:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Inserting a zero into a value, or inserting a value
> into zero at offset 0 my be implemented with AND.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/optimize.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index d2156367a3..956114b631 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1279,6 +1279,8 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
>
>  static bool fold_deposit(OptContext *ctx, TCGOp *op)
>  {
> +    TCGOpcode and_opc;
> +
>      if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
>          uint64_t t1 = arg_info(op->args[1])->val;
>          uint64_t t2 = arg_info(op->args[2])->val;
> @@ -1287,6 +1289,39 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>          return tcg_opt_gen_movi(ctx, op, op->args[0], t1);
>      }
>
> +    switch (ctx->type) {
> +    case TCG_TYPE_I32:
> +        and_opc = INDEX_op_and_i32;
> +        break;
> +    case TCG_TYPE_I64:
> +        and_opc = INDEX_op_and_i64;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (arg_is_const(op->args[1])
> +        && arg_info(op->args[1])->val == 0
> +        && op->args[3] == 0) {
> +        uint64_t mask = MAKE_64BIT_MASK(0, op->args[4]);

The docs for the TCG deposit op don't say what the restrictions on the
immediate args are, but this will be UB for QEMU if args[4] is 0.
Have we already sanitized those somewhere?

> +
> +        op->opc = and_opc;
> +        op->args[1] = op->args[2];
> +        op->args[2] = temp_arg(tcg_constant_internal(ctx->type, mask));
> +        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
> +        return false;
> +    }
> +
> +    if (arg_is_const(op->args[2])
> +        && arg_info(op->args[2])->val == 0) {
> +        uint64_t mask = deposit64(-1, op->args[3], op->args[4], 0);
> +
> +        op->opc = and_opc;
> +        op->args[2] = temp_arg(tcg_constant_internal(ctx->type, mask));
> +        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
> +        return false;
> +    }
> +
>      ctx->z_mask = deposit64(arg_info(op->args[1])->z_mask,
>                              op->args[3], op->args[4],
>                              arg_info(op->args[2])->z_mask);
> --

thanks
-- PMM


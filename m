Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2587358DC
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:45:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFBd-0000LH-75; Mon, 19 Jun 2023 09:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFBb-0000Kp-DQ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:44:51 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFBZ-0005fH-RZ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:44:51 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51a1d539ffaso6677959a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 06:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687182288; x=1689774288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7yDQnwe+pqE5E+Xpo8oKLCJ4tiyERQoa8z2BYvAWQG0=;
 b=b0osIN35Qnhk6g3TYupQ1W/u6pQLAUrMnIqvG4dsmfSwevQEWIuHHdQ700zuC09Vpo
 P32Q04XpI0r+XW2h50v8WsgUnV80oifU+D4/gGaDnGRCmRf9t7zbkQb28+hgPZFNtQ8g
 zy/qay45nOnH3xo2R0ZvmWjbIdfVgSRyLId3Ep6Hpn5w3PLUJmAwp+8+t+VFsm94OIcX
 URnFAei4YQ7zvTSQlYO2CNeawK/X3HRIDwIyl2w7OK7UmF/jf585YYJPQT/DDUuHRYY9
 udfw0jLpsXYvRf8ZXUsMj625pIU9bem4nMZ8WEY5M2Xbyunfp8l2cXjmESuvwwyLeF2Y
 SuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687182288; x=1689774288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7yDQnwe+pqE5E+Xpo8oKLCJ4tiyERQoa8z2BYvAWQG0=;
 b=B12MWc4v3Zr0MGUSmSh9WdvelHefpDjoFtOEpJwD8raxHJp/Cmxh6DDapWGRnqEy3t
 Tn3rQnzt2E/TMhmS9kK7x7+/7DbXhDW55MBi/uvJBjiA4+AgDQYdHwMZZ7hjVEC4F6jO
 o13Hm0acI4j5vBcpkrEV5feAxDHRBlRWxQdlDRg+WdLEqyM9j3yn2gZ7wzg1DhGwCspE
 ucwqqFqjrSvcQWSHNmcj88AKd0R8+gI3WPeKdd6bwdDupoVA2tueRSEZV1l4OP41HRep
 onu/j1NcDKsT0MtjLSWjyDuJW0U+25moBfSJ2vzUAj49H7JL7Ra/ffDCPWa8UPd01J6t
 6laQ==
X-Gm-Message-State: AC+VfDwyRNYj4rP/3XlXbZQABDHco4iWoQbK+A6iTVpEwhLzl/V1RUpF
 1wKjOM8J7VBDxIyoj4IxbLLsG3AouQsyHu07xpvLCA==
X-Google-Smtp-Source: ACHHUZ75vT+dkZDvBIa7fA/R7qQMz4NXO7sX5Ny8EoAxxCtbOMz6QYfwjjnlGMdelLwX9DwprZtsmkZO4Q3BwVARpBY=
X-Received: by 2002:a05:6402:2683:b0:51a:4c1e:c94a with SMTP id
 w3-20020a056402268300b0051a4c1ec94amr4305318edd.2.1687182288129; Mon, 19 Jun
 2023 06:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230619132548.400875-1-richard.henderson@linaro.org>
In-Reply-To: <20230619132548.400875-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 14:44:37 +0100
Message-ID: <CAFEAcA-TeLU36SqMK27xpPg-NLLvG5+3UmHbUa0SJFWZF1pjZA@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: Handle MO_ATOM_WITHIN16 in do_st16_leN
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 19 Jun 2023 at 14:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Otherwise we hit the default assert not reached.
> Handle it as MO_ATOM_NONE, because of size and misalignment.
> We already handle this correctly in do_ld16_beN.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Fixes an abort booting debian11 with -cpu max.
>
> r~
>
> ---
>  accel/tcg/cputlb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 5e2ca47243..14ce97c33b 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2727,6 +2727,7 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
>           * and so neither is atomic.
>           */
>      case MO_ATOM_IFALIGN:
> +    case MO_ATOM_WITHIN16:
>      case MO_ATOM_NONE:
>          stq_le_p(p->haddr, int128_getlo(val_le));
>          return store_bytes_leN(p->haddr + 8, p->size - 8,
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


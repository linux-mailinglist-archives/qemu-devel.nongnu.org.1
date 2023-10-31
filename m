Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 400BB7DCB2B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 11:53:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmMC-0003ol-LX; Tue, 31 Oct 2023 06:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxmMA-0003oH-AN
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:52:22 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxmM8-0002Or-Mk
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:52:21 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so8921999a12.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698749537; x=1699354337; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RI+K7+Ec0wKr9LBm4qXj86Wdkj40B89dPJBLeuP1HuU=;
 b=EAwXq8slE9VNzSZsgeULxp/8yJAz8U5eZ5gLQTaRKmjIaO21MVSGe56pNVZLrnCqHf
 cn/rsFvtviEQB4f8FL0v9zsFv5AaYHjGwhz35gpaT5GFzWJ9kqauULzJvK8jG70dtkcx
 TZ3qSoWr//WhkUg6QwUtichbQ76onncdIyXmxGYVNxikrZ7GsgHyMBfrEvRsMhfEPmh5
 Xz/aVJMt6ZgyfjRuvMAnh2kl2q7J69use+6M1LtBu+3yhLo4LOzczglJx9F1RXDF943g
 XJsXNUNv0UCpbTgUD9q+/PWq9GQ0dq9tQ7+mPz7Fy6gJBY6aYFr5mvjmz5WvGD7AgXSD
 91nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698749537; x=1699354337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RI+K7+Ec0wKr9LBm4qXj86Wdkj40B89dPJBLeuP1HuU=;
 b=mieQLKCWJtUxHrFFXpaA/Rv8jQUXakEfLjsctDvHpXTORx2Nrba9JaR9br2wqibxWG
 hWgyFDZXpJfbgs3KvqKevzix6JWBbm+O537Md4spyziCVcTF/lbD1VIy2rb+mi1POxih
 z+9Nk7XOj+wrn4oe7jYaOIzCAacNIsZzzdubYrP0Uj1MQS5NMhYVMvrKO9fl+XcTUbBO
 2gR2yP09RfnHqqYxfn2SsxsHh1dCVnzHetrUhUJGk6D5SY4KXUCY0y9nzT+4GpFeSVgG
 fBXpihioByeL8+ePfAaTMhgihGNKFGb6sYyt5VJq3cHDe80yxrrpL1cpNMjshwoTHcU5
 2FBQ==
X-Gm-Message-State: AOJu0YxIC3OgFqKukedIRx3yU3Spkl6h1Gja9cS/vHrnmUjIhtpmBx7k
 +OihHCt+3NXMywc7/zY7mcrUpbpltZFSa4lTuQthvw==
X-Google-Smtp-Source: AGHT+IG6wBFK+VrqiEcCXCr8u84/SS6CzI5wIDBZlmGfuI/excwW+ovFjYCOMDn6a9AK4E++gvBDmHxWRK2JIbyF4y8=
X-Received: by 2002:a05:6402:4305:b0:540:a5a1:745e with SMTP id
 m5-20020a056402430500b00540a5a1745emr11681231edc.14.1698749537553; Tue, 31
 Oct 2023 03:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231030190354.94671-1-richard.henderson@linaro.org>
In-Reply-To: <20231030190354.94671-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 10:52:06 +0000
Message-ID: <CAFEAcA_kG-yE9sYDx+QBxCoAMySjc57oXx+UtSo=p=nCqAwKfQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix SVE STR increment
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
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

On Mon, 30 Oct 2023 at 19:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The previous change missed updating one of the increments.
>
> Cc: qemu-stable@nongnu.org
> Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index 7b39962f20..fc4220114d 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -4294,7 +4294,7 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
>          t0 = tcg_temp_new_i64();
>          t1 = tcg_temp_new_i64();
>          t16 = tcg_temp_new_i128();
> -        for (i = 0; i < len_align; i += 8) {
> +        for (i = 0; i < len_align; i += 16) {
>              tcg_gen_ld_i64(t0, base, vofs + i);
>              tcg_gen_ld_i64(t1, base, vofs + i + 8);
>              tcg_gen_concat_i64_i128(t16, t0, t1);
> --

This fixes the test case I have for vector lengths of 64 bytes
and below, but vector lengths above that (eg 128 bytes) still
misbehave in a different way (only every other set of 8 bytes
gets stored). Presumably that's a different bug somewhere else?

thanks
-- PMM


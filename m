Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7301A703407
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:44:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybIe-0008PC-5B; Mon, 15 May 2023 12:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybIb-0008MF-Uy
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:43:49 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybIa-0001pi-EE
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:43:49 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-50be0d835aaso23072963a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684169026; x=1686761026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=63Yb7nHAv3lSmSb76PeYAf67Cp2xqz80VbGD/4BRPZc=;
 b=JcJVNUgrRQmOoYKpN8pCJFhIG0VOXtbtcVHsix5XTYtrVoYb+/vSCTJDAJhxyyMON3
 UOx59jfTjKDDKvncEpajh+fZJWOgyT+3YngN1hPusmuJcTXWHirHZliY7EG2scsg8BtF
 kk7ZzGpki9tUGlX1nAoausyUam4Ik6hkAljLcU2Pq6jnMDeO/rDB7XHTRhQTKJZLLSgR
 IaepEAgoCDaFAx8fUbljePA0RYAWUW6HIXBjnR4K2CxrmoTfHDQ6FvxMIsg5011zjQTV
 87epOOSP468GsesIW6w9TtTE7T1QU44dsEz/y5qJVPSGv2fFi182w0/s1g+Q6kR//FEa
 xxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684169026; x=1686761026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=63Yb7nHAv3lSmSb76PeYAf67Cp2xqz80VbGD/4BRPZc=;
 b=f5vRFZuS4+27c2rDFT98D8itaC6EpUx34Qg23gQDlN5PSEkGMjAaMVU/woiKyxgDGq
 U2kof9suvhSDCj0ZCGemLRWqsl+vcceXUiFCQ9QVZuE9YAtJAONarD+xkkUgoBYvAUyd
 MwTJydzrmI1yBFoOYKmPPC0K3hFNNgxCY5eAZ+BA57V03d37nea+vVtsaMsjZYtKVKYF
 yBSYPcp3hwB6biTQBKw0EAF/rMmxtOmAYCA+KaipHcY2tEO9aqGC6Va+8rHauM8U/3OW
 MSKYDBF10FFwo+GQfgNrPBdwFF9K/xp+rp4FCElqhlur5PGK9iocyNu3ekz8uSAx2jvc
 F8Tw==
X-Gm-Message-State: AC+VfDxU5ex9LTncgWc1q2Z19bFGmY9y8NlKMEz032aIowDtqVVPV7lH
 OGBHylietR9CF9DDW0wYw/bg3O/zc/dRd5IC8g19aw==
X-Google-Smtp-Source: ACHHUZ4jYSjo40YAuKd+iUAp33V5shpOE2SN7z4iybKGJSELnP50NX5b5NJVkXu0h2PxjrNO9OUTNNu6cepi13A1LUE=
X-Received: by 2002:a17:907:97c8:b0:961:b0:3dfd with SMTP id
 js8-20020a17090797c800b0096100b03dfdmr33946915ejc.7.1684169026542; Mon, 15
 May 2023 09:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-3-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 May 2023 17:43:35 +0100
Message-ID: <CAFEAcA_KaYWE+Yh+vberVqk6hV=3R1Xm2V2Po+jrS54i6S1Quw@mail.gmail.com>
Subject: Re: [PATCH v5 02/54] accel/tcg: Honor atomicity of loads
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 15 May 2023 at 15:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Create ldst_atomicity.c.inc.
>
> Not required for user-only code loads, because we've ensured that
> the page is read-only before beginning to translate code.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v5: Dropped r-b because of MO_ATOM_* reorg
> ---





> +/**
> + * load_atom_2:
> + * @p: host address
> + * @memop: the full memory op
> + *
> + * Load 2 bytes from @p, honoring the atomicity of @memop.
> + */
> +static uint16_t load_atom_2(CPUArchState *env, uintptr_t ra,
> +                            void *pv, MemOp memop)
> +{
> +    uintptr_t pi = (uintptr_t)pv;
> +    int atmax;
> +
> +    if (likely((pi & 1) == 0)) {
> +        return load_atomic2(pv);
> +    }
> +    if (HAVE_al16_fast) {
> +        return load_atom_extract_al16_or_al8(pv, 2);
> +    }
> +
> +    atmax = required_atomicity(env, pi, memop);
> +    switch (atmax) {
> +    case MO_8:
> +        return lduw_he_p(pv);
> +    case MO_16:
> +        /* The only case remaining is MO_ATOM_WITHIN16. */
> +        if (!HAVE_al8_fast && (pi & 3) == 1) {
> +            /* Big or little endian, we want the middle two bytes. */
> +            return load_atomic4(pv - 1) >> 8;
> +        }
> +        if (unlikely((pi & 15) != 7)) {

Why is this the unlikely case ?

> +            return load_atom_extract_al8_or_exit(env, ra, pv, 2);
> +        }
> +        return load_atom_extract_al16_or_exit(env, ra, pv, 2);
> +    default:
> +        g_assert_not_reached();
> +    }
> +}

Either way,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


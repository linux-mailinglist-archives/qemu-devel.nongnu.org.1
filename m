Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE73704F04
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:16:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyuVK-0005C7-JX; Tue, 16 May 2023 09:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyuVI-0005Br-BW
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:14:12 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyuVG-0004XE-Gf
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:14:12 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-50bc4bc2880so21542511a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684242848; x=1686834848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FsqO1Ug+oKZLntYhBasWO/KhtaZ522+IYFfRo50Gft0=;
 b=r5fc7XlIj9J/ackm1DXeWYVChiQNwIZ6fBrYaJaYc2MvHn51dltX76m7+rAZ9mlpb5
 9ZHI8EidtBxVKgCs7+sj8d9BsEtpuLjuvOquvzMWE9M+Xxt+4E5Pe2Dv1N6Wlol46IC0
 sg39/omSxkJj4xC1PHViBiurnkgMlFj7T++YxeXfpQucacZqWPcNhpzlSRyJVF0YyoSd
 qrfVQSWFgixG0bF32XM05hopNzT0GfqMlBTDBI6V6DXRIdXtZQWh1h42FqomEPp2yWJI
 t7DKDjES92lY3sFF9NlPCNCsqzIL02so6c+rhd6ri/kux6NoOwCyVoQ16wyZ/HzOSxSp
 y8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684242848; x=1686834848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FsqO1Ug+oKZLntYhBasWO/KhtaZ522+IYFfRo50Gft0=;
 b=PiYVj6JQdFIwE0SA1L59MrGrmuPbrKnxpoanc1RTxaOTzx1rPuH/32sXDa09Hztye9
 5EAOCXvzQsYiD5KhREBru56V+MBTh1UxBr4zqbQvbsVYuXgzIlxp8xRkaMK8qLw9wsH8
 bOseUGNNFuoBshuNObuXKS3uPOn86el4R1yHKxxvX/oPj9EZYtes1Xp+qQs6uaIdi7g5
 JoWQV6UdXUGJB7s5IloXuV7PLmOvby1M9ObueMmd9wCZvktBw5grTbHRbzlgv1C7Jjj0
 wIK5H7MMkb3QhjvPFzLA35Vika/WYnULTwE3chc0tXR/2OOg8006WjSD9y3lnLvspVYL
 HJXA==
X-Gm-Message-State: AC+VfDwRDsDxAs0W1ZEs+2Iv2O6Vy7uSY9C0T3sXyUVGj/dzx+KmRsZs
 TfG4n4VE3cC08Ug3H+hSFUFx//YmPlycfOKR8e5Epw==
X-Google-Smtp-Source: ACHHUZ56iLgvPEjHaAbNThloKsIc3nhtSoDsY2Qe2PeWyqzTnQgWtWuXk9Ea0heoKvC0qxBkkQchb7NVW/KjQGpoUZ4=
X-Received: by 2002:a17:907:2687:b0:94e:16d:4bf1 with SMTP id
 bn7-20020a170907268700b0094e016d4bf1mr30903976ejc.66.1684242848057; Tue, 16
 May 2023 06:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-3-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 14:13:57 +0100
Message-ID: <CAFEAcA8SxOVhPC+Y5saHKDWmBpOYZ2Ujcn3yHxoauw-jhhj3qg@mail.gmail.com>
Subject: Re: [PATCH v5 02/54] accel/tcg: Honor atomicity of loads
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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
> + * load_atomic16:
> + * @pv: host address
> + *
> + * Atomically load 16 aligned bytes from @pv.
> + */
> +static inline Int128 load_atomic16(void *pv)
> +{
> +#ifdef CONFIG_ATOMIC128
> +    __uint128_t *p = __builtin_assume_aligned(pv, 16);
> +    Int128Alias r;
> +
> +    r.u = qatomic_read__nocheck(p);
> +    return r.s;
> +#else
> +    qemu_build_not_reached();
> +#endif
> +}

Something that I remembered: Are we OK with this potentially barfing
if you try it on read-only memory? AIUI some compilers (clang,
gcc is thinking about it) will emit a cmpxchg or a load/store
exclusive loop inline for 128 bit atomic loads.

(eg https://godbolt.org/z/GaGKhT4f9 is not for the exact builtin
that qatomic_read__nocheck() boils down to but does show the
compiler will do this.)

-- PMM


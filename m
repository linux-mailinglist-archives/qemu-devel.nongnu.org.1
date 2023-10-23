Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C03CD7D42FD
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:00:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv3tB-00079N-Kz; Mon, 23 Oct 2023 18:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv3tA-000797-Eo
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 18:59:12 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv3t8-0003EM-RI
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 18:59:12 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-27cfb8bc7eeso3077442a91.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 15:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698101949; x=1698706749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KvZ1beBWsVfhGZ1yflHof8exslC46Ha5IfqwrZDWhHg=;
 b=QPGMh4t8o5hKjRH/SM2wQB93dt/V0XegsBeFYWoqmVz909e0A+dBrwwnuYAEKOxGq3
 uGlOMaJ8Yvp8VVPPoP7MAsyYmn/3TqRFxO9kWlfJejkjIuSixACoMfkRz+a9a0pe9qhH
 GlZ2s6HtGCis5v5PqfQJ57gn1vHIaT7JAAYjVdv5tSojk49M4MgVUJPbu180MXo5aJkH
 Uip6QKKHXG0uBQc69n0rPtyhYZgopRLvfQvbACBVT3h6rkOg4Y3kXnt/CjMNMrPW50WX
 wwR9GJdoiYlW39PDZ3c7aO8hGq8nXt0mqKBHPQYeQD52ub30SA1fMEYATLbZWDxcIefX
 cPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698101949; x=1698706749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KvZ1beBWsVfhGZ1yflHof8exslC46Ha5IfqwrZDWhHg=;
 b=WPjKA81mnnWUtiY94jwZ91v1DVg8Yb7ymEa6Q1m2xa/OsyM/trfnUyUjCN4tDl7Dqd
 pb2kPAFFMwO3GbSYXlOINeBZknX7LGB3vmtl2KOmEMORXP0142Gb0ZO8Y09O66OJbnFk
 ahcUXkwzrrBN6DK7K6IHnFw/YIK1ZRZtx1r5q3tpWdLPTt0pbWHw4pmTd2d/VBjRpYIO
 5aD+hNtvDB0gPZNZ8QlrIewJz6679cN5hdQS7pd/MqPlUaG0Ya7Z6XsIqm5eMBikkDlc
 r+HoMCWoy5PSVNqkoTMOWgY6lE5q5DT9OPEiXShABpwJJW8EJflhNxFFMS3+CB1O/1Vu
 h4vA==
X-Gm-Message-State: AOJu0Yzsf/f9/114BY6U1xTCJXn09Z/Ubr7E2kbe9fvlI20gehx9uEH9
 lmnyKs3TGctyjjpMugsyZ2tx/d+wB8GNMpwkKKY=
X-Google-Smtp-Source: AGHT+IGEYafvj5AFXjsEFsMwv9NMuLfhl4sbHLl/kZGEy3ud80xoe38QtRILA0SWXpbW4pi/2DfxMg==
X-Received: by 2002:a17:90b:4f42:b0:27c:f8d4:a4ca with SMTP id
 pj2-20020a17090b4f4200b0027cf8d4a4camr9664738pjb.44.1698101948988; 
 Mon, 23 Oct 2023 15:59:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ga8-20020a17090b038800b0027d0af2e9c3sm8106910pjb.40.2023.10.23.15.59.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 15:59:08 -0700 (PDT)
Message-ID: <bb63dd8a-50e5-4b79-9645-ae5e8ab9918f@linaro.org>
Date: Mon, 23 Oct 2023 15:59:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/loongarch: Add amcas[_db].{b/h/w/d}
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20231023153029.269211-2-c@jia.je>
 <20231023153029.269211-5-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231023153029.269211-5-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 10/23/23 08:29, Jiajie Chen wrote:
> +static bool gen_cas(DisasContext *ctx, arg_rrr *a,
> +                    void (*func)(TCGv, TCGv, TCGv, TCGv, TCGArg, MemOp),
> +                    MemOp mop)
> +{
> +    TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
> +    TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
> +    TCGv val = gpr_src(ctx, a->rk, EXT_NONE);
> +
> +    addr = make_address_i(ctx, addr, 0);
> +
> +    func(dest, addr, dest, val, ctx->mem_idx, mop);

You need

     TCGv old = gpr_src(ctx, a->rd, EXT_NONE);
     func(dest, addr, old, val, ...);

as otherwise rd=0 will abort.

Correct emulation requires that you perform the memory operation, and then discard the 
result.  But you must provide the (initialized) source of zero for that case.

Do any or all of the AM, LL, SC instructions require aligned memory?
I suspect that they do.

I think probably gen_ll, gen_sc, gen_am, and now gen_cas are missing "mop | MO_ALIGN" 
applied to the memory operation(s).


r~


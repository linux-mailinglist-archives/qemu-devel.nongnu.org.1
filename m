Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBE87FDE5F
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 18:28:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8OLG-0006zL-5Y; Wed, 29 Nov 2023 12:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8OLE-0006z7-7L
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 12:27:16 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8OLC-0007my-LY
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 12:27:15 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-58cecfb4412so24331eaf.3
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 09:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701278833; x=1701883633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2N5ofwvD7gujQ4VWlNEhHDhsD/O4YOcCtGAK382JrLY=;
 b=kjc5mBAqd5wnEALpFwafIpXbrVRrg1WP7cpGlbHny7hZq/hGVB3UXgGQjwJ8ZImM1j
 TIVxLqGLvEVfG4iokYir/huz+KR7kQn1fmk5pB3lw0XnVFZMsDHjja4mVAWAoykmk0DW
 MIjoIQXh6sF42T5mjui8rHiB8G2qzFpz1sHdHYXEKi4JXAZGQiF0AXlz92u0w0Nxo1EM
 6SHc4tJuhu7Gxh/5a3NSABjqKoCc/Ja8znjshHBS7UQ/+N1KdBDCEXu3Yp5pb13YMCPO
 PPpkFdpIhrkcVc5hSGl+Fv9UXEurB+hBVyYC1UC7Q/84/MrAADGX/5vligTivZUVD3dS
 Z0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701278833; x=1701883633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2N5ofwvD7gujQ4VWlNEhHDhsD/O4YOcCtGAK382JrLY=;
 b=mRyCQC7hJXdUXQykRPjTiktKRMl2ZjFBQfLN9vArYHkQpGzMC8b4h494qdTLv4yTbM
 Duq9r2l0Nn2xW3gmQv7zhuF20mPUFxvMVq0L4ZbSIbNsNh6SJt7Gk7+u48KVvFTo6iS/
 1C+NVJAgl/rPSTrkjTJzGn51LwpWW6Mv3uTH/b5BDMpxge2diroWN1y5LLAw74v/i/T5
 U4TlntYdIgS7IrzM6euiDzUyfHssHtCuQutXKC6cjGDaYosK4zQd52pZynSOY2+//HNH
 7YBpqXTxNQeFobbpYahyrgly7cBODxj/yHxOZmvB0PcrBFeGylUZXDkjJxMU36OKXl1Y
 1bCA==
X-Gm-Message-State: AOJu0Yzoob+a9Rsl23DuufBel9UWFSTK6MFWmlu684sBR8dTeKBAKu+W
 Ln/gU2Fk7bmHxMwqbTzHuJ8BYQ==
X-Google-Smtp-Source: AGHT+IGZfLlfQKn9u6k2U47pfLljE5CGiBuasMbD2YXgOZEZvUFz+a6MW2aDUkHNL/NvLYbMYj9aVw==
X-Received: by 2002:a05:6820:827:b0:58d:974b:504b with SMTP id
 bg39-20020a056820082700b0058d974b504bmr10181335oob.7.1701278832989; 
 Wed, 29 Nov 2023 09:27:12 -0800 (PST)
Received: from [192.168.174.227] (rrcs-71-42-197-3.sw.biz.rr.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 w4-20020a4a7644000000b0058d458b5420sm1975656ooe.47.2023.11.29.09.27.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 09:27:12 -0800 (PST)
Message-ID: <68a73d87-bb90-413d-ba48-e4bd62c61bd9@linaro.org>
Date: Wed, 29 Nov 2023 11:27:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv: The whole vector register move
 instructions depend on vsew
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>
References: <20231129170400.21251-1-max.chou@sifive.com>
 <20231129170400.21251-3-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231129170400.21251-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

On 11/29/23 11:03, Max Chou wrote:
> The RISC-V v spec 16.6 section says that the whole vector register move
> instructions operate as if EEW=SEW. So it should depends on the vsew
> field of vtype register.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 114ad87397f..3871f0ea73d 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3643,8 +3643,7 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
>           QEMU_IS_ALIGNED(a->rs2, LEN)) {                                 \
>           uint32_t maxsz = (s->cfg_ptr->vlen >> 3) * LEN;                 \
>           if (s->vstart_eq_zero) {                                        \
> -            /* EEW = 8 */                                               \
> -            tcg_gen_gvec_mov(MO_8, vreg_ofs(s, a->rd),                  \
> +            tcg_gen_gvec_mov(s->sew, vreg_ofs(s, a->rd),                \
>                                vreg_ofs(s, a->rs2), maxsz, maxsz);        \
>               mark_vs_dirty(s);                                           \
>           } else {                                                        \

This perhaps makes things clearer in the translator, but there is no difference in the tcg 
code generation end.  All logic operations (and, or, xor, mov...) ignore the element size.

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~


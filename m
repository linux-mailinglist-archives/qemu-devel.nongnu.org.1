Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 332A382D331
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 03:54:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPD7O-0003SP-Bt; Sun, 14 Jan 2024 21:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPD7M-0003Rv-8f
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 21:54:28 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPD7K-0008SU-N3
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 21:54:28 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6db79e11596so375324b3a.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 18:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705287264; x=1705892064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EkIXnQmEbalEjV5GUYvrKXwdFaFaD8HotsqcYxuvs48=;
 b=eaItcvFPVM+zgbenHBTmG09CEfP1BShIm4gmw307xjErR7dlfyiq8xQBTwcdE+xf4x
 U0/8nGr5JeKcSpFlHkFHD1F68H+GH/CpKbbmAFt1FmhFiALDpLMfgpIu8HdcNB8OtYWD
 ytY07I8VKHLTK7surv2vmRUMYTPvSy+kD/l3UVfDeZAbwl+1IiMQ/TtRU3J3ZIG69ZZE
 eccYPvdxIpYFsnOG/bgE/SpBgz55nKao6eHe7Ak2Z/TrGTJkWTSedhb+a9wdn7LryaRH
 s0/3qyWjb8QQg6VnV7YAOPIIDGqYT1zXIUReFBf9ony6L5mqbM4sFCkAXhP3F/jxf20K
 jiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705287264; x=1705892064;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EkIXnQmEbalEjV5GUYvrKXwdFaFaD8HotsqcYxuvs48=;
 b=I0orQtJ5Se0E7ob6KjJkoISB/NksbA+8oF07yz5Cfw4NBN/VyCdGuEedgdD3yxAqeF
 8pHD20VT2ZdHDffwj0epUVuu6nXVNrAwuI/3Ry/5vEkI6Oog1mrMrzhMVFcP6b194pJJ
 qHYL3diO46k+k1xwjEaZ2cxscnqGq2shhoHC1juo2s80diRqwKmDswVH1CcIHbvE8HVp
 0wsCIaxGUOQ+WTh0xycYiHkMD6mGsskBNOgW78JxtbxME1i1ZoZn5IOfNg6mNCk+iosr
 8Yre3gWfVFlbeuvVeT0Yal99LdR2Papa3L3Nib0hXvT+MzL0Z7XEhJ1Hrl+h+aC5EtET
 mT6Q==
X-Gm-Message-State: AOJu0Yx+SlmJZ6uG/79GOTs3WtKbaHyHohm+8aLj2iYFLen11mIef6vF
 YrziwgT0KMp8pj/O5QLQrE4phgjZODDZkA==
X-Google-Smtp-Source: AGHT+IG9Fg+xuTSTDbGCu6VNqqdwjxgr1t/NFSzuNGfp4HvJM7RgQ1gWDts/s4n84jkZ1+5Jr80UHw==
X-Received: by 2002:a05:6a00:1384:b0:6d9:af1f:dd44 with SMTP id
 t4-20020a056a00138400b006d9af1fdd44mr6437964pfg.9.1705287263895; 
 Sun, 14 Jan 2024 18:54:23 -0800 (PST)
Received: from [192.168.1.57] ([1.145.66.112])
 by smtp.gmail.com with ESMTPSA id
 fc18-20020a056a002e1200b006db13a02921sm6570401pfb.183.2024.01.14.18.54.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jan 2024 18:54:23 -0800 (PST)
Message-ID: <244768ca-35d6-40c9-8a1b-f5d2eed39aee@linaro.org>
Date: Mon, 15 Jan 2024 13:52:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Eip error in x86_64-softmmu
Content-Language: en-US
To: guoguangyao <guoguangyao18@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eduardo@habkost.net
References: <20240115020804.30272-1-guoguangyao18@mails.ucas.ac.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240115020804.30272-1-guoguangyao18@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/15/24 13:08, guoguangyao wrote:
> When closing PCREL, qemu-system-x86_64 run into error.
> Eip modification here leads to the result. Using s->pc
> in func gen_update_eip_next() solves the problem.
> 
> Fixes: b5e0d5d22fbf("target/i386: Fix 32-bit wrapping of pc/eip computation")
> 
> Signed-off-by: guoguangyao <guoguangyao18@mails.ucas.ac.cn>
> 
> 	modified:   target/i386/tcg/translate.c
> ---
>   target/i386/tcg/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index e1eb82a5c6..6f57d5a8a5 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -567,9 +567,9 @@ static void gen_update_eip_next(DisasContext *s)
>       if (tb_cflags(s->base.tb) & CF_PCREL) {
>           tcg_gen_addi_tl(cpu_eip, cpu_eip, s->pc - s->pc_save);
>       } else if (CODE64(s)) {
> -        tcg_gen_movi_tl(cpu_eip, s->base.pc_next);
> +        tcg_gen_movi_tl(cpu_eip, s->pc);
>       } else {
> -        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->base.pc_next - s->cs_base));
> +        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->pc - s->cs_base));
>       }
>       s->pc_save = s->pc;
>   }



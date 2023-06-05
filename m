Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9776C7227AA
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:42:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ATK-00069H-U7; Mon, 05 Jun 2023 09:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6ATH-00068Y-SL; Mon, 05 Jun 2023 09:42:07 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6ATG-00014k-9w; Mon, 05 Jun 2023 09:42:07 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6af86627460so4613981a34.1; 
 Mon, 05 Jun 2023 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685972524; x=1688564524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jZQ2Oj0Hu2PCwk6YHKCLSrVZdw2+IdPkM8sZTaJE3b4=;
 b=I7swHhx0PmMxPDBDMbvIIqt0ePB9mFOuFkHqZORLBasFl+pcrDPMrfZnO4e9fRmfoz
 UjK/6hi3xYLdzP9OZ8dNnc0Uq2X5Uu9fU2bkXcYn/p9U3tG5b6UPtRFEUfzF3Caz04KN
 bdPbOB3HAML7P5rrcAyO8qeHKJL08ohuJo9DVpSSOfpZTNQfCbkaDtVy/wQa1lNyM4zK
 fUVS9NEFMBud9j8OPMSfQK77+8cfeA4UTDYAdZUaKYMcbPJa97p1TvqGq2yCC/mOdnld
 T99N+SuNCPMoIIix/9u0HthuTZgHTVaHVZm15AhDe8vW26SupB8ykGDCCusdLO39JmHJ
 BDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685972524; x=1688564524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jZQ2Oj0Hu2PCwk6YHKCLSrVZdw2+IdPkM8sZTaJE3b4=;
 b=ZRgKrOvMhl0GudvXncW7EKxBVB0se+WdkpdKQOeOrVf1kArCg65HTH2wPDtvWdH0sN
 71WumbWmln9ybEgmgwDfEVT37E5vGHy+I0JnH6lU2OQLscbTuhkJrufpVfaksNeVlEnL
 OTQK6jcREulxG2NJB5EfWSajOQyVnrtAPD7aM9+QjvewV5VTHZHfeVEzvKK+OSOLEuVU
 t4YtcsGgVS4AKNWc76FILzv/Pf61CxB/JRP4D8b8ZBBztVTN1hT44ciQUCXa9Kvcz2sC
 XXH1MjHSmz6yJ2t7A9iAiK0Rx2KNu2cr6VLklu6eZw194p/mdOwHFD4PN5VfqY7QRuYq
 ZnIg==
X-Gm-Message-State: AC+VfDxKIj/WZHJHKCTbtfalfyg4V2zSlBu5CmwED5TJHjB2OXCOuD54
 DzQQxcuPH/HNK5G8EYxmQjI=
X-Google-Smtp-Source: ACHHUZ6Lrdf1LYOM1xA+j758NeeOLqA4tC7KPcIUMRnXTPYSzb5QaHZ+2kT8vv6cukC7tu68VoW11A==
X-Received: by 2002:a9d:7dd3:0:b0:6b1:6583:dfd9 with SMTP id
 k19-20020a9d7dd3000000b006b16583dfd9mr4155175otn.29.1685972524188; 
 Mon, 05 Jun 2023 06:42:04 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a9d628a000000b006a42e87aee4sm2012784otk.32.2023.06.05.06.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 06:42:03 -0700 (PDT)
Message-ID: <7626561a-c479-e229-7608-d6696626c41a@gmail.com>
Date: Mon, 5 Jun 2023 10:42:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] target/ppc: Fix lqarx to set cpu_reserve
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230605025445.161932-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230605025445.161932-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09,
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



On 6/4/23 23:54, Nicholas Piggin wrote:
> lqarx does not set cpu_reserve, which causes stqcx. to never succeed.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 94bf2658676 ("target/ppc: Use atomic load for LQ and LQARX")
> Fixes: 57b38ffd0c6 ("target/ppc: Use tcg_gen_qemu_{ld,st}_i128 for LQARX, LQ, STQ")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Queued. Thanks,


Daniel

> v2:
> - Fix bugs vs memory access fault [Richard]
> 
>   target/ppc/translate.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 3650d2985d..7a5bf1d820 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3881,6 +3881,7 @@ static void gen_lqarx(DisasContext *ctx)
>       tcg_gen_qemu_ld_i128(t16, EA, ctx->mem_idx, DEF_MEMOP(MO_128 | MO_ALIGN));
>       tcg_gen_extr_i128_i64(lo, hi, t16);
>   
> +    tcg_gen_mov_tl(cpu_reserve, EA);
>       tcg_gen_st_tl(hi, cpu_env, offsetof(CPUPPCState, reserve_val));
>       tcg_gen_st_tl(lo, cpu_env, offsetof(CPUPPCState, reserve_val2));
>   }


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E673D4B5
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:55:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXgI-0000XM-Fy; Sun, 25 Jun 2023 17:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDXgE-0000X6-Ed
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:53:58 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDXgC-0001zI-R0
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:53:58 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-987341238aeso311437566b.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687730034; x=1690322034;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FTVjWBIj5qiznP6SkoJ++rYkygLVvkn935fabBL5V8w=;
 b=NcJtn+Gx6WB8CRL/rQiqRM40kGKuWhmyTNFBUQLWCluYRrDcZVtAFG3YApl1gk4vV9
 bTNxHhtqoFOdFRfTC8+8ywSCXOEslZgMrWcS9Q3bc+n10tZdXZLyQfp4Dc6TGDRc5+nK
 STmKxpCdAo1r0PSdmtRwtMiImKmcqddTj4mj2b7hk9WpLb15xDOz8YbJYcApbehCJpB4
 43P9d4vdh2gdVrZfjBKbFc74FHNt+zhNeBjQMg1TqQzcaHuaaEsAeaDHR71d8RPaDNUl
 J+HpcvvacpHc9kGTR2m+0SBxxF/dhW7GMGkoIW34EFoWhH5VxQY36nEhf0HIoBGdp/1q
 tu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687730034; x=1690322034;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FTVjWBIj5qiznP6SkoJ++rYkygLVvkn935fabBL5V8w=;
 b=gMhsnWfGJ+wOBpwfY4O72CUwY1TxAGGwcXYzdg0JMip6+BXxTJJ7khZWeUWKVSK/ej
 +RU1dlr9QbvttN3I3MBw3vHNNqFOmr/Bw7bg+6+RhfCRFSYDnF9id8fHXNAwT16RAnpx
 0qhZ2YqqxborBDDej0MtIPUDatyl10JcHSllxo6RkutyIZW5DyJVZvWxM7oCijjKQcIo
 ftlcyW5kDQ6IT92eG9gZ5KWa6ppKwRJwUzzI7q47y4JFhZxN27EVxKLDA2XOFj0bNjuU
 XlO7NSzjgLTCkR3vJ1ukajId0lE/7cBeutkWme8FH9ffepqNsZCD4HRy+KkmAJNYmC70
 tOPw==
X-Gm-Message-State: AC+VfDzhJ+XvA0mUmm0Fpzf/p53tTMnlgxIrQYrUuQnbVz90PRXCEAKc
 E+chYCRqVqXuKsOlhau5pBwU+A==
X-Google-Smtp-Source: ACHHUZ4oC7yIKcsigoIRP1n2CwKKp9L/yZ5ryaKUA15GT9mFS0kYh2vEAYZwS5K+SeHPONeaZR6WOg==
X-Received: by 2002:a17:907:26c8:b0:94e:afa6:299f with SMTP id
 bp8-20020a17090726c800b0094eafa6299fmr24892429ejc.22.1687730034653; 
 Sun, 25 Jun 2023 14:53:54 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a170906398600b009829f31dd08sm2504650eje.50.2023.06.25.14.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jun 2023 14:53:54 -0700 (PDT)
Message-ID: <4ee66b35-5cf5-97d8-eca9-0e882e255c7c@linaro.org>
Date: Sun, 25 Jun 2023 23:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC v3 08/10] target/mips: Add support for native library calls
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
 <20230625212707.1078951-9-fufuyqqqqqq@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230625212707.1078951-9-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 25/6/23 23:27, Yeqi Fu wrote:
> Upon encountering specialized instructions reserved for native calls,
> store the function id and argument types, then invoke helper.
> 
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>   target/mips/tcg/translate.c | 26 ++++++++++++++++++++++++++
>   target/mips/tcg/translate.h |  2 ++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index a6ca2e5a3b..15ab889dca 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -36,6 +36,7 @@
>   #include "qemu/qemu-print.h"
>   #include "fpu_helper.h"
>   #include "translate.h"
> +#include "native/native-defs.h"
>   
>   /*
>    * Many sysemu-only helpers are not reachable for user-only.
> @@ -13592,6 +13593,31 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
>   #endif
>           break;
>       case OPC_SYSCALL:
> +        uint32_t sig = (ctx->opcode) >> 6;

            if (native_call_enabled() && sig) {
                if (ctx->native_call_status) {
                    ...
                } else {
                    ...
                }
                break;
            }

> +        if (native_call_enabled() && (!ctx->native_call_status) && sig) {
> +            ctx->native_call_status = true;
> +            ctx->native_call_id = sig;
> +            break;
> +        } else if (native_call_enabled() && (ctx->native_call_status) && sig) {
> +            TCGv arg1 = tcg_temp_new();
> +            TCGv arg2 = tcg_temp_new();
> +            TCGv arg3 = tcg_temp_new();
> +
> +            tcg_gen_mov_tl(arg1, cpu_gpr[4]);
> +            tcg_gen_mov_tl(arg2, cpu_gpr[5]);
> +            tcg_gen_mov_tl(arg3, cpu_gpr[6]);
> +
> +            TCGv_i32 abi_map = tcg_constant_i32(sig);
> +            TCGv_i32 func_id = tcg_constant_i32(ctx->native_call_id);
> +            TCGv res = tcg_temp_new();
> +            TCGv_i32 mmu_idx = tcg_constant_i32(MMU_USER_IDX);
> +            gen_helper_native_call(res, cpu_env, arg1, arg2, arg3,
> +                                    abi_map, func_id, mmu_idx);
> +            tcg_gen_mov_tl(cpu_gpr[2], res);
> +            ctx->native_call_status = false;
> +            ctx->native_call_id = 0;
> +            break;
> +        }
>           generate_exception_end(ctx, EXCP_SYSCALL);
>           break;
>       case OPC_BREAK:



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C275DBA7
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 12:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qN9aN-0006vc-Uo; Sat, 22 Jul 2023 06:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qN9aM-0006vS-HR
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 06:11:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qN9aK-00068P-3v
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 06:11:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so2311688f8f.2
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 03:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690020692; x=1690625492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K4BAaPgT8ZRvaVNwn8PWKkMztRfEZcv/rF2Z/NlCl8g=;
 b=SrxOUfA5cHX7g2q6eWBI+VOfS9EUyfg3aGEER/spJBvccriVo5KE7rbQxnS98sqtZp
 Wy5w/skWF/sw8Udr2G/6nSUotAO+lYvWRTsfk0MWqqFSTqheJTYYP4fDPt0339/NECGC
 3TKVLmdKrklUSvNxGgLUHLaTSBZLn/Km5IhCSnBMVa6rxrEMWlrljnS8WfLdIfwlhg8A
 nsemrYS3Nd/dLa49QDpc2RKStt7WUzc5swuogpK6qI5sbJmlo5ECmjsDfThvRJBUH3Ur
 QE+J07oBtAijc3HUz6IH7dNasoYiYQ1wSVXVnvXroxEbvKgVGp87IFyvdyLdSwsRFu7U
 h1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690020692; x=1690625492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K4BAaPgT8ZRvaVNwn8PWKkMztRfEZcv/rF2Z/NlCl8g=;
 b=gk5BXTrVxQoCegf48IESXwU+GDzfor6RBoo/y35RJmRwZHQZCNHb/RahiwVqaQHSdw
 8NlwxcjdiL1gzu70dvsdXcw3ECd7dppUg6x7jXsAHd9CGJfCxu8lTKhqxzX2I1LxIMXW
 5tPnjH07NUkJccBBCBgZNzfdVrlhBMePGsTWEz5qytVKX8hZE6fKOdkmeBRQKMiT8UMp
 gocvCK0/KDUd1ZRiZ5Cks6XCpF8QlwrEYQ8reclGvUGUYoFk9jzxGrL1sb0ZBIMRsBnh
 oZsHY3GHxFfPGwimrBaZ6ntNqcja1Xa0Zuf5OMYtHg43DZWbZD2H6+Z+2h+9Zm5N9IDe
 l11w==
X-Gm-Message-State: ABy/qLb/MiJmCu3YOid6MYN3XvFQFd56JTFk6XxQIYcWr6uwG4GCezYS
 PBxsMq0E5dXmEfVOIxoYuJckog==
X-Google-Smtp-Source: APBJJlHHTpneNwp+3ohfvbnEbJ1cSr1O86DSIfPrUvjwJVuVhhrC2dv8cHrR9Ntq7z8N8pITr7Oy6w==
X-Received: by 2002:a5d:404d:0:b0:317:4e25:eaeb with SMTP id
 w13-20020a5d404d000000b003174e25eaebmr178226wrp.24.1690020692119; 
 Sat, 22 Jul 2023 03:11:32 -0700 (PDT)
Received: from [172.20.2.77]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a05600c138500b003fd2e898aa3sm654659wmf.0.2023.07.22.03.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Jul 2023 03:11:31 -0700 (PDT)
Message-ID: <ffb529cb-2d73-cefd-e6b6-30c0ab7334fa@linaro.org>
Date: Sat, 22 Jul 2023 11:11:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] accel/tcg: Fix guest instruction address in output
 assembly log
Content-Language: en-US
To: Matt Borgerson <contact@mborgerson.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20230718013531.1669100-1-contact@mborgerson.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230718013531.1669100-1-contact@mborgerson.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/18/23 02:35, Matt Borgerson wrote:
> If CF_PCREL is enabled, generated host assembly logging (command line
> option `-d out_asm`) may incorrectly report guest instruction virtual
> addresses as page offsets instead of absolute addresses. This patch
> corrects the reported guest address.
> 
> Signed-off-by: Matt Borgerson <contact@mborgerson.com>
> ---
>   accel/tcg/translate-all.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index a1782db5dd..859db95cf7 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -283,6 +283,24 @@ static int setjmp_gen_code(CPUArchState *env, TranslationBlock *tb,
>       return tcg_gen_code(tcg_ctx, tb, pc);
>   }
>   
> +static vaddr get_guest_insn_vaddr(TranslationBlock *tb, vaddr pc, size_t insn)
> +{
> +    g_assert(insn < tb->icount);
> +
> +    /* FIXME: This replicates the restore_state_to_opc() logic. */
> +    vaddr addr = tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WORDS];
> +
> +    if (tb_cflags(tb) & CF_PCREL) {
> +        addr |= (pc & TARGET_PAGE_MASK);
> +    } else {
> +#if defined(TARGET_I386)
> +        addr -= tb->cs_base;
> +#endif
> +    }

I disagree with this.  The only bug I see is

>                       "  -- guest addr 0x%016" PRIx64 " + tb prologue\n",

"guest addr", which makes you believe this to be a guest virtual address.

I think it is important to log what is actually in the data structures, which is the page 
offset.

Why are you so keen to have the virtual address?  Why is this more reasonable than the 
physical address, or anything else?


r~


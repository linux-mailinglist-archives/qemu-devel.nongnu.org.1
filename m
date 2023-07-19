Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44535758A96
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 03:03:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLvbD-0001gq-0s; Tue, 18 Jul 2023 21:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qLvbA-0001ga-Sm
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 21:03:24 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jniethe5@gmail.com>)
 id 1qLvb7-0007mI-NG
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 21:03:24 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b8ad8383faso50486615ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 18:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689728599; x=1692320599;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X0+hzjhf/6kFNClrXPkoMZpxOT3umf0pZ79hCNj18lI=;
 b=nJL1hlV2wdup4xF9wP+vNBP4n4pkfdajB77iv6Uj16R5u9jHSiaRQAoYAsgryZiTUm
 i39FvopoDArRRHIKCvggDnVKZ1OOSRY56S7Q/vF61Tw+HjMt4Ly32qKMQ+IhNuTMD/tE
 FrpIfFiPWP600nwbyXPRCrjBg5X2yBQ4M4+hPw0+YWH9dkza94E34W1P5SYSdcAeW8RO
 TR3CjGXMb6ZOBTnJb0gvL3REJlZ4gbKFz65nf0Iqf60P3xkEIFcP0O7+nb84Us3Hgpyu
 Z7OTIt2Yc93NuA0gdn+nVFUYyDY5gZzAHwLxEoWpU41pKUlWx62KHd1icFbAmIepvYRX
 h3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689728599; x=1692320599;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X0+hzjhf/6kFNClrXPkoMZpxOT3umf0pZ79hCNj18lI=;
 b=c56FUEZ/1bwdKhHHJ52S1NB0Isp0fzisZRIJS6vSatgHhBRE7XigLSG3KGKhlp4lqv
 SzMjXJthyVZ7nM9d++ID2qcplNiRYkHWDWkxxjNMmzUL4oAosbXud+9txFyGQY5k+8yF
 yuWFBhJXbEL7Gh0zdtkSGE4XLLQtvr+GzQ4ZhrTgF7dGmm5hi7pYgHBVHD880Z82GOHw
 M/ch2GS0w87v2BXUI4dwT9BY0LPw6CFgFONz5MJaxoMB/ew3OZAz5fYlbPhN9xRLVIP1
 YbeLk6BVp1h2FCWUDhna7tpSwmSsym/qe63LuEflkr3rbTQv9gXvJLFOkU3XAJjODTCe
 icRw==
X-Gm-Message-State: ABy/qLY14pbrr2VmN9XN3XX7tT35ZOhJLhFh0mvva421bI/qv7JQv92Z
 mnVJy0ivLmlXZsy2Lk4URWc=
X-Google-Smtp-Source: APBJJlHBLQ8XNn2k6yRpwy6emIp4zu4sQ3UN9p3RRPuMEeivGzDjVgJchkCYOS9BVowv8/1bzFp5Iw==
X-Received: by 2002:a17:902:c3c6:b0:1b8:1c9e:444e with SMTP id
 j6-20020a170902c3c600b001b81c9e444emr16551314plj.25.1689728598625; 
 Tue, 18 Jul 2023 18:03:18 -0700 (PDT)
Received: from localhost.localdomain ([146.112.118.69])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a170902e74c00b001bb515e6b39sm193517plf.306.2023.07.18.18.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jul 2023 18:03:18 -0700 (PDT)
Subject: Re: [PATCH for-8.0] tcg/sparc64: Disable direct linking for goto_tb
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org
References: <20230404150435.1571646-1-richard.henderson@linaro.org>
From: Jordan Niethe <jniethe5@gmail.com>
Message-ID: <d9644b89-6ddf-8569-3ff8-b0c0b4f9dbe3@gmail.com>
Date: Wed, 19 Jul 2023 11:03:13 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230404150435.1571646-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=jniethe5@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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



On 5/4/23 1:04 am, Richard Henderson wrote:
> Something is wrong with this code, and also wrong with gdb on the
> sparc systems to which I have access, so I cannot debug it either.
> Disable for now, so the release is not broken.

I'm not sure if it is the entire problem but it looks like the broken 
code had the same race as on ppc [1] between loading TCG_REG_TB and 
patching and executing the direct branch.

[1] 
https://lore.kernel.org/qemu-devel/20230717093001.13167-1-jniethe5@gmail.com/#t

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target.c.inc | 30 ++++--------------------------
>   1 file changed, 4 insertions(+), 26 deletions(-)
> 
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index ccc4144f7c..694f2b9dd4 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -1445,12 +1445,12 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>   {
>       ptrdiff_t off = tcg_tbrel_diff(s, (void *)get_jmp_target_addr(s, which));
>   
> -    /* Direct branch will be patched by tb_target_set_jmp_target. */
> +    /* Load link and indirect branch. */
>       set_jmp_insn_offset(s, which);
> -    tcg_out32(s, CALL);
> -    /* delay slot */
> -    tcg_debug_assert(check_fit_ptr(off, 13));
>       tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TB, TCG_REG_TB, off);
> +    tcg_out_arithi(s, TCG_REG_G0, TCG_REG_TB, 0, JMPL);
> +    /* delay slot */
> +    tcg_out_nop(s);
>       set_jmp_reset_offset(s, which);
>   
>       /*
> @@ -1469,28 +1469,6 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>   void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>                                 uintptr_t jmp_rx, uintptr_t jmp_rw)
>   {
> -    uintptr_t addr = tb->jmp_target_addr[n];
> -    intptr_t br_disp = (intptr_t)(addr - jmp_rx) >> 2;
> -    tcg_insn_unit insn;
> -
> -    br_disp >>= 2;
> -    if (check_fit_ptr(br_disp, 19)) {
> -        /* ba,pt %icc, addr */
> -        insn = deposit32(INSN_OP(0) | INSN_OP2(1) | INSN_COND(COND_A)
> -                         | BPCC_ICC | BPCC_PT, 0, 19, br_disp);
> -    } else if (check_fit_ptr(br_disp, 22)) {
> -        /* ba addr */
> -        insn = deposit32(INSN_OP(0) | INSN_OP2(2) | INSN_COND(COND_A),
> -                         0, 22, br_disp);
> -    } else {
> -        /* The code_gen_buffer can't be larger than 2GB.  */
> -        tcg_debug_assert(check_fit_ptr(br_disp, 30));
> -        /* call addr */
> -        insn = deposit32(CALL, 0, 30, br_disp);
> -    }
> -
> -    qatomic_set((uint32_t *)jmp_rw, insn);
> -    flush_idcache_range(jmp_rx, jmp_rw, 4);
>   }
>   
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc,
> 


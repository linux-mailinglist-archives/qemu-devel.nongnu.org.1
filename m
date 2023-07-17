Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F3755D0C
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 09:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLIlU-0007tU-UF; Mon, 17 Jul 2023 03:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLIlB-0007s1-Kj
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 03:35:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLIl6-0000Wn-VP
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 03:35:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so31682095e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689579303; x=1692171303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7JrFj9BTVPmhBQuiuoDoprzdYEwbCV+clikqpFCCtGI=;
 b=TzAK+V2H1Rqza/l7uYhvau8JTtVXr75oeSV0ejMwl9xoLsfiM5AT5dKX0sVq55bVLu
 Mork81dHP6W9DHQyvQhvyl5i6cjj2yqfk5up/KU9sQzu9lTm9grZ8EfKD23jigtQgYCx
 NkNTNXukQ3bI9oqa11AcuNbAhPJQTi5EVYXd4fvFfuYhg8fnNRZHoiHxtEp3qm+xLrNn
 4AIc4w0iAxrjtygzCncJrKNYIqsCkSW/pqRUvXRoUDMkIp6dNeo9MmlYic1fo4IzkBZD
 dPZ/srXrZ+QWM7y4hnWW4YjDs8S668TmzPMjECKd3hLk8IaGmyp3nb2nLMD5P4Ddoi31
 pybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689579303; x=1692171303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7JrFj9BTVPmhBQuiuoDoprzdYEwbCV+clikqpFCCtGI=;
 b=KZyp8rvZdPcOb0qARakKUxAKBis1IMXLqZavzY4Qvmay6qpCmmwv5btbRWZSMFIL6T
 5tJBT7N7p3BSRyVCmkQdSGnxoHlxt9ZfWPuI+b6wdKQY/RRJI9hPZ45hv+E6FKHV5bNM
 nYOsi+3/B7C9KFV9y4vgri1o2n60PjcsS4zM20wLJEwrW19oNcKWpuPYP/93kFFb0taN
 fjbqMjtoMdOACiOs26IL2l4giRmgdhHbtKKqBb52BzPzWPI8yn05THG5uG1fBUdKih1m
 DOCR5WgB8TNTQ8fLeXHBXyjBRGDtToqJm2PlghR0jc0Xw/XWsWtmvCfVfwZHVIoRqFXc
 ASxA==
X-Gm-Message-State: ABy/qLYETHVF0mcPv4IyChw7ExCpBvq5b8QmEw1oIp8BSF8L8BP/U9A+
 is1eW0YXH4Jn64PBLQGV3w+ayg==
X-Google-Smtp-Source: APBJJlEtseZUnT1du3Mlkyrc2in0ntXP4BXyDSQv7samlC/gRwZg/ivdvIwmpPwUr+CuTI0eRbO+TQ==
X-Received: by 2002:a05:600c:da:b0:3fb:c075:b308 with SMTP id
 u26-20020a05600c00da00b003fbc075b308mr7592764wmm.12.1689579302892; 
 Mon, 17 Jul 2023 00:35:02 -0700 (PDT)
Received: from [192.168.1.205] ([51.219.12.49])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a5d6790000000b003112ab916cdsm18530528wru.73.2023.07.17.00.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 00:35:02 -0700 (PDT)
Message-ID: <504c0ab2-e314-c27b-a119-a310d8b028a1@linaro.org>
Date: Mon, 17 Jul 2023 08:35:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tcg/ppc: Fix race in goto_tb implementation
To: Jordan Niethe <jniethe5@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, alex.bennee@linaro.org, dbarboza@ventanamicro.com,
 npiggin@gmail.com, anushree.mathur@linux.vnet.ibm.com, mjt@tls.msk.ru,
 clg@kaod.org, bgray@linux.ibm.com
References: <20230717012327.20149-1-jniethe5@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230717012327.20149-1-jniethe5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/17/23 02:23, Jordan Niethe wrote:
> Commit 20b6643324 ("tcg/ppc: Reorg goto_tb implementation") modified
> goto_tb to ensure only a single instruction was patched to prevent
> incorrect behaviour if a thread was in the middle of multiple
> instructions when they were replaced. However this introduced a race
> between loading the jmp target into TCG_REG_TB and patching and
> executing the direct branch.
> 
> The relevent part of the goto_tb implementation:
> 
>      ld TCG_REG_TB, TARGET_ADDR_LOCATION(TCG_REG_TB)
>    patch_location:
>      mtctr TCG_REG_TB
>      bctr
> 
> tb_target_set_jmp_target() will replace 'patch_location' with a direct
> branch if the target is in range. The direct branch now relies on
> TCG_REG_TB being set up correctly by the ld. Prior to this commit
> multiple instructions were patched in for the direct branch case; these
> instructions would initalise TCG_REG_TB to the same value as the branch
> target.
> 
> Imagine the following sequence:
> 
> 1) Thread A is executing the goto_tb sequence and loads the jmp
>     target into TCG_REG_TB.
> 
> 2) Thread B updates the jmp target address and calls
>     tb_target_set_jmp_target(). This patches a new direct branch into the
>     goto_tb sequence.
> 
> 3) Thread A executes the newly patched direct branch. The value in
>     TCG_REG_TB still contains the old jmp target.
> 
> TCG_REG_TB MUST contain the translation block's tc.ptr. Execution will
> eventually crash after performing memory accesses generated from a
> faulty value in TCG_REG_TB.
> 
> This presents as segfaults or illegal instruction exceptions.
> 
> Do not revert commit 20b6643324 as it did fix a different race
> condition. Instead remove the direct branch optimization and always use
> indirect branches.
> 
> The direct branch optimization can be re-added later with a race free
> sequence.
> 
> Gitlab issue: https://gitlab.com/qemu-project/qemu/-/issues/1726
> 
> Fixes: 20b6643324 ("tcg/ppc: Reorg goto_tb implementation")
> 
> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Co-developed-by: Benjamin Gray <bgray@linux.ibm.com>
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
>   tcg/ppc/tcg-target.c.inc | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 8d6899cf40..a7323f479b 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2533,11 +2533,10 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
>           ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
>           tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset);
>       
> -        /* Direct branch will be patched by tb_target_set_jmp_target. */
> +        /* TODO: Use direct branches when possible. */
>           set_jmp_insn_offset(s, which);
>           tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
>   
> -        /* When branch is out of range, fall through to indirect. */
>           tcg_out32(s, BCCTR | BO_ALWAYS);
>   
>           /* For the unlinked case, need to reset TCG_REG_TB.  */
> @@ -2565,10 +2564,11 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
>       intptr_t diff = addr - jmp_rx;
>       tcg_insn_unit insn;
>   
> +    if (USE_REG_TB)
> +        return;
> +

Braces.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This is an excellent reason to add support for power10, and its pc-relative references. 
We can disable REG_TB for that case.


r~


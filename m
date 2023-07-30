Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1337686D9
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 19:48:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQASR-0007Zn-TK; Sun, 30 Jul 2023 13:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQASP-0007ZP-Ai
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 13:43:53 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQASN-0003np-Bj
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 13:43:53 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bbc06f830aso23463245ad.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690739029; x=1691343829;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QtGwLS/VdYydX/glCIj5f7bhJig2rdszW3l5C9a0VU4=;
 b=pmpDI1EphtbhAjpZNJq2uuanvNXbH2Sw7VdqO+JIQRDOGhwqzg9pWzU3eyr5Q3Kong
 gxssvqw7nbswomAOWNm90lV6G+1rRg/O5hTqVxid4WdVLxJZqxoH+Kb3u6R/cMtGuY44
 bA+AEvRV8oW0qC8UnRJXB9QnA/IFTG870F72KePHVXYl9xj7AZXWqxpABTfpg1v9fC91
 M8sMoCLgRHFMZkz+wsUBJ366pBlVxdrjzexsb/zetgbypXx2iSeXSSNrFQnXJUMPlhMd
 IbuUo52OL6n7AIHGpunx7UBSzP7uYC+Uzv9duP83FLuzsTDjtFHUuWKeNF8vUfGi6mLt
 oJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690739029; x=1691343829;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QtGwLS/VdYydX/glCIj5f7bhJig2rdszW3l5C9a0VU4=;
 b=CED0IYf8t7DA4UU5O0LI/O6EnrxDTPErUpheQHK3WfhYydQUByeATy+DciIS61MVrN
 uONN3jAFn+EyNHCueYWtDb9Nox2t5T2CgPskWSBRm1BCRCrLGhO2Wr2otnqVV86xGi3u
 uGpz4BMCP50jR4xW2iA1lCk1b7yFY6pDC9Az/zA0zTOUmuzT0/tPGuBkwfCExxcKP1Ne
 upXOq2jA/WOTLqEX5ns1Jpm60xx5HYUmp8+vAMyQb6FB/IAAozUFk4Q2DPvOlc82WMq4
 y/nsIhH16axs+FNYT2uIsqEaqRutgL4Rn4B6SRIIPvRXXHyaeXwl2IRoewYjqu1vm5FA
 dF1w==
X-Gm-Message-State: ABy/qLbOTPlrESloM+aLR0WqBi+ty+adqBsXK0uKzaPKeRa+EcPe3PcE
 q4QCV6sE58EDPO8vEGqE6scG4Q==
X-Google-Smtp-Source: APBJJlH4YCrmn5ZG10q3rQjKC+8KeZ6nElg685IK0cQqKXqK/4itAEng1nFYMdmyF5X9VXTbimkKdg==
X-Received: by 2002:a17:902:ceca:b0:1b7:ca9c:4f5c with SMTP id
 d10-20020a170902ceca00b001b7ca9c4f5cmr8514770plg.28.1690739028470; 
 Sun, 30 Jul 2023 10:43:48 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:a7b4:380e:e513:5ef2?
 ([2602:47:d490:6901:a7b4:380e:e513:5ef2])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a639202000000b00563397f1624sm6668168pgd.69.2023.07.30.10.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 10:43:48 -0700 (PDT)
Message-ID: <19b913a1-57d1-1631-06bb-04149b8a7bd1@linaro.org>
Date: Sun, 30 Jul 2023 10:43:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/openrisc: Set EPCR to next PC on FPE exceptions
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20230729210851.3097340-1-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230729210851.3097340-1-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/29/23 14:08, Stafford Horne wrote:
> The architecture specification calls for the EPCR to be set to "Address
> of next not executed instruction" when there is a floating point
> exception (FPE).  This was not being done, so fix it by using the same
> method as syscall.  Note, this may need a lot more work if we start
> seeing floating point operations in delay slots which exceptions
> enabled.
> 
> Without this patch FPU exceptions will loop, as the exception hanlding
> will always return back to the failed floating point instruction.
> 
> This was not noticed in earlier testing because:
> 
>   1. The compiler usually generates code which clobbers the input operand
>      such as:
> 
>        lf.div.s r19,r17,r19
> 
>   2. The target will store the operation output before to the register
>      before handling the exception.  So an operation such as:
> 
>        float a = 100.0f;
>        float b = 0.0f;
>        float c = a / b;    /* lf.div.s r19,r17,r19 */
> 
>      Will first execute:
> 
>        100 / 0    -> Store inf to c (r19)
>                   -> triggering divide by zero exception
>                   -> handle and return
> 
>      Then it will exectute:
> 
>        100 / inf  -> Store 0 to c  (no exception)
> 
> To confirm the looping behavoid and the fix I used the following:
> 
>      float fpu_div(float a, float b) {
> 	float c;
> 	asm volatile("lf.div.s %0, %1, %2"
> 		      : "+r" (c)
> 		      : "r" (a), "r" (b));
> 	return c;
>      }
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>   target/openrisc/interrupt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
> index 3887812810..9b14b8a2c6 100644
> --- a/target/openrisc/interrupt.c
> +++ b/target/openrisc/interrupt.c
> @@ -34,7 +34,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
>       int exception = cs->exception_index;
>   
>       env->epcr = env->pc;
> -    if (exception == EXCP_SYSCALL) {
> +    if (exception == EXCP_SYSCALL || exception == EXCP_FPE) {
>           env->epcr += 4;
>       }
>       /* When we have an illegal instruction the error effective address

According to Table 6-3, when in a delay slot the EPCR should be the address of the jump, 
for both syscall and fpe.  This whole block should be moved down...

>     /* Set/clear dsx to indicate if we are in a delay slot exception.  */
>     if (env->dflag) {
>         env->dflag = 0;
>         env->sr |= SR_DSX;
>         env->epcr -= 4;
>     } else {
>         env->sr &= ~SR_DSX;
>     }

... into the else.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


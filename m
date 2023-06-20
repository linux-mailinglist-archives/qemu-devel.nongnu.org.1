Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E94F736ADC
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:22:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZR2-0003eQ-N1; Tue, 20 Jun 2023 07:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBZR0-0003e3-4f
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:22:06 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBZQy-00087j-2T
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:22:05 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-98862e7e3e6so376172566b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687260122; x=1689852122;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rph3lYyqaiUu3OixE3Y2/spxfHOSoluf7LkbZNwjMjU=;
 b=L/19TPumMf80h6398IJIYX86BTMRzFfQomIreTcmSfAu81axnFen0h9DVsnREJDbXF
 1ODybKZUQb6d0AeBSAuPjZpLdM510sARQWabYjnWajgRdDDV+SgRg+YF9bYKJM22WeQ+
 XCmliTy1lrBgTewe2j5jU4lB4pwlYK2NtTZqCYuDYtYcWcmOzo4zdwxjS+1AsQ+neEm0
 AJkMehs8kiNOOb7/F8Phq3zT4QAd794z+kqriN85AVvrKIpdTxo95GJXakeqHknaCBpg
 tyfU7uHBF1PPWSRDibe/+6AXGTFhjQb58ef/9JeH4zzI/BwgZWnmoi+diPlfhmIL/KC6
 f2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687260122; x=1689852122;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rph3lYyqaiUu3OixE3Y2/spxfHOSoluf7LkbZNwjMjU=;
 b=N6roPwDT/lLpMrWtSyTltAbYdVUqaqMFOz64CxG+vyfoc46KDaJf9DLQb3NYf6f3pW
 YqVJMaAlks5jpEcm2TK2S50wXkDeEZ4MqKoVLlIhOXGY7N1pYEoAdZgU/4pPtufzkmiy
 IErfTfkM0gD5X21oal4N7rncST5JDW0GTe6Zi7Hg5/iPR9+rhpnnWKNKc+nX5KG8vMey
 J7VtT8ACnIk839gF3r7fIy1BkGj2Mx1Q+7Lwgztr4k84v6mmXuGsscm/Xx6OMsqK+eiP
 SqkjJtWUuRJMChjtOIGQyNaOCVEm/tWCY1jmXmuyqdjn9G3WKsvuD402Xt9nBTwLVLkC
 S6Sw==
X-Gm-Message-State: AC+VfDyMg1j1UwWiZTySL1SqPPZqAFMQeSDoCovLNrWQ8fMJ/zP+mARH
 vdl8V+KifIl5VQ4d05DN70GsAA==
X-Google-Smtp-Source: ACHHUZ4z/NVt3RYvUenx05AjkdEAgwfyXmcn+w7W+cFD2rHj8OvnfQpZE7he5j3YOsYy7clM1cqc3w==
X-Received: by 2002:a17:907:a01:b0:987:fe18:1c56 with SMTP id
 bb1-20020a1709070a0100b00987fe181c56mr6915771ejc.47.1687260122326; 
 Tue, 20 Jun 2023 04:22:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a1709064a8900b00985767bb5f9sm1197352eju.70.2023.06.20.04.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 04:22:01 -0700 (PDT)
Message-ID: <676ac594-77c6-3953-7355-1b96a09d93df@linaro.org>
Date: Tue, 20 Jun 2023 13:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH for-8.1] target/sparc: Use tcg_gen_lookup_and_goto_ptr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230405185922.2122668-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230405185922.2122668-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 5/4/23 20:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 137bdc5159..47940fd85e 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -322,7 +322,7 @@ static void gen_goto_tb(DisasContext *s, int tb_num,

[expanding diff context]

         if (use_goto_tb(s, pc, npc))  {
             /* jump to same page: we can use a direct jump */
             tcg_gen_goto_tb(tb_num);
             tcg_gen_movi_tl(cpu_pc, pc);
             tcg_gen_movi_tl(cpu_npc, npc);
             tcg_gen_exit_tb(s->base.tb, tb_num);
         } else {

>           /* jump to another page: currently not optimized */
>           tcg_gen_movi_tl(cpu_pc, pc);
>           tcg_gen_movi_tl(cpu_npc, npc);
> -        tcg_gen_exit_tb(NULL, 0);
> +        tcg_gen_lookup_and_goto_ptr();

Per 
https://qemu.readthedocs.io/en/latest/devel/tcg.html#lookup-and-goto-ptr 
[*]:

This helper will look for an existing TB that matches the current CPU 
state. If the destination TB is available its code address is returned, 
otherwise the address of the JIT epilogue is returned.

OK. IIUC this is the "optimized" form (trying to not exit the current
TB). Should the comment be updated to "/* jump to another page */"?

>       }
>   }
>   
> @@ -4153,7 +4153,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)

[expanding diff context]

                              case 0x3: /* V9 wrasi */

wrasi = "Write ASI register" instruction.

>                                   /* End TB to notice changed ASI.  */
>                                   save_state(dc);
>                                   gen_op_next_insn();
> -                                tcg_gen_exit_tb(NULL, 0);
> +                                tcg_gen_lookup_and_goto_ptr();

Memory mapping is not changed, CPU state change is constant,
no interrupt updated, OK.

>                                   dc->base.is_jmp = DISAS_NORETURN;
>                                   break;
>                               case 0x6: /* V9 wrfprs */

wrfprs = "Write floating-point registers state register".

>                                   dc->fprs_dirty = 0;
>                                   save_state(dc);
>                                   gen_op_next_insn();
> -                                tcg_gen_exit_tb(NULL, 0);
> +                                tcg_gen_lookup_and_goto_ptr();

Similar analysis, OK.

>                                   dc->base.is_jmp = DISAS_NORETURN;
>                                   break;
>                               case 0xf: /* V9 sir, nop if user */
> @@ -5661,7 +5661,7 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)

[expanding diff context]

         switch (dc->base.is_jmp) {
         case DISAS_NEXT:
         case DISAS_TOO_MANY:
             if (dc->pc != DYNAMIC_PC &&
                 (dc->npc != DYNAMIC_PC && dc->npc != JUMP_PC)) {
                 /* static PC and NPC: we can use direct chaining */
                 gen_goto_tb(dc, 0, dc->pc, dc->npc);
             } else {
                 if (dc->pc != DYNAMIC_PC) {

>                   tcg_gen_movi_tl(cpu_pc, dc->pc);
>               }
>               save_npc(dc);
> -            tcg_gen_exit_tb(NULL, 0);
> +            tcg_gen_lookup_and_goto_ptr();

Per [*] "we either branch to the next TB or return to the main loop."

So here we just perform an indirect branch, possibly using the JIT
epilogue instead of directly returning to the main loop. OK.

To the best of my knowledge:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           }
>           break;
>   



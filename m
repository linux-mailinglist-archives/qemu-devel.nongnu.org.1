Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4B8197E8
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 05:56:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFobn-0004uA-64; Tue, 19 Dec 2023 23:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rFobk-0004tt-9f
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:55:00 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rFobi-0001fC-F4
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:54:59 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5cd86e3a9afso263073a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 20:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703048097; x=1703652897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pNzKABZbnaK/uthynYntCMPgX5leSiv7mSYezkrPudA=;
 b=ZPNbONlyblZlWuES2ivHn6XXOe7B4YMsfzcGVeFBMFSrPN0FfdjWjXllQZVGb1NJIM
 AnPXJE9KqbP9yCkryFSX5RuYBz9GMf1MplqioB6CKxlGMGJL4dnuRViONnIp9d6amn/N
 VxH4HrEuNHng6VXstSwExgL4sjk0Ojf2qIszxhx5YCPNnkuhEUAIeZrANJcAhSh4LL8V
 QaCDxiCMhtWJvL45XXuQnyTqmWqK6WyfQAOSkyqzkB4Nxz7Xnwa/96bkOMSP/WLb7ZwP
 7KxuNojfdFqnK5C1Z0nobCvTenKLzJupp9gpv7hJ1jvi//dJAQHPucoPE8uwiYDNJ2el
 SBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703048097; x=1703652897;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNzKABZbnaK/uthynYntCMPgX5leSiv7mSYezkrPudA=;
 b=QuzAbown0JOguFjoOHl8aVe6kUVKXuufsKnuXQIrqwW9Md6EBcRue9ZVjSJzd2D6v8
 6niDcG6PQTaC7sbh3OnReEznK/wOmDDtwN0EdszKg2pUnGpaRHuKeX6MkunqDEfityj5
 7OtC+Sam61mSfLjxni0bbc/9ojsWle5QJ82hArKtCKXDZ96KbYTPMmO4z0iDaf+c7LE3
 /VdBHIR4dJPSwQ8lhdVBa9kksaXWGx+5ypYCHXprhR6uk9yzxkOOZugjLijjjmMu4CKr
 kHm+wIfXIxXIaWqAuonaaBxm7Fu29mtU2+Y+npe3+9O444U79jkwGllDChe8VvZagChb
 cmUw==
X-Gm-Message-State: AOJu0YyReT3ecv5dooKU+YEY/J6oQYCMq7jKFDNh0mxI+3nY+RdIsWjl
 rcqQdGYO3JVjnaG7NvE0nS/1zw==
X-Google-Smtp-Source: AGHT+IEIGeoPLowjgZ52vhLG/Psii+05Tfm3Jz3P2owm6JPGwS30CGq+syZFWHkt+D6+4Hwl0rH9Cg==
X-Received: by 2002:a05:6a20:40a0:b0:194:9898:17f8 with SMTP id
 a32-20020a056a2040a000b00194989817f8mr1634557pzf.31.1703048096624; 
 Tue, 19 Dec 2023 20:54:56 -0800 (PST)
Received: from [192.168.1.13] ([43.252.112.169])
 by smtp.gmail.com with ESMTPSA id
 f12-20020aa78b0c000000b006d095553f2asm16080853pfd.81.2023.12.19.20.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 20:54:56 -0800 (PST)
Message-ID: <8c168040-f357-4f6a-aece-dd4ecfa39cab@linaro.org>
Date: Wed, 20 Dec 2023 15:54:51 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Give IRQs a chance when resetting
 HF_INHIBIT_IRQ_MASK
Content-Language: en-US
To: Ruihan Li <lrh2000@pku.edu.cn>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20231210190147.129734-2-lrh2000@pku.edu.cn>
 <vtru73lhzn24ue6dlx3hbqm4y4dcqvrx2nvjnbbwozfix5h5wa@63tiijodka5c>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <vtru73lhzn24ue6dlx3hbqm4y4dcqvrx2nvjnbbwozfix5h5wa@63tiijodka5c>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 12/20/23 02:04, Ruihan Li wrote:
> Hi all,
> 
> On Mon, Dec 11, 2023 at 03:01:48AM +0800, Ruihan Li wrote:
>> When emulated with QEMU, interrupts will never come in the following
>> loop. However, if the NOP instruction is uncommented, interrupts will
>> fire as normal.
>>
>> 	loop:
>> 		cli
>>      		call do_sti
>> 		jmp loop
>>
>> 	do_sti:
>> 		sti
>> 		# nop
>> 		ret
>>
>> This behavior is different from that of a real processor. For example,
>> if KVM is enabled, interrupts will always fire regardless of whether the
>> NOP instruction is commented or not. Also, the Intel Software Developer
>> Manual states that after the STI instruction is executed, the interrupt
>> inhibit should end as soon as the next instruction (e.g., the RET
>> instruction if the NOP instruction is commented) is executed.
>>
>> This problem is caused because the previous code may choose not to end
>> the TB even if the HF_INHIBIT_IRQ_MASK has just been reset (e.g., in the
>> case where the RET instruction is immediately followed by the STI
>> instruction), so that IRQs may not have a change to trigger. This commit
>> fixes the problem by always terminating the current TB to give IRQs a
>> chance to trigger when HF_INHIBIT_IRQ_MASK is reset.
>>
>> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
>> ---
>> The same problem was discovered two years ago, see [StackOverflow][so].
>>
>>   [so]: https://stackoverflow.com/questions/68135305/executing-ret-after-sti-doesnt-start-interrupts
>>
>>   target/i386/tcg/translate.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
>> index 587d886..6b7deb5 100644
>> --- a/target/i386/tcg/translate.c
>> +++ b/target/i386/tcg/translate.c
>> @@ -2767,13 +2767,19 @@ static void gen_bnd_jmp(DisasContext *s)
>>   static void
>>   do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
>>   {
>> +    bool inhibit_reset;
>> +
>>       gen_update_cc_op(s);
>>   
>>       /* If several instructions disable interrupts, only the first does it.  */
>>       if (inhibit && !(s->flags & HF_INHIBIT_IRQ_MASK)) {
>>           gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
>> -    } else {
>> +        inhibit_reset = false;
>> +    } else if (!inhibit && (s->flags & HF_INHIBIT_IRQ_MASK)) {
>>           gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
>> +        inhibit_reset = true;
>> +    } else {
>> +        inhibit_reset = false;
>>       }
>>   
>>       if (s->base.tb->flags & HF_RF_MASK) {
>> @@ -2784,7 +2790,9 @@ do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
>>           tcg_gen_exit_tb(NULL, 0);
>>       } else if (s->flags & HF_TF_MASK) {
>>           gen_helper_single_step(tcg_env);
>> -    } else if (jr) {
>> +    } else if (jr &&
>> +               /* give irqs a chance to happen */
>> +               !inhibit_reset) {
>>           tcg_gen_lookup_and_goto_ptr();
>>       } else {
>>           tcg_gen_exit_tb(NULL, 0);
>> -- 
>> 2.43.0
> 
> A friendly ping.
> 
> Anyone here to confirm this BUG and/or comment on the patch?

Looks correct.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



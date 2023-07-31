Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44196769A19
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:51:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQUEf-0007ha-Aj; Mon, 31 Jul 2023 10:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQUET-0007eM-Tj
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:50:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQUER-0006Nt-NV
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:50:49 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686bc261111so3246524b3a.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690815044; x=1691419844;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=23BfVe44Mz4FAVTmRxrfNUmkAlP1s8jGUx9p2E0iIsk=;
 b=i51yBfqWYHJZNXOOO3Zc1aD/8heRb844C2UlRyj58BqK13MJVEO6oqGcOoc37KSVim
 Dcn1CAbDXIS5bWd+FzwculI07tj7HtydhOFWenb2VY7lNoQXPdYodP3i8XVJKKbb9XUa
 vAIAKcnA5iz5WJ49Ydmkn6HCqzzLdIL8sks8bWCZkgez8mB21CkiCr4hTeLJpxIdfxp1
 qL/uF0OUotW/gMU3H1rolJyKri9pKW20TwiwXQtN6eb8h9H+5XvnrxUffCE+dC9CKFyH
 U2j3aCy63DX4JLEaNOTtokMAvUq9qcvH2rCvT1D1UsI1ohxKirZuM+FHddBh1fNNTv0a
 jYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690815044; x=1691419844;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23BfVe44Mz4FAVTmRxrfNUmkAlP1s8jGUx9p2E0iIsk=;
 b=d/O1bNPfJbyNwxRuUAoG+jjjHMrDnrpy1/tbQ92S8Y4hdds6pPfWHuai6fxrw3UzVc
 5UGtrys0Uv+XmZO90YLwGjdb4em+na8Dwt97vwXkJUO/QA8tiBjGCiU486uV7BNnVlME
 PV2HXY+EPx71u2Bj8B66M04hd6ZMaw1b5pWtAxtvT3RrJZhzpKMXVZbnLpALPYdjRCVM
 y/sbAlD2AcpuO5wE+Skx+ENmDSvv72+ASZHJyVYlhURDFXak2gH/emXeElYaiuvxV24K
 m7PFk8XWS5TVGFBIm64drWdsBnvlDeHrFt9qILHFOhRcF3a3/BjUBAOeEa4vMUggbd+z
 +Utw==
X-Gm-Message-State: ABy/qLZDaAU9koP1exZBF3u+PsnCy/FpVyspwU8HrBGIDJvn800QBuXv
 a0DAFykA/mE+3YFbaSlTRZJbTw==
X-Google-Smtp-Source: APBJJlGMr3yda+j16r38qAU8+BkBMJCsZv72GAUadHlLQJ9gh4amUL77Lwq+oidWDfqWqMcOetLO3A==
X-Received: by 2002:a05:6a21:4887:b0:134:ad98:fb0c with SMTP id
 av7-20020a056a21488700b00134ad98fb0cmr11296590pzc.4.1690815044052; 
 Mon, 31 Jul 2023 07:50:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a63ac45000000b0056420d3cd20sm5761452pgn.71.2023.07.31.07.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 07:50:43 -0700 (PDT)
Message-ID: <fa0e79f3-acdc-09b2-3377-a3fae6eca8bc@linaro.org>
Date: Mon, 31 Jul 2023 07:50:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH] accel/tcg: Use lookup_and_goto_ptr() for linux-user
 in translator_use_goto_tb()
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <ZMakYpOgco2Ihg0G@p100>
 <b0ff6b75-60c9-aa3e-e701-a4062558a9bf@linaro.org>
 <2c178363-b1a3-1192-09ac-2bbfa7ae7672@gmx.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2c178363-b1a3-1192-09ac-2bbfa7ae7672@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 7/30/23 13:37, Helge Deller wrote:
> On 7/30/23 22:03, Richard Henderson wrote:
>> On 7/30/23 10:56, Helge Deller wrote:
>>> I'm quite unclear about translator_use_goto_tb() for qemu-user
>>> emulation....(and in general).
>>>
>>> Based on the function name, the function translator_use_goto_tb() shall
>>> help to decide if a program should use goto_tb() and exit_tb() to jump
>>> to the next instruction.
>>>
>>> Currently, if the destination is on the same page, it returns true.
>>> I wonder, if it shouldn't return false in this case instead, because
>>> arches have code like this: (taken from target/hppa/translate.c):
>>>      if (... && translator_use_goto_tb(ctx, f)) {
>>>          tcg_gen_goto_tb(which);
>>>          tcg_gen_movi_reg(cpu_iaoq_f, f);
>>>          tcg_gen_movi_reg(cpu_iaoq_b, b);
>>>          tcg_gen_exit_tb(ctx->base.tb, which);
>>>      } else {
>>>          copy_iaoq_entry(cpu_iaoq_f, f, cpu_iaoq_b);
>>>          copy_iaoq_entry(cpu_iaoq_b, b, ctx->iaoq_n_var);
>>>          tcg_gen_lookup_and_goto_ptr();
>>>      }
>>>
>>> Shouldn't, if the destination is on the same page, the (faster?)
>>> path with tcg_gen_lookup_and_goto_ptr() be taken instead?
>>
>> No, because tcg_gen_lookup_and_goto_ptr is not the faster path.
>> That always involves a lookup, then an indirect branch.
> 
> Ah, ok. So my assumption was wrong, and this explains it.
> 
>> The goto_tb path is linked, so only requires a lookup once, and the
>> branch may be direct (depending on the host architecture).
> Probably the last question in this regard:
> 
> This code:
> IN:
> 0x00010c98:  cmpib,<>,n 0,r19,0x10c98
> 
> generates "nop/jmp" in the code:
> 
> the tcg_gen_goto_tb() branch:
> OUT:
> 0x7fd7e400070e:  85 db                    testl    %ebx, %ebx
> 0x7fd7e4000710:  0f 85 20 00 00 00        jne      0x7fd7e4000736
> 0x7fd7e4000716:  90                       nop                <- from 
> "tcg_gen_op1i(INDEX_op_goto_tb, idx)" in tcg_gen_goto_tb()
> 0x7fd7e4000717:  e9 00 00 00 00           jmp      0x7fd7e400071c    <- jump is effective 
> useless.
> 0x7fd7e400071c:  c7 45 00 a3 0c 01 00     movl     $0x10ca3, (%rbp)
> 0x7fd7e4000723:  c7 45 04 a7 0c 01 00     movl     $0x10ca7, 4(%rbp)
> 0x7fd7e400072a:  48 8d 05 0f ff ff ff     leaq     -0xf1(%rip), %rax
> 0x7fd7e4000731:  e9 e2 f8 ff ff           jmp      0x7fd7e4000018
> 0x7fd7e4000736:  90                       nop                <- here too.
> 0x7fd7e4000737:  e9 00 00 00 00           jmp      0x7fd7e400073c
> 0x7fd7e400073c:  c7 45 00 9f 0c 01 00     movl     $0x10c9f, (%rbp)
> 0x7fd7e4000743:  c7 45 04 9b 0c 01 00     movl     $0x10c9b, 4(%rbp)
> 0x7fd7e400074a:  48 8d 05 f0 fe ff ff     leaq     -0x110(%rip), %rax
> 0x7fd7e4000751:  e9 c2 f8 ff ff           jmp      0x7fd7e4000018
> 
> I assume those nops/jmp+0 is to be able to insert breakpoints?

No.

The destination of the jmp is patched by tb_target_set_jmp_target, which happens some time 
after this disassembly.  The nop is present to ensure that the patch point is aligned, so 
that it is one 4-byte atomic store.


r~


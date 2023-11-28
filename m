Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EEA7FC0FE
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 19:06:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r82TH-0002Es-3U; Tue, 28 Nov 2023 13:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r82TE-0002ET-9M
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:06:04 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r82TC-0000Kx-GS
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:06:04 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c8880fbb33so75918401fa.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 10:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701194760; x=1701799560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m2LeVsrDjWyRn1jYA0xN7yrslB3v2IVPRw4NROBC4aE=;
 b=HvmgtKyZ1pHcZ1TlOU4M769M5vM7APIQ9Cg3HXUl8iIPp5b93s5bvuPwtqX3QXW9iU
 Ksro6konfB7Qx8BtTM11GooGQA+XopHVRJI9eIu7c8qgaMuFucFQYAExj1rAPQQhapBT
 lfDY7mP72zgGvnB2eerrkPJXq8YPqH7nyNdlVLV/CQDnnFv1/03F/6gCGCpn/VbPv2ID
 PiiMlKHmgmptJeiuIhaAhJQJMl0CxrZbff7nz02MMiT1y9q8FVMjEPr8JtkdrOM+b4w7
 DZie6Qyyz0obecGxhG8ZyzaXdmZn5XEa6m97bvXiRh6jr7Dd2WNpNmNO/L3HkKtFye0M
 tlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701194760; x=1701799560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m2LeVsrDjWyRn1jYA0xN7yrslB3v2IVPRw4NROBC4aE=;
 b=vcOKYoxLuXdEbg0Mq/73aePPn7/IH8JuoQ+r4EhZiPduSt4YRXIT2ZbJWD2DmR1bRo
 S9TIrXxrMa8juwMAspj17Kpi9QHxYFWQ8jrKIUyTjvfHb2MHupyTmiVxx60uhupv3LJo
 OYT0+oQCAv0vT8uutgQ4bmmCFAGtETsb+UbC4laAaUkS6Wdx7+cXdkamhaZ7iEwYsOIb
 VfMfvPoUMAH423IaX00T2KZNv6ZFc7x9aSK8i8pOr1db6D9Gk+dyFjkDeJ9BNlcfOiIJ
 fSnXitrQ8BHk0dlhOORzwZ9bPnBbs7hyDjOzu7yc6w1vq0LRi2+vGU4PN5asby39U9p9
 I5vg==
X-Gm-Message-State: AOJu0YwuHTwjcmN3J9zMDRrDqICAHKdbARQ1wBbw++MCsB4oB1jEwKY8
 OCS6U71WeL1RqFKQzcWu1TeKqA==
X-Google-Smtp-Source: AGHT+IF27VLeipk+KQqBaMxXcyJ/ywFX0hCUzBYcKBrmbHlLK3+JCfTN5CKjjRroUdtxCW05N3hJWw==
X-Received: by 2002:a2e:2ac5:0:b0:2c9:9837:4d7b with SMTP id
 q188-20020a2e2ac5000000b002c998374d7bmr7482066ljq.4.1701194760502; 
 Tue, 28 Nov 2023 10:06:00 -0800 (PST)
Received: from [192.168.174.227] ([91.223.100.55])
 by smtp.gmail.com with ESMTPSA id
 a27-20020a2ebe9b000000b002bcdbfe36a1sm1760596ljr.84.2023.11.28.10.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 10:06:00 -0800 (PST)
Message-ID: <d071f147-5d5b-457e-aeb6-9f77868245b9@linaro.org>
Date: Tue, 28 Nov 2023 12:05:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.1 v6 14/17] accel/tcg: Move breakpoint recognition
 outside translation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 peter.maydell@linaro.org
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org,
 mark.cave-ayland@ilande.co.uk, Max Filippov <jcmvbkbc@gmail.com>
References: <20210720195439.626594-1-richard.henderson@linaro.org>
 <20210720195439.626594-15-richard.henderson@linaro.org>
 <7a6efb0c-62fb-4047-a20a-261ebb8c99ac@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7a6efb0c-62fb-4047-a20a-261ebb8c99ac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22a.google.com
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

On 11/28/23 05:08, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 20/7/21 21:54, Richard Henderson wrote:
>> Trigger breakpoints before beginning translation of a TB
>> that would begin with a BP.  Thus we never generate code
>> for the BP at all.
>>
>> Single-step instructions within a page containing a BP so
>> that we are sure to check each insn for the BP as above.
>>
>> We no longer need to flush any TBs when changing BPs.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/286
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/404
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/489
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/cpu-exec.c   | 91 ++++++++++++++++++++++++++++++++++++++++--
>>   accel/tcg/translator.c | 24 +----------
>>   cpu.c                  | 20 ----------
>>   3 files changed, 89 insertions(+), 46 deletions(-)
> 
> 
>> diff --git a/cpu.c b/cpu.c
>> index 91d9e38acb..d6ae5ae581 100644
>> --- a/cpu.c
>> +++ b/cpu.c
>> @@ -225,11 +225,6 @@ void tb_invalidate_phys_addr(target_ulong addr)
>>       tb_invalidate_phys_page_range(addr, addr + 1);
>>       mmap_unlock();
>>   }
>> -
>> -static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
>> -{
>> -    tb_invalidate_phys_addr(pc);
>> -}
> 
> This patch removed the last use of tb_invalidate_phys_addr() in
> user emulation:
> 
>    void tb_invalidate_phys_addr(hwaddr addr)
>    {
>        mmap_lock();
>        tb_invalidate_phys_page(addr);
>        mmap_unlock();
>    }
> 
> Do we still need it?

Probably not.

> (In sysemu there is a single use in Xtensa tb_invalidate_virtual_addr).

I suspect that should be migrated to use the common HW breakpoint support.


r~


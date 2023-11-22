Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E517F4CDC
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 17:40:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5qFu-0000LS-NQ; Wed, 22 Nov 2023 11:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r5qFh-0000Kd-Ad
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 11:39:02 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r5qFc-0007hl-Vm
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 11:38:58 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6d7e6df999fso931616a34.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 08:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700671135; x=1701275935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WQcbwDTe97fNlo5xdHqcwZvJlfpmp31ZQBpEUtLX+Z8=;
 b=Yx7sGgNSXpwajLzI1ozzzsRklVLRqs1Z3n0e6ngYg1ayb9MCwjkI0QPCPNU+KbCKu4
 4L8feve96Vf92VRNEb/aolCc0MQLcuDPe9zHPhe2V5nz4/q6t1bcv+Sx9320ZtD0vzzw
 +KkGSOtmcXMGBQU7EbZ7u7EcUw5gjP+AjM2SsT79ZPsAvhuBxbdD8KnArcV5P1q1Ql5K
 ssQfoblm8VewWJ1JeGPBrTZ3N3g6TI9gKD4otbOcO+dF+0gtivqmlWHdw5QQs216IBcI
 1IFAwmBl6TzmFnt9Mw8IAjmc/scECgHcba/qxgY3l9s9XDHKpudGtRtGruVRl3oWCwXw
 wJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700671135; x=1701275935;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WQcbwDTe97fNlo5xdHqcwZvJlfpmp31ZQBpEUtLX+Z8=;
 b=UpUT1k0XiFMh+uc1XT8gyJ5UqmmG2I7Y74/rvJVfrrDWiIgHB88qPK7F4D2by/+Jsd
 QNcYSZnNFsbGvoVbxY2saAJUzx8rVBUPjMcsYuVbm6lm0gQN0FwwmZRlA+I0Ci70aYA/
 MruSDM8AbKTGn05EuXWYM6HfZ46Nd4gW7z/1wryMRlTun/3mAjiHNARIfvlWa3hPGDnW
 kjdS3ddSCoGr/4AXGc97/gKyYBU5vThbD2Kw+4U8yOSc79t+9X87ts4wKb5fReXtg2uX
 km3z6ba1eLo8R5LpfqnuLXfI07oj1teN3MGCPSY8Zducw93r+26ptgryYua5irHxIvAx
 1TpQ==
X-Gm-Message-State: AOJu0Yx7KzfTDaOjXeDOt7oZHtJN4IghARI6FdFyYFwwpBbffxFJSYHg
 nhDpEwZiEqaT710IEdqIwSE8r4mSxM/N+HE4miiQGNXe
X-Google-Smtp-Source: AGHT+IFnwKZe4FLvxAwXi1ojSnXooG/GSNlkCGafDtrCe0iCFuoubSwIKG9Yhkfc2kiCUrwSYanDbw==
X-Received: by 2002:a05:6830:328b:b0:6bc:a68b:ca44 with SMTP id
 m11-20020a056830328b00b006bca68bca44mr2988506ott.6.1700671135041; 
 Wed, 22 Nov 2023 08:38:55 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a9d6543000000b006cd09ba046fsm1922080otl.61.2023.11.22.08.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 08:38:54 -0800 (PST)
Message-ID: <0930062d-5aba-4e4c-be56-3c358ec125ba@linaro.org>
Date: Wed, 22 Nov 2023 10:38:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: kvm64: remove a redundant
 KVM_CAP_SET_GUEST_DEBUG probe
To: Chao Du <duchao@eswincomputing.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
References: <20231025070726.22689-1-duchao@eswincomputing.com>
 <3c895935.1233.18bf6196456.Coremail.duchao@eswincomputing.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3c895935.1233.18bf6196456.Coremail.duchao@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/22/23 02:15, Chao Du wrote:
> Hi,
> 
> Kindly ping. :)
> 
> Thanks,
> Chao
> 
> 
>> -----Original Messages-----From:"Chao Du" <duchao@eswincomputing.com>Sent Time:2023-10-25 15:07:26 (Wednesday)To:qemu-devel@nongnu.org, qemu-arm@nongnu.orgCc:Subject:[PATCH] target/arm: kvm64: remove a redundant KVM_CAP_SET_GUEST_DEBUG probe
>>
>> The KVM_CAP_SET_GUEST_DEBUG is probed during kvm_init().
>> gdbserver will fail to start if the CAP is not supported.
>> So no need to make another probe here, like other targets.
>>
>> Signed-off-by: Chao Du <duchao@eswincomputing.com>

Correct: all handled by kvm_supports_guest_debug.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


>> ---
>>   target/arm/kvm64.c | 28 +++++++---------------------
>>   1 file changed, 7 insertions(+), 21 deletions(-)
>>
>> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
>> index 4bb68646e4..b0bf59b5a1 100644
>> --- a/target/arm/kvm64.c
>> +++ b/target/arm/kvm64.c
>> @@ -31,13 +31,9 @@
>>   #include "hw/acpi/acpi.h"
>>   #include "hw/acpi/ghes.h"
>>   
>> -static bool have_guest_debug;
>>   
>>   void kvm_arm_init_debug(KVMState *s)
>>   {
>> -    have_guest_debug = kvm_check_extension(s,
>> -                                           KVM_CAP_SET_GUEST_DEBUG);
>> -
>>       max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
>>       hw_watchpoints = g_array_sized_new(true, true,
>>                                          sizeof(HWWatchpoint), max_hw_wps);
>> @@ -1140,33 +1136,23 @@ static const uint32_t brk_insn = 0xd4200000;
>>   
>>   int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>>   {
>> -    if (have_guest_debug) {
>> -        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
>> -            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1)) {
>> -            return -EINVAL;
>> -        }
>> -        return 0;
>> -    } else {
>> -        error_report("guest debug not supported on this kernel");
>> +    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
>> +        cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1)) {
>>           return -EINVAL;
>>       }
>> +    return 0;
>>   }
>>   
>>   int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>>   {
>>       static uint32_t brk;
>>   
>> -    if (have_guest_debug) {
>> -        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk, 4, 0) ||
>> -            brk != brk_insn ||
>> -            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
>> -            return -EINVAL;
>> -        }
>> -        return 0;
>> -    } else {
>> -        error_report("guest debug not supported on this kernel");
>> +    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk, 4, 0) ||
>> +        brk != brk_insn ||
>> +        cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
>>           return -EINVAL;
>>       }
>> +    return 0;
>>   }
>>   
>>   /* See v8 ARM ARM D7.2.27 ESR_ELx, Exception Syndrome Register
>> -- 
>> 2.17.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D447FB228
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 07:53:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7rxi-0001Pm-1V; Tue, 28 Nov 2023 01:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7rxg-0001PU-4z
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 01:52:48 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7rxP-0000jv-IS
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 01:52:47 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-332f4ad27d4so1967041f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 22:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701154349; x=1701759149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M3ZE7shiFCKoUO81T1KiXdBLdPBJ/Fr7IoSteLYqKeQ=;
 b=yuRBvrwhXE07tkr8omP4qP/kOhKFKqIIEhLlcd5Yn7r5ocGtglNhdsozmCFikPpQxU
 rkxFjbdvGtzbJUN/oaz5MZK4xwqlsC1ziyb0Q7rnJxnRyM7UTO1lMD2onB1x0eq8KXr4
 SbzBztnRKBORG3QuJrWXekcIRhM/tW0xcbKwMK38OPjt5q9qx3mMeA+B0z23dC+Cc2aU
 FjLsBZPT6UaOvfZGP/0LYD6D7hY79SPKhg3Q2JwiTreZpFgsdDZEfMSM5BEDT0RyFONe
 mal+hdMrl1NZPVPPrOzBhj0oMWFKfX/H4YSsyaaxxDMkYIo1T9zZCI+uew75jXNbMusL
 H+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701154349; x=1701759149;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M3ZE7shiFCKoUO81T1KiXdBLdPBJ/Fr7IoSteLYqKeQ=;
 b=a1lH9kiWugT5kzPqN+DpT5PHzb/KVMcmIDVHs+8wnluLAhSJtFUjxwL/u96+DNxvSK
 4ysdwpAKjlT8AXcJpLHRuDbp8uv5hqjPEibUSfGOHtqpDsCc7O8DFGstCekwJGMZ2fnC
 zd3b/HolqicD7w9SV2S4f/x6o/uYB00yuIO3UQOy6HJdIQkbRTGY+HGQbPfg1p/3ruwH
 FbvDILWll0K8PnEddykb0kXVPHA9lwLcQzfK9N1juUBSkrPHiWcHtvm+GD0+2pXuOaTi
 X28SxhQb4IUGAyNIBOGVHc2YJJorkcSB5kIixcN0uiMWjBo2vMgfmNOPbq2SZ5k28fyM
 CbFw==
X-Gm-Message-State: AOJu0YwJMlNHLZS5B49lildyFFm+yINFHiteUvnLbRXGzAi6J3BtBLoI
 4RvKL9UPfdz9p5WumV170Qj8UQ==
X-Google-Smtp-Source: AGHT+IGuBI5Ir68gSS9m/agiw7rdbLSrem/4hA3OK9LF7GGhl3jZpLVFyloG3UPXARlKPc7xheDh0g==
X-Received: by 2002:a5d:488f:0:b0:333:19b:d317 with SMTP id
 g15-20020a5d488f000000b00333019bd317mr3255424wrq.52.1701154349359; 
 Mon, 27 Nov 2023 22:52:29 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 w27-20020adf8bdb000000b00332e5624a31sm13406545wra.84.2023.11.27.22.52.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 22:52:29 -0800 (PST)
Message-ID: <49b491fa-0aa7-43d7-9bb7-ffd9a5172191@linaro.org>
Date: Tue, 28 Nov 2023 07:52:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 05/16] target/arm/kvm: Have kvm_arm_sve_get_vls
 take a ARMCPU argument
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-6-philmd@linaro.org>
 <54a38178-18ca-4bea-9d5d-af34114dda5b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <54a38178-18ca-4bea-9d5d-af34114dda5b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Gavin,

On 27/11/23 05:12, Gavin Shan wrote:
> Hi Phil,
> 
> On 11/24/23 05:35, Philippe Mathieu-Daudé wrote:
>> Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
>> take a ARMCPU* argument. Use the CPU() QOM cast macro When
>> calling the generic vCPU API from "sysemu/kvm.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/kvm_arm.h | 6 +++---
>>   target/arm/cpu64.c   | 2 +-
>>   target/arm/kvm.c     | 2 +-
>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
>> index 6fb8a5f67e..84f87f5ed7 100644
>> --- a/target/arm/kvm_arm.h
>> +++ b/target/arm/kvm_arm.h
>> @@ -129,13 +129,13 @@ void kvm_arm_destroy_scratch_host_vcpu(int 
>> *fdarray);
>>   /**
>>    * kvm_arm_sve_get_vls:
>> - * @cs: CPUState
>> + * @cpu: ARMCPU
>>    *
>>    * Get all the SVE vector lengths supported by the KVM host, setting
>>    * the bits corresponding to their length in quadwords minus one
>>    * (vq - 1) up to ARM_MAX_VQ.  Return the resulting map.
>>    */
>> -uint32_t kvm_arm_sve_get_vls(CPUState *cs);
>> +uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu);
> 
> Either @cs or @cpu isn't dereferenced in kvm_arm_sve_get_vls(). So I guess
> the argument can be simply droped?

If KVM eventually supports heterogeneous vCPUs such big.LITTLE, we'd
de-reference. But then we'd have a major rework of the code.

Peter, do you have a preference?

Thanks,

Phil.


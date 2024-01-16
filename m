Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F057B82FA2D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 22:26:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPqvm-0002Ak-AH; Tue, 16 Jan 2024 16:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPqvi-0002AV-MD
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 16:25:06 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPqvf-00045a-Sl
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 16:25:06 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-559b3ee02adso1250546a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 13:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705440302; x=1706045102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZN3rSoSrU0V0ck0j3mERKVXOmSU7KwpwWf+gkqOG714=;
 b=QQZPGL64inmefghCNylVyAyACMIbp7OXrlltJOGrt5oZWLkJ/01CkZTYJbvt/zx+8+
 rP3dqx25g/YpJzsAp/9ZpEAd5QskQtc43j9KS89q7z73Kds87o0IIGjn3omE+gjvoThd
 tRwknRUzHwOG3yk3P41tnvb1/rGdxYQ2/25iUdI440dTTCgZquPZC1dlAX199Hc/2E0z
 piI2JFfWSr4wmmqweCtP7iT/6GKrQuW0ZaNp4JLZC/6IolBVdIuScl3NS39GVeKM/+Nz
 NOKcTdGL5kqUPYdVF0HawX2qqzW33Dn9ek+E+dVOXel4jyzaRNuT2j7Pt3QqUgRLKmFZ
 J/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705440302; x=1706045102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZN3rSoSrU0V0ck0j3mERKVXOmSU7KwpwWf+gkqOG714=;
 b=mWh8QN/mYf+TWfYtjklpgXZjym1xJausogA2c6vHoLoaJ+j9QmsiGKDpdO/tXnW0Ra
 UFqVXI/Z0FKr48FWQSU1nb6ainfL+z7qhtUWpBpwNfHt9RfTS9Et5pb9nBqtIkXPL2qG
 MfSKjHSh8q9eIBFcT+wBKUMYk1pOd2NUwXp4xQv6zp3klvOB1dImq6eQy0jzfzyvpeMx
 8APH5+I0OD0NBPHd7dnNeaf8SxX/R3OET8w8izvr55H+hlXPraoUIhfT5QwPjgZ7sccS
 LO8a0SgSyxT32Jq/Jz0Z127GmtwYQK7UFdzpx6q2JENwPTZ0kj/CPrrtSf6anpc+fSO1
 s5yA==
X-Gm-Message-State: AOJu0YwQSqAJcZKAr4INetT8s7a2uRthYHRSmj6W/+CRyZnX+A6CpaUO
 45PbT7MkCW3FDda/o6Lz3V2za7Z8Iod5xw==
X-Google-Smtp-Source: AGHT+IEDlw9MPQzSdcVoslf9gA/QzgnvDUvpiGEyz2CDoV5J1bcF6E9Z/d+JqTkiMfdkBYk6eiF8aA==
X-Received: by 2002:aa7:c59a:0:b0:558:cd71:eed9 with SMTP id
 g26-20020aa7c59a000000b00558cd71eed9mr2680586edq.90.1705440301985; 
 Tue, 16 Jan 2024 13:25:01 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 ck4-20020a0564021c0400b00559cad6fc46sm282746edb.49.2024.01.16.13.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 13:25:01 -0800 (PST)
Message-ID: <b15f4eab-f4aa-4007-81b0-4a710af80a98@linaro.org>
Date: Tue, 16 Jan 2024 22:24:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel: Do not set CPUState::can_do_io in non-TCG accels
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, kvm@vger.kernel.org
References: <20231129205037.16849-1-philmd@linaro.org>
 <768e7409-62a7-441c-960d-dc99ab89c7d0@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <768e7409-62a7-441c-960d-dc99ab89c7d0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 30/11/23 14:51, Richard Henderson wrote:
> On 11/29/23 14:50, Philippe Mathieu-Daudé wrote:
>> 'can_do_io' is specific to TCG. Having it set in non-TCG
>> code is confusing, so remove it from QTest / HVF / KVM.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/dummy-cpus.c        | 1 -
>>   accel/hvf/hvf-accel-ops.c | 1 -
>>   accel/kvm/kvm-accel-ops.c | 1 -
>>   3 files changed, 3 deletions(-)
>>
>> diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
>> index b75c919ac3..1005ec6f56 100644
>> --- a/accel/dummy-cpus.c
>> +++ b/accel/dummy-cpus.c
>> @@ -27,7 +27,6 @@ static void *dummy_cpu_thread_fn(void *arg)
>>       qemu_mutex_lock_iothread();
>>       qemu_thread_get_self(cpu->thread);
>>       cpu->thread_id = qemu_get_thread_id();
>> -    cpu->neg.can_do_io = true;
>>       current_cpu = cpu;
> 
> I expect this is ok...
> 
> When I was moving this variable around just recently, 464dacf6, I 
> wondered about these other settings, and I wondered if they used to be 
> required for implementing some i/o on behalf of hw accel.  Something 
> that has now been factored out to e.g. kvm_handle_io, which now uses 
> address_space_rw directly.

It was added by mistake in commit 99df7dce8a ("cpu: Move can_do_io
field from CPU_COMMON to CPUState", 2013) to cpu_common_reset() and
commit 626cf8f4c6 ("icount: set can_do_io outside TB execution", 2014),
then moved in commits 57038a92bb ("cpus: extract out kvm-specific code
to accel/kvm"), b86f59c715 ("accel: replace struct CpusAccel with
AccelOpsClass") and the one you mentioned, 464dacf609 ("accel/tcg: Move
can_do_io to CPUNegativeOffsetState").

The culprit is 626cf8f4c6 I guess, so maybe:
Fixes: 626cf8f4c6 ("icount: set can_do_io outside TB execution")

> I see 3 reads of can_do_io: accel/tcg/{cputlb.c, icount-common.c} and 
> system/watchpoint.c.  The final one is nested within 
> replay_running_debug(), which implies icount and tcg.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


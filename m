Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ADD8079CE
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 21:50:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAypC-0004av-RA; Wed, 06 Dec 2023 15:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAyp9-0004aV-EC
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 15:48:51 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAyp7-00089a-Ix
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 15:48:51 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40c09f4bea8so2418055e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 12:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701895727; x=1702500527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gkBAo4eEPeBIDXS2d9zo2gYh3GC0wek0p9HOoIw3/pc=;
 b=lwS2kw5GlxOplIenEe5XMFT4qB0uXMpgE10oF7uXXResHEkhKBZHX335ytSWzWwlr7
 aGmf/N7H0eU8XeZM2Mv6vVnaWgfReuKphscGixy2a+0FYqq7deurrthgGDKfsIGO2ds6
 TMX8nlucaubJLlDgzjVUKYkHRdptOMbiclhPTafIoVmjvsVVIivdOOnKYViyxLnpERhR
 NEWfGKhJEi+66qf0htAsfZQxzayv2FFEhJKMJ7QMMfra7ZCp3D5wct7LqQzi43jcjWUL
 7olvngd+kG511ZqVvihQBlYF3aRcGPEoRoAWxkYxX1pAoHbCc+96uGaLpg+o2pb9PgNc
 g0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701895727; x=1702500527;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gkBAo4eEPeBIDXS2d9zo2gYh3GC0wek0p9HOoIw3/pc=;
 b=UKcQmLFzh4eQp6CrZ7PcOYpasVgNMXJYIbildvrW2pnCEJi9Ncttq/wZthQcd+saln
 0pYSiJmxRUYDVuiKMe6OaU1BehKePYrgvZp8Y3689xCUctYg/YXIZDpu2L08Uwbl51Bh
 vsYPeGW6ImdVKpiuL7t9kvOWx0CJ0H/zFqanLbDXe8gVxP1NvboDjcoq0zzx/hBfEk+s
 qWGXTMQQk/SKzU7u7UDPLwKKOTxKMTx0HWWRCzdhcNfGn/dfib5J4zxKKChf9xgBphg2
 YzUgyqeDguRH1f1TMqscgEss7EdHJj5Woc6m+47nL3K2BARu+ac4JGUaMI+9eMV1y4Gl
 B4qQ==
X-Gm-Message-State: AOJu0YysKxFiZo+aofq5ad9stJoJ3jv5PeE2I/Aca3j6I1C5BvfO2u/n
 It6i0/XlU60JVlZD4cMTcE01KQ==
X-Google-Smtp-Source: AGHT+IFkck4CMIVPXtzfrgjqLlNLzJPEQrdGaBcZimQ+hmTVmtBB7TdPcz5spR14nnFya0Ftf0rwNA==
X-Received: by 2002:a05:600c:331b:b0:40b:5e59:da78 with SMTP id
 q27-20020a05600c331b00b0040b5e59da78mr921139wmp.139.1701895727217; 
 Wed, 06 Dec 2023 12:48:47 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a05600c46c800b0040b347d90d0sm807114wmo.12.2023.12.06.12.48.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 12:48:46 -0800 (PST)
Message-ID: <5ffd8414-c326-436e-9009-ec5fa570070f@linaro.org>
Date: Wed, 6 Dec 2023 21:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 02/12] cpus: stop vm in suspended runstate
Content-Language: en-US
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <1701883417-356268-3-git-send-email-steven.sistare@oracle.com>
 <2d6e4dec-bb04-46ea-bfa8-7006d8cc6dda@linaro.org>
 <a4ba60ff-be9e-4380-ab91-5b85e690c1d8@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a4ba60ff-be9e-4380-ab91-5b85e690c1d8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 6/12/23 20:19, Steven Sistare wrote:
> On 12/6/2023 1:45 PM, Philippe Mathieu-Daudé wrote:
>> Hi Steve,
>>
>> On 6/12/23 18:23, Steve Sistare wrote:
>>> Currently, a vm in the suspended state is not completely stopped.  The VCPUs
>>> have been paused, but the cpu clock still runs, and runstate notifiers for
>>> the transition to stopped have not been called.  This causes problems for
>>> live migration.  Stale cpu timers_state is saved to the migration stream,
>>> causing time errors in the guest when it wakes from suspend, and state that
>>> would have been modified by runstate notifiers is wrong.
>>>
>>> Modify vm_stop to completely stop the vm if the current state is suspended,
>>> transition to RUN_STATE_PAUSED, and remember that the machine was suspended.
>>> Modify vm_start to restore the suspended state.
>>>
>>> This affects all callers of vm_stop and vm_start, notably, the qapi stop and
>>> cont commands.  For example:
>>>
>>>       (qemu) info status
>>>       VM status: paused (suspended)
>>>
>>>       (qemu) stop
>>>       (qemu) info status
>>>       VM status: paused
>>>
>>>       (qemu) system_wakeup
>>>       Error: Unable to wake up: guest is not in suspended state
>>>
>>>       (qemu) cont
>>>       (qemu) info status
>>>       VM status: paused (suspended)
>>>
>>>       (qemu) system_wakeup
>>>       (qemu) info status
>>>       VM status: running
>>>
>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    include/sysemu/runstate.h |  5 +++++
>>>    qapi/misc.json            | 10 ++++++++--
>>>    system/cpus.c             | 23 +++++++++++++++--------
>>>    system/runstate.c         |  3 +++
>>>    4 files changed, 31 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
>>> index 88a67e2..867e53c 100644
>>> --- a/include/sysemu/runstate.h
>>> +++ b/include/sysemu/runstate.h
>>> @@ -40,6 +40,11 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>>>        return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
>>>    }
>>>    +static inline bool runstate_is_live(RunState state)
>>> +{
>>> +    return state == RUN_STATE_RUNNING || state == RUN_STATE_SUSPENDED;
>>> +}
>>
>> Not being familiar with (live) migration, from a generic vCPU PoV
>> I don't get what "runstate_is_live" means. Can we add a comment
>> explaining what this helper is for?
> 
> Sure.  "live" means the cpu clock is ticking, and the runstate notifiers think
> we are running.  It is everything that is enabled in vm_start except for starting
> the vcpus.
> 
>> Since this is a migration particular case, maybe we can be verbose
>> in vm_resume() and keep runstate_is_live() -- eventually undocumented
>> -- in migration/migration.c.
> 
> runstate_is_live is about cpu and vm state, not migration state (the "live" is not
> live migration), and is used in multiple places in cpus code and elsewhere, so I would
> like to keep it in runstate.h.  It has a specific meaning, and it is useful to search
> for it to see who handles "liveness", and distinguish it from code that checks the
> running and suspended states for other reasons.

OK then, no objection, but please add a comment describing.

Thanks,

Phil.


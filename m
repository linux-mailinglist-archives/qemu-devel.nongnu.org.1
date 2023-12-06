Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74641807A2D
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 22:11:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAz9L-0001ua-A3; Wed, 06 Dec 2023 16:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAz9H-0001uR-3e
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 16:09:39 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAz9F-0004oT-BP
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 16:09:38 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3316a4bc37dso213800f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 13:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701896976; x=1702501776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o1Wc4l7WiLxy13ca9loOZZhx27fnVUY7OfFLYxJ5q1w=;
 b=LEgnZU58XKhQ4PNIiGgGFUqjr7r2u6NiEZdaZ5TXTokXhaOC/bmwMFCdLlqTX0x8Kq
 6R4l7uPtzXYUmHAfElv3oh7liM8Nlw7UupZ2GXpM1L3oZblJYmNmzFDkigjpN/Ni+6nD
 gIetdMIlPOz/KYSrd9neKoIiwOmSvQiRzA5L3GJY3DiT+BYk6ek8CKB6sYnm9lRw8Seq
 Djo9lzXGIDaJcTrgPnfbUmOgAqsEbzGlOBqYq7/eBrwVV388wvsfmQDWupGGBYIRa8m/
 AGPqRZx0Hd4PJDyhx7HyBkFt5DFVS5j/ftI+UrKX3Wy74u0rZ+/GrA6lSGamnXiYAKTt
 n64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701896976; x=1702501776;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o1Wc4l7WiLxy13ca9loOZZhx27fnVUY7OfFLYxJ5q1w=;
 b=HfhHX3XSQLEcgMfvArBYpMXH7I3EzcagCjLfnXyh0qT6dmyEgjGxpYO7tJj/gJRZqx
 J2mjTgVkZ85DaieHxuApwhN7vj/Ni0KvV3OFOfugq40TrcZ/qTD70inN64tBZ771Mvzc
 UZWuQFHzbR707DMbWzf2gEBlh/Vh4qllnJYlFef6LaVzQJmyZdPinHxbNZjDi6mRYOC0
 2QIFrirL5bEgpMshaJXYa3TmkQoiQrOg8NhqZdx1egNHHlR//Zrq7uHkfLvzqWm/BXmJ
 BYqdPwYt6IxrCUwd+5dyqLMAANTGeIbdQujPVipMhYgRV6izgRaDXElQcXmCGO1dQIE8
 if8g==
X-Gm-Message-State: AOJu0YyeuN6s42UBEbZepRVYQAaVFY6sbeprJMKf9giGTi7bdeE2x1MJ
 39HhvlUvsQgd03yOb3p3f9QT0g==
X-Google-Smtp-Source: AGHT+IEic4Kzetqdjh464seU7hN7mV9qr2QtGUWObNePOydrOaL+eHu38C73gtgx0cGS+jOOeTm2kQ==
X-Received: by 2002:a5d:50d2:0:b0:333:2fd2:4b04 with SMTP id
 f18-20020a5d50d2000000b003332fd24b04mr951541wrt.128.1701896975814; 
 Wed, 06 Dec 2023 13:09:35 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d6789000000b0033331f83907sm561644wru.65.2023.12.06.13.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 13:09:35 -0800 (PST)
Message-ID: <db299749-3aa0-45d4-808c-1002fa75704d@linaro.org>
Date: Wed, 6 Dec 2023 22:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 02/12] cpus: stop vm in suspended runstate
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <1701883417-356268-3-git-send-email-steven.sistare@oracle.com>
 <2d6e4dec-bb04-46ea-bfa8-7006d8cc6dda@linaro.org>
 <a4ba60ff-be9e-4380-ab91-5b85e690c1d8@oracle.com>
 <5ffd8414-c326-436e-9009-ec5fa570070f@linaro.org>
In-Reply-To: <5ffd8414-c326-436e-9009-ec5fa570070f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 6/12/23 21:48, Philippe Mathieu-Daudé wrote:
> On 6/12/23 20:19, Steven Sistare wrote:
>> On 12/6/2023 1:45 PM, Philippe Mathieu-Daudé wrote:
>>> Hi Steve,
>>>
>>> On 6/12/23 18:23, Steve Sistare wrote:
>>>> Currently, a vm in the suspended state is not completely stopped.  
>>>> The VCPUs
>>>> have been paused, but the cpu clock still runs, and runstate 
>>>> notifiers for
>>>> the transition to stopped have not been called.  This causes 
>>>> problems for
>>>> live migration.  Stale cpu timers_state is saved to the migration 
>>>> stream,
>>>> causing time errors in the guest when it wakes from suspend, and 
>>>> state that
>>>> would have been modified by runstate notifiers is wrong.
>>>>
>>>> Modify vm_stop to completely stop the vm if the current state is 
>>>> suspended,
>>>> transition to RUN_STATE_PAUSED, and remember that the machine was 
>>>> suspended.
>>>> Modify vm_start to restore the suspended state.
>>>>
>>>> This affects all callers of vm_stop and vm_start, notably, the qapi 
>>>> stop and
>>>> cont commands.  For example:
>>>>
>>>>       (qemu) info status
>>>>       VM status: paused (suspended)
>>>>
>>>>       (qemu) stop
>>>>       (qemu) info status
>>>>       VM status: paused
>>>>
>>>>       (qemu) system_wakeup
>>>>       Error: Unable to wake up: guest is not in suspended state
>>>>
>>>>       (qemu) cont
>>>>       (qemu) info status
>>>>       VM status: paused (suspended)
>>>>
>>>>       (qemu) system_wakeup
>>>>       (qemu) info status
>>>>       VM status: running
>>>>
>>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>> ---
>>>>    include/sysemu/runstate.h |  5 +++++
>>>>    qapi/misc.json            | 10 ++++++++--
>>>>    system/cpus.c             | 23 +++++++++++++++--------
>>>>    system/runstate.c         |  3 +++
>>>>    4 files changed, 31 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
>>>> index 88a67e2..867e53c 100644
>>>> --- a/include/sysemu/runstate.h
>>>> +++ b/include/sysemu/runstate.h
>>>> @@ -40,6 +40,11 @@ static inline bool 
>>>> shutdown_caused_by_guest(ShutdownCause cause)
>>>>        return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
>>>>    }
>>>>    +static inline bool runstate_is_live(RunState state)
>>>> +{
>>>> +    return state == RUN_STATE_RUNNING || state == RUN_STATE_SUSPENDED;
>>>> +}
>>>
>>> Not being familiar with (live) migration, from a generic vCPU PoV
>>> I don't get what "runstate_is_live" means. Can we add a comment
>>> explaining what this helper is for?
>>
>> Sure.  "live" means the cpu clock is ticking, and the runstate 
>> notifiers think
>> we are running.  It is everything that is enabled in vm_start except 
>> for starting
>> the vcpus.

What about runstate_is_vcpu_clock_ticking() then?

>>> Since this is a migration particular case, maybe we can be verbose
>>> in vm_resume() and keep runstate_is_live() -- eventually undocumented
>>> -- in migration/migration.c.
>>
>> runstate_is_live is about cpu and vm state, not migration state (the 
>> "live" is not
>> live migration), and is used in multiple places in cpus code and 
>> elsewhere, so I would
>> like to keep it in runstate.h.  It has a specific meaning, and it is 
>> useful to search
>> for it to see who handles "liveness", and distinguish it from code 
>> that checks the
>> running and suspended states for other reasons.
> 
> OK then, no objection, but please add a comment describing.
> 
> Thanks,
> 
> Phil.



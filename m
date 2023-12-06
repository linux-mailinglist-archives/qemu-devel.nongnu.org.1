Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBC8075AF
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:49:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAv4R-0005FD-GV; Wed, 06 Dec 2023 11:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAv4P-0005Ep-RB
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:48:21 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAv4O-0005Nk-4C
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:48:21 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ce939ecfc2so11847b3a.2
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701881299; x=1702486099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vWOFMaDd6oLi0Vwgj/NGKj9NcMsrHwtJA26zHK/u/Mg=;
 b=oZEFKNKsiZIzh3W7Ls7XFSblEHETSqI6mWV8S7iKQASOE2LRo+SuBe2gbGXYnT537d
 yl1076sjW4IKzI8AcfX0YH2YVShTq7XGS/fygJMxxxf31SsqzcDs+9aQR0XABn3IXgfo
 bZu6Gk9bGsmz33TPNO9yaAmmNuBjDc1UehQPoMfgSGVP0cfwM+9Dx8Je8ASqI5QqsoMq
 iES49um6drerC4SM5+207QVNPfW4lIqrdLJiXllvG0XqN4Ub0aTBChMf1Az+IkqEkxAO
 HZ79HfKyLl/Ce58qFUjaJJ5QTqRZJqzEujyh42gK8osSX57amaGZm0wnyE8y3+nqmdRa
 WK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701881299; x=1702486099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vWOFMaDd6oLi0Vwgj/NGKj9NcMsrHwtJA26zHK/u/Mg=;
 b=eFRPmy6RJQWXDdEA3JICR+pV3iHBk+P/kOyqZvQVoE1DpuzBS/bIteWG4FPRV734g+
 DRTPEA7r9qAb6xtxfmi5jQ5oWYaM1HB6Rqb/09MtPMQdx6Dl6wXPdaSfnLOKPUYDvCPa
 fCvUhnFu3H/e2oWZFLYHI3h88lsQh8MmDCQYt3meH4pTBMvq5fH7pZkXVdYsceN88/fF
 OmCQGkHtQ1/t9eq44vrbfX/3movJp1zEZNgDsaULMhelqib/t7ZNnBsY8kjZvUTvniYc
 vYQoOl0IS0n4UO2nXxhkIqik+dHNUfScidQy9fEaOZjTEd4nO0u5k0JQc2GENcftbM8a
 A6aA==
X-Gm-Message-State: AOJu0Yx4vC02IhFw8PH90UJ/YZxDTrJ+cjmgrIgr3Uvi/VeRKCtaktdx
 wK9JG5nv8o1OMtvU3g+zFUxxTQ==
X-Google-Smtp-Source: AGHT+IEo7uIOHH3ix0I7E90dTvg1tpiJei2wYAEPleL7Mbcu5lszV4msPpq5hpT0uZ5VXp0OgFv0tg==
X-Received: by 2002:a05:6a20:d406:b0:18c:43f4:3d44 with SMTP id
 il6-20020a056a20d40600b0018c43f43d44mr1145776pzb.25.1701881298708; 
 Wed, 06 Dec 2023 08:48:18 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 n33-20020a056a000d6100b006ce65bf5376sm208446pfv.75.2023.12.06.08.48.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 08:48:18 -0800 (PST)
Message-ID: <43f2e50a-1d84-4402-b30c-a5b865cd4e49@linaro.org>
Date: Wed, 6 Dec 2023 08:48:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] replay: introduce a central report point for sync
 errors
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-9-alex.bennee@linaro.org>
 <3536aaa0-a6c6-4db0-bf84-3218ee9e22f1@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3536aaa0-a6c6-4db0-bf84-3218ee9e22f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 12/6/23 03:35, Philippe Mathieu-Daudé wrote:
> Hi Alex,
> 
> On 5/12/23 21:41, Alex Bennée wrote:
>> Figuring out why replay has failed is tricky at the best of times.
>> Lets centralise the reporting of a replay sync error and add a little
>> bit of extra information to help with debugging.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   replay/replay-internal.h | 12 ++++++++++++
>>   replay/replay-char.c     |  6 ++----
>>   replay/replay-internal.c |  1 +
>>   replay/replay.c          |  9 +++++++++
>>   4 files changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
>> index 1bc8fd5086..709e2eb4cb 100644
>> --- a/replay/replay-internal.h
>> +++ b/replay/replay-internal.h
>> @@ -74,6 +74,7 @@ enum ReplayEvents {
>>    * @cached_clock: Cached clocks values
>>    * @current_icount: number of processed instructions
>>    * @instruction_count: number of instructions until next event
>> + * @current_event: current event index
>>    * @data_kind: current event
>>    * @has_unread_data: true if event not yet processed
>>    * @file_offset: offset into replay log at replay snapshot
>> @@ -84,6 +85,7 @@ typedef struct ReplayState {
>>       int64_t cached_clock[REPLAY_CLOCK_COUNT];
>>       uint64_t current_icount;
>>       int instruction_count;
>> +    unsigned int current_event;
>>       unsigned int data_kind;
>>       bool has_unread_data;
>>       uint64_t file_offset;
> Shouldn't this field be migrated?

No, it's for diagnostic use only.


r~



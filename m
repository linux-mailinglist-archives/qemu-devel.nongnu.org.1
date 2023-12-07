Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F27D80837F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 09:47:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBA1H-0006M1-0b; Thu, 07 Dec 2023 03:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rBA0t-0006LH-9l
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:45:43 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rBA0p-0007Lo-LF
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:45:41 -0500
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 7221B40737A7;
 Thu,  7 Dec 2023 08:45:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7221B40737A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1701938736;
 bh=+F8OW+MU1FdUNPQzqm6b/MIgRUByvpc9mpYsD/NJeS4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sgl2xDQ000x3rDRhSI+7OqaJj+2+D9mxiXdxONxsiZLN4Q/GRtNk/r8hbRPjE3CgK
 PzivJvWiFplaFYryiCoYDVIBXKIdtKrESmxcY/wVjf3tB/q4ToK6chYP++CKmSmbdi
 xRXue7AMc2SAqotNGIBUDINdZHhvb8gYPRBAMQUI=
Message-ID: <6c705934-d4b9-45c8-a0cb-ac1b06c26e2e@ispras.ru>
Date: Thu, 7 Dec 2023 11:45:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] replay: introduce a central report point for sync
 errors
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
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
 <43f2e50a-1d84-4402-b30c-a5b865cd4e49@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <43f2e50a-1d84-4402-b30c-a5b865cd4e49@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
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

On 06.12.2023 19:48, Richard Henderson wrote:
> On 12/6/23 03:35, Philippe Mathieu-Daudé wrote:
>> Hi Alex,
>>
>> On 5/12/23 21:41, Alex Bennée wrote:
>>> Figuring out why replay has failed is tricky at the best of times.
>>> Lets centralise the reporting of a replay sync error and add a little
>>> bit of extra information to help with debugging.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>   replay/replay-internal.h | 12 ++++++++++++
>>>   replay/replay-char.c     |  6 ++----
>>>   replay/replay-internal.c |  1 +
>>>   replay/replay.c          |  9 +++++++++
>>>   4 files changed, 24 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
>>> index 1bc8fd5086..709e2eb4cb 100644
>>> --- a/replay/replay-internal.h
>>> +++ b/replay/replay-internal.h
>>> @@ -74,6 +74,7 @@ enum ReplayEvents {
>>>    * @cached_clock: Cached clocks values
>>>    * @current_icount: number of processed instructions
>>>    * @instruction_count: number of instructions until next event
>>> + * @current_event: current event index
>>>    * @data_kind: current event
>>>    * @has_unread_data: true if event not yet processed
>>>    * @file_offset: offset into replay log at replay snapshot
>>> @@ -84,6 +85,7 @@ typedef struct ReplayState {
>>>       int64_t cached_clock[REPLAY_CLOCK_COUNT];
>>>       uint64_t current_icount;
>>>       int instruction_count;
>>> +    unsigned int current_event;
>>>       unsigned int data_kind;
>>>       bool has_unread_data;
>>>       uint64_t file_offset;
>> Shouldn't this field be migrated?
> 
> No, it's for diagnostic use only.

It should be migrated, because RR may be started from the snapshot, 
which references the middle of replayed scenario.


Pavel Dovgalyuk




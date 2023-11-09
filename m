Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF707E6644
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 10:08:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r111F-0002VX-Ks; Thu, 09 Nov 2023 04:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r111D-0002UH-8I; Thu, 09 Nov 2023 04:08:07 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r1119-0000He-Mr; Thu, 09 Nov 2023 04:08:06 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5329:0:640:5ed5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id D7FFC61976;
 Thu,  9 Nov 2023 12:07:58 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b42b::1:2e] (unknown
 [2a02:6b8:b081:b42b::1:2e])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id v7abfF0On8c0-BcB0sycY; Thu, 09 Nov 2023 12:07:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1699520878;
 bh=9apuE64fZoYjpT4VLW8mk0oUcbeNnjUm20AMDVFkNmM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BLsHTpF5+AW0xY9ZTQeG28PP6P6lK1WtlX5kRKK2O5m1fmK1YE6hzWZufocso97z6
 YoXTpt/ZHtFcpyBovJwRDxnBdP9IEBBcTebZyo0a4+gIcMTNzBXJ6JS29076vu8C8z
 nolLfT1FOuIh7gh/qTgmuhP1tpVR0057OIT5hw8Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7b017824-069d-421a-a179-4098ab7a8c64@yandex-team.ru>
Date: Thu, 9 Nov 2023 12:07:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block-backend: per-device throttling of BLOCK_IO_ERROR
 reports
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, armbru@redhat.com,
 yc-core@yandex-team.ru, zeil@yandex-team.ru, xeor@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org
References: <20231107085842.602188-1-vsementsov@yandex-team.ru>
 <tl4b6tcrlwchbgrkq2zuqyxqqsxe3oclrgt6pr62ggm2nbtkfz@lah5uyiomzp5>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <tl4b6tcrlwchbgrkq2zuqyxqqsxe3oclrgt6pr62ggm2nbtkfz@lah5uyiomzp5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 09.11.23 00:22, Eric Blake wrote:
> On Tue, Nov 07, 2023 at 11:58:42AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> From: Leonid Kaplan <xeor@yandex-team.ru>
>>
>> BLOCK_IO_ERROR events comes from guest, so we must throttle them.
>> We still want per-device throttling, so let's use device id as a key.
>>
>> Signed-off-by: Leonid Kaplan <xeor@yandex-team.ru>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   monitor/monitor.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>> index 01ede1babd..ad0243e9d7 100644
>> --- a/monitor/monitor.c
>> +++ b/monitor/monitor.c
>> @@ -309,6 +309,7 @@ int error_printf_unless_qmp(const char *fmt, ...)
>>   static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>>       /* Limit guest-triggerable events to 1 per second */
>>       [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
>> +    [QAPI_EVENT_BLOCK_IO_ERROR]    = { 1000 * SCALE_MS },
>>       [QAPI_EVENT_WATCHDOG]          = { 1000 * SCALE_MS },
>>       [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
>>       [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
>> @@ -498,6 +499,10 @@ static unsigned int qapi_event_throttle_hash(const void *key)
>>           hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
>>       }
>>   
>> +    if (evstate->event == QAPI_EVENT_BLOCK_IO_ERROR) {
>> +        hash += g_str_hash(qdict_get_str(evstate->data, "device"));
> 
> Wouldn't ^= be better than += for combining hashes?

As I understand (after googling a bit), XOR is a kind of default, and is obviously better than OR and AND.
Adding is not bitwise and should be slower, but I don't think we care about it here. Still adding is better at least in fact that it doesn't map pairs of equal string all to zero hash.
Adding is preexisting in this function, I don't think we should change it now.

> 
>> +    }
>> +
>>       return hash;
>>   }
>>   
>> @@ -525,6 +530,11 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
>>                          qdict_get_str(evb->data, "qom-path"));
>>       }
>>   
>> +    if (eva->event == QAPI_EVENT_BLOCK_IO_ERROR) {
>> +        return !strcmp(qdict_get_str(eva->data, "device"),
>> +                       qdict_get_str(evb->data, "device"));
>> +    }
>> +
> 
> At any rate, the idea makes sense for me.
> 

-- 
Best regards,
Vladimir



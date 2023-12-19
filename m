Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CE8818716
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 13:10:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFYuH-0003MM-CT; Tue, 19 Dec 2023 07:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFYuE-0003Km-Ky
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 07:09:02 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFYuB-0006Nc-O2
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 07:09:02 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ce934e9d51so2267844b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 04:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702987738; x=1703592538;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wxsjwpH1JV73RfMCcGzcn4dvmAF+Npb9UCHvc+CDUG0=;
 b=N7Ld/Q/NpR6qe/8eukYMjBcAtdE+CbHEpRUVCm7CImzJEmGh0bHedsnv27Zp6+p2fe
 7YSIXsVLijJNHCitxcTNnJpMOyf+qCAlJv9fmfKleWsO3ThBerF7dd0p//d6Za43/31o
 Yn/EgJs0wpSEHiRpQPtc6YWClYAn3hwWskfrUuOta9V2cgppJmpN+T5Ti6U0vMPRjtZC
 WvTlVRW1QJ5FSeowYZauUCvPqKGqTiSO20UeaKhgVm3J4ce3W0zzxy1lkpFL5fypgAIz
 cuKJjvaHCnnz3SwftCyT+0z0ExZYtoKbcQadbgfV5hXXkwEOEVNDwG77vR/+3ZoJ71N3
 9aXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702987738; x=1703592538;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wxsjwpH1JV73RfMCcGzcn4dvmAF+Npb9UCHvc+CDUG0=;
 b=FSJ5oOYfuZY2MfUTdb3DYoQrAJ7+HT0jKEdatIo2eQK0oq5FS9tbliSR9CuwK24M1Z
 mm3xqDl1dSZLonjpNYOC4WxHZaDXwlOqr9KSG+V+gw3V6lai8TCGelrK9pWYkwqpT4ah
 k9d+bxO6kVUypJTmkpujGZV++uGUAWh/Cz4XUfzabk9HUpxKuA6WrFk5TwXRDuttyH/Z
 qPfCYQG49sLZhz0oulbOLqi+d/QLu9tKYYIbxjTxthd+IMP39DuJP9O77Q5UnMn0KdbQ
 +p+/qcmTFK5eyyyez2tqMCcBT8YqclK2O9HYOTuExcaGjSNjXX2fwXMVL5+QbyyM4i+Z
 z7Sg==
X-Gm-Message-State: AOJu0YztMhhhfwQIdxzCN+vDPnSbIk8C0xcyEQBJZoWYgLxnc7e1xpHP
 jex0ppGhN/HHLaTM1HSlzRLdBw==
X-Google-Smtp-Source: AGHT+IHoCTvbUVyr9d1n0NlfQG5j2blxhwuI6rq61fn5Aa2lno0l96XIwakmfMtw6588e3BOet7+Pg==
X-Received: by 2002:a05:6a20:a11f:b0:190:4c11:28a3 with SMTP id
 q31-20020a056a20a11f00b001904c1128a3mr10664334pzk.6.1702987738360; 
 Tue, 19 Dec 2023 04:08:58 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 g22-20020a62e316000000b006d273997cd5sm6249019pfh.91.2023.12.19.04.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 04:08:58 -0800 (PST)
Message-ID: <ff212914-32b5-442e-8f67-4f01a7208a0c@daynix.com>
Date: Tue, 19 Dec 2023 21:08:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qdev: Report an error for machine without
 HotplugHandler
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
References: <20231210-bus-v2-1-34ebf5726fa0@daynix.com>
 <87h6kpgrl7.fsf@pond.sub.org>
 <cbda6265-5027-424c-be93-86073d9ad63a@daynix.com>
 <8734vzsj6k.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8734vzsj6k.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/18 23:02, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2023/12/11 15:51, Markus Armbruster wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> The HotplugHandler of the machine will be used when the parent bus does
>>>> not exist, but the machine may not have one. Report an error in such a
>>>> case instead of aborting.
>>>>
>>>> Fixes: 7716b8ca74 ("qdev: HotplugHandler: Add support for unplugging BUS-less devices")
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>> Do you have a reproducer for the crash?
>>>
>>>> ---
>>>> Changes in v2:
>>>> - Fixed indention.
>>>> - Link to v1: https://lore.kernel.org/r/20231202-bus-v1-1-f7540e3a8d62@daynix.com
>>>> ---
>>>>    system/qdev-monitor.c | 13 ++++++++++---
>>>>    1 file changed, 10 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>>>> index a13db763e5..5fe5d49c20 100644
>>>> --- a/system/qdev-monitor.c
>>>> +++ b/system/qdev-monitor.c
>>>> @@ -927,9 +927,16 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>>>    void qdev_unplug(DeviceState *dev, Error **errp)
>>>    {
>>>        DeviceClass *dc = DEVICE_GET_CLASS(dev);
>>>        HotplugHandler *hotplug_ctrl;
>>>        HotplugHandlerClass *hdc;
>>>        Error *local_err = NULL;
>>>        if (qdev_unplug_blocked(dev, errp)) {
>>>            return;
>>>        }
>>>        if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
>>>            error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
>>>            return;
>>>        }
>>>        if (!dc->hotpluggable) {
>>>            error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
>>>                       object_get_typename(OBJECT(dev)));
>>>            return;
>>>        }
>>>        if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
>>>            error_setg(errp, "device_del not allowed while migrating");
>>>            return;
>>>        }
>>>
>>>>       qdev_hot_removed = true;
>>>>          hotplug_ctrl = qdev_get_hotplug_handler(dev);
>>>> -    /* hotpluggable device MUST have HotplugHandler, if it doesn't
>>>> -     * then something is very wrong with it */
>>>> -    g_assert(hotplug_ctrl);
>>>> +    if (!hotplug_ctrl) {
>>>> +        /*
>>>> +         * hotpluggable bus MUST have HotplugHandler, if it doesn't
>>>> +         * then something is very wrong with it
>>>> +         */
>>>> +        assert(!dev->parent_bus);
>>>> +
>>>> +        error_setg(errp, "The machine does not support hotplugging for a device without parent bus");
>>>> +        return;
>>>> +    }
>>>
>>> Extended version of my question above: what are the devices where
>>> qdev_get_hotplug_handler(dev) returns null here?
>>
>> Start a VM: qemu-system-aarch64 -M virt -nographic
>> Run the following on its HMP: device_del /machine/unattached/device[0]
>>
>> It tries to unplug cortex-a15-arm-cpu and crashes.
> 
> This device has no parent bus (dev->parent_bus is null), but is marked
> hot-pluggable (dc->hotpluggable is true).  Question for somebody
> familiar with the hot-plug machinery: is this sane?

Setting hotpluggable false for each device without bus_type gives the 
same effect, but is error-prone.


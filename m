Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FFF81AED5
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 07:37:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGCfm-00050q-0K; Thu, 21 Dec 2023 01:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGCfk-00050d-GI
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:36:44 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGCfh-0002Gi-55
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:36:44 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d3e05abcaeso3187865ad.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 22:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1703140595; x=1703745395;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k4HFyN8Qd94O7IlfdeCTXz9IW17rMmG81QliWfTgv5Q=;
 b=CQtq1L/zAkDSy1RxCQcxZvP9hOpS+Rj7nOgs1DSQTKdmzJkXyY0Zm257bx/RMCUgeW
 NiK/qz+dIYX7IhayCrPQVTKCN+Wu3EpUYOnytfG3uHlcCb30945gZjuTAaRfPH3E5AuK
 cvTIybEvBtUSavX3cFLgpRRNfiJ7ymWB7sWfVaJo0QdwzLanKtyZ5Ex+S6rRBgJ6ftyr
 0HUiefkxmu+DCo9lbodEtx2GTn4zbN9NTmIC1q2zI5SQ1AMB78TY7LyROwS/K9dXmeDr
 CtvJfEVLXg3a/xhOsbgW0hkkmlwJ4F7/ORvR/9MTYTskXnaBmj51vGL4a/fV7FWtVfpi
 cKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703140595; x=1703745395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k4HFyN8Qd94O7IlfdeCTXz9IW17rMmG81QliWfTgv5Q=;
 b=iVlh5eo3f3DO0jJFW284srK9czh72QAlEmg763OMNudHzhhorqE+aj9QLAdeR91VPO
 PoxHvUia1DSXulc7Q+DbyEtItH6Artmio7Wu+owqqN0wjT1Y4hJtYTEOKQ675W5d+etr
 q+h+vbskSXIMk8NJEp9YMxHDkkUlFMrV5noOAkjMK1fT1Bs3PZc6jZWz5nO7qCrbo525
 93F6wbZYt8s8JatS45LSVdaX+n4dwib2iwQnHd6gRqjzNS+86Yb1c1z1GJTsoQfLx/7d
 3dns5dawJPjsmAgoUeMjCt/Zu4EV5xBbsUkkmxgou50zYHe43DeaQVmUfz/sCodqlO34
 cpnQ==
X-Gm-Message-State: AOJu0Yxi3xsAIrmd5Kkx4HXBFoIMg1uPzL6Vob2cJtCjVpB6wdFLkgeJ
 lvziGWyQicPuBlo4D779rydbETbAJzGh8a5Vo3hLnA==
X-Google-Smtp-Source: AGHT+IF57ArjLD4zJN2y0iZ32TOFz3mwfD8uvuJqKTi6iV6jrw0HDKYV9OYPBHNVu+qGZwbU1MZuRg==
X-Received: by 2002:a17:902:eb86:b0:1d3:f1ca:6a3 with SMTP id
 q6-20020a170902eb8600b001d3f1ca06a3mr1368755plg.112.1703140595362; 
 Wed, 20 Dec 2023 22:36:35 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a170902db0a00b001d3f7a5ea50sm789445plx.234.2023.12.20.22.36.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 22:36:34 -0800 (PST)
Message-ID: <68c2e155-0dc1-4566-853a-059e351e9649@daynix.com>
Date: Thu, 21 Dec 2023 15:36:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qdev: Report an error for machine without
 HotplugHandler
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
References: <20231210-bus-v2-1-34ebf5726fa0@daynix.com>
 <87h6kpgrl7.fsf@pond.sub.org>
 <cbda6265-5027-424c-be93-86073d9ad63a@daynix.com>
 <8734vzsj6k.fsf@pond.sub.org>
 <ff212914-32b5-442e-8f67-4f01a7208a0c@daynix.com>
 <87y1dpgvim.fsf@pond.sub.org> <ZYMaS8v8sIWhteFm@intel.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZYMaS8v8sIWhteFm@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

On 2023/12/21 1:46, Zhao Liu wrote:
> Hi Markus,
> 
> On Wed, Dec 20, 2023 at 08:53:21AM +0100, Markus Armbruster wrote:
>> Date: Wed, 20 Dec 2023 08:53:21 +0100
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [PATCH v2] qdev: Report an error for machine without
>>   HotplugHandler
>>
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>
>>> On 2023/12/18 23:02, Markus Armbruster wrote:
>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>
>>>>> On 2023/12/11 15:51, Markus Armbruster wrote:
>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>>
>>>>>>> The HotplugHandler of the machine will be used when the parent bus does
>>>>>>> not exist, but the machine may not have one. Report an error in such a
>>>>>>> case instead of aborting.
>>>>>>>
>>>>>>> Fixes: 7716b8ca74 ("qdev: HotplugHandler: Add support for unplugging BUS-less devices")
>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>
>>>>>> Do you have a reproducer for the crash?
>>>>>>
>>>>>>> ---
>>>>>>> Changes in v2:
>>>>>>> - Fixed indention.
>>>>>>> - Link to v1: https://lore.kernel.org/r/20231202-bus-v1-1-f7540e3a8d62@daynix.com
>>>>>>> ---
>>>>>>>     system/qdev-monitor.c | 13 ++++++++++---
>>>>>>>     1 file changed, 10 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>>>>>>> index a13db763e5..5fe5d49c20 100644
>>>>>>> --- a/system/qdev-monitor.c
>>>>>>> +++ b/system/qdev-monitor.c
>>>>>>> @@ -927,9 +927,16 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>>>>>>     void qdev_unplug(DeviceState *dev, Error **errp)
>>>>>>     {
>>>>>>         DeviceClass *dc = DEVICE_GET_CLASS(dev);
>>>>>>         HotplugHandler *hotplug_ctrl;
>>>>>>         HotplugHandlerClass *hdc;
>>>>>>         Error *local_err = NULL;
>>>>>>         if (qdev_unplug_blocked(dev, errp)) {
>>>>>>             return;
>>>>>>         }
>>>>>>         if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
>>>>>>             error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
>>>>>>             return;
>>>>>>         }
>>>>>>         if (!dc->hotpluggable) {
>>>>>>             error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
>>>>>>                        object_get_typename(OBJECT(dev)));
>>>>>>             return;
>>>>>>         }
>>>>>>         if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
>>>>>>             error_setg(errp, "device_del not allowed while migrating");
>>>>>>             return;
>>>>>>         }
>>>>>>
>>>>>>>        qdev_hot_removed = true;
>>>>>>>           hotplug_ctrl = qdev_get_hotplug_handler(dev);
>>>>>>> -    /* hotpluggable device MUST have HotplugHandler, if it doesn't
>>>>>>> -     * then something is very wrong with it */
>>>>>>> -    g_assert(hotplug_ctrl);
>>>>>>> +    if (!hotplug_ctrl) {
>>>>>>> +        /*
>>>>>>> +         * hotpluggable bus MUST have HotplugHandler, if it doesn't
>>>>>>> +         * then something is very wrong with it
>>>>>>> +         */
>>>>>>> +        assert(!dev->parent_bus);
>>>>>>> +
>>>>>>> +        error_setg(errp, "The machine does not support hotplugging for a device without parent bus");
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>
>>>>>> Extended version of my question above: what are the devices where
>>>>>> qdev_get_hotplug_handler(dev) returns null here?
>>>>>
>>>>> Start a VM: qemu-system-aarch64 -M virt -nographic
>>>>> Run the following on its HMP: device_del /machine/unattached/device[0]
>>>>>
>>>>> It tries to unplug cortex-a15-arm-cpu and crashes.
>>>>
>>>> This device has no parent bus (dev->parent_bus is null), but is marked
>>>> hot-pluggable (dc->hotpluggable is true).  Question for somebody
>>>> familiar with the hot-plug machinery: is this sane?
>>>
>>> Setting hotpluggable false for each device without bus_type gives the same effect, but is error-prone.
>>
>> Having hotpluggable = true when the device cannot be hot-plugged is
>> *wrong*.  You might be able to paper over the wrongness so the code
>> works anyway, but nothing good can come out of lying to developers
>> trying to understand how the code works.
>>
>> Three ideas to avoid the lying:
>>
>> 1. default hotpluggable to bus_type != NULL.

I don't have an idea to achieve that. Currently bus_type is set after 
hotpluggable.

>>
>> 2. assert(dc->bus_type || !dc->hotpluggable) in a suitable spot.

It results in abortion and doesn't improve the situation.

>>
>> 3. Change the meaning of hotpluggable, and rename it to reflect its new
>> meaning.  Requires a careful reading of its uses.  I wouldn't go there.

I don't have an idea for such a naming.

So I'm stuck with the current proposal. It suppresses abortion at least. 
Any alternative idea is welcome.

>>
> 
> What about 4 (or maybe 3.1) - droping this hotpluggable flag and just use a
> helper (like qbus) to check if device is hotpluggable?
> 
> This removes the confusion of that flag and also reduces the number of
> configuration items for DeviceState that require developer attention.
> A simple helper is as follows:

Some devices simply doesn't support hotplugging even if the bus 
supports. virtio-gpu-pci doesn't support hotplugging because the display 
infrastructure cannot handle hotplugging, for example.

Regards,
Akihiko Odaki


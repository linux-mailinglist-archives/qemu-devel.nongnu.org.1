Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2BF81B292
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 10:38:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGFTu-0003iA-Vd; Thu, 21 Dec 2023 04:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGFTs-0003hz-Do
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 04:36:40 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGFTq-0006r4-5J
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 04:36:40 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d3ef33e68dso4172585ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 01:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1703151396; x=1703756196;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HMoVWxtkoGSxyJIot7bzuHkXzVawQW22Rt9ewhXJp3g=;
 b=a/7YHtOFOQoFuLKDSSqO6AD1o8RMOjyFjwL6lvB6ujRPUTUxhjeVUMzZ9gEWHAfN+8
 FTmXqrgc6eIOkr7F4p/xn3ewNgwLctesbTu88Wqt/HEC/sr9xWgjhGtdTHKuHBf0eKNr
 rNSiQT+6HmcsJEkMDdO7j+yZ+YJZXIS/LYNY5e19OVB3q0d2d02S5qrWiSCCjOl975uY
 XLTH5n3biPWcB/UJTr9tu5nfG/5goYYTse7iAv6FzpgmnsnXq2rstxxWHBirG60ipqmH
 0MtBVTY79mT/+ph7Qq7g1e0dNaEVW4WKfzuH8Zy4CDEmnsWL8AupZZr91CvYojGLGgIQ
 XT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703151396; x=1703756196;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HMoVWxtkoGSxyJIot7bzuHkXzVawQW22Rt9ewhXJp3g=;
 b=wgSHcVRCGtPpGa6L3bYAT01QaHgHMH5DVv5LRyVECx+ed5oisQT7LBfAtzuVMH0azm
 qzU+snRpKEy7D7RNCyVrih+Hduq4ERDFZ070+ji65igUXfc0hrzlUuI0+plbH2lrIi/w
 H7v2R/rjuhgQtd6C4pR6PUZZwpTWni0eHxERbO56VVkgSkaOPdmfHD53J0964XBZOaGZ
 Kv//W5PN7+bMTrLZBR4OoAo6UjrvWMy460gR+wfDapB7toJSqYD1qiXXY/GWfAYq9N8Z
 NfuxvWm7f0nzemE1N9wqWRQoQjZS4l3Uhogd39OWc8l6F8iasYXVWw8l1bANOXXRKtrc
 w31A==
X-Gm-Message-State: AOJu0YyUB9ONnlEJ8sR2tocNVXl1/haB1CBQ5tRSwp3kBlbny+CLk4Gi
 GgLN6iEPqOGQwBZoiOpSKmtvO8zHUA01cg==
X-Google-Smtp-Source: AGHT+IFdtSeGV6rs8kt9J4+l7IyCmwTYqSGhVtGbvMH7m84TKAuH5VEFSOlxihjuPhY0gHP+bOASRA==
X-Received: by 2002:a17:902:fa06:b0:1d4:56b:5d31 with SMTP id
 la6-20020a170902fa0600b001d4056b5d31mr478844plb.8.1703151396628; 
 Thu, 21 Dec 2023 01:36:36 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902ee4500b001d06b63bb98sm1189874plo.71.2023.12.21.01.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 01:36:36 -0800 (PST)
Message-ID: <8f441c44-182f-4139-a0d1-4e3e410efb41@daynix.com>
Date: Thu, 21 Dec 2023 18:36:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qdev: Report an error for machine without
 HotplugHandler
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
References: <20231210-bus-v2-1-34ebf5726fa0@daynix.com>
 <87h6kpgrl7.fsf@pond.sub.org>
 <cbda6265-5027-424c-be93-86073d9ad63a@daynix.com>
 <8734vzsj6k.fsf@pond.sub.org>
 <ff212914-32b5-442e-8f67-4f01a7208a0c@daynix.com>
 <87y1dpgvim.fsf@pond.sub.org> <ZYMaS8v8sIWhteFm@intel.com>
 <68c2e155-0dc1-4566-853a-059e351e9649@daynix.com>
 <87ttoc6ius.fsf@pond.sub.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87ttoc6ius.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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

On 2023/12/21 17:49, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2023/12/21 1:46, Zhao Liu wrote:
>>> Hi Markus,
>>> On Wed, Dec 20, 2023 at 08:53:21AM +0100, Markus Armbruster wrote:
>>>> Date: Wed, 20 Dec 2023 08:53:21 +0100
>>>> From: Markus Armbruster <armbru@redhat.com>
>>>> Subject: Re: [PATCH v2] qdev: Report an error for machine without
>>>>    HotplugHandler
>>>>
>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>
>>>>> On 2023/12/18 23:02, Markus Armbruster wrote:
>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>>
>>>>>>> On 2023/12/11 15:51, Markus Armbruster wrote:
>>>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>>>>
>>>>>>>>> The HotplugHandler of the machine will be used when the parent bus does
>>>>>>>>> not exist, but the machine may not have one. Report an error in such a
>>>>>>>>> case instead of aborting.
>>>>>>>>>
>>>>>>>>> Fixes: 7716b8ca74 ("qdev: HotplugHandler: Add support for unplugging BUS-less devices")
>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>
>>>>>>>> Do you have a reproducer for the crash?
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>> Changes in v2:
>>>>>>>>> - Fixed indention.
>>>>>>>>> - Link to v1: https://lore.kernel.org/r/20231202-bus-v1-1-f7540e3a8d62@daynix.com
>>>>>>>>> ---
>>>>>>>>>      system/qdev-monitor.c | 13 ++++++++++---
>>>>>>>>>      1 file changed, 10 insertions(+), 3 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>>>>>>>>> index a13db763e5..5fe5d49c20 100644
>>>>>>>>> --- a/system/qdev-monitor.c
>>>>>>>>> +++ b/system/qdev-monitor.c
>>>>>>>>> @@ -927,9 +927,16 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>>>>>>>>      void qdev_unplug(DeviceState *dev, Error **errp)
>>>>>>>>      {
>>>>>>>>          DeviceClass *dc = DEVICE_GET_CLASS(dev);
>>>>>>>>          HotplugHandler *hotplug_ctrl;
>>>>>>>>          HotplugHandlerClass *hdc;
>>>>>>>>          Error *local_err = NULL;
>>>>>>>>          if (qdev_unplug_blocked(dev, errp)) {
>>>>>>>>              return;
>>>>>>>>          }
>>>>>>>>          if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
>>>>>>>>              error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
>>>>>>>>              return;
>>>>>>>>          }
>>>>>>>>          if (!dc->hotpluggable) {
>>>>>>>>              error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
>>>>>>>>                         object_get_typename(OBJECT(dev)));
>>>>>>>>              return;
>>>>>>>>          }
>>>>>>>>          if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
>>>>>>>>              error_setg(errp, "device_del not allowed while migrating");
>>>>>>>>              return;
>>>>>>>>          }
>>>>>>>>
>>>>>>>>>         qdev_hot_removed = true;
>>>>>>>>>            hotplug_ctrl = qdev_get_hotplug_handler(dev);
>>>>>>>>> -    /* hotpluggable device MUST have HotplugHandler, if it doesn't
>>>>>>>>> -     * then something is very wrong with it */
>>>>>>>>> -    g_assert(hotplug_ctrl);
>>>>>>>>> +    if (!hotplug_ctrl) {
>>>>>>>>> +        /*
>>>>>>>>> +         * hotpluggable bus MUST have HotplugHandler, if it doesn't
>>>>>>>>> +         * then something is very wrong with it
>>>>>>>>> +         */
>>>>>>>>> +        assert(!dev->parent_bus);
>>>>>>>>> +
>>>>>>>>> +        error_setg(errp, "The machine does not support hotplugging for a device without parent bus");
>>>>>>>>> +        return;
>>>>>>>>> +    }
>>>>>>>>
>>>>>>>> Extended version of my question above: what are the devices where
>>>>>>>> qdev_get_hotplug_handler(dev) returns null here?
>>>>>>>
>>>>>>> Start a VM: qemu-system-aarch64 -M virt -nographic
>>>>>>> Run the following on its HMP: device_del /machine/unattached/device[0]
>>>>>>>
>>>>>>> It tries to unplug cortex-a15-arm-cpu and crashes.
>>>>>>
>>>>>> This device has no parent bus (dev->parent_bus is null), but is marked
>>>>>> hot-pluggable (dc->hotpluggable is true).  Question for somebody
>>>>>> familiar with the hot-plug machinery: is this sane?
>>>>>
>>>>> Setting hotpluggable false for each device without bus_type gives the same effect, but is error-prone.
>>>>
>>>> Having hotpluggable = true when the device cannot be hot-plugged is
>>>> *wrong*.  You might be able to paper over the wrongness so the code
>>>> works anyway, but nothing good can come out of lying to developers
>>>> trying to understand how the code works.
>>>>
>>>> Three ideas to avoid the lying:
>>>>
>>>> 1. default hotpluggable to bus_type != NULL.
>>
>> I don't have an idea to achieve that. Currently bus_type is set after hotpluggable.
>>
>>>>
>>>> 2. assert(dc->bus_type || !dc->hotpluggable) in a suitable spot.
>>
>> It results in abortion and doesn't improve the situation.
> 
> Oh, it does!  The abort leads us to all the places where we currently
> lie (by having dc->hotpluggable = true when it isn't), so we can fix
> them.

I get your point. So we can put the assertion to the point that runs 
after device realization and let such devices break. It's quite 
disruptive but works.


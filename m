Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 481B6810DB5
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 10:52:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDLtI-0001Lt-SO; Wed, 13 Dec 2023 04:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDLtG-0001Lh-Br
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 04:50:54 -0500
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDLtE-0003RM-D5
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 04:50:54 -0500
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-35f72db10f7so1983175ab.2
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 01:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702461051; x=1703065851;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0GW46pv03PV2MIqMCEOGb53HHQpdFuvgzW+Sz3LKeOE=;
 b=selHIrudxMfXAi0NEbaB6Ab2QoCrBRXI81c39q+5Mdh+9y6InEWC/C5IfMlM5wFCTY
 rBJf27L3Mhvh+HDyvRgCIHImooqCdql3KepQnezAdBmfaN5Qe45EfAMT6wEOIr5ekfOx
 XI5zQ2E3HV+hP3q3oJQd14DRUd8jbTX1n/0aG1gZbuEWsZn42Y/5PvmjjSjJ2YEpwbp2
 3NludVWSmjSG6CMZmmXebRHCYzQOnDOg6EgHmPFHx4GIfROXLMN+/Ny0fBd/pvmoscSB
 2YkzzS5VPNl6GRQTbCmrbRbleLA23rLTXNX+7wRA1FuloNy8rd1pL+ucz4KRFlZl0Jwr
 sM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702461051; x=1703065851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0GW46pv03PV2MIqMCEOGb53HHQpdFuvgzW+Sz3LKeOE=;
 b=eJJekX23ATLTfwef1PxajUMBnZVhd6QE4FuXLyw+PYh5yF3Y49kuj6fBppERfH3WBJ
 fFOyhbJ2JHd1DHP7nlkllLAEj/lWrSWSP1T/JmNTsgNCQVQ2/jpjLI7qn52ovCWfsdFQ
 jqh+itEkd+Qv9nLeBwFTzP/YGElv03qfNfjOk6lu7kbqNaVlq5uhcfeUgWmnCzlE7Cbv
 jVDyRF20Tfxcsf+tn11KjjQSEwC2oMeRDHb0d24SF6JRiVidK0FPiu0s5QEjJF2Mvp54
 oUCSdGebpvR9To2vIRG+Hwf2X7nc/EmRUG87AwwtqZSaVR5HKiGObkvuERAgGn9t7Yt0
 z0tw==
X-Gm-Message-State: AOJu0Yy7EQ/LuVo5snn9QP7AZOuyDXPyRcZsS3pQOdVgqG4ltnEVYLC1
 DvbiqHSra1805W/X0E9jJpYLcw==
X-Google-Smtp-Source: AGHT+IGqLWUiNmio9OrjiVItp5c9jw+fqlBp3VrBZTDQ1/61pfm/EVFVa6uOQhTnSGd+GF4PDVn3iA==
X-Received: by 2002:a05:6e02:19ce:b0:35d:59a2:3323 with SMTP id
 r14-20020a056e0219ce00b0035d59a23323mr14013448ill.39.1702461050948; 
 Wed, 13 Dec 2023 01:50:50 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a170902cece00b001d0cd48e08fsm10216620plg.179.2023.12.13.01.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 01:50:50 -0800 (PST)
Message-ID: <cbda6265-5027-424c-be93-86073d9ad63a@daynix.com>
Date: Wed, 13 Dec 2023 18:50:47 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87h6kpgrl7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x12b.google.com
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

On 2023/12/11 15:51, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> The HotplugHandler of the machine will be used when the parent bus does
>> not exist, but the machine may not have one. Report an error in such a
>> case instead of aborting.
>>
>> Fixes: 7716b8ca74 ("qdev: HotplugHandler: Add support for unplugging BUS-less devices")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Do you have a reproducer for the crash?
> 
>> ---
>> Changes in v2:
>> - Fixed indention.
>> - Link to v1: https://lore.kernel.org/r/20231202-bus-v1-1-f7540e3a8d62@daynix.com
>> ---
>>   system/qdev-monitor.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>> index a13db763e5..5fe5d49c20 100644
>> --- a/system/qdev-monitor.c
>> +++ b/system/qdev-monitor.c
>> @@ -927,9 +927,16 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>     void qdev_unplug(DeviceState *dev, Error **errp)
>     {
>         DeviceClass *dc = DEVICE_GET_CLASS(dev);
>         HotplugHandler *hotplug_ctrl;
>         HotplugHandlerClass *hdc;
>         Error *local_err = NULL;
> 
>         if (qdev_unplug_blocked(dev, errp)) {
>             return;
>         }
> 
>         if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
>             error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
>             return;
>         }
> 
>         if (!dc->hotpluggable) {
>             error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
>                        object_get_typename(OBJECT(dev)));
>             return;
>         }
> 
>         if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
>             error_setg(errp, "device_del not allowed while migrating");
>             return;
>         }
> 
>>       qdev_hot_removed = true;
>>   
>>       hotplug_ctrl = qdev_get_hotplug_handler(dev);
>> -    /* hotpluggable device MUST have HotplugHandler, if it doesn't
>> -     * then something is very wrong with it */
>> -    g_assert(hotplug_ctrl);
>> +    if (!hotplug_ctrl) {
>> +        /*
>> +         * hotpluggable bus MUST have HotplugHandler, if it doesn't
>> +         * then something is very wrong with it
>> +         */
>> +        assert(!dev->parent_bus);
>> +
>> +        error_setg(errp, "The machine does not support hotplugging for a device without parent bus");
>> +        return;
>> +    }
> 
> Extended version of my question above: what are the devices where
> qdev_get_hotplug_handler(dev) returns null here?

Start a VM: qemu-system-aarch64 -M virt -nographic
Run the following on its HMP: device_del /machine/unattached/device[0]

It tries to unplug cortex-a15-arm-cpu and crashes.


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A2B81B0B4
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:51:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGEkA-0007wv-5f; Thu, 21 Dec 2023 03:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGEk8-0007vD-UJ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:49:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGEk6-00030Z-Uz
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703148561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D1MZ7n+0ATSpNn9T1QWfP3GWKRPCY+A7Fw432VQncHI=;
 b=PmBE5KVGPZWl2jTPYhspXo13ge9RJ9/VtOM/lw5zABHc6ESY6aG/vJUjfk8R74/aJNhnai
 daXMO94b1a914HtUS95ikQNq85uvRmf1Tf77U/vKD/Ik2owyr8frB7O4MBH2oo8H6gWRO1
 +jRaoPIzYBWc6RAgmeCOor35dWQizPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-_PoA2BjDPlm6-vUnO7wRQQ-1; Thu, 21 Dec 2023 03:49:17 -0500
X-MC-Unique: _PoA2BjDPlm6-vUnO7wRQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3133585A58B;
 Thu, 21 Dec 2023 08:49:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E77CD51D5;
 Thu, 21 Dec 2023 08:49:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AEFAF21E6920; Thu, 21 Dec 2023 09:49:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2] qdev: Report an error for machine without
 HotplugHandler
In-Reply-To: <68c2e155-0dc1-4566-853a-059e351e9649@daynix.com> (Akihiko
 Odaki's message of "Thu, 21 Dec 2023 15:36:32 +0900")
References: <20231210-bus-v2-1-34ebf5726fa0@daynix.com>
 <87h6kpgrl7.fsf@pond.sub.org>
 <cbda6265-5027-424c-be93-86073d9ad63a@daynix.com>
 <8734vzsj6k.fsf@pond.sub.org>
 <ff212914-32b5-442e-8f67-4f01a7208a0c@daynix.com>
 <87y1dpgvim.fsf@pond.sub.org> <ZYMaS8v8sIWhteFm@intel.com>
 <68c2e155-0dc1-4566-853a-059e351e9649@daynix.com>
Date: Thu, 21 Dec 2023 09:49:15 +0100
Message-ID: <87ttoc6ius.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2023/12/21 1:46, Zhao Liu wrote:
>> Hi Markus,
>> On Wed, Dec 20, 2023 at 08:53:21AM +0100, Markus Armbruster wrote:
>>> Date: Wed, 20 Dec 2023 08:53:21 +0100
>>> From: Markus Armbruster <armbru@redhat.com>
>>> Subject: Re: [PATCH v2] qdev: Report an error for machine without
>>>   HotplugHandler
>>>
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> On 2023/12/18 23:02, Markus Armbruster wrote:
>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>
>>>>>> On 2023/12/11 15:51, Markus Armbruster wrote:
>>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>>>
>>>>>>>> The HotplugHandler of the machine will be used when the parent bus does
>>>>>>>> not exist, but the machine may not have one. Report an error in such a
>>>>>>>> case instead of aborting.
>>>>>>>>
>>>>>>>> Fixes: 7716b8ca74 ("qdev: HotplugHandler: Add support for unplugging BUS-less devices")
>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>
>>>>>>> Do you have a reproducer for the crash?
>>>>>>>
>>>>>>>> ---
>>>>>>>> Changes in v2:
>>>>>>>> - Fixed indention.
>>>>>>>> - Link to v1: https://lore.kernel.org/r/20231202-bus-v1-1-f7540e3a8d62@daynix.com
>>>>>>>> ---
>>>>>>>>     system/qdev-monitor.c | 13 ++++++++++---
>>>>>>>>     1 file changed, 10 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>>>>>>>> index a13db763e5..5fe5d49c20 100644
>>>>>>>> --- a/system/qdev-monitor.c
>>>>>>>> +++ b/system/qdev-monitor.c
>>>>>>>> @@ -927,9 +927,16 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>>>>>>>     void qdev_unplug(DeviceState *dev, Error **errp)
>>>>>>>     {
>>>>>>>         DeviceClass *dc = DEVICE_GET_CLASS(dev);
>>>>>>>         HotplugHandler *hotplug_ctrl;
>>>>>>>         HotplugHandlerClass *hdc;
>>>>>>>         Error *local_err = NULL;
>>>>>>>         if (qdev_unplug_blocked(dev, errp)) {
>>>>>>>             return;
>>>>>>>         }
>>>>>>>         if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
>>>>>>>             error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
>>>>>>>             return;
>>>>>>>         }
>>>>>>>         if (!dc->hotpluggable) {
>>>>>>>             error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
>>>>>>>                        object_get_typename(OBJECT(dev)));
>>>>>>>             return;
>>>>>>>         }
>>>>>>>         if (!migration_is_idle() && !dev->allow_unplug_during_migration) {
>>>>>>>             error_setg(errp, "device_del not allowed while migrating");
>>>>>>>             return;
>>>>>>>         }
>>>>>>>
>>>>>>>>        qdev_hot_removed = true;
>>>>>>>>           hotplug_ctrl = qdev_get_hotplug_handler(dev);
>>>>>>>> -    /* hotpluggable device MUST have HotplugHandler, if it doesn't
>>>>>>>> -     * then something is very wrong with it */
>>>>>>>> -    g_assert(hotplug_ctrl);
>>>>>>>> +    if (!hotplug_ctrl) {
>>>>>>>> +        /*
>>>>>>>> +         * hotpluggable bus MUST have HotplugHandler, if it doesn't
>>>>>>>> +         * then something is very wrong with it
>>>>>>>> +         */
>>>>>>>> +        assert(!dev->parent_bus);
>>>>>>>> +
>>>>>>>> +        error_setg(errp, "The machine does not support hotplugging for a device without parent bus");
>>>>>>>> +        return;
>>>>>>>> +    }
>>>>>>>
>>>>>>> Extended version of my question above: what are the devices where
>>>>>>> qdev_get_hotplug_handler(dev) returns null here?
>>>>>>
>>>>>> Start a VM: qemu-system-aarch64 -M virt -nographic
>>>>>> Run the following on its HMP: device_del /machine/unattached/device[0]
>>>>>>
>>>>>> It tries to unplug cortex-a15-arm-cpu and crashes.
>>>>>
>>>>> This device has no parent bus (dev->parent_bus is null), but is marked
>>>>> hot-pluggable (dc->hotpluggable is true).  Question for somebody
>>>>> familiar with the hot-plug machinery: is this sane?
>>>>
>>>> Setting hotpluggable false for each device without bus_type gives the same effect, but is error-prone.
>>>
>>> Having hotpluggable = true when the device cannot be hot-plugged is
>>> *wrong*.  You might be able to paper over the wrongness so the code
>>> works anyway, but nothing good can come out of lying to developers
>>> trying to understand how the code works.
>>>
>>> Three ideas to avoid the lying:
>>>
>>> 1. default hotpluggable to bus_type != NULL.
>
> I don't have an idea to achieve that. Currently bus_type is set after hotpluggable.
>
>>>
>>> 2. assert(dc->bus_type || !dc->hotpluggable) in a suitable spot.
>
> It results in abortion and doesn't improve the situation.

Oh, it does!  The abort leads us to all the places where we currently
lie (by having dc->hotpluggable = true when it isn't), so we can fix
them.

>>> 3. Change the meaning of hotpluggable, and rename it to reflect its new
>>> meaning.  Requires a careful reading of its uses.  I wouldn't go there.
>
> I don't have an idea for such a naming.
>
> So I'm stuck with the current proposal. It suppresses abortion at least. Any alternative idea is welcome.
>
>>>
>> What about 4 (or maybe 3.1) - droping this hotpluggable flag and just use a
>> helper (like qbus) to check if device is hotpluggable?
>> This removes the confusion of that flag and also reduces the number of
>> configuration items for DeviceState that require developer attention.
>> A simple helper is as follows:
>
> Some devices simply doesn't support hotplugging even if the bus supports. virtio-gpu-pci doesn't support hotplugging because the display infrastructure cannot handle hotplugging, for example.
>
> Regards,
> Akihiko Odaki



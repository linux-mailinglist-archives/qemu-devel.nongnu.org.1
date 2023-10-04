Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3CB7B8D78
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 21:35:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo7dm-0000O2-IA; Wed, 04 Oct 2023 15:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qo7dj-0000GB-TO
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:34:35 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qo7de-00087f-Jc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:34:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 6823364D10;
 Wed,  4 Oct 2023 22:34:26 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:2::1:1c] (unknown [2a02:6b8:b081:2::1:1c])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id OYdpGF3OoKo0-bIMZBJEh; 
 Wed, 04 Oct 2023 22:34:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696448065;
 bh=HbqrGniURF4NtD6RWc8RLd7aFuy+y2eK7vKqFF0YdRA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=f3rrdwSKV1YxAGqkLqEMLl07bWVKK6JZoRidAbPc7Bxy6Z5aJ7ICScmw3rsKmI3ox
 Kurd2AFNYYFSxx6lJBbRFonFkGu7XhHu63P21W+ZZoS8maNmJoxcWO8Mc/fyCoLvd9
 t1w59ZvmGy12YQizxdizpItRNsbBZpAbu9/LNAOw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e31e4d30-3c78-3c28-6b7a-6dc132c36bc8@yandex-team.ru>
Date: Wed, 4 Oct 2023 22:34:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 2/4] qapi: add DEVICE_ON and query-hotplug
 infrastructure
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, antonkuchin@yandex-team.ru, den-plotnikov@yandex-team.ru
References: <20230421103207.845847-1-vsementsov@yandex-team.ru>
 <20230421103207.845847-3-vsementsov@yandex-team.ru>
 <9f61f7f4-4c78-bf82-b140-6706a912e45a@linaro.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <9f61f7f4-4c78-bf82-b140-6706a912e45a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A bit old thread, but I'm going to resend, so should answer here about things I don't want to change. Be free to ignore it and come to review from scratch in v8 (coming soon) if you don't remember, what was it :)

On 19.05.23 18:20, Philippe Mathieu-Daudé wrote:
> Hi Vladimir,
> 
> On 21/4/23 12:32, Vladimir Sementsov-Ogievskiy wrote:
>> We have DEVICE_DELETED event, that signals that device_del command is
>> actually completed. But we don't have a counter-part for device_add.
>> Still it's sensible for SHPC and PCIe-native hotplug, as there are time
>> when the device in some intermediate state. Let's add an event that say
>> that the device is finally powered on, power indicator is on and
>> everything is OK for next manipulation on that device.
>>
>> Motivations:
>> 1. To be sure that device is "accepted" by guest. Guest may ignore
>> hotplugged device for some reason (for example during OS booting).
>> Management wants to catch this and handle the problem, instead of
>> silent assume that everything is OK. So, if we don't get the event by
>> some timeout, we can report an error, try to unplug/plug the disk again
>> or do some other things to handle the problem.
>>
>> 2. The device can't be removed (by blockdev-del) while power indicator
>> of hotplug controller is blinking (QEMU reports "guest is busy (power
>> indicator blinking)"). So, management should avoid removing the device
>> until it gets the DEVICE_ON event.
>> (Probably, better solution for this point is to automatically postpone
>> deletion until power indicator stops blinking)
>>
>> 3. Also, management tool may make a GUI visualization of power
>> indicator with help of this event.
>>
>> New query-hotplug command in additon to "device-on" state also provides
>> SHPC/PCIe-native specific hotplug controller properties (like leds)
>> that may help to determine real state of hotplug controller. That may
>> help to get additional information for further debugging when DEVICE_ON
>> / DEVICE_DELETED not come in time as expected.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[..]

>>   #endif
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index bd50ad5ee1..63889e41c0 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -180,6 +180,7 @@ struct DeviceState {
>>       char *id;
>>       char *canonical_path;
>>       bool realized;
>> +    bool device_on_sent; /* set once by SHPC or PCIE-hotplug */
> 
> This seems to belong to the next patch (not used here).
> Anyhow (besides the field misses its description) from the name
> I can't figure out what this is about. Probably too generic name
> IMHO.

Actually it's used in this patch and forces the event to be sent at most once.
The comment is misleading.

> 
>>       bool pending_deleted_event;
>>       int64_t pending_deleted_expires_ms;
>>       QDict *opts;
>> diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
>> index 1d57bf6577..c1c8798e89 100644
>> --- a/include/monitor/qdev.h
>> +++ b/include/monitor/qdev.h
>> @@ -36,4 +36,6 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>>    */
>>   const char *qdev_set_id(DeviceState *dev, char *id, Error **errp);
>> +void qdev_hotplug_device_on_event(DeviceState *dev);
>> +
>>   #endif
>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>> index 135cd81586..ffd20c43e0 100644
>> --- a/qapi/qdev.json
>> +++ b/qapi/qdev.json
>> @@ -173,3 +173,147 @@
>>   #
>>   ##
>>   { 'event': 'DEVICE_UNPLUG_GUEST_ERROR', 'data': 'DeviceAndPath' }
>> +
>> +##
>> +# @LedActivity:
>> +#
>> +# Three-state led indicator state.
>> +#
>> +# @on: Indicator is on.
>> +#
>> +# @blink: Indicator is blinking.
>> +#
>> +# @off: Indicator is off.
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'enum': 'LedActivity',
>> +  'data': [ 'on', 'blink', 'off' ] }
> 
> Possibly useful enough to add in a new qapi/led.json.

I'd postpone it until another user of the enum appear.

> 
>> +##
>> +# @HotplugSHPCSlotState:
>> +#
>> +# Standard Hot-Plug Controller slot state.
>> +#
>> +# @power-only: Slot is powered on but neither clock nor bus are connected.
>> +#
>> +# @enabled: Slot is powered on, clock and bus are connected, the card is
>> +#           fully functional from a hardware standpoint.
>> +#
>> +# @disabled: Slot is disabled, card is safe to be removed.
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'enum': 'HotplugSHPCSlotState',
>> +  'data': [ 'power-only', 'enabled', 'disabled' ] }
>> +
>> +##
>> +# @HotplugBaseState:
>> +#
>> +# Base structure for SHPC and PCIe-native hotplug.
>> +#
>> +# @power-led: Power indicator. When power indicator is on the device is
>> +#             ready and accepted by guest. Off status means that device
>> +#             is safe to remove and blinking is an intermediate state of
>> +#             hot-plug or hot-unplug.
>> +#
>> +# @attention-led: Attention indicator. Off status means normal operation,
>> +#                 On signals about operational problem, Blinking is for
>> +#                 locating the slot.
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'struct': 'HotplugBaseState',
>> +  'data': { '*power-led': 'LedActivity',
>> +            '*attention-led': 'LedActivity' } }
>> +
>> +##
>> +# @HotplugSHPCState:
>> +#
>> +# Standard Hot Plug Controller state.
>> +#
>> +# @slot-state: The slot state field of Slot Status.
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'struct': 'HotplugSHPCState',
>> +  'base': 'HotplugBaseState',
>> +  'data': { '*slot-state': 'HotplugSHPCSlotState' } }
>> +
>> +##
>> +# @HotplugPCIeNativeState:
>> +#
>> +# PCIe Native hotplug slot state.
> 
> Doesn't this belong to qapi/pci.json?

Now I think it shouldn't. I'd keep all hotplug-related together, even when ACPI hotplug will be supported by new event.

Probably it makes sense to make qdev-hotplug.json, but then what to keep in qdev.json? Only device-list-properties command.. Seems that it not worth the split for now.

> 
>> +#
>> +# @power-on: PCIe Power Controller Control of Slot Control Register.
>> +#            True means Power On (Power Controller Control bit is 0),
>> +#            False means Power Off (Power Controller Control bit is 1).
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'struct': 'HotplugPCIeNativeState',
>> +  'base': 'HotplugBaseState',
>> +  'data': { '*power-on': 'bool' } }
>> +
>> +##
>> +# @HotplugType:
>> +#
>> +# Type of hotplug controller / provider.
>> +#
>> +# @shpc: Standard Hot Plug Controller
>> +#
>> +# @pcie-native: PCIe Native hotplug
> 
> Ditto.
> 
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'enum': 'HotplugType',
>> +  'data': ['shpc', 'pcie-native'] }
>> +
>> +##
>> +# @HotplugInfo:
>> +#
>> +# Generic hotplug slot state.
>> +#
>> +# @type: type of the hotplug (shpc or pcie-native)
>> +#
>> +# @bus: The QOM path of the parent bus where device is hotplugged.
>> +#
>> +# @addr: The bus address for hotplugged device if applicable.
>> +#
>> +# @child: the hotplugged device
>> +#
>> +# @device-on: Device is powered-on by guest. This state changes at most
>> +#             once for the device and corresponds to DEVICE_ON event.
>> +#
>> +# Single: 8.1
>> +##
>> +{ 'union': 'HotplugInfo',
>> +  'base': { 'type': 'HotplugType',
>> +            'bus': 'DeviceAndPath',
>> +            '*addr': 'str',
>> +            'child': 'DeviceAndPath',
>> +            'device-on': 'bool' },
>> +  'discriminator': 'type',
>> +  'data': { 'shpc': 'HotplugSHPCState',
>> +            'pcie-native': 'HotplugPCIeNativeState' } }
>> +
>> +##
>> +# @query-hotplug:
>> +#
>> +# Query the state of hotplug controller.
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'command': 'query-hotplug',
>> +  'data': { 'id': 'str' },
>> +  'returns': 'HotplugInfo' }
>> +
>> +##
>> +# @DEVICE_ON:
>> +#
>> +# Emitted whenever the device insertion completion is acknowledged by the guest.
>> +# For now only emitted for SHPC and PCIe-native hotplug.
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'event': 'DEVICE_ON', 'data': 'DeviceAndPath' }

-- 
Best regards,
Vladimir



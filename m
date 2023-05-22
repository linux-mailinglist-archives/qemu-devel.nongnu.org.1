Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4956570BE3A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14dM-0006z3-Nb; Mon, 22 May 2023 08:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q14dC-0006xl-UR
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:27:26 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q14d9-00076o-Go
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:27:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:22a0:0:640:144c:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 2AFD15F8C5;
 Mon, 22 May 2023 15:27:08 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b50f::1:35] (unknown
 [2a02:6b8:b081:b50f::1:35])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5RgsGC1OjeA0-QFfwhtep; Mon, 22 May 2023 15:27:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1684758427; bh=gnCZrtD0AewNvoAysTCZ1HipHL+UEWB4pZiSXISrCSI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=SXGX/j2oCUv9wEUgCODH49fWAeKbDyU9SjFaxsorjJIB0GKJZh0X/RhMayFgMXetV
 lp0aCTqjZpuFhtLnD8kOSwjGKvCHFKSSH1Q8FOlM44o5HTsVrEfDGmOhwI5SMpt06I
 ae11iDWGzjF4y8qp7y0IzEwRg32ZF+Vey+D3jYv0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <eb68c11b-4bad-cf91-62b5-e6823ac83032@yandex-team.ru>
Date: Mon, 22 May 2023 15:27:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 2/4] qapi: add DEVICE_ON and query-hotplug
 infrastructure
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, antonkuchin@yandex-team.ru,
 den-plotnikov@yandex-team.ru
References: <20230421103207.845847-1-vsementsov@yandex-team.ru>
 <20230421103207.845847-3-vsementsov@yandex-team.ru>
 <87zg5wlk1q.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87zg5wlk1q.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 22.05.23 13:47, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
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
> 
> Events often need to be paired with a query to let the management
> application resynchronize after a QMP disconnect, say for a restart.
> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Do we have libvirt patches?  If not, is anybody working on them?

I'm afraid not [I'm making this for non-libvirt management software]

> If
> not, we need at least interface review by a libvirt developer familiar
> with hot-plug.  And we might want to mark the interface experimental.

experimental sounds fair, will do.

> 
> [...]
> 
>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>> index 135cd81586..ffd20c43e0 100644
>> --- a/qapi/qdev.json
>> +++ b/qapi/qdev.json
>> @@ -173,3 +173,147 @@
>>   #
>>   ##
>>   { 'event': 'DEVICE_UNPLUG_GUEST_ERROR', 'data': 'DeviceAndPath' }
>> +
>> +##
>> +# @LedActivity:
> 
> Not sure about "Activity".  "Status"?

Status sound better, I agree

> 
>> +#
>> +# Three-state led indicator state.
> 
> Scratch the sentence?
> 
>> +#
>> +# @on: Indicator is on.
>> +#
>> +# @blink: Indicator is blinking.
>> +#
>> +# @off: Indicator is off.
> 
> Suggest "LED is on" ans so forth.
> 
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'enum': 'LedActivity',
>> +  'data': [ 'on', 'blink', 'off' ] }
> 
> Suggest 'blinking'.
> 
>> +
>> +##
>> +# @HotplugSHPCSlotState:
>> +#
>> +# Standard Hot-Plug Controller slot state.
>> +#
>> +# @power-only: Slot is powered on but neither clock nor bus are connected.
> 
> Comma after "on"?
> 
>> +#
>> +# @enabled: Slot is powered on, clock and bus are connected, the card is
>> +#           fully functional from a hardware standpoint.
> 
> Suggest ", and the card"
> 
> Please format like
> 
>     # @power-only: Slot is powered on, but neither clock nor bus are
>     #     connected.
>     #
>     # @enabled: Slot is powered on, clock and bus are connected, and the
>     #     card is fully functional from a hardware standpoint.
> 
> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
> to conform to current conventions).
> 
>> +#
>> +# @disabled: Slot is disabled, card is safe to be removed.
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'enum': 'HotplugSHPCSlotState',
>> +  'data': [ 'power-only', 'enabled', 'disabled' ] }
>> +
>> +##
>> +# @HotplugBaseState:
>> +#
>> +# Base structure for SHPC and PCIe-native hotplug.
>> +#
>> +# @power-led: Power indicator. When power indicator is on the device is
>> +#             ready and accepted by guest. Off status means that device
>> +#             is safe to remove and blinking is an intermediate state of
>> +#             hot-plug or hot-unplug.
> 
> Suggest something like "When the power LED is on, the device is ...
> When it is off, the device is ...  It is blinking while hot plug or
> unplug is in progress."
> 
>> +#
>> +# @attention-led: Attention indicator. Off status means normal operation,
>> +#                 On signals about operational problem, Blinking is for
>> +#                 locating the slot.
> 
> Suggest something like "The attention LED is normally off.  It is on to
> signal a a problem.  Blinking is for helping users to locate the slot."
> 
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'struct': 'HotplugBaseState',
>> +  'data': { '*power-led': 'LedActivity',
>> +            '*attention-led': 'LedActivity' } }
>> +
>> +##
>> +# @HotplugSHPCState:
>> +#
>> +# Standard Hot Plug Controller state.
>> +#
>> +# @slot-state: The slot state field of Slot Status.
> 
> Color me confused.  What's "Slot Status"?

It's part of SHPC specification. "Slot Status" is a property of slot. It includes "Slot state" ("off" / "on"), which is important for us, and some other things, like "Slot frequency".

> 
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'struct': 'HotplugSHPCState',
>> +  'base': 'HotplugBaseState',
>> +  'data': { '*slot-state': 'HotplugSHPCSlotState' } }
>> +
>> +##
>> +# @HotplugPCIeNativeState:
>> +#
>> +# PCIe Native hotplug slot state.
> 
> hot-plug
> 
> More below, not flagging it there.
> 
>> +#
>> +# @power-on: PCIe Power Controller Control of Slot Control Register.
>> +#            True means Power On (Power Controller Control bit is 0),
>> +#            False means Power Off (Power Controller Control bit is 1).
> 
> Please format like
> 
>      # @power-on: PCIe Power Controller Control of Slot Control Register.
>      #     True means Power On (Power Controller Control bit is 0), and
>      #     False means Power Off (Power Controller Control bit is 1).
> 
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'struct': 'HotplugPCIeNativeState',
>> +  'base': 'HotplugBaseState',
>> +  'data': { '*power-on': 'bool' } }
>> +
>> +##
>> +# @HotplugType:
>> +#
>> +# Type of hotplug controller / provider.
>> +#
>> +# @shpc: Standard Hot Plug Controller
> 
> Suggest "PCI Standard Hot-plug Controller", because that's how the spec
> seems to spell it.
> 
>> +#
>> +# @pcie-native: PCIe Native hotplug
> 
> What about non-PCI hot-plug?

Nothing for now, not covered by these patches. (one more point for marking this experimental)

> 
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'enum': 'HotplugType',
>> +  'data': ['shpc', 'pcie-native'] }
>> +
>> +##
>> +# @HotplugInfo:
>> +#
>> +# Generic hotplug slot state.
> 
> Well, the generic part is defined here, but the union type pulls in
> controller-specific parts.  Scratch "generic"?

Agree

> 
>> +#
>> +# @type: type of the hotplug (shpc or pcie-native)
> 
> Repeating enum values in doc comments risks them going stale there.
> Scratch the parenthesis?
> 
>> +#
>> +# @bus: The QOM path of the parent bus where device is hotplugged.
> 
> Is this the bus the device is plugged into?

Yes

> 
> What about bus-less devices?  Hmm, I think we can make an argument that
> the infrastructure required to make hot-plug work will always be part of
> some kind of bus.  Does this make sense to you?

Yes I think we always have some parent device to hot-plug our device into.
It may change in future and then we'll just make the field optional?

> 
>> +#
>> +# @addr: The bus address for hotplugged device if applicable.
> 
> Uh, does this encode structured data in a string?

It should match addr specified in corresponding device_add command. So it's structured a bit.

> 
>> +#
>> +# @child: the hotplugged device
>> +#
>> +# @device-on: Device is powered-on by guest. This state changes at most
>> +#             once for the device and corresponds to DEVICE_ON event.
>> +#
>> +# Single: 8.1
>> +##
>> +{ 'union': 'HotplugInfo',
>> +  'base': { 'type': 'HotplugType',
>> +            'bus': 'DeviceAndPath',
>> +            '*addr': 'str',
>> +            'child': 'DeviceAndPath',
>> +            'device-on': 'bool' },
>> +  'discriminator': 'type',
>> +  'data': { 'shpc': 'HotplugSHPCState',
>> +            'pcie-native': 'HotplugPCIeNativeState' } }
> 
> You have data common to both types in two places: base of HotplugInfo
> and base of the variant types HotplugBaseState.  Why?

Good question. Don't remember now, will try to simplify for v8

> 
>> +
>> +##
>> +# @query-hotplug:
>> +#
>> +# Query the state of hotplug controller.
>> +#
> 
> @id is undocumented.
> 
>> +# Since: 8.1
>> +##
>> +{ 'command': 'query-hotplug',
>> +  'data': { 'id': 'str' },
>> +  'returns': 'HotplugInfo' }
> 
> I have more questions, but I'd like to understand the meaning of @id
> before I type them up.

It's id of hot-plugged device. Should correspond to @id in device_del command:

   # @id: the device's ID or QOM path

> 
>> +
>> +##
>> +# @DEVICE_ON:
>> +#
>> +# Emitted whenever the device insertion completion is acknowledged by the guest.
>> +# For now only emitted for SHPC and PCIe-native hotplug.
> 
> Please format like
> 
>     # Emitted whenever the device insertion completion is acknowledged by
>     # the guest.  For now only emitted for SHPC and PCIe-native hotplug.
> 
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'event': 'DEVICE_ON', 'data': 'DeviceAndPath' }
> 
> [...]
> 

Thanks a lot for reviewing!

-- 
Best regards,
Vladimir



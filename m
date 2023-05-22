Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B55A670BC82
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:56:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q149b-0001dL-5E; Mon, 22 May 2023 07:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q149Y-0001SP-Ez
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:56:40 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q149U-0000SZ-Gw
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:56:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0d:3786:0:640:7c97:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 51FE6603DD;
 Mon, 22 May 2023 14:56:29 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b50f::1:35] (unknown
 [2a02:6b8:b081:b50f::1:35])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id SufWeH4Mma60-USjicKII; Mon, 22 May 2023 14:56:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1684756588; bh=WC32EkA2ofOuo+So/WDRN+JRC6X92NJXA2lNyC4gm7Y=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=JLoYEnlZ9QEwtIdWzeWgBBXFBQsUiG9dgcb2JaPjLfnC1ZAU0cqqhgAkVcbMZ6RX+
 HAZeHNOCTsg88QEIC7iEA0+odWaJTFMJaORcBDc6U0BDaMuY4BpFbaLyzJT4Dhzwow
 1hsoLavWhGvMC+PrNkpm1lNWRi75Q2tdbpt5wdmU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <66477b6e-b8e1-677f-9e33-d5891b6cfb7c@yandex-team.ru>
Date: Mon, 22 May 2023 14:56:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
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
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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
>> ---
>>   hw/core/hotplug.c      |  13 ++++
>>   include/hw/hotplug.h   |  12 ++++
>>   include/hw/qdev-core.h |   1 +
>>   include/monitor/qdev.h |   2 +
>>   qapi/qdev.json         | 144 +++++++++++++++++++++++++++++++++++++++++
>>   softmmu/qdev-monitor.c |  41 ++++++++++++
>>   6 files changed, 213 insertions(+)
>>
>> diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
>> index 17ac986685..08d6d03760 100644
>> --- a/hw/core/hotplug.c
>> +++ b/hw/core/hotplug.c
>> @@ -57,6 +57,19 @@ void hotplug_handler_unplug(HotplugHandler *plug_handler,
>>       }
>>   }
>> +HotplugInfo *hotplug_handler_get_hotplug_state(HotplugHandler *plug_handler,
> 
> What about hotplug_handler_get_state()?

OK for me

> 
>> +                                               DeviceState *plugged_dev,
>> +                                               Error **errp)
>> +{
>> +    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
>> +
>> +    if (hdc->get_hotplug_state) {
>> +        return hdc->get_hotplug_state(plug_handler, plugged_dev, errp);
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>>   static const TypeInfo hotplug_handler_info = {
>>       .name          = TYPE_HOTPLUG_HANDLER,
>>       .parent        = TYPE_INTERFACE,
>> diff --git a/include/hw/hotplug.h b/include/hw/hotplug.h
>> index a9840ed485..9c43e1263b 100644
>> --- a/include/hw/hotplug.h
>> +++ b/include/hw/hotplug.h
>> @@ -13,6 +13,7 @@
>>   #define HOTPLUG_H
>>   #include "qom/object.h"
>> +#include "qapi/qapi-types-qdev.h"
>>   #define TYPE_HOTPLUG_HANDLER "hotplug-handler"
>> @@ -60,6 +61,8 @@ struct HotplugHandlerClass {
>>       hotplug_fn unplug_request;
>>       hotplug_fn unplug;
>>       bool (*is_hotpluggable_bus)(HotplugHandler *plug_handler, BusState *bus);
>> +    HotplugInfo *(*get_hotplug_state)(HotplugHandler *plug_handler,
>> +                                      DeviceState *plugged_dev, Error **errp);
>>   };
>>   /**
>> @@ -96,4 +99,13 @@ void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
>>   void hotplug_handler_unplug(HotplugHandler *plug_handler,
>>                               DeviceState *plugged_dev,
>>                               Error **errp);
>> +
>> +/**
>> + * hotplug_handler_get_hotplug_state:
>> + *
>> + * Calls #HotplugHandlerClass.get_hotplug_state callback of @plug_handler.
>> + */
>> +HotplugInfo *hotplug_handler_get_hotplug_state(HotplugHandler *plug_handler,
>> +                                               DeviceState *plugged_dev,
>> +                                               Error **errp);
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

Means "DEVICE_ON event is already sent".

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

OK, will move.

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



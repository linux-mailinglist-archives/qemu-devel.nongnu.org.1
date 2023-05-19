Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD468709B22
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:20:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01u3-0006WS-5y; Fri, 19 May 2023 11:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q01tx-0006WB-I4
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:20:17 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q01tv-000550-64
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:20:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30636edb493so689492f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684509613; x=1687101613;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GX3qMJ7I/walxoFEgJcI9YAoDEhJbd08ZK1GKNbSBxo=;
 b=CTkB7IiL8SQSrBybQ2zeagXHSYddX43w3Gm11gIE+DM8LuOqU2gjWc13JN37N1TEKx
 y+GgjtcxE4jBTGqJRUo+WYQOoYIwsZhjq/xVa7HpycNzAqtdOlbIh6PBWGBt2zdyYyb6
 9GTkUzFxEVoVnn/iF5ylMJ/9oxU2PPpBFvZiVjnqc4hKwXfqgRxUNq0OPtkz65a4DWDp
 XJFGSn1mypOPZsyj7Bb6AI8GX+1dMDg4YaITa7qj6oU1m5OBV8ggsL4mm48Avo6DyzzA
 q6nW3lZNkopWaiAPWkM7Zv16AGL46ASgcfTm7VVMJWsj1RO+1tnfPUsl1lqF1d5ngrn4
 kH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684509613; x=1687101613;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GX3qMJ7I/walxoFEgJcI9YAoDEhJbd08ZK1GKNbSBxo=;
 b=PIhAIwUhwhZLpoLJBaJGMH5+KqLh9UrIXNJA/+6iONLjKx1PPN0L2x1rLUcSQWKg4G
 alUdlYOHXsJ0pkkDWXumpYNoVEeiaJ5msyLpDIthI4UGOKOupZSWkRQvLAHh6EY3uVBY
 X2D5hZiTPERWx/0liImgSJV7pLlc376U2FZpubCpzer2bldQkw0GZX6/MR4+KYMax+vw
 uf4dTh8pajMJGmtIr6WOB/T0KoQssG08jlvD6er+SPPm11OCN2dd1lxKX2C/qx/umD2k
 br7ZPhWWrCbUIzU9TlCRNiSYfzbcI2wuO5914NfYf258W7MWBEGjdrINJlYQ7Nt321FJ
 LMSw==
X-Gm-Message-State: AC+VfDzBnpG104DvYcuP3CM8aS199nHKzQ2QjiGYTym35oNNjgxwftY9
 p8nsYIbXxuIg/b7TQOfYfeyRGA==
X-Google-Smtp-Source: ACHHUZ5bQdD48WYQq4wLbDHG+1hHRWbw/LJ8Dedf+qNihrYWXa5VN3UgOGH2G+2TUH5pfmqEqDtGhw==
X-Received: by 2002:adf:e2ce:0:b0:2fb:92c7:b169 with SMTP id
 d14-20020adfe2ce000000b002fb92c7b169mr4711976wrj.10.1684509613347; 
 Fri, 19 May 2023 08:20:13 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr.
 [176.184.41.228]) by smtp.gmail.com with ESMTPSA id
 k9-20020a5d5189000000b003063176ef09sm5644874wrv.6.2023.05.19.08.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:20:12 -0700 (PDT)
Message-ID: <9f61f7f4-4c78-bf82-b140-6706a912e45a@linaro.org>
Date: Fri, 19 May 2023 17:20:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v7 2/4] qapi: add DEVICE_ON and query-hotplug
 infrastructure
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, antonkuchin@yandex-team.ru, den-plotnikov@yandex-team.ru
References: <20230421103207.845847-1-vsementsov@yandex-team.ru>
 <20230421103207.845847-3-vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230421103207.845847-3-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Vladimir,

On 21/4/23 12:32, Vladimir Sementsov-Ogievskiy wrote:
> We have DEVICE_DELETED event, that signals that device_del command is
> actually completed. But we don't have a counter-part for device_add.
> Still it's sensible for SHPC and PCIe-native hotplug, as there are time
> when the device in some intermediate state. Let's add an event that say
> that the device is finally powered on, power indicator is on and
> everything is OK for next manipulation on that device.
> 
> Motivations:
> 1. To be sure that device is "accepted" by guest. Guest may ignore
> hotplugged device for some reason (for example during OS booting).
> Management wants to catch this and handle the problem, instead of
> silent assume that everything is OK. So, if we don't get the event by
> some timeout, we can report an error, try to unplug/plug the disk again
> or do some other things to handle the problem.
> 
> 2. The device can't be removed (by blockdev-del) while power indicator
> of hotplug controller is blinking (QEMU reports "guest is busy (power
> indicator blinking)"). So, management should avoid removing the device
> until it gets the DEVICE_ON event.
> (Probably, better solution for this point is to automatically postpone
> deletion until power indicator stops blinking)
> 
> 3. Also, management tool may make a GUI visualization of power
> indicator with help of this event.
> 
> New query-hotplug command in additon to "device-on" state also provides
> SHPC/PCIe-native specific hotplug controller properties (like leds)
> that may help to determine real state of hotplug controller. That may
> help to get additional information for further debugging when DEVICE_ON
> / DEVICE_DELETED not come in time as expected.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/core/hotplug.c      |  13 ++++
>   include/hw/hotplug.h   |  12 ++++
>   include/hw/qdev-core.h |   1 +
>   include/monitor/qdev.h |   2 +
>   qapi/qdev.json         | 144 +++++++++++++++++++++++++++++++++++++++++
>   softmmu/qdev-monitor.c |  41 ++++++++++++
>   6 files changed, 213 insertions(+)
> 
> diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
> index 17ac986685..08d6d03760 100644
> --- a/hw/core/hotplug.c
> +++ b/hw/core/hotplug.c
> @@ -57,6 +57,19 @@ void hotplug_handler_unplug(HotplugHandler *plug_handler,
>       }
>   }
>   
> +HotplugInfo *hotplug_handler_get_hotplug_state(HotplugHandler *plug_handler,

What about hotplug_handler_get_state()?

> +                                               DeviceState *plugged_dev,
> +                                               Error **errp)
> +{
> +    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
> +
> +    if (hdc->get_hotplug_state) {
> +        return hdc->get_hotplug_state(plug_handler, plugged_dev, errp);
> +    }
> +
> +    return NULL;
> +}
> +
>   static const TypeInfo hotplug_handler_info = {
>       .name          = TYPE_HOTPLUG_HANDLER,
>       .parent        = TYPE_INTERFACE,
> diff --git a/include/hw/hotplug.h b/include/hw/hotplug.h
> index a9840ed485..9c43e1263b 100644
> --- a/include/hw/hotplug.h
> +++ b/include/hw/hotplug.h
> @@ -13,6 +13,7 @@
>   #define HOTPLUG_H
>   
>   #include "qom/object.h"
> +#include "qapi/qapi-types-qdev.h"
>   
>   #define TYPE_HOTPLUG_HANDLER "hotplug-handler"
>   
> @@ -60,6 +61,8 @@ struct HotplugHandlerClass {
>       hotplug_fn unplug_request;
>       hotplug_fn unplug;
>       bool (*is_hotpluggable_bus)(HotplugHandler *plug_handler, BusState *bus);
> +    HotplugInfo *(*get_hotplug_state)(HotplugHandler *plug_handler,
> +                                      DeviceState *plugged_dev, Error **errp);
>   };
>   
>   /**
> @@ -96,4 +99,13 @@ void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
>   void hotplug_handler_unplug(HotplugHandler *plug_handler,
>                               DeviceState *plugged_dev,
>                               Error **errp);
> +
> +/**
> + * hotplug_handler_get_hotplug_state:
> + *
> + * Calls #HotplugHandlerClass.get_hotplug_state callback of @plug_handler.
> + */
> +HotplugInfo *hotplug_handler_get_hotplug_state(HotplugHandler *plug_handler,
> +                                               DeviceState *plugged_dev,
> +                                               Error **errp);
>   #endif
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index bd50ad5ee1..63889e41c0 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -180,6 +180,7 @@ struct DeviceState {
>       char *id;
>       char *canonical_path;
>       bool realized;
> +    bool device_on_sent; /* set once by SHPC or PCIE-hotplug */

This seems to belong to the next patch (not used here).
Anyhow (besides the field misses its description) from the name
I can't figure out what this is about. Probably too generic name
IMHO.

>       bool pending_deleted_event;
>       int64_t pending_deleted_expires_ms;
>       QDict *opts;
> diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
> index 1d57bf6577..c1c8798e89 100644
> --- a/include/monitor/qdev.h
> +++ b/include/monitor/qdev.h
> @@ -36,4 +36,6 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>    */
>   const char *qdev_set_id(DeviceState *dev, char *id, Error **errp);
>   
> +void qdev_hotplug_device_on_event(DeviceState *dev);
> +
>   #endif
> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 135cd81586..ffd20c43e0 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -173,3 +173,147 @@
>   #
>   ##
>   { 'event': 'DEVICE_UNPLUG_GUEST_ERROR', 'data': 'DeviceAndPath' }
> +
> +##
> +# @LedActivity:
> +#
> +# Three-state led indicator state.
> +#
> +# @on: Indicator is on.
> +#
> +# @blink: Indicator is blinking.
> +#
> +# @off: Indicator is off.
> +#
> +# Since: 8.1
> +##
> +{ 'enum': 'LedActivity',
> +  'data': [ 'on', 'blink', 'off' ] }

Possibly useful enough to add in a new qapi/led.json.

> +##
> +# @HotplugSHPCSlotState:
> +#
> +# Standard Hot-Plug Controller slot state.
> +#
> +# @power-only: Slot is powered on but neither clock nor bus are connected.
> +#
> +# @enabled: Slot is powered on, clock and bus are connected, the card is
> +#           fully functional from a hardware standpoint.
> +#
> +# @disabled: Slot is disabled, card is safe to be removed.
> +#
> +# Since: 8.1
> +##
> +{ 'enum': 'HotplugSHPCSlotState',
> +  'data': [ 'power-only', 'enabled', 'disabled' ] }
> +
> +##
> +# @HotplugBaseState:
> +#
> +# Base structure for SHPC and PCIe-native hotplug.
> +#
> +# @power-led: Power indicator. When power indicator is on the device is
> +#             ready and accepted by guest. Off status means that device
> +#             is safe to remove and blinking is an intermediate state of
> +#             hot-plug or hot-unplug.
> +#
> +# @attention-led: Attention indicator. Off status means normal operation,
> +#                 On signals about operational problem, Blinking is for
> +#                 locating the slot.
> +#
> +# Since: 8.1
> +##
> +{ 'struct': 'HotplugBaseState',
> +  'data': { '*power-led': 'LedActivity',
> +            '*attention-led': 'LedActivity' } }
> +
> +##
> +# @HotplugSHPCState:
> +#
> +# Standard Hot Plug Controller state.
> +#
> +# @slot-state: The slot state field of Slot Status.
> +#
> +# Since: 8.1
> +##
> +{ 'struct': 'HotplugSHPCState',
> +  'base': 'HotplugBaseState',
> +  'data': { '*slot-state': 'HotplugSHPCSlotState' } }
> +
> +##
> +# @HotplugPCIeNativeState:
> +#
> +# PCIe Native hotplug slot state.

Doesn't this belong to qapi/pci.json?

> +#
> +# @power-on: PCIe Power Controller Control of Slot Control Register.
> +#            True means Power On (Power Controller Control bit is 0),
> +#            False means Power Off (Power Controller Control bit is 1).
> +#
> +# Since: 8.1
> +##
> +{ 'struct': 'HotplugPCIeNativeState',
> +  'base': 'HotplugBaseState',
> +  'data': { '*power-on': 'bool' } }
> +
> +##
> +# @HotplugType:
> +#
> +# Type of hotplug controller / provider.
> +#
> +# @shpc: Standard Hot Plug Controller
> +#
> +# @pcie-native: PCIe Native hotplug

Ditto.

> +#
> +# Since: 8.1
> +##
> +{ 'enum': 'HotplugType',
> +  'data': ['shpc', 'pcie-native'] }
> +
> +##
> +# @HotplugInfo:
> +#
> +# Generic hotplug slot state.
> +#
> +# @type: type of the hotplug (shpc or pcie-native)
> +#
> +# @bus: The QOM path of the parent bus where device is hotplugged.
> +#
> +# @addr: The bus address for hotplugged device if applicable.
> +#
> +# @child: the hotplugged device
> +#
> +# @device-on: Device is powered-on by guest. This state changes at most
> +#             once for the device and corresponds to DEVICE_ON event.
> +#
> +# Single: 8.1
> +##
> +{ 'union': 'HotplugInfo',
> +  'base': { 'type': 'HotplugType',
> +            'bus': 'DeviceAndPath',
> +            '*addr': 'str',
> +            'child': 'DeviceAndPath',
> +            'device-on': 'bool' },
> +  'discriminator': 'type',
> +  'data': { 'shpc': 'HotplugSHPCState',
> +            'pcie-native': 'HotplugPCIeNativeState' } }
> +
> +##
> +# @query-hotplug:
> +#
> +# Query the state of hotplug controller.
> +#
> +# Since: 8.1
> +##
> +{ 'command': 'query-hotplug',
> +  'data': { 'id': 'str' },
> +  'returns': 'HotplugInfo' }
> +
> +##
> +# @DEVICE_ON:
> +#
> +# Emitted whenever the device insertion completion is acknowledged by the guest.
> +# For now only emitted for SHPC and PCIe-native hotplug.
> +#
> +# Since: 8.1
> +##
> +{ 'event': 'DEVICE_ON', 'data': 'DeviceAndPath' }


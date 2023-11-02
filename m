Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB77DF13F
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:37:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyVzi-0000EW-U1; Thu, 02 Nov 2023 07:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qyVzg-0000EL-Qi
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qyVze-0001Su-OL
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698924969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2O0rYDEJEF42OZQvPvEMiClXYnYaYD7RXT9fk5V2NAQ=;
 b=QBvJf2V7rDzkRNb9+qyO1LQUvojtTGrW0PoyxZr5422mxJUSRXy/xd8xp2jUHPYdUyevNU
 ObBvLHhbMPWKn01ynmCwgoQd74FzRAFxtQ7vqG9tMpa8APSDp/rDIlYYwx4nL3OmOtYFfR
 VQzBGBOlLWCV21XV7Qe9K4i8Y3PrI0c=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-Jq-TxIP3M2u5ciD_Nf0ZVg-1; Thu, 02 Nov 2023 07:36:07 -0400
X-MC-Unique: Jq-TxIP3M2u5ciD_Nf0ZVg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507a3ae32beso755231e87.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 04:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698924966; x=1699529766;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2O0rYDEJEF42OZQvPvEMiClXYnYaYD7RXT9fk5V2NAQ=;
 b=sSw0BYVctshfaidUAT+Ak20zVvrPmah4mb9flSumRTly8v1eFpOv0NtWIlCoNRCnY1
 m0QaEpq3OKa1I+R6OiMWtuD/7Wamq++4uObb8ChMjL6dzUYJB6safZD44cwHaNBlW0dp
 KBCPXfNG7Nt3MBibWnTfxcsVM9Hf9UVUORtCPCkpeakfGJH2dKW95b6iR+RiuSdR4+AW
 CG3UhqQS6vzkR4r/BWka7Oh7q5OfhjH4TElDw5v2aFH3vG4CC2UJNsTItYfO0ukUvqJt
 ExxwFsTptvU7AOMEcrm2NU7WguZ6WsqVllNW4WNqXCTMJwFesraxl+a9Wk1Dnr46vPo+
 oI1w==
X-Gm-Message-State: AOJu0YzpJoDke6Ae9ur6drpZrR8HjLS4BVAvHbqwzMm0jVjlvRijvuRw
 xHbeAhb1Dd9JE48NKTn5HkmVaT1el0ug53qi28sCz40sQVF3dvzFZ6A6P5yjT90g0oDVK9P02XQ
 jK6ghCrg602IlaA8=
X-Received: by 2002:a2e:9593:0:b0:2c5:70e:734a with SMTP id
 w19-20020a2e9593000000b002c5070e734amr14508408ljh.2.1698924965891; 
 Thu, 02 Nov 2023 04:36:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+P3SGWSdUlY6wxPezRPFaWMOjk+v+SU4Yn81kXt5sTgb5GIaHizupsiaTR7yTTcT9g4joNw==
X-Received: by 2002:a2e:9593:0:b0:2c5:70e:734a with SMTP id
 w19-20020a2e9593000000b002c5070e734amr14508378ljh.2.1698924965387; 
 Thu, 02 Nov 2023 04:36:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
 by smtp.gmail.com with ESMTPSA id
 n27-20020a05600c3b9b00b003feea62440bsm2625014wms.43.2023.11.02.04.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 04:36:04 -0700 (PDT)
Date: Thu, 2 Nov 2023 07:35:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, berrange@redhat.com, pbonzini@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 den-plotnikov@yandex-team.ru, yc-core@yandex-team.ru
Subject: Re: [PATCH v8 2/4] qapi: add DEVICE_ON and query-hotplug
 infrastructure
Message-ID: <20231102073212-mutt-send-email-mst@kernel.org>
References: <20231005092926.56231-1-vsementsov@yandex-team.ru>
 <20231005092926.56231-3-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005092926.56231-3-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

On Thu, Oct 05, 2023 at 12:29:24PM +0300, Vladimir Sementsov-Ogievskiy wrote:
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
>  hw/core/hotplug.c      |  12 ++++
>  include/hw/hotplug.h   |  11 ++++
>  include/hw/qdev-core.h |   7 +++
>  include/monitor/qdev.h |   2 +
>  qapi/qdev.json         | 135 +++++++++++++++++++++++++++++++++++++++++
>  softmmu/qdev-monitor.c |  41 +++++++++++++
>  6 files changed, 208 insertions(+)
> 
> diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
> index 17ac986685..9651fe7c85 100644
> --- a/hw/core/hotplug.c
> +++ b/hw/core/hotplug.c
> @@ -57,6 +57,18 @@ void hotplug_handler_unplug(HotplugHandler *plug_handler,
>      }
>  }
>  
> +HotplugInfo *hotplug_handler_get_state(HotplugHandler *plug_handler,
> +                                       DeviceState *plugged_dev, Error **errp)
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
>  static const TypeInfo hotplug_handler_info = {
>      .name          = TYPE_HOTPLUG_HANDLER,
>      .parent        = TYPE_INTERFACE,
> diff --git a/include/hw/hotplug.h b/include/hw/hotplug.h
> index a9840ed485..23c57a0967 100644
> --- a/include/hw/hotplug.h
> +++ b/include/hw/hotplug.h
> @@ -13,6 +13,7 @@
>  #define HOTPLUG_H
>  
>  #include "qom/object.h"
> +#include "qapi/qapi-types-qdev.h"
>  
>  #define TYPE_HOTPLUG_HANDLER "hotplug-handler"
>  
> @@ -60,6 +61,8 @@ struct HotplugHandlerClass {
>      hotplug_fn unplug_request;
>      hotplug_fn unplug;
>      bool (*is_hotpluggable_bus)(HotplugHandler *plug_handler, BusState *bus);
> +    HotplugInfo *(*get_hotplug_state)(HotplugHandler *plug_handler,
> +                                      DeviceState *plugged_dev, Error **errp);
>  };
>  
>  /**
> @@ -96,4 +99,12 @@ void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
>  void hotplug_handler_unplug(HotplugHandler *plug_handler,
>                              DeviceState *plugged_dev,
>                              Error **errp);
> +
> +/**
> + * hotplug_handler_get_state:
> + *
> + * Calls #HotplugHandlerClass.get_hotplug_state callback of @plug_handler.
> + */
> +HotplugInfo *hotplug_handler_get_state(HotplugHandler *plug_handler,
> +                                       DeviceState *plugged_dev, Error **errp);
>  #endif
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 151d968238..a27ef2eb24 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -229,6 +229,13 @@ struct DeviceState {
>       * @realized: has device been realized?
>       */
>      bool realized;
> +
> +    /**
> +     * @device_on_event_sent: When true means that DEVICE_ON event was already
> +     *                        sent.
> +     */
> +    bool device_on_event_sent;
> +
>      /**
>       * @pending_deleted_event: track pending deletion events during unplug
>       */
> diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
> index 1d57bf6577..c1c8798e89 100644
> --- a/include/monitor/qdev.h
> +++ b/include/monitor/qdev.h
> @@ -36,4 +36,6 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>   */
>  const char *qdev_set_id(DeviceState *dev, char *id, Error **errp);
>  
> +void qdev_hotplug_device_on_event(DeviceState *dev);
> +
>  #endif
> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 2899fac837..fa80694735 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -180,3 +180,138 @@
>  #      "timestamp": { "seconds": 1615570772, "microseconds": 202844 } }
>  ##
>  { 'event': 'DEVICE_UNPLUG_GUEST_ERROR', 'data': 'DeviceAndPath' }
> +
> +##
> +# @LedStatus:
> +#
> +# @on: LED is on.
> +#
> +# @blinking: LED is blinking.
> +#
> +# @off: LED is off.
> +#
> +# Since: 8.2
> +##
> +{ 'enum': 'LedStatus',
> +  'data': [ 'on', 'blinking', 'off' ] }
> +

Querying LED status is by itself a reasonable thing.
It's under guest control though - how do we avoid
a flood of events?


> +##
> +# @HotplugSHPCSlotState:
> +#
> +# Standard Hot-Plug Controller slot state.
> +#
> +# @power-only: Slot is powered on, but neither clock nor bus are
> +#     connected.
> +#
> +# @enabled: Slot is powered on, clock and bus are connected, and the
> +#     card is fully functional from a hardware standpoint.
> +#
> +# @disabled: Slot is disabled, card is safe to be removed.
> +#

Are these really the only 3 states a slot can be in?
And do we care about power-only?


> +# Since: 8.2
> +##
> +{ 'enum': 'HotplugSHPCSlotState',
> +  'data': [ 'power-only', 'enabled', 'disabled' ] }
> +
> +##
> +# @HotplugSHPCState:
> +#
> +# Standard Hot Plug Controller state.
> +#
> +# @slot-state: The slot state field of SHPC Slot Status structure.
> +#
> +# Since: 8.2
> +##
> +{ 'struct': 'HotplugSHPCState',
> +  'data': { '*slot-state': 'HotplugSHPCSlotState' } }
> +
> +##
> +# @HotplugPCIeNativeState:
> +#
> +# PCIe Native hotplug slot state.
> +#
> +# @power-on: PCIe Power Controller Control of Slot Control Register.
> +#     True means Power On (Power Controller Control bit is 0), False
> +#     means Power Off (Power Controller Control bit is 1).
> +#
> +# Since: 8.2
> +##
> +{ 'struct': 'HotplugPCIeNativeState',
> +  'data': { '*power-on': 'bool' } }

and here we don't care about enable?

> +
> +##
> +# @HotplugType:
> +#
> +# Type of hotplug controller / provider.
> +#
> +# @shpc: PCI Standard Hot-plug Controller
> +#
> +# @pcie-native: PCIe Native hotplug
> +#
> +# TODO: add @acpi type
> +#
> +# Since: 8.2
> +##
> +{ 'enum': 'HotplugType',
> +  'data': ['shpc', 'pcie-native'] }
> +
> +##
> +# @HotplugInfo:
> +#
> +# Hotplug slot state.
> +#
> +# @type: type of the hotplug
> +#
> +# @bus: The QOM path of the parent bus where device is plugged into.
> +#
> +# @addr: The bus address for hotplugged device if applicable.
> +#
> +# @child: the hotplugged device
> +#
> +# @device-on: Device is powered-on by guest.  This state changes at
> +#     most once for the device and corresponds to DEVICE_ON event.
> +#
> +# @power-led: Power indicator.  When power LED is on the device is
> +#     ready and accepted by guest.  When it is off, device is safe to
> +#     remove.  It is blinking while hot plug or unplug is in progress.
> +#
> +# @attention-led: The attention LED is normally off.  It is on to
> +#     signal a problem.  Blinking is for helping users to locate the
> +#     slot.
> +#
> +# Single: 8.2
> +##
> +{ 'union': 'HotplugInfo',
> +  'base': { 'type': 'HotplugType',
> +            'bus': 'DeviceAndPath',
> +            '*addr': 'str',
> +            'child': 'DeviceAndPath',
> +            'device-on': 'bool',
> +            '*power-led': 'LedStatus',
> +            '*attention-led': 'LedStatus'},
> +  'discriminator': 'type',
> +  'data': { 'shpc': 'HotplugSHPCState',
> +            'pcie-native': 'HotplugPCIeNativeState' } }
> +

What about ACPI hotplug?



> +##
> +# @x-query-hotplug:
> +#
> +# Query the state of hotplug controller.
> +#
> +# @id: the device's ID or QOM path
> +#
> +# Since: 8.2
> +##
> +{ 'command': 'x-query-hotplug',
> +  'data': { 'id': 'str' },
> +  'returns': 'HotplugInfo' }
> +
> +##
> +# @X_DEVICE_ON:
> +#
> +# Emitted whenever the device insertion completion is acknowledged by
> +# the guest.  For now only emitted for SHPC and PCIe-native hotplug.
> +#
> +# Since: 8.2
> +##
> +{ 'event': 'X_DEVICE_ON', 'data': 'DeviceAndPath' }
> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index 74f4e41338..483da40cb9 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -25,6 +25,7 @@
>  #include "sysemu/arch_init.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-qdev.h"
> +#include "qapi/qapi-events-qdev.h"
>  #include "qapi/qmp/dispatch.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qerror.h"
> @@ -956,6 +957,36 @@ void qmp_device_del(const char *id, Error **errp)
>      }
>  }
>  
> +HotplugInfo *qmp_x_query_hotplug(const char *id, Error **errp)
> +{
> +    DeviceState *dev = find_device_state(id, errp);
> +    HotplugHandler *hotplug_ctrl;
> +
> +    if (!dev) {
> +        return NULL;
> +    }
> +
> +    if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
> +        error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
> +        return NULL;
> +    }
> +
> +    if (!DEVICE_GET_CLASS(dev)->hotpluggable) {
> +        error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
> +                   object_get_typename(OBJECT(dev)));
> +        return NULL;
> +    }
> +
> +    hotplug_ctrl = qdev_get_hotplug_handler(dev);
> +    /*
> +     * hotpluggable device MUST have HotplugHandler, if it doesn't
> +     * then something is very wrong with it.
> +     */
> +    g_assert(hotplug_ctrl);
> +
> +    return hotplug_handler_get_state(hotplug_ctrl, dev, errp);
> +}
> +
>  void hmp_device_add(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
> @@ -1146,3 +1177,13 @@ bool qmp_command_available(const QmpCommand *cmd, Error **errp)
>      }
>      return true;
>  }
> +
> +void qdev_hotplug_device_on_event(DeviceState *dev)
> +{
> +    if (dev->device_on_event_sent) {
> +        return;
> +    }
> +
> +    dev->device_on_event_sent = true;
> +    qapi_event_send_x_device_on(dev->id, dev->canonical_path);
> +}
> -- 
> 2.34.1



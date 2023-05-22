Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C4670BA51
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 12:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1359-0000aU-QX; Mon, 22 May 2023 06:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q134y-0000Zx-03
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q134w-00023s-1s
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684752468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Ckynoxxz7ZiD6JabSu/mB3zN3lK5Ok8/ghdJEmf0I0=;
 b=iRfpejusnZt8GI2n6YV9D4OHfCPp28Bhc44Z0H2YHBQxfKTraXCXejT85kyz7MFczoyesj
 etC8yfr/u6Yeik/VGsx9qxcnyPmIdwJwFLaP3YIQ4MxPsCvAdCvM9eaZDC+EDcbg9bBGbW
 vcxsG7pGSo1VFtOBdwBu2BIJfCYlxpw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-_PlS-XMQPbysGe8f6TEZ2g-1; Mon, 22 May 2023 06:47:31 -0400
X-MC-Unique: _PlS-XMQPbysGe8f6TEZ2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 560B13C025AD;
 Mon, 22 May 2023 10:47:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAD392166B25;
 Mon, 22 May 2023 10:47:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C6F0D21E692E; Mon, 22 May 2023 12:47:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com,  eblake@redhat.com,
 eduardo@habkost.net,  berrange@redhat.com,  pbonzini@redhat.com,
 marcel.apfelbaum@gmail.com,  mst@redhat.com,  philmd@linaro.org,
 antonkuchin@yandex-team.ru,  den-plotnikov@yandex-team.ru
Subject: Re: [PATCH v7 2/4] qapi: add DEVICE_ON and query-hotplug
 infrastructure
References: <20230421103207.845847-1-vsementsov@yandex-team.ru>
 <20230421103207.845847-3-vsementsov@yandex-team.ru>
Date: Mon, 22 May 2023 12:47:29 +0200
In-Reply-To: <20230421103207.845847-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 21 Apr 2023 13:32:05 +0300")
Message-ID: <87zg5wlk1q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

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

Events often need to be paired with a query to let the management
application resynchronize after a QMP disconnect, say for a restart.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Do we have libvirt patches?  If not, is anybody working on them?  If
not, we need at least interface review by a libvirt developer familiar
with hot-plug.  And we might want to mark the interface experimental.

[...]

> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 135cd81586..ffd20c43e0 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -173,3 +173,147 @@
>  #
>  ##
>  { 'event': 'DEVICE_UNPLUG_GUEST_ERROR', 'data': 'DeviceAndPath' }
> +
> +##
> +# @LedActivity:

Not sure about "Activity".  "Status"?

> +#
> +# Three-state led indicator state.

Scratch the sentence?

> +#
> +# @on: Indicator is on.
> +#
> +# @blink: Indicator is blinking.
> +#
> +# @off: Indicator is off.

Suggest "LED is on" ans so forth.

> +#
> +# Since: 8.1
> +##
> +{ 'enum': 'LedActivity',
> +  'data': [ 'on', 'blink', 'off' ] }

Suggest 'blinking'.

> +
> +##
> +# @HotplugSHPCSlotState:
> +#
> +# Standard Hot-Plug Controller slot state.
> +#
> +# @power-only: Slot is powered on but neither clock nor bus are connected.

Comma after "on"?

> +#
> +# @enabled: Slot is powered on, clock and bus are connected, the card is
> +#           fully functional from a hardware standpoint.

Suggest ", and the card"

Please format like

   # @power-only: Slot is powered on, but neither clock nor bus are
   #     connected.
   #
   # @enabled: Slot is powered on, clock and bus are connected, and the
   #     card is fully functional from a hardware standpoint.

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

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

Suggest something like "When the power LED is on, the device is ...
When it is off, the device is ...  It is blinking while hot plug or
unplug is in progress."

> +#
> +# @attention-led: Attention indicator. Off status means normal operation,
> +#                 On signals about operational problem, Blinking is for
> +#                 locating the slot.

Suggest something like "The attention LED is normally off.  It is on to
signal a a problem.  Blinking is for helping users to locate the slot."

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

Color me confused.  What's "Slot Status"?

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

hot-plug

More below, not flagging it there.

> +#
> +# @power-on: PCIe Power Controller Control of Slot Control Register.
> +#            True means Power On (Power Controller Control bit is 0),
> +#            False means Power Off (Power Controller Control bit is 1).

Please format like

    # @power-on: PCIe Power Controller Control of Slot Control Register.
    #     True means Power On (Power Controller Control bit is 0), and
    #     False means Power Off (Power Controller Control bit is 1).

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

Suggest "PCI Standard Hot-plug Controller", because that's how the spec
seems to spell it.

> +#
> +# @pcie-native: PCIe Native hotplug

What about non-PCI hot-plug?

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

Well, the generic part is defined here, but the union type pulls in
controller-specific parts.  Scratch "generic"?

> +#
> +# @type: type of the hotplug (shpc or pcie-native)

Repeating enum values in doc comments risks them going stale there.
Scratch the parenthesis?

> +#
> +# @bus: The QOM path of the parent bus where device is hotplugged.

Is this the bus the device is plugged into?

What about bus-less devices?  Hmm, I think we can make an argument that
the infrastructure required to make hot-plug work will always be part of
some kind of bus.  Does this make sense to you?

> +#
> +# @addr: The bus address for hotplugged device if applicable.

Uh, does this encode structured data in a string?

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

You have data common to both types in two places: base of HotplugInfo
and base of the variant types HotplugBaseState.  Why?

> +
> +##
> +# @query-hotplug:
> +#
> +# Query the state of hotplug controller.
> +#

@id is undocumented.

> +# Since: 8.1
> +##
> +{ 'command': 'query-hotplug',
> +  'data': { 'id': 'str' },
> +  'returns': 'HotplugInfo' }

I have more questions, but I'd like to understand the meaning of @id
before I type them up.

> +
> +##
> +# @DEVICE_ON:
> +#
> +# Emitted whenever the device insertion completion is acknowledged by the guest.
> +# For now only emitted for SHPC and PCIe-native hotplug.

Please format like

   # Emitted whenever the device insertion completion is acknowledged by
   # the guest.  For now only emitted for SHPC and PCIe-native hotplug.

> +#
> +# Since: 8.1
> +##
> +{ 'event': 'DEVICE_ON', 'data': 'DeviceAndPath' }

[...]



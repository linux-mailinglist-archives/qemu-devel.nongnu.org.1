Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB35A8B8708
	for <lists+qemu-devel@lfdr.de>; Wed,  1 May 2024 10:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s25fa-0002u3-Lo; Wed, 01 May 2024 04:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s25fX-0002st-4u; Wed, 01 May 2024 04:50:27 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s25fT-0005rz-As; Wed, 01 May 2024 04:50:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6CDB060913;
 Wed,  1 May 2024 11:50:14 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8829::1:3c] (unknown
 [2a02:6b8:b081:8829::1:3c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id CoNfHq11UKo0-Y7qdq7Y4; Wed, 01 May 2024 11:50:13 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714553413;
 bh=RFlXxvucgeuj68yVjlNqCzYnsHI52ilFoDthrBiLt1s=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=oRQzxZwPRLSHAcJ489ea6wgrmQtrdD8jMGHMYrDaiUH+lkR+DR52R/46DHdiLY985
 vkkSX1CYEuOB0Hucc09tyk0IF0LAOPIB4OXNQWqUedPfedSbolo1bWQsh00nKOIZkt
 OYdA2pvaKe8ybK3+YNKw2MkCcjG8JMzDtmGqxMtw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a5993c67-6631-4fd0-a67b-c9dd52596030@yandex-team.ru>
Date: Wed, 1 May 2024 11:50:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] qapi: introduce device-sync-config
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, raphael@enfabrica.net, mst@redhat.com,
 qemu-devel@nongnu.org, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, hreitz@redhat.com,
 kwolf@redhat.com, yc-core@yandex-team.ru
References: <20240429101623.1992943-1-vsementsov@yandex-team.ru>
 <20240429101623.1992943-4-vsementsov@yandex-team.ru>
 <877cgfcley.fsf@pond.sub.org>
 <2f3f4354-7a98-48e9-84fa-4962f129a26f@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <2f3f4354-7a98-48e9-84fa-4962f129a26f@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 30.04.24 11:31, Vladimir Sementsov-Ogievskiy wrote:
> On 30.04.24 11:19, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>
>>> Add command to sync config from vhost-user backend to the device. It
>>> may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
>>> triggered interrupt to the guest or just not available (not supported
>>> by vhost-user server).
>>>
>>> Command result is racy if allow it during migration. Let's allow the
>>> sync only in RUNNING state.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>   hw/block/vhost-user-blk.c |  1 +
>>>   hw/virtio/virtio-pci.c    |  9 ++++++++
>>>   include/hw/qdev-core.h    |  3 +++
>>>   qapi/qdev.json            | 23 +++++++++++++++++++
>>>   system/qdev-monitor.c     | 48 +++++++++++++++++++++++++++++++++++++++
>>>   5 files changed, 84 insertions(+)
>>>
>>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>>> index 091d2c6acf..2f301f380c 100644
>>> --- a/hw/block/vhost-user-blk.c
>>> +++ b/hw/block/vhost-user-blk.c
>>> @@ -588,6 +588,7 @@ static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
>>>       device_class_set_props(dc, vhost_user_blk_properties);
>>>       dc->vmsd = &vmstate_vhost_user_blk;
>>> +    dc->sync_config = vhost_user_blk_sync_config;
>>>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>>>       vdc->realize = vhost_user_blk_device_realize;
>>>       vdc->unrealize = vhost_user_blk_device_unrealize;
>>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>>> index b1d02f4b3d..0d91e8b5dc 100644
>>> --- a/hw/virtio/virtio-pci.c
>>> +++ b/hw/virtio/virtio-pci.c
>>> @@ -2351,6 +2351,14 @@ static void virtio_pci_dc_realize(DeviceState *qdev, Error **errp)
>>>       vpciklass->parent_dc_realize(qdev, errp);
>>>   }
>>> +static int virtio_pci_sync_config(DeviceState *dev, Error **errp)
>>> +{
>>> +    VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
>>> +    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>>> +
>>> +    return qdev_sync_config(DEVICE(vdev), errp);
>>> +}
>>> +
>>>   static void virtio_pci_class_init(ObjectClass *klass, void *data)
>>>   {
>>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>> @@ -2367,6 +2375,7 @@ static void virtio_pci_class_init(ObjectClass *klass, void *data)
>>>       device_class_set_parent_realize(dc, virtio_pci_dc_realize,
>>>                                       &vpciklass->parent_dc_realize);
>>>       rc->phases.hold = virtio_pci_bus_reset_hold;
>>> +    dc->sync_config = virtio_pci_sync_config;
>>>   }
>>>   static const TypeInfo virtio_pci_info = {
>>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>>> index 9228e96c87..87135bdcdf 100644
>>> --- a/include/hw/qdev-core.h
>>> +++ b/include/hw/qdev-core.h
>>> @@ -95,6 +95,7 @@ typedef void (*DeviceUnrealize)(DeviceState *dev);
>>>   typedef void (*DeviceReset)(DeviceState *dev);
>>>   typedef void (*BusRealize)(BusState *bus, Error **errp);
>>>   typedef void (*BusUnrealize)(BusState *bus);
>>> +typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
>>>   /**
>>>    * struct DeviceClass - The base class for all devices.
>>> @@ -162,6 +163,7 @@ struct DeviceClass {
>>>       DeviceReset reset;
>>>       DeviceRealize realize;
>>>       DeviceUnrealize unrealize;
>>> +    DeviceSyncConfig sync_config;
>>>       /**
>>>        * @vmsd: device state serialisation description for
>>> @@ -546,6 +548,7 @@ bool qdev_hotplug_allowed(DeviceState *dev, Error **errp);
>>>    */
>>>   HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
>>>   void qdev_unplug(DeviceState *dev, Error **errp);
>>> +int qdev_sync_config(DeviceState *dev, Error **errp);
>>>   void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
>>>                                     DeviceState *dev, Error **errp);
>>>   void qdev_machine_creation_done(void);
>>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>>> index facaa0bc6a..fc5e125a45 100644
>>> --- a/qapi/qdev.json
>>> +++ b/qapi/qdev.json
>>> @@ -161,3 +161,26 @@
>>>   ##
>>>   { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
>>>     'data': { '*device': 'str', 'path': 'str' } }
>>> +
>>> +##
>>> +# @device-sync-config:
>>> +#
>>> +# Synchronize device configuration from host to guest part.  First,
>>> +# copy the configuration from the host part (backend) to the guest
>>> +# part (frontend).  Then notify guest software that device
>>> +# configuration changed.
>>
>> Blank line here, please.
>>
>>> +# The command may be used to notify the guest about block device
>>> +# capcity change.  Currently only vhost-user-blk device supports
>>> +# this.
>>> +#
>>> +# @id: the device's ID or QOM path
>>> +#
>>> +# Features:
>>> +#
>>> +# @unstable: The command is experimental.
>>> +#
>>> +# Since: 9.1
>>> +##
>>> +{ 'command': 'device-sync-config',
>>> +  'features': [ 'unstable' ],
>>> +  'data': {'id': 'str'} }
>>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>>> index 264978aa40..47bfc0506e 100644
>>> --- a/system/qdev-monitor.c
>>> +++ b/system/qdev-monitor.c
>>> @@ -23,6 +23,7 @@
>>>   #include "monitor/monitor.h"
>>>   #include "monitor/qdev.h"
>>>   #include "sysemu/arch_init.h"
>>> +#include "sysemu/runstate.h"
>>>   #include "qapi/error.h"
>>>   #include "qapi/qapi-commands-qdev.h"
>>>   #include "qapi/qmp/dispatch.h"
>>> @@ -971,6 +972,53 @@ void qmp_device_del(const char *id, Error **errp)
>>>       }
>>>   }
>>> +int qdev_sync_config(DeviceState *dev, Error **errp)
>>> +{
>>> +    DeviceClass *dc = DEVICE_GET_CLASS(dev);
>>> +
>>> +    if (!dc->sync_config) {
>>> +        error_setg(errp, "device-sync-config is not supported for '%s'",
>>> +                   object_get_typename(OBJECT(dev)));
>>> +        return -ENOTSUP;
>>> +    }
>>> +
>>> +    return dc->sync_config(dev, errp);
>>> +}
>>> +
>>> +void qmp_device_sync_config(const char *id, Error **errp)
>>> +{
>>> +    DeviceState *dev;
>>> +
>>> +    /*
>>> +     * During migration there is a race between syncing`configuration and
>>> +     * migrating it (if migrate first, that target would get outdated version),
>>> +     * so let's just not allow it.
>>
>> Wrap comment lines around column 70 for legibility, please.
>>
>>> +     *
>>> +     * Moreover, let's not rely on setting up interrupts in paused
>>> +     * state, which may be a part of migration process.
>>
>> We discussed this in review of v3.  You wanted to check whether the
>> problem is real.  Is it?
> 
> We discussed it later than I've sent v4 :) No, I didn't check yet.

Checked. Seems this works (in scheme pause -> migrate -> resume, interrupts are migrated and triggered on target after resume), so my doubt was wrong.

> 
>>
>>> +     */
>>> +
>>> +    if (migration_is_running()) {
>>> +        error_setg(errp, "Config synchronization is not allowed "
>>> +                   "during migration");
>>> +        return;
>>> +    }
>>> +
>>> +    if (!runstate_is_running()) {
>>> +        error_setg(errp, "Config synchronization allowed only in '%s' state, "
>>
>> Suggest a line break after errp,
>>
>>> +                   "current state is '%s'", RunState_str(RUN_STATE_RUNNING),
>>> +                   RunState_str(runstate_get()));
>>> +        return;
>>> +    }
>>> +
>>> +    dev = find_device_state(id, true, errp);
>>> +    if (!dev) {
>>> +        return;
>>> +    }
>>> +
>>> +    qdev_sync_config(dev, errp);
>>> +}
>>> +
>>>   void hmp_device_add(Monitor *mon, const QDict *qdict)
>>>   {
>>>       Error *err = NULL;
>>
> 

-- 
Best regards,
Vladimir



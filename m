Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D83F27CC7BD
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:45:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsmF6-0004WG-4Q; Tue, 17 Oct 2023 11:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsmEv-0004V1-Ev; Tue, 17 Oct 2023 11:44:14 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsmEr-00023J-Sg; Tue, 17 Oct 2023 11:44:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7d8a:0:640:8fc3:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 418FD625BD;
 Tue, 17 Oct 2023 18:44:05 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8006::1:24] (unknown
 [2a02:6b8:b081:8006::1:24])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3imqi8BOcmI0-BWPB5GIc; Tue, 17 Oct 2023 18:44:04 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697557444;
 bh=c//YX3gF8H3lItywUo/DysjMhtfuSc3yCw8LvMJjrrc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Ngq0Pyvn6sC52Z4TvwV+A+jLLyyyk1a2bjSoGa5ro7LZ5sMsyZmVjjGaP5zXyZk0p
 PdqhOwpk40Yi+L+9hQpoNZN10esHHQyPHbqO+rwjS97KYQrL6J5/r0ZEsrJzfLLe+I
 PecOoiRTMQiWYYIW7zzj2NnvHY3m6eZcN4wSIT+4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ae494c44-1bd6-435e-8bd8-0ec2ba9ceaa6@yandex-team.ru>
Date: Tue, 17 Oct 2023 18:44:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] qapi: introduce CONFIG_READ event
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com,
 dave@treblig.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 raphael.norwitz@nutanix.com, mst@redhat.com, yc-core@yandex-team.ru,
 den-plotnikov@yandex-team.ru, daniil.tatianin@yandex.ru
References: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
 <20231006202045.1161543-5-vsementsov@yandex-team.ru>
 <87sf692t0i.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87sf692t0i.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 17.10.23 18:00, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Send a new event when guest reads virtio-pci config after
>> virtio_notify_config() call.
>>
>> That's useful to check that guest fetched modified config, for example
>> after resizing disk backend.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   hw/virtio/virtio-pci.c |  9 +++++++++
>>   include/monitor/qdev.h |  1 +
>>   monitor/monitor.c      |  1 +
>>   qapi/qdev.json         | 22 ++++++++++++++++++++++
>>   softmmu/qdev-monitor.c |  5 +++++
>>   5 files changed, 38 insertions(+)
>>
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index dd4620462b..f24f8ff03d 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -23,6 +23,7 @@
>>   #include "hw/boards.h"
>>   #include "hw/virtio/virtio.h"
>>   #include "migration/qemu-file-types.h"
>> +#include "monitor/qdev.h"
>>   #include "hw/pci/pci.h"
>>   #include "hw/pci/pci_bus.h"
>>   #include "hw/qdev-properties.h"
>> @@ -541,6 +542,10 @@ static uint64_t virtio_pci_config_read(void *opaque, hwaddr addr,
>>       }
>>       addr -= config;
>>   
>> +    if (vdev->generation > 0) {
>> +        qdev_config_read_event(DEVICE(proxy));
>> +    }
>> +
>>       switch (size) {
>>       case 1:
>>           val = virtio_config_readb(vdev, addr);
>> @@ -1728,6 +1733,10 @@ static uint64_t virtio_pci_device_read(void *opaque, hwaddr addr,
>>           return UINT64_MAX;
>>       }
>>   
>> +    if (vdev->generation > 0) {
>> +        qdev_config_read_event(DEVICE(proxy));
>> +    }
>> +
>>       switch (size) {
>>       case 1:
>>           val = virtio_config_modern_readb(vdev, addr);
>> diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
>> index 949a3672cb..f0b0eab07e 100644
>> --- a/include/monitor/qdev.h
>> +++ b/include/monitor/qdev.h
>> @@ -39,6 +39,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>>   const char *qdev_set_id(DeviceState *dev, char *id, Error **errp);
>>   
>>   void qdev_hotplug_device_on_event(DeviceState *dev);
>> +void qdev_config_read_event(DeviceState *dev);
>>   
>>   DeviceAndPath *qdev_new_device_and_path(DeviceState *dev);
>>   
>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>> index 941f87815a..f8aa91b190 100644
>> --- a/monitor/monitor.c
>> +++ b/monitor/monitor.c
>> @@ -315,6 +315,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>>       [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
>>       [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
>>       [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
>> +    [QAPI_EVENT_X_CONFIG_READ]   = { 300 * SCALE_MS },
>>   };
>>   
>>   /*
>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>> index 2468f8bddf..37a8785b81 100644
>> --- a/qapi/qdev.json
>> +++ b/qapi/qdev.json
>> @@ -329,3 +329,25 @@
>>   # Since: 8.2
>>   ##
>>   { 'command': 'x-device-sync-config', 'data': {'id': 'str'} }
>> +
>> +##
>> +# @X_CONFIG_READ:
>> +#
>> +# Emitted whenever guest reads virtio device config after config change.
>> +#
>> +# @device: device name
>> +#
>> +# @path: device path
>> +#
>> +# Since: 5.0.1-24
>> +#
>> +# Example:
>> +#
>> +# <- { "event": "X_CONFIG_READ",
>> +#      "data": { "device": "virtio-net-pci-0",
>> +#                "path": "/machine/peripheral/virtio-net-pci-0" },
>> +#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
>> +#
>> +##
>> +{ 'event': 'X_CONFIG_READ',
>> +  'data': { '*device': 'str', 'path': 'str' } }
> 
> The commit message talks about event CONFIG_READ, but you actually name
> it x-device-sync-config.

will fix

> 
> I figure you use x- to signify "unstable".  Please use feature flag
> 'unstable' for that.  See docs/devel/qapi-code-gen.rst section
> "Features", in particular "Special features", and also the note on x- in
> section "Naming rules and reserved names".

OK, will do.

Hmm, it say

    Names beginning with ``x-`` used to signify "experimental".  This
    convention has been replaced by special feature "unstable".

"replaced".. So, I should use "unstable" flag without "x-" prefix? Can't find an example. Seems "unstable" always used together with "x-".

Also, nothing said about events. Is using "X_" wrong idea? Should it be x-SOME_EVENT instead?

> 
> The name CONFIG_READ feels overly generic for something that makes sense
> only with virtio devices.

Hmm, right.. I think, we can say same thing about DEVICE_UNPLUG_GUEST_ERROR.

So, what about DEVICE_GUEST_READ_CONFIG ?

> 
>> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
>> index b485375049..d0f022e925 100644
>> --- a/softmmu/qdev-monitor.c
>> +++ b/softmmu/qdev-monitor.c
>> @@ -1252,3 +1252,8 @@ void qdev_hotplug_device_on_event(DeviceState *dev)
>>       dev->device_on_event_sent = true;
>>       qapi_event_send_x_device_on(dev->id, dev->canonical_path);
>>   }
>> +
>> +void qdev_config_read_event(DeviceState *dev)
>> +{
>> +    qapi_event_send_x_config_read(dev->id, dev->canonical_path);
>> +}
> 

-- 
Best regards,
Vladimir



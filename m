Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7E17CC6EF
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:01:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qslZ0-0000S5-V2; Tue, 17 Oct 2023 11:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qslYz-0000Qg-FU
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qslYx-0001Eo-B1
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697554850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=byNnCbEj9YiZcY1rgnXgSS3HPso0UhWHVZwaqc0EtPQ=;
 b=UeEO0Z8M84wmB1Ef4EpzsmhJiQv7yjBTTT2ZsR+u+zlOnr9cx/Rl3M/RQyG3k/1a4r4XSX
 htvyRfI3MqrL7K3VFwft3YDyXF5tQKBv+azcCEy3RHyLSZIVvUBV0L/EMKZuoi5gGLiBff
 dSRTO+nZYdFXpEHqklBLH//zNtKi4Vc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-5GpkWnA1OmGy-kqC-yLA_g-1; Tue, 17 Oct 2023 11:00:47 -0400
X-MC-Unique: 5GpkWnA1OmGy-kqC-yLA_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7345B81D9EC;
 Tue, 17 Oct 2023 15:00:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3150F1121314;
 Tue, 17 Oct 2023 15:00:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A68121E6A1F; Tue, 17 Oct 2023 17:00:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  eblake@redhat.com,
 dave@treblig.org,  eduardo@habkost.net,  berrange@redhat.com,
 pbonzini@redhat.com,  hreitz@redhat.com,  kwolf@redhat.com,
 raphael.norwitz@nutanix.com,  mst@redhat.com,  yc-core@yandex-team.ru,
 den-plotnikov@yandex-team.ru,  daniil.tatianin@yandex.ru
Subject: Re: [PATCH 4/4] qapi: introduce CONFIG_READ event
References: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
 <20231006202045.1161543-5-vsementsov@yandex-team.ru>
Date: Tue, 17 Oct 2023 17:00:45 +0200
In-Reply-To: <20231006202045.1161543-5-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 6 Oct 2023 23:20:45 +0300")
Message-ID: <87sf692t0i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> Send a new event when guest reads virtio-pci config after
> virtio_notify_config() call.
>
> That's useful to check that guest fetched modified config, for example
> after resizing disk backend.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/virtio-pci.c |  9 +++++++++
>  include/monitor/qdev.h |  1 +
>  monitor/monitor.c      |  1 +
>  qapi/qdev.json         | 22 ++++++++++++++++++++++
>  softmmu/qdev-monitor.c |  5 +++++
>  5 files changed, 38 insertions(+)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index dd4620462b..f24f8ff03d 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -23,6 +23,7 @@
>  #include "hw/boards.h"
>  #include "hw/virtio/virtio.h"
>  #include "migration/qemu-file-types.h"
> +#include "monitor/qdev.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/qdev-properties.h"
> @@ -541,6 +542,10 @@ static uint64_t virtio_pci_config_read(void *opaque, hwaddr addr,
>      }
>      addr -= config;
>  
> +    if (vdev->generation > 0) {
> +        qdev_config_read_event(DEVICE(proxy));
> +    }
> +
>      switch (size) {
>      case 1:
>          val = virtio_config_readb(vdev, addr);
> @@ -1728,6 +1733,10 @@ static uint64_t virtio_pci_device_read(void *opaque, hwaddr addr,
>          return UINT64_MAX;
>      }
>  
> +    if (vdev->generation > 0) {
> +        qdev_config_read_event(DEVICE(proxy));
> +    }
> +
>      switch (size) {
>      case 1:
>          val = virtio_config_modern_readb(vdev, addr);
> diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
> index 949a3672cb..f0b0eab07e 100644
> --- a/include/monitor/qdev.h
> +++ b/include/monitor/qdev.h
> @@ -39,6 +39,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>  const char *qdev_set_id(DeviceState *dev, char *id, Error **errp);
>  
>  void qdev_hotplug_device_on_event(DeviceState *dev);
> +void qdev_config_read_event(DeviceState *dev);
>  
>  DeviceAndPath *qdev_new_device_and_path(DeviceState *dev);
>  
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 941f87815a..f8aa91b190 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -315,6 +315,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>      [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
>      [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
>      [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_X_CONFIG_READ]   = { 300 * SCALE_MS },
>  };
>  
>  /*
> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 2468f8bddf..37a8785b81 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -329,3 +329,25 @@
>  # Since: 8.2
>  ##
>  { 'command': 'x-device-sync-config', 'data': {'id': 'str'} }
> +
> +##
> +# @X_CONFIG_READ:
> +#
> +# Emitted whenever guest reads virtio device config after config change.
> +#
> +# @device: device name
> +#
> +# @path: device path
> +#
> +# Since: 5.0.1-24
> +#
> +# Example:
> +#
> +# <- { "event": "X_CONFIG_READ",
> +#      "data": { "device": "virtio-net-pci-0",
> +#                "path": "/machine/peripheral/virtio-net-pci-0" },
> +#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
> +#
> +##
> +{ 'event': 'X_CONFIG_READ',
> +  'data': { '*device': 'str', 'path': 'str' } }

The commit message talks about event CONFIG_READ, but you actually name
it x-device-sync-config.

I figure you use x- to signify "unstable".  Please use feature flag
'unstable' for that.  See docs/devel/qapi-code-gen.rst section
"Features", in particular "Special features", and also the note on x- in
section "Naming rules and reserved names".

The name CONFIG_READ feels overly generic for something that makes sense
only with virtio devices.

> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index b485375049..d0f022e925 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -1252,3 +1252,8 @@ void qdev_hotplug_device_on_event(DeviceState *dev)
>      dev->device_on_event_sent = true;
>      qapi_event_send_x_device_on(dev->id, dev->canonical_path);
>  }
> +
> +void qdev_config_read_event(DeviceState *dev)
> +{
> +    qapi_event_send_x_config_read(dev->id, dev->canonical_path);
> +}



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF679E842
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:45:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPEd-0002tV-GN; Wed, 13 Sep 2023 08:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den-plotnikov@yandex-team.ru>)
 id 1qgPEM-0002i2-MG
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:44:32 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den-plotnikov@yandex-team.ru>)
 id 1qgPED-0008Nw-0O
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:44:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5429:0:640:6285:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 4183F5EF95;
 Wed, 13 Sep 2023 15:44:13 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b691::1:31] (unknown
 [2a02:6b8:b081:b691::1:31])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Aieors0OfKo0-DF3WesQ9; Wed, 13 Sep 2023 15:44:12 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1694609052;
 bh=gDLJnbfoQ9q+mRwWSvisU/n+D69fWboANpuCUBROPyo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VB7gRbOWrd09eHqFSCnEF42sxVsmF0DZwY0+iCGCPyORmKTszcNjfsHAR9ZLGOBbD
 8tke6ArJ07K9M6Q9smlfLgP1RHLRqRDWgp27A9IEVT6L4AyRXt+wUvmPYL+JDgFzLx
 S0QJlWX+PBmai5l4ETv89LAxhCUy6b8raZg8Z9Hc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b1bc0af3-8c3e-3e7f-a18c-dac1a8356469@yandex-team.ru>
Date: Wed, 13 Sep 2023 15:44:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] virtio: add VIRTQUEUE_ERROR QAPI event
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: yc-core@yandex-team.ru, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, dave@treblig.org,
 mst@redhat.com
References: <20230912175756.151047-1-vsementsov@yandex-team.ru>
From: Denis Plotnikov <den-plotnikov@yandex-team.ru>
In-Reply-To: <20230912175756.151047-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=den-plotnikov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>

On 9/12/23 20:57, Vladimir Sementsov-Ogievskiy wrote:
> For now we only log the vhost device error, when virtqueue is actually
> stopped. Let's add a QAPI event, which makes possible:
>
>   - collect statistics of such errors
>   - make immediate actions: take core dumps or do some other debugging
>   - inform the user through a management API or UI, so that (s)he can
>    react somehow, e.g. reset the device driver in the guest or even
>    build up some automation to do so
>
> Note that basically every inconsistency discovered during virtqueue
> processing results in a silent virtqueue stop.  The guest then just
> sees the requests getting stuck somewhere in the device for no visible
> reason.  This event provides a means to inform the management layer of
> this situation in a timely fashion.
>
> The event could be reused for some other virtqueue problems (not only
> for vhost devices) in future. For this it gets a generic name and
> structure.
>
> We keep original VHOST_OPS_DEBUG(), to keep original debug output as is
> here, it's not the only call to VHOST_OPS_DEBUG in the file.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>
> v2: - improve commit message (just stole wording by Roman, hope he don't
>                                mind:)
>      - add event throttling
>
>   hw/virtio/vhost.c | 12 +++++++++---
>   monitor/monitor.c | 10 ++++++++++
>   qapi/qdev.json    | 25 +++++++++++++++++++++++++
>   3 files changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e2f6ffb446..162899feee 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -15,6 +15,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> +#include "qapi/qapi-events-qdev.h"
>   #include "hw/virtio/vhost.h"
>   #include "qemu/atomic.h"
>   #include "qemu/range.h"
> @@ -1332,11 +1333,16 @@ static void vhost_virtqueue_error_notifier(EventNotifier *n)
>       struct vhost_virtqueue *vq = container_of(n, struct vhost_virtqueue,
>                                                 error_notifier);
>       struct vhost_dev *dev = vq->dev;
> -    int index = vq - dev->vqs;
>   
>       if (event_notifier_test_and_clear(n) && dev->vdev) {
> -        VHOST_OPS_DEBUG(-EINVAL,  "vhost vring error in virtqueue %d",
> -                        dev->vq_index + index);
> +        int ind = vq - dev->vqs + dev->vq_index;
> +        DeviceState *ds = &dev->vdev->parent_obj;
> +
> +        VHOST_OPS_DEBUG(-EINVAL,  "vhost vring error in virtqueue %d", ind);
> +        qapi_event_send_virtqueue_error(ds->id, ds->canonical_path, ind,
> +                                        VIRTQUEUE_ERROR_VHOST_VRING_ERR,
> +                                        "vhost reported failure through vring "
> +                                        "error fd");
>       }
>   }
>   
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 941f87815a..cb1ee31156 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -313,6 +313,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>       [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
>       [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
>       [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_VIRTQUEUE_ERROR]   = { 1000 * SCALE_MS },
>       [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
>       [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
>   };
> @@ -497,6 +498,10 @@ static unsigned int qapi_event_throttle_hash(const void *key)
>           hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
>       }
>   
> +    if (evstate->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
> +        hash += g_str_hash(qdict_get_str(evstate->data, "device"));
> +    }
> +
>       return hash;
>   }
>   
> @@ -524,6 +529,11 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
>                          qdict_get_str(evb->data, "qom-path"));
>       }
>   
> +    if (eva->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
> +        return !strcmp(qdict_get_str(eva->data, "device"),
> +                       qdict_get_str(evb->data, "device"));
> +    }
> +
>       return TRUE;
>   }
>   
> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 6bc5a733b8..199e21cae7 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -161,3 +161,28 @@
>   ##
>   { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
>     'data': { '*device': 'str', 'path': 'str' } }
> +
> +##
> +# @VirtqueueError:
> +#
> +# Since: 8.2
> +##
> +{ 'enum': 'VirtqueueError',
> +  'data': [ 'vhost-vring-err' ] }
> +
> +##
> +# @VIRTQUEUE_ERROR:
> +#
> +# Emitted when a device virtqueue fails in runtime.
> +#
> +# @device: the device's ID if it has one
> +# @path: the device's QOM path
> +# @virtqueue: virtqueue index
> +# @error: error identifier
> +# @description: human readable description
> +#
> +# Since: 8.2
> +##
> +{ 'event': 'VIRTQUEUE_ERROR',
> + 'data': { '*device': 'str', 'path': 'str', 'virtqueue': 'int',
> +            'error': 'VirtqueueError', 'description': 'str'} }


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729F8A78E7E
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Apr 2025 14:33:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzxGo-0000fX-Mi; Wed, 02 Apr 2025 08:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tzxGY-0000bC-C6
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 08:32:26 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tzxGT-0003fD-OW
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 08:32:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A5730609ED;
 Wed,  2 Apr 2025 15:32:12 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:1217::1:23] (unknown
 [2a02:6b8:b081:1217::1:23])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BWW16f0FYCg0-ifbOgzJJ; Wed, 02 Apr 2025 15:32:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1743597132;
 bh=p9Q/7VkbkPEGU99k97QbUh8fGLJS1rDMBDsqAId6KIg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=GIvWJSn1LZLfCESCPXeMVRwHPI+ylSaXB+L1NJ9a2tQ1EfeI1kAmpDM7n2R7lLwl5
 pVCUZWOWjGR7mqkCUgXC8oBcUIKptd3t8Smj4zDx1AeQ1evfp4QyjgT0un81K1Ipjq
 TtOsc5WWNMoDNs/ole+32A3+MAO8OYReSMeVR4Mw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4abdc4e4-9a2b-481a-8381-0d972fd89a68@yandex-team.ru>
Date: Wed, 2 Apr 2025 15:32:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] [for-10.1] virtio: add VIRTQUEUE_ERROR QAPI event
To: mst@redhat.com
Cc: sgarzare@redhat.com, armbru@redhat.com, dave@treblig.org,
 eblake@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, qemu-devel@nongnu.org,
 Denis Plotnikov <den-plotnikov@yandex-team.ru>
References: <20250401170731.121336-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250401170731.121336-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 01.04.25 20:07, Vladimir Sementsov-Ogievskiy wrote:
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
> Reviewed-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
> ---
> 
> v5: resend, update version in QAPI to 10.1
>      drop a-b by Markus (too much time passed, the context could
>      changed. Markus, is the patch still OK?)
> 
>   hw/virtio/vhost.c | 12 +++++++++---
>   monitor/monitor.c | 10 ++++++++++
>   qapi/qdev.json    | 32 ++++++++++++++++++++++++++++++++
>   3 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6aa72fd434..0b205cef73 100644
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
> @@ -1442,11 +1443,16 @@ static void vhost_virtqueue_error_notifier(EventNotifier *n)
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
> +                                        VIRTQUEUE_ERROR_VHOST_VRING_ERROR,
> +                                        "vhost reported failure through vring "
> +                                        "error fd");
>       }
>   }
>   
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index c5a5d30877..1296a9207e 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -313,6 +313,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>       [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
>       [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
>       [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_VIRTQUEUE_ERROR]   = { 1000 * SCALE_MS },
>       [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
>       [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
>       [QAPI_EVENT_HV_BALLOON_STATUS_REPORT] = { 1000 * SCALE_MS },
> @@ -499,6 +500,10 @@ static unsigned int qapi_event_throttle_hash(const void *key)
>           hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
>       }
>   
> +    if (evstate->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
> +        hash += g_str_hash(qdict_get_str(evstate->data, "device"));

Hmm we should use "qom-path" here, right?

> +    }
> +
>       return hash;
>   }
>   
> @@ -527,6 +532,11 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
>                          qdict_get_str(evb->data, "qom-path"));
>       }
>   
> +    if (eva->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
> +        return !strcmp(qdict_get_str(eva->data, "device"),
> +                       qdict_get_str(evb->data, "device"));

and here

> +    }
> +
>       return TRUE;
>   }
>   
> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 25cbcf977b..2d20f4777e 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -187,3 +187,35 @@
>   { 'command': 'device-sync-config',
>     'features': [ 'unstable' ],
>     'data': {'id': 'str'} }
> +
> +##
> +# @VirtqueueError:
> +#
> +# @vhost-vring-error: Vhost device reported failure through
> +#     through vring error fd.
> +#
> +# Since: 10.1
> +##
> +{ 'enum': 'VirtqueueError',
> +  'data': [ 'vhost-vring-error' ] }
> +
> +##
> +# @VIRTQUEUE_ERROR:
> +#
> +# Emitted when a device virtqueue fails in runtime.
> +#
> +# @device: the device's ID if it has one
> +#
> +# @path: the device's QOM path
> +#
> +# @virtqueue: virtqueue index
> +#
> +# @error: error identifier
> +#
> +# @description: human readable description
> +#
> +# Since: 10.1
> +##
> +{ 'event': 'VIRTQUEUE_ERROR',
> + 'data': { '*device': 'str', 'path': 'str', 'virtqueue': 'int',
> +            'error': 'VirtqueueError', 'description': 'str'} }

-- 
Best regards,
Vladimir



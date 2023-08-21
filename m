Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 808D67826C4
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 12:06:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY1mw-0005jL-80; Mon, 21 Aug 2023 06:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY1ms-0005j5-Jf
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 06:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY1mq-0003ZY-0B
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 06:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692612327;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RcsxCO40yfMmwnszlOwCtEvlVHI21Q9hLL8lzpOp0TQ=;
 b=Fsr6soY8TV9lCOjeqBDKbetFKwnz00KHeJYKSTeV7BRPoPKo9seOOZ0rz3MtasPNv8yLfp
 B2jp4/nfHC0CrTuKP/21HBGIA67FmWnq5Gt9LSpVxKezNF2EV7iSTnkQm2sdIgn3KCwvtg
 elxJ7Ep+5hR9wDyVfnQgeM4T5jPrthQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-693-AtqjKZowMy2LgW8f47Kzdg-1; Mon, 21 Aug 2023 06:05:25 -0400
X-MC-Unique: AtqjKZowMy2LgW8f47Kzdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3721A800C7A;
 Mon, 21 Aug 2023 10:05:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B334440D2843;
 Mon, 21 Aug 2023 10:05:23 +0000 (UTC)
Date: Mon, 21 Aug 2023 11:05:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 mst@redhat.com, boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 eduardo@habkost.net
Subject: Re: [PATCH v4 1/3] qmp: remove virtio_list, search QOM tree instead
Message-ID: <ZOM24ZC7+lXXTBWl@redhat.com>
References: <20230818171926.3136840-1-jonah.palmer@oracle.com>
 <20230818171926.3136840-2-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818171926.3136840-2-jonah.palmer@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Aug 18, 2023 at 01:19:24PM -0400, Jonah Palmer wrote:
> The virtio_list duplicates information about virtio devices that already
> exist in the QOM composition tree. Instead of creating this list of
> realized virtio devices, search the QOM composition tree instead.
> 
> This patch modifies the QMP command qmp_x_query_virtio to instead
> recursively search the QOM composition tree for devices of type
> 'TYPE_VIRTIO_DEVICE'. The device is also checked to ensure it's
> realized.
> 
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
> 
>  Jonah: In the v2 patches, the qmp_x_query_virtio function was
>  iterating through devices found via. qmp_qom_list and appending
>  "/virtio-backend" to devices' paths to check if they were a virtio
>  device.
> 
>  This method was messy and involved unneeded string manipulation.
> 
>  Instead, we can use recursion with object_get_root to iterate through
>  all parent and child device paths to find virtio devices.
> 
>  The qmp_find_virtio_device function was also updated to simplify the
>  method of determining if a path is to a valid and realized virtio
>  device.
> 
>  hw/virtio/virtio-qmp.c | 88 +++++++++++++++---------------------------
>  hw/virtio/virtio-qmp.h |  7 ----
>  hw/virtio/virtio.c     |  6 ---
>  3 files changed, 32 insertions(+), 69 deletions(-)
> 
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index 7515b0947b..ac5f0ee0ee 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -667,70 +667,46 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>      return features;
>  }
>  
> -VirtioInfoList *qmp_x_query_virtio(Error **errp)
> +static int query_dev_child(Object *child, void *opaque)
>  {
> -    VirtioInfoList *list = NULL;
> -    VirtioInfo *node;
> -    VirtIODevice *vdev;
> +    VirtioInfoList **vdevs = opaque;
> +    Object *dev = object_dynamic_cast(child, TYPE_VIRTIO_DEVICE);
> +    if (dev != NULL && DEVICE(dev)->realized) {
> +        VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +
> +        VirtioInfo *info = g_new(VirtioInfo, 1);
> +
> +        /* Get canonical path of device */
> +        g_autofree char *path = object_get_canonical_path(dev);
>  
> -    QTAILQ_FOREACH(vdev, &virtio_list, next) {
> -        DeviceState *dev = DEVICE(vdev);
> -        Error *err = NULL;
> -        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
> -
> -        if (err == NULL) {
> -            GString *is_realized = qobject_to_json_pretty(obj, true);
> -            /* virtio device is NOT realized, remove it from list */
> -            if (!strncmp(is_realized->str, "false", 4)) {
> -                QTAILQ_REMOVE(&virtio_list, vdev, next);
> -            } else {
> -                node = g_new(VirtioInfo, 1);
> -                node->path = g_strdup(dev->canonical_path);
> -                node->name = g_strdup(vdev->name);
> -                QAPI_LIST_PREPEND(list, node);
> -            }
> -           g_string_free(is_realized, true);
> -        }
> -        qobject_unref(obj);
> +        info->path = g_strdup(path);

Just call object_get_canonical_path(dev) directly and avoid
duplicating & freeing the intermediate 'path' variable

> +        info->name = g_strdup(vdev->name);
> +        QAPI_LIST_PREPEND(*vdevs, info);
>      }
> +    return 0;
> +}
>  


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



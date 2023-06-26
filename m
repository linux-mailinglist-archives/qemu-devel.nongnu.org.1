Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3F73DEB7
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:17:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDl9D-0003Gc-QU; Mon, 26 Jun 2023 08:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDl8l-0003CR-W5
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDl8j-0008D1-2B
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687781775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IG1l/VeyGHJXZwtZnFLE3B2YAsNuWmrby75/th5bmb0=;
 b=VycyCZTa81yz0q2GbaRBNOfyCgx5JFhGnU2yV6G8jtXE2F27lPeQRLcq1Nzl+3mq6DZdgM
 S1B+ivIbRGeQNH6d/WqgiNtpUvLikh+Iz7C6ASVz49aYlV90egtn8+Bplny1czkCxfClvr
 sGshllcJGKSBGuOPiQAk8oLgE9nXOlM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-ltzcIxGfNQKKjhah2OvWrw-1; Mon, 26 Jun 2023 08:16:14 -0400
X-MC-Unique: ltzcIxGfNQKKjhah2OvWrw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-313f2430134so297532f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687781772; x=1690373772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IG1l/VeyGHJXZwtZnFLE3B2YAsNuWmrby75/th5bmb0=;
 b=Pk006gVPgtj+wnUWqry6ZTv/7kQGHPsl6rcXX4PCxm60joMonl0D175vnN5D9pKS6J
 T/VSPUkZj+a7iu6Sj6AfnonHTu90awR8RrfO7Y3PRh2xJQY130BtHWuQYCXEo4Aut2VV
 3s56N59JcfWcGqhAEOwouPBNNIiFhnOZ5sn59cKJbktwnHUV2DphB3Od0BZiuarCBtiC
 9ueRSYbDJ5Kty53O4E4i/v57LBogCA/nvgPQtCU3rSt7s+PQr9nSrBOuat8km/HziHRB
 y24mYMFqa4aqYELpJ6ujkXILqWfQm6JzwFbJZb/pHSk9WGDn7CQO7f1WpHhFcMp0/+sn
 8kMA==
X-Gm-Message-State: AC+VfDzDYm2hT3AgDzP6HjphP7fjM22LIEZPT9zxlRNUWGla9u9uhmPc
 BQx6XT+cC5b4Wj8/ppRPhb0/ZQn3WBvBrnNuZDmbWbnspH9ysqNYhZ/ZZje6JktobbJz/WFNqtz
 M/1c8VvxNOkiGQXc=
X-Received: by 2002:a05:6000:1cb:b0:313:efd5:f294 with SMTP id
 t11-20020a05600001cb00b00313efd5f294mr2179133wrx.10.1687781771999; 
 Mon, 26 Jun 2023 05:16:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ayfnW/e4Ptyhn/dM2ZhbtjS0wxUlDmpzPCwwhnhMijj76nYaxOM+9zT2jjobjExgkW4ZxmQ==
X-Received: by 2002:a05:6000:1cb:b0:313:efd5:f294 with SMTP id
 t11-20020a05600001cb00b00313efd5f294mr2179071wrx.10.1687781770774; 
 Mon, 26 Jun 2023 05:16:10 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 cs7-20020a056000088700b0030ada01ca78sm7266722wrb.10.2023.06.26.05.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:16:10 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:16:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: Re: [PATCH v2 1/2] qmp: remove virtio_list, search QOM tree instead
Message-ID: <20230626081522-mutt-send-email-mst@kernel.org>
References: <20230609132040.2180710-1-jonah.palmer@oracle.com>
 <20230609132040.2180710-2-jonah.palmer@oracle.com>
 <20230623014315-mutt-send-email-mst@kernel.org>
 <49f01bcc-eefa-d277-93fe-e3bcbc2ccd42@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f01bcc-eefa-d277-93fe-e3bcbc2ccd42@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 26, 2023 at 08:08:28AM -0400, Jonah Palmer wrote:
> 
> On 6/23/23 01:47, Michael S. Tsirkin wrote:
> 
>     On Fri, Jun 09, 2023 at 09:20:39AM -0400, Jonah Palmer wrote:
> 
>         The virtio_list duplicates information about virtio devices that already
>         exist in the QOM composition tree. Instead of creating this list of
>         realized virtio devices, search the QOM composition tree instead.
> 
>         This patch modifies the QMP command qmp_x_query_virtio to instead search
>         the partial paths of '/machine/peripheral/' &
>         '/machine/peripheral-anon/' in the QOM composition tree for virtio
>         devices.
> 
>         A device is found to be a valid virtio device if (1) its canonical path
>         is of 'TYPE_VIRTIO_DEVICE' and (2) the device has been realized.
> 
>         [Jonah: In the previous commit I had written that a device is found to
>          be a valid virtio device if (1) it has a canonical path ending with
>          'virtio-backend'.
> 
>          The code now determines if it's a virtio device by appending
>          'virtio-backend' (if needed) to a given canonical path and then
>          checking that path to see if the device is of type
>         'TYPE_VIRTIO_DEVICE'.
> 
>          The patch also instead now checks to make sure it's a virtio device
>          before attempting to check whether the device is realized or not.]
> 
>         Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> 
> 
>     Could one of QMP maintainers comment on this please?
> 
> 
>         ---
>          hw/virtio/virtio-qmp.c | 128 ++++++++++++++++++++++++++---------------
>          hw/virtio/virtio-qmp.h |   8 +--
>          hw/virtio/virtio.c     |   6 --
>          3 files changed, 82 insertions(+), 60 deletions(-)
> 
>         diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>         index b5e1835299..e936cc8ce5 100644
>         --- a/hw/virtio/virtio-qmp.c
>         +++ b/hw/virtio/virtio-qmp.c
>         @@ -668,67 +668,101 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>          VirtioInfoList *qmp_x_query_virtio(Error **errp)
>          {
>              VirtioInfoList *list = NULL;
>         -    VirtioInfo *node;
>         -    VirtIODevice *vdev;
> 
>         -    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>         -        DeviceState *dev = DEVICE(vdev);
>         -        Error *err = NULL;
>         -        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>         -
>         -        if (err == NULL) {
>         -            GString *is_realized = qobject_to_json_pretty(obj, true);
>         -            /* virtio device is NOT realized, remove it from list */
>         -            if (!strncmp(is_realized->str, "false", 4)) {
>         -                QTAILQ_REMOVE(&virtio_list, vdev, next);
>         -            } else {
>         -                node = g_new(VirtioInfo, 1);
>         -                node->path = g_strdup(dev->canonical_path);
>         -                node->name = g_strdup(vdev->name);
>         -                QAPI_LIST_PREPEND(list, node);
>         +    /* Query the QOM composition tree for virtio devices */
>         +    qmp_set_virtio_device_list("/machine/peripheral/", &list);
>         +    qmp_set_virtio_device_list("/machine/peripheral-anon/", &list);
> 
>     How sure are we these will forever be the only two places where virtio
>     can live?
> 
> A virtio device will always be considered a peripheral device, right?
> Since peripheral devices are input and/or output devices by definition.
> 
>         +    if (list == NULL) {
>         +        error_setg(errp, "No virtio devices found");
>         +        return NULL;
>         +    }
>         +    return list;
>         +}
>         +
>         +/* qmp_set_virtio_device_list:
>         + * @ppath: An incomplete peripheral path to search from.
>         + * @list: A list of realized virtio devices.
>         + * Searches a given incomplete peripheral path (e.g. '/machine/peripheral/'
>         + * or '/machine/peripheral-anon/') for realized virtio devices and adds them
>         + * to a given list of virtio devices.
>         + */
>         +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list)
>         +{
>         +    ObjectPropertyInfoList *plist;
>         +    VirtioInfoList *node;
>         +    Error *err = NULL;
>         +
>         +    /* Search an incomplete path for virtio devices */
>         +    plist = qmp_qom_list(ppath, &err);
>         +    if (err == NULL) {
>         +        ObjectPropertyInfoList *start = plist;
>         +        while (plist != NULL) {
>         +            ObjectPropertyInfo *value = plist->value;
>         +            GString *path = g_string_new(ppath);
>         +            g_string_append(path, value->name);
>         +            g_string_append(path, "/virtio-backend");
>         +
>         +            /* Determine if full path is a realized virtio device */
>         +            VirtIODevice *vdev = qmp_find_virtio_device(path->str);
>         +            if (vdev != NULL) {
>         +                node = g_new0(VirtioInfoList, 1);
>         +                node->value = g_new(VirtioInfo, 1);
>         +                node->value->path = g_strdup(path->str);
>         +                node->value->name = g_strdup(vdev->name);
>         +                QAPI_LIST_PREPEND(*list, node->value);
>                      }
>         -           g_string_free(is_realized, true);
>         +            g_string_free(path, true);
>         +            plist = plist->next;
>                  }
>         -        qobject_unref(obj);
>         +        qapi_free_ObjectPropertyInfoList(start);
>              }
>         -
>         -    return list;
>          }
> 
>          VirtIODevice *qmp_find_virtio_device(const char *path)
>          {
>         -    VirtIODevice *vdev;
>         -
>         -    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>         -        DeviceState *dev = DEVICE(vdev);
>         -
>         -        if (strcmp(dev->canonical_path, path) != 0) {
>         -            continue;
>         +    Error *err = NULL;
>         +    char *basename;
>         +
>         +    /* Append 'virtio-backend' to path if needed */
>         +    basename = g_path_get_basename(path);
>         +    if (strcmp(basename, "virtio-backend")) {
>         +        GString *temp = g_string_new(path);
>         +        char *last = strrchr(path, '/');
>         +        if (g_strcmp0(last, "/")) {
>         +            g_string_append(temp, "/virtio-backend");
>         +        } else {
>         +            g_string_append(temp, "virtio-backend");
>                  }
>         +        path = g_strdup(temp->str);
>         +        g_string_free(temp, true);
>         +    }
> 
>     I don't much like the string operations. We should be able to
>     check object types instead.
> 
> 
> I don't either but in order for us to check if the object is a
> virtio device type, we need to use the device's path ending
> with '/virtio-backend'.
> 
> If there's a better method to checking this though, or perhaps
> checking a different type, that doesn't involve string
> manipulation, then I'm all for it.

TYPE_VIRTIO_DEVICE ?


>         -        Error *err = NULL;
>         -        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>         -        if (err == NULL) {
>         -            GString *is_realized = qobject_to_json_pretty(obj, true);
>         -            /* virtio device is NOT realized, remove it from list */
>         -            if (!strncmp(is_realized->str, "false", 4)) {
>         -                g_string_free(is_realized, true);
>         -                qobject_unref(obj);
>         -                QTAILQ_REMOVE(&virtio_list, vdev, next);
>         -                return NULL;
>         -            }
>         +    /* Verify the canonical path is a virtio device */
>         +    Object *obj = object_resolve_path(path, NULL);
>         +    if (!obj || !object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE)) {
>         +        object_unref(obj);
>         +        return NULL;
>         +    }
>         +
>         +    /* Verify the virtio device is realized */
>         +    QObject *qobj = qmp_qom_get(path, "realized", &err);
>         +    if (err == NULL) {
>         +        GString *is_realized = qobject_to_json_pretty(qobj, true);
>         +        if (!strncmp(is_realized->str, "false", 4)) {
>                      g_string_free(is_realized, true);
>         -        } else {
>         -            /* virtio device doesn't exist in QOM tree */
>         -            QTAILQ_REMOVE(&virtio_list, vdev, next);
>         -            qobject_unref(obj);
>         +            qobject_unref(qobj);
>                      return NULL;
>                  }
>         -        /* device exists in QOM tree & is realized */
>         -        qobject_unref(obj);
>         -        return vdev;
>         +        g_string_free(is_realized, true);
>         +    } else {
>         +        qobject_unref(qobj);
>         +        return NULL;
>              }
>         -    return NULL;
>         +    qobject_unref(qobj);
>         +
>         +    /* Get VirtIODevice object */
>         +    VirtIODevice *vdev = VIRTIO_DEVICE(obj);
>         +    return vdev;
>          }
> 
>          VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>         diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
>         index 8af5f5e65a..4b2b7875b4 100644
>         --- a/hw/virtio/virtio-qmp.h
>         +++ b/hw/virtio/virtio-qmp.h
>         @@ -15,13 +15,7 @@
>          #include "hw/virtio/virtio.h"
>          #include "hw/virtio/vhost.h"
> 
>         -#include "qemu/queue.h"
>         -
>         -typedef QTAILQ_HEAD(QmpVirtIODeviceList, VirtIODevice) QmpVirtIODeviceList;
>         -
>         -/* QAPI list of realized VirtIODevices */
>         -extern QmpVirtIODeviceList virtio_list;
>         -
>         +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list);
>          VirtIODevice *qmp_find_virtio_device(const char *path);
>          VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
>          VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
>         diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>         index 295a603e58..83c5db3d26 100644
>         --- a/hw/virtio/virtio.c
>         +++ b/hw/virtio/virtio.c
>         @@ -45,8 +45,6 @@
>          #include "standard-headers/linux/virtio_mem.h"
>          #include "standard-headers/linux/virtio_vsock.h"
> 
>         -QmpVirtIODeviceList virtio_list;
>         -
>          /*
>           * Maximum size of virtio device config space
>           */
>         @@ -3616,7 +3614,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
>              vdev->listener.commit = virtio_memory_listener_commit;
>              vdev->listener.name = "virtio";
>              memory_listener_register(&vdev->listener, vdev->dma_as);
>         -    QTAILQ_INSERT_TAIL(&virtio_list, vdev, next);
>          }
> 
>          static void virtio_device_unrealize(DeviceState *dev)
>         @@ -3631,7 +3628,6 @@ static void virtio_device_unrealize(DeviceState *dev)
>                  vdc->unrealize(dev);
>              }
> 
>         -    QTAILQ_REMOVE(&virtio_list, vdev, next);
>              g_free(vdev->bus_name);
>              vdev->bus_name = NULL;
>          }
>         @@ -3805,8 +3801,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
>              vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
> 
>              vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
>         -
>         -    QTAILQ_INIT(&virtio_list);
>          }
> 
>          bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
>         --
>         2.39.3
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 008EA73B04D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 07:48:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCZeW-0008MH-DU; Fri, 23 Jun 2023 01:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCZeS-0008LR-E1
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCZeQ-0008TJ-F0
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687499285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nf23ja485y7YmwZXEUWg2kKxN/fAOvOU4nR61pMe4SY=;
 b=EXjlDmEmNtcGUg2MrvzPrcZg/eWMXv0CYKHXgCWuDisVYyDdqtESqlzIFCuVtgj4axofc0
 WRh5rfDwiI2R/ety3/Nmk1RDLvH9S9yD5QWP2CD7lKJKiELsXz3szTXYmRA+87RcZ7HkN8
 c2uzOSs1mSpQBmlEtI24rBRm2iGvCyc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-uoslUoO0OP2qRLx0-1Cv8Q-1; Fri, 23 Jun 2023 01:48:04 -0400
X-MC-Unique: uoslUoO0OP2qRLx0-1Cv8Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31123ce0c81so142245f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 22:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687499283; x=1690091283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nf23ja485y7YmwZXEUWg2kKxN/fAOvOU4nR61pMe4SY=;
 b=ZWG/RtI4oOSMrVKUJvVT9S9o2fUY5hM9I47ag5EHvi/OjAeziFShuJ1ZVr2Se2yPGv
 5LHtuIeJ8/ulF6/XCkfWpu8qiPlMEOwKLTqIu4P07Km09qKQwt0zguto1vd3kXbZxpdw
 gi0w2IP3GRsmv5P6FrH2g94i7J0PyLitHAdlVR3F7CmtcvmAw74ybzo81Qr07vUVWwxt
 X73aL0GxWL2lRYEL9ibH3PuhLdxjsHlnI77H0KRCgv8b2/rJbwbP4WrMo+SSXQrF9v+T
 Cq+1Hhs4Jge9MitIYWMzYfSoX76+gmH/9fe7j7fbBcd1GOgItqyoR01iR/YoRoqBehsV
 e4dg==
X-Gm-Message-State: AC+VfDwOadEjQSqEqEzvySitVIzVgnhCPMO2Z2MQCm9eQVF+2FpmLStp
 MDi1+czyDDefzV+jvE8F5XoAV8IZdG8VvAb2gmW+XLAjcizLOJechdhtNVxw59y5jpAEVwynKeN
 RM6M7qND34k1CcqQ=
X-Received: by 2002:a5d:58d1:0:b0:310:12f1:19e4 with SMTP id
 o17-20020a5d58d1000000b0031012f119e4mr15183550wrf.30.1687499282958; 
 Thu, 22 Jun 2023 22:48:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4iX3zNqsflfSHuTQu15f73hDeDiEHvkUcxyH5g0njDFEtrs/Tf7pbFpIP5tnyGIkNCk8t5xw==
X-Received: by 2002:a5d:58d1:0:b0:310:12f1:19e4 with SMTP id
 o17-20020a5d58d1000000b0031012f119e4mr15183535wrf.30.1687499282609; 
 Thu, 22 Jun 2023 22:48:02 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 e14-20020adfe38e000000b0030fcf3d75c4sm8690692wrm.45.2023.06.22.22.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 22:48:01 -0700 (PDT)
Date: Fri, 23 Jun 2023 01:47:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: Re: [PATCH v2 1/2] qmp: remove virtio_list, search QOM tree instead
Message-ID: <20230623014315-mutt-send-email-mst@kernel.org>
References: <20230609132040.2180710-1-jonah.palmer@oracle.com>
 <20230609132040.2180710-2-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609132040.2180710-2-jonah.palmer@oracle.com>
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

On Fri, Jun 09, 2023 at 09:20:39AM -0400, Jonah Palmer wrote:
> The virtio_list duplicates information about virtio devices that already
> exist in the QOM composition tree. Instead of creating this list of
> realized virtio devices, search the QOM composition tree instead.
> 
> This patch modifies the QMP command qmp_x_query_virtio to instead search
> the partial paths of '/machine/peripheral/' &
> '/machine/peripheral-anon/' in the QOM composition tree for virtio
> devices.
> 
> A device is found to be a valid virtio device if (1) its canonical path
> is of 'TYPE_VIRTIO_DEVICE' and (2) the device has been realized.
> 
> [Jonah: In the previous commit I had written that a device is found to
>  be a valid virtio device if (1) it has a canonical path ending with
>  'virtio-backend'.
> 
>  The code now determines if it's a virtio device by appending
>  'virtio-backend' (if needed) to a given canonical path and then
>  checking that path to see if the device is of type
> 'TYPE_VIRTIO_DEVICE'.
> 
>  The patch also instead now checks to make sure it's a virtio device
>  before attempting to check whether the device is realized or not.]
> 
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>


Could one of QMP maintainers comment on this please?

> ---
>  hw/virtio/virtio-qmp.c | 128 ++++++++++++++++++++++++++---------------
>  hw/virtio/virtio-qmp.h |   8 +--
>  hw/virtio/virtio.c     |   6 --
>  3 files changed, 82 insertions(+), 60 deletions(-)
> 
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index b5e1835299..e936cc8ce5 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -668,67 +668,101 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>  VirtioInfoList *qmp_x_query_virtio(Error **errp)
>  {
>      VirtioInfoList *list = NULL;
> -    VirtioInfo *node;
> -    VirtIODevice *vdev;
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
> +    /* Query the QOM composition tree for virtio devices */
> +    qmp_set_virtio_device_list("/machine/peripheral/", &list);
> +    qmp_set_virtio_device_list("/machine/peripheral-anon/", &list);

How sure are we these will forever be the only two places where virtio
can live?

> +    if (list == NULL) {
> +        error_setg(errp, "No virtio devices found");
> +        return NULL;
> +    }
> +    return list;
> +}
> +
> +/* qmp_set_virtio_device_list:
> + * @ppath: An incomplete peripheral path to search from.
> + * @list: A list of realized virtio devices.
> + * Searches a given incomplete peripheral path (e.g. '/machine/peripheral/'
> + * or '/machine/peripheral-anon/') for realized virtio devices and adds them
> + * to a given list of virtio devices.
> + */
> +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list)
> +{
> +    ObjectPropertyInfoList *plist;
> +    VirtioInfoList *node;
> +    Error *err = NULL;
> +
> +    /* Search an incomplete path for virtio devices */
> +    plist = qmp_qom_list(ppath, &err);
> +    if (err == NULL) {
> +        ObjectPropertyInfoList *start = plist;
> +        while (plist != NULL) {
> +            ObjectPropertyInfo *value = plist->value;
> +            GString *path = g_string_new(ppath);
> +            g_string_append(path, value->name);
> +            g_string_append(path, "/virtio-backend");
> +
> +            /* Determine if full path is a realized virtio device */
> +            VirtIODevice *vdev = qmp_find_virtio_device(path->str);
> +            if (vdev != NULL) {
> +                node = g_new0(VirtioInfoList, 1);
> +                node->value = g_new(VirtioInfo, 1);
> +                node->value->path = g_strdup(path->str);
> +                node->value->name = g_strdup(vdev->name);
> +                QAPI_LIST_PREPEND(*list, node->value);
>              }
> -           g_string_free(is_realized, true);
> +            g_string_free(path, true);
> +            plist = plist->next;
>          }
> -        qobject_unref(obj);
> +        qapi_free_ObjectPropertyInfoList(start);
>      }
> -
> -    return list;
>  }
>  
>  VirtIODevice *qmp_find_virtio_device(const char *path)
>  {
> -    VirtIODevice *vdev;
> -
> -    QTAILQ_FOREACH(vdev, &virtio_list, next) {
> -        DeviceState *dev = DEVICE(vdev);
> -
> -        if (strcmp(dev->canonical_path, path) != 0) {
> -            continue;
> +    Error *err = NULL;
> +    char *basename;
> +
> +    /* Append 'virtio-backend' to path if needed */
> +    basename = g_path_get_basename(path);
> +    if (strcmp(basename, "virtio-backend")) {
> +        GString *temp = g_string_new(path);
> +        char *last = strrchr(path, '/');
> +        if (g_strcmp0(last, "/")) {
> +            g_string_append(temp, "/virtio-backend");
> +        } else {
> +            g_string_append(temp, "virtio-backend");
>          }
> +        path = g_strdup(temp->str);
> +        g_string_free(temp, true);
> +    }

I don't much like the string operations. We should be able to
check object types instead.


> -        Error *err = NULL;
> -        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
> -        if (err == NULL) {
> -            GString *is_realized = qobject_to_json_pretty(obj, true);
> -            /* virtio device is NOT realized, remove it from list */
> -            if (!strncmp(is_realized->str, "false", 4)) {
> -                g_string_free(is_realized, true);
> -                qobject_unref(obj);
> -                QTAILQ_REMOVE(&virtio_list, vdev, next);
> -                return NULL;
> -            }
> +    /* Verify the canonical path is a virtio device */
> +    Object *obj = object_resolve_path(path, NULL);
> +    if (!obj || !object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE)) {
> +        object_unref(obj);
> +        return NULL;
> +    }
> +
> +    /* Verify the virtio device is realized */
> +    QObject *qobj = qmp_qom_get(path, "realized", &err);
> +    if (err == NULL) {
> +        GString *is_realized = qobject_to_json_pretty(qobj, true);
> +        if (!strncmp(is_realized->str, "false", 4)) {
>              g_string_free(is_realized, true);
> -        } else {
> -            /* virtio device doesn't exist in QOM tree */
> -            QTAILQ_REMOVE(&virtio_list, vdev, next);
> -            qobject_unref(obj);
> +            qobject_unref(qobj);
>              return NULL;
>          }
> -        /* device exists in QOM tree & is realized */
> -        qobject_unref(obj);
> -        return vdev;
> +        g_string_free(is_realized, true);
> +    } else {
> +        qobject_unref(qobj);
> +        return NULL;
>      }
> -    return NULL;
> +    qobject_unref(qobj);
> +
> +    /* Get VirtIODevice object */
> +    VirtIODevice *vdev = VIRTIO_DEVICE(obj);
> +    return vdev;
>  }
>  
>  VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
> diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
> index 8af5f5e65a..4b2b7875b4 100644
> --- a/hw/virtio/virtio-qmp.h
> +++ b/hw/virtio/virtio-qmp.h
> @@ -15,13 +15,7 @@
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/vhost.h"
>  
> -#include "qemu/queue.h"
> -
> -typedef QTAILQ_HEAD(QmpVirtIODeviceList, VirtIODevice) QmpVirtIODeviceList;
> -
> -/* QAPI list of realized VirtIODevices */
> -extern QmpVirtIODeviceList virtio_list;
> -
> +void qmp_set_virtio_device_list(const char *ppath, VirtioInfoList **list);
>  VirtIODevice *qmp_find_virtio_device(const char *path);
>  VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
>  VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 295a603e58..83c5db3d26 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -45,8 +45,6 @@
>  #include "standard-headers/linux/virtio_mem.h"
>  #include "standard-headers/linux/virtio_vsock.h"
>  
> -QmpVirtIODeviceList virtio_list;
> -
>  /*
>   * Maximum size of virtio device config space
>   */
> @@ -3616,7 +3614,6 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
>      vdev->listener.commit = virtio_memory_listener_commit;
>      vdev->listener.name = "virtio";
>      memory_listener_register(&vdev->listener, vdev->dma_as);
> -    QTAILQ_INSERT_TAIL(&virtio_list, vdev, next);
>  }
>  
>  static void virtio_device_unrealize(DeviceState *dev)
> @@ -3631,7 +3628,6 @@ static void virtio_device_unrealize(DeviceState *dev)
>          vdc->unrealize(dev);
>      }
>  
> -    QTAILQ_REMOVE(&virtio_list, vdev, next);
>      g_free(vdev->bus_name);
>      vdev->bus_name = NULL;
>  }
> @@ -3805,8 +3801,6 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
>      vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
>  
>      vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
> -
> -    QTAILQ_INIT(&virtio_list);
>  }
>  
>  bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
> -- 
> 2.39.3



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EE1793511
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 07:58:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdlWy-0001ko-A5; Wed, 06 Sep 2023 01:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdlWu-0001kU-SR
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 01:56:45 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdlWr-0002fB-TT
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 01:56:44 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99de884ad25so503547866b.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 22:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693979800; x=1694584600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HOW1IrlKmxFbuuDsXPqHimQQIirIaB/q1Vg4pRCE1fg=;
 b=QGmPgOGgRxgBmlTR8sFoFGEzJ+iyxxkctxruRxlr2z2fVLfG+VJWEGWGb3ggGEL00K
 uwgqXBxbb/W+DbHL0aN0UWrwFstcNngu28lMM4aS83TD3p2FQVQUVPmmao3rkG36+3Eb
 gH9QGH9QtJe9BtDfp0fF59g4vUowuaSpVej5QnrDTYUtQGaDMQe8stfBgGU165xsECY9
 dgrYd4O/TpTFlofwf6ln3PPvVvGVb4AojPe8hS2owu35Y6KVX5jodr0nBY3f6usJh1St
 nRxTuWmvear7ZY4H8+YyqGbZcrODr7AXT3v9NivNQm42qy1KxaMLTlGC/oD6Vlxh4j6i
 PQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693979800; x=1694584600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HOW1IrlKmxFbuuDsXPqHimQQIirIaB/q1Vg4pRCE1fg=;
 b=NTitmM83UJT4QVjLJwL5G+wiO1oEOVc/g0caU2zf16OnLpWYLX0I+g4EtL4+pu+PD8
 O8fOd/FX5Wt74dS+5nlLcaLgQqUdAjPqqJCcx0GyiMdQubO34adFV5jWuEpKN62PmmDK
 KRPBVlqeI/yOASJhyay1bIESQi08xdnmJ+iZVFtjPrZFg0ZmUqgOsvBV9408MFiASpU2
 7Rs4rXmGC/aKWULJk5i/0oSRGpInpSmUdCSMDmnAkH9FEE0GxUrpt6kmYZ721I/f1NR8
 5iyJTzEUJHLDzh6LFKeh/lE/EBXglbWgJLo/sI/KL8+X4qYC1GeBlzzBhHengZgzcN4e
 uvVg==
X-Gm-Message-State: AOJu0YzAYZBp3SJciUvtB5M4Gxuns3yjD0fEMWNDkAGz8RsmK8Df5Ofx
 qzJiDHPmaiO5u3gRQl4jb7l7Lw==
X-Google-Smtp-Source: AGHT+IHOpajHnrgvgG2vSdxc/js84w2dmqgo+SAvyrNoy0VUvWsH8LEJ6mqKWNOo5e/7BWh5P/Bzkg==
X-Received: by 2002:a17:906:10ca:b0:9a1:f4e8:87b4 with SMTP id
 v10-20020a17090610ca00b009a1f4e887b4mr1210489ejv.5.1693979800018; 
 Tue, 05 Sep 2023 22:56:40 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 lu7-20020a170906fac700b00992e14af9b9sm8387498ejb.134.2023.09.05.22.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 22:56:39 -0700 (PDT)
Message-ID: <e6b6abb1-921b-43d7-054a-71042b0f4e38@linaro.org>
Date: Wed, 6 Sep 2023 07:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v5 2/4] virtio-dmabuf: introduce virtio-dmabuf
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, kraxel@redhat.com, cohuck@redhat.com,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230802090824.91688-1-aesteve@redhat.com>
 <20230802090824.91688-3-aesteve@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230802090824.91688-3-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Albert,

On 2/8/23 11:08, Albert Esteve wrote:
> This API manages objects (in this iteration,
> dmabuf fds) that can be shared along different
> virtio devices, associated to a UUID.
> 
> The API allows the different devices to add,
> remove and/or retrieve the objects by simply
> invoking the public functions that reside in the
> virtio-dmabuf file.
> 
> For vhost backends, the API stores the pointer
> to the backend holding the object.
> 
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   MAINTAINERS                       |   7 ++
>   hw/display/meson.build            |   1 +
>   hw/display/virtio-dmabuf.c        | 136 +++++++++++++++++++++++++++++
>   include/hw/virtio/virtio-dmabuf.h | 103 ++++++++++++++++++++++
>   tests/unit/meson.build            |   1 +
>   tests/unit/test-virtio-dmabuf.c   | 137 ++++++++++++++++++++++++++++++
>   6 files changed, 385 insertions(+)
>   create mode 100644 hw/display/virtio-dmabuf.c
>   create mode 100644 include/hw/virtio/virtio-dmabuf.h
>   create mode 100644 tests/unit/test-virtio-dmabuf.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12e59b6b27..cd8487785a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2158,6 +2158,13 @@ T: git https://gitlab.com/cohuck/qemu.git s390-next
>   T: git https://github.com/borntraeger/qemu.git s390-next
>   L: qemu-s390x@nongnu.org
>   
> +virtio-dmabuf
> +M: Albert Esteve <aesteve@redhat.com>
> +S: Supported
> +F: hw/display/virtio-dmabuf.c
> +F: include/hw/virtio/virtio-dmabuf.h
> +F: tests/unit/test-virtio-dmabuf.c
> +
>   virtiofs
>   M: Stefan Hajnoczi <stefanha@redhat.com>
>   S: Supported
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 413ba4ab24..05619c6968 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -37,6 +37,7 @@ system_ss.add(when: 'CONFIG_MACFB', if_true: files('macfb.c'))
>   system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
>   
>   system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
> +system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c'))
>   
>   if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
>       config_all_devices.has_key('CONFIG_VGA_PCI') or
> diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> new file mode 100644
> index 0000000000..e852c71ba9
> --- /dev/null
> +++ b/hw/display/virtio-dmabuf.c
> @@ -0,0 +1,136 @@
> +/*
> + * Virtio Shared dma-buf
> + *
> + * Copyright Red Hat, Inc. 2023
> + *
> + * Authors:
> + *     Albert Esteve <aesteve@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "hw/virtio/virtio-dmabuf.h"
> +
> +
> +static GMutex lock;
> +static GHashTable *resource_uuids;
> +
> +/*
> + * uuid_equal_func: wrapper for UUID is_equal function to
> + * satisfy g_hash_table_new expected parameters signatures.
> + */
> +static int uuid_equal_func(const void *lhv, const void *rhv)
> +{
> +    return qemu_uuid_is_equal(lhv, rhv);
> +}
> +
> +static bool virtio_add_resource(QemuUUID *uuid, struct VirtioSharedObject *value)

Per QEMU coding style we use typedefs, so "VirtioSharedObject" here.

> +{
> +    if (resource_uuids == NULL) {
> +        resource_uuids = g_hash_table_new_full(
> +            qemu_uuid_hash, uuid_equal_func, NULL, g_free);
> +    }
> +    if (g_hash_table_lookup(resource_uuids, uuid) != NULL) {
> +        return false;
> +    }
> +
> +    return g_hash_table_insert(resource_uuids, uuid, value);

Hmm shouldn't this function take the lock to access resource_uuids?

> +}
> +
> +static gpointer virtio_lookup_resource(const QemuUUID *uuid)
> +{
> +    if (resource_uuids == NULL) {
> +        return NULL;
> +    }
> +
> +    return g_hash_table_lookup(resource_uuids, uuid);

Ditto.

Here you can directly return the casted type (VirtioSharedObject *),
since a plain gpointer isn't really used / useful.

> +}
> +
> +bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
> +{
> +    bool result;
> +    struct VirtioSharedObject *vso;
> +    if (udmabuf_fd < 0) {
> +        return false;
> +    }
> +    vso = g_new0(struct VirtioSharedObject, 1);

s/g_new0/g_new/

> +    g_mutex_lock(&lock);
> +    vso->type = TYPE_DMABUF;
> +    vso->value = GINT_TO_POINTER(udmabuf_fd);
> +    result = virtio_add_resource(uuid, vso);
> +    g_mutex_unlock(&lock);
> +
> +    return result;
> +}
> +
> +bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
> +{
> +    bool result;
> +    struct VirtioSharedObject *vso;
> +    if (dev == NULL) {
> +        return false;
> +    }
> +    vso = g_new0(struct VirtioSharedObject, 1);
> +    g_mutex_lock(&lock);
> +    vso->type = TYPE_VHOST_DEV;
> +    vso->value = dev;
> +    result = virtio_add_resource(uuid, vso);

Ah, you lock here... I'd rather do it in the callee.

> +    g_mutex_unlock(&lock);
> +
> +    return result;
> +}
> +
> +bool virtio_remove_resource(const QemuUUID *uuid)
> +{
> +    bool result;
> +    g_mutex_lock(&lock);
> +    result = g_hash_table_remove(resource_uuids, uuid);
> +    g_mutex_unlock(&lock);

virtio_remove_resource() correctly locks. For API parity,
virtio_add_resource() should too.

> +
> +    return result;
> +}
> +
> +static struct VirtioSharedObject *get_shared_object(const QemuUUID *uuid)
> +{
> +    g_mutex_lock(&lock);
> +    gpointer lookup_res = virtio_lookup_resource(uuid);
> +    g_mutex_unlock(&lock);
> +    return (struct VirtioSharedObject*) lookup_res;

See earlier, this function can be merged with virtio_lookup_resource().

> +}
> +
> +int virtio_lookup_dmabuf(const QemuUUID *uuid)
> +{
> +    struct VirtioSharedObject *vso = get_shared_object(uuid);
> +    if (vso == NULL) {
> +        return -1;
> +    }
> +    assert(vso->type == TYPE_DMABUF);
> +    return GPOINTER_TO_INT(vso->value);
> +}
> +
> +struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
> +{
> +    struct VirtioSharedObject *vso = get_shared_object(uuid);
> +    if (vso == NULL) {
> +        return NULL;
> +    }
> +    assert(vso->type == TYPE_VHOST_DEV);
> +    return (struct vhost_dev *) vso->value;
> +}
> +
> +enum SharedObjectType virtio_object_type(const QemuUUID *uuid)
> +{
> +    struct VirtioSharedObject *vso = get_shared_object(uuid);
> +    if (vso == NULL) {
> +        return TYPE_INVALID;
> +    }
> +    return vso->type;
> +}
> +
> +void virtio_free_resources(void)
> +{
> +    g_hash_table_destroy(resource_uuids);

Lock?

> +    /* Reference count shall be 0 after the implicit unref on destroy */
> +    resource_uuids = NULL;
> +}
> diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
> new file mode 100644
> index 0000000000..536e622555
> --- /dev/null
> +++ b/include/hw/virtio/virtio-dmabuf.h
> @@ -0,0 +1,103 @@
> +/*
> + * Virtio Shared dma-buf
> + *
> + * Copyright Red Hat, Inc. 2023
> + *
> + * Authors:
> + *     Albert Esteve <aesteve@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef VIRTIO_DMABUF_H
> +#define VIRTIO_DMABUF_H
> +
> +#include "qemu/osdep.h"
> +
> +#include <glib.h>
> +#include "qemu/uuid.h"
> +#include "vhost.h"
> +
> +enum SharedObjectType {
> +    TYPE_INVALID = 0,
> +    TYPE_DMABUF,
> +    TYPE_VHOST_DEV,
> +};
> +

Please declare a

typedef

> +struct VirtioSharedObject {
> +    enum SharedObjectType type;
> +    gpointer value;
> +};

VirtioSharedObject;

and use it instead of 'struct VirtioSharedObject'.

Regards,

Phil.


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4807B793C30
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 14:04:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdrFt-0002f0-46; Wed, 06 Sep 2023 08:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdrFq-0002ef-79
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 08:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1qdrFl-0006Le-HD
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 08:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694001804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fwY7zQL7xXCh0VKf+8KcF0HAxgYujbnMPfazPhnrIls=;
 b=VTYZ1Wa4DuoeQnc8xvXQNNOPNs9EybAPWPhjBk2xdqmjaYQl82qInhCJlLTevFUw1ixlL3
 1ba8fOzdMaLJvAS1SJXvzYudPbdzhSG5Nj+ovtRt4tX2/EEBGR9P/910afxruB8tC7dWq5
 fhXsbZ1elWLe75U+VtcgN5b03WlymfY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-3-htpDQlNuGYrngBRmAUDQ-1; Wed, 06 Sep 2023 08:03:22 -0400
X-MC-Unique: 3-htpDQlNuGYrngBRmAUDQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-56fb25fdf06so2782594a12.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 05:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694001800; x=1694606600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fwY7zQL7xXCh0VKf+8KcF0HAxgYujbnMPfazPhnrIls=;
 b=MXWhq15LEzQgcgit6QND4rr9uA5lVWM70onU/bIWY4WUDBFZdpVkrXhFvobdMX/as8
 TJw8vxYSA+VKIi2QZu3QQIU0NZZE5QyZm3nw8KBN3sCn8BhgYAAq4kkOIYncT+MSlVIh
 UEBpQxpK7QSGB7s26LiIRaOLJbOHKkORFxy3LSZqBzYxi3Mm55sc5AnSxELUMMw/ENNL
 LIf+qvj00g4Ho3i2mUHQepWK3T6ur9NuOMaxb2coDRNHjh5UzJesUN0wAwb01smDCD6j
 XU3tIajn+tNFPNn3mSS9Tp//gOJRk5GVPlgrmu2l1TGMKGFqWIwfDtk6Ecr5FN1gz0PZ
 lvFg==
X-Gm-Message-State: AOJu0Yw2MGYttEwuvYFyanwaie0ExAnV+Tl933sMk/ylldj6lfnzXhAg
 lzqpOHaen2QHzzHu+Q19nq8pIavQpZpXbm+kbwwRfpLtBvCj6qZ+Agv7beqdO4wDOIXRKgzFP0x
 XfqJO0SgOqoeTgnKViWKgN9K+pI0q5OI0S/+YnbI=
X-Received: by 2002:a05:6a20:3d91:b0:152:efa4:228 with SMTP id
 s17-20020a056a203d9100b00152efa40228mr5378954pzi.20.1694001799878; 
 Wed, 06 Sep 2023 05:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4UD9c/qCN4xVgiANzCExB4p53GvKhLSmsQ1jubuWnbgdsCPEWCh6wPYlbFt0f+r8rHbOI/Znm9SUhClo4fzM=
X-Received: by 2002:a05:6a20:3d91:b0:152:efa4:228 with SMTP id
 s17-20020a056a203d9100b00152efa40228mr5378917pzi.20.1694001799382; Wed, 06
 Sep 2023 05:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230906111549.357178-1-aesteve@redhat.com>
 <20230906111549.357178-3-aesteve@redhat.com>
In-Reply-To: <20230906111549.357178-3-aesteve@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 6 Sep 2023 14:03:08 +0200
Message-ID: <CADSE00J3s+hqN_QUyV9gFDYRM8bcWVuj7ALdKSDZL8PPwNuH5w@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] virtio-dmabuf: introduce virtio-dmabuf
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Fam Zheng <fam@euphon.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com, kraxel@redhat.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="0000000000008065950604af8763"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000008065950604af8763
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 6, 2023 at 1:15=E2=80=AFPM Albert Esteve <aesteve@redhat.com> w=
rote:

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
>  MAINTAINERS                       |   7 ++
>  hw/display/meson.build            |   1 +
>  hw/display/virtio-dmabuf.c        | 134 +++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-dmabuf.h | 103 ++++++++++++++++++++++
>  tests/unit/meson.build            |   1 +
>  tests/unit/test-virtio-dmabuf.c   | 137 ++++++++++++++++++++++++++++++
>  6 files changed, 383 insertions(+)
>  create mode 100644 hw/display/virtio-dmabuf.c
>  create mode 100644 include/hw/virtio/virtio-dmabuf.h
>  create mode 100644 tests/unit/test-virtio-dmabuf.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b29568ed4..fb0f7b823f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2150,6 +2150,13 @@ T: git https://gitlab.com/cohuck/qemu.git s390-nex=
t
>  T: git https://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>
> +virtio-dmabuf
> +M: Albert Esteve <aesteve@redhat.com>
> +S: Supported
> +F: hw/display/virtio-dmabuf.c
> +F: include/hw/virtio/virtio-dmabuf.h
> +F: tests/unit/test-virtio-dmabuf.c
> +
>  virtiofs
>  M: Stefan Hajnoczi <stefanha@redhat.com>
>  S: Supported
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 413ba4ab24..05619c6968 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -37,6 +37,7 @@ system_ss.add(when: 'CONFIG_MACFB', if_true:
> files('macfb.c'))
>  system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
>
>  system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
> +system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c'))
>
>  if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
>      config_all_devices.has_key('CONFIG_VGA_PCI') or
> diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> new file mode 100644
> index 0000000000..268ffe81ec
> --- /dev/null
> +++ b/hw/display/virtio-dmabuf.c
> @@ -0,0 +1,134 @@
> +/*
> + * Virtio Shared dma-buf
> + *
> + * Copyright Red Hat, Inc. 2023
> + *
> + * Authors:
> + *     Albert Esteve <aesteve@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
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
> +static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *valu=
e)
> +{
> +    bool result;
> +    g_mutex_lock(&lock);
> +    if (resource_uuids =3D=3D NULL) {
> +        resource_uuids =3D g_hash_table_new_full(
> +            qemu_uuid_hash, uuid_equal_func, NULL, g_free);
> +    }
> +    if (g_hash_table_lookup(resource_uuids, uuid) !=3D NULL) {
> +        g_mutex_unlock(&lock);
> +        return false;
> +    }
> +    result =3D g_hash_table_insert(resource_uuids, uuid, value);
> +    g_mutex_unlock(&lock);
> +
> +    return result;
> +}
> +
> +bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
> +{
> +    bool result;
> +    VirtioSharedObject *vso;
> +    if (udmabuf_fd < 0) {
> +        return false;
> +    }
> +    vso =3D g_new(VirtioSharedObject, 1);
> +    vso->type =3D TYPE_DMABUF;
> +    vso->value =3D GINT_TO_POINTER(udmabuf_fd);
> +    result =3D virtio_add_resource(uuid, vso);
> +
> +    return result;
>

Just realized that the result variable is not required anymore
with the last change.

Not sure if it is worth sending a new review for this...
I can take it into account for a follow-up refactor for the next
update I make on the file. Or just send a separate trivial patch.


> +}
> +
> +bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
> +{
> +    bool result;
> +    VirtioSharedObject *vso;
> +    if (dev =3D=3D NULL) {
> +        return false;
> +    }
> +    vso =3D g_new(VirtioSharedObject, 1);
> +    vso->type =3D TYPE_VHOST_DEV;
> +    vso->value =3D dev;
> +    result =3D virtio_add_resource(uuid, vso);
> +
> +    return result;
> +}
> +
> +bool virtio_remove_resource(const QemuUUID *uuid)
> +{
> +    bool result;
> +    g_mutex_lock(&lock);
> +    result =3D g_hash_table_remove(resource_uuids, uuid);
> +    g_mutex_unlock(&lock);
> +
> +    return result;
> +}
> +
> +static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)
> +{
> +    g_mutex_lock(&lock);
> +    if (resource_uuids =3D=3D NULL) {
> +        g_mutex_unlock(&lock);
> +        return NULL;
> +    }
> +    gpointer lookup_res =3D g_hash_table_lookup(resource_uuids, uuid);
> +    g_mutex_unlock(&lock);
> +    return (VirtioSharedObject*) lookup_res;
> +}
> +
> +int virtio_lookup_dmabuf(const QemuUUID *uuid)
> +{
> +    VirtioSharedObject *vso =3D get_shared_object(uuid);
> +    if (vso =3D=3D NULL) {
> +        return -1;
> +    }
> +    assert(vso->type =3D=3D TYPE_DMABUF);
> +    return GPOINTER_TO_INT(vso->value);
> +}
> +
> +struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
> +{
> +    VirtioSharedObject *vso =3D get_shared_object(uuid);
> +    if (vso =3D=3D NULL) {
> +        return NULL;
> +    }
> +    assert(vso->type =3D=3D TYPE_VHOST_DEV);
> +    return (struct vhost_dev *) vso->value;
> +}
> +
> +SharedObjectType virtio_object_type(const QemuUUID *uuid)
> +{
> +    VirtioSharedObject *vso =3D get_shared_object(uuid);
> +    if (vso =3D=3D NULL) {
> +        return TYPE_INVALID;
> +    }
> +    return vso->type;
> +}
> +
> +void virtio_free_resources(void)
> +{
> +    g_mutex_lock(&lock);
> +    g_hash_table_destroy(resource_uuids);
> +    /* Reference count shall be 0 after the implicit unref on destroy */
> +    resource_uuids =3D NULL;
> +    g_mutex_unlock(&lock);
> +}
> diff --git a/include/hw/virtio/virtio-dmabuf.h
> b/include/hw/virtio/virtio-dmabuf.h
> new file mode 100644
> index 0000000000..202eec5868
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
> +typedef enum SharedObjectType {
> +    TYPE_INVALID =3D 0,
> +    TYPE_DMABUF,
> +    TYPE_VHOST_DEV,
> +} SharedObjectType;
> +
> +typedef struct VirtioSharedObject {
> +    SharedObjectType type;
> +    gpointer value;
> +} VirtioSharedObject;
> +
> +/**
> + * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup table
> + * @uuid: new resource's UUID
> + * @dmabuf_fd: the dma-buf descriptor that will be stored and shared wit=
h
> + *             other virtio devices. The caller retains ownership over t=
he
> + *             descriptor and its lifecycle.
> + *
> + * Note: @dmabuf_fd must be a valid (non-negative) file descriptor.
> + *
> + * Return: true if the UUID did not exist and the resource has been adde=
d,
> + * false if another resource with the same UUID already existed.
> + * Note that if it finds a repeated UUID, the resource is not inserted i=
n
> + * the lookup table.
> + */
> +bool virtio_add_dmabuf(QemuUUID *uuid, int dmabuf_fd);
> +
> +/**
> + * virtio_add_vhost_device() - Add a new exporter vhost device that hold=
s
> the
> + * resource with the associated UUID
> + * @uuid: new resource's UUID
> + * @dev: the pointer to the vhost device that holds the resource. The
> caller
> + *       retains ownership over the device struct and its lifecycle.
> + *
> + * Return: true if the UUID did not exist and the device has been tracke=
d,
> + * false if another resource with the same UUID already existed.
> + * Note that if it finds a repeated UUID, the resource is not inserted i=
n
> + * the lookup table.
> + */
> +bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev);
> +
> +/**
> + * virtio_remove_resource() - Removes a resource from the lookup table
> + * @uuid: resource's UUID
> + *
> + * Return: true if the UUID has been found and removed from the lookup
> table.
> + */
> +bool virtio_remove_resource(const QemuUUID *uuid);
> +
> +/**
> + * virtio_lookup_dmabuf() - Looks for a dma-buf resource in the lookup
> table
> + * @uuid: resource's UUID
> + *
> + * Return: the dma-buf file descriptor integer, or -1 if the key is not
> found.
> + */
> +int virtio_lookup_dmabuf(const QemuUUID *uuid);
> +
> +/**
> + * virtio_lookup_vhost_device() - Looks for an exporter vhost device in
> the
> + * lookup table
> + * @uuid: resource's UUID
> + *
> + * Return: pointer to the vhost_dev struct, or NULL if the key is not
> found.
> + */
> +struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid);
> +
> +/**
> + * virtio_object_type() - Looks for the type of resource in the lookup
> table
> + * @uuid: resource's UUID
> + *
> + * Return: the type of resource associated with the UUID, or TYPE_INVALI=
D
> if
> + * the key is not found.
> + */
> +SharedObjectType virtio_object_type(const QemuUUID *uuid);
> +
> +/**
> + * virtio_free_resources() - Destroys all keys and values of the shared
> + * resources lookup table, and frees them
> + */
> +void virtio_free_resources(void);
> +
> +#endif /* VIRTIO_DMABUF_H */
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index 93977cc32d..425ecc30fb 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -50,6 +50,7 @@ tests =3D {
>    'test-qapi-util': [],
>    'test-interval-tree': [],
>    'test-xs-node': [qom],
> +  'test-virtio-dmabuf': [meson.project_source_root() /
> 'hw/display/virtio-dmabuf.c'],
>  }
>
>  if have_system or have_tools
> diff --git a/tests/unit/test-virtio-dmabuf.c
> b/tests/unit/test-virtio-dmabuf.c
> new file mode 100644
> index 0000000000..40fe262538
> --- /dev/null
> +++ b/tests/unit/test-virtio-dmabuf.c
> @@ -0,0 +1,137 @@
> +/*
> + * QEMU tests for shared dma-buf API
> + *
> + * Copyright (c) 2023 Red Hat, Inc.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/virtio/virtio-dmabuf.h"
> +
> +
> +static void test_add_remove_resources(void)
> +{
> +    QemuUUID uuid;
> +    int i, dmabuf_fd;
> +
> +    for (i =3D 0; i < 100; ++i) {
> +        qemu_uuid_generate(&uuid);
> +        dmabuf_fd =3D g_random_int_range(3, 500);
> +        /* Add a new resource */
> +        g_assert(virtio_add_dmabuf(&uuid, dmabuf_fd));
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, dmabuf_fd);
> +        /* Remove the resource */
> +        g_assert(virtio_remove_resource(&uuid));
> +        /* Resource is not found anymore */
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, -1);
> +    }
> +}
> +
> +static void test_add_remove_dev(void)
> +{
> +    QemuUUID uuid;
> +    struct vhost_dev *dev =3D g_new0(struct vhost_dev, 1);
> +    int i;
> +
> +    for (i =3D 0; i < 100; ++i) {
> +        qemu_uuid_generate(&uuid);
> +        virtio_add_vhost_device(&uuid, dev);
> +        /* vhost device is found */
> +        g_assert(virtio_lookup_vhost_device(&uuid) !=3D NULL);
> +        /* Remove the vhost device */
> +        g_assert(virtio_remove_resource(&uuid));
> +        /* vhost device is not found anymore */
> +        g_assert(virtio_lookup_vhost_device(&uuid) =3D=3D NULL);
> +    }
> +    g_free(dev);
> +}
> +
> +static void test_remove_invalid_resource(void)
> +{
> +    QemuUUID uuid;
> +    int i;
> +
> +    for (i =3D 0; i < 20; ++i) {
> +        qemu_uuid_generate(&uuid);
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, -1);
> +        /* Removing a resource that does not exist returns false */
> +        g_assert_false(virtio_remove_resource(&uuid));
> +    }
> +}
> +
> +static void test_add_invalid_resource(void)
> +{
> +    QemuUUID uuid;
> +    struct vhost_dev *dev =3D NULL;
> +    int i, dmabuf_fd =3D -2, alt_dmabuf =3D 2;
> +
> +    for (i =3D 0; i < 20; ++i) {
> +        qemu_uuid_generate(&uuid);
> +        /* Add a new resource with invalid (negative) resource fd */
> +        g_assert_false(virtio_add_dmabuf(&uuid, dmabuf_fd));
> +        /* Resource is not found */
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, -1);
> +        /* Add a new vhost device with invalid (NULL) pointer */
> +        g_assert_false(virtio_add_vhost_device(&uuid, dev));
> +        /* vhost device is not found */
> +        g_assert(virtio_lookup_vhost_device(&uuid) =3D=3D NULL);
> +    }
> +
> +    for (i =3D 0; i < 20; ++i) {
> +        /* Add a valid resource */
> +        qemu_uuid_generate(&uuid);
> +        dmabuf_fd =3D g_random_int_range(3, 500);
> +        g_assert(virtio_add_dmabuf(&uuid, dmabuf_fd));
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, dmabuf_fd);
> +        /* Add a new resource with repeated uuid returns false */
> +        g_assert_false(virtio_add_dmabuf(&uuid, alt_dmabuf));
> +        /* The value for the uuid key is not replaced */
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), =3D=3D, dmabuf_fd);
> +    }
> +}
> +
> +static void test_free_resources(void)
> +{
> +    QemuUUID uuids[20];
> +    int i, dmabuf_fd;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(uuids); ++i) {
> +        qemu_uuid_generate(&uuids[i]);
> +        dmabuf_fd =3D g_random_int_range(3, 500);
> +        g_assert(virtio_add_dmabuf(&uuids[i], dmabuf_fd));
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), =3D=3D, dmabuf_=
fd);
> +    }
> +    virtio_free_resources();
> +    for (i =3D 0; i < ARRAY_SIZE(uuids); ++i) {
> +        /* None of the resources is found after free'd */
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), =3D=3D, -1);
> +    }
> +
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_add_func("/virtio-dmabuf/add_rm_res",
> test_add_remove_resources);
> +        g_test_add_func("/virtio-dmabuf/add_rm_dev", test_add_remove_dev=
);
> +    g_test_add_func("/virtio-dmabuf/rm_invalid_res",
> +                    test_remove_invalid_resource);
> +    g_test_add_func("/virtio-dmabuf/add_invalid_res",
> +                    test_add_invalid_resource);
> +    g_test_add_func("/virtio-dmabuf/free_res", test_free_resources);
> +
> +    return g_test_run();
> +}
> --
> 2.41.0
>
>

--0000000000008065950604af8763
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font=
-family:RedHatText,sans-serif;font-weight:bold;margin:0px;padding:0px;font-=
size:14px"><br></p></div></div></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 6, 2023 at 1:15=E2=80=AFPM=
 Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com">aesteve@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
This API manages objects (in this iteration,<br>
dmabuf fds) that can be shared along different<br>
virtio devices, associated to a UUID.<br>
<br>
The API allows the different devices to add,<br>
remove and/or retrieve the objects by simply<br>
invoking the public functions that reside in the<br>
virtio-dmabuf file.<br>
<br>
For vhost backends, the API stores the pointer<br>
to the backend holding the object.<br>
<br>
Suggested-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=
=3D"_blank">kraxel@redhat.com</a>&gt;<br>
Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" targ=
et=3D"_blank">aesteve@redhat.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 ++<br>
=C2=A0hw/display/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A01 +<br>
=C2=A0hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 134 +++++++++=
++++++++++++++++++++<br>
=C2=A0include/hw/virtio/virtio-dmabuf.h | 103 ++++++++++++++++++++++<br>
=C2=A0tests/unit/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A01 +<br>
=C2=A0tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0| 137 +++++++++++++++++++=
+++++++++++<br>
=C2=A06 files changed, 383 insertions(+)<br>
=C2=A0create mode 100644 hw/display/virtio-dmabuf.c<br>
=C2=A0create mode 100644 include/hw/virtio/virtio-dmabuf.h<br>
=C2=A0create mode 100644 tests/unit/test-virtio-dmabuf.c<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 3b29568ed4..fb0f7b823f 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -2150,6 +2150,13 @@ T: git <a href=3D"https://gitlab.com/cohuck/qemu.git=
" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/cohuck/qemu.git</=
a> s390-next<br>
=C2=A0T: git <a href=3D"https://github.com/borntraeger/qemu.git" rel=3D"nor=
eferrer" target=3D"_blank">https://github.com/borntraeger/qemu.git</a> s390=
-next<br>
=C2=A0L: <a href=3D"mailto:qemu-s390x@nongnu.org" target=3D"_blank">qemu-s3=
90x@nongnu.org</a><br>
<br>
+virtio-dmabuf<br>
+M: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" target=3D"_blan=
k">aesteve@redhat.com</a>&gt;<br>
+S: Supported<br>
+F: hw/display/virtio-dmabuf.c<br>
+F: include/hw/virtio/virtio-dmabuf.h<br>
+F: tests/unit/test-virtio-dmabuf.c<br>
+<br>
=C2=A0virtiofs<br>
=C2=A0M: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" target=
=3D"_blank">stefanha@redhat.com</a>&gt;<br>
=C2=A0S: Supported<br>
diff --git a/hw/display/meson.build b/hw/display/meson.build<br>
index 413ba4ab24..05619c6968 100644<br>
--- a/hw/display/meson.build<br>
+++ b/hw/display/meson.build<br>
@@ -37,6 +37,7 @@ system_ss.add(when: &#39;CONFIG_MACFB&#39;, if_true: file=
s(&#39;macfb.c&#39;))<br>
=C2=A0system_ss.add(when: &#39;CONFIG_NEXTCUBE&#39;, if_true: files(&#39;ne=
xt-fb.c&#39;))<br>
<br>
=C2=A0system_ss.add(when: &#39;CONFIG_VGA&#39;, if_true: files(&#39;vga.c&#=
39;))<br>
+system_ss.add(when: &#39;CONFIG_VIRTIO&#39;, if_true: files(&#39;virtio-dm=
abuf.c&#39;))<br>
<br>
=C2=A0if (config_all_devices.has_key(&#39;CONFIG_VGA_CIRRUS&#39;) or<br>
=C2=A0 =C2=A0 =C2=A0config_all_devices.has_key(&#39;CONFIG_VGA_PCI&#39;) or=
<br>
diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c<br>
new file mode 100644<br>
index 0000000000..268ffe81ec<br>
--- /dev/null<br>
+++ b/hw/display/virtio-dmabuf.c<br>
@@ -0,0 +1,134 @@<br>
+/*<br>
+ * Virtio Shared dma-buf<br>
+ *<br>
+ * Copyright Red Hat, Inc. 2023<br>
+ *<br>
+ * Authors:<br>
+ *=C2=A0 =C2=A0 =C2=A0Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.c=
om" target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
+ * See the COPYING file in the top-level directory.<br>
+ */<br>
+<br>
+#include &quot;hw/virtio/virtio-dmabuf.h&quot;<br>
+<br>
+<br>
+static GMutex lock;<br>
+static GHashTable *resource_uuids;<br>
+<br>
+/*<br>
+ * uuid_equal_func: wrapper for UUID is_equal function to<br>
+ * satisfy g_hash_table_new expected parameters signatures.<br>
+ */<br>
+static int uuid_equal_func(const void *lhv, const void *rhv)<br>
+{<br>
+=C2=A0 =C2=A0 return qemu_uuid_is_equal(lhv, rhv);<br>
+}<br>
+<br>
+static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)=
<br>
+{<br>
+=C2=A0 =C2=A0 bool result;<br>
+=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
+=C2=A0 =C2=A0 if (resource_uuids =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_uuids =3D g_hash_table_new_full(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_hash, uuid_equal_func,=
 NULL, g_free);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (g_hash_table_lookup(resource_uuids, uuid) !=3D NULL) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 result =3D g_hash_table_insert(resource_uuids, uuid, value);=
<br>
+=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
+<br>
+=C2=A0 =C2=A0 return result;<br>
+}<br>
+<br>
+bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)<br>
+{<br>
+=C2=A0 =C2=A0 bool result;<br>
+=C2=A0 =C2=A0 VirtioSharedObject *vso;<br>
+=C2=A0 =C2=A0 if (udmabuf_fd &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 vso =3D g_new(VirtioSharedObject, 1);<br>
+=C2=A0 =C2=A0 vso-&gt;type =3D TYPE_DMABUF;<br>
+=C2=A0 =C2=A0 vso-&gt;value =3D GINT_TO_POINTER(udmabuf_fd);<br>
+=C2=A0 =C2=A0 result =3D virtio_add_resource(uuid, vso);<br>
+<br>
+=C2=A0 =C2=A0 return result;<br></blockquote><div><br></div><div>Just real=
ized that the result variable is not required anymore</div><div>with the la=
st change.</div><div><br></div><div>Not sure if it is worth sending a new r=
eview for this...</div><div>I can take it into account for a follow-up refa=
ctor for the next</div><div>update I make on the file. Or just send a separ=
ate trivial patch.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
+}<br>
+<br>
+bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)<br>
+{<br>
+=C2=A0 =C2=A0 bool result;<br>
+=C2=A0 =C2=A0 VirtioSharedObject *vso;<br>
+=C2=A0 =C2=A0 if (dev =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 vso =3D g_new(VirtioSharedObject, 1);<br>
+=C2=A0 =C2=A0 vso-&gt;type =3D TYPE_VHOST_DEV;<br>
+=C2=A0 =C2=A0 vso-&gt;value =3D dev;<br>
+=C2=A0 =C2=A0 result =3D virtio_add_resource(uuid, vso);<br>
+<br>
+=C2=A0 =C2=A0 return result;<br>
+}<br>
+<br>
+bool virtio_remove_resource(const QemuUUID *uuid)<br>
+{<br>
+=C2=A0 =C2=A0 bool result;<br>
+=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
+=C2=A0 =C2=A0 result =3D g_hash_table_remove(resource_uuids, uuid);<br>
+=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
+<br>
+=C2=A0 =C2=A0 return result;<br>
+}<br>
+<br>
+static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)<br>
+{<br>
+=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
+=C2=A0 =C2=A0 if (resource_uuids =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 gpointer lookup_res =3D g_hash_table_lookup(resource_uuids, =
uuid);<br>
+=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
+=C2=A0 =C2=A0 return (VirtioSharedObject*) lookup_res;<br>
+}<br>
+<br>
+int virtio_lookup_dmabuf(const QemuUUID *uuid)<br>
+{<br>
+=C2=A0 =C2=A0 VirtioSharedObject *vso =3D get_shared_object(uuid);<br>
+=C2=A0 =C2=A0 if (vso =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 assert(vso-&gt;type =3D=3D TYPE_DMABUF);<br>
+=C2=A0 =C2=A0 return GPOINTER_TO_INT(vso-&gt;value);<br>
+}<br>
+<br>
+struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)<br>
+{<br>
+=C2=A0 =C2=A0 VirtioSharedObject *vso =3D get_shared_object(uuid);<br>
+=C2=A0 =C2=A0 if (vso =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 assert(vso-&gt;type =3D=3D TYPE_VHOST_DEV);<br>
+=C2=A0 =C2=A0 return (struct vhost_dev *) vso-&gt;value;<br>
+}<br>
+<br>
+SharedObjectType virtio_object_type(const QemuUUID *uuid)<br>
+{<br>
+=C2=A0 =C2=A0 VirtioSharedObject *vso =3D get_shared_object(uuid);<br>
+=C2=A0 =C2=A0 if (vso =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TYPE_INVALID;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return vso-&gt;type;<br>
+}<br>
+<br>
+void virtio_free_resources(void)<br>
+{<br>
+=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
+=C2=A0 =C2=A0 g_hash_table_destroy(resource_uuids);<br>
+=C2=A0 =C2=A0 /* Reference count shall be 0 after the implicit unref on de=
stroy */<br>
+=C2=A0 =C2=A0 resource_uuids =3D NULL;<br>
+=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
+}<br>
diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-d=
mabuf.h<br>
new file mode 100644<br>
index 0000000000..202eec5868<br>
--- /dev/null<br>
+++ b/include/hw/virtio/virtio-dmabuf.h<br>
@@ -0,0 +1,103 @@<br>
+/*<br>
+ * Virtio Shared dma-buf<br>
+ *<br>
+ * Copyright Red Hat, Inc. 2023<br>
+ *<br>
+ * Authors:<br>
+ *=C2=A0 =C2=A0 =C2=A0Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.c=
om" target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPL, version 2.<br>
+ * See the COPYING file in the top-level directory.<br>
+ */<br>
+<br>
+#ifndef VIRTIO_DMABUF_H<br>
+#define VIRTIO_DMABUF_H<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+<br>
+#include &lt;glib.h&gt;<br>
+#include &quot;qemu/uuid.h&quot;<br>
+#include &quot;vhost.h&quot;<br>
+<br>
+typedef enum SharedObjectType {<br>
+=C2=A0 =C2=A0 TYPE_INVALID =3D 0,<br>
+=C2=A0 =C2=A0 TYPE_DMABUF,<br>
+=C2=A0 =C2=A0 TYPE_VHOST_DEV,<br>
+} SharedObjectType;<br>
+<br>
+typedef struct VirtioSharedObject {<br>
+=C2=A0 =C2=A0 SharedObjectType type;<br>
+=C2=A0 =C2=A0 gpointer value;<br>
+} VirtioSharedObject;<br>
+<br>
+/**<br>
+ * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup table<br=
>
+ * @uuid: new resource&#39;s UUID<br>
+ * @dmabuf_fd: the dma-buf descriptor that will be stored and shared with<=
br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0other virtio devices. Th=
e caller retains ownership over the<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0descriptor and its lifec=
ycle.<br>
+ *<br>
+ * Note: @dmabuf_fd must be a valid (non-negative) file descriptor.<br>
+ *<br>
+ * Return: true if the UUID did not exist and the resource has been added,=
<br>
+ * false if another resource with the same UUID already existed.<br>
+ * Note that if it finds a repeated UUID, the resource is not inserted in<=
br>
+ * the lookup table.<br>
+ */<br>
+bool virtio_add_dmabuf(QemuUUID *uuid, int dmabuf_fd);<br>
+<br>
+/**<br>
+ * virtio_add_vhost_device() - Add a new exporter vhost device that holds =
the<br>
+ * resource with the associated UUID<br>
+ * @uuid: new resource&#39;s UUID<br>
+ * @dev: the pointer to the vhost device that holds the resource. The call=
er<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0retains ownership over the device struct and =
its lifecycle.<br>
+ *<br>
+ * Return: true if the UUID did not exist and the device has been tracked,=
<br>
+ * false if another resource with the same UUID already existed.<br>
+ * Note that if it finds a repeated UUID, the resource is not inserted in<=
br>
+ * the lookup table.<br>
+ */<br>
+bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev);<br>
+<br>
+/**<br>
+ * virtio_remove_resource() - Removes a resource from the lookup table<br>
+ * @uuid: resource&#39;s UUID<br>
+ *<br>
+ * Return: true if the UUID has been found and removed from the lookup tab=
le.<br>
+ */<br>
+bool virtio_remove_resource(const QemuUUID *uuid);<br>
+<br>
+/**<br>
+ * virtio_lookup_dmabuf() - Looks for a dma-buf resource in the lookup tab=
le<br>
+ * @uuid: resource&#39;s UUID<br>
+ *<br>
+ * Return: the dma-buf file descriptor integer, or -1 if the key is not fo=
und.<br>
+ */<br>
+int virtio_lookup_dmabuf(const QemuUUID *uuid);<br>
+<br>
+/**<br>
+ * virtio_lookup_vhost_device() - Looks for an exporter vhost device in th=
e<br>
+ * lookup table<br>
+ * @uuid: resource&#39;s UUID<br>
+ *<br>
+ * Return: pointer to the vhost_dev struct, or NULL if the key is not foun=
d.<br>
+ */<br>
+struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid);<br>
+<br>
+/**<br>
+ * virtio_object_type() - Looks for the type of resource in the lookup tab=
le<br>
+ * @uuid: resource&#39;s UUID<br>
+ *<br>
+ * Return: the type of resource associated with the UUID, or TYPE_INVALID =
if<br>
+ * the key is not found.<br>
+ */<br>
+SharedObjectType virtio_object_type(const QemuUUID *uuid);<br>
+<br>
+/**<br>
+ * virtio_free_resources() - Destroys all keys and values of the shared<br=
>
+ * resources lookup table, and frees them<br>
+ */<br>
+void virtio_free_resources(void);<br>
+<br>
+#endif /* VIRTIO_DMABUF_H */<br>
diff --git a/tests/unit/meson.build b/tests/unit/meson.build<br>
index 93977cc32d..425ecc30fb 100644<br>
--- a/tests/unit/meson.build<br>
+++ b/tests/unit/meson.build<br>
@@ -50,6 +50,7 @@ tests =3D {<br>
=C2=A0 =C2=A0&#39;test-qapi-util&#39;: [],<br>
=C2=A0 =C2=A0&#39;test-interval-tree&#39;: [],<br>
=C2=A0 =C2=A0&#39;test-xs-node&#39;: [qom],<br>
+=C2=A0 &#39;test-virtio-dmabuf&#39;: [meson.project_source_root() / &#39;h=
w/display/virtio-dmabuf.c&#39;],<br>
=C2=A0}<br>
<br>
=C2=A0if have_system or have_tools<br>
diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabu=
f.c<br>
new file mode 100644<br>
index 0000000000..40fe262538<br>
--- /dev/null<br>
+++ b/tests/unit/test-virtio-dmabuf.c<br>
@@ -0,0 +1,137 @@<br>
+/*<br>
+ * QEMU tests for shared dma-buf API<br>
+ *<br>
+ * Copyright (c) 2023 Red Hat, Inc.<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see &lt;<a href=3D"http://www.=
gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/=
licenses/</a>&gt;.<br>
+ *<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;hw/virtio/virtio-dmabuf.h&quot;<br>
+<br>
+<br>
+static void test_add_remove_resources(void)<br>
+{<br>
+=C2=A0 =C2=A0 QemuUUID uuid;<br>
+=C2=A0 =C2=A0 int i, dmabuf_fd;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 100; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf_fd =3D g_random_int_range(3, 500);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add a new resource */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_add_dmabuf(&amp;uuid, dmabuf_f=
d));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
), =3D=3D, dmabuf_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Remove the resource */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_remove_resource(&amp;uuid));<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Resource is not found anymore */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
), =3D=3D, -1);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void test_add_remove_dev(void)<br>
+{<br>
+=C2=A0 =C2=A0 QemuUUID uuid;<br>
+=C2=A0 =C2=A0 struct vhost_dev *dev =3D g_new0(struct vhost_dev, 1);<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 100; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_add_vhost_device(&amp;uuid, dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* vhost device is found */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_lookup_vhost_device(&amp;uuid)=
 !=3D NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Remove the vhost device */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_remove_resource(&amp;uuid));<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* vhost device is not found anymore */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_lookup_vhost_device(&amp;uuid)=
 =3D=3D NULL);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_free(dev);<br>
+}<br>
+<br>
+static void test_remove_invalid_resource(void)<br>
+{<br>
+=C2=A0 =C2=A0 QemuUUID uuid;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 20; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
), =3D=3D, -1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Removing a resource that does not exist ret=
urns false */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_remove_resource(&amp;uui=
d));<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void test_add_invalid_resource(void)<br>
+{<br>
+=C2=A0 =C2=A0 QemuUUID uuid;<br>
+=C2=A0 =C2=A0 struct vhost_dev *dev =3D NULL;<br>
+=C2=A0 =C2=A0 int i, dmabuf_fd =3D -2, alt_dmabuf =3D 2;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 20; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add a new resource with invalid (negative) =
resource fd */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_add_dmabuf(&amp;uuid, dm=
abuf_fd));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Resource is not found */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
), =3D=3D, -1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add a new vhost device with invalid (NULL) =
pointer */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_add_vhost_device(&amp;uu=
id, dev));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* vhost device is not found */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_lookup_vhost_device(&amp;uuid)=
 =3D=3D NULL);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 20; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add a valid resource */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf_fd =3D g_random_int_range(3, 500);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_add_dmabuf(&amp;uuid, dmabuf_f=
d));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
), =3D=3D, dmabuf_fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add a new resource with repeated uuid retur=
ns false */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_false(virtio_add_dmabuf(&amp;uuid, al=
t_dmabuf));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The value for the uuid key is not replaced =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
), =3D=3D, dmabuf_fd);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void test_free_resources(void)<br>
+{<br>
+=C2=A0 =C2=A0 QemuUUID uuids[20];<br>
+=C2=A0 =C2=A0 int i, dmabuf_fd;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(uuids); ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuids[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dmabuf_fd =3D g_random_int_range(3, 500);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_add_dmabuf(&amp;uuids[i], dmab=
uf_fd));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
s[i]), =3D=3D, dmabuf_fd);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 virtio_free_resources();<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(uuids); ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* None of the resources is found after free&#=
39;d */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp;uuid=
s[i]), =3D=3D, -1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+}<br>
+<br>
+int main(int argc, char **argv)<br>
+{<br>
+=C2=A0 =C2=A0 g_test_init(&amp;argc, &amp;argv, NULL);<br>
+=C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/add_rm_res&quot;, test_=
add_remove_resources);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/add_rm_de=
v&quot;, test_add_remove_dev);<br>
+=C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/rm_invalid_res&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test=
_remove_invalid_resource);<br>
+=C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/add_invalid_res&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test=
_add_invalid_resource);<br>
+=C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/free_res&quot;, test_fr=
ee_resources);<br>
+<br>
+=C2=A0 =C2=A0 return g_test_run();<br>
+}<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div></div>

--0000000000008065950604af8763--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D2C74DDB5
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:02:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIw8B-0002aZ-PI; Mon, 10 Jul 2023 15:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIw7e-0002Yv-Of
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIw7b-0007uj-JH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689015629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z4rp7ztHsWsPntO08VlLQF1KaQuFFDj5u0DP3DCsToM=;
 b=MskRJ8VCdKys77oEp6sNn6B+ksj0Yb7tytPtgN1Gsy9OnFiK2pMrZokiztFOBo35JxFeXK
 2Kr3gRC3WNyS9DOCRIrVkYf5UXfiZmosxj3CAKa96WIkCfcFRl31Alb3T+oS3eYCqOy5FY
 by9Nox12lgulHRpEv4fbKig5qePEOqM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-L4l1kTKPN9G2OP-ZIY-4KQ-1; Mon, 10 Jul 2023 15:00:28 -0400
X-MC-Unique: L4l1kTKPN9G2OP-ZIY-4KQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3158f4d72e9so1315358f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 12:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689015627; x=1691607627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4rp7ztHsWsPntO08VlLQF1KaQuFFDj5u0DP3DCsToM=;
 b=U+aQcHQsNLKpULALLzfHxzxtDRk90BO/T8K+E8d3oK0mZEhaUV11xBbYwSCRFBSLk/
 +pfZjoCshCNtl/D8z6ih5380KHuYiUy/qaxvLY3YzoDvSQYLu4UT3mtUGx0mY1EmBo5E
 N/Rt7Hi9IEZbSzeZA0GOm+KjbMgZbXfZtBIe2qt/othPbhzkbsRCtDFPhMLRz/ZTduKF
 nhnvhe7Y0EQKESUPzfZVIlOT7xF++LfIGIVPsIbBNn/KOenxU8petMefxEK26hesuNud
 S/lX5JGds+mE4J2HmvVlWBvqMo9qj67gxrgTCpE99kNWpdfkrDkLspCDXnVKJZOLCRkr
 hgkA==
X-Gm-Message-State: ABy/qLZDdCjGokxUCtFY1iI/baoLiUudSdAuVNPJpSaDujEREYBF1Mbu
 Hxd3MO94g+4kUQHGEjFfth1tDcGK4lu8GgwxcQ14CXlVF13+mdACLJBJLD4a3ds3e3FTbOwF2ni
 lhWxw4B6veoar+c4=
X-Received: by 2002:adf:f8c3:0:b0:314:30ed:9b55 with SMTP id
 f3-20020adff8c3000000b0031430ed9b55mr8370205wrq.15.1689015626849; 
 Mon, 10 Jul 2023 12:00:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGnJHB3mneCHcKUvLT8z380OwHU27lF/9gevOw/F11xtOn7r9Cl88rbRPVefjlbazHCXkWGAQ==
X-Received: by 2002:adf:f8c3:0:b0:314:30ed:9b55 with SMTP id
 f3-20020adff8c3000000b0031430ed9b55mr8370173wrq.15.1689015626295; 
 Mon, 10 Jul 2023 12:00:26 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 q3-20020a5d5743000000b003143c6e09ccsm180710wrw.16.2023.07.10.12.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 12:00:25 -0700 (PDT)
Date: Mon, 10 Jul 2023 15:00:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, cohuck@redhat.com,
 Fam Zheng <fam@euphon.net>, kraxel@redhat.com
Subject: Re: [PATCH v4 2/4] virtio-dmabuf: introduce virtio-dmabuf
Message-ID: <20230710145806-mutt-send-email-mst@kernel.org>
References: <20230626073426.285659-1-aesteve@redhat.com>
 <20230626073426.285659-3-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626073426.285659-3-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 26, 2023 at 09:34:24AM +0200, Albert Esteve wrote:
> This API manages objects (in this iteration,
> dmabuf fds) that can be shared along different
> virtio devices.
> 
> The API allows the different devices to add,
> remove and/or retrieve the objects by simply
> invoking the public functions that reside in the
> virtio-dmabuf file.
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  MAINTAINERS                       |   7 ++
>  hw/display/meson.build            |   1 +
>  hw/display/virtio-dmabuf.c        |  90 ++++++++++++++++++++++++
>  include/hw/virtio/virtio-dmabuf.h |  59 ++++++++++++++++
>  tests/unit/meson.build            |   1 +
>  tests/unit/test-virtio-dmabuf.c   | 112 ++++++++++++++++++++++++++++++
>  6 files changed, 270 insertions(+)
>  create mode 100644 hw/display/virtio-dmabuf.c
>  create mode 100644 include/hw/virtio/virtio-dmabuf.h
>  create mode 100644 tests/unit/test-virtio-dmabuf.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f323cd2eb..ce77a691a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2150,6 +2150,13 @@ T: git https://gitlab.com/cohuck/qemu.git s390-next
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

Hmm new functionality that no one seems to care
about enough to review,

Gerd you suggested this - ready to be a maintainer?
co-maintain with Albert?


> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 413ba4ab24..05619c6968 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -37,6 +37,7 @@ system_ss.add(when: 'CONFIG_MACFB', if_true: files('macfb.c'))
>  system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
>  
>  system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
> +system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c'))
>  
>  if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
>      config_all_devices.has_key('CONFIG_VGA_PCI') or
> diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> new file mode 100644
> index 0000000000..7dba0b2c71
> --- /dev/null
> +++ b/hw/display/virtio-dmabuf.c
> @@ -0,0 +1,90 @@
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
> +static bool virtio_add_resource(QemuUUID *uuid, gpointer value)
> +{
> +    assert(resource_uuids != NULL);
> +    if (g_hash_table_lookup(resource_uuids, uuid) != NULL) {
> +        return false;
> +    }
> +
> +    return g_hash_table_insert(resource_uuids, uuid, value);
> +}
> +
> +static gpointer virtio_lookup_resource(const QemuUUID *uuid)
> +{
> +    if (resource_uuids == NULL) {
> +        return NULL;
> +    }
> +
> +    return g_hash_table_lookup(resource_uuids, uuid);
> +}
> +
> +bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
> +{
> +    bool result;
> +    if (udmabuf_fd < 0) {
> +        return false;
> +    }
> +    g_mutex_lock(&lock);
> +    if (resource_uuids == NULL) {
> +        resource_uuids = g_hash_table_new(qemu_uuid_hash, uuid_equal_func);
> +    }
> +    result = virtio_add_resource(uuid, GINT_TO_POINTER(udmabuf_fd));
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
> +
> +    return result;
> +}
> +
> +int virtio_lookup_dmabuf(const QemuUUID *uuid)
> +{
> +    g_mutex_lock(&lock);
> +    gpointer lookup_res = virtio_lookup_resource(uuid);
> +    g_mutex_unlock(&lock);
> +    if (lookup_res == NULL) {
> +        return -1;
> +    }
> +
> +    return GPOINTER_TO_INT(lookup_res);
> +}
> +
> +void virtio_free_resources(void)
> +{
> +    g_hash_table_destroy(resource_uuids);
> +    /* Reference count shall be 0 after the implicit unref on destroy */
> +    resource_uuids = NULL;
> +}
> diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
> new file mode 100644
> index 0000000000..4fdd394c4b
> --- /dev/null
> +++ b/include/hw/virtio/virtio-dmabuf.h
> @@ -0,0 +1,59 @@
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
> +
> +/**
> + * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup table
> + * @uuid: new resource's UUID
> + * @dmabuf_fd: the dma-buf descriptor that will be stored and shared with
> + *             other virtio devices. The caller retains ownership over the
> + *             descriptor and its lifecycle.
> + *
> + * Note: @dmabuf_fd must be a valid (non-negative) file descriptor.
> + *
> + * Return: true if the UUID did not exist and the resource has been added,
> + * false if another resource with the same UUID already existed.
> + * Note that if it finds a repeated UUID, the resource is not inserted in
> + * the lookup table.
> + */
> +bool virtio_add_dmabuf(QemuUUID *uuid, int dmabuf_fd);
> +
> +/**
> + * virtio_remove_resource() - Removes a resource from the lookup table
> + * @uuid: resource's UUID
> + *
> + * Return: true if the UUID has been found and removed from the lookup table.
> + */
> +bool virtio_remove_resource(const QemuUUID *uuid);
> +
> +/**
> + * virtio_lookup_dmabuf() - Looks for a dma-buf resource in the lookup table
> + * @uuid: resource's UUID
> + *
> + * Return: the dma-buf file descriptor integer, or -1 if the key is not found.
> + */
> +int virtio_lookup_dmabuf(const QemuUUID *uuid);
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
> @@ -50,6 +50,7 @@ tests = {
>    'test-qapi-util': [],
>    'test-interval-tree': [],
>    'test-xs-node': [qom],
> +  'test-virtio-dmabuf': [meson.project_source_root() / 'hw/display/virtio-dmabuf.c'],
>  }
>  
>  if have_system or have_tools
> diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabuf.c
> new file mode 100644
> index 0000000000..53436aa93d
> --- /dev/null
> +++ b/tests/unit/test-virtio-dmabuf.c
> @@ -0,0 +1,112 @@
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
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
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
> +    for (i = 0; i < 100; ++i) {
> +        qemu_uuid_generate(&uuid);
> +        dmabuf_fd = g_random_int_range(3, 500);
> +        /* Add a new resource */
> +        g_assert(virtio_add_dmabuf(&uuid, dmabuf_fd));
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, dmabuf_fd);
> +        /* Remove the resource */
> +        g_assert(virtio_remove_resource(&uuid));
> +        /* Resource is not found anymore */
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
> +    }
> +}
> +
> +static void test_remove_invalid_resource(void)
> +{
> +    QemuUUID uuid;
> +    int i;
> +
> +    for (i = 0; i < 20; ++i) {
> +        qemu_uuid_generate(&uuid);
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
> +        /* Removing a resource that does not exist returns false */
> +        g_assert_false(virtio_remove_resource(&uuid));
> +    }
> +}
> +
> +static void test_add_invalid_resource(void)
> +{
> +    QemuUUID uuid;
> +    int i, dmabuf_fd = -2, alt_dmabuf = 2;
> +
> +    for (i = 0; i < 20; ++i) {
> +        qemu_uuid_generate(&uuid);
> +        /* Add a new resource with invalid (negative) resource fd */
> +        g_assert_false(virtio_add_dmabuf(&uuid, dmabuf_fd));
> +        /* Resource is not found */
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
> +    }
> +
> +    for (i = 0; i < 20; ++i) {
> +        /* Add a valid resource */
> +        qemu_uuid_generate(&uuid);
> +        dmabuf_fd = g_random_int_range(3, 500);
> +        g_assert(virtio_add_dmabuf(&uuid, dmabuf_fd));
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, dmabuf_fd);
> +        /* Add a new resource with repeated uuid returns false */
> +        g_assert_false(virtio_add_dmabuf(&uuid, alt_dmabuf));
> +        /* The value for the uuid key is not replaced */
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, dmabuf_fd);
> +    }
> +}
> +
> +static void test_free_resources(void)
> +{
> +    QemuUUID uuids[20];
> +    int i, dmabuf_fd;
> +
> +    for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
> +        qemu_uuid_generate(&uuids[i]);
> +        dmabuf_fd = g_random_int_range(3, 500);
> +        g_assert(virtio_add_dmabuf(&uuids[i], dmabuf_fd));
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), ==, dmabuf_fd);
> +    }
> +    virtio_free_resources();
> +    for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
> +        /* None of the resources is found after free'd */
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), ==, -1);
> +    }
> +
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_add_func("/virtio-dmabuf/add_rm_res", test_add_remove_resources);
> +    g_test_add_func("/virtio-dmabuf/rm_invalid_res",
> +                    test_remove_invalid_resource);
> +    g_test_add_func("/virtio-dmabuf/add_invalid_res",
> +                    test_add_invalid_resource);
> +    g_test_add_func("/virtio-dmabuf/free_res", test_free_resources);
> +
> +    return g_test_run();
> +}
> -- 
> 2.40.0



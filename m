Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA7C7E401A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:33:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MD7-0002fe-EY; Tue, 07 Nov 2023 08:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0MD5-0002b0-2J
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:33:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0MD2-00040M-7d
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699364015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWeesfY61gMOep56A0imnJbu4o62SKDoHrKiwL1vm6U=;
 b=JwXAL0tuCdeS32SusJ2P3kYFf4Hl+EcKjmhbLimkDu/6fzfRObFQdl2V+OpQ+VFpsh/HxE
 uyA0/HdVMFXmPXDpYufz96onEhibhPuVnpWwGlmJ6acA7xl2mjjPobtxNK71UypLi4F0kL
 hMmhywvrbZ0S1UFJcRXeaVrbwI+y/yw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-P9CQcbRqNRqfxRzIQO4iPg-1; Tue, 07 Nov 2023 08:33:18 -0500
X-MC-Unique: P9CQcbRqNRqfxRzIQO4iPg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7788fa5f1b0so655398085a.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 05:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699363998; x=1699968798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OWeesfY61gMOep56A0imnJbu4o62SKDoHrKiwL1vm6U=;
 b=V8dQq+gGukTUEQfQ0cbQqh2CfCTcZYUtRNRBK7SPvcWJl5/eDt+bj89S85S51mPqPO
 tjkBGsWpDoI47cESN2sQpVwu2z18MzA277zhbqMeigJUZKHxsZstgVnXibMobJT536ZH
 D7rFK4o9+J9cjTfJATCJY4uNxxDz2IjTBjfZtHAABg91H855hoWNfWgg4N1rVNlBvsID
 GzEmKpcEsy2ZZqC4r4vWrjRR0wFdXNgOnZsbIJkUovWyq0Z5Zygt//lgEN/wiw2jkKzK
 VQjLa09JEnkKD1PWeqD7r1HkIDGdqzV3WtzgKgLW/Nq/NEthe7nXepLoxOt4h4q0iV63
 eQ9A==
X-Gm-Message-State: AOJu0YwmFRJebrvwGUmTn06u06QxSC2iPDAZzWAiFK/bKoirrafPpmI2
 +Qr9WpJgBfuiQK2WHfGmJKB6tESZXc9L/lUY/8J19nzDhNjgbyXyd9ijGSwhlGXhKF/1H3PuK4i
 SKORICSMXYPnna6k=
X-Received: by 2002:a05:620a:558b:b0:777:6631:85b6 with SMTP id
 vq11-20020a05620a558b00b00777663185b6mr32426637qkn.39.1699363997901; 
 Tue, 07 Nov 2023 05:33:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWj2HjOKai+IebhEC1Jk7qUyOThHM1lHUuLkTlZGWaZ6ajAkbEeG086gGyqrz3T/M1O4u1uw==
X-Received: by 2002:a05:620a:558b:b0:777:6631:85b6 with SMTP id
 vq11-20020a05620a558b00b00777663185b6mr32426600qkn.39.1699363997535; 
 Tue, 07 Nov 2023 05:33:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 po2-20020a05620a384200b00774309d3e89sm4194638qkn.7.2023.11.07.05.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 05:33:17 -0800 (PST)
Message-ID: <da7de379-bd8c-47d1-b7bf-412be92a2756@redhat.com>
Date: Tue, 7 Nov 2023 14:33:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/41] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-27-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231102071302.1818071-27-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/2/23 08:12, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> Introduce an iommufd object which allows the interaction
> with the host /dev/iommu device.
> 
> The /dev/iommu can have been already pre-opened outside of qemu,
> in which case the fd can be passed directly along with the
> iommufd object:
> 
> This allows the iommufd object to be shared accross several
> subsystems (VFIO, VDPA, ...). For example, libvirt would open
> the /dev/iommu once.
> 
> If no fd is passed along with the iommufd object, the /dev/iommu
> is opened by the qemu code.
> 
> The CONFIG_IOMMUFD option must be set to compile this new object.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v4: add CONFIG_IOMMUFD check, document default case
> 
>   MAINTAINERS              |   7 ++
>   qapi/qom.json            |  22 ++++
>   include/sysemu/iommufd.h |  46 +++++++
>   backends/iommufd-stub.c  |  59 +++++++++
>   backends/iommufd.c       | 257 +++++++++++++++++++++++++++++++++++++++
>   backends/Kconfig         |   4 +
>   backends/meson.build     |   5 +
>   backends/trace-events    |  12 ++
>   qemu-options.hx          |  13 ++
>   9 files changed, 425 insertions(+)
>   create mode 100644 include/sysemu/iommufd.h
>   create mode 100644 backends/iommufd-stub.c
>   create mode 100644 backends/iommufd.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd8d6b140f..6f35159255 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2135,6 +2135,13 @@ F: hw/vfio/ap.c
>   F: docs/system/s390x/vfio-ap.rst
>   L: qemu-s390x@nongnu.org
>   
> +iommufd
> +M: Yi Liu <yi.l.liu@intel.com>
> +M: Eric Auger <eric.auger@redhat.com>
> +S: Supported
> +F: backends/iommufd.c
> +F: include/sysemu/iommufd.h
> +
>   vhost
>   M: Michael S. Tsirkin <mst@redhat.com>
>   S: Supported
> diff --git a/qapi/qom.json b/qapi/qom.json
> index c53ef978ff..27300add48 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -794,6 +794,24 @@
>   { 'struct': 'VfioUserServerProperties',
>     'data': { 'socket': 'SocketAddress', 'device': 'str' } }
>   
> +##
> +# @IOMMUFDProperties:
> +#
> +# Properties for iommufd objects.
> +#
> +# @fd: file descriptor name previously passed via 'getfd' command,
> +#     which represents a pre-opened /dev/iommu.  This allows the
> +#     iommufd object to be shared accross several subsystems
> +#     (VFIO, VDPA, ...), and the file descriptor to be shared
> +#     with other process, e.g. DPDK.  (default: QEMU opens
> +#     /dev/iommu by itself)
> +#
> +# Since: 8.2
> +##
> +{ 'struct': 'IOMMUFDProperties',
> +  'data': { '*fd': 'str' },
> +  'if': 'CONFIG_IOMMUFD' }


Activating or not IOMMUFD on a platform is a configuration choice
and it is not a dependency on an external resource. I would make
things simpler and drop all the #ifdef in the documentation files.

There might be a way to remove the documentation also. Not a big
issue for now.


> +
>   ##
>   # @RngProperties:
>   #
> @@ -934,6 +952,8 @@
>       'input-barrier',
>       { 'name': 'input-linux',
>         'if': 'CONFIG_LINUX' },
> +    { 'name': 'iommufd',
> +      'if': 'CONFIG_IOMMUFD' },
>       'iothread',
>       'main-loop',
>       { 'name': 'memory-backend-epc',
> @@ -1003,6 +1023,8 @@
>         'input-barrier':              'InputBarrierProperties',
>         'input-linux':                { 'type': 'InputLinuxProperties',
>                                         'if': 'CONFIG_LINUX' },
> +      'iommufd':                    { 'type': 'IOMMUFDProperties',
> +                                      'if': 'CONFIG_IOMMUFD' },
>         'iothread':                   'IothreadProperties',
>         'main-loop':                  'MainLoopProperties',
>         'memory-backend-epc':         { 'type': 'MemoryBackendEpcProperties',
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> new file mode 100644
> index 0000000000..f0e5c7eeb8
> --- /dev/null
> +++ b/include/sysemu/iommufd.h
> @@ -0,0 +1,46 @@
> +#ifndef SYSEMU_IOMMUFD_H
> +#define SYSEMU_IOMMUFD_H
> +
> +#include "qom/object.h"
> +#include "qemu/thread.h"
> +#include "exec/hwaddr.h"
> +#include "exec/cpu-common.h"
> +
> +#define TYPE_IOMMUFD_BACKEND "iommufd"
> +OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass,
> +                    IOMMUFD_BACKEND)
> +#define IOMMUFD_BACKEND(obj) \
> +    OBJECT_CHECK(IOMMUFDBackend, (obj), TYPE_IOMMUFD_BACKEND)
> +#define IOMMUFD_BACKEND_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(IOMMUFDBackendClass, (obj), TYPE_IOMMUFD_BACKEND)
> +#define IOMMUFD_BACKEND_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(IOMMUFDBackendClass, (klass), TYPE_IOMMUFD_BACKEND)
> +struct IOMMUFDBackendClass {
> +    ObjectClass parent_class;
> +};
> +
> +struct IOMMUFDBackend {
> +    Object parent;
> +
> +    /*< protected >*/
> +    int fd;            /* /dev/iommu file descriptor */
> +    bool owned;        /* is the /dev/iommu opened internally */
> +    QemuMutex lock;
> +    uint32_t users;
> +
> +    /*< public >*/
> +};
> +
> +int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
> +void iommufd_backend_disconnect(IOMMUFDBackend *be);
> +
> +int iommufd_backend_get_ioas(IOMMUFDBackend *be, uint32_t *ioas_id);
> +void iommufd_backend_put_ioas(IOMMUFDBackend *be, uint32_t ioas_id);
> +void iommufd_backend_free_id(int fd, uint32_t id);
> +int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
> +                            ram_addr_t size, void *vaddr, bool readonly);
> +int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> +                              hwaddr iova, ram_addr_t size);
> +int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
> +                               uint32_t pt_id, uint32_t *out_hwpt);
> +#endif
> diff --git a/backends/iommufd-stub.c b/backends/iommufd-stub.c

I don't think this stub file is needed. Please drop.

> new file mode 100644
> index 0000000000..02ac844c17
> --- /dev/null
> +++ b/backends/iommufd-stub.c
> @@ -0,0 +1,59 @@
> +/*
> + * iommufd container backend stub
> + *
> + * Copyright (C) 2023 Intel Corporation.
> + * Copyright Red Hat, Inc. 2023
> + *
> + * Authors: Yi Liu <yi.l.liu@intel.com>
> + *          Eric Auger <eric.auger@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/iommufd.h"
> +#include "qemu/error-report.h"
> +
> +int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
> +{
> +    return 0;
> +}
> +void iommufd_backend_disconnect(IOMMUFDBackend *be)
> +{
> +}
> +void iommufd_backend_free_id(int fd, uint32_t id)
> +{
> +}
> +int iommufd_backend_get_ioas(IOMMUFDBackend *be, uint32_t *ioas_id)
> +{
> +    return 0;
> +}
> +void iommufd_backend_put_ioas(IOMMUFDBackend *be, uint32_t ioas_id)
> +{
> +}
> +int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
> +                            ram_addr_t size, void *vaddr, bool readonly)
> +{
> +    return 0;
> +}
> +int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> +                              hwaddr iova, ram_addr_t size)
> +{
> +    return 0;
> +}
> +int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
> +                               uint32_t pt_id, uint32_t *out_hwpt)
> +{
> +    return 0;
> +}
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> new file mode 100644
> index 0000000000..a526d58824
> --- /dev/null
> +++ b/backends/iommufd.c
> @@ -0,0 +1,257 @@
> +/*
> + * iommufd container backend
> + *
> + * Copyright (C) 2023 Intel Corporation.
> + * Copyright Red Hat, Inc. 2023
> + *
> + * Authors: Yi Liu <yi.l.liu@intel.com>
> + *          Eric Auger <eric.auger@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/iommufd.h"
> +#include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
> +#include "qemu/module.h"
> +#include "qom/object_interfaces.h"
> +#include "qemu/error-report.h"
> +#include "monitor/monitor.h"
> +#include "trace.h"
> +#include <sys/ioctl.h>
> +#include <linux/iommufd.h>
> +
> +static void iommufd_backend_init(Object *obj)
> +{
> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
> +
> +    be->fd = -1;
> +    be->users = 0;
> +    be->owned = true;
> +    qemu_mutex_init(&be->lock);
> +}
> +
> +static void iommufd_backend_finalize(Object *obj)
> +{
> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
> +
> +    if (be->owned) {
> +        close(be->fd);
> +        be->fd = -1;
> +    }
> +}
> +
> +static void iommufd_backend_set_fd(Object *obj, const char *str, Error **errp)
> +{
> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
> +    int fd = -1;
> +
> +    fd = monitor_fd_param(monitor_cur(), str, errp);
> +    if (fd == -1) {
> +        error_prepend(errp, "Could not parse remote object fd %s:", str);
> +        return;
> +    }
> +    qemu_mutex_lock(&be->lock);
> +    be->fd = fd;
> +    be->owned = false;
> +    qemu_mutex_unlock(&be->lock);
> +    trace_iommu_backend_set_fd(be->fd);
> +}
> +
> +static void iommufd_backend_class_init(ObjectClass *oc, void *data)
> +{
> +    object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
> +}
> +
> +int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
> +{
> +    int fd, ret = 0;
> +
> +    qemu_mutex_lock(&be->lock);
> +    if (be->users == UINT32_MAX) {
> +        error_setg(errp, "too many connections");
> +        ret = -E2BIG;
> +        goto out;
> +    }
> +    if (be->owned && !be->users) {
> +        fd = qemu_open_old("/dev/iommu", O_RDWR);
> +        if (fd < 0) {
> +            error_setg_errno(errp, errno, "/dev/iommu opening failed");
> +            ret = fd;
> +            goto out;
> +        }
> +        be->fd = fd;
> +    }
> +    be->users++;
> +out:
> +    trace_iommufd_backend_connect(be->fd, be->owned,
> +                                  be->users, ret);
> +    qemu_mutex_unlock(&be->lock);
> +    return ret;
> +}
> +
> +void iommufd_backend_disconnect(IOMMUFDBackend *be)
> +{
> +    qemu_mutex_lock(&be->lock);
> +    if (!be->users) {
> +        goto out;
> +    }
> +    be->users--;
> +    if (!be->users && be->owned) {
> +        close(be->fd);
> +        be->fd = -1;
> +    }
> +out:
> +    trace_iommufd_backend_disconnect(be->fd, be->users);
> +    qemu_mutex_unlock(&be->lock);
> +}
> +
> +static int iommufd_backend_alloc_ioas(int fd, uint32_t *ioas_id)
> +{
> +    int ret;
> +    struct iommu_ioas_alloc alloc_data  = {
> +        .size = sizeof(alloc_data),
> +        .flags = 0,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_IOAS_ALLOC, &alloc_data);
> +    if (ret) {
> +        error_report("Failed to allocate ioas %m");
> +    }
> +
> +    *ioas_id = alloc_data.out_ioas_id;
> +    trace_iommufd_backend_alloc_ioas(fd, *ioas_id, ret);
> +
> +    return ret;
> +}
> +
> +void iommufd_backend_free_id(int fd, uint32_t id)
> +{
> +    int ret;
> +    struct iommu_destroy des = {
> +        .size = sizeof(des),
> +        .id = id,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_DESTROY, &des);
> +    trace_iommufd_backend_free_id(fd, id, ret);
> +    if (ret) {
> +        error_report("Failed to free id: %u %m", id);
> +    }
> +}
> +
> +int iommufd_backend_get_ioas(IOMMUFDBackend *be, uint32_t *ioas_id)
> +{
> +    int ret;
> +
> +    ret = iommufd_backend_alloc_ioas(be->fd, ioas_id);
> +    trace_iommufd_backend_get_ioas(be->fd, *ioas_id, ret);
> +    return ret;
> +}
> +
> +void iommufd_backend_put_ioas(IOMMUFDBackend *be, uint32_t ioas_id)
> +{
> +    iommufd_backend_free_id(be->fd, ioas_id);
> +    trace_iommufd_backend_put_ioas(be->fd, ioas_id);
> +}
> +
> +int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
> +                            ram_addr_t size, void *vaddr, bool readonly)
> +{
> +    int ret;
> +    struct iommu_ioas_map map = {
> +        .size = sizeof(map),
> +        .flags = IOMMU_IOAS_MAP_READABLE |
> +                 IOMMU_IOAS_MAP_FIXED_IOVA,
> +        .ioas_id = ioas_id,
> +        .__reserved = 0,
> +        .user_va = (uintptr_t)vaddr,
> +        .iova = iova,
> +        .length = size,
> +    };
> +
> +    if (!readonly) {
> +        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
> +    }
> +
> +    ret = ioctl(be->fd, IOMMU_IOAS_MAP, &map);
> +    trace_iommufd_backend_map_dma(be->fd, ioas_id, iova, size,
> +                                  vaddr, readonly, ret);
> +    if (ret) {
> +        error_report("IOMMU_IOAS_MAP failed: %m");
> +    }
> +    return !ret ? 0 : -errno;
> +}
> +
> +int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> +                              hwaddr iova, ram_addr_t size)
> +{
> +    int ret;
> +    struct iommu_ioas_unmap unmap = {
> +        .size = sizeof(unmap),
> +        .ioas_id = ioas_id,
> +        .iova = iova,
> +        .length = size,
> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_IOAS_UNMAP, &unmap);
> +    trace_iommufd_backend_unmap_dma(be->fd, ioas_id, iova, size, ret);
> +    /*
> +     * TODO: IOMMUFD doesn't support mapping PCI BARs for now.
> +     * It's not a problem if there is no p2p dma, relax it here
> +     * and avoid many noisy trigger from vIOMMU side.

Should we add a warn_report() ?

> +     */
> +    if (ret && errno == ENOENT) {
> +        ret = 0;
> +    }
> +    if (ret) {
> +        error_report("IOMMU_IOAS_UNMAP failed: %m");
> +    }
> +    return !ret ? 0 : -errno;
> +}
> +
> +int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
> +                               uint32_t pt_id, uint32_t *out_hwpt)
> +{
> +    int ret;
> +    struct iommu_hwpt_alloc alloc_hwpt = {
> +        .size = sizeof(struct iommu_hwpt_alloc),
> +        .flags = 0,
> +        .dev_id = dev_id,
> +        .pt_id = pt_id,
> +        .__reserved = 0,
> +    };
> +
> +    ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
> +    trace_iommufd_backend_alloc_hwpt(iommufd, dev_id, pt_id,
> +                                     alloc_hwpt.out_hwpt_id, ret);
> +
> +    if (ret) {
> +        error_report("IOMMU_HWPT_ALLOC failed: %m");
> +    } else {
> +        *out_hwpt = alloc_hwpt.out_hwpt_id;
> +    }
> +    return !ret ? 0 : -errno;
> +}
> +
> +static const TypeInfo iommufd_backend_info = {
> +    .name = TYPE_IOMMUFD_BACKEND,
> +    .parent = TYPE_OBJECT,
> +    .instance_size = sizeof(IOMMUFDBackend),
> +    .instance_init = iommufd_backend_init,
> +    .instance_finalize = iommufd_backend_finalize,
> +    .class_size = sizeof(IOMMUFDBackendClass),
> +    .class_init = iommufd_backend_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&iommufd_backend_info);
> +}
> +
> +type_init(register_types);
> diff --git a/backends/Kconfig b/backends/Kconfig
> index f35abc1609..2cb23f62fa 100644
> --- a/backends/Kconfig
> +++ b/backends/Kconfig
> @@ -1 +1,5 @@
>   source tpm/Kconfig
> +
> +config IOMMUFD
> +    bool
> +    depends on VFIO
> diff --git a/backends/meson.build b/backends/meson.build
> index 914c7c4afb..05ac57ff15 100644
> --- a/backends/meson.build
> +++ b/backends/meson.build
> @@ -20,6 +20,11 @@ if have_vhost_user
>     system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('vhost-user.c'))
>   endif
>   system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
> +if have_iommufd
> +  system_ss.add(files('iommufd.c'))
> +else
> +  system_ss.add(files('iommufd-stub.c'))
> +endif

replace with :

  system_ss.add(when: 'CONFIG_IOMMUFD', if_true: files('iommufd.c'))

and drop iommufd-stub.c which will become useless.



>   if have_vhost_user_crypto
>     system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
>   endif
> diff --git a/backends/trace-events b/backends/trace-events
> index 652eb76a57..e5f828bca2 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -5,3 +5,15 @@ dbus_vmstate_pre_save(void)
>   dbus_vmstate_post_load(int version_id) "version_id: %d"
>   dbus_vmstate_loading(const char *id) "id: %s"
>   dbus_vmstate_saving(const char *id) "id: %s"
> +
> +# iommufd.c
> +iommufd_backend_connect(int fd, bool owned, uint32_t users, int ret) "fd=%d owned=%d users=%d (%d)"
> +iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
> +iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
> +iommufd_backend_get_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
> +iommufd_backend_put_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
> +iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
> +iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
> +iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
> +iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u out_hwpt=%u (%d)"
> diff --git a/qemu-options.hx b/qemu-options.hx
> index e26230bac5..ddfaddf8ce 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5210,6 +5210,19 @@ SRST
>   
>           The ``share`` boolean option is on by default with memfd.
>   
> +#ifdef CONFIG_IOMMUFD

Please remove.


Thanks,

C.




> +    ``-object iommufd,id=id[,fd=fd]``
> +        Creates an iommufd backend which allows control of DMA mapping
> +        through the /dev/iommu device.
> +
> +        The ``id`` parameter is a unique ID which frontends (such as
> +        vfio-pci of vdpa) will use to connect with the iommufd backend.
> +
> +        The ``fd`` parameter is an optional pre-opened file descriptor
> +        resulting from /dev/iommu opening. Usually the iommufd is shared
> +        across all subsystems, bringing the benefit of centralized
> +        reference counting.
> +#endif
>       ``-object rng-builtin,id=id``
>           Creates a random number generator backend which obtains entropy
>           from QEMU builtin functions. The ``id`` parameter is a unique ID



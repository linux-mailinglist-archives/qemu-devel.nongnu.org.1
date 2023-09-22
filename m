Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8F67AA9E5
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:17:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjaOa-0006ZU-4P; Fri, 22 Sep 2023 03:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjaOF-0006Vf-8E
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjaOB-0001ON-Ag
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695366945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ITur9HsGnQdv7PxUQgqM92n/WKFJaNzWDU84tP1oY8E=;
 b=hKd7Ou4Xop4N7v0UZ13NDNaV4dEhAv6rBJ6PsCCvaWdnwqBF3sNghZ8mxIlS94a71n3lus
 MkQ4hI8pwWupB/KJFhyklMX7SqhiMsnXTEXZnPKlEDCAnahK2CK5xfadEHXxa2c6D5LuFm
 eWCF4J9BeK8+nSdGkw+wjKJpPr48HdY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-xbSUPsi3Oredz9bLZYe1Aw-1; Fri, 22 Sep 2023 03:15:44 -0400
X-MC-Unique: xbSUPsi3Oredz9bLZYe1Aw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fd0fa4d08cso13305795e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 00:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695366943; x=1695971743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ITur9HsGnQdv7PxUQgqM92n/WKFJaNzWDU84tP1oY8E=;
 b=rkBlq9r/ujj+20vARyCcQ1tlsNCCWlSiyxLdemD315Ar0Kxg5vXy9a9m9VQsgpONjK
 VEogVs7Ot7O1R/zHVL9Vt2PL4d72LpwpWyyTAKrRKW//tUzUGfFmYRCj8vzCMuS8qXlL
 uzdR8MoAE4my9qOHdNwjg/hpXlHRANwNlQXeggopZTzvcG7HwsspI9GRnICPg0Thxala
 Fh6N2/hVydR3qKGxJx4wbzHlYtxOMjws+OEmJFXw8zBsfQoHgIe/1a5Alb8nCqsC84sf
 LaJvPUELuH41XPEb4qbumHU98C5HmPQicDmtd5BQI/kM80Ox80iKXvY0zfHr143dOoXP
 oplw==
X-Gm-Message-State: AOJu0YxSDXC30SU2QD+P1CsDEcNP2oazyyk+iUD7CbrcbWdI/trfastx
 yhf1gUAKBu0uyuovLOvhGYF7yyXrsy7T+LSJbBWbhJiqTslKMzobJgJsE1sfKzPHW7f4Ubkh89u
 OxdHmuXL15mYi0zc=
X-Received: by 2002:a7b:c5ca:0:b0:404:fc52:a3c6 with SMTP id
 n10-20020a7bc5ca000000b00404fc52a3c6mr7332481wmk.25.1695366942993; 
 Fri, 22 Sep 2023 00:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb66lwizFbcN+kzvu4xtC2ON45foGeiK0IOzlZaUgKpFNFpFwrlyULPn0l2cEehLkyn0sc1g==
X-Received: by 2002:a7b:c5ca:0:b0:404:fc52:a3c6 with SMTP id
 n10-20020a7bc5ca000000b00404fc52a3c6mr7332456wmk.25.1695366942590; 
 Fri, 22 Sep 2023 00:15:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ay2-20020a05600c1e0200b003feea62440bsm307831wmb.43.2023.09.22.00.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 00:15:41 -0700 (PDT)
Message-ID: <9c13451c-6e6d-a405-1c3c-a67bb7c6caf3@redhat.com>
Date: Fri, 22 Sep 2023 09:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 16/22] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-17-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230830103754.36461-17-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 8/30/23 12:37, Zhenzhong Duan wrote:
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
>   MAINTAINERS              |   7 +
>   backends/Kconfig         |   4 +
>   backends/iommufd.c       | 291 +++++++++++++++++++++++++++++++++++++++
>   backends/meson.build     |   3 +
>   backends/trace-events    |  13 ++
>   include/sysemu/iommufd.h |  49 +++++++
>   qapi/qom.json            |  18 ++-
>   qemu-options.hx          |  13 ++
>   8 files changed, 397 insertions(+), 1 deletion(-)
>   create mode 100644 backends/iommufd.c
>   create mode 100644 include/sysemu/iommufd.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6111b6b4d9..04663fbb6f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2079,6 +2079,13 @@ F: hw/vfio/ap.c
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
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> new file mode 100644
> index 0000000000..07ea434424
> --- /dev/null
> +++ b/backends/iommufd.c
> @@ -0,0 +1,291 @@
> +/*
> + * iommufd container backend
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
> +static int iommufd_backend_alloc_ioas(int fd, uint32_t *ioas)
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
> +    *ioas = alloc_data.out_ioas_id;
> +    trace_iommufd_backend_alloc_ioas(fd, *ioas, ret);
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
> +void iommufd_backend_put_ioas(IOMMUFDBackend *be, uint32_t ioas)
> +{
> +    trace_iommufd_backend_put_ioas(be->fd, ioas);
> +    iommufd_backend_free_id(be->fd, ioas);
> +}
> +
> +int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas,
> +                              hwaddr iova, ram_addr_t size)
> +{
> +    int ret;
> +    struct iommu_ioas_unmap unmap = {
> +        .size = sizeof(unmap),
> +        .ioas_id = ioas,
> +        .iova = iova,
> +        .length = size,
> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_IOAS_UNMAP, &unmap);
> +    trace_iommufd_backend_unmap_dma(be->fd, ioas, iova, size, ret);
> +    if (ret && errno == ENOENT) {
> +        ret = 0;
> +    }
> +    if (ret) {
> +        error_report("IOMMU_IOAS_UNMAP failed: %s", strerror(errno));
> +    }
> +    return !ret ? 0 : -errno;
> +}
> +
> +int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas, hwaddr iova,
> +                            ram_addr_t size, void *vaddr, bool readonly)
> +{
> +    int ret;
> +    struct iommu_ioas_map map = {
> +        .size = sizeof(map),
> +        .flags = IOMMU_IOAS_MAP_READABLE |
> +                 IOMMU_IOAS_MAP_FIXED_IOVA,
> +        .ioas_id = ioas,
> +        .__reserved = 0,
> +        .user_va = (int64_t)vaddr,

This needs an extra cast (uintptr_t)

Thanks,

C.

> +        .iova = iova,
> +        .length = size,
> +    };
> +
> +    if (!readonly) {
> +        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
> +    }
> +
> +    ret = ioctl(be->fd, IOMMU_IOAS_MAP, &map);
> +    trace_iommufd_backend_map_dma(be->fd, ioas, iova, size,
> +                                  vaddr, readonly, ret);
> +    if (ret) {
> +        error_report("IOMMU_IOAS_MAP failed: %s", strerror(errno));
> +    }
> +    return !ret ? 0 : -errno;
> +}
> +
> +int iommufd_backend_copy_dma(IOMMUFDBackend *be, uint32_t src_ioas,
> +                             uint32_t dst_ioas, hwaddr iova,
> +                             ram_addr_t size, bool readonly)
> +{
> +    int ret;
> +    struct iommu_ioas_copy copy = {
> +        .size = sizeof(copy),
> +        .flags = IOMMU_IOAS_MAP_READABLE |
> +                 IOMMU_IOAS_MAP_FIXED_IOVA,
> +        .dst_ioas_id = dst_ioas,
> +        .src_ioas_id = src_ioas,
> +        .length = size,
> +        .dst_iova = iova,
> +        .src_iova = iova,
> +    };
> +
> +    if (!readonly) {
> +        copy.flags |= IOMMU_IOAS_MAP_WRITEABLE;
> +    }
> +
> +    ret = ioctl(be->fd, IOMMU_IOAS_COPY, &copy);
> +    trace_iommufd_backend_copy_dma(be->fd, src_ioas, dst_ioas,
> +                                   iova, size, readonly, ret);
> +    if (ret) {
> +        error_report("IOMMU_IOAS_COPY failed: %s", strerror(errno));
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
> +    trace_iommufd_backend_alloc_hwpt(iommufd, dev_id, pt_id, ret);
> +
> +    if (ret) {
> +        error_report("IOMMU_HWPT_ALLOC failed: %s", strerror(errno));
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
> diff --git a/backends/meson.build b/backends/meson.build
> index 914c7c4afb..29dc147c8e 100644
> --- a/backends/meson.build
> +++ b/backends/meson.build
> @@ -20,6 +20,9 @@ if have_vhost_user
>     system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('vhost-user.c'))
>   endif
>   system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
> +if have_iommufd
> +  system_ss.add(files('iommufd.c'))
> +endif
>   if have_vhost_user_crypto
>     system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
>   endif
> diff --git a/backends/trace-events b/backends/trace-events
> index 652eb76a57..093e3eb1da 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -5,3 +5,16 @@ dbus_vmstate_pre_save(void)
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
> +iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
> +iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
> +iommufd_backend_copy_dma(int iommufd, uint32_t src_ioas, uint32_t dst_ioas, uint64_t iova, uint64_t size, bool readonly, int ret) " iommufd=%d src_ioas=%d dst_ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" readonly=%d (%d)"
> +iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
> +iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u (%d)"
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> new file mode 100644
> index 0000000000..f3bd212170
> --- /dev/null
> +++ b/include/sysemu/iommufd.h
> @@ -0,0 +1,49 @@
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
> +int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas,
> +                              hwaddr iova, ram_addr_t size);
> +int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas, hwaddr iova,
> +                            ram_addr_t size, void *vaddr, bool readonly);
> +int iommufd_backend_copy_dma(IOMMUFDBackend *be, uint32_t src_ioas,
> +                             uint32_t dst_ioas, hwaddr iova,
> +                             ram_addr_t size, bool readonly);
> +int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
> +                               uint32_t pt_id, uint32_t *out_hwpt);
> +#endif
> diff --git a/qapi/qom.json b/qapi/qom.json
> index fa3e88c8e6..2646ac4cca 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -779,6 +779,18 @@
>   { 'struct': 'VfioUserServerProperties',
>     'data': { 'socket': 'SocketAddress', 'device': 'str' } }
>   
> +##
> +# @IOMMUFDProperties:
> +#
> +# Properties for IOMMUFDbackend objects.
> +#
> +# fd: file descriptor name
> +#
> +# Since: 7.2
> +##
> +{ 'struct': 'IOMMUFDProperties',
> +        'data': { '*fd': 'str' } }
> +
>   ##
>   # @RngProperties:
>   #
> @@ -933,6 +945,8 @@
>       'qtest',
>       'rng-builtin',
>       'rng-egd',
> +    { 'name': 'iommufd',
> +      'if': 'CONFIG_IOMMUFD' },
>       { 'name': 'rng-random',
>         'if': 'CONFIG_POSIX' },
>       'secret',
> @@ -1014,7 +1028,9 @@
>         'tls-creds-x509':             'TlsCredsX509Properties',
>         'tls-cipher-suites':          'TlsCredsProperties',
>         'x-remote-object':            'RemoteObjectProperties',
> -      'x-vfio-user-server':         'VfioUserServerProperties'
> +      'x-vfio-user-server':         'VfioUserServerProperties',
> +      'iommufd':                    { 'type': 'IOMMUFDProperties',
> +                                      'if': 'CONFIG_IOMMUFD' }
>     } }
>   
>   ##
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 29b98c3d4c..827dd085ee 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5098,6 +5098,19 @@ SRST
>   
>           The ``share`` boolean option is on by default with memfd.
>   
> +#ifdef CONFIG_IOMMUFD
> +    ``-object iommufd,id=id[,fd=fd]``
> +        Creates an iommufd backend which allows control of DMA mapping
> +        through the /dev/iommu device.
> +
> +        The ``id`` parameter is a unique ID which frontends (such as
> +        vfio-pci of vdpa) will use to connect withe the iommufd backend.
> +
> +        The ``fd`` parameter is an optional pre-opened file descriptor
> +        resulting from /dev/iommu opening. Usually the iommufd is shared
> +        accross all subsystems, bringing the benefit of centralized
> +        reference counting.
> +#endif
>       ``-object rng-builtin,id=id``
>           Creates a random number generator backend which obtains entropy
>           from QEMU builtin functions. The ``id`` parameter is a unique ID



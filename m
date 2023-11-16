Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2907EDCF9
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 09:34:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Xo3-0002wO-1n; Thu, 16 Nov 2023 03:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3Xo1-0002wF-CV
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:32:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3Xnz-0005Xi-2M
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700123573;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GsglDrYu7d2JfrbJdpnwqUhAPBqiYdMt0e/QyNfVa8s=;
 b=RV69nZZDA5doG50+n7gprMqn7Bf+XNC+WsjDljEWkKK5ceGG2f766/IEVxzwUKhJlVh2nJ
 xhp4RpNthEFjykxDI1FEYU2Mb8WrCnw8Th6xOWa05teFiRxF3mHyszRKJaUoeIseFPrv1e
 wnxaM8hkgH4BctDEXw+agjOLWSfs39Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-ATbt_CuiOfCsUQKZ6i8odw-1; Thu, 16 Nov 2023 03:32:52 -0500
X-MC-Unique: ATbt_CuiOfCsUQKZ6i8odw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-670b675b2c5so6840916d6.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 00:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700123572; x=1700728372;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GsglDrYu7d2JfrbJdpnwqUhAPBqiYdMt0e/QyNfVa8s=;
 b=LfIfapwwkh4VpWelNa3AqMELD831ase6TXjpiGTm1qNARvPcEmbOtAl1/bl+zXP2GV
 O+mUXM5uDpdz0DCSjAUAN3wBelczSEND/gWBE6VG2dzYgZcPK7at0vt2ZD3PA6MvvVFS
 Gps3iCBsabwCcDg3YEZ7/JEWiey8+H6mPn7qy3NWiRDSrclQSCWNX+ACY0+3TJ6w1RLb
 2tUsKrV713aOmc2uOZMDDNzCazUp6fMgLifDlMJX6hoe3Carf01FBXekhkM3Fl4MDSsv
 BkBGNfku31EHDnUZxwYx8WmKx/JbYbA6SMPJEcNCz33CoQ+SFFh2ra2bz1wZDoi7qhVs
 KrCQ==
X-Gm-Message-State: AOJu0YznX3RITeJgFSihyz22ZpfDQ2su9+LV+LaiZBwasOwpJckw4tBR
 86MDMGCPS/6KOUh/ScU7uYQ0qUFT589CJ+SIQDhMhpfqVdjifoxo/ZCz7NZE/ArrjjWX11uHilS
 wuoVjCn/WTAgzA+k=
X-Received: by 2002:a05:6214:c8d:b0:66f:addc:9882 with SMTP id
 r13-20020a0562140c8d00b0066faddc9882mr9254460qvr.0.1700123571946; 
 Thu, 16 Nov 2023 00:32:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAvoo1Hjmt2Aq9E2ShI3f720zYP3pIAoS3OZKUY7Jve7UvCjsFGXq26NbPARyNtSIe64jCLQ==
X-Received: by 2002:a05:6214:c8d:b0:66f:addc:9882 with SMTP id
 r13-20020a0562140c8d00b0066faddc9882mr9254433qvr.0.1700123571638; 
 Thu, 16 Nov 2023 00:32:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a0cedd2000000b0065d0dcc28e3sm1197956qvr.73.2023.11.16.00.32.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 00:32:51 -0800 (PST)
Message-ID: <ac069b07-d732-44db-a707-3e5deebe29af@redhat.com>
Date: Thu, 16 Nov 2023 09:32:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
 <2599bd21-31fa-490e-aecd-0749c4abe657@redhat.com>
 <SJ0PR11MB674492FC92766292663D698792B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB674492FC92766292663D698792B0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhenzhong,

On 11/16/23 05:04, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, November 15, 2023 8:53 PM
>> Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
>>
>> Hi Zhenzhong,
>>
>> On 11/14/23 11:09, Zhenzhong Duan wrote:
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> Introduce an iommufd object which allows the interaction
>>> with the host /dev/iommu device.
>>>
>>> The /dev/iommu can have been already pre-opened outside of qemu,
>>> in which case the fd can be passed directly along with the
>>> iommufd object:
>>>
>>> This allows the iommufd object to be shared accross several
>>> subsystems (VFIO, VDPA, ...). For example, libvirt would open
>>> the /dev/iommu once.
>>>
>>> If no fd is passed along with the iommufd object, the /dev/iommu
>>> is opened by the qemu code.
>>>
>>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>> v6: remove redundant call, alloc_hwpt, get/put_ioas
>>>
>>>  MAINTAINERS              |   7 ++
>>>  qapi/qom.json            |  19 ++++
>>>  include/sysemu/iommufd.h |  44 ++++++++
>>>  backends/iommufd.c       | 228 +++++++++++++++++++++++++++++++++++++++
>>>  backends/Kconfig         |   4 +
>>>  backends/meson.build     |   1 +
>>>  backends/trace-events    |  10 ++
>>>  qemu-options.hx          |  12 +++
>>>  8 files changed, 325 insertions(+)
>>>  create mode 100644 include/sysemu/iommufd.h
>>>  create mode 100644 backends/iommufd.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ff1238bb98..a4891f7bda 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2166,6 +2166,13 @@ F: hw/vfio/ap.c
>>>  F: docs/system/s390x/vfio-ap.rst
>>>  L: qemu-s390x@nongnu.org
>>>
>>> +iommufd
>>> +M: Yi Liu <yi.l.liu@intel.com>
>>> +M: Eric Auger <eric.auger@redhat.com>
>> Zhenzhong, don't you want to be added here?
>>> +S: Supported
>>> +F: backends/iommufd.c
>>> +F: include/sysemu/iommufd.h
>>> +
>>>  vhost
>>>  M: Michael S. Tsirkin <mst@redhat.com>
>>>  S: Supported
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index c53ef978ff..1fd8555a75 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -794,6 +794,23 @@
>>>  { 'struct': 'VfioUserServerProperties',
>>>    'data': { 'socket': 'SocketAddress', 'device': 'str' } }
>>>
>>> +##
>>> +# @IOMMUFDProperties:
>>> +#
>>> +# Properties for iommufd objects.
>>> +#
>>> +# @fd: file descriptor name previously passed via 'getfd' command,
>> "previously passed via 'getfd' command", I wonder if this applies here or whether
>> it is copy/paste of
>> RemoteObjectProperties.fd doc?
> Maybe copied😊 I thinks this applies here because I use monitor_fd_param to get fd.
> Or I miss anything?
This is a bit cryptic to me and I don't really understand what it means.
It does not mean it is not correct but I am curious about explanations
if anybody has some ;-)
>
>>> +#     which represents a pre-opened /dev/iommu.  This allows the
>>> +#     iommufd object to be shared accross several subsystems
>>> +#     (VFIO, VDPA, ...), and the file descriptor to be shared
>>> +#     with other process, e.g. DPDK.  (default: QEMU opens
>>> +#     /dev/iommu by itself)
>>> +#
>>> +# Since: 8.2
>>> +##
>>> +{ 'struct': 'IOMMUFDProperties',
>>> +  'data': { '*fd': 'str' } }
>>> +
>>>  ##
>>>  # @RngProperties:
>>>  #
>>> @@ -934,6 +951,7 @@
>>>      'input-barrier',
>>>      { 'name': 'input-linux',
>>>        'if': 'CONFIG_LINUX' },
>>> +    'iommufd',
>>>      'iothread',
>>>      'main-loop',
>>>      { 'name': 'memory-backend-epc',
>>> @@ -1003,6 +1021,7 @@
>>>        'input-barrier':              'InputBarrierProperties',
>>>        'input-linux':                { 'type': 'InputLinuxProperties',
>>>                                        'if': 'CONFIG_LINUX' },
>>> +      'iommufd':                    'IOMMUFDProperties',
>>>        'iothread':                   'IothreadProperties',
>>>        'main-loop':                  'MainLoopProperties',
>>>        'memory-backend-epc':         { 'type': 'MemoryBackendEpcProperties',
>>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>>> new file mode 100644
>>> index 0000000000..9b3a86f57d
>>> --- /dev/null
>>> +++ b/include/sysemu/iommufd.h
>>> @@ -0,0 +1,44 @@
>>> +#ifndef SYSEMU_IOMMUFD_H
>>> +#define SYSEMU_IOMMUFD_H
>>> +
>>> +#include "qom/object.h"
>>> +#include "qemu/thread.h"
>>> +#include "exec/hwaddr.h"
>>> +#include "exec/cpu-common.h"
>>> +
>>> +#define TYPE_IOMMUFD_BACKEND "iommufd"
>>> +OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass,
>>> +                    IOMMUFD_BACKEND)
>>> +#define IOMMUFD_BACKEND(obj) \
>>> +    OBJECT_CHECK(IOMMUFDBackend, (obj), TYPE_IOMMUFD_BACKEND)
>>> +#define IOMMUFD_BACKEND_GET_CLASS(obj) \
>>> +    OBJECT_GET_CLASS(IOMMUFDBackendClass, (obj),
>> TYPE_IOMMUFD_BACKEND)
>>> +#define IOMMUFD_BACKEND_CLASS(klass) \
>>> +    OBJECT_CLASS_CHECK(IOMMUFDBackendClass, (klass),
>> TYPE_IOMMUFD_BACKEND)
>>> +struct IOMMUFDBackendClass {
>>> +    ObjectClass parent_class;
>>> +};
>>> +
>>> +struct IOMMUFDBackend {
>>> +    Object parent;
>>> +
>>> +    /*< protected >*/
>>> +    int fd;            /* /dev/iommu file descriptor */
>>> +    bool owned;        /* is the /dev/iommu opened internally */
>>> +    QemuMutex lock;
>>> +    uint32_t users;
>>> +
>>> +    /*< public >*/
>>> +};
>>> +
>>> +int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
>>> +void iommufd_backend_disconnect(IOMMUFDBackend *be);
>>> +
>>> +int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
>>> +                               Error **errp);
>>> +void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
>>> +int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> hwaddr iova,
>>> +                            ram_addr_t size, void *vaddr, bool readonly);
>>> +int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>> +                              hwaddr iova, ram_addr_t size);
>>> +#endif
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> new file mode 100644
>>> index 0000000000..ea3e2a8f85
>>> --- /dev/null
>>> +++ b/backends/iommufd.c
>>> @@ -0,0 +1,228 @@
>>> +/*
>>> + * iommufd container backend
>>> + *
>>> + * Copyright (C) 2023 Intel Corporation.
>>> + * Copyright Red Hat, Inc. 2023
>>> + *
>>> + * Authors: Yi Liu <yi.l.liu@intel.com>
>>> + *          Eric Auger <eric.auger@redhat.com>
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "sysemu/iommufd.h"
>>> +#include "qapi/error.h"
>>> +#include "qapi/qmp/qerror.h"
>>> +#include "qemu/module.h"
>>> +#include "qom/object_interfaces.h"
>>> +#include "qemu/error-report.h"
>>> +#include "monitor/monitor.h"
>>> +#include "trace.h"
>>> +#include <sys/ioctl.h>
>>> +#include <linux/iommufd.h>
>>> +
>>> +static void iommufd_backend_init(Object *obj)
>>> +{
>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>> +
>>> +    be->fd = -1;
>>> +    be->users = 0;
>>> +    be->owned = true;
>>> +    qemu_mutex_init(&be->lock);
>>> +}
>>> +
>>> +static void iommufd_backend_finalize(Object *obj)
>>> +{
>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>> +
>>> +    if (be->owned) {
>>> +        close(be->fd);
>>> +        be->fd = -1;
>>> +    }
>>> +}
>>> +
>>> +static void iommufd_backend_set_fd(Object *obj, const char *str, Error **errp)
>>> +{
>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>> +    int fd = -1;
>>> +
>>> +    fd = monitor_fd_param(monitor_cur(), str, errp);
>>> +    if (fd == -1) {
>>> +        error_prepend(errp, "Could not parse remote object fd %s:", str);
>>> +        return;
>>> +    }
>>> +    qemu_mutex_lock(&be->lock);
>>> +    be->fd = fd;
>>> +    be->owned = false;
>>> +    qemu_mutex_unlock(&be->lock);
>>> +    trace_iommu_backend_set_fd(be->fd);
>>> +}
>>> +
>>> +static void iommufd_backend_class_init(ObjectClass *oc, void *data)
>>> +{
>>> +    object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
>>> +}
>>> +
>>> +int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>>> +{
>>> +    int fd, ret = 0;
>>> +
>>> +    qemu_mutex_lock(&be->lock);
>>> +    if (be->users == UINT32_MAX) {
>>> +        error_setg(errp, "too many connections");
>>> +        ret = -E2BIG;
>>> +        goto out;
>>> +    }
>>> +    if (be->owned && !be->users) {
>>> +        fd = qemu_open_old("/dev/iommu", O_RDWR);
>>> +        if (fd < 0) {
>>> +            error_setg_errno(errp, errno, "/dev/iommu opening failed");
>>> +            ret = fd;
>>> +            goto out;
>>> +        }
>>> +        be->fd = fd;
>>> +    }
>>> +    be->users++;
>>> +out:
>>> +    trace_iommufd_backend_connect(be->fd, be->owned,
>>> +                                  be->users, ret);
>>> +    qemu_mutex_unlock(&be->lock);
>>> +    return ret;
>>> +}
>>> +
>>> +void iommufd_backend_disconnect(IOMMUFDBackend *be)
>>> +{
>>> +    qemu_mutex_lock(&be->lock);
>>> +    if (!be->users) {
>>> +        goto out;
>>> +    }
>>> +    be->users--;
>>> +    if (!be->users && be->owned) {
>>> +        close(be->fd);
>>> +        be->fd = -1;
>>> +    }
>>> +out:
>>> +    trace_iommufd_backend_disconnect(be->fd, be->users);
>>> +    qemu_mutex_unlock(&be->lock);
>>> +}
>>> +
>>> +int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
>>> +                               Error **errp)
>>> +{
>>> +    int ret, fd = be->fd;
>>> +    struct iommu_ioas_alloc alloc_data  = {
>>> +        .size = sizeof(alloc_data),
>>> +        .flags = 0,
>>> +    };
>>> +
>>> +    ret = ioctl(fd, IOMMU_IOAS_ALLOC, &alloc_data);
>>> +    if (ret) {
>>> +        error_setg_errno(errp, errno, "Failed to allocate ioas");
>>> +        return ret;
>>> +    }
>>> +
>>> +    *ioas_id = alloc_data.out_ioas_id;
>>> +    trace_iommufd_backend_alloc_ioas(fd, *ioas_id, ret);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id)
>>> +{
>>> +    int ret, fd = be->fd;
>>> +    struct iommu_destroy des = {
>>> +        .size = sizeof(des),
>>> +        .id = id,
>>> +    };
>>> +
>>> +    ret = ioctl(fd, IOMMU_DESTROY, &des);
>>> +    trace_iommufd_backend_free_id(fd, id, ret);
>>> +    if (ret) {
>>> +        error_report("Failed to free id: %u %m", id);
>>> +    }
>>> +}
>>> +
>>> +int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> hwaddr iova,
>>> +                            ram_addr_t size, void *vaddr, bool readonly)
>>> +{
>>> +    int ret, fd = be->fd;
>>> +    struct iommu_ioas_map map = {
>>> +        .size = sizeof(map),
>>> +        .flags = IOMMU_IOAS_MAP_READABLE |
>>> +                 IOMMU_IOAS_MAP_FIXED_IOVA,
>>> +        .ioas_id = ioas_id,
>>> +        .__reserved = 0,
>>> +        .user_va = (uintptr_t)vaddr,
>>> +        .iova = iova,
>>> +        .length = size,
>>> +    };
>>> +
>>> +    if (!readonly) {
>>> +        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
>>> +    }
>>> +
>>> +    ret = ioctl(fd, IOMMU_IOAS_MAP, &map);
>>> +    trace_iommufd_backend_map_dma(fd, ioas_id, iova, size,
>>> +                                  vaddr, readonly, ret);
>>> +    if (ret) {
>>> +        ret = -errno;
>>> +        error_report("IOMMU_IOAS_MAP failed: %m");
>>> +    }
>>> +    return ret;
>>> +}
>>> +
>>> +int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>> +                              hwaddr iova, ram_addr_t size)
>>> +{
>>> +    int ret, fd = be->fd;
>>> +    struct iommu_ioas_unmap unmap = {
>>> +        .size = sizeof(unmap),
>>> +        .ioas_id = ioas_id,
>>> +        .iova = iova,
>>> +        .length = size,
>>> +    };
>>> +
>>> +    ret = ioctl(fd, IOMMU_IOAS_UNMAP, &unmap);
>>> +    /*
>>> +     * IOMMUFD takes mapping as some kind of object, unmapping
>>> +     * nonexistent mapping is treated as deleting a nonexistent
>>> +     * object and return ENOENT. This is different from legacy
>>> +     * backend which allows it. vIOMMU may trigger a lot of
>>> +     * redundant unmapping, to avoid flush the log, treat them
>>> +     * as succeess for IOMMUFD just like legacy backend.
>>> +     */
>>> +    if (ret && errno == ENOENT) {
>>> +        trace_iommufd_backend_unmap_dma_non_exist(fd, ioas_id, iova, size,
>> ret);
>>> +        ret = 0;
>>> +    } else {
>>> +        trace_iommufd_backend_unmap_dma(fd, ioas_id, iova, size, ret);
>>> +    }
>>> +
>>> +    if (ret) {
>>> +        ret = -errno;
>>> +        error_report("IOMMU_IOAS_UNMAP failed: %m");
>>> +    }
>>> +    return ret;
>>> +}
>>> +
>>> +static const TypeInfo iommufd_backend_info = {
>>> +    .name = TYPE_IOMMUFD_BACKEND,
>>> +    .parent = TYPE_OBJECT,
>>> +    .instance_size = sizeof(IOMMUFDBackend),
>>> +    .instance_init = iommufd_backend_init,
>>> +    .instance_finalize = iommufd_backend_finalize,
>>> +    .class_size = sizeof(IOMMUFDBackendClass),
>>> +    .class_init = iommufd_backend_class_init,
>>> +    .interfaces = (InterfaceInfo[]) {
>>> +        { TYPE_USER_CREATABLE },
>>> +        { }
>>> +    }
>>> +};
>>> +
>>> +static void register_types(void)
>>> +{
>>> +    type_register_static(&iommufd_backend_info);
>>> +}
>>> +
>>> +type_init(register_types);
>>> diff --git a/backends/Kconfig b/backends/Kconfig
>>> index f35abc1609..2cb23f62fa 100644
>>> --- a/backends/Kconfig
>>> +++ b/backends/Kconfig
>>> @@ -1 +1,5 @@
>>>  source tpm/Kconfig
>>> +
>>> +config IOMMUFD
>>> +    bool
>>> +    depends on VFIO
>> I don't know the state of vDPA/iommufd integration but this extra might
>> be added in short term.
> Thanks for reminder. But I think it make more sense that series relax the check
> itself?
> E.g. depends on VFIO || VHOST_VDPA
yeah we can leave it as it is for now

Eric
>
> Thanks
> Zhenzhong



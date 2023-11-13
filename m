Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD387E9AA2
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:05:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Ukc-0004lY-Hh; Mon, 13 Nov 2023 06:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2Uka-0004kM-8n
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:05:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2UkX-0000k3-KR
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699873499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2ljsNGUDPrymHlhfH2vO5HKxzupUltjTSViJagypBg=;
 b=WRGU152MdV59omiwZkni091jvRNWV+P/KXexC7OZJwDyJXrCdtr+qgGBwWBhPV529d3kaw
 tvZLnym85OwiC+y53nBXOkmtWohjfaENViEiUSzC+3BwrADG1NZKDP2/JtjPIXSJ3/bH9I
 ZSr955BVDJMZx9MxYY/TvpJlLEN1eIQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-DQH_OgPYOs28P0SFomjL_A-1; Mon, 13 Nov 2023 06:04:56 -0500
X-MC-Unique: DQH_OgPYOs28P0SFomjL_A-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-da3b6438170so4504286276.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 03:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699873496; x=1700478296;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S2ljsNGUDPrymHlhfH2vO5HKxzupUltjTSViJagypBg=;
 b=nn+6eIPHZ4BQdWyB/k0N3JpKN/yjQXiUDxZoiWDCuV1afzMZjHS3Z4My7yZYCzvOk8
 oWQBO3p79YvKblkN+XOwUGi4pdRfDUJgDIqrLdky2vxUOrCuCQQe7cMC87RnRS50F5nR
 eH4jnvtgy2F6kkbBm2YEmkg8KWb7fHigTG5TiTTBa3aRX9GdvTVvdxtFFZgn/Z3ya0gp
 O9nvXFsf45ekDCNACA4jVDkpZSKk9rW2kgxfgOn1u/c8cHYFaz13JKsghCOmLXdrLdXi
 4gE6xF3iPzz07VL0PDa1oQ87PX5cIEV/9WeLsGDxlQO/x/0oKLiuKlksy4JHxhn4SlS0
 LaHg==
X-Gm-Message-State: AOJu0Yx5tlGqvVCcSprK2S1EgmOUuCf4ciTHkpI8HBrZkR9UrDIAvz7+
 vEVDCrsNIBmg5kb63L5waUdO/gXLQrHGIJXY/UjnqDx5SbStfDVIliw2+iekmUAsmBw0hZPVv8w
 Ob+1TcCPJBbi1+jQ=
X-Received: by 2002:a25:2684:0:b0:da0:c611:74f0 with SMTP id
 m126-20020a252684000000b00da0c61174f0mr3643548ybm.61.1699873496016; 
 Mon, 13 Nov 2023 03:04:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmvqc5Sj4rP5ZS9/s6WR6os+kPE3Gy28vug884qn+dRLUvAjVD0ObxfBx5dLPCYlvMFaYF4Q==
X-Received: by 2002:a25:2684:0:b0:da0:c611:74f0 with SMTP id
 m126-20020a252684000000b00da0c61174f0mr3643538ybm.61.1699873495681; 
 Mon, 13 Nov 2023 03:04:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 j18-20020a0ceb12000000b0065b14fcfca6sm1987265qvp.118.2023.11.13.03.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 03:04:55 -0800 (PST)
Message-ID: <0c380464-f5c3-483b-8114-cabf9667dfc7@redhat.com>
Date: Mon, 13 Nov 2023 12:04:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/20] vfio/iommufd: Implement the iommufd backend
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-4-zhenzhong.duan@intel.com>
 <befa083f-2e1b-4895-97cc-f00cfe5fc9a2@redhat.com>
 <SJ0PR11MB67443A3F92285FD074493FFA92AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67443A3F92285FD074493FFA92AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 11/10/23 11:18, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, November 10, 2023 5:34 PM
>> Subject: Re: [PATCH v5 03/20] vfio/iommufd: Implement the iommufd backend
>>
>> On 11/9/23 12:45, Zhenzhong Duan wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> Add the iommufd backend. The IOMMUFD container class is implemented
>>> based on the new /dev/iommu user API. This backend obviously depends
>>> on CONFIG_IOMMUFD.
>>>
>>> So far, the iommufd backend doesn't support dirty page sync yet due
>>> to missing support in the host kernel.
>>>
>>> Co-authored-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>> v5: Switch to IOAS attach/detach and hide hwpt
>>>
>>>    include/hw/vfio/vfio-common.h |  11 +
>>>    hw/vfio/common.c              |  20 +-
>>>    hw/vfio/iommufd.c             | 429 ++++++++++++++++++++++++++++++++++
>>>    hw/vfio/meson.build           |   3 +
>>>    hw/vfio/trace-events          |  10 +
>>>    5 files changed, 469 insertions(+), 4 deletions(-)
>>>    create mode 100644 hw/vfio/iommufd.c
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 24ecc0e7ee..3dac5c167e 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -89,6 +89,14 @@ typedef struct VFIOHostDMAWindow {
>>>        QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
>>>    } VFIOHostDMAWindow;
>>>
>>> +typedef struct IOMMUFDBackend IOMMUFDBackend;
>>> +
>>> +typedef struct VFIOIOMMUFDContainer {
>>> +    VFIOContainerBase bcontainer;
>>> +    IOMMUFDBackend *be;
>>> +    uint32_t ioas_id;
>>> +} VFIOIOMMUFDContainer;
>>> +
>>>    typedef struct VFIODeviceOps VFIODeviceOps;
>>>
>>>    typedef struct VFIODevice {
>>> @@ -116,6 +124,8 @@ typedef struct VFIODevice {
>>>        OnOffAuto pre_copy_dirty_page_tracking;
>>>        bool dirty_pages_supported;
>>>        bool dirty_tracking;
>>> +    int devid;
>>> +    IOMMUFDBackend *iommufd;
>>>    } VFIODevice;
>>>
>>>    struct VFIODeviceOps {
>>> @@ -201,6 +211,7 @@ typedef QLIST_HEAD(VFIODeviceList, VFIODevice)
>> VFIODeviceList;
>>>    extern VFIOGroupList vfio_group_list;
>>>    extern VFIODeviceList vfio_device_list;
>>>    extern const VFIOIOMMUOps vfio_legacy_ops;
>>> +extern const VFIOIOMMUOps vfio_iommufd_ops;
>>>    extern const MemoryListener vfio_memory_listener;
>>>    extern int vfio_kvm_device_fd;
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 572ae7c934..3b7e11158f 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -19,6 +19,7 @@
>>>     */
>>>
>>>    #include "qemu/osdep.h"
>>> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>>>    #include <sys/ioctl.h>
>>>    #ifdef CONFIG_KVM
>>>    #include <linux/kvm.h>
>>> @@ -1462,10 +1463,13 @@ VFIOAddressSpace
>> *vfio_get_address_space(AddressSpace *as)
>>>
>>>    void vfio_put_address_space(VFIOAddressSpace *space)
>>>    {
>>> -    if (QLIST_EMPTY(&space->containers)) {
>>> -        QLIST_REMOVE(space, list);
>>> -        g_free(space);
>>> +    if (!QLIST_EMPTY(&space->containers)) {
>>> +        return;
>>
>> I think this change deserves to be in a separate patch, even if simple.
>> Is there some relation with iommufd ? This is not clear.
> 
> OK, will do. It's unrelated to iommufd, just avoid unnecessary check below.
> 
>>
>>>        }
>>> +
>>> +    QLIST_REMOVE(space, list);
>>> +    g_free(space);
>>> +
>>>        if (QLIST_EMPTY(&vfio_address_spaces)) {
>>>            qemu_unregister_reset(vfio_reset_handler, NULL);
>>>        }
>>> @@ -1498,8 +1502,16 @@ retry:
>>>    int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>                           AddressSpace *as, Error **errp)
>>>    {
>>> -    const VFIOIOMMUOps *ops = &vfio_legacy_ops;
>>> +    const VFIOIOMMUOps *ops;
>>>
>>> +#ifdef CONFIG_IOMMUFD
>>> +    if (vbasedev->iommufd) {
>>> +        ops = &vfio_iommufd_ops;
>>> +    } else
>>> +#endif
>>> +    {
>>> +        ops = &vfio_legacy_ops;
>>> +    }
>>
>> Simply adding :
>>
>>   +#ifdef CONFIG_IOMMUFD
>>   +    if (vbasedev->iommufd) {
>>   +        ops = &vfio_iommufd_ops;
>>   +    }
>>   +#endif
>>
>> would have the same effect with less change.
> 
> Indeed, will do.
> 
>>
>> That said, it would also be nice to find a way to avoid the use of
>> CONFIG_IOMMUFD in hw/vfio/common.c. May be with a helper returning
>> 'const VFIOIOMMUOps *'. This is minor. Still, I find some redundancy
>> with vfio_container_init() and I don't a good alternative yet :)
> 
> Sure, will do, guess you mean a helper function in hw/vfio/helpers.c with
> CONFIG_IOMMUFD check?

Yes. That was the idea. I took a look and the benefits are minimal.
I am not sure it is worth the effort.

I also tried to minize the use of CONFIG_IOMMUFD in our various
VFIO devices with an intermediate QOM interface. See below.

+
+#define TYPE_IOMMUFD_INTERFACE "iommufd-interface"
+#define IOMMUFD_INTERFACE(obj) \
+     INTERFACE_CHECK(IOMMUFDInterface, (obj), TYPE_IOMMUFD_INTERFACE)
+typedef struct IOMMUFDInterfaceClass IOMMUFDInterfaceClass;
+DECLARE_CLASS_CHECKERS(IOMMUFDInterfaceClass, IOMMUFD_INTERFACE,
+                       TYPE_IOMMUFD_INTERFACE)
+
+typedef struct IOMMUFDInterface IOMMUFDInterface;
+
+struct IOMMUFDInterfaceClass {
+    InterfaceClass parent;
+    void (*set_fd)(Object *obj, const char *str, Error **errp);
+};
+
+#ifdef CONFIG_IOMMUFD
+static void iommufd_interface_set_fd(Object *obj, const char *str, Error **errp)
+{
+    IOMMUFDInterfaceClass *iik = IOMMUFD_INTERFACE_GET_CLASS(obj);
+
+    iik->set_fd(obj, str, errp);
+}
+#endif
+
+static void iommufd_interface_class_init(ObjectClass *klass, void *data)
+{
+#ifdef CONFIG_IOMMUFD
+    object_class_property_add_str(klass, "fd", NULL, iommufd_interface_set_fd);
+#endif
+}
+
+static void iommufd_interface_add_property(Object *obj, Object **iommufd)
+{
+#ifdef CONFIG_IOMMUFD
+    object_property_add_link(obj, "iommufd", TYPE_IOMMUFD_BACKEND, iommufd,
+                             NULL, OBJ_PROP_LINK_STRONG);
+#endif
+}
+
+static const TypeInfo iommufd_interface_info = {
+    .name = TYPE_IOMMUFD_INTERFACE,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(IOMMUFDInterfaceClass),
+    .class_init = iommufd_interface_class_init,
+};
  
  /*
   * Functions used whatever the injection method
@@ -649,21 +696,18 @@ static Property vfio_platform_dev_proper
  static void vfio_platform_instance_init(Object *obj)
  {
      VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(obj);
+    Object *iommufd = OBJECT(vdev->vbasedev.iommufd);
  
      vdev->vbasedev.fd = -1;
+    iommufd_interface_add_property(obj, &iommufd);
  }
  
  static void vfio_platform_class_init(ObjectClass *klass, void *data)
  {
      DeviceClass *dc = DEVICE_CLASS(klass);
      SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(klass);
+    IOMMUFDInterfaceClass *iik = IOMMUFD_INTERFACE_CLASS(klass);
  
      dc->realize = vfio_platform_realize;
      device_class_set_props(dc, vfio_platform_dev_properties);
      dc->vmsd = &vfio_platform_vmstate;
      dc->desc = "VFIO-based platform device assignment";
      sbc->connect_irq_notifier = vfio_start_irqfd_injection;
      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
      /* Supported by TYPE_VIRT_MACHINE */
      dc->user_creatable = true;
+    iik->set_fd = vfio_platform_set_fd;
  }
  
  static const TypeInfo vfio_platform_dev_info = {
@@ -703,11 +745,16 @@ static const TypeInfo vfio_platform_dev_
      .instance_init = vfio_platform_instance_init,
      .class_init = vfio_platform_class_init,
      .class_size = sizeof(VFIOPlatformDeviceClass),
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_IOMMUFD_INTERFACE },
+        { }
+    }
  };
  

Not really satisfying compared to the #ifdef. Let's keep them.



> 
>>
>>
>>>        return ops->attach_device(name, vbasedev, as, errp);
>>>    }
>>>
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> new file mode 100644
>>> index 0000000000..ea4e23f4ec
>>> --- /dev/null
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -0,0 +1,429 @@
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
>>> +#include <sys/ioctl.h>
>>> +#include <linux/vfio.h>
>>> +#include <linux/iommufd.h>
>>> +
>>> +#include "hw/vfio/vfio-common.h"
>>> +#include "qemu/error-report.h"
>>> +#include "trace.h"
>>> +#include "qapi/error.h"
>>> +#include "sysemu/iommufd.h"
>>> +#include "hw/qdev-core.h"
>>> +#include "sysemu/reset.h"
>>> +#include "qemu/cutils.h"
>>> +#include "qemu/chardev_open.h"
>>> +
>>> +static int iommufd_map(VFIOContainerBase *bcontainer, hwaddr iova,
>>> +                       ram_addr_t size, void *vaddr, bool readonly)
>>> +{
>>> +    VFIOIOMMUFDContainer *container =
>>> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>>> +
>>> +    return iommufd_backend_map_dma(container->be,
>>> +                                   container->ioas_id,
>>> +                                   iova, size, vaddr, readonly);
>>> +}
>>> +
>>> +static int iommufd_unmap(VFIOContainerBase *bcontainer,
>>> +                         hwaddr iova, ram_addr_t size,
>>> +                         IOMMUTLBEntry *iotlb)
>>> +{
>>> +    VFIOIOMMUFDContainer *container =
>>> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>>> +
>>> +    /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
>>> +    return iommufd_backend_unmap_dma(container->be,
>>> +                                     container->ioas_id, iova, size);
>>> +}
>>> +
>>> +static void iommufd_cdev_kvm_device_add(VFIODevice *vbasedev)
>>> +{
>>> +    Error *err = NULL;
>>> +
>>> +    if (vfio_kvm_device_add_fd(vbasedev->fd, &err)) {
>>> +        error_report_err(err);
>>
>> We should propagate this error to the callers instead.
> 
> This is to follow legacy backend where the error doesn't treated as
> a serious issue.
> 
>>
>>> +    }
>>> +}
>>> +
>>> +static void iommufd_cdev_kvm_device_del(VFIODevice *vbasedev)
>>> +{
>>> +    Error *err = NULL;
>>> +
>>> +    if (vfio_kvm_device_del_fd(vbasedev->fd, &err)) {
>>> +        error_report_err(err);
>>
>> Possibly this one also but It might be more complex. Let's keep it that
>> way.
>>
>>> +    }
>>> +}
>>> +
>>> +static int iommufd_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>>> +{
>>> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>>> +    struct vfio_device_bind_iommufd bind = {
>>> +        .argsz = sizeof(bind),
>>> +        .flags = 0,
>>> +    };
>>> +    int ret;
>>> +
>>> +    ret = iommufd_backend_connect(iommufd, errp);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    /*
>>> +     * Add device to kvm-vfio to be prepared for the tracking
>>> +     * in KVM. Especially for some emulated devices, it requires
>>> +     * to have kvm information in the device open.
>>> +     */
>>> +    iommufd_cdev_kvm_device_add(vbasedev);
>>
>> We shoud return a possible error.
> 
> This is to follow legacy backend where this error is reported and ignored.
> Do we need a difference for iommufd BE?

I don't know ! You tell me :) It is always better to raise the
exception and let the upper layers decide on the action to take.

> 
>>
>>> +
>>> +    /* Bind device to iommufd */
>>> +    bind.iommufd = iommufd->fd;
>>> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
>>> +    if (ret) {
>>> +        error_setg_errno(errp, errno, "error bind device fd=%d to iommufd=%d",
>>> +                         vbasedev->fd, bind.iommufd);
>>> +        goto err_bind;
>>> +    }
>>> +
>>> +    vbasedev->devid = bind.out_devid;
>>> +    trace_iommufd_connect_and_bind(bind.iommufd, vbasedev->name,
>> vbasedev->fd,
>>> +                                   vbasedev->devid);
>>> +    return ret;
>>> +err_bind:
>>> +    iommufd_cdev_kvm_device_del(vbasedev);
>>> +    iommufd_backend_disconnect(iommufd);
>>
>> These two calls look like iommufd_unbind_and_disconnect() below.
> 
> Yes, they are same as iommufd doesn't support explicit device unbind.
> But it looks strange to call iommufd_unbind_and_disconnect in
> iommufd_connect_and_bind.

This is just a little redudant. This is minor.


Thanks,

C.




>>
>>> +    return ret;
>>> +}
>>> +
>>> +static void iommufd_unbind_and_disconnect(VFIODevice *vbasedev)
>>> +{
>>> +    /* Unbind is automatically conducted when device fd is closed */
>>> +    iommufd_cdev_kvm_device_del(vbasedev);
>>> +    iommufd_backend_disconnect(vbasedev->iommufd);
>>> +}
>>> +
>>> +static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>>> +{
>>> +    long int ret = -ENOTTY;
>>> +    char *path, *vfio_dev_path = NULL, *vfio_path = NULL;
>>> +    DIR *dir = NULL;
>>> +    struct dirent *dent;
>>> +    gchar *contents;
>>> +    struct stat st;
>>> +    gsize length;
>>> +    int major, minor;
>>> +    dev_t vfio_devt;
>>> +
>>> +    path = g_strdup_printf("%s/vfio-dev", sysfs_path);
>>> +    if (stat(path, &st) < 0) {
>>> +        error_setg_errno(errp, errno, "no such host device");
>>> +        goto out_free_path;
>>> +    }
>>> +
>>> +    dir = opendir(path);
>>> +    if (!dir) {
>>> +        error_setg_errno(errp, errno, "couldn't open dirrectory %s", path);
>>
>>
>> directory
> 
> Good catch, will fix.
> 
> Thanks
> Zhenzhong
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3A17E9ACC
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:10:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UoD-0007s0-MY; Mon, 13 Nov 2023 06:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2Uo1-0007ka-5v
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:08:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2Unw-0001L2-VE
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699873712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCpOQz9psTGul/vBLFlg9TZtnx8MpCkekNKPu1yGts0=;
 b=JpM8wg8Zg3obE290v38eIO/+C18TQzgxbQ0yB/VV2kuQZFkzFlB1HUZz5EHYoB/PtfmwUj
 oALK0XAw4OCWGKmhhDho7dGEt3jvRONtQRWwr/vGz1H6XEuEfGeUZdhIS/pHZh951uaRah
 6RziSi3P/yayZsUHnMhMrMld8XtdgwQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-3Ka2yQ9rPuifyK6Z2h7Wtw-1; Mon, 13 Nov 2023 06:08:30 -0500
X-MC-Unique: 3Ka2yQ9rPuifyK6Z2h7Wtw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5a7bbe0a453so49437287b3.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 03:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699873710; x=1700478510;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aCpOQz9psTGul/vBLFlg9TZtnx8MpCkekNKPu1yGts0=;
 b=QFq2swG9plypcTniFmx0BzF4fV69BXnpeELHXcgagrphK4q9SiUM0rtobJihIfc2mA
 P5H86a0ffVyqKAXhmNMiglkVvjx6vVMs+ql5wpGy4d8i4Gvv99vP8CJMIN9d/XgLet7j
 NkvoaECdrLProLKw+R3DgElpB35hL42YtR7ct0savReQkQQLT2w2H6raLd7GINmfE0d9
 lZP3SO8Yi+UzLQOEwNAUbeREgFm1pgXBsiTVYtvotZD2AmiMRSjRlzDI2wH779tZJ7iF
 awjhsZgTLCfLxMUQpkJW7v3NzqRtjb051Zu1IlEEjPk4g5P2XxNn+dh+i3Cqf5dpuX9t
 UThw==
X-Gm-Message-State: AOJu0YyM3kjC/qtJ7/i3uLBB9F1eEfm5MLxA+ckCmgqOfdDSNNsd21Xq
 C7D2OErikbdYXPRA3g/4ULlslwPWl7ZJpLaNwgtWOerxFCVy6TxasQIdJRFDIAYLoDTct8uGN6Z
 7rEI2xtvLisUvqrA=
X-Received: by 2002:a81:5d0a:0:b0:5a7:be33:8bd4 with SMTP id
 r10-20020a815d0a000000b005a7be338bd4mr4125626ywb.2.1699873710283; 
 Mon, 13 Nov 2023 03:08:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHDoI+JpHR3ioydaIzxj/g8uoqpgnEP6c8Z6RydhWJ2Xopj63HRxi6UMHZiEV4wspBcNFWDQ==
X-Received: by 2002:a81:5d0a:0:b0:5a7:be33:8bd4 with SMTP id
 r10-20020a815d0a000000b005a7be338bd4mr4125604ywb.2.1699873709984; 
 Mon, 13 Nov 2023 03:08:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a0cfbc8000000b00677c71e52e2sm186169qvp.125.2023.11.13.03.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 03:08:29 -0800 (PST)
Message-ID: <896af239-b56f-424a-ba3a-f0d87888aa87@redhat.com>
Date: Mon, 13 Nov 2023 12:08:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/20] vfio/pci: Make vfio cdev pre-openable by passing
 a file handle
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
 <20231109114529.1904193-11-zhenzhong.duan@intel.com>
 <07539cb1-2262-4ae9-82ea-cfb7b9b8f2d5@redhat.com>
 <SJ0PR11MB67445F52268A9F988A84655B92B3A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67445F52268A9F988A84655B92B3A@SJ0PR11MB6744.namprd11.prod.outlook.com>
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

On 11/13/23 04:00, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, November 10, 2023 6:53 PM
>> Subject: Re: [PATCH v5 10/20] vfio/pci: Make vfio cdev pre-openable by passing a
>> file handle
>>
>> On 11/9/23 12:45, Zhenzhong Duan wrote:
>>> This gives management tools like libvirt a chance to open the vfio
>>> cdev with privilege and pass FD to qemu. This way qemu never needs
>>> to have privilege to open a VFIO or iommu cdev node.
>>>
>>> Together with the earlier support of pre-opening /dev/iommu device,
>>> now we have full support of passing a vfio device to unprivileged
>>> qemu by management tool. This mode is no more considered for the
>>> legacy backend. So let's remove the "TODO" comment.
>>>
>>> Add a helper function vfio_device_get_name() to check fd and get
>>> device name, it will also be used by other vfio devices.
>>>
>>> There is no easy way to check if a device is mdev with FD passing,
>>> so fail the x-balloon-allowed check unconditionally in this case.
>>>
>>> There is also no easy way to get BDF as name with FD passing, so
>>> we fake a name by VFIO_FD[fd].
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-common.h |  1 +
>>>    hw/vfio/helpers.c             | 34 +++++++++++++++++++++++++++++
>>>    hw/vfio/iommufd.c             | 12 +++++++----
>>>    hw/vfio/pci.c                 | 40 ++++++++++++++++++++++++-----------
>>>    4 files changed, 71 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 3dac5c167e..960a14e8d8 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -238,6 +238,7 @@ struct vfio_info_cap_header *
>>>    vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
>>>    struct vfio_info_cap_header *
>>>    vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
>>> +int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>    #endif
>>>
>>>    bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>>> index 168847e7c5..d80aa58719 100644
>>> --- a/hw/vfio/helpers.c
>>> +++ b/hw/vfio/helpers.c
>>> @@ -20,6 +20,7 @@
>>>     */
>>>
>>>    #include "qemu/osdep.h"
>>> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>>>    #include <sys/ioctl.h>
>>>
>>>    #include "hw/vfio/vfio-common.h"
>>> @@ -609,3 +610,36 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int
>> region, uint16_t cap_type)
>>>
>>>        return ret;
>>>    }
>>> +
>>> +int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>>> +{
>>> +    struct stat st;
>>> +
>>> +    if (vbasedev->fd < 0) {
>>> +        if (stat(vbasedev->sysfsdev, &st) < 0) {
>>> +            error_setg_errno(errp, errno, "no such host device");
>>> +            error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
>>> +            return -errno;
>>> +        }
>>> +        /* User may specify a name, e.g: VFIO platform device */
>>> +        if (!vbasedev->name) {
>>> +            vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
>>> +        }
>>> +    }
>>> +#ifdef CONFIG_IOMMUFD
>>> +    else {
>>> +        if (!vbasedev->iommufd) {
>>
>>
>> Can we handle with this case without CONFIG_IOMMUFD, simply by
>> testing vbasedev->iommufd ?
> 
> Sure, will do.
> 
>>
>>> +            error_setg(errp, "Use FD passing only with iommufd backend");
>>> +            return -EINVAL;
>>> +        }
>>> +        /*
>>> +         * Give a name with fd so any function printing out vbasedev->name
>>> +         * will not break.
>>> +         */
>>> +        if (!vbasedev->name) {
>>> +            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
>>> +        }
>>> +    }
>>> +#endif
>>> +    return 0;
>>> +}
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 44dc6848bf..fd30477275 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -326,11 +326,15 @@ static int iommufd_attach_device(const char *name,
>> VFIODevice *vbasedev,
>>>        uint32_t ioas_id;
>>>        Error *err = NULL;
>>>
>>> -    devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>>> -    if (devfd < 0) {
>>> -        return devfd;
>>> +    if (vbasedev->fd < 0) {
>>> +        devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>>> +        if (devfd < 0) {
>>> +            return devfd;
>>> +        }
>>> +        vbasedev->fd = devfd;
>>> +    } else {
>>> +        devfd = vbasedev->fd;
>>>        }
>>> -    vbasedev->fd = devfd;
>>>
>>>        ret = iommufd_connect_and_bind(vbasedev, errp);
>>>        if (ret) {
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index e9a426200b..f95725ed16 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -44,6 +44,7 @@
>>>    #include "migration/blocker.h"
>>>    #include "migration/qemu-file.h"
>>>    #include "sysemu/iommufd.h"
>>> +#include "monitor/monitor.h"
>>>
>>>    #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>>>
>>> @@ -2934,18 +2935,23 @@ static void vfio_realize(PCIDevice *pdev, Error
>> **errp)
>>>        VFIODevice *vbasedev = &vdev->vbasedev;
>>>        char *tmp, *subsys;
>>>        Error *err = NULL;
>>> -    struct stat st;
>>>        int i, ret;
>>>        bool is_mdev;
>>>        char uuid[UUID_STR_LEN];
>>>        char *name;
>>>
>>> -    if (!vbasedev->sysfsdev) {
>>> +    if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>>>            if (!(~vdev->host.domain || ~vdev->host.bus ||
>>>                  ~vdev->host.slot || ~vdev->host.function)) {
>>>                error_setg(errp, "No provided host device");
>>> +#ifdef CONFIG_IOMMUFD
>>> +            error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F, "
>>> +                              "-device vfio-pci,sysfsdev=PATH_TO_DEVICE "
>>> +                              "or -device vfio-pci,fd=DEVICE_FD\n");
>>> +#else
>>>                error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
>>>                                  "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
>>> +#endif
>>
>> or simply :
>>
>>
>>                 error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
>>   +#ifdef CONFIG_IOMMUFD
>>   +                              "or -device vfio-pci,fd=DEVICE_FD "
>>   +#endif
>>                                   "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
> 
> Good idea, will do.
> 
>>
>>
>>
>>>                return;
>>>            }
>>>            vbasedev->sysfsdev =
>>> @@ -2954,13 +2960,9 @@ static void vfio_realize(PCIDevice *pdev, Error
>> **errp)
>>>                                vdev->host.slot, vdev->host.function);
>>>        }
>>>
>>> -    if (stat(vbasedev->sysfsdev, &st) < 0) {
>>> -        error_setg_errno(errp, errno, "no such host device");
>>> -        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
>>> +    if (vfio_device_get_name(vbasedev, errp)) {
>>>            return;
>>>        }
>>> -
>>> -    vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
>>>        vbasedev->ops = &vfio_pci_ops;
>>>        vbasedev->type = VFIO_DEVICE_TYPE_PCI;
>>>        vbasedev->dev = DEVICE(vdev);
>>> @@ -3320,6 +3322,7 @@ static void vfio_instance_init(Object *obj)
>>>        vdev->host.bus = ~0U;
>>>        vdev->host.slot = ~0U;
>>>        vdev->host.function = ~0U;
>>> +    vdev->vbasedev.fd = -1;
>> We should probably move the all VFIODevice initializations :
>>
>>      vbasedev->ops = &vfio_pci_ops;
>>      vbasedev->type = VFIO_DEVICE_TYPE_PCI;
>>      vbasedev->dev = DEVICE(vdev);
>>
>> under vfio_instance_init (should be called vfio_pci_instance_init).
>>
>> This is true for all other VFIO devices. May be not for this series,
>> it can come later.
> 
> Sure, Let me send a separate series addressing this.
> 
>>
>>
>>>
>>>        vdev->nv_gpudirect_clique = 0xFF;
>>>
>>> @@ -3373,11 +3376,6 @@ static Property vfio_pci_dev_properties[] = {
>>>                                       qdev_prop_nv_gpudirect_clique, uint8_t),
>>>        DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice,
>> msix_relo,
>>>                                    OFF_AUTOPCIBAR_OFF),
>>> -    /*
>>> -     * TODO - support passed fds... is this necessary?
>>> -     * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
>>> -     * DEFINE_PROP_STRING("vfiogroupfd, VFIOPCIDevice, vfiogroupfd_name),
>>> -     */
>>>    #ifdef CONFIG_IOMMUFD
>>>        DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
>>>                         TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>>> @@ -3385,6 +3383,21 @@ static Property vfio_pci_dev_properties[] = {
>>>        DEFINE_PROP_END_OF_LIST(),
>>>    };
>>>
>>> +#ifdef CONFIG_IOMMUFD
>>> +static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>>> +{
>>> +    VFIOPCIDevice *vdev = VFIO_PCI(obj);
>>> +    int fd = -1;
>>> +
>>> +    fd = monitor_fd_param(monitor_cur(), str, errp);
>>> +    if (fd == -1) {
>>> +        error_prepend(errp, "Could not parse remote object fd %s:", str);
>>> +        return;
>>> +    }
>>> +    vdev->vbasedev.fd = fd;
>>
>> We could introduce a common helper in hw/vfio/common.c to remove code
>> duplication :
>>
>> #ifdef CONFIG_IOMMUFD
>> static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>> {
>>      vfio_device_set_fd(&VFIO_PCI(obj)->vbasedev, str, errp);
>> }
>> #endif
> 
> Good suggestions! Will do.


The idead is to isolate the iommufd addition in some common extension.
I tried with a QOM interface but it is not really satifying. See
previous email. I am not loosing faith though to find a solution for
this multi inheritance issue with VFIO devices


Thanks,

C.



> 
> Thanks
> Zhenzhong



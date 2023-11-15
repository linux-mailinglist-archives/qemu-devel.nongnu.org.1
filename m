Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF7C7EC33D
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 14:07:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3FaQ-0001fn-KY; Wed, 15 Nov 2023 08:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3FaL-0001fG-Dn
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:05:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3FaB-0002Ew-5Q
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700053525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6nUVXNTZOtA8tIQR8Qkj5PO41yD+G1382T9mafoqYg=;
 b=FWmHteb7BwLTPa8SsOzMziGUa03eDAiRJ5kWjX7hHCMobj8DMaoHHS3eHl6k2koOLjn2ev
 8Eulm8Qu7hYrOSKRWIbv0CHb4dWdvlidOksiBdou/RJQc5GOXqvlTWWdRe56pWolRpHuUv
 xQDMjCwaHyZM3LfXRS7tL/+vrrcgeBE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-tZUri8-3MAmx5NGPfc6bVQ-1; Wed, 15 Nov 2023 08:05:23 -0500
X-MC-Unique: tZUri8-3MAmx5NGPfc6bVQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6707401e1aeso78306176d6.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 05:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700053523; x=1700658323;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c6nUVXNTZOtA8tIQR8Qkj5PO41yD+G1382T9mafoqYg=;
 b=WY+P54DfFCzgixZhOuIbMiNKHGjM/zFMhP5/j9GUUCAStYXzH5cC1igLRQGiplvByr
 PFxfOsswYso6xvdSXEl+/dgyaXhrX94Ztwb4/tnmfzfKURDExm3FEgs7Hl0/px2Vj7Mb
 vEyK5CHULS1HH8Z2WZPmvM6tb374UlyAZlNhBoQFtiM7nS1OXjRGNqTzRxwcqWC/JpI4
 89xPY+QQWdU/J5lWHUJ80hTkNKol17U78Z9QDuQM2/tcAbHEbe4aEzjoB7QyDRLXoOGW
 WnSVacEwkrSkD8P8kOYb/wp7e6m3l35HH5MW2DnxYP4lIyO/B+sIK2awYm/KQpFyHYGM
 n5zQ==
X-Gm-Message-State: AOJu0Yzy1K2PiZ7XRbhKV/itE9EkQjQ0NY5vAFehI4PD9jeqHjLpKZNl
 1FBrpvGdVwMFPjGNhvBIt1BJPg3PfV54lMROl0B/ix96UCTHkXXR9xuv2orfLY8TpIhlnrIIrBv
 oBfn6moPuylvvUgk=
X-Received: by 2002:a05:6214:508f:b0:66f:baa4:77b0 with SMTP id
 kk15-20020a056214508f00b0066fbaa477b0mr6316467qvb.8.1700053523081; 
 Wed, 15 Nov 2023 05:05:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV1N/wp4USKU4dxnbPRqfjAoQdmGGXI78ksbrh8EUy/+SlN/XtA0KI3UUMX46zSOP722MMfQ==
X-Received: by 2002:a05:6214:508f:b0:66f:baa4:77b0 with SMTP id
 kk15-20020a056214508f00b0066fbaa477b0mr6316434qvb.8.1700053522767; 
 Wed, 15 Nov 2023 05:05:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 w14-20020a0cf70e000000b0066d1e71e515sm517036qvn.113.2023.11.15.05.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 05:05:22 -0800 (PST)
Message-ID: <de1bb7bf-64ee-4378-b757-eca7f547b674@redhat.com>
Date: Wed, 15 Nov 2023 14:05:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] vfio/pci: Make vfio cdev pre-openable by passing
 a file handle
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-12-zhenzhong.duan@intel.com>
 <b6c6f336-8f56-415a-b6a7-fce19dfd2241@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <b6c6f336-8f56-415a-b6a7-fce19dfd2241@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/15/23 13:09, Philippe Mathieu-Daudé wrote:
> Hi Zhenzhong,
> 
> On 14/11/23 11:09, Zhenzhong Duan wrote:
>> This gives management tools like libvirt a chance to open the vfio
>> cdev with privilege and pass FD to qemu. This way qemu never needs
>> to have privilege to open a VFIO or iommu cdev node.
>>
>> Together with the earlier support of pre-opening /dev/iommu device,
>> now we have full support of passing a vfio device to unprivileged
>> qemu by management tool. This mode is no more considered for the
>> legacy backend. So let's remove the "TODO" comment.
>>
>> Add helper functions vfio_device_set_fd() and vfio_device_get_name()
>> to set fd and get device name, they will also be used by other vfio
>> devices.
>>
>> There is no easy way to check if a device is mdev with FD passing,
>> so fail the x-balloon-allowed check unconditionally in this case.
>>
>> There is also no easy way to get BDF as name with FD passing, so
>> we fake a name by VFIO_FD[fd].
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>> v6: simplify CONFIG_IOMMUFD checking code
>>      introduce a helper vfio_device_set_fd
>>
>>   include/hw/vfio/vfio-common.h |  3 +++
>>   hw/vfio/helpers.c             | 44 +++++++++++++++++++++++++++++++++++
>>   hw/vfio/iommufd.c             | 12 ++++++----
>>   hw/vfio/pci.c                 | 28 ++++++++++++----------
>>   4 files changed, 71 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 3dac5c167e..567e5f7bea 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -251,4 +251,7 @@ int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
>>                                       hwaddr size);
>>   int vfio_get_dirty_bitmap(VFIOContainerBase *bcontainer, uint64_t iova,
>>                                    uint64_t size, ram_addr_t ram_addr);
>> +
> 
> Please add bare documentation:
> 
>    /* Returns 0 on success, or a negative errno. */
> 
>> +int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
> 
> Functions taking an Error** param should return a boolean, so:
> 
>    /* Return: true on success, else false setting @errp with error. */
> 
>> +void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>>   #endif /* HW_VFIO_VFIO_COMMON_H */
> 
> 
>> @@ -609,3 +611,45 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
>>       return ret;
>>   }
>> +
>> +int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    struct stat st;
>> +
>> +    if (vbasedev->fd < 0) {
>> +        if (stat(vbasedev->sysfsdev, &st) < 0) {
>> +            error_setg_errno(errp, errno, "no such host device");
>> +            error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
>> +            return -errno;
>> +        }
>> +        /* User may specify a name, e.g: VFIO platform device */
>> +        if (!vbasedev->name) {
>> +            vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
>> +        }
>> +    } else {
>> +        if (!vbasedev->iommufd) {
>> +            error_setg(errp, "Use FD passing only with iommufd backend");
>> +            return -EINVAL;
>> +        }
>> +        /*
>> +         * Give a name with fd so any function printing out vbasedev->name
>> +         * will not break.
>> +         */
>> +        if (!vbasedev->name) {
>> +            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
> 
>     bool vfio_device_set_fd(..., Error **errp)
> 
>> +{
>> +    int fd = monitor_fd_param(monitor_cur(), str, errp);
>> +
>> +    if (fd < 0) {
>> +        error_prepend(errp, "Could not parse remote object fd %s:", str);
>> +        return;
> 
>             return false;
> 
>> +    }
>> +    vbasedev->fd = fd;
> 
>         return true;

If we had a QOM base device object, vfio_device_set_fd() would be passed
directly to object_class_property_add_str() which expects a :

   void (*set)(Object *, const char *, Error **)

I think it is fine to keep as it is. We might have a QOM base device object
one day ! Minor anyway.

Thanks,

C.


> 
>> +}
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 3eec428162..e08a217057 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -326,11 +326,15 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>       uint32_t ioas_id;
>>       Error *err = NULL;
>> -    devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>> -    if (devfd < 0) {
>> -        return devfd;
>> +    if (vbasedev->fd < 0) {
>> +        devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>> +        if (devfd < 0) {
>> +            return devfd;
>> +        }
>> +        vbasedev->fd = devfd;
>> +    } else {
>> +        devfd = vbasedev->fd;
>>       }
>> -    vbasedev->fd = devfd;
>>       ret = iommufd_cdev_connect_and_bind(vbasedev, errp);
>>       if (ret) {
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index c5984b0598..b23b492cce 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2944,17 +2944,19 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>       VFIODevice *vbasedev = &vdev->vbasedev;
>>       char *tmp, *subsys;
>>       Error *err = NULL;
>> -    struct stat st;
>>       int i, ret;
>>       bool is_mdev;
>>       char uuid[UUID_STR_LEN];
>>       char *name;
>> -    if (!vbasedev->sysfsdev) {
>> +    if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>>           if (!(~vdev->host.domain || ~vdev->host.bus ||
>>                 ~vdev->host.slot || ~vdev->host.function)) {
>>               error_setg(errp, "No provided host device");
>>               error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
>> +#ifdef CONFIG_IOMMUFD
>> +                              "or -device vfio-pci,fd=DEVICE_FD "
>> +#endif
>>                                 "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
>>               return;
>>           }
>> @@ -2964,13 +2966,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>                               vdev->host.slot, vdev->host.function);
>>       }
>> -    if (stat(vbasedev->sysfsdev, &st) < 0) {
>> -        error_setg_errno(errp, errno, "no such host device");
>> -        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
>> +    if (vfio_device_get_name(vbasedev, errp)) {
> 
> Clearer as:
> 
>         if (vfio_device_get_name(vbasedev, errp) < 0) {
> 
>>           return;
>>       }
> 
> Regards,
> 
> Phil.
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 367097B5463
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 15:58:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnJQM-0006qo-65; Mon, 02 Oct 2023 09:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qnJQE-0006mb-RC
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 09:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qnJQC-0001VI-2V
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 09:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696255034;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lm/Lk6bCNUlDQUPwHbkUj6VmkbwkbtBlptI5GoTzUwM=;
 b=MoSEE2dXAmk7YpLoYkej+k8elUpWovmswIOt5DUvvr3z4/jwEme6jq0/qqpjqByppKTaM3
 mU05tEaRbGUEMyk6G7k8Z8idRg6BQpv0q6dmQceTEEG/6Tc+5Pxqa85PUWN0JKQSV2VP9m
 hnOy97YcI7yI8SBbc1GyElHsX5Z/0s4=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-Wib1R9W_PCKMXfk7IZDrjw-1; Mon, 02 Oct 2023 09:57:13 -0400
X-MC-Unique: Wib1R9W_PCKMXfk7IZDrjw-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7ab00f0d672so8482934241.3
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 06:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696255032; x=1696859832;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lm/Lk6bCNUlDQUPwHbkUj6VmkbwkbtBlptI5GoTzUwM=;
 b=b8S7Y4toxLOqvC1X6ae164EHF2wOg256rdCA2mzgBSsNjVW5au1i3t+KOBN8wMFCsD
 ogvC//J1Oyxy38zWEAdSoLBf2GlLxkswJaKcZEqAlImk3gFH7AXw9BwwZxh5YRsGXTEg
 ZoUYbZqyF1kZ83XbDmHCX846GbC24xNix05P2l/tDOCfe7991Zb5nBSyDdUMDHvCmmn/
 7ixFJIO1295GiJkTxGL3r1A3NyLhkAES0rsv2wFMIZ+ktNZ3BCCQWAz658+RJhnNd9+u
 6Oe/gOjMjfcdxby+5mrMnF2xMHtRTuIaZvgF4qjRtiPl92PaEJlufr0Ds0sbEcWyPa8K
 NeEg==
X-Gm-Message-State: AOJu0YwV6A2IivYvNNIKG3lkUSABLWHURbO3cbNCYXVZye9R69wD/Smz
 +EEhhxGMTDmuLMu3nsfpRiIFONogfrOyfXYNHXHkX+v9V8TvXm+6GmsrzJMxzQMbLOYC0ZejeHs
 je4P+nn03YvScGjA=
X-Received: by 2002:a67:f70e:0:b0:451:64e:4645 with SMTP id
 m14-20020a67f70e000000b00451064e4645mr9979331vso.12.1696255032576; 
 Mon, 02 Oct 2023 06:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0HkFyiUVlR2yQAS3iCDYVGsLwMUUIaM4maQd9NceUsKGpMaTkzqfzZRiBzhqeOtTXdQ/obw==
X-Received: by 2002:a67:f70e:0:b0:451:64e:4645 with SMTP id
 m14-20020a67f70e000000b00451064e4645mr9979298vso.12.1696255032277; 
 Mon, 02 Oct 2023 06:57:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a0cf5c7000000b00656506a1881sm9732933qvm.74.2023.10.02.06.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 06:57:11 -0700 (PDT)
Message-ID: <6ee692cd-4d9f-78c5-6c69-c4144ed31cd9@redhat.com>
Date: Mon, 2 Oct 2023 15:57:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-7-zhenzhong.duan@intel.com>
 <b1012c96-e76e-10eb-2080-af7d8ff606ee@redhat.com>
 <PH7PR11MB6722E62822B43C65DE5187C492C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
 <b4118ef6-e44f-785c-c99d-c4d8224b88ed@redhat.com>
 <PH7PR11MB6722BC6A9DD797DB8BA9631E92C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <PH7PR11MB6722BC6A9DD797DB8BA9631E92C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhenzhong,

On 9/27/23 14:32, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, September 27, 2023 8:23 PM
>> Subject: Re: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
>>
>>
>>
>> On 9/27/23 12:07, Duan, Zhenzhong wrote:
>>> Hi Eric,
>>>
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Sent: Wednesday, September 27, 2023 5:02 PM
>>>> Subject: Re: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
>>>>
>>>> Hi Zhenzhong,
>>>>
>>>> On 9/26/23 13:32, Zhenzhong Duan wrote:
>>>>> From: Eric Auger <eric.auger@redhat.com>
>>>>>
>>>>> We want the VFIO devices to be able to use two different
>>>>> IOMMU backends, the legacy VFIO one and the new iommufd one.
>>>>>
>>>>> Introduce vfio_[attach/detach]_device which aim at hiding the
>>>>> underlying IOMMU backend (IOCTLs, datatypes, ...).
>>>>>
>>>>> Once vfio_attach_device completes, the device is attached
>>>>> to a security context and its fd can be used. Conversely
>>>>> When vfio_detach_device completes, the device has been
>>>>> detached from the security context.
>>>>>
>>>>> At the moment only the implementation based on the legacy
>>>>> container/group exists. Let's use it from the vfio-pci device.
>>>>> Subsequent patches will handle other devices.
>>>>>
>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> ---
>>>>>  include/hw/vfio/vfio-common.h |  3 ++
>>>>>  hw/vfio/common.c              | 68 +++++++++++++++++++++++++++++++++++
>>>>>  hw/vfio/pci.c                 | 50 +++-----------------------
>>>>>  hw/vfio/trace-events          |  2 +-
>>>>>  4 files changed, 77 insertions(+), 46 deletions(-)
>>>>>
>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>>>>> index c4e7c3b4a7..12fbfbc37d 100644
>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>> @@ -225,6 +225,9 @@ void vfio_put_group(VFIOGroup *group);
>>>>>  struct vfio_device_info *vfio_get_device_info(int fd);
>>>>>  int vfio_get_device(VFIOGroup *group, const char *name,
>>>>>                      VFIODevice *vbasedev, Error **errp);
>>>>> +int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>>> +                       AddressSpace *as, Error **errp);
>>>>> +void vfio_detach_device(VFIODevice *vbasedev);
>>>>>
>>>>>  int vfio_kvm_device_add_fd(int fd, Error **errp);
>>>>>  int vfio_kvm_device_del_fd(int fd, Error **errp);
>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>>> index 959b1362bb..7f3798b152 100644
>>>>> --- a/hw/vfio/common.c
>>>>> +++ b/hw/vfio/common.c
>>>>> @@ -2611,3 +2611,71 @@ int vfio_eeh_as_op(AddressSpace *as, uint32_t
>> op)
>>>>>      }
>>>>>      return vfio_eeh_container_op(container, op);
>>>>>  }
>>>>> +
>>>>> +static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>>>>> +{
>>>>> +    char *tmp, group_path[PATH_MAX], *group_name;
>>>>> +    int ret, groupid;
>>>>> +    ssize_t len;
>>>>> +
>>>>> +    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
>>>>> +    len = readlink(tmp, group_path, sizeof(group_path));
>>>>> +    g_free(tmp);
>>>>> +
>>>>> +    if (len <= 0 || len >= sizeof(group_path)) {
>>>>> +        ret = len < 0 ? -errno : -ENAMETOOLONG;
>>>>> +        error_setg_errno(errp, -ret, "no iommu_group found");
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    group_path[len] = 0;
>>>>> +
>>>>> +    group_name = basename(group_path);
>>>>> +    if (sscanf(group_name, "%d", &groupid) != 1) {
>>>>> +        error_setg_errno(errp, errno, "failed to read %s", group_path);
>>>>> +        return -errno;
>>>>> +    }
>>>>> +    return groupid;
>>>>> +}
>>>>> +
>>>>> +int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>>> +                       AddressSpace *as, Error **errp)
>>>>> +{
>>>>> +    int groupid = vfio_device_groupid(vbasedev, errp);
>>>>> +    VFIODevice *vbasedev_iter;
>>>>> +    VFIOGroup *group;
>>>>> +    int ret;
>>>>> +
>>>>> +    if (groupid < 0) {
>>>>> +        return groupid;
>>>>> +    }
>>>>> +
>>>>> +    trace_vfio_attach_device(vbasedev->name, groupid);
>>>>> +
>>>>> +    group = vfio_get_group(groupid, as, errp);
>>>>> +    if (!group) {
>>>>> +        return -ENOENT;
>>>>> +    }
>>>>> +
>>>>> +    QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>>>>> +        if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
>>>>> +            error_setg(errp, "device is already attached");
>>>>> +            vfio_put_group(group);
>>>>> +            return -EBUSY;
>>>>> +        }
>>>>> +    }
>>>>> +    ret = vfio_get_device(group, name, vbasedev, errp);
>>>>> +    if (ret) {
>>>>> +        vfio_put_group(group);
>>>>> +    }
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +void vfio_detach_device(VFIODevice *vbasedev)
>>>>> +{
>>>>> +    VFIOGroup *group = vbasedev->group;
>>>>> +
>>>>> +    vfio_put_base_device(vbasedev);
>>>>> +    vfio_put_group(group);
>>>>> +}
>>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>>> index 3b2ca3c24c..fe56789893 100644
>>>>> --- a/hw/vfio/pci.c
>>>>> +++ b/hw/vfio/pci.c
>>>>> @@ -2828,10 +2828,10 @@ static void vfio_populate_device(VFIOPCIDevice
>>>> *vdev, Error **errp)
>>>>>  static void vfio_put_device(VFIOPCIDevice *vdev)
>>>>>  {
>>>>> +    vfio_detach_device(&vdev->vbasedev);
>>>>> +
>>>>>      g_free(vdev->vbasedev.name);
>>>>>      g_free(vdev->msix);
>>>>> -
>>>>> -    vfio_put_base_device(&vdev->vbasedev);
>>>>>  }
>>>>>
>>>>>  static void vfio_err_notifier_handler(void *opaque)
>>>>> @@ -2978,13 +2978,9 @@ static void vfio_realize(PCIDevice *pdev, Error
>>>> **errp)
>>>>>  {
>>>>>      VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>>>>>      VFIODevice *vbasedev = &vdev->vbasedev;
>>>>> -    VFIODevice *vbasedev_iter;
>>>>> -    VFIOGroup *group;
>>>>> -    char *tmp, *subsys, group_path[PATH_MAX], *group_name;
>>>>> +    char *tmp, *subsys;
>>>>>      Error *err = NULL;
>>>>> -    ssize_t len;
>>>>>      struct stat st;
>>>>> -    int groupid;
>>>>>      int i, ret;
>>>>>      bool is_mdev;
>>>>>      char uuid[UUID_FMT_LEN];
>>>>> @@ -3015,39 +3011,6 @@ static void vfio_realize(PCIDevice *pdev, Error
>>>> **errp)
>>>>>      vbasedev->type = VFIO_DEVICE_TYPE_PCI;
>>>>>      vbasedev->dev = DEVICE(vdev);
>>>>>
>>>>> -    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
>>>>> -    len = readlink(tmp, group_path, sizeof(group_path));
>>>>> -    g_free(tmp);
>>>>> -
>>>>> -    if (len <= 0 || len >= sizeof(group_path)) {
>>>>> -        error_setg_errno(errp, len < 0 ? errno : ENAMETOOLONG,
>>>>> -                         "no iommu_group found");
>>>>> -        goto error;
>>>>> -    }
>>>>> -
>>>>> -    group_path[len] = 0;
>>>>> -
>>>>> -    group_name = basename(group_path);
>>>>> -    if (sscanf(group_name, "%d", &groupid) != 1) {
>>>>> -        error_setg_errno(errp, errno, "failed to read %s", group_path);
>>>>> -        goto error;
>>>>> -    }
>>>>> -
>>>>> -    trace_vfio_realize(vbasedev->name, groupid);
>>>>> -
>>>>> -    group = vfio_get_group(groupid, pci_device_iommu_address_space(pdev),
>>>> errp);
>>>>> -    if (!group) {
>>>>> -        goto error;
>>>>> -    }
>>>>> -
>>>>> -    QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>>>>> -        if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
>>>>> -            error_setg(errp, "device is already attached");
>>>>> -            vfio_put_group(group);
>>>>> -            goto error;
>>>>> -        }
>>>>> -    }
>>>>> -
>>>>>      /*
>>>>>       * Mediated devices *might* operate compatibly with discarding of RAM,
>> but
>>>>>       * we cannot know for certain, it depends on whether the mdev vendor
>>>> driver
>>>>> @@ -3065,7 +3028,6 @@ static void vfio_realize(PCIDevice *pdev, Error
>> **errp)
>>>>>      if (vbasedev->ram_block_discard_allowed && !is_mdev) {
>>>>>          error_setg(errp, "x-balloon-allowed only potentially compatible "
>>>>>                     "with mdev devices");
>>>>> -        vfio_put_group(group);
>>>>>          goto error;
>>>>>      }
>>>>>
>>>>> @@ -3076,10 +3038,10 @@ static void vfio_realize(PCIDevice *pdev, Error
>>>> **errp)
>>>>>          name = g_strdup(vbasedev->name);
>>>>>      }
>>>>>
>>>>> -    ret = vfio_get_device(group, name, vbasedev, errp);
>>>>> +    ret = vfio_attach_device(name, vbasedev,
>>>>> +                             pci_device_iommu_address_space(pdev), errp);
>>>>>      g_free(name);
>>>>>      if (ret) {
>>>>> -        vfio_put_group(group);
>>>> independently on this patch, I think in case of error we leak
>>>> vbasedev->name. Please have a look and if confirmed you can send a
>>>> separate patch.
>>> In case of error, vbasedev->name is freed in vfio_put_device().
>> called in vfio_instance_finalize only. See comment below
>>>> Also I think if any subsequent action fail we shoudl properly detach the
>>>> detach the device so introduce an extra error goto label, my bad sorry.
>>> vfio_detach_device is called in vfio_instance_finalize(), this is just to follow
>>> the old code, group and container resource allocated in vfio_realize() are
>>> freed in vfio_instance_finalize().
>>>
>>> I agree this is strange, but I guess there may be some reason I'm unclear.
>> Yeah but if vfio_realize does fail, I am not sure the
>> vfio_instance_finalize gets called
> If vfio_realize fails, fio_exitfn() will not be called but vfio_instance_finalize will.
> Note vfio_instance_finalize() is called by object_unref().

I think this holds if the object has been properly initialized. With gdb
I don't see

vfio_instance_finalize() gets called on vfio_realize() failure.

Thanks

Eric

>
> Thanks
> Zhenzhong
>



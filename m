Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DF5838EEB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 13:56:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSGIu-00014m-EA; Tue, 23 Jan 2024 07:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rSGIr-00014O-Tm
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 07:54:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rSGIp-0007Mc-Sz
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 07:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706014494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GNaVyaW7arppHjHCYe29G2hbVqfvceOWI8sOA5I7C/Y=;
 b=b57oLtP+waJ0cUBGbSFwG53ikPEyiT4c7Qu99ij6XRaoO8aQAlNFb496h/m8TbVi/ecPLL
 Y/i3Vf4vN8soQHIjhqiFcLHYHITAubs/u7avBPxKFiTlT+HQrkSxYz/H8Ro/vz/p+2o5jT
 tstdgZ2H6py5xh2VSukPogTKtcfdmdI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-UX39C3CPOZeenjJE6vwwxA-1; Tue, 23 Jan 2024 07:54:51 -0500
X-MC-Unique: UX39C3CPOZeenjJE6vwwxA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7830ab8fb5aso488254185a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 04:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706014490; x=1706619290;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GNaVyaW7arppHjHCYe29G2hbVqfvceOWI8sOA5I7C/Y=;
 b=XJpe0BiIq5EdzNASoT9AbZyXWgurXBUuEyATXTUTOuq5L0eWJfKXa/D3jv/lHIE6zq
 RRwQavbbPDQSKEL6o9Dg6StOjAJ2AEcnl+mj6ixGUgZrwJmrbJcB8xs+yDC0lf9n6MLq
 2xnFbF7r9zPfFyBDmRquSGu7CeOi4LcWjutY9jO+PHGjUG3PhngfrKM3hG9SR3lz+BKn
 7Kw5H0hPgWTOGZMRcncUd4Lm1VNAUZ9X01Yel39WhqmewV+M3hpxHjGAeVizsuktDQFE
 3R5IIanitdtjcZXMfJNC98suns6J4fJXi4dxBiXo3UwgGuyInDpDUSm12/xQjguOaOp+
 UoEg==
X-Gm-Message-State: AOJu0YzN85lnke/yOsL02zyfqm8+CUoVqvJJWiNqPsj86PeHboaL91px
 sSPKbHeZdCMdCpYdtfBzNr7NTCux8q5ZXM2j18O+TRi5FCXCijnIi4E7eAEUHzkkPYAtTOhKC8K
 OWmsmnd77njjvzi0bwx6DzODPz4u0dvyB3625CwlTpWj6VPNtad83
X-Received: by 2002:ac8:5945:0:b0:42a:8ba:a956 with SMTP id
 5-20020ac85945000000b0042a08baa956mr819321qtz.38.1706014490759; 
 Tue, 23 Jan 2024 04:54:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFK1TUEMzZw9tS2Qu/SXWb4+7VARAIc1O0rZ3vjnio1XffrFSEDxHrUbcXrpduIDiHdzoSbA==
X-Received: by 2002:ac8:5945:0:b0:42a:8ba:a956 with SMTP id
 5-20020ac85945000000b0042a08baa956mr819313qtz.38.1706014490477; 
 Tue, 23 Jan 2024 04:54:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 gd21-20020a05622a5c1500b00429cfdac07fsm3448868qtb.18.2024.01.23.04.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 04:54:50 -0800 (PST)
Message-ID: <ef9e0483-b984-457f-b317-bff89241a4de@redhat.com>
Date: Tue, 23 Jan 2024 13:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-5-zhenzhong.duan@intel.com>
 <852e8e08-1d82-49d4-a19c-36a6b256d662@redhat.com>
 <SJ0PR11MB67442926DAA9AD72F1B89CED92742@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67442926DAA9AD72F1B89CED92742@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
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

On 1/23/24 10:46, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
>> vIOMMU
>>
>> On 1/15/24 11:13, Zhenzhong Duan wrote:
>>> Initialize IOMMUFDDevice in vfio and pass to vIOMMU, so that vIOMMU
>>> could get hw IOMMU information.
>>>
>>> In VFIO legacy backend mode, we still pass a NULL IOMMUFDDevice to
>> vIOMMU,
>>> in case vIOMMU needs some processing for VFIO legacy backend mode.
>>>
>>> Originally-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-common.h |  2 ++
>>>    hw/vfio/iommufd.c             |  2 ++
>>>    hw/vfio/pci.c                 | 24 +++++++++++++++++++-----
>>>    3 files changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>>> index 9b7ef7d02b..fde0d0ca60 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -31,6 +31,7 @@
>>>    #endif
>>>    #include "sysemu/sysemu.h"
>>>    #include "hw/vfio/vfio-container-base.h"
>>> +#include "sysemu/iommufd_device.h"
>>>
>>>    #define VFIO_MSG_PREFIX "vfio %s: "
>>>
>>> @@ -126,6 +127,7 @@ typedef struct VFIODevice {
>>>        bool dirty_tracking;
>>>        int devid;
>>>        IOMMUFDBackend *iommufd;
>>> +    IOMMUFDDevice idev;
>>>    } VFIODevice;
>>>
>>>    struct VFIODeviceOps {
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 9bfddc1360..cbd035f148 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -309,6 +309,7 @@ static int iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>>        VFIOContainerBase *bcontainer;
>>>        VFIOIOMMUFDContainer *container;
>>>        VFIOAddressSpace *space;
>>> +    IOMMUFDDevice *idev = &vbasedev->idev;
>>>        struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
>>>        int ret, devfd;
>>>        uint32_t ioas_id;
>>> @@ -428,6 +429,7 @@ found_container:
>>>        QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev,
>> container_next);
>>>        QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>>>
>>> +    iommufd_device_init(idev, sizeof(*idev), container->be, vbasedev-
>>> devid);
>>>        trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev-
>>> num_irqs,
>>>                                       vbasedev->num_regions, vbasedev->flags);
>>>        return 0;
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index d7fe06715c..2c3a5d267b 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3107,11 +3107,21 @@ static void vfio_realize(PCIDevice *pdev,
>> Error **errp)
>>>
>>>        vfio_bars_register(vdev);
>>>
>>> -    ret = vfio_add_capabilities(vdev, errp);
>>> +    if (vbasedev->iommufd) {
>>> +        ret = pci_device_set_iommu_device(pdev, &vbasedev->idev, errp);
>>> +    } else {
>>> +        ret = pci_device_set_iommu_device(pdev, 0, errp);
>>
>>
>> AFAICT, pci_device_set_iommu_device() with a NULL IOMMUFDDevice will
>> do
>> nothing. Why call it ?
> 
> We will do something in nesting series, see https://github.com/yiliu1765/qemu/commit/7f0bb59575bb5cf38618ae950f68a8661676e881

ok, that's not much. idev is used as a capability bool and later on
to pass the /dev/iommu fd.  We don't need to support the legacy mode ?

> Another choice is to call pci_device_set_iommu_device() no matter which backend
> is used and check idev->iommufd in vtd_dev_set_iommu_device(). Is this better
> for you?

yes. Should be fine. There is more to it though.

IIUC, what will determine most of the requirements, is the legacy
mode. We also need the host iommu info in that case. As said Eric,
ideally, we should introduce a common abstract "host-iommu-info" struct
and sub structs associated with the iommu backends (iommufd + legacy)
which would be allocated accordingly.

So, IOMMUFDDevice usage should be limited to the iommufd files. All PCI
files should use the common abstract type. We should define these data
structures first. They could be simple C struct for now. We will see if
QOM applies after.

Will take a look at Eric's patchset next.

Thanks,

C.



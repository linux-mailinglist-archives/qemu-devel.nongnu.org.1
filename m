Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 192257D0A72
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 10:20:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtkjF-0003iM-Hp; Fri, 20 Oct 2023 04:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qtkjA-0003eo-0q
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qtkj7-0005Cj-P3
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697789963;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C75cNN9hf25tF4+pFF1Eo+TDs1Hc9jMPjQNo+o70r0s=;
 b=UujWXcKsBoWj5jxq8aDwuZpR5zUTi0SYxlNBo1ZHHz2X3ao9l84LLFWUxH+fOjUWs0QlYf
 aZ9kMUizQukHcxozrKB7o5GHD0oNwhtyQLbRbc2tNwlMYRx16xg6pdnTZWEfz/BQjF3HeY
 FkrrzgeSiXYvnFfXxn/E9I0yK/s5Vf0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-qnchKukaNdKJtzck-dXFog-1; Fri, 20 Oct 2023 04:19:11 -0400
X-MC-Unique: qnchKukaNdKJtzck-dXFog-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41cdce61dcbso874981cf.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 01:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697789947; x=1698394747;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C75cNN9hf25tF4+pFF1Eo+TDs1Hc9jMPjQNo+o70r0s=;
 b=ex2uaaMwroNA1cqDC67G7ShWsmaxp/UPC7z3VqQW71xWbwBs/BGuDKQZYAGY0L8pXF
 cwswR/ObZMc3t/efB4AWjXZrCLmYeHYaEbrNftNz92kejMndtHnpcW8ZhlZzYF3cMKPG
 KVR+D8ZWIFJz4OvMZDoh79fJTVasY6JY8+ZmTckvcSs03qy/xwL0E9Bc13vGaB107Fg/
 einJ/kBNymiuwNyEnmfdm/EP3HqlgeS9OA2V1TXHWgRhSNz+lKkn7jqvRNO7UVlnBSVB
 OO/hgZCJZfMWR2xIqk7Hoz7DOqeVrlWed5vgDRP9YHOtAhhwgP3iVxvE9478PbPJGzjj
 xUvQ==
X-Gm-Message-State: AOJu0YyFn7HFX+VqVe0A5SRQxw/PZo0zZv+lU7XLUv0ubY0xxGW5w6uC
 tY2su2AOoq59uKELsI1unE+U1ZlE97sqwDFOOD2RqN1CSMh32aTpArWGysYp1q0XpAAV2GpTLg5
 Ng+p9dRiYFd0S+Is=
X-Received: by 2002:ac8:4e53:0:b0:41c:c34a:84af with SMTP id
 e19-20020ac84e53000000b0041cc34a84afmr1040520qtw.6.1697789947059; 
 Fri, 20 Oct 2023 01:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwruiAMvEBf1hArsRXH9RVX4GGhmAfIYdi83dIU85HtHmTVWOuH8DJ3VDWReiNQ7hfARTz5g==
X-Received: by 2002:ac8:4e53:0:b0:41c:c34a:84af with SMTP id
 e19-20020ac84e53000000b0041cc34a84afmr1040498qtw.6.1697789946742; 
 Fri, 20 Oct 2023 01:19:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 df7-20020a05622a0ec700b00418122186ccsm430159qtb.12.2023.10.20.01.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 01:19:05 -0700 (PDT)
Message-ID: <3573353d-5153-2678-e121-33cf20798aa6@redhat.com>
Date: Fri, 20 Oct 2023 10:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
 and targetted interface
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, David Gibson <david@gibson.dropbear.id.au>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
 <20231016083223.1519410-3-zhenzhong.duan@intel.com>
 <f8089865-20cf-4f11-981a-e593a103a387@redhat.com>
 <PH7PR11MB6722FF23DC574EB09300075292D5A@PH7PR11MB6722.namprd11.prod.outlook.com>
 <c5c0c0ff-3eb1-4b46-b39c-e4e7fa250618@redhat.com>
 <PH7PR11MB67226A6A32A4655138CE1C8A92D4A@PH7PR11MB6722.namprd11.prod.outlook.com>
 <cf232093-a59c-49ef-9271-bb691860215b@redhat.com>
 <PH7PR11MB6722D6969CD287A86CFC469792DBA@PH7PR11MB6722.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <PH7PR11MB6722D6969CD287A86CFC469792DBA@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

Hi,
On 10/20/23 07:48, Duan, Zhenzhong wrote:
> Hi Cédric,
>
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Thursday, October 19, 2023 8:18 PM
>> Subject: Re: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer and
>> targetted interface
>>
>> On 10/19/23 04:29, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Cédric Le Goater <clg@redhat.com>
>>>> Sent: Wednesday, October 18, 2023 4:04 PM
>>>> Subject: Re: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
>> and
>>>> targetted interface
>>>>
>>>> On 10/18/23 04:41, Duan, Zhenzhong wrote:
>>>>> Hi Cédric,
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>>> Sent: Tuesday, October 17, 2023 11:51 PM
>>>>>> Subject: Re: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
>>>> and
>>>>>> targetted interface
>>>>>>
>>>>>> On 10/16/23 10:31, Zhenzhong Duan wrote:
>>>>>>> From: Eric Auger <eric.auger@redhat.com>
>>>>>>>
>>>>>>> Introduce a dumb VFIOContainer base object and its targetted interface.
>>>>>>> This is willingly not a QOM object because we don't want it to be
>>>>>>> visible from the user interface.  The VFIOContainer will be smoothly
>>>>>>> populated in subsequent patches as well as interfaces.
>>>>>>>
>>>>>>> No fucntional change intended.
>>>>>>>
>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>> ---
>>>>>>>     include/hw/vfio/vfio-common.h         |  8 +--
>>>>>>>     include/hw/vfio/vfio-container-base.h | 82
>>>> +++++++++++++++++++++++++++
>>>>>>>     2 files changed, 84 insertions(+), 6 deletions(-)
>>>>>>>     create mode 100644 include/hw/vfio/vfio-container-base.h
>>>>>>>
>>>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>>>> common.h
>>>>>>> index 34648e518e..9651cf921c 100644
>>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>>> @@ -30,6 +30,7 @@
>>>>>>>     #include <linux/vfio.h>
>>>>>>>     #endif
>>>>>>>     #include "sysemu/sysemu.h"
>>>>>>> +#include "hw/vfio/vfio-container-base.h"
>>>>>>>
>>>>>>>     #define VFIO_MSG_PREFIX "vfio %s: "
>>>>>>>
>>>>>>> @@ -81,6 +82,7 @@ typedef struct VFIOAddressSpace {
>>>>>>>     struct VFIOGroup;
>>>>>>>
>>>>>>>     typedef struct VFIOLegacyContainer {
>>>>>>> +    VFIOContainer bcontainer;
>>>>>> That's the parent class, right ?
>>>>> Right.
>>>>>
>>>>>>>         VFIOAddressSpace *space;
>>>>>>>         int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>>>>>>>         MemoryListener listener;
>>>>>>> @@ -200,12 +202,6 @@ typedef struct VFIODisplay {
>>>>>>>         } dmabuf;
>>>>>>>     } VFIODisplay;
>>>>>>>
>>>>>>> -typedef struct {
>>>>>>> -    unsigned long *bitmap;
>>>>>>> -    hwaddr size;
>>>>>>> -    hwaddr pages;
>>>>>>> -} VFIOBitmap;
>>>>>>> -
>>>>>>>     void vfio_host_win_add(VFIOLegacyContainer *container,
>>>>>>>                            hwaddr min_iova, hwaddr max_iova,
>>>>>>>                            uint64_t iova_pgsizes);
>>>>>>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>>>>>> container-base.h
>>>>>>> new file mode 100644
>>>>>>> index 0000000000..afc8543d22
>>>>>>> --- /dev/null
>>>>>>> +++ b/include/hw/vfio/vfio-container-base.h
>>>>>>> @@ -0,0 +1,82 @@
>>>>>>> +/*
>>>>>>> + * VFIO BASE CONTAINER
>>>>>>> + *
>>>>>>> + * Copyright (C) 2023 Intel Corporation.
>>>>>>> + * Copyright Red Hat, Inc. 2023
>>>>>>> + *
>>>>>>> + * Authors: Yi Liu <yi.l.liu@intel.com>
>>>>>>> + *          Eric Auger <eric.auger@redhat.com>
>>>>>>> + *
>>>>>>> + * This program is free software; you can redistribute it and/or modify
>>>>>>> + * it under the terms of the GNU General Public License as published by
>>>>>>> + * the Free Software Foundation; either version 2 of the License, or
>>>>>>> + * (at your option) any later version.
>>>>>>> +
>>>>>>> + * This program is distributed in the hope that it will be useful,
>>>>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>>>> + * GNU General Public License for more details.
>>>>>>> +
>>>>>>> + * You should have received a copy of the GNU General Public License
>> along
>>>>>>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>>>>>>> + */
>>>>>>> +
>>>>>>> +#ifndef HW_VFIO_VFIO_BASE_CONTAINER_H
>>>>>>> +#define HW_VFIO_VFIO_BASE_CONTAINER_H
>>>>>>> +
>>>>>>> +#include "exec/memory.h"
>>>>>>> +#ifndef CONFIG_USER_ONLY
>>>>>>> +#include "exec/hwaddr.h"
>>>>>>> +#endif
>>>>>>> +
>>>>>>> +typedef struct VFIOContainer VFIOContainer;
>>>>>>> +typedef struct VFIODevice VFIODevice;
>>>>>>> +typedef struct VFIOIOMMUBackendOpsClass
>> VFIOIOMMUBackendOpsClass;
>>>>>>> +
>>>>>>> +typedef struct {
>>>>>>> +    unsigned long *bitmap;
>>>>>>> +    hwaddr size;
>>>>>>> +    hwaddr pages;
>>>>>>> +} VFIOBitmap;
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * This is the base object for vfio container backends
>>>>>>> + */
>>>>>>> +struct VFIOContainer {
>>>>>>> +    VFIOIOMMUBackendOpsClass *ops;
>>>>>> This is unexpected.
>>>>>>
>>>>>> I thought that an abstract QOM model for VFIOContainer was going
>>>>>> to be introduced with a VFIOContainerClass with the ops below
>>>>>> (VFIOIOMMUBackendOpsClass).
>>>>>>
>>>>>> Then, we would call :
>>>>>>
>>>>>>      VFIOContainerClass *vcc = VFIO_CONTAINER_GET_CLASS(container);
>>>>>>
>>>>>> to get the specific implementation for the current container.
>>>>>>
>>>>>> I don't understand the VFIOIOMMUBackendOpsClass pointer and
>>>>>> TYPE_VFIO_IOMMU_BACKEND_OPS. It seems redundant.
>>>>> The original implementation was abstract QOM model. But it wasn't
>> accepted,
>>>>> see https://lore.kernel.org/all/YmuFv2s5TPuw7K%2Fu@yekko/ for details.
>>>> I see the idea was challenged, not rejected. I need to dig in further and this
>>>> will take time.
>>> Thanks for help looking into it.
>>>
>>> +David, Hi David, I'm digging into your concern of using QOM to abstract base
>>> container and legacy VFIOContainer:
>>> "The QOM class of things is visible to the user/config layer via QMP (and
>> sometimes command line).
>>> It doesn't necessarily correspond to guest visible differences, but it often does."
>>>
>>> AIUI, while it's true when the QOM type includes TYPE_USER_CREATABLE
>> interface,
>>> otherwise, user can't create an object of this type. Only difference is user will
>> see
>>> "object type '%s' isn't supported by object-add" instead of "invalid object
>> type: %s".
>>> Is your expectation to not permit user to create this object or only want user
>>> to see "invalid object type: %s".
>>> If you mean the first, then I think QOM could be suitable if we don't include
>>> TYPE_USER_CREATABLE interface?
>> I was imagining some kind of QOM hierarchy under the vfio device
>> with various QOM interfaces (similar to the ops) to define the
>> possible IOMMU backends. The fact that we use the IOMMUFD object
> >from the command line made it more plausible. I might be mistaking.
>
> Got your point.
> This way we introduce a new QOM type "vfio-pci-iommufd" for iommufd support,
> and vfio-pci keep same for legacy backend, e.g:
>
> #qemu  -object iommufd,id=iommufd0 \
>               -device vfio-pci-iommufd,iommufd=iommufd0,id=vfio0... \
>              -device vfio-pci,id=vfio1...
you would need to do that for all types for vfio devices, ap, ccw,
platform. Looks heavy to me. Why would we need to use a different
vfio-pci-* device while we could switch the iommu backend according to
the "iommufd" prop presence. The initial discussion was about QOMyfying
the container instead.

Thanks

Eric
 
>
> Below is a draft for vfio-pci based on your imagination. not pasted here the change
> for platform/ap/ccw vfio device which should be similar.
> Not clear if this fully match your imagination.
>
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 5345986993..54a6ce4d73 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -124,7 +124,7 @@ DECLARE_CLASS_CHECKERS(VFIOIOMMUBackendOpsClass,
>
>  struct VFIOIOMMUBackendOpsClass {
>      /*< private >*/
> -    ObjectClass parent_class;
> +    InterfaceClass parent_class;
>
>      /*< public >*/
>      /* required */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index edb787d3d1..829deddc7d 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3725,6 +3725,11 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
> +    IOMMU_Backend_Ops_Class *be_ops = IOMMU_BACKEND_OPS_CLASS(klass);
> +
> +    be_ops->dma_map = vfio_legacy_dma_map;
> +    be_ops->dma_unmap = vfio_legacy_dma_unmap;
> +    ...
>
>      dc->reset = vfio_pci_reset;
>      device_class_set_props(dc, vfio_pci_dev_properties);
> @@ -3749,10 +3754,40 @@ static const TypeInfo vfio_pci_dev_info = {
>      .interfaces = (InterfaceInfo[]) {
>          { INTERFACE_PCIE_DEVICE },
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { INTERFACE_IOMMU_BACKEND_OPS },
>          { }
>      },
>  };
>
> +static Property vfio_pci_dev_iommufd_properties[] = {
> +#ifdef CONFIG_IOMMUFD
> +    DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
> +                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> +#endif
> +};
> +
> +static void vfio_pci_iommufd_dev_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    IOMMU_Backend_Ops_Class *be_ops = IOMMU_BACKEND_OPS_CLASS(klass);
> +
> +    device_class_set_props(dc, vfio_pci_dev_iommufd_properties);
> +
> +    be_ops->dma_map = iommufd_map;
> +    be_ops->dma_unmap = iommufd_unmap;
> +    ...
> +    /* Unimplemented ops */
> +    be_ops->set_dirty_page_tracking = NULL;
> +    ...
> +}
> +
> +static const TypeInfo vfio_pci_iommufd_dev_info = {
> +    .name = TYPE_VFIO_PCI_IOMMUFD,
> +    .parent = TYPE_VFIO_PCI,
> +    .instance_size = sizeof(VFIOPCIDevice),
> +    .class_init = vfio_pci_iommufd_dev_class_init,
> +};
> +
>  static Property vfio_pci_dev_nohotplug_properties[] = {
>      DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>      DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
> @@ -3770,13 +3805,20 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
>
>  static const TypeInfo vfio_pci_nohotplug_dev_info = {
>      .name = TYPE_VFIO_PCI_NOHOTPLUG,
> -    .parent = TYPE_VFIO_PCI,
> +    .parent = TYPE_VFIO_PCI_IOMMUFD,
>      .instance_size = sizeof(VFIOPCIDevice),
>      .class_init = vfio_pci_nohotplug_dev_class_init,
>  };
>
>  static void register_vfio_pci_dev_type(void)
>  {
> +    static const TypeInfo iommu_be_ops_interface_info = {
> +        .name          = TYPE_IOMMU_BACKEND_OPS,
> +        .parent        = TYPE_INTERFACE,
> +        .class_size = sizeof(VFIOIOMMUBackendOpsClass),
> +    };
> +
> +    type_register_static(&iommu_be_ops_interface_info);
>      type_register_static(&vfio_pci_dev_info);
>      type_register_static(&vfio_pci_nohotplug_dev_info);
>  }
>
> Thanks
> Zhenzhong
>
>> Anyhow, the series looks pretty good. There are other aspect to
>> check, like are all this iommu ops well suited for the need ?
>> Let's stress the models in parallel of the reviews. If we could get
>> some of it for 8.2 that'd be nice. It's on top of my list now.
>>
>> Thanks,
>>
>> C.
>>
>>
>>> Thanks
>>> Zhenzhong



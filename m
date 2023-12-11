Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FFC80CC6F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 15:01:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgqM-0003Z9-J3; Mon, 11 Dec 2023 09:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rCgqE-0003YZ-Qq
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 09:01:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rCgq9-0007OW-Kj
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 09:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702303257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=731bi/GhYlv54WauJ+R+GjlExLdHpW/P4cdVxrO6coQ=;
 b=RsRqTgAAySh41TsH2SJew8Og5GbwHhYYlG/OeipF+EXIAEcf2DA1/DRdEOC2txD7EEy65e
 xkvRlKfrdeJeAMWN/TdnmOxuCYkpWmi55nIqPv6hBD0eeDWlb6sHLVvHV+AApp1GVY2tDs
 xIy+JUhdnBp/eWLEnFa94hcdGvjfkZM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-4HS3uMsIPZaAVKJ5vsKaDA-1; Mon, 11 Dec 2023 09:00:54 -0500
X-MC-Unique: 4HS3uMsIPZaAVKJ5vsKaDA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-67a696be34cso64047126d6.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 06:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702303254; x=1702908054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=731bi/GhYlv54WauJ+R+GjlExLdHpW/P4cdVxrO6coQ=;
 b=HDC3yqEGDt8xDun62b9Ns4Dt8ohHQUkUR8zYDFQB17zOkrFMyrrcKcQ9dWUVJxirkh
 gHlNg6w23fJiSNwTcNbbR8Hv50uHagTamlCePGKavp7L8pZoMk6iD8kiucLj+X5giI74
 3JbRS7arvME4GwOMD9Wul9fXDlnRRlQWJHzJ9cJpQZxrZbFaBYjIeeVrs1CSzagR5gC6
 VgJ24VrPhS2vZwG1HebIQ4O8+QSGR1rZ0LIbwdPQpZYbfNbnCxugWuIFz27TVMwO1iz4
 Ds6rRfv8zyJr5ZyZNCBpeDPJgqNovscM763maGSvxqCy5hNk4qHivKdANlccmm/Ykuh+
 lz8Q==
X-Gm-Message-State: AOJu0Yx57LPVfv7CzCM00U6GRnnrA2cdtTjqvvRlqB26IBy5r4fHQzmJ
 JI2vRWaJehTmh2YrESW9rWAydMnOwcDnzY6OKcl82xcOikXHoWw70N0rIGcFHmRuWFk0CmZbtOj
 yoaIwU6DpRPkaGCc=
X-Received: by 2002:a05:6214:bc8:b0:67a:aa54:dbe1 with SMTP id
 ff8-20020a0562140bc800b0067aaa54dbe1mr4590514qvb.102.1702303254090; 
 Mon, 11 Dec 2023 06:00:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxO5+AT/HnD2C0HeEVWj5vFbWhdVcdYBnoOKG2/L9XzX66C0jU1GH/E2aPPzExtvH4Nsm6UQ==
X-Received: by 2002:a05:6214:bc8:b0:67a:aa54:dbe1 with SMTP id
 ff8-20020a0562140bc800b0067aaa54dbe1mr4590503qvb.102.1702303253806; 
 Mon, 11 Dec 2023 06:00:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 b6-20020ad45186000000b0067a770a6061sm3327968qvp.58.2023.12.11.06.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 06:00:53 -0800 (PST)
Message-ID: <6f47ba3d-2b87-4bf6-84af-e0eb5e78b19a@redhat.com>
Date: Mon, 11 Dec 2023 15:00:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 05/10] vfio/container: Introduce a VFIOIOMMU
 legacy QOM interface
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-6-clg@redhat.com>
 <SJ0PR11MB6744BFFFC1507716EF630EEB928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744BFFFC1507716EF630EEB928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/11/23 07:14, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, December 8, 2023 4:46 PM
>> Subject: [PATCH for-9.0 05/10] vfio/container: Introduce a VFIOIOMMU
>> legacy QOM interface
>>
>> Convert the legacy VFIOIOMMUOps struct to the new VFIOIOMMU QOM
>> interface. The set of of operations for this backend can be referenced
>> with a literal typename instead of a C struct. This will simplify
>> support of multiple backends.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> include/hw/vfio/vfio-common.h         |  1 -
>> include/hw/vfio/vfio-container-base.h |  1 +
>> hw/vfio/common.c                      |  6 ++-
>> hw/vfio/container.c                   | 59 +++++++++++++++++++++++----
>> 4 files changed, 56 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>> index
>> b8aa8a549532442a31c8e85ce385c992d84f6bd5..14c497b6b0a79466e8f56
>> 7aceed384ec2c75ea90 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -210,7 +210,6 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup)
>> VFIOGroupList;
>> typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>> extern VFIOGroupList vfio_group_list;
>> extern VFIODeviceList vfio_device_list;
>> -extern const VFIOIOMMUOps vfio_legacy_ops;
>> extern const VFIOIOMMUOps vfio_iommufd_ops;
>> extern const MemoryListener vfio_memory_listener;
>> extern int vfio_kvm_device_fd;
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>> index
>> 81d49fe562d3840859096dd8a62ac38d62314939..a31fd9c2e3b9a571083e
>> a8987ac27e91b332c170 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -95,6 +95,7 @@ void vfio_container_destroy(VFIOContainerBase
>> *bcontainer);
>> typedef struct VFIOIOMMU VFIOIOMMU;
>>
>> #define TYPE_VFIO_IOMMU "vfio-iommu"
>> +#define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
>>
>> #define VFIO_IOMMU(obj) INTERFACE_CHECK(VFIOIOMMU, (obj),
>> TYPE_VFIO_IOMMU)
>> DECLARE_CLASS_CHECKERS(VFIOIOMMUClass, VFIO_IOMMU,
>> TYPE_VFIO_IOMMU)
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index
>> 49dab41566f07ba7be1100fed1973e028d34467c..2329d0efc8c1d617f0bfee
>> 5283e82b295d2d477d 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1503,13 +1503,17 @@ retry:
>> int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>                         AddressSpace *as, Error **errp)
>> {
>> -    const VFIOIOMMUClass *ops = &vfio_legacy_ops;
>> +    const VFIOIOMMUClass *ops =
>> +
>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>>
>> #ifdef CONFIG_IOMMUFD
>>      if (vbasedev->iommufd) {
>>          ops = &vfio_iommufd_ops;
>>      }
>> #endif
>> +
>> +    assert(ops);
>> +
>>      return ops->attach_device(name, vbasedev, as, errp);
>> }
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index
>> f4a0434a5239bfb6a17b91c8879cb98e686afccc..fdf4e116570013732d4807
>> 1a5122d25b02da715c 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -369,10 +369,30 @@ static int vfio_get_iommu_type(VFIOContainer
>> *container,
>>      return -EINVAL;
>> }
>>
>> +/*
>> + * vfio_get_iommu_ops - get a VFIOIOMMUClass associated with a type
>> + */
>> +static const VFIOIOMMUClass *vfio_get_iommu_class(int iommu_type,
>> Error **errp)
>> +{
>> +    ObjectClass *klass = NULL;
> 
> No need to nullify?

well, I am not sure. Some compilers might complain. I will check.


>> +
>> +    switch (iommu_type) {
>> +    case VFIO_TYPE1v2_IOMMU:
>> +    case VFIO_TYPE1_IOMMU:
>> +        klass = object_class_by_name(TYPE_VFIO_IOMMU_LEGACY);
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    };
>> +
>> +    return VFIO_IOMMU_CLASS(klass);
>> +}
>> +
>> static int vfio_init_container(VFIOContainer *container, int group_fd,
>>                                 VFIOAddressSpace *space, Error **errp)
>> {
>>      int iommu_type, ret;
>> +    const VFIOIOMMUClass *vioc = NULL;
> 
> No need to nullify?

No need indeed.
  
>>
>>      iommu_type = vfio_get_iommu_type(container, errp);
>>      if (iommu_type < 0) {
>> @@ -401,7 +421,14 @@ static int vfio_init_container(VFIOContainer
>> *container, int group_fd,
>>      }
>>
>>      container->iommu_type = iommu_type;
>> -    vfio_container_init(&container->bcontainer, space, &vfio_legacy_ops);
>> +
>> +    vioc = vfio_get_iommu_class(iommu_type, errp);
>> +    if (!vioc) {
>> +        error_setg(errp, "No available IOMMU models");
>> +        return -EINVAL;
>> +    }
>> +
>> +    vfio_container_init(&container->bcontainer, space, vioc);
>>      return 0;
>> }
>>
>> @@ -1098,12 +1125,26 @@ out_single:
>>      return ret;
>> }
>>
>> -const VFIOIOMMUOps vfio_legacy_ops = {
>> -    .dma_map = vfio_legacy_dma_map,
>> -    .dma_unmap = vfio_legacy_dma_unmap,
>> -    .attach_device = vfio_legacy_attach_device,
>> -    .detach_device = vfio_legacy_detach_device,
>> -    .set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking,
>> -    .query_dirty_bitmap = vfio_legacy_query_dirty_bitmap,
>> -    .pci_hot_reset = vfio_legacy_pci_hot_reset,
>> +static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
>> +{
>> +    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
>> +
>> +    vioc->dma_map = vfio_legacy_dma_map;
>> +    vioc->dma_unmap = vfio_legacy_dma_unmap;
>> +    vioc->attach_device = vfio_legacy_attach_device;
>> +    vioc->detach_device = vfio_legacy_detach_device;
>> +    vioc->set_dirty_page_tracking = vfio_legacy_set_dirty_page_tracking;
>> +    vioc->query_dirty_bitmap = vfio_legacy_query_dirty_bitmap;
>> +    vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
>> };
>> +
>> +static const TypeInfo types[] = {
>> +    {
>> +        .name = TYPE_VFIO_IOMMU_LEGACY,
>> +        .parent = TYPE_VFIO_IOMMU,
>> +        .class_init = vfio_iommu_legacy_class_init,
>> +        .class_size = sizeof(VFIOIOMMUClass),
> 
> Inherit parent class_size is enough? Otherwise,

No need to define class_size again.


Thanks,

C.



> 
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Thanks
> Zhenzhong
> 
>> +    },
>> +};
>> +
>> +DEFINE_TYPES(types)
>> --
>> 2.43.0
> 



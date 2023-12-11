Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E59680CC3C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:59:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgoJ-0002RF-SQ; Mon, 11 Dec 2023 08:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rCgoH-0002R6-Pd
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:59:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rCgoG-0006U5-3p
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702303139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kCvRAfSZPn5WA3L+WT1Hz5o0ZQN/0uzlFAD3mZFobg4=;
 b=cgAtMF5obd6p2QLCm5S/EhaSBO4sawLw5EDokAYjA7Xpxz3rXzjFppDITEJ2vBBtDYw9Vs
 6GQycv7QvF1314gVI3Sglr2M1a+UGD47mifEFL5Ac4jO8Xdia/GctdOotbgmmiHS5nrK/a
 rpNTKRlcr+hNE90o/m+JZLYeOoill10=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-ljlhgiieNDWnnvAdw7CI0A-1; Mon, 11 Dec 2023 08:58:58 -0500
X-MC-Unique: ljlhgiieNDWnnvAdw7CI0A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-67aec8cce57so49684956d6.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:58:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702303137; x=1702907937;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kCvRAfSZPn5WA3L+WT1Hz5o0ZQN/0uzlFAD3mZFobg4=;
 b=ZYo8iTJYne4UwbcgaoNtUHeJZCTX2u3p56uNZBlojlKyEHRw7BeatGhz/fxkCE3AvF
 TX9nQojv+l+0tTH4kOafxt55UkLAz7Q1/HxPYlh93v/+NljOzHyPgNavWJ+pv+0EhIgP
 bxIsVBCI8S8ZUOi7XlJppG34RhKuXEGr220kB/3+OACNE4aN0t68cj7SnZMULevVLEZh
 RYYLDKROLlRhnPzUf0SHR+IbiH0dUaf0cMIOjssjv7qLKv/y2zbRVxC1iTha8eUOSXAK
 GImf5WOxfpLuFyRzpHf9xiQt9LyOdcAhWt8mIQoYMzkgN9VjKkKitXRIT5MRy4FtT5mi
 fzag==
X-Gm-Message-State: AOJu0YzVo1MHE8yeKmiBV6m6Sd60R/TpveKI11hn6WN9wICdbGp8Ex0s
 8roKT3gbJRVyuKGbVQJ/0L0hFIR4addIxM+1JoRhph5ttWiMMqWdIH7jbI8OhM1yxzxywautRO5
 aYWOZRHKQoe2JuvM=
X-Received: by 2002:a05:6214:5ec4:b0:67a:a721:9ec2 with SMTP id
 mn4-20020a0562145ec400b0067aa7219ec2mr5082441qvb.115.1702303137636; 
 Mon, 11 Dec 2023 05:58:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElrnoNRfF8zrvVdJVZbUDAwpftDxyZNbLGnvd7ZuHtjtCD26o1XyM6+3orbMYCayW2HrnqQw==
X-Received: by 2002:a05:6214:5ec4:b0:67a:a721:9ec2 with SMTP id
 mn4-20020a0562145ec400b0067aa7219ec2mr5082432qvb.115.1702303137406; 
 Mon, 11 Dec 2023 05:58:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 e7-20020ad442a7000000b0067cd743328csm3301214qvr.81.2023.12.11.05.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 05:58:57 -0800 (PST)
Message-ID: <f0dfddd3-b080-4f59-b92d-8e06c6f3f9cb@redhat.com>
Date: Mon, 11 Dec 2023 14:58:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 04/10] vfio/container: Introduce a VFIOIOMMU QOM
 interface
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-5-clg@redhat.com>
 <SJ0PR11MB67447A62DBC85853B6AB4652928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67447A62DBC85853B6AB4652928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/11/23 07:08, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, December 8, 2023 4:46 PM
>> Subject: [PATCH for-9.0 04/10] vfio/container: Introduce a VFIOIOMMU
>> QOM interface
>>
>> Simply transform the VFIOIOMMUOps struct in an InterfaceClass and do
>> some initial name replacements. Next changes will start converting
>> VFIOIOMMUOps.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++----
>> hw/vfio/common.c                      |  2 +-
>> hw/vfio/container-base.c              | 12 +++++++++++-
>> hw/vfio/pci.c                         |  2 +-
>> 4 files changed, 27 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>> index
>> 5c9594b6c77681e5593236e711e7e391e5f2bdff..81d49fe562d3840859096
>> dd8a62ac38d62314939 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -16,7 +16,8 @@
>> #include "exec/memory.h"
>>
>> typedef struct VFIODevice VFIODevice;
>> -typedef struct VFIOIOMMUOps VFIOIOMMUOps;
>> +typedef struct VFIOIOMMUClass VFIOIOMMUClass;
>> +#define VFIOIOMMUOps VFIOIOMMUClass /* To remove */
>>
>> typedef struct {
>>      unsigned long *bitmap;
>> @@ -34,7 +35,7 @@ typedef struct VFIOAddressSpace {
>>   * This is the base object for vfio container backends
>>   */
>> typedef struct VFIOContainerBase {
>> -    const VFIOIOMMUOps *ops;
>> +    const VFIOIOMMUClass *ops;
>>      VFIOAddressSpace *space;
>>      MemoryListener listener;
>>      Error *error;
>> @@ -88,10 +89,19 @@ int vfio_container_query_dirty_bitmap(const
>> VFIOContainerBase *bcontainer,
>>
>> void vfio_container_init(VFIOContainerBase *bcontainer,
>>                           VFIOAddressSpace *space,
>> -                         const VFIOIOMMUOps *ops);
>> +                         const VFIOIOMMUClass *ops);
>> void vfio_container_destroy(VFIOContainerBase *bcontainer);
>>
>> -struct VFIOIOMMUOps {
>> +typedef struct VFIOIOMMU VFIOIOMMU;
>> +
>> +#define TYPE_VFIO_IOMMU "vfio-iommu"
>> +
>> +#define VFIO_IOMMU(obj) INTERFACE_CHECK(VFIOIOMMU, (obj),
>> TYPE_VFIO_IOMMU)
> 
> Maybe this #define can be removed or you have other plans?

yes, and we can remove 'struct VFIOIOMMU' also.


Thanks,

C.




> Otherwise, Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Thanks
> Zhenzhong
> 
>> +DECLARE_CLASS_CHECKERS(VFIOIOMMUClass, VFIO_IOMMU,
>> TYPE_VFIO_IOMMU)
>> +
>> +struct VFIOIOMMUClass {
>> +    InterfaceClass parent_class;
>> +
>>      /* basic feature */
>>      int (*dma_map)(const VFIOContainerBase *bcontainer,
>>                     hwaddr iova, ram_addr_t size,
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index
>> 08a3e576725b1fc9f2f7e425375df3b827c4fe56..49dab41566f07ba7be1100f
>> ed1973e028d34467c 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1503,7 +1503,7 @@ retry:
>> int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>                         AddressSpace *as, Error **errp)
>> {
>> -    const VFIOIOMMUOps *ops = &vfio_legacy_ops;
>> +    const VFIOIOMMUClass *ops = &vfio_legacy_ops;
>>
>> #ifdef CONFIG_IOMMUFD
>>      if (vbasedev->iommufd) {
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index
>> 1ffd25bbfa8bd3d404e43b96357273b95f5a0031..913ae49077c4f09b7b275
>> 17c1231cfbe4befb7fb 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -72,7 +72,7 @@ int vfio_container_query_dirty_bitmap(const
>> VFIOContainerBase *bcontainer,
>> }
>>
>> void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace
>> *space,
>> -                         const VFIOIOMMUOps *ops)
>> +                         const VFIOIOMMUClass *ops)
>> {
>>      bcontainer->ops = ops;
>>      bcontainer->space = space;
>> @@ -99,3 +99,13 @@ void vfio_container_destroy(VFIOContainerBase
>> *bcontainer)
>>
>>      g_list_free_full(bcontainer->iova_ranges, g_free);
>> }
>> +
>> +static const TypeInfo types[] = {
>> +    {
>> +        .name = TYPE_VFIO_IOMMU,
>> +        .parent = TYPE_INTERFACE,
>> +        .class_size = sizeof(VFIOIOMMUClass),
>> +    },
>> +};
>> +
>> +DEFINE_TYPES(types)
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index
>> 1874ec1aba987cac6cb83f86650e7a5e1968c327..d84a9e73a65de4e4c1cdaf
>> 65619a700bd8d6b802 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2488,7 +2488,7 @@ int
>> vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
>> static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
>> {
>>      VFIODevice *vbasedev = &vdev->vbasedev;
>> -    const VFIOIOMMUOps *ops = vbasedev->bcontainer->ops;
>> +    const VFIOIOMMUClass *ops = vbasedev->bcontainer->ops;
>>
>>      return ops->pci_hot_reset(vbasedev, single);
>> }
>> --
>> 2.43.0
> 



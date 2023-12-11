Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9225580CC93
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 15:02:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgqs-0003af-4E; Mon, 11 Dec 2023 09:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rCgqU-0003aC-FJ
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 09:01:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rCgqR-0007Yb-PL
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 09:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702303275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5H+UzZkXQPYBL+YdjDioW1GLtxywgoPzJjq6vmMfUg=;
 b=Pg1E2eVMBdZoaBm3avxW5mrWvpIn5VX9HJ0uSQmx40VunER9VgYfCDzOHgjcwvEU/zjp2X
 PKEgtCiNVLs5BtPGic2zZ+Ezx5/Uc42o1Hg7TyPWynSjO/NsHYS5dpJmq80i3X7FmORsnd
 sSz2khlcXlPeJJAwOQwYoS1LNU3nFiE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-ORuzMAroPmuXfhRIgUJ-Ow-1; Mon, 11 Dec 2023 09:01:13 -0500
X-MC-Unique: ORuzMAroPmuXfhRIgUJ-Ow-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-67aa0c94343so95533886d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 06:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702303273; x=1702908073;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k5H+UzZkXQPYBL+YdjDioW1GLtxywgoPzJjq6vmMfUg=;
 b=u169zdjkOFCeL1/wo/sb7saJ+PzhYxUk/khVQswjjW8g69ZpCXjYs7H+6YVDQQdQkw
 KHxEoFJvX5wJHuJvYUCnFVMj37MlBCI2NskMvW4uZQfyD4+PZtm1/9wC8CT61AoU//Xo
 hZ5nnn7vmK8THx4G5yoLvGdwfAq02d6Tax2yD4XkAhI+jLTZ9JevvzHwkpQwTCA0fgQ+
 THMT0pu1G0SIAmzDmOn1G0VPU3VG2a9A5LtZwXQI2y7zmig2rTxtW5x1hFGYhB9ZrRm2
 KTRzjbYGLQdSH6SDRTk/lJWk6THyU8RI56RGwCckTZ6RCTy4giM240RDRjAigD9GbpYZ
 rJcA==
X-Gm-Message-State: AOJu0YzzXMGI45j+maAlf2bfMurmaFw5NfpSv1TfrSLlId5/JBsZeuS3
 VtEG2tkC/mtsfNPmx059oRbelm8uZF9P9XnB90UvEANGnm0YYb3COQaPPX7WkcBC1SwvlyLnr4M
 NZ7FXfJPhsqnFTg4=
X-Received: by 2002:a05:6214:2d09:b0:67a:a779:ea18 with SMTP id
 mz9-20020a0562142d0900b0067aa779ea18mr6724016qvb.25.1702303272500; 
 Mon, 11 Dec 2023 06:01:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOiPP5VezjQJY1OcWkmyAvUEBfzmBt3oBwePaDVZ/lhATfAgIWUtoJqycdj051SEDNrhMosQ==
X-Received: by 2002:a05:6214:2d09:b0:67a:a779:ea18 with SMTP id
 mz9-20020a0562142d0900b0067aa779ea18mr6723998qvb.25.1702303272234; 
 Mon, 11 Dec 2023 06:01:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 b6-20020ad45186000000b0067a770a6061sm3327968qvp.58.2023.12.11.06.01.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 06:01:11 -0800 (PST)
Message-ID: <ae1d91d3-2aff-4e5d-a18f-f3107434ec9c@redhat.com>
Date: Mon, 11 Dec 2023 15:01:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 07/10] vfio/spapr: Introduce a sPAPR VFIOIOMMU QOM
 interface
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-8-clg@redhat.com>
 <SJ0PR11MB6744660C2087683E83A01E58928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744660C2087683E83A01E58928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/11/23 07:25, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, December 8, 2023 4:46 PM
>> Subject: [PATCH for-9.0 07/10] vfio/spapr: Introduce a sPAPR VFIOIOMMU
>> QOM interface
>>
>> Move vfio_spapr_container_setup() to a VFIOIOMMUClass::setup handler
>> and convert the sPAPR VFIOIOMMUOps struct to a QOM interface. The
>> sPAPR QOM interface inherits from the legacy QOM interface because
>> because both have the same basic needs. The sPAPR interface is then
>> extended with the handlers specific to the sPAPR IOMMU.
>>
>> This allows reuse and provides better abstraction of the backends. It
>> will be useful to avoid compiling the sPAPR IOMMU backend on targets
>> not supporting it.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> include/hw/vfio/vfio-container-base.h |  1 +
>> hw/vfio/container.c                   | 18 ++++--------
>> hw/vfio/spapr.c                       | 40 +++++++++++++++++----------
>> 3 files changed, 32 insertions(+), 27 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>> index
>> 870e7dc48e542ddbfc52e12b0ab5fab4771a1ebd..4012360c07b7c0a23f170f
>> 94a19455c79d3504b1 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -96,6 +96,7 @@ typedef struct VFIOIOMMU VFIOIOMMU;
>>
>> #define TYPE_VFIO_IOMMU "vfio-iommu"
>> #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
>> +#define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
>>
>> #define VFIO_IOMMU(obj) INTERFACE_CHECK(VFIOIOMMU, (obj),
>> TYPE_VFIO_IOMMU)
>> DECLARE_CLASS_CHECKERS(VFIOIOMMUClass, VFIO_IOMMU,
>> TYPE_VFIO_IOMMU)
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index
>> 5f5ad8479f083db0be5207f179f3056ae67c49c3..ce5a731ba74600fbb331a8
>> 0f5148a88e2e43b068 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -381,6 +381,10 @@ static const VFIOIOMMUClass
>> *vfio_get_iommu_class(int iommu_type, Error **errp)
>>      case VFIO_TYPE1_IOMMU:
>>          klass = object_class_by_name(TYPE_VFIO_IOMMU_LEGACY);
>>          break;
>> +    case VFIO_SPAPR_TCE_v2_IOMMU:
>> +    case VFIO_SPAPR_TCE_IOMMU:
>> +        klass = object_class_by_name(TYPE_VFIO_IOMMU_SPAPR);
>> +        break;
>>      default:
>>          g_assert_not_reached();
>>      };
>> @@ -623,19 +627,9 @@ static int vfio_connect_container(VFIOGroup
>> *group, AddressSpace *as,
>>          goto free_container_exit;
>>      }
>>
>> -    switch (container->iommu_type) {
>> -    case VFIO_TYPE1v2_IOMMU:
>> -    case VFIO_TYPE1_IOMMU:
>> -        ret = vfio_legacy_setup(bcontainer, errp);
>> -        break;
>> -    case VFIO_SPAPR_TCE_v2_IOMMU:
>> -    case VFIO_SPAPR_TCE_IOMMU:
>> -        ret = vfio_spapr_container_init(container, errp);
>> -        break;
>> -    default:
>> -        g_assert_not_reached();
>> -    }
>> +    assert(bcontainer->ops->setup);
>>
>> +    ret = bcontainer->ops->setup(bcontainer, errp);
>>      if (ret) {
>>          goto enable_discards_exit;
>>      }
>> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
>> index
>> 44617dfc6b5f1a2a3a1c37436b76042aebda8b63..46aa14bd2ae6d580c16bb
>> a75838cb6aca7d4047f 100644
>> --- a/hw/vfio/spapr.c
>> +++ b/hw/vfio/spapr.c
>> @@ -458,20 +458,11 @@ static void
>> vfio_spapr_container_release(VFIOContainerBase *bcontainer)
>>      }
>> }
>>
>> -static VFIOIOMMUOps vfio_iommu_spapr_ops;
>> -
>> -static void setup_spapr_ops(VFIOContainerBase *bcontainer)
>> -{
>> -    vfio_iommu_spapr_ops = *bcontainer->ops;
>> -    vfio_iommu_spapr_ops.add_window =
>> vfio_spapr_container_add_section_window;
>> -    vfio_iommu_spapr_ops.del_window =
>> vfio_spapr_container_del_section_window;
>> -    vfio_iommu_spapr_ops.release = vfio_spapr_container_release;
>> -    bcontainer->ops = &vfio_iommu_spapr_ops;
>> -}
>> -
>> -int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
>> +static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
>> +                                      Error **errp)
>> {
>> -    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>> +                                            bcontainer);
>>      VFIOSpaprContainer *scontainer = container_of(container,
>> VFIOSpaprContainer,
>>                                                    container);
>>      struct vfio_iommu_spapr_tce_info info;
>> @@ -536,8 +527,6 @@ int vfio_spapr_container_init(VFIOContainer
>> *container, Error **errp)
>>                            0x1000);
>>      }
>>
>> -    setup_spapr_ops(bcontainer);
>> -
>>      return 0;
>>
>> listener_unregister_exit:
>> @@ -546,3 +535,24 @@ listener_unregister_exit:
>>      }
>>      return ret;
>> }
>> +
>> +static void vfio_iommu_spapr_class_init(ObjectClass *klass, void *data)
>> +{
>> +    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
>> +
>> +    vioc->add_window = vfio_spapr_container_add_section_window;
>> +    vioc->del_window = vfio_spapr_container_del_section_window;
>> +    vioc->release = vfio_spapr_container_release;
>> +    vioc->setup = vfio_spapr_container_setup;
>> +};
>> +
>> +static const TypeInfo types[] = {
>> +    {
>> +        .name = TYPE_VFIO_IOMMU_SPAPR,
>> +        .parent = TYPE_VFIO_IOMMU_LEGACY,
>> +        .class_init = vfio_iommu_spapr_class_init,
>> +        .class_size = sizeof(VFIOIOMMUClass),
> 
> Inherit parent class_size is enough? Otherwise,

yes.


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



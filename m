Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E217DC819
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 09:22:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxk0D-0005yv-Sr; Tue, 31 Oct 2023 04:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxk0C-0005ym-7B
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxk0A-0007qz-M1
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 04:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698740489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mcWfoaH9mT7XkhH32fanQhCpM32Ni7Yd1mRTvY9rpXI=;
 b=AM9f5vVVTTuEE0fscX8Q+Mba+7CWBlE9JFbNmMIrQ+CQwlnaB4PZErlGGbVqnBJEpckMPX
 ML055pRGq7WaQsp76kOBEkMWliQuzryRKralH2HrVOBCsJHqjynq6Sj1WtByqv2R/Vm2DL
 Q0GEwduPcAZwmzVHYAixT4LmXe3NA94=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-oRNinswpNy-xvzyT18Je2w-1; Tue, 31 Oct 2023 04:21:27 -0400
X-MC-Unique: oRNinswpNy-xvzyT18Je2w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-670991f8b5cso48392056d6.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 01:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698740487; x=1699345287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mcWfoaH9mT7XkhH32fanQhCpM32Ni7Yd1mRTvY9rpXI=;
 b=JRI7Tq/rcNCSvJNgeXfWurn8hadRvQA/JK38R0Ah1KiD83L7DjbCcX7hfLf7WPjWBD
 Z2au1o2bYegbnfGrEx0o5fuJcxNjA4cOF+2fc4fXUbjA1q66hwkGj4A3uoO91khWMB+1
 hG6MaoqwHvZqy+osdIIdq2yKlip2s4ZKo6ao6hxXVxYmdk3YqGrBNsSauw28EejB3vRo
 CgA0sgITbrkIvJPhXm9/syo4hWyNeBWSOfzk6S6IzKj2z8/NjwKBerNF7vaxmxUZKPho
 SeODbo9RcbUcI2R3nb7cBcJUJ2UV+Tldfrd2VlZDDwW0OF8PAyDCRXY9EoMw3ODPdZZ4
 Q37w==
X-Gm-Message-State: AOJu0Yxr1JhU0UQpI6CkOfoBe+b5+hny1xeFhQNdCDTqYb1rh0HguITg
 Pe8PyfQLGgu+kuZ5nVGyeTdeIT/M/lg6wjfCTsA/M8gxjMy481CXxLU8G+Pjd9lWl4iYW9E49yp
 OsQ5EG36r4SGE4fM=
X-Received: by 2002:a05:6214:2308:b0:66f:a356:b5dc with SMTP id
 gc8-20020a056214230800b0066fa356b5dcmr2758554qvb.12.1698740487236; 
 Tue, 31 Oct 2023 01:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEfnFXyhzJpiW7GgQ0n5XgGcoayTanloxKWA9l4Xyj7j5Nu6zObANKpdGsIf9YKonnjPkx8g==
X-Received: by 2002:a05:6214:2308:b0:66f:a356:b5dc with SMTP id
 gc8-20020a056214230800b0066fa356b5dcmr2758549qvb.12.1698740487021; 
 Tue, 31 Oct 2023 01:21:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a0cf9d1000000b00674648411b3sm330098qvo.132.2023.10.31.01.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 01:21:26 -0700 (PDT)
Message-ID: <105c633f-bffc-47c9-b7a5-5c4bbdbea85e@redhat.com>
Date: Tue, 31 Oct 2023 09:21:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/37] vfio/container: Introduce a empty VFIOIOMMUOps
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-8-zhenzhong.duan@intel.com>
 <c475bb0c-02be-48d6-8219-0822189c9f2d@redhat.com>
 <SJ0PR11MB67446E8BAFECC739CDA9426292A1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67446E8BAFECC739CDA9426292A1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/30/23 03:43, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, October 27, 2023 10:21 PM
>> Subject: Re: [PATCH v3 07/37] vfio/container: Introduce a empty
>> VFIOIOMMUOps
>>
>> On 10/26/23 12:30, Zhenzhong Duan wrote:
>>> This empty VFIOIOMMUOps named vfio_legacy_ops will hold all general
>>> IOMMU ops of legacy container.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-common.h | 2 +-
>>>    hw/vfio/container.c           | 5 +++++
>>>    2 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index d8f293cb57..8ded5cd8e4 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -255,7 +255,7 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup)
>> VFIOGroupList;
>>>    typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>>>    extern VFIOGroupList vfio_group_list;
>>>    extern VFIODeviceList vfio_device_list;
>>> -
>>> +extern const VFIOIOMMUOps vfio_legacy_ops;
>>
>>
>> why does it need to be external ?
> 
> It is referenced by vfio_connect_container() and vfio_attach_device().

Yes. I realized that later on.

The backend is chosen when the device id attached :
   
     int vfio_attach_device(char *name, VFIODevice *vbasedev,
                            AddressSpace *as, Error **errp)
     {
         const VFIOIOMMUOps *ops;
   
         if (vbasedev->iommufd) {
             ops = &vfio_iommufd_ops;
         } else  {
             ops = &vfio_legacy_ops;
         }
         return ops->attach_device(name, vbasedev, as, errp);
     }

To be noted that we don't need the backend ops but the attach_device()
handler only.

And then, the backend ops is assigned to the base container deeper
in the call stack with vfio_container_init(), which is a bit like a
chicken and egg problem to me.

     vfio_legacy_ops.attach_device = vfio_legacy_attach_device()
       vfio_get_group()
         vfio_connect_container()
            vfio_container_init(&vfio_legacy_ops)
   
     vfio_iommufd_ops.attach_device = iommufd_attach_device()
       vfio_container_init(&vfio_iommufd_ops)
   
vfio_legacy_attach_device() and iommufd_attach_device() are similar but
have different requirements. I don't see a good alternative. Unless we
introduce a QOM object wrapping the IOMMUFDBackend and the legacy one
to hold the VFIOIOMMUOps struct. Looks overkill.

Thanks,

C.



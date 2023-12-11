Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDB180CC31
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:58:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgnF-00016C-5H; Mon, 11 Dec 2023 08:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rCgnD-00015s-6P
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:57:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rCgnB-0006J6-KB
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702303072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1t80YvjtJh+rZxxzUiNfWsthwZU5XCdMfUX5x5ZBsVs=;
 b=FmxuPLknCA981RLGJez3TZ4W2KzoWj8Z26bQ4sswL2uLOiLhR0lNtBjnMOkqiD+dA6wSQs
 Q2BiwQ0pz5dMj658oJ1pZYRQOG7Jb/AxX/2p+86ZXjt3jDBzI5luadLfwtAGrW9meioS1z
 mV9NGEISalf3ipUkoO0BpoB4mzowbT4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-_xJBlsSwNjubTcX1bAgQnA-1; Mon, 11 Dec 2023 08:57:51 -0500
X-MC-Unique: _xJBlsSwNjubTcX1bAgQnA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5d3911218b3so52225527b3.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702303071; x=1702907871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1t80YvjtJh+rZxxzUiNfWsthwZU5XCdMfUX5x5ZBsVs=;
 b=B4L1J/hiEJ/bK9OinOZuBcy3l5OhHw3Zjl3UjiPtZ7BijjGbG7gg9kjLkfRlmv+s1s
 pZ8Psqf5HTCTMqYEYw04poGS08XPTYj4HtgJ+Vvnl36uu3POMCC5jZdlenxzdsXagVtk
 xFBOL52ayWUpprQ/zUyQMpIvLoLxdVXF8Kj+zeL84GrLjjlhgwnPZWwnfq5EIdixlMO1
 VtCVNZs9kvtHXo7o4mofJb3GsfEYqJH49loPuWdFafKQLklPJzb96ufkGYBpE8iqZI6R
 St3UK6l4GKkIXLcUUOEKAYpZaey4vmpEovWQFtw8Onkfsd3SLc52NrOoLZMG4A0Mi86l
 fYiA==
X-Gm-Message-State: AOJu0Yxc93QT7dvDRs37tNDrshDgJaE86CbB9Sw3H0JdsO5HlzHW5vlE
 7XXRTu+zHGNIfiLx+4c65byANJ8KZP5cyjtCbGbsX+DNU3wcgNoFnVsSCbeEo80lrRwT0zcObmt
 R1nJ0y+JaxA83i3M=
X-Received: by 2002:a05:6902:2ca:b0:dbc:b01c:6794 with SMTP id
 w10-20020a05690202ca00b00dbcb01c6794mr175252ybh.115.1702303070880; 
 Mon, 11 Dec 2023 05:57:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmFEhScK25nhHpq5pqsdWHsGE2hrxxEpUbeQY4RnWee5VuabJb8Bqc4lBTG9sogIn8gH1zwA==
X-Received: by 2002:a05:6902:2ca:b0:dbc:b01c:6794 with SMTP id
 w10-20020a05690202ca00b00dbcb01c6794mr175245ybh.115.1702303070599; 
 Mon, 11 Dec 2023 05:57:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 e7-20020ad442a7000000b0067cd743328csm3301214qvr.81.2023.12.11.05.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 05:57:50 -0800 (PST)
Message-ID: <a86f5186-9600-4360-8f4d-4133c57ea5cf@redhat.com>
Date: Mon, 11 Dec 2023 14:57:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 03/10] vfio/container: Initialize VFIOIOMMUOps
 under vfio_init_container()
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-4-clg@redhat.com>
 <SJ0PR11MB6744ADC5CD40D8CF8013EEA8928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744ADC5CD40D8CF8013EEA8928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
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

On 12/11/23 06:59, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, December 8, 2023 4:46 PM
>> Subject: [PATCH for-9.0 03/10] vfio/container: Initialize VFIOIOMMUOps
>> under vfio_init_container()
>>
>> vfio_init_container() already defines the IOMMU type of the container.
>> Do the same for the VFIOIOMMUOps struct. This prepares ground for the
>> following patches that will deduce the associated VFIOIOMMUOps struct
>>from the IOMMU type.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> hw/vfio/container.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index
>> afcfe8048805c58291d1104ff0ef20bdc457f99c..f4a0434a5239bfb6a17b91c8
>> 879cb98e686afccc 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -370,7 +370,7 @@ static int vfio_get_iommu_type(VFIOContainer
>> *container,
>> }
>>
>> static int vfio_init_container(VFIOContainer *container, int group_fd,
>> -                               Error **errp)
>> +                               VFIOAddressSpace *space, Error **errp)
>> {
>>      int iommu_type, ret;
>>
>> @@ -401,6 +401,7 @@ static int vfio_init_container(VFIOContainer
>> *container, int group_fd,
>>      }
>>
>>      container->iommu_type = iommu_type;
>> +    vfio_container_init(&container->bcontainer, space, &vfio_legacy_ops);
> 
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> Not related to this patch, not clear if it's deserved to rename
> vfio_container_init as vfio_bcontainer_init to distinguish
> with vfio_init_container.

I agree, the vfio_container_init() and vfio_init_container() names
are confusing. I would keep vfio_container_init() because it is
consistent with all routines handling 'VFIOContainerBase *' ops.

I would be tempted to rename vfio_init_container() to vfio_set_iommu() ?

Also, I will introduce a vfio_connect_setup() helper in v2 doing the
assert as the other routines.

Thanks,

C.





> 
> Thanks
> Zhenzhong
> 
>>      return 0;
>> }
>>
>> @@ -583,9 +584,8 @@ static int vfio_connect_container(VFIOGroup *group,
>> AddressSpace *as,
>>      container = g_malloc0(sizeof(*container));
>>      container->fd = fd;
>>      bcontainer = &container->bcontainer;
>> -    vfio_container_init(bcontainer, space, &vfio_legacy_ops);
>>
>> -    ret = vfio_init_container(container, group->fd, errp);
>> +    ret = vfio_init_container(container, group->fd, space, errp);
>>      if (ret) {
>>          goto free_container_exit;
>>      }
>> --
>> 2.43.0
> 



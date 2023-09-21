Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C45777A9484
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:08:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJOx-000174-7Q; Thu, 21 Sep 2023 09:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjJOo-0000XW-Ip
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjJOi-0005So-UG
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695301629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nWzMB2T3IOLytLd/Iu4RJxDn+Mb4TRIyCIkRSPVbRZw=;
 b=IHa5ZYciNq1QMZr9bO/7o4iBhAFIWgM7hymXXNgejhUTksdW7lqwTToqsAILE8oe2wE/mg
 CH/UeSkZXXpesnL0CbJx6vcSQCJrKIjU14DvKYvDY8pbeIQ7yQKaI+nv8gEtgwFiKxCzyZ
 Tassot/GXoBHGVRihT4K2n/pdAXSTY0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-EzkhPn4hOSSDGim-LdN9XQ-1; Thu, 21 Sep 2023 06:53:52 -0400
X-MC-Unique: EzkhPn4hOSSDGim-LdN9XQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6563d523671so14317306d6.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 03:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695293632; x=1695898432;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nWzMB2T3IOLytLd/Iu4RJxDn+Mb4TRIyCIkRSPVbRZw=;
 b=vo6UIuP+NlY2cS2HXQirN7jn4I93Wj+ylv2ty2T3d1qddMB2Glb0FEg+Gzz5J9WMxW
 GdjxyBbfZxjza8KTsKroeKw0X51rq2L8KrZjmx9WKoBR9BxM3M/vIql6xxkCHgBk8dSz
 pECfZwBSkh/0xs2CggTTC/LD2B5BQpTcOI1gjz2gCiDshoTClFtt+LAYchYz2+GE0n03
 zhVrQ46nLAJHp4my5pOnSEKvCbt8Chd+IVkuWn2VtT9qdWiAG19uts3JiskGT5qWdBo0
 CH6Ekiamh/TEFQjILa0Sk3p47WBwcj1MhmR67XikH0EIHX0FcZ7sRK+YFUXACsxXThd/
 JQ1A==
X-Gm-Message-State: AOJu0Yx0dg4Aj2CvWYLX21ceh8gNnvAfMA/y7T3BSKUs/S84iUcbjc7M
 Rtq8HKskTbgTc32msswiEu7YIEa0PqIu4dvnhAH2t7rmsxdUflkHqwN7z6sCaC822lYZfj9d4iB
 OnRlAqyznfL5cdOQ=
X-Received: by 2002:a0c:b445:0:b0:656:46ed:8a46 with SMTP id
 e5-20020a0cb445000000b0065646ed8a46mr6328262qvf.31.1695293632049; 
 Thu, 21 Sep 2023 03:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeGiQ22Mux9rcwgA9Owmy4g7h1yo7l9DHuV22gddWe0q28C44DIo2MhhVeVOlJHrlDxPw6lw==
X-Received: by 2002:a0c:b445:0:b0:656:46ed:8a46 with SMTP id
 e5-20020a0cb445000000b0065646ed8a46mr6328250qvf.31.1695293631821; 
 Thu, 21 Sep 2023 03:53:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a0cf24f000000b0064f72988fecsm460309qvl.127.2023.09.21.03.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 03:53:51 -0700 (PDT)
Message-ID: <95ab51c2-be14-3272-11b3-48ee3e65b9a4@redhat.com>
Date: Thu, 21 Sep 2023 12:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 05/22] vfio/common: Extract out
 vfio_kvm_device_[add/del]_fd
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-6-zhenzhong.duan@intel.com>
 <127c3104-44e0-f19f-6339-43182fbf6db1@redhat.com>
 <95befe1b-efb4-82f9-3cf8-fe703378617f@redhat.com>
 <SJ0PR11MB674493761CD31BBE53753DC192F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB674493761CD31BBE53753DC192F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 9/21/23 12:22, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Thursday, September 21, 2023 4:42 PM
>> Subject: Re: [PATCH v1 05/22] vfio/common: Extract out
>> vfio_kvm_device_[add/del]_fd
>>
>> On 9/20/23 13:49, Eric Auger wrote:
>>> Hi Zhenzhong,
>>>
>>> On 8/30/23 12:37, Zhenzhong Duan wrote:
>>>> ...which will be used by both legacy and iommufd backend.
>>> I prefer genuine sentences in the commit msg. Also you explain what you
>>> do but not why.
>>>
>>> suggestion: Introduce two new helpers, vfio_kvm_device_[add/del]_fd
>>> which take as input a file descriptor which can be either a group fd or
>>> a cdev fd. This uses the new KVM_DEV_VFIO_FILE VFIO KVM device group,
>>> which aliases to the legacy KVM_DEV_VFIO_GROUP.
>>
>> Ah yes. I didn't understand why the 's/GROUP/FILE/' change in the
>> VFIO KVM device ioctls. Thanks for clarifying.
>>
>> What about pre-6.6 kernels without KVM_DEV_VFIO_FILE support ?
> They are purely alias. See below commit:

Ah. I missed that. thanks again.

C.



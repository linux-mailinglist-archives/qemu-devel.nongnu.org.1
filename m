Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7365D7D47C2
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 08:53:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvBGt-0003Hj-NB; Tue, 24 Oct 2023 02:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qvBGq-0003HS-2l
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qvBGo-0008CQ-GS
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 02:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698130326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q305Vt0an7A6aTCpGXpn6LMvochP5S9jNvAc2VB8Bp4=;
 b=FhfdgPWyJ0D24+AdJh8eqKP+2mGZMKRhLCJBKK8dEspdgBKxURBlNq9TYQnaE0w4VgLQpv
 REygZJOsSFBpvVA7PAd1pHx3XVbqjVb71vn8xpso8SB0uyRYwsbKbtVtLMrbnyYiobc4E6
 9aUBtwe6PlNGi2P9+XCwN895glnL/KU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-rxqWiC5SM-u0hQPCXSVJ7Q-1; Tue, 24 Oct 2023 02:52:02 -0400
X-MC-Unique: rxqWiC5SM-u0hQPCXSVJ7Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d0ceb78cbso52701036d6.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 23:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698130322; x=1698735122;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q305Vt0an7A6aTCpGXpn6LMvochP5S9jNvAc2VB8Bp4=;
 b=d/Pza9naxgoLkbe7kFYbhYAwlGaQHqP9hode4YPI6ecwblD4DZ4NJyl9B/sSu/rGcC
 3SM33Y12EA5ITvkp+kNBlkhFgGY71PCrh0A0V2EgwZgW/OtG2gM3o2HWAQQSLKPQuSbw
 3bnX6Buk8H+4aC6n5nudUlXTgsNoxIG7HNJE2CDX2Gmdhi1qpzU8VYayQp9GlKLQLISQ
 0oqEeDD7I7K/8Jj++fD2Mjn8aWqO0tlpgkNa9PdMKOW7xUSTJWTciJqA80ZcWYtfDvgE
 sXltzy2LMey2JdcHiFigon8dAvhAFXbmxrFTeVmentZ24qGm3XWnwbR+IbuptgWojDan
 aG8Q==
X-Gm-Message-State: AOJu0YyEcR3dYqkmlLZ92upQLYCYX9cV1wyPa/hYPLJ1mX28eoNX4Gdv
 /ovUnGjpcqCX0cIK2MNLdJYO9Y9nD13rENqDSPusxSdEloAiX1wqF700+4PEJJw/ZGFM3fYRTNE
 Nwxq7nKVL/uNsJng=
X-Received: by 2002:ad4:5de6:0:b0:66d:25b6:82b2 with SMTP id
 jn6-20020ad45de6000000b0066d25b682b2mr11863466qvb.57.1698130321880; 
 Mon, 23 Oct 2023 23:52:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjwCHnKK/yno5OUJY56XFD+m839xTXudhjdBFOOV9lsQ0FtsJdGlWE0zOQyVNfeemLaUdm2g==
X-Received: by 2002:ad4:5de6:0:b0:66d:25b6:82b2 with SMTP id
 jn6-20020ad45de6000000b0066d25b682b2mr11863452qvb.57.1698130321640; 
 Mon, 23 Oct 2023 23:52:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 bt12-20020ad455cc000000b00655e428604esm3418877qvb.137.2023.10.23.23.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 23:52:01 -0700 (PDT)
Message-ID: <6eff67ad-17f4-4614-8e74-3a54f9b53a7d@redhat.com>
Date: Tue, 24 Oct 2023 08:51:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
 and targetted interface
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
 <3573353d-5153-2678-e121-33cf20798aa6@redhat.com>
 <759053f1-995b-4238-b0be-bace84a1249c@redhat.com>
 <PH7PR11MB6722A19603BF7CB244BBB27A92DFA@PH7PR11MB6722.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <PH7PR11MB6722A19603BF7CB244BBB27A92DFA@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Zhenzhong,

>>> you would need to do that for all types for vfio devices, ap, ccw,
>>> platform. Looks heavy to me. Why would we need to use a different
>>> vfio-pci-* device while we could switch the iommu backend according to
>>> the "iommufd" prop presence. The initial discussion was about QOMyfying
>>> the container instead.
>>
>> yes.
>>
>> I took a closer look at the first part which adds the backend ops,
>> including patch 19 adding the iommufd backend, not saying that I have
>> identified all the dark corners.
>>
>> A QOM-like design would have introduced a VFIOLegacyContainer,
>> inheriting from VFIOContainer (same for VFIOIOMMUFDContainer) with a
>> VFIOContainerClass to implement the specific backend ops.
>> VFIOspaprContainer would have made sense also.
>>
>> But QOM doesn't seem well adapted for the current needs. So let's try
>> a simpler approach. It seems that VFIOIOMMUBackendOpsClass is
>> useless. IMO, it could be a callbacks structure like we have for
>> memory regions initialized with vfio_container_init(). This would
>> remove some noise around the QOM typeinfo definitions.
> 
> Yes, good suggestion, will do.
>
Thanks,

>>
>> 'struct vfio_iommu_ops' reads/sounds like a good name.

This should be read as VFIOIOMMUOps :)

>> Can we try that in a v3 ? It should not be such an earthquake.
> 
> Sure.
> 
>>
>> spapr has some singularities which would be good to isolate in a
>> vfio_iommu_spapr_ops to remove all the VFIO_SPAPR_TCE_*_IOMMU code in
>> container.c. vfio_legacy_{add,del}_section_window are SPAPR specific.
> 
> Yes, let me try it.

There is a large amount of spapr code in container.c. If it could
be moved under its own backend (and in hw/ppc/spapr_pci_vfio.c),
we would have two backends : spapr and legacy. We could possibly
merge this first part in 8.2.

I have access to a PPC P9 system. I can make sure we are not breaking
support.

C.



> Thanks
> Zhenzhong
>>
>> FYI, I did some adjustements bc of the recent introduction of iova_ranges
>> in my branch :
>>
>>   https://github.com/legoater/qemu/commits/vfio-8.2
>>
>> Thanks,
>>
>> C.
>>
> 



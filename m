Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 366BC7DC8E3
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:02:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkd6-0007ti-Tt; Tue, 31 Oct 2023 05:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxkd5-0007tV-HI
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxkd4-0006nX-13
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IrnTTC4sbhWTq5eiFFX4YiwVoPDnXe1yJuzqYGKWYUg=;
 b=T77FPrgpNctYfhuQAKFG/Mdn7WBciMmJ++qlrkD+x33tE+Veh0ENZydVgofpjDUIo08ak1
 M6wk5MNWycn9nWr1+Yw1fH/m9r3UWGmXjQfPvt63UwFPTx5wWzWwQStYab3zIlW1yvBSVl
 DjTd4RkeDugg/FH0K9n4cqnEfKlhZ+A=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-A4Jb1h5gMlC-jyp1kkrOaw-1; Tue, 31 Oct 2023 05:01:28 -0400
X-MC-Unique: A4Jb1h5gMlC-jyp1kkrOaw-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1e987fa0d87so7392437fac.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 02:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698742888; x=1699347688;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IrnTTC4sbhWTq5eiFFX4YiwVoPDnXe1yJuzqYGKWYUg=;
 b=pmFuYMgh2uUbq/MfWfYtdCpn1+k6lBL1ODu2I6bTlb7x2+JQJ1QFOCao+w3C2eTXtP
 0ce9j1pT0WuOSNmxsNZsqjw4ZypRbkIWfVctllkF957RxhO62/rk1kONQDCrbS6tBmU+
 Jqq/WFqTWyaoOmin+d+2DnXMjQptqDTBemwU748iJkEWlQMhr1RtDxikuuM9TCWp44NC
 DwtNzXc1mbF0upWURKN6tnvpYt484Jb5f0Eom/3jMb1nteX8cUkcXNDzOWOg1WwEYHt4
 j0KvXd/EttcuJ5fwcTEvF6l/YUONz/hVYkJ3YWyETfezOF/h0Avkd6G1cDKIzcYADiuG
 T0CQ==
X-Gm-Message-State: AOJu0YwPLAq1oYq2O2FYx2kOg001nFbdNRzAxApVHldwwpfEAwWgKs4U
 45ET0lWmMkf4uU0dh/jXezce0nHH8/oN+ZPmtJ23VcVYqWKsToICm70lb6ihAhe6Ei1Fp5f99SU
 pFvCcFECIRYt2BHA=
X-Received: by 2002:a05:6870:10d1:b0:1dc:d8c6:39f with SMTP id
 17-20020a05687010d100b001dcd8c6039fmr13029324oar.14.1698742888167; 
 Tue, 31 Oct 2023 02:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ9p4wCzvYYCNvTB077BCs7+AKhCi1BvZKvedjSQlofnoPqk7bCjgITFdq1wsFstAJRKmSlw==
X-Received: by 2002:a05:6870:10d1:b0:1dc:d8c6:39f with SMTP id
 17-20020a05687010d100b001dcd8c6039fmr13029291oar.14.1698742887673; 
 Tue, 31 Oct 2023 02:01:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a056214012f00b0065d1380dd17sm353368qvs.61.2023.10.31.02.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 02:01:27 -0700 (PDT)
Message-ID: <183a9b3f-bc01-4feb-8663-f3777de62288@redhat.com>
Date: Tue, 31 Oct 2023 10:01:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/37] vfio/iommufd: Bypass EEH if iommufd backend
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
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-30-zhenzhong.duan@intel.com>
 <9e5a2eaf-4703-4797-8305-05baee9d7de4@redhat.com>
 <SJ0PR11MB67448F476F129A500E2F623D92A0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67448F476F129A500E2F623D92A0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/31/23 03:26, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Monday, October 30, 2023 9:57 PM
>> Subject: Re: [PATCH v3 29/37] vfio/iommufd: Bypass EEH if iommufd backend
>>
>> On 10/26/23 12:30, Zhenzhong Duan wrote:
>>> IBM EEH is only supported by legacy backend currently, bypass it
>>> for IOMMUFD backend.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/ppc/spapr_pci_vfio.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
>>> index d1d07bec46..a2518838a1 100644
>>> --- a/hw/ppc/spapr_pci_vfio.c
>>> +++ b/hw/ppc/spapr_pci_vfio.c
>>> @@ -93,10 +93,10 @@ static VFIOContainer
>> *vfio_eeh_as_container(AddressSpace *as)
>>>
>>>        bcontainer = QLIST_FIRST(&space->containers);
>>>
>>> -    if (QLIST_NEXT(bcontainer, next)) {
>>> +    if (QLIST_NEXT(bcontainer, next) || bcontainer->ops != &vfio_legacy_ops) {
>>
>> It's curious that a test on the VFIOIOMMUOps is needed so deep in
>> the software stack, and spapr should have its own VFIOIOMMUOps, which
>> de facto doesn't support iommufd.
> 
> Yes, in this series, spapr shares same ops vfio_legacy_ops, in next series I should
> check with vfio_iommu_spapr_ops.

Well, since PPC doesn't support IOMMUFD it should be tested before or compile
out as suggested on patch 23 "Add iommufd configure option"

Thanks,

C.


> The general vfio-pci device supports iommu property, if we pass a vfio device
> with iommufd backend, I guess we will crash Qemu if there is no check here.
> 
> Thanks
> Zhenzhong
> 



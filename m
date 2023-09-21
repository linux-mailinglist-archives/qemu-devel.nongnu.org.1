Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE397A974B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:22:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNLv-0003pm-UN; Thu, 21 Sep 2023 13:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qjNLt-0003pE-IY
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:20:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qjNLq-0004TJ-Rf
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695316827;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOEiNYWiDMhnUiv7h9JA99u6yPkZMLplllJKFS92O2Q=;
 b=akM+KVMe0z7wEU+Awxmg8OE6W3UaC0SjFaqSP/mk/DC651oN7em299RvrcQT+S0guP0nGh
 +RdpF3j8IlvBhYn3SeP97FwkidtwXNRPxJChEm1gcTN78kSyCxBXEgy6b3PDWXXZiQl1w/
 1b2GTmzYvHPrNIofsKGihJ1t+a+TO3k=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-Bmy3s9OdPVyyjM8tpaoEcg-1; Thu, 21 Sep 2023 13:20:24 -0400
X-MC-Unique: Bmy3s9OdPVyyjM8tpaoEcg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6563d523671so18503086d6.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695316823; x=1695921623;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uOEiNYWiDMhnUiv7h9JA99u6yPkZMLplllJKFS92O2Q=;
 b=R9KkgwxFNE177VuoWUyRP32RsFwmcugku4dKMAXJMCJCOrPojHscwyBto/U9syoytk
 FEJi0AcziM8uZ2TJImsBVrFUTQwHywXJS9yvKUH9aAb9x6bU67C8+vM1nSP8ermRLPHx
 yjZhh+TSXjM/vSoxBcGFB+YDVf6YhfTwRMpqTiLLBcaUmAtvyjt/sOIRZXG9QeZ07vgJ
 kR0s5aQeVvj0AyL1cwW/NUScVUTp+KoQ4nN6EluSnq/rw+/vZv6+YXdQo1oLeGUX7IlV
 yQPhhuokyhPT9C8NKL526e5Yt+W3bJbNXkHch1QkhqBXstPWsp0leqS85hj1CjDiTVq0
 cj6Q==
X-Gm-Message-State: AOJu0YxkAg198hIjelsLjdCmJ9N23qrBoYBL0TTL8cAvng8/r3P8hPvE
 6WR5AF3UHpJaZO6dKBCBr8+jG/3Wzt7o0D+8Pq3ysv7MS6UZJiJBgD2KlO3LC5groH+DIV7knr1
 UEA8/7lLGaBLBIbE=
X-Received: by 2002:a05:6214:ccf:b0:63c:f325:bb03 with SMTP id
 15-20020a0562140ccf00b0063cf325bb03mr513200qvx.8.1695316823565; 
 Thu, 21 Sep 2023 10:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKpZAH2W/X+fT6Pz4B3SsxN5U60P2gSEiYwKos35b/0fXDjwwq6AYH7uOSLFK3Iyb7tDQ1kA==
X-Received: by 2002:a05:6214:ccf:b0:63c:f325:bb03 with SMTP id
 15-20020a0562140ccf00b0063cf325bb03mr513165qvx.8.1695316823247; 
 Thu, 21 Sep 2023 10:20:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a0cdc06000000b006563c0aa959sm730665qvk.13.2023.09.21.10.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 10:20:22 -0700 (PDT)
Message-ID: <0904e417-6201-a994-6507-60c44ba8efcd@redhat.com>
Date: Thu, 21 Sep 2023 19:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 13/22] vfio: Add base container
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
 Yi Sun <yi.y.sun@linux.intel.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-14-zhenzhong.duan@intel.com>
 <eb3c51e0-d1ba-1452-6f85-786f7c36411a@redhat.com>
 <14853056-3742-8cfe-f8b7-cdb8ea05a846@redhat.com>
 <SJ0PR11MB6744CFAAC37534C158BE484192F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744CFAAC37534C158BE484192F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Zhenzhong,
On 9/21/23 05:35, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Thursday, September 21, 2023 1:31 AM
>> Subject: Re: [PATCH v1 13/22] vfio: Add base container
>>
>> Hi Zhenzhong,
>>
>> On 9/19/23 19:23, Cédric Le Goater wrote:
>>> On 8/30/23 12:37, Zhenzhong Duan wrote:
>>>> From: Yi Liu <yi.l.liu@intel.com>
>>>>
>>>> Abstract the VFIOContainer to be a base object. It is supposed to be
>>>> embedded by legacy VFIO container and later on, into the new iommufd
>>>> based container.
>>>>
>>>> The base container implements generic code such as code related to
>>>> memory_listener and address space management. The VFIOContainerOps
>>>> implements callbacks that depend on the kernel user space being used.
>>>>
>>>> 'common.c' and vfio device code only manipulates the base container with
>>>> wrapper functions that calls the functions defined in
>>>> VFIOContainerOpsClass.
>>>> Existing 'container.c' code is converted to implement the legacy
>>>> container
>>>> ops functions.
>>>>
>>>> Below is the base container. It's named as VFIOContainer, old
>>>> VFIOContainer
>>>> is replaced with VFIOLegacyContainer.
>>> Usualy, we introduce the new interface solely, port the current models
>>> on top of the new interface, wire the new models in the current
>>> implementation and remove the old implementation. Then, we can start
>>> adding extensions to support other implementations.
>>>
>>> spapr should be taken care of separatly following the principle above.
>>> With my PPC hat, I would not even read such a massive change, too risky
>>> for the subsystem. This path will need (much) further splitting to be
>>> understandable and acceptable.
>> We might split this patch by
>> 1) introducing VFIOLegacyContainer encapsulating the base VFIOContainer,
>> without using the ops in a first place:
>>  common.c would call vfio_container_* with harcoded legacy
>> implementation, ie. retrieving the legacy container with container_of.
>> 2) we would introduce the BE interface without using it.
>> 3) we would use the new BE interface
>>
>> Obviously this needs to be further tried out. If you wish I can try to
>> split it that way ... Please let me know
> Sure, thanks for your help, glad that I can cooperate with you to move
> this series forward.
> I just updated the branch which rebased to newest upstream for you to pick at https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_cdev_v1_rebased 

I have spent most of my day reshuffling this single patch into numerous
ones (16!). This should help the review.
I was short of time. This compiles, the end code should be identical to
the original one. Besides this deserves some additional review on your
end, commit msg tuning, ...

But at least it is a move forward. Feel free to incorporate that in your
next respin.

Please find that work on the following branch

https://github.com/eauger/qemu/tree/iommufd_cdev_v1_rebased_split

Thanks

Eric
>
> Thanks
> Zhenzhong



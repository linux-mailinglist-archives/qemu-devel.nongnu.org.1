Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F927A91C8
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 08:29:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjDB9-00087U-En; Thu, 21 Sep 2023 02:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qjDB3-000855-U6
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qjDAz-0001hz-QF
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695277716;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qBo8TfYPacOI6MRRTA9hmy+3EfGZH0rZkSTPlpLZqx0=;
 b=Oa6VIXplymn10z/bqHV+DAi0S8VBHhN3hDch+t4C243TvUt80ma9C4Dgvp99l/y85o9tFy
 2T60N4Yse6gOimPHnKFW8f8kDhPZuyWerCWxjBepKZyOzuLd6a4JFRHFadKtx10UKgIbMn
 ZNiGlCvU7XG+SAmP2p2ZMSX1kYH5bp0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-h8j7YMc4NXmOG2pkJI_39Q-1; Thu, 21 Sep 2023 02:28:34 -0400
X-MC-Unique: h8j7YMc4NXmOG2pkJI_39Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-404f81fe7cfso7156945e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 23:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695277713; x=1695882513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qBo8TfYPacOI6MRRTA9hmy+3EfGZH0rZkSTPlpLZqx0=;
 b=s2F0WFlyYZ3zantpusSo4/raDVDx24rMQ6Qv9nxOkS1clNM4LesYPfer+sooCcMfF+
 O2pcIOCbDQpeAAS1dxq4Hb4rFiGRz9jmV13jJWp69tr9KqfaBrpbG3TR0Q8CucCwusUI
 UOPeeckdylmk8BqMyXaceFvvi09nyRy0Gxl9/fGpjUcPyDWqRJMswnShi3ACVcbeGCdl
 gLd9cOgwbH3wIhZRgIOZAANAJAHue7iCxGkPPnH2Uko9a7qVisNcH14HL8gjlHr7eJm4
 KN9y8TJCo4mJvrJx9iczbqfgOBeHEnoAg27TcLvG18Ubb0A8V2WONE5Zt5PMKMiKXuJi
 oJTg==
X-Gm-Message-State: AOJu0YwTelf5M3JIW7aRt27lVo1xAH1hy8JT3899AzNAFOVfFneTunFw
 NKBC77B2F5JV5o/GggAunDo+f0s8W7F/0Di9AyyS9BFm06kdgmB2MVFr7w/S4I4LJ06mGadfVL1
 DKWtBjBlTeKos27U=
X-Received: by 2002:adf:fc10:0:b0:31f:fc9a:a03 with SMTP id
 i16-20020adffc10000000b0031ffc9a0a03mr6225818wrr.20.1695277713710; 
 Wed, 20 Sep 2023 23:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdwE2+ndNQQp51pEn6s2jScRP1lZHdmrJ1ImPkbBgabWt2WmgrJHmDRxZXJe75Pwm7vHFRJA==
X-Received: by 2002:adf:fc10:0:b0:31f:fc9a:a03 with SMTP id
 i16-20020adffc10000000b0031ffc9a0a03mr6225795wrr.20.1695277713394; 
 Wed, 20 Sep 2023 23:28:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a056000018500b0031980783d78sm799118wrx.54.2023.09.20.23.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 23:28:31 -0700 (PDT)
Message-ID: <7308f588-a1e9-15af-6152-e776e1cfc583@redhat.com>
Date: Thu, 21 Sep 2023 08:28:28 +0200
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


Hi,
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

OK thanks. Let me do the exercise.

Eric
>
> Thanks
> Zhenzhong



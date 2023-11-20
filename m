Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 417527F11E3
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 12:24:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r52MY-0003hA-FD; Mon, 20 Nov 2023 06:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r52MV-0003go-Ib
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 06:22:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r52MS-0005v8-FM
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 06:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700479359;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFkeGT6qs0Z/Jop/Gv7TRkQQ/N/wjzVkt9bNgHoDQXw=;
 b=PPIh170cyXGcQWsL25HcDXdl6e75l6mZp2tfw/+UOdNAmO60wY+ri3CoAHHyDJwo0geRFI
 t82738pzAvKLf1sgVohdWZhZ2rVqTQAX5ruORImEH9R2aQGdCj1pFNI/gjmpksDWcREDws
 SaTC2pRJFDhDuUV84Q0Qcxdh+v0/tn0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-Jno1jBvKN-iFLg4gernoRg-1; Mon, 20 Nov 2023 06:22:34 -0500
X-MC-Unique: Jno1jBvKN-iFLg4gernoRg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-670991f8b5cso30086356d6.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 03:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700479354; x=1701084154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pFkeGT6qs0Z/Jop/Gv7TRkQQ/N/wjzVkt9bNgHoDQXw=;
 b=cVDVDv3etjzPbQIyEQwAINCawpUcIpiQULpxMTijp64ohYhD+f2cSYs9CdImHX7uuX
 2U3la8jx4ipDQz2e5oVtOBJvRRAJ1NoS702P2wQImGSzlatXD2tLX/Y35M0qqDFJBUvD
 nDYeZcDZYNEtAZfCTsZTmVa6bW3dMahJ3iJy3kco3ZlYjbHVPtSA+UU5fnhI/RITI2Ei
 XaNv9NUpVgIhFz25oit4VHiIiB/udsq5L0wWvyLKbNXS1lP2YbwAhwjDs0MzfaEZ6hm0
 NvZrY5fnLU2Gb5qPztjXjEskzFWuKAWmtAYcH3XljE0iGoIVG7vt4od9m/wwz363CUR1
 cZZA==
X-Gm-Message-State: AOJu0YxhyckbOf+B7bA8I2JISxnPkwxxd6bLQCj719pE4R33fy0SibvY
 bPDbTop7nvuYEq0Yx0AwY4TuyzhUhazQzgN78oDwAkOUFq+1dCdZ2clTYQJhIVqjB7E8RNM9odv
 xNSmHA5XRxutt3dw=
X-Received: by 2002:ad4:5f47:0:b0:66d:5cfe:82a6 with SMTP id
 p7-20020ad45f47000000b0066d5cfe82a6mr11822281qvg.27.1700479354495; 
 Mon, 20 Nov 2023 03:22:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGS6F8e6ba4tBkvTM9Fb3sp0+syfcNFAG+vS01VKEed3BY19s4EVe0tfJAWQj3cQBrs/FG9Gg==
X-Received: by 2002:ad4:5f47:0:b0:66d:5cfe:82a6 with SMTP id
 p7-20020ad45f47000000b0066d5cfe82a6mr11822270qvg.27.1700479354245; 
 Mon, 20 Nov 2023 03:22:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 f26-20020ad4559a000000b006710660a548sm2824607qvx.27.2023.11.20.03.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 03:22:33 -0800 (PST)
Message-ID: <f0e43c2b-f2af-4886-9cf6-e522fb531c15@redhat.com>
Date: Mon, 20 Nov 2023 12:22:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/21] vfio: Adopt iommufd
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <ab076809-9441-4933-a948-83fbb0855dd7@redhat.com>
 <SJ0PR11MB6744FD09AC64D1C9B3609DF692B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744FD09AC64D1C9B3609DF692B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhengzhong

On 11/20/23 11:09, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Monday, November 20, 2023 5:15 PM
>> Subject: Re: [PATCH v6 00/21] vfio: Adopt iommufd
>>
>> Hi Zhenzhong,
>>
>> On 11/14/23 11:09, Zhenzhong Duan wrote:
>>> Hi,
>>>
>>> Thanks all for giving guides and comments on previous series, this is
>>> the remaining part of the iommufd support.
>>>
>>> Based on Cédric's suggestion, replace old config method for IOMMUFD
>>> with Kconfig.
>>>
>>> Based on Jason's suggestion, drop the implementation of manually
>>> allocating hwpt and switch to IOAS attach/detach.
>>>
>>> Beside current test, we also tested mdev with mtty for better cover range.
>>>
>>> PATCH 1: Introduce iommufd object
>>> PATCH 2-9: add IOMMUFD container and cdev support
>>> PATCH 10-17: fd passing for cdev and linking to IOMMUFD
>>> PATCH 18: make VFIOContainerBase parameter const
>>> PATCH 19-21: Compile out for IOMMUFD for arm, s390x and x86
>>>
>>>
>>> We have done wide test with different combinations, e.g:
>>> - PCI device were tested
>>> - FD passing and hot reset with some trick.
>>> - device hotplug test with legacy and iommufd backends
>>> - with or without vIOMMU for legacy and iommufd backends
>>> - divices linked to different iommufds
>>> - VFIO migration with a E800 net card(no dirty sync support) passthrough
>>> - platform, ccw and ap were only compile-tested due to environment limit
>>> - test mdev pass through with mtty and mix with real device and different BE
>>>
>>> Given some iommufd kernel limitations, the iommufd backend is
>>> not yet fully on par with the legacy backend w.r.t. features like:
>>> - p2p mappings (you will see related error traces)
>>> - dirty page sync
>>> - and etc.
>> Feel free to add my T-b:
>> Tested-by: Eric Auger <eric.auger@redhat.com>
> Thanks Eric, you mean all the patches or arm part?

Yeah sorry I failed to give details. I have tested on ARM with vfio-pci
atm. So all the generic patches + ARM virt / PCI specific ones. As for
VFIO-PLATFORM I need to resurrect a new environment because I have some
trouble with AMD overdrive which do not expose iommu groups atm. I need
to figure this out or create a new vfio-platform environment to test.
Working on it ...

Thanks

Eric
>
> BRs.
> Zhenzhong



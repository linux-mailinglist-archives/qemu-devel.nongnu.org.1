Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2584836A67
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:26:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRx6v-0001Lm-WB; Mon, 22 Jan 2024 11:25:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rRx6t-0001LK-Vh
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:25:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rRx6s-0007tn-BZ
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705940716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLnvE7beAX9izZsLBFb4i01JsPR7l2jiatekZCgjnLw=;
 b=SGk9c/X/s7vjIB+yk3ydGzfgBR+Dwxy+ZdPtqA1MFW7tAUxOg75uz0NdOi3FLvuzO1jaSf
 BippR85g2P5zQJHWvVlyEvf2nHb26qrs+6xjDCvIfmOnXOX9GzA14fM4jPBTvUmrDh1JAg
 A3xUpvFlidbGHrJOHGrXp06hfF+xCEs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-BtecEeg9PhWAEC-FjIp5hQ-1; Mon, 22 Jan 2024 11:25:15 -0500
X-MC-Unique: BtecEeg9PhWAEC-FjIp5hQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-680139b1990so74300976d6.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705940714; x=1706545514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zLnvE7beAX9izZsLBFb4i01JsPR7l2jiatekZCgjnLw=;
 b=PMya0hBc9ebpjRF8/k+KLNNHf3LjOpoakpIvg7oHwPbiJEvL5DGcNs61voERYmCj+C
 gsUCbCee1wkSaffh0pyI/sdJ9sXR3KJcSdQr/61Y6rrQuthyGsWkZ3cT6BRVC04seulK
 rIsulCSjwWFJZErQo3hBUg7eXlkzXf5g9UKXryoY+x5kNH9oI+NiMvSznMJ5urU3zHum
 TGstTzFqd6v4zr82moZupYhCYwowa7T+XdluMrFYHFLMxdBjnrbDOAZNXOlhbEWHEN1U
 H9gVcDTMRw0lwHBNBpfLDF5ZvmWql7ikC/4yktqtUmGzk7gQckzniPSfATKm9ecPAO+0
 fd5A==
X-Gm-Message-State: AOJu0YwtnAc9uNiC/1HeDlQW3Aq7U6ggCvC0gmKvDRnwU7W2+PJwyFxS
 JhhLzjeqYvJv/s4kmiSTTDdTF9C/eiVRMHmSL7R4wZ8IykpgdnhOtfc66w7hU3eluIEVFbQ+LrI
 aLJR0Z5c3xbVDyX75usmPyzmcY4UkAQRQPcsjvsXxwprXRh0QOyM+
X-Received: by 2002:a05:6214:242f:b0:685:fc61:7060 with SMTP id
 gy15-20020a056214242f00b00685fc617060mr5041947qvb.99.1705940714638; 
 Mon, 22 Jan 2024 08:25:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWSInV92bXDKmmRCyv0rjfkKPjPg+Imriy+NIIsOBLicFkuQtoK4gJOPE2A5aVn//elDXYKg==
X-Received: by 2002:a05:6214:242f:b0:685:fc61:7060 with SMTP id
 gy15-20020a056214242f00b00685fc617060mr5041925qvb.99.1705940714393; 
 Mon, 22 Jan 2024 08:25:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 kv2-20020a056214534200b00681896c0483sm2527911qvb.114.2024.01.22.08.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 08:25:14 -0800 (PST)
Message-ID: <008d04c6-89b2-4b40-affa-cbfa14098308@redhat.com>
Date: Mon, 22 Jan 2024 17:25:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 1/6] backends/iommufd_device: introduce IOMMUFDDevice
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-2-zhenzhong.duan@intel.com>
 <180a39fb-aa2b-4dca-9f01-adb4f392b846@redhat.com>
 <SJ0PR11MB6744950843CB68DB485FF03792702@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744950843CB68DB485FF03792702@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/19/24 08:31, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH rfcv1 1/6] backends/iommufd_device: introduce
>> IOMMUFDDevice
>>
>>
>>
>> On 1/15/24 11:13, Zhenzhong Duan wrote:
>>> IOMMUFDDevice represents a device in iommufd and can be used as
>>> a communication interface between devices (i.e., VFIO, VDPA) and
>>> vIOMMU.
>>>
>>> Currently it includes iommufd handler and device id information
>>> which could be used by vIOMMU to get hw IOMMU information.
>>>
>>> In future nested translation support, vIOMMU is going to have
>>> more iommufd related operations like allocate hwpt for a device,
>>> attach/detach hwpt, etc. So IOMMUFDDevice will be further expanded.
>>>
>>> IOMMUFDDevice is willingly not a QOM object because we don't want
>>> it to be visible from the user interface.
>>>
>>> Introduce a helper iommufd_device_init to initialize IOMMUFDDevice.
>>>
>>> Originally-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>   MAINTAINERS                     |  4 +--
>>>   include/sysemu/iommufd_device.h | 31 ++++++++++++++++++++
>>>   backends/iommufd_device.c       | 50
>> +++++++++++++++++++++++++++++++++
>> Maybe it is still time to move the iommufd files in a sepate dir, under
>> hw at the same level as vfio.
>>
>> Thoughts?
> 
> Any reason for the movement? Hw dir contains entries to emulate different
> Devices. Iommufd is not a real device. It's more a backend.

I would include the new services in the existing iommufd .[ch] files.
No need for a new file since the changes are all related to the IOMMUFD
device usage.

Thanks,

C.





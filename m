Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DBA7E5299
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 10:23:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0ekr-0006nZ-Id; Wed, 08 Nov 2023 04:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0eko-0006n7-Ia
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:21:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0ekm-00053U-SP
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699435299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVltpDhtj4PVlsIXSPVizZGJfqxb0+3KzSxnkHaLVXA=;
 b=JYMlcYcao9ktHFntmarC48eNr6N6t7QgLQALb8lcQ3JHh7BYeby/ogr2GI+c4g7rKZ2F8/
 q16XOi/27Kb7OmUWsfITNJdT7DIeBGHK0Gpz0Dqi/FynulmA5K7KxSZ4hOuAU/2PWVaJ//
 M1IvVegVSv+df7L/s3ma4OimsbfRrvY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-c6gRcFfmOKepi5Re4OUhfw-1; Wed, 08 Nov 2023 04:21:37 -0500
X-MC-Unique: c6gRcFfmOKepi5Re4OUhfw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d03dcdc6bso78886616d6.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 01:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699435297; x=1700040097;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mVltpDhtj4PVlsIXSPVizZGJfqxb0+3KzSxnkHaLVXA=;
 b=gHgV+ny3Xa48rOGbRTnAibnj8qgYu/nczpiXb+7sR54T5DnDPlkjY17QNnsT5rJEn0
 XwIK/f/0+ajKD3e9nPl8cTHvYk6mnoljuMm8E2diu9wOjnlhnYcAiovVeZEIRkFYeHE/
 asSdioT9qoGwYK02kiTdoLqobOJvWU2GxBBsLo5SH3oBRLZ+RWyngGaFKOpfyWTQ3rbL
 imwQH2zETaKoSiFU9bMDUaQrUCBoVJsLIB5HseHm8xNqdLTcmag+zgZf4VQKbUa7h3YU
 3gM+NpbUefB3bLkgF/3KHT3NJcZIV+jygUnJdnSkIa423OSk3j/8BvNBLVhMKGurN7vK
 9E6g==
X-Gm-Message-State: AOJu0YzlMG2WLIgqACHZeHillMCY3w50m08GublPIJs2AZretxkpS9LI
 D4dQ7jbEnRvw5dWtwzrVTAwGdXuHbewoC1sCI8i9Cmc75R6te/wsGOxEboF0I/svyWq+ZhATmrN
 JDmPqpQcug+fw9Rw=
X-Received: by 2002:a05:6214:2687:b0:66d:5dd:26f6 with SMTP id
 gm7-20020a056214268700b0066d05dd26f6mr1308594qvb.25.1699435297418; 
 Wed, 08 Nov 2023 01:21:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr83PctT5PjQ5xxIIwGc+W86mwbenAj6iG8EUxqYvSadOWdu+8pUH4mkBwW3pO1YC2+7C5kQ==
X-Received: by 2002:a05:6214:2687:b0:66d:5dd:26f6 with SMTP id
 gm7-20020a056214268700b0066d05dd26f6mr1308575qvb.25.1699435297094; 
 Wed, 08 Nov 2023 01:21:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 bu7-20020ad455e7000000b0064f5d70d072sm873432qvb.37.2023.11.08.01.21.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 01:21:36 -0800 (PST)
Message-ID: <cb8d044d-72ad-4197-ae29-78599cf4771f@redhat.com>
Date: Wed, 8 Nov 2023 10:21:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/41] vfio: Adopt iommufd
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <d8f1ecdd-4ce8-4811-8efe-6607e71a9f98@redhat.com>
 <923acaad-4e52-442f-b688-277e87a48469@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <923acaad-4e52-442f-b688-277e87a48469@linux.ibm.com>
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

On 11/8/23 04:26, Matthew Rosato wrote:
> On 11/7/23 1:28 PM, Cédric Le Goater wrote:
>> On 11/2/23 08:12, Zhenzhong Duan wrote:
>>> Hi,
>>>
>>> Thanks all for giving guides and comments on previous series, here is
>>> the v4 of pure iommufd support part.
>>>
>>> Based on Cédric's suggestion, this series includes an effort to remove
>>> spapr code from container.c, now all spapr functions are moved to spapr.c
>>> or spapr_pci_vfio.c, but there are still a few trival check on
>>> VFIO_SPAPR_TCE_*_IOMMU which I am not sure if deserved to introduce many
>>> callbacks and duplicate code just to remove them. Some functions are moved
>>> to spapr.c instead of spapr_pci_vfio.c to avoid compile issue because
>>> spapr_pci_vfio.c is arch specific, or else we need to introduce stub
>>> functions to those spapr functions moved.
>>>
>>>
>>> PATCH 1-5: Move spapr functions to spapr*.c
>>> PATCH 6-20: Abstract out base container
>>> PATCH 21-24: Introduce sparpr container and its specific interface
>>
>> PATCH 6-24 applied to vfio-next :
>>
>>    https://github.com/legoater/qemu/commits/vfio-next
>>
>> (with a global s/fucntional/functional/)
>>
>>
>> I also pushed the remaining patches on :
>>
>>    https://github.com/legoater/qemu/commits/vfio-8.2
>>
>> with a slight rework of the IOMMUFD configuration, now done per platform.
>> The VFIO frontend and the 'iommufd' object are only available on x86_64,
>> arm, s390x.
> 
> FYI, I first tried this vfio-8.2 branch on s390x but wasn't actually able to use the iommufd backend (was getting errors like Property 'vfio-pci.iommufd' not found) so I think something isn't actually enabling IOMMUFD as expected with your change...

yes. The previous method used to enable the IOMMUFD device with
a ./configure script option was exposing the CONFIG_IOMMUFD define
globally.

The current method using the Kconfig files requires an extra :

#include CONFIG_DEVICES

in each file using CONFIG_IOMMUFD.

I didn't see it because when compiled natively on x86_64 the
CONFIG_IOMMUFD define is included for some (magic) reason.
It is not the case on other arches, ppc64, aarch64, s390x.

I did the update and repushed vfio-8.2. Should work now.

> 
> Instead I tested on s390x using vfio-next + patches 25-41 of this series on top.
> 
> Legacy backend regression testing worked fine for vfio-pci, vfio-ap and vfio-ccw.

ok. Good. This means that vfio-next is in good shape.

> Using iommufd backend for vfio-pci on s390 exposes an s390-only issue related to accounting of vfio DMA limit (code in hw/s390x/s390-pci-vfio.c assumes VFIODevice.group is never null, but that's no longer true when we use the iommufd backend with cdev).  We don't even need to track this when using the iommufd backend -- With that issue bypassed, vfio-pci testing on s390x looks good so far.  I'll send a separate fix for that.

Thanks,

C.

  
> Using the iommufd backend for vfio-ccw and vfio-ap did not work, see response to patch 28.
> 
> Thanks,
> Matt
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF3E7E529D
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 10:24:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0emw-00087l-Li; Wed, 08 Nov 2023 04:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0emu-00086w-RX
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:23:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r0emt-0005IF-Ai
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699435430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o4kNiL8HtZ+KnSFj62fiqupRPWfr3wi/gZYwBUJx8Fk=;
 b=REt4wG+C6ErEE5EIpAhmqq8dLbiRUmwGvPQrSG23GCSXIa1kqSgg8qIT/UJ3BhPfZH7zJG
 gzElG92x2aSb3kMzD1uyq6kEAZu0GFSfUDHJL/0Q8Tmgp4pHUWEhA8WhucvZ7Y1WFdRhNe
 b0FLEL/fXYiHPQE2YtBM8WyK/5tCCvs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Df14eMyBPSCcwrSY4LwjbA-1; Wed, 08 Nov 2023 04:23:48 -0500
X-MC-Unique: Df14eMyBPSCcwrSY4LwjbA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6717027ac96so76994366d6.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 01:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699435428; x=1700040228;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o4kNiL8HtZ+KnSFj62fiqupRPWfr3wi/gZYwBUJx8Fk=;
 b=ulVnbeDExbzSby6tqC1GRyQMMJUeLPXd2le74gP08xJ4lOfEOr0AhCQuz1Rt5p8WBy
 1i6KoBhWh2j4vNQ2puRjGB5ryC4LhDaDM5aqrdRVaT1jIjh1631V/PuUlIwv5Q6kMM5v
 2T9zgDXngEAQxi7cnc94ml3d/cKJql/6wHQ3yQcq3bwOM755HGU5OiMKAgtHNfMnwbYN
 w43DCCxmwKGpcACuhWj5mpQUvoUEsJZH1GtYkVPX1y4O6YmiSoaVU3U3BJLnirakgbvN
 efagfUx7GiFj1c44p61ZE8I1GJcfx7pgeivsj+xygzZskjPHlzkjiPpr2TsDM+P7+T/P
 99hQ==
X-Gm-Message-State: AOJu0Yy1L8q3j7rwYxSb8CXN124IG4DOJPaLuWXREKaRJbWD4n1e4Z3d
 Pn/yY2TXhRyOl50u/DHpGo0M3yNVb+DfLycmLGMTz7ENvqRJFWATKK1y9oYx5Rt9xiOlWABlS7G
 9YJNZhLeTJ+WBLAI=
X-Received: by 2002:ad4:5d6b:0:b0:671:3f49:c8b7 with SMTP id
 fn11-20020ad45d6b000000b006713f49c8b7mr1204721qvb.51.1699435428379; 
 Wed, 08 Nov 2023 01:23:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEO/8BSwXqMZtqx2oiMljdH6ynLX1eWa+yRlSUaSVm0zJ5CIcOQqQv6bGIKxxf7qyXgIDXzHA==
X-Received: by 2002:ad4:5d6b:0:b0:671:3f49:c8b7 with SMTP id
 fn11-20020ad45d6b000000b006713f49c8b7mr1204697qvb.51.1699435428081; 
 Wed, 08 Nov 2023 01:23:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a056214104800b0065d89f4d537sm867006qvr.45.2023.11.08.01.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 01:23:47 -0800 (PST)
Message-ID: <3fe23c92-e25c-486c-b7d4-81bf09a5f106@redhat.com>
Date: Wed, 8 Nov 2023 10:23:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/41] vfio: Adopt iommufd
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <d8f1ecdd-4ce8-4811-8efe-6607e71a9f98@redhat.com>
 <923acaad-4e52-442f-b688-277e87a48469@linux.ibm.com>
 <SJ0PR11MB67444527CF73955C131AABD892A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB6744D2DDA934B345ABAADFB092A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744D2DDA934B345ABAADFB092A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
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

>>> FYI, I first tried this vfio-8.2 branch on s390x but wasn't actually able to use the
>>> iommufd backend (was getting errors like Property 'vfio-pci.iommufd' not found)
>>> so I think something isn't actually enabling IOMMUFD as expected with your
>>> change...
>>
>> It looks CONFIG_IOMMUFD is recognized by Kconfig sub-system but not received
>> by compiler. I'm still digging how to pass CONFIG_IOMMUFD to compiler.
> 
> Need below change to pass CONFIG_IOMMUFD to compiler.
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 0a810f8b88..2a3263b51f 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -30,6 +30,7 @@
>   #include "exec/address-spaces.h"
>   #include "qom/object.h"
>   #include "monitor/monitor.h"
> +#include CONFIG_DEVICES
> 
>   #define TYPE_VFIO_AP_DEVICE      "vfio-ap"
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index a674bd8d6d..08101ad445 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -31,6 +31,7 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/module.h"
>   #include "monitor/monitor.h"
> +#include CONFIG_DEVICES
> 
>   struct VFIOCCWDevice {
>       S390CCWDevice cdev;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d8f658ea47..3121b5f985 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -44,6 +44,7 @@
>   #include "migration/qemu-file.h"
>   #include "sysemu/iommufd.h"
>   #include "monitor/monitor.h"
> +#include CONFIG_DEVICES
> 
>   #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"


yep. I pushed forced vfio-8.2 with these changes.

Thanks,

C.




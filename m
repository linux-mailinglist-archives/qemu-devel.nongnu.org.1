Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D807B16378
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Jul 2025 17:15:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh8W4-0001wj-Ud; Wed, 30 Jul 2025 11:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uh7Lw-0002xs-EL
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uh7Lt-00050o-TY
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753884015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s1npoe8Mx74UINSR5OilDjc7A31k/jI832FNVlLjcSQ=;
 b=GZX2jBiKyurThwx69mKxYDzzRxOrBYF8P64sQrqH4/HGQUDz2AU/Jhsxh6ArBylmggb2br
 k9pQ14qDK4gZNsHHgV/qE7F/2D8SbyQvYSHOJ6XpRabJq8bN4IVO+ihYKkefZClM4l4YQG
 EKLtnQBdfhXHsl421lzjU+ma1ucRdaw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-tEWupYYbNKC802gUwRQZHw-1; Wed, 30 Jul 2025 10:00:09 -0400
X-MC-Unique: tEWupYYbNKC802gUwRQZHw-1
X-Mimecast-MFC-AGG-ID: tEWupYYbNKC802gUwRQZHw_1753884008
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-455f79a2a16so51977045e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 07:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753884008; x=1754488808;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s1npoe8Mx74UINSR5OilDjc7A31k/jI832FNVlLjcSQ=;
 b=X1deNz6U3RJY6IFVHNbAplnBqGjIVeXsA/RJ+MYclMz0ZDpup97LStEhuJ1PBsQmi9
 ZvgMUotJMXN+niUS91cIRjs8c60SwCsJ9uZj72/aYvno7Njv/aglt8NZOkdOMdyI/BaX
 9W/d8fwEOZdTk3Gy0oAdGZUSBbRNA810EuGrq29IcimgAwaiwt3JhdSEfkUDNPBX0e1y
 UhyVqGJPBdfgTgsZ8IMifNqzI6cIQU0Xx0hmZW6lwSAK9fnn+PApL/YkvJ3DaMJStqAm
 Q1y9yUDO3VhFXBkbLo9hKEfmzHNjNY8EhbD7I58yOqbwwUoZw68QZ15M6gezSu50Hbrq
 bRiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF6SOLfaFWkWPigr3MGZeDLu6GVYynolJjeehPxJRflhPcFN/yEsA51T/gxGzD0B/cwgp0jJ5JJ8Lx@nongnu.org
X-Gm-Message-State: AOJu0YyU/SPZX9K0SwU5JQpW9Cy4BRBPnmRVAZzdr+lu8z4LNrPRiwO6
 HlpiH5qA32CloZZz9wb4uH022T8lUT1LrqCFKan2487IrhjycbIinOtkstZ6820t6YtPEb+8dIT
 I5e+kGYMLGX9NowMebIlaDAG+blSc1iXI2GcKyGWjcGcbmnL0q1BPgZDH
X-Gm-Gg: ASbGncssxe0tMAyrzsxyLy2MpVxyhuMqX6WEV3H1c4T3HLfNHZ36MUxmGbYZTDJQ7nL
 NYbcRE88o4pVCqzrmKYi7xviIRRtvGA1JaaBquEnpZiqE/J4XoM6w3pTFQl1FT58WESmAVJbfks
 +uPtm1DR/oIHQITopJDoxzoFAUHfOZMlCzCQtmYjwNbfpaU13vm5z2f+C4BaVvlUZzeHHLCbaIq
 ELZmoGEs70t2WuzqVSAnwBeMnzqMv+o8e4F03hW/XB0HOuEtnYIFsc5lIPT+b+9jJFvJ7Hoe+eb
 DW8SK68+3fbQbRtHfrwDC2SzYYYg/S+vxdakbaDoiu76CDgwcyISa0P2PCuln1spARFvou/XWdW
 lxtmhrTE=
X-Received: by 2002:a05:600c:4450:b0:455:f59e:fdaa with SMTP id
 5b1f17b1804b1-45892bc6d1bmr31049045e9.21.1753884007362; 
 Wed, 30 Jul 2025 07:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxyqRgkzxPEZ4SWcmrHp7pgJY+FZf/lcvnxEBAwqGjxGrPuxKgf6GXWrkmhtd35vF9NTerPQ==
X-Received: by 2002:a05:600c:4450:b0:455:f59e:fdaa with SMTP id
 5b1f17b1804b1-45892bc6d1bmr31048515e9.21.1753884006709; 
 Wed, 30 Jul 2025 07:00:06 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589536a71esm28048135e9.7.2025.07.30.07.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 07:00:06 -0700 (PDT)
Message-ID: <8c395b8f-4c6d-4c64-bf02-feb1e2e5e369@redhat.com>
Date: Wed, 30 Jul 2025 16:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/20] vfio/iommufd: Force creating nested parent domain
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <20250729092043.785836-5-zhenzhong.duan@intel.com>
 <74895627-74a8-4cb4-a460-491ac5dd1c2b@redhat.com>
 <IA3PR11MB91365795415087EF9550FB209224A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB91365795415087EF9550FB209224A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/30/25 12:55, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v4 04/20] vfio/iommufd: Force creating nested parent
>> domain
>>
>> On 7/29/25 11:20, Zhenzhong Duan wrote:
>>> Call pci_device_get_viommu_cap() to get if vIOMMU supports
>> VIOMMU_CAP_HW_NESTED,
>>> if yes, create nested parent domain which could be reused by vIOMMU to
>> create
>>> nested domain.
>>>
>>> It is safe because hw_caps & VIOMMU_CAP_HW_NESTED cannot be set yet
>> because
>>> s->flts is forbidden until we support passthrough device with x-flts=on.
>>>
>>> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>>    hw/vfio/iommufd.c | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 48c590b6a9..61a548f13f 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -20,6 +20,7 @@
>>>    #include "trace.h"
>>>    #include "qapi/error.h"
>>>    #include "system/iommufd.h"
>>> +#include "hw/iommu.h"
>>>    #include "hw/qdev-core.h"
>>>    #include "hw/vfio/vfio-cpr.h"
>>>    #include "system/reset.h"
>>> @@ -379,6 +380,19 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>            flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>        }
>>>
>>> +    /*
>>> +     * If vIOMMU supports stage-1 translation, force to create nested
>> parent
>>> +     * domain which could be reused by vIOMMU to create nested
>> domain.
>>> +     */
>>> +    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
>>> +        VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice,
>> vbasedev);
>>> +
>>> +        hw_caps = pci_device_get_viommu_cap(&vdev->pdev);
>>> +        if (hw_caps & VIOMMU_CAP_HW_NESTED) {
>>> +            flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
>>> +        }
>>> +    }
>>>
>>
>> Could you please add a wrapper for the above ? Something like :
>>
>> static bool vfio_device_viommu_get_nested(VFIODevice *vbasedev)
>> {
>>      if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
>>          VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice,
>> vbasedev);
>>
>> 	return !!(pci_device_get_viommu_cap(&vdev->pdev) &
>> VIOMMU_CAP_HW_NESTED);
>>      }
>>      return false;
>> }
>>
>> May be this routine belongs to hw/vfio/device.c.
> 
> Done, see https://github.com/yiliu1765/qemu/commit/7ce1af90d5c1f418f23c9e397a16a3914b30f09f
> 
> I also introduced another wrapper vfio_device_to_vfio_pci(), let me know if you think it's unnecessary, I'll fold it.

It's good to have it if you use it everywhere:

hw/vfio/device.c:    if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
hw/vfio/container.c:                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
hw/vfio/container.c:                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
hw/vfio/listener.c:    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
hw/vfio/listener.c:        if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
hw/vfio/iommufd.c:    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
hw/vfio/iommufd.c:        vbasedev_tmp->type != VFIO_DEVICE_TYPE_PCI) {

So, I would address this cleanup separately.

FYI, We also have this helper :

VFIODevice *vfio_get_vfio_device(Object *obj)
{
     if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
         return &VFIO_PCI_BASE(obj)->vbasedev;
     } else {
         return NULL;
     }
}


Thanks,

C.





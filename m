Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3CB7EF3B7
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 14:31:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3yvQ-00065k-DS; Fri, 17 Nov 2023 08:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3yv4-00065S-Qv
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 08:30:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3yv2-0000zW-KL
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 08:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700227796;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6SJi5EdTN4r0EJkJzZuatIgcctJmpY0NwUyZPcAK7Mc=;
 b=gUXf7xPSlg8huf9MGhv+KVi6YOOLqQfu74PelLPC0FHfPuC4Zl/pEB8ROj/yXFYxPfuWU1
 FWH7C/HqfwBDAU9vQtgCtcbIZW2g5ZBVcpDeXyc4WYV8ySdcIpKQ3fNhgBRhC5yDIlxxH5
 icbEC37NOtPzf6Uo66FnJUBqEOdxUYk=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-UWqkSxFQN8KYe6pNKRHdzw-1; Fri, 17 Nov 2023 08:29:54 -0500
X-MC-Unique: UWqkSxFQN8KYe6pNKRHdzw-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-58a83a73ce9so2135282eaf.2
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 05:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700227793; x=1700832593;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6SJi5EdTN4r0EJkJzZuatIgcctJmpY0NwUyZPcAK7Mc=;
 b=RG4ZvpT1SsMM1T2Wu5NDgyx66s8OS6Uc/XwqlBT1EAx8fFzZo1VQMvjicCxLVPMGGq
 XQk4Ofw1vSkvMshmsmskfU2DYX4h6mFBO0UB9aAgz9fIgwLK3DlmHvLaSjguxuOCTVx/
 wMdRQUXPaxI95xwFFA/jWax41Va2+TFwhEc/+0qfW788A15F/vittmB6XPRVhoxtZt1B
 iOup+ffMp6pX94iaZTMc0fcU3bgMLRk2CuuTiEkQhmMMKT1P/QMmpSyGnxSyLNY9Jyll
 XfZK4MiFVnxwIHywxB3gXIyVomkyFE6yc/EWaHFE6GRF8gkVUYxVIUgT8nPLIau8LQYE
 PjaA==
X-Gm-Message-State: AOJu0YwVJDr9y50Cmja9btjZb4KzxYxTit7Mf74ewMCCFY5B3uzHSnX8
 wGvxVUrOvgdSFgG6Ios0UFh42j3+7Rclon+uhYn25LLfJ/xR78YLe47ZvBRaBlpNbNnTFUJckNY
 cd61iXTNzgtiTAdA=
X-Received: by 2002:a05:6358:7249:b0:16b:cc89:c1a9 with SMTP id
 i9-20020a056358724900b0016bcc89c1a9mr16296187rwa.27.1700227793654; 
 Fri, 17 Nov 2023 05:29:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGju/1T6QIqShxWv2BNlP62g0f2dBPQTXd76adSF0usRmoYCCaiYge23rmv8FjMXwggkXHV9A==
X-Received: by 2002:a05:6358:7249:b0:16b:cc89:c1a9 with SMTP id
 i9-20020a056358724900b0016bcc89c1a9mr16296158rwa.27.1700227793367; 
 Fri, 17 Nov 2023 05:29:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 qh26-20020a0562144c1a00b006577e289d37sm634364qvb.2.2023.11.17.05.29.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 05:29:52 -0800 (PST)
Message-ID: <248389a7-3f89-42ae-98e7-34d6612cf186@redhat.com>
Date: Fri, 17 Nov 2023 14:29:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
 <c964fdf3-d6ef-40cd-b4c0-32f1fb8501ae@redhat.com>
 <SJ0PR11MB6744B1B91C890A9A1B81E89792B7A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744B1B91C890A9A1B81E89792B7A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Cédric,

On 11/17/23 12:39, Duan, Zhenzhong wrote:
> Hi Cédric,
>
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, November 17, 2023 7:10 PM
>> Subject: Re: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
>>
>> Hello,
>>
>>> +int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> hwaddr iova,
>>> +                            ram_addr_t size, void *vaddr, bool readonly)
>>> +{
>>> +    int ret, fd = be->fd;
>>> +    struct iommu_ioas_map map = {
>>> +        .size = sizeof(map),
>>> +        .flags = IOMMU_IOAS_MAP_READABLE |
>>> +                 IOMMU_IOAS_MAP_FIXED_IOVA,
>>> +        .ioas_id = ioas_id,
>>> +        .__reserved = 0,
>>> +        .user_va = (uintptr_t)vaddr,
>>> +        .iova = iova,
>>> +        .length = size,
>>> +    };
>>> +
>>> +    if (!readonly) {
>>> +        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
>>> +    }
>>> +
>>> +    ret = ioctl(fd, IOMMU_IOAS_MAP, &map);
>>> +    trace_iommufd_backend_map_dma(fd, ioas_id, iova, size,
>>> +                                  vaddr, readonly, ret);
>>> +    if (ret) {
>>> +        ret = -errno;
>>> +        error_report("IOMMU_IOAS_MAP failed: %m");
>>> +    }
>>> +    return ret;
>>> +}
>> When using a UEFI guest, QEMU reports errors when mapping regions
>> in the top PCI space :
>>
>>   iommufd_backend_map_dma  iommufd=10 ioas=2 iova=0x380000001000
>> size=0x3000 addr=0x7fce2c28b000 readonly=0 (-1)
>>   qemu-system-x86_64: IOMMU_IOAS_MAP failed: Invalid argument
>>   qemu-system-x86_64: vfio_container_dma_map(0x55a21b03a150,
>> 0x380000001000, 0x3000, 0x7fce2c28b000) = -22 (Invalid argument)
>>
>>   iommufd_backend_map_dma  iommufd=10 ioas=2 iova=0x380000004000
>> size=0x4000 addr=0x7fce2c980000 readonly=0 (-1)
>>   qemu-system-x86_64: IOMMU_IOAS_MAP failed: Invalid argument
>>   qemu-system-x86_64: vfio_container_dma_map(0x55a21b03a150,
>> 0x380000004000, 0x4000, 0x7fce2c980000) = -22 (Invalid argument)
>>
>> This is because IOMMUFD reserved IOVAs areas are :
>>
>>  [ fee00000 - feefffff ]
>>  [ 8000000000 - ffffffffffffffff ] (39 bits address space)
>>
>> which were allocated when the device was initially attached.
>> The topology is basic. Something is wrong.
> 	
> Thanks for your report. This looks a hardware limit of
> host IOMMU address width(39) < guest physical address width.
>
> A similar issue with a fix submitted below, ccing related people.
> https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg02937.html
> It looks the fix will not work for hotplug.
>
> Or below qemu cmdline may help:
> "-cpu host,host-phys-bits-limit=39"

don't you have the same issue with legacy VFIO code, you should?

Eric
>
> Thanks
> Zhenzhong
>



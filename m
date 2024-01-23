Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9823E838B72
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:11:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDjx-0006IX-BR; Tue, 23 Jan 2024 05:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rSDjv-0006IL-5c
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:10:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rSDjt-0002JC-JH
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706004639;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sODYAX0xLp5JZcJAUQOo3nj5lYY7y5BPPofSdZnCLp8=;
 b=I1cIR+yjoLX6kgpojm1k50ZunZ7w+Fg8sfxqJS/3pYYc7s5MntTy3JbBGGX56xhMvro4j9
 05l4ZBnolbtWT3hS9rG04ortVIs04KFyZoj2r2Tvv4oSHHMmDiJBUS1l7Uy3DwYhu1GJkx
 GEUATeFAt3gRFm/hU7xKi2H2A6cQ9EI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-II1AVIF-MDqA9GYJd4uRNQ-1; Tue, 23 Jan 2024 05:10:34 -0500
X-MC-Unique: II1AVIF-MDqA9GYJd4uRNQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-783603ba574so690096885a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 02:10:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706004614; x=1706609414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sODYAX0xLp5JZcJAUQOo3nj5lYY7y5BPPofSdZnCLp8=;
 b=lduq+JcUnuQxCou9dAW05b8gjaPjsti7qa1YRQ15+2pDFTJzKerWWkSLmuBcQG5eng
 uqDNJUTfISlfRfZDsvhlrliVedmC2cQZ3tnayODFZKonNs7i+hgSuU0Lclg42MlpClD+
 GwdfRSAxHzg6ZdLlik5BuJHpktX3ceUn7XDhNtYvHCrf+SKSdY0y06ephoICdRVEu142
 RESlOSG3+9NHsYV39i8GReCgxmYf88uMb1YCLV34ZJ76pX7sNs+fmc93EQ+QPsrCplgT
 yvUFEYXlx5BHmpo+9qyF3OU4dZJufr8LPueORgysa24iavmZXc0LovWguZO6u0QCPSBD
 r55g==
X-Gm-Message-State: AOJu0Yxy41GAvU0ACzAZh7GNgZ/+jwduBz2oIQubMMCQm1A1dhH+HdCP
 y6+d5Aw+vBL9GH8H0rQMISEsYNWX20m8p5IoHPUwGGQrwsnPbAT05GE4rgbEvHF35eu2C6PkY9w
 AgvcaSnZqwvk4CvmAgiCK71QgJHRRfVu0EPoYhlmnsz9wY34LsEtt
X-Received: by 2002:a05:6214:b64:b0:681:972:a252 with SMTP id
 ey4-20020a0562140b6400b006810972a252mr726132qvb.80.1706004614088; 
 Tue, 23 Jan 2024 02:10:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQ/cPDBZqrs95i1dnI7JloR30dqS1ySQ5lu1YPbJfd/YYWlTtqMR1OxtirLaqQdFXHfxJFBA==
X-Received: by 2002:a05:6214:b64:b0:681:972:a252 with SMTP id
 ey4-20020a0562140b6400b006810972a252mr726112qvb.80.1706004613778; 
 Tue, 23 Jan 2024 02:10:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 nh6-20020a056214390600b00681935bac12sm3326069qvb.81.2024.01.23.02.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 02:10:13 -0800 (PST)
Message-ID: <9e85eabc-ea56-41b0-b6ce-607749e5b640@redhat.com>
Date: Tue, 23 Jan 2024 11:10:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv1 1/6] backends/iommufd_device: introduce IOMMUFDDevice
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744950843CB68DB485FF03792702@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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



On 1/19/24 08:31, Duan, Zhenzhong wrote:
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
>>>  MAINTAINERS                     |  4 +--
>>>  include/sysemu/iommufd_device.h | 31 ++++++++++++++++++++
>>>  backends/iommufd_device.c       | 50
>> +++++++++++++++++++++++++++++++++
>> Maybe it is still time to move the iommufd files in a sepate dir, under
>> hw at the same level as vfio.
>>
>> Thoughts?
> Any reason for the movement? Hw dir contains entries to emulate different
> Devices. Iommufd is not a real device. It's more a backend.
Well I was thinking it would become bigger and bigger and since you
created a new .c file with new abstraction (devices) the backend dir
flat layout may not be well adapted. But as suggested by Cédric we may
use the existing files.

Thanks

Eric
>
> Thanks
> Zhenzhong



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAA97A20B9
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:20:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9fs-0007L3-Fy; Fri, 15 Sep 2023 10:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qh9fV-0007FL-FP
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qh9fT-0000Mp-SP
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694787575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a32ot1mLc+fauQaQeiFV3v+/qakq+bCy5oHpGBXA1nk=;
 b=Moa0pbQPAHfrWGC86An5VKPJMTx3p1MVjcys+7ou22ZlvY37v85ve1zM8Uwe33osQCuJZL
 9O7oWG1hgC2nI7aHzIpXu13kfhhR1KbY6fBHCykSn5xoADx5Z8zqwsG8UagvmcYuhkHFLK
 yHry9FjLuPOx4aP33VKIk/q1tZfHmNE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-uvW1KIqPPXGJW664Wm-Xkw-1; Fri, 15 Sep 2023 10:19:33 -0400
X-MC-Unique: uvW1KIqPPXGJW664Wm-Xkw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6562692f945so17562166d6.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 07:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694787573; x=1695392373;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a32ot1mLc+fauQaQeiFV3v+/qakq+bCy5oHpGBXA1nk=;
 b=JZkXqoo5nzxfLBzb4B22tUlEkzaFYrE3q1HYgzw9iDbMy4XsEE1Asbf4YjAF1x1ddq
 YLxLAFYS3FXPdAOWf0c9u/tY3MUbP0jLtUO1WbImzFdbmksMByL/5ieGXBw6BpO234UD
 gzLduQ0lHlE9LRVKRfIlSnIXZY3lRGdwfl2TDEGuMx7F5RawNH7lxvm0X9C4JQJg551J
 QJ2EluGZoBX/ywkAuVwZs5s96ADQyev8t84mSzlzQbvYIp1cBPrUw85WsZf6dX5vKHP5
 MDMThHkQGJbBVNODLqVZGxVZP7peTTTgRZ5FdaiKEQOVA0P7dgRrF6zlVtu3ZqUjsMTs
 WKwQ==
X-Gm-Message-State: AOJu0YzaxH9MBilr6I2uIQPiuIRu5QIUDZkQwELqXe/MYVodghBqxhb2
 gxLNUQWGShiOR1PusKJmpZoc1aITSt8CvnKH/reYWvKPewjz1bfi5cpc8rH7jH189PpXEGDLsjX
 mhkYM6udZ2Z6w+Lk=
X-Received: by 2002:a0c:f390:0:b0:64a:959f:22fb with SMTP id
 i16-20020a0cf390000000b0064a959f22fbmr1843910qvk.58.1694787573098; 
 Fri, 15 Sep 2023 07:19:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgI79V+hP7I+/0qO6JPMCBrYxU32nJvc4q3loV+Y9mVv+U5fApiRWj+LBKfmYhkBmWgAFYMg==
X-Received: by 2002:a0c:f390:0:b0:64a:959f:22fb with SMTP id
 i16-20020a0cf390000000b0064a959f22fbmr1843886qvk.58.1694787572860; 
 Fri, 15 Sep 2023 07:19:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 w26-20020a0ca81a000000b00655e2005350sm1316128qva.9.2023.09.15.07.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 07:19:32 -0700 (PDT)
Message-ID: <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
Date: Fri, 15 Sep 2023 16:19:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Content-Language: en-US
To: ankita@nvidia.com, jgg@nvidia.com, alex.williamson@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org, ani@anisinha.ca
Cc: aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230915024559.6565-1-ankita@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230915024559.6565-1-ankita@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Ankit,

On 9/15/23 04:45, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> For devices which allow CPU to cache coherently access their memory,
> it is sensible to expose such memory as NUMA nodes separate from
> the sysmem node. Qemu currently do not provide a mechanism for creation
> of NUMA nodes associated with a vfio-pci device.
> 
> Implement a mechanism to create and associate a set of unique NUMA nodes
> with a vfio-pci device.>
> NUMA node is created by inserting a series of the unique proximity
> domains (PXM) in the VM SRAT ACPI table. The ACPI tables are read once
> at the time of bootup by the kernel to determine the NUMA configuration
> and is inflexible post that. Hence this feature is incompatible with
> device hotplug. The added node range associated with the device is
> communicated through ACPI DSD and can be fetched by the VM kernel or
> kernel modules. QEMU's VM SRAT and DSD builder code is modified
> accordingly.
> 
> New command line params are introduced for admin to have a control on
> the NUMA node assignment.

This approach seems to bypass the NUMA framework in place in QEMU and
will be a challenge for the upper layers. QEMU is generally used from
libvirt when dealing with KVM guests.

Typically, a command line for a virt machine with NUMA nodes would look
like :

   -object memory-backend-ram,id=ram-node0,size=1G \
   -numa node,nodeid=0,memdev=ram-node0 \
   -object memory-backend-ram,id=ram-node1,size=1G \
   -numa node,nodeid=1,cpus=0-3,memdev=ram-node1

which defines 2 nodes, one with memory and all CPUs and a second with
only memory.

   # numactl -H
   available: 2 nodes (0-1)
   node 0 cpus: 0 1 2 3
   node 0 size: 1003 MB
   node 0 free: 734 MB
   node 1 cpus:
   node 1 size: 975 MB
   node 1 free: 968 MB
   node distances:
   node   0   1
     0:  10  20
     1:  20  10

   
Could it be a new type of host memory backend ?  Have you considered
this approach ?

Thanks,

C.

> 
> It is expected for a vfio-pci driver to expose this feature through
> sysfs. Presence of the feature is checked to enable these code changes.
> 
> Applied over v8.1.0-rc4.
> 
> Ankit Agrawal (4):
>    vfio: new command line params for device memory NUMA nodes
>    vfio: assign default values to node params
>    hw/arm/virt-acpi-build: patch guest SRAT for NUMA nodes
>    acpi/gpex: patch guest DSDT for dev mem information
> 
>   hw/arm/virt-acpi-build.c    |  54 +++++++++++++
>   hw/pci-host/gpex-acpi.c     |  69 +++++++++++++++++
>   hw/vfio/pci.c               | 146 ++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.h               |   2 +
>   include/hw/pci/pci_device.h |   3 +
>   5 files changed, 274 insertions(+)
> 



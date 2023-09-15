Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FD57A25D9
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 20:36:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhDed-0008Jc-VU; Fri, 15 Sep 2023 14:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qhDeT-0008IQ-Oa
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 14:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qhDeS-0001TR-34
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 14:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694802886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TtSEInjybqRb6l9CiNMNLZiWNc6Hr1x7n1G1Nj2NnrI=;
 b=Pk0T2K+TmQq0ixVrjTkgsofLhb56cCYh9N2ytmgo9EjFqSFlgrmGbaixnCqcJDU02eQyRJ
 k/hSz07ujf+HJJ4q05mpfJp1B1jU/k1CVxcQdUy881u4xaRmEpXrDzVyiFwJlNI9tb9+D/
 1ZgN2d20m35B46yOt265dTudVWnNj8w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-Pdi48yyWONCH9cobw6ps1Q-1; Fri, 15 Sep 2023 14:34:44 -0400
X-MC-Unique: Pdi48yyWONCH9cobw6ps1Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-401e521122fso19646295e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 11:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694802883; x=1695407683;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtSEInjybqRb6l9CiNMNLZiWNc6Hr1x7n1G1Nj2NnrI=;
 b=L2ZeR81wK0a+CeAcVDQrGRvd42rZpL2+NSr5sge/LxihvxqQjN7pz7Hnr2RAvI7u0P
 tLNPpzP0mYr7dUD3OK7K8G84TwRH7U0sUbKKvvYUrKCbsmGfxv5rdiVIm317iqrGmocl
 G+AeaizCLAjizQRCxdPkSvFF4u9S5VqBzxz3tsHR35em0BLjnAV4hDBxrtjiKfZ8WCzp
 QClvF9Zgu+e80lF/VKNQE1VfkE7CMzu3R7n46F5vc0D/NVczcBaVyEkASGT851kHMjZ8
 PPOHWijWmsFcA5nuN8SkJJNQUPCGQmgTE2HzXnI33CQv5npJx/3dstoOl5L2rot26WPL
 HEbQ==
X-Gm-Message-State: AOJu0YwPBvyOkMxtyFEBl/znA0YZci20hM4zemw9CXvQOZafL4kzJPp8
 VS8W6Vr8Fu/imRmsqwEJrMq7JwZ1toLBfbcQQX3IMbUMGqsKhpSozDP1f0Z1EhwiX6q8kJmwQRD
 Z4lLXpM+PjclidHo=
X-Received: by 2002:a7b:cd06:0:b0:3fe:22a9:907 with SMTP id
 f6-20020a7bcd06000000b003fe22a90907mr2255895wmj.20.1694802883329; 
 Fri, 15 Sep 2023 11:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq81TvRKpTxRm/xeCyzAzPbDrvp4UTbJoLmYRqDxX1+iT58qRbKxbEft50+Nd9Gdtw3VMQUg==
X-Received: by 2002:a7b:cd06:0:b0:3fe:22a9:907 with SMTP id
 f6-20020a7bcd06000000b003fe22a90907mr2255878wmj.20.1694802882964; 
 Fri, 15 Sep 2023 11:34:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c728:e000:a4bd:1c35:a64e:5c70?
 (p200300cbc728e000a4bd1c35a64e5c70.dip0.t-ipconnect.de.
 [2003:cb:c728:e000:a4bd:1c35:a64e:5c70])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c22c400b00403b63e87f2sm5292465wmg.32.2023.09.15.11.34.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 11:34:42 -0700 (PDT)
Message-ID: <f129b30b-bd0c-4e30-6be9-384b2b79a26b@redhat.com>
Date: Fri, 15 Sep 2023 20:34:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
Cc: ankita@nvidia.com, jgg@nvidia.com, shannon.zhaosl@gmail.com,
 peter.maydell@linaro.org, ani@anisinha.ca, aniketa@nvidia.com,
 cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 vsethi@nvidia.com, acurrid@nvidia.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230915024559.6565-1-ankita@nvidia.com>
 <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
 <20230915084754.4b49d5c0.alex.williamson@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230915084754.4b49d5c0.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 15.09.23 16:47, Alex Williamson wrote:
> On Fri, 15 Sep 2023 16:19:29 +0200
> Cédric Le Goater <clg@redhat.com> wrote:
> 
>> Hello Ankit,
>>
>> On 9/15/23 04:45, ankita@nvidia.com wrote:
>>> From: Ankit Agrawal <ankita@nvidia.com>
>>>
>>> For devices which allow CPU to cache coherently access their memory,
>>> it is sensible to expose such memory as NUMA nodes separate from
>>> the sysmem node. Qemu currently do not provide a mechanism for creation
>>> of NUMA nodes associated with a vfio-pci device.
>>>
>>> Implement a mechanism to create and associate a set of unique NUMA nodes
>>> with a vfio-pci device.>
>>> NUMA node is created by inserting a series of the unique proximity
>>> domains (PXM) in the VM SRAT ACPI table. The ACPI tables are read once
>>> at the time of bootup by the kernel to determine the NUMA configuration
>>> and is inflexible post that. Hence this feature is incompatible with
>>> device hotplug. The added node range associated with the device is
>>> communicated through ACPI DSD and can be fetched by the VM kernel or
>>> kernel modules. QEMU's VM SRAT and DSD builder code is modified
>>> accordingly.
>>>
>>> New command line params are introduced for admin to have a control on
>>> the NUMA node assignment.
>>
>> This approach seems to bypass the NUMA framework in place in QEMU and
>> will be a challenge for the upper layers. QEMU is generally used from
>> libvirt when dealing with KVM guests.
>>
>> Typically, a command line for a virt machine with NUMA nodes would look
>> like :
>>
>>     -object memory-backend-ram,id=ram-node0,size=1G \
>>     -numa node,nodeid=0,memdev=ram-node0 \
>>     -object memory-backend-ram,id=ram-node1,size=1G \
>>     -numa node,nodeid=1,cpus=0-3,memdev=ram-node1
>>
>> which defines 2 nodes, one with memory and all CPUs and a second with
>> only memory.
>>
>>     # numactl -H
>>     available: 2 nodes (0-1)
>>     node 0 cpus: 0 1 2 3
>>     node 0 size: 1003 MB
>>     node 0 free: 734 MB
>>     node 1 cpus:
>>     node 1 size: 975 MB
>>     node 1 free: 968 MB
>>     node distances:
>>     node   0   1
>>       0:  10  20
>>       1:  20  10
>>
>>     
>> Could it be a new type of host memory backend ?  Have you considered
>> this approach ?
> 
> Good idea.  Fundamentally the device should not be creating NUMA nodes,
> the VM should be configured with NUMA nodes and the device memory
> associated with those nodes.

+1. That would also make it fly with DIMMs and virtio-mem, where you 
would want NUMA-less nodes ass well (imagine passing CXL memory to a VM 
using virtio-mem).

-- 
Cheers,

David / dhildenb



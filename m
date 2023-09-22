Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC82F7AAC2C
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 10:16:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjbKE-00029w-Es; Fri, 22 Sep 2023 04:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjbK0-00026Y-Ok
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 04:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjbJx-0004rH-BL
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 04:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695370528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPnGJ6pUigf9VysrNrEYmrS5dUnPI6KzEbz5GjJ2rr4=;
 b=Wid4YW28lC7OXtoNC/FAUUI/XnX9LQwTzhHlhh3h9n1I3/wt3iumvQsBMQgydoz5fAs2M2
 igW9PpF82z/ZUC14WJtQZNscYPDOGhq40snJwg1EigebhM9fCEQ5ZeeQMkWzrmzQK2ADgb
 5zpCyEoEY8H36HVCaYvlZQJx9TBhpu4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-wMPVyntwMJ2YvK1OMEGHEA-1; Fri, 22 Sep 2023 04:15:24 -0400
X-MC-Unique: wMPVyntwMJ2YvK1OMEGHEA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so13549305e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 01:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695370523; x=1695975323;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KPnGJ6pUigf9VysrNrEYmrS5dUnPI6KzEbz5GjJ2rr4=;
 b=a8uwHh9ojP3Yb3k+9Uyiob5nYPQj7d+Awkxy2islG/drkvWmtEZWmHLlW/ZrQweiSg
 BeRhtDMQLWxVmt0/5BGEXg69jTiyMgqITUeJF8/Uu/jGzPrDGYeXKgh/73LugAHvtNtO
 MGVhccO6o16OZxGAIqvEYdMONwzctgllmeJiP8V7HLXbT660MnskDY2RxfBn9RMtdKkv
 9PKF8KI75e3KZ7cMh8e2Drvt5o/SGgRjZqBL75QpSTzTiKPYR8gUeuiJaSUnd6h1RNi+
 x8kR9EuSjyYAhrJlfVbw61ZM7XAdZ73vnk2B+OoEfsd4/XkVKbZ8JiErA3jOge3H+McN
 K6BQ==
X-Gm-Message-State: AOJu0YwzbBWJyItOlwhxfDirzVY+JUXEzVkyHK9/h7eHxLvyDOfi/J8F
 dOjSxFkd9vybFSzqLSoGd+XE39EDJMknlDaPEu8GQNMNT6VlhOkN9ESjtS2uIsyRa+3Op3EESUP
 NH5rac5CUeR5DlPs=
X-Received: by 2002:a05:600c:1e05:b0:405:3803:5588 with SMTP id
 ay5-20020a05600c1e0500b0040538035588mr2912421wmb.22.1695370523181; 
 Fri, 22 Sep 2023 01:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyz3wA+oF9oxaA57IsP2sgGKTiyQ7eFT5vhj4ILdVnRLD+qs7lFmqKk9fvxlGRtZ2D3ZbbxQ==
X-Received: by 2002:a05:600c:1e05:b0:405:3803:5588 with SMTP id
 ay5-20020a05600c1e0500b0040538035588mr2912399wmb.22.1695370522761; 
 Fri, 22 Sep 2023 01:15:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:7100:dfaf:df8b:54b9:7303?
 (p200300cbc71a7100dfafdf8b54b97303.dip0.t-ipconnect.de.
 [2003:cb:c71a:7100:dfaf:df8b:54b9:7303])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a05600c2d5500b004053e9276easm923265wmg.32.2023.09.22.01.15.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 01:15:22 -0700 (PDT)
Message-ID: <b67c18d1-a648-81bc-1144-33fb839f2aa3@redhat.com>
Date: Fri, 22 Sep 2023 10:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Content-Language: en-US
To: Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ani@anisinha.ca" <ani@anisinha.ca>, Aniket Agashe <aniketa@nvidia.com>,
 Neo Jia <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
 <20230915084754.4b49d5c0.alex.williamson@redhat.com>
 <f129b30b-bd0c-4e30-6be9-384b2b79a26b@redhat.com>
 <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 22.09.23 10:11, Ankit Agrawal wrote:
>>>>
>>>> Typically, a command line for a virt machine with NUMA nodes would
>>>> look like :
>>>>
>>>>      -object memory-backend-ram,id=ram-node0,size=1G \
>>>>      -numa node,nodeid=0,memdev=ram-node0 \
>>>>      -object memory-backend-ram,id=ram-node1,size=1G \
>>>>      -numa node,nodeid=1,cpus=0-3,memdev=ram-node1
>>>>
>>>> which defines 2 nodes, one with memory and all CPUs and a second with
>>>> only memory.
>>>>
>>>>      # numactl -H
>>>>      available: 2 nodes (0-1)
>>>>      node 0 cpus: 0 1 2 3
>>>>      node 0 size: 1003 MB
>>>>      node 0 free: 734 MB
>>>>      node 1 cpus:
>>>>      node 1 size: 975 MB
>>>>      node 1 free: 968 MB
>>>>      node distances:
>>>>      node   0   1
>>>>        0:  10  20
>>>>        1:  20  10
>>>>
>>>>
>>>> Could it be a new type of host memory backend ?  Have you considered
>>>> this approach ?
>>>
>>> Good idea.  Fundamentally the device should not be creating NUMA
>>> nodes, the VM should be configured with NUMA nodes and the device
>>> memory associated with those nodes.
>>
>> +1. That would also make it fly with DIMMs and virtio-mem, where you
>> would want NUMA-less nodes ass well (imagine passing CXL memory to a VM
>> using virtio-mem).
>>
> 
> We actually do not add the device memory on the host, instead
> map it into the Qemu VMA using remap_pfn_range(). Please checkout the
> mmap function in vfio-pci variant driver code managing the device.
> https://lore.kernel.org/all/20230915025415.6762-1-ankita@nvidia.com/
> And I think host memory backend would need memory that is added on the
> host.
> 
> Moreover since we want to passthrough the entire device memory, the
> -object memory-backend-ram would have to be passed a size that is equal
> to the device memory. I wonder if that would be too much of a trouble
> for an admin (or libvirt) triggering the Qemu process.
> 
> Both these items are avoided by exposing the device memory as BAR as in the
> current  implementation (referenced above) since it lets Qemu to naturally
> discover the device memory region and do mmap.
> 

Just to clarify: nNUMA nodes for DIMMs/NVDIMMs/virtio-mem are configured 
on the device, not on the memory backend.

e.g., -device pc-dimm,node=3,memdev=mem1,...

-- 
Cheers,

David / dhildenb



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1147AF161
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:55:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBL1-0007PH-GF; Tue, 26 Sep 2023 12:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlBKx-0007K2-Jj
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlBKt-0005FO-2m
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zj3q5flgaeqb4qWSO0AKftsTTGLjck96xlxTasXf9m8=;
 b=YFtUU4LBRphnLt91t05fkPse3hIJljx+lidiMyCg8pIppNxajw56FsofHJb2ZK5wMqPIz2
 HZlRtCMAe2y49d8API0zlW/nyiOwV6eQ9BsiEHp0xx4WZ099G4lgmJMuLJlDF5uQHwFA8I
 U/o0hVujc44jV4U3+YoZzUma8q1GH0A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-20V87Wv1M5KXUOP9m7BrOw-1; Tue, 26 Sep 2023 12:54:56 -0400
X-MC-Unique: 20V87Wv1M5KXUOP9m7BrOw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32329974dbdso3716748f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747295; x=1696352095;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zj3q5flgaeqb4qWSO0AKftsTTGLjck96xlxTasXf9m8=;
 b=ZT+1483pXASI/3Dlknxww9ckxjKC7hROR8nvKzuCQZxVoZGEFRpy1tjkb3HRlKYuT9
 mzXEwEFVPx4KYcUzSPsgtHOurGPN7PUf21aCjS7M7Ubg2xPrwnBmBKq5Uft0zCbTw51M
 9HHYYmpTDtw3BB17rdftPK8pdUzIh00OiRCiIps+crNJ2lUzvm4PGghJjPbGJPsd1xNU
 jHa3Ddl8GHpVVg0SxQZPu1z6aKAYLFj86ZK02Y9mIvOm6p9C3A1tw9xH3gM6Sjd2Im/k
 GjgqPIMKfRIwS0Z3mEpNnPQAgXaa7L/E0vG1MYwbCS8gBYfyeszIO9WEwNDlOXg/AUBw
 oUvQ==
X-Gm-Message-State: AOJu0YxjH4LtMh9DRhzS3Q1fI/5DZib6mqj3KecoDvKMgSGNwMczQgKG
 NafoYpRBjt9rgmTet3/zRIC4XjWl2017TZcwIna+qfdS3hNqiqpJlQGkGnBl4g/dnxfGSIANKmB
 7+4xkBNURtoXIKP4=
X-Received: by 2002:a5d:6a46:0:b0:320:bbb:5ab1 with SMTP id
 t6-20020a5d6a46000000b003200bbb5ab1mr9214616wrw.14.1695747295410; 
 Tue, 26 Sep 2023 09:54:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Nqr7O8eoPW+aNmpN8N1KMhzCwrc/kDWaGvBXbHMsbaDF03/FTFKkfqLcrj3YHBIKNTzYhg==
X-Received: by 2002:a5d:6a46:0:b0:320:bbb:5ab1 with SMTP id
 t6-20020a5d6a46000000b003200bbb5ab1mr9214587wrw.14.1695747294911; 
 Tue, 26 Sep 2023 09:54:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:600:933b:ca69:5a80:230d?
 (p200300cbc73f0600933bca695a80230d.dip0.t-ipconnect.de.
 [2003:cb:c73f:600:933b:ca69:5a80:230d])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a5d50c1000000b003142e438e8csm15127431wrt.26.2023.09.26.09.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 09:54:54 -0700 (PDT)
Message-ID: <769b577a-65b0-dbfe-3e99-db57cea08529@redhat.com>
Date: Tue, 26 Sep 2023 18:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gavin Shan <gshan@redhat.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
 <20230915084754.4b49d5c0.alex.williamson@redhat.com>
 <f129b30b-bd0c-4e30-6be9-384b2b79a26b@redhat.com>
 <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <b67c18d1-a648-81bc-1144-33fb839f2aa3@redhat.com>
 <BY5PR12MB37636F9E84CF92020769D859B0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
In-Reply-To: <BY5PR12MB37636F9E84CF92020769D859B0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 26.09.23 16:52, Ankit Agrawal wrote:
>>>>> Good idea.  Fundamentally the device should not be creating NUMA
>>>>> nodes, the VM should be configured with NUMA nodes and the device
>>>>> memory associated with those nodes.
>>>>
>>>> +1. That would also make it fly with DIMMs and virtio-mem, where you
>>>> would want NUMA-less nodes ass well (imagine passing CXL memory to a VM
>>>> using virtio-mem).
>>>>
>>>
>>> We actually do not add the device memory on the host, instead
>>> map it into the Qemu VMA using remap_pfn_range(). Please checkout the
>>> mmap function in vfio-pci variant driver code managing the device.
>>> https://lore.kernel.org/all/20230915025415.6762-1-ankita@nvidia.com/
>>> And I think host memory backend would need memory that is added on the
>>> host.
>>>
>>> Moreover since we want to passthrough the entire device memory, the
>>> -object memory-backend-ram would have to be passed a size that is equal
>>> to the device memory. I wonder if that would be too much of a trouble
>>> for an admin (or libvirt) triggering the Qemu process.
>>>
>>> Both these items are avoided by exposing the device memory as BAR as in the
>>> current  implementation (referenced above) since it lets Qemu to naturally
>>> discover the device memory region and do mmap.
>>>
>>
>> Just to clarify: nNUMA nodes for DIMMs/NVDIMMs/virtio-mem are configured
>> on the device, not on the memory backend.
>>
>> e.g., -device pc-dimm,node=3,memdev=mem1,...
> 

Alco CCing Gavin, I remember he once experimented with virtio-mem + 
multiple memory-less nodes and it was quite working (because of 
MEM_AFFINITY_HOTPLUGGABLE only on the last node, below).

> Agreed, but still we will have the aforementioned issues viz.
> 1. The backing memory for the memory device would need to be allocated
> on the host. However, we do not add the device memory on the host in this
> case. Instead the Qemu VMA is mapped to the device memory physical
> address using remap_pfn_range().

I don't see why that would be necessary ...

> 2. The memory device need to be passed an allocation size such that all of
> the device memory is mapped into the Qemu VMA. This may not be readily
> available to the admin/libvirt.

... or that. But your proposal roughly looks like what I had in mind, so 
let's focus on that.

> 
> Based on the suggestions here, can we consider something like the
> following?
> 1. Introduce a new -numa subparam 'devnode', which tells Qemu to mark
> the node with MEM_AFFINITY_HOTPLUGGABLE in the SRAT's memory affinity
> structure to make it hotpluggable.

Is that "devnode=on" parameter required? Can't we simply expose any node 
that does *not* have any boot memory assigned as MEM_AFFINITY_HOTPLUGGABLE?

Right now, with "ordinary", fixed-location memory devices 
(DIMM/NVDIMM/virtio-mem/virtio-pmem), we create an srat entry that 
covers the device memory region for these devices with 
MEM_AFFINITY_HOTPLUGGABLE. We use the highest NUMA node in the machine, 
which does not quite work IIRC. All applicable nodes that don't have 
boot memory would need MEM_AFFINITY_HOTPLUGGABLE for Linux to create them.

In your example, which memory ranges would we use for these nodes in SRAT?

> 2. Create several NUMA nodes with 'devnode' which are supposed to be
> associated with the vfio-pci device.
> 3. Pass the numa node start and count to associate the nodes created.
> 
> So, the command would look something like the following.
> ...
>          -numa node,nodeid=2,devnode=on \
>          -numa node,nodeid=3,devnode=on \
>          -numa node,nodeid=4,devnode=on \
>          -numa node,nodeid=5,devnode=on \
>          -numa node,nodeid=6,devnode=on \
>          -numa node,nodeid=7,devnode=on \
>          -numa node,nodeid=8,devnode=on \
>          -numa node,nodeid=9,devnode=on \
>          -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,numa-node-start=2,numa-node-count=8 \

Better an array/list like "numa-nodes=2-9"

... but how would the device actually use these nodes? (which for which?)

-- 
Cheers,

David / dhildenb



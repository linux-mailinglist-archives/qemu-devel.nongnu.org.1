Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D52BD7BDCF2
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 14:59:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpppG-0000G8-Df; Mon, 09 Oct 2023 08:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpppE-0000Ft-NV
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpppD-0001JN-CE
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696856250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qo8iiOB+UxWwxastfmcSl9Amta4/SGZ9A5ncrD+jtHA=;
 b=Pzq1ja16E5ILJileyIpjvurq+Zlpj6/9+zoA9HAw13hM1cBeE2A0P0gzci3TlSThOoLEpB
 D73z92pBnT7f2dBFBbMZXekmfgJ88VSUbTMatpRLqf1wf772tzwEPBv2SbgAA2Fof0YVsg
 XfIRf7C6rF2ZXyQhK4GrcGshaVTOHcM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-hAHvyXo4PGC_k3LqP3UQKA-1; Mon, 09 Oct 2023 08:57:19 -0400
X-MC-Unique: hAHvyXo4PGC_k3LqP3UQKA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-406c6de2cfdso25957265e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 05:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696856238; x=1697461038;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qo8iiOB+UxWwxastfmcSl9Amta4/SGZ9A5ncrD+jtHA=;
 b=XfUpWmTTuTwKzz7MPd4Jdd6GTAqoLbPWKGZHipjYj+NJIk49JhRb1+tB4DQMqwdt/b
 gIuCJjyyOkehZqJDHm5BU5rZS5d+ODKoh+hCGrFFLAfnijFJnFMvDw6vbZYoc8J1i9E7
 7DWtMMnBX6yvbdrIDgwhp0SyQw/bjsID870JpEOLsBg9T2G9935x9Af2dowXwjdcA3MJ
 H6Q+bHGbPtzvEq2ZDoSa9PELOd7FEmwldQbOLICgaytKGud4ILZSvrhXfVykB8bJ4PhW
 i3m0g8f3rt+wKg3oy36i0u6LRx+UCUeqMUcncp73sttRqbFlBxy5bcFMRofiS77ulEKF
 BSSQ==
X-Gm-Message-State: AOJu0YzQeC7AHTd8hslZlZzAFn+9GUxM2QB+ZDlCb8jGbtITSxWpEdIU
 sz10uo4eOCNbJqZNGF0scrON85mOGBHeAlWEnjNhtJp0JP68ClhhTwv9pgdiVlno+FhM6OH6X3k
 Rio7CvT8RDp9Gsec=
X-Received: by 2002:a05:600c:259:b0:401:b204:3b8d with SMTP id
 25-20020a05600c025900b00401b2043b8dmr14588371wmj.27.1696856238017; 
 Mon, 09 Oct 2023 05:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR+VeQGP0PGQYfDILUYl9tS2hpZDs8ue/69+KbZen3PuDTptwpLNbLe/xROQvPjhuT8lJkeA==
X-Received: by 2002:a05:600c:259:b0:401:b204:3b8d with SMTP id
 25-20020a05600c025900b00401b2043b8dmr14588346wmj.27.1696856237574; 
 Mon, 09 Oct 2023 05:57:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548?
 (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de.
 [2003:cb:c733:6400:ae10:4bb7:9712:8548])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a5d4b0f000000b00325aca09ad1sm9665801wrq.24.2023.10.09.05.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 05:57:16 -0700 (PDT)
Message-ID: <10a2b2f6-a52f-a8cd-83cc-8f3b71cbf7f7@redhat.com>
Date: Mon, 9 Oct 2023 14:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] qom: Link multiple numa nodes to device using a
 new object
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, ankita@nvidia.com
Cc: jgg@nvidia.com, alex.williamson@redhat.com, clg@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org, ani@anisinha.ca,
 berrange@redhat.com, eduardo@habkost.net, imammedo@redhat.com,
 mst@redhat.com, eblake@redhat.com, armbru@redhat.com, gshan@redhat.com,
 aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
 dnigam@nvidia.com, udhoke@nvidia.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231007201740.30335-1-ankita@nvidia.com>
 <20231007201740.30335-4-ankita@nvidia.com>
 <20231009133048.00003535@Huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231009133048.00003535@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 09.10.23 14:30, Jonathan Cameron wrote:
> On Sun, 8 Oct 2023 01:47:40 +0530
> <ankita@nvidia.com> wrote:
> 
>> From: Ankit Agrawal <ankita@nvidia.com>
>>
>> NVIDIA GPU's support MIG (Mult-Instance GPUs) feature [1], which allows
>> partitioning of the GPU device resources (including device memory) into
>> several (upto 8) isolated instances. Each of the partitioned memory needs
>> a dedicated NUMA node to operate. The partitions are not fixed and they
>> can be created/deleted at runtime.
>>
>> Unfortunately Linux OS does not provide a means to dynamically create/destroy
>> NUMA nodes and such feature implementation is not expected to be trivial. The
>> nodes that OS discovers at the boot time while parsing SRAT remains fixed. So
>> we utilize the GI Affinity structures that allows association between nodes
>> and devices. Multiple GI structures per BDF is possible, allowing creation of
>> multiple nodes by exposing unique PXM in each of these structures.
>>
>> Introducing a new nvidia-acpi-generic-initiator object, which inherits from
>> the generic acpi-generic-initiator object to allow a BDF to be associated with
>> more than 1 nodes.
>>
>> An admin can provide the range of nodes using numa-node-start and
>> numa-node-count and link it to a device by providing its id. The following
>> sample creates 8 nodes and link them to the device dev0:
>>
>>          -numa node,nodeid=2 \
>>          -numa node,nodeid=3 \
>>          -numa node,nodeid=4 \
>>          -numa node,nodeid=5 \
>>          -numa node,nodeid=6 \
>>          -numa node,nodeid=7 \
>>          -numa node,nodeid=8 \
>>          -numa node,nodeid=9 \
>>          -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
>>          -object nvidia-acpi-generic-initiator,id=gi0,device=dev0,numa-node-start=2,numa-node-count=8 \
> 
> If you go this way, use an array of references to the numa nodes instead of a start and number.
> There is no obvious reason why they should be contiguous that I can see.

Right, a uint16List should do.


-- 
Cheers,

David / dhildenb



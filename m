Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F28FF828AA6
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 18:04:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFUU-00021A-3H; Tue, 09 Jan 2024 12:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rNFUS-0001z7-Qa
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:02:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rNFUR-00061l-00
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704819729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ESOIdMMVr/ueMqi/VldismHDJjiR/eNx90xaSaUeOhk=;
 b=Je67oHUCmEddPbk/Lox3x8/HXxLvMo6Jy7e3kItEz62PZ3hlhTD1aS+r0f4FpRhIFFVyVh
 q9SFo/XokGEIIz+KCrXpcJ+QNc0KC/RyRpNLyOuJ6Uyd+8nC8SGSMAChrNkXU/VlaJMimI
 dSz15Efznuz9x84aCJ+lRCgaGH5mOOA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-vSwPLBj-OT6Pn0pBwED5ew-1; Tue, 09 Jan 2024 12:02:07 -0500
X-MC-Unique: vSwPLBj-OT6Pn0pBwED5ew-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d8f402742so25552805e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 09:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704819726; x=1705424526;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESOIdMMVr/ueMqi/VldismHDJjiR/eNx90xaSaUeOhk=;
 b=SaQEJCAh8S4b1Zk62chEFAkQzyf0DCumTTwu9Qig46jRRjbUoW+ikCLNYUxeyzqX47
 BPcSDbr/jkbQKg7GiTZPYLShPmgA/ej3rPhUB8gaqYmIA0BxUri+/Juqr0JySttmEduh
 Tql6QmsVdaizQpcbGZBBuD5nrFVDhTtOlkm7i8rzfZ3KA/KcpeW6pIhP9Uwnv4jVpcwe
 Xd7D+CnA6LnYnM+MbO3SEUZw2i46ctsA08i9adLpCHOhZ5f0IMgAjl/jKlxVIb8QGt4+
 dtEod1FH3i6Mi1pE6uS++1eI4qR5B5piIeKx00KtAiHlLo6b+CAoydI43AedioSGVNDE
 +rRQ==
X-Gm-Message-State: AOJu0Yy9ZEGsfLml2jwZYVNc2Mr9H6AUNtRiWparO2QoRdp3FCJKTeuf
 MqKAyrhQL5A+hi2MV0P1Qme/eEGzh+e+BZUlw48OLFkRj5JRe7VK9AvZGxI3nFquXnUJuyL6V78
 MBbN250t4K01WQIxuYP5wv+A=
X-Received: by 2002:a05:600c:601f:b0:40e:5270:737a with SMTP id
 az31-20020a05600c601f00b0040e5270737amr444097wmb.107.1704819726183; 
 Tue, 09 Jan 2024 09:02:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG01kxLlyw3pEC9AQtWDHKTNap/26R+YHHVCPqbuPqkUzNAeBWblPmBECEYkuDU5IrQsvI6YQ==
X-Received: by 2002:a05:600c:601f:b0:40e:5270:737a with SMTP id
 az31-20020a05600c601f00b0040e5270737amr444065wmb.107.1704819725725; 
 Tue, 09 Jan 2024 09:02:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:9800:9ff6:a15:cd3e:2d4?
 (p200300cbc73598009ff60a15cd3e02d4.dip0.t-ipconnect.de.
 [2003:cb:c735:9800:9ff6:a15:cd3e:2d4])
 by smtp.gmail.com with ESMTPSA id
 iw14-20020a05600c54ce00b0040d1bd0e716sm4159482wmb.9.2024.01.09.09.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 09:02:05 -0800 (PST)
Message-ID: <16d54fd2-9bab-46cd-a1b7-9742674453d6@redhat.com>
Date: Tue, 9 Jan 2024 18:02:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] qom: new object to associate device to numa node
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ani@anisinha.ca" <ani@anisinha.ca>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "gshan@redhat.com"
 <gshan@redhat.com>, Aniket Agashe <aniketa@nvidia.com>,
 Neo Jia <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>,
 Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
 <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <SA1PR12MB719917E2C9D98C04AE9058C4B0672@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240104103941.019f9b54.alex.williamson@redhat.com>
 <20240109165221.00003b8b@Huawei.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240109165221.00003b8b@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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

On 09.01.24 17:52, Jonathan Cameron wrote:
> On Thu, 4 Jan 2024 10:39:41 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
>> On Thu, 4 Jan 2024 16:40:39 +0000
>> Ankit Agrawal <ankita@nvidia.com> wrote:
>>
>>> Had a discussion with RH folks, summary follows:
>>>
>>> 1. To align with the current spec description pointed by Jonathan, we first do
>>>       a separate object instance per GI node as suggested by Jonathan. i.e.
>>>       a acpi-generic-initiator would only link one node to the device. To
>>>       associate a set of nodes, those number of object instances should be
>>>       created.
>>> 2. In parallel, we work to get the spec updated. After the update, we switch
>>>      to the current implementation to link a PCI device with a set of NUMA
>>>      nodes.
>>>
>>> Alex/Jonathan, does this sound fine?
>>>    
>>
>> Yes, as I understand Jonathan's comments, the acpi-generic-initiator
>> object should currently define a single device:node relationship to
>> match the ACPI definition.
> 
> Doesn't matter for this, but it's a many_device:single_node
> relationship as currently defined. We should be able to support that
> in any new interfaces for QEMU.
> 
>>   Separately a clarification of the spec
>> could be pursued that could allow us to reinstate a node list option
>> for the acpi-generic-initiator object.  In the interim, a user can
>> define multiple 1:1 objects to create the 1:N relationship that's
>> ultimately required here.  Thanks,
> 
> Yes, a spec clarification would work, probably needs some text
> to say a GI might not be an initiator as well - my worry is
> theoretical backwards compatibility with a (probably
> nonexistent) OS that assumes the N:1 mapping. So you may be in
> new SRAT entry territory.
> 
> Given that, an alternative proposal that I think would work
> for you would be to add a 'placeholder' memory node definition
> in SRAT (so allow 0 size explicitly - might need a new SRAT
> entry to avoid backwards compat issues).

Putting all the PCI/GI/... complexity aside, I'll just raise again that 
for virtio-mem something simple like that might be helpful as well, IIUC.

	-numa node,nodeid=2 \
	...
	-device virtio-mem-pci,node=2,... \

All we need is the OS to prepare for an empty node that will get 
populated with memory later.

So if that's what a "placeholder" node definition in srat could achieve 
as well, even without all of the other acpi-generic-initiator stuff, 
that would be great.

-- 
Cheers,

David / dhildenb



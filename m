Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 326857A22F4
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:51:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhB5M-0007iD-IZ; Fri, 15 Sep 2023 11:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qhB4w-0007cf-9U
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qhB4u-0001nW-IS
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694792995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1yYlgACwZSRQ95J8b0x3TSobr/+GgAUNQ1ig/aQjBlQ=;
 b=eiPMk06Dw4Nq6XFQNtDJHr1R29ARxfV+ZWWehE5BWPyzXNUlCRhiK3/DrpdzTzk/PpNhLa
 LyU33wbqgfAO4GYFQa2yhVP/11rkztHaDYjVn5V5ZaPW6eaLxvhpX9H+ZQ1gBcjAe7X4h6
 ca2983wba1mEvxYG+/Z11k2K/bZFJRk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-wsscepk-P4K8b8b7_aCyFg-1; Fri, 15 Sep 2023 11:49:54 -0400
X-MC-Unique: wsscepk-P4K8b8b7_aCyFg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so17472485e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694792993; x=1695397793;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1yYlgACwZSRQ95J8b0x3TSobr/+GgAUNQ1ig/aQjBlQ=;
 b=v66SQjsuIiYekmh3vVntJQNqoCGRJNV3o6naTkd7Kkc4aYIsnZBKpLd36OBhGS3AnQ
 kRuljcVjFA0qp/CKdtNvDgdtd98rMocIkenUgQtc0rNfkLABS5tm6rK2cszcanxIfF9M
 4BeSeeInJke587AOZjQHlT+mJhTUIY1uRgeukcJADvn0HktKWMxUkU8S60jWIUEKY2NB
 hTZ8HTxX21x+MzDttVT4R/YK9mgcbyaueOX4ygL6lpD9B4HWusvoEVIkVy/vF54V9TOC
 1hpNRgmEb27JD0ybkflgh7ZIkoPAT+fVbI4geM69FP7PY4cxgyrIgNTRjpR8iaGZzuVW
 vrtA==
X-Gm-Message-State: AOJu0YwvSV1kUdf3HupydsjPKUusLsCu8Av6S4xEpi1NQy5Bf5UIhO+X
 A5jgBBNcQ3XFStHo+ty9v1kKoAkFSKVeHLKyymL84zMaHaMfIOkzyaPEROi0+jd/vKtIwaSDVyB
 3lQvp1g4kWa93XHA=
X-Received: by 2002:adf:f1c4:0:b0:31f:c1b5:d4b5 with SMTP id
 z4-20020adff1c4000000b0031fc1b5d4b5mr1757568wro.36.1694792992748; 
 Fri, 15 Sep 2023 08:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3jqFIAJg3V3Ep9yih1BIKeyuqOPhrVM38xCs/hSePLX0VAJrn9zxC+INUWFhxyM37e+Pzew==
X-Received: by 2002:adf:f1c4:0:b0:31f:c1b5:d4b5 with SMTP id
 z4-20020adff1c4000000b0031fc1b5d4b5mr1757538wro.36.1694792992350; 
 Fri, 15 Sep 2023 08:49:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c728:e000:a4bd:1c35:a64e:5c70?
 (p200300cbc728e000a4bd1c35a64e5c70.dip0.t-ipconnect.de.
 [2003:cb:c728:e000:a4bd:1c35:a64e:5c70])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a5d5008000000b0031f8be5b41bsm4758095wrt.5.2023.09.15.08.49.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 08:49:51 -0700 (PDT)
Message-ID: <2ef7f73b-4db3-cc6d-1141-40c6d8a32f33@redhat.com>
Date: Fri, 15 Sep 2023 17:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 3/4] hw/arm/virt-acpi-build: patch guest SRAT for NUMA
 nodes
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, ankita@nvidia.com
Cc: jgg@nvidia.com, alex.williamson@redhat.com, clg@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org, ani@anisinha.ca,
 aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-4-ankita@nvidia.com>
 <20230915165251.688fea5e@imammedo.users.ipa.redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230915165251.688fea5e@imammedo.users.ipa.redhat.com>
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

On 15.09.23 16:52, Igor Mammedov wrote:
> On Thu, 14 Sep 2023 19:45:58 -0700
> <ankita@nvidia.com> wrote:
> 
>> From: Ankit Agrawal <ankita@nvidia.com>
>>
>> During bootup, Linux kernel parse the ACPI SRAT to determine the PXM ids.
>> This allows for the creation of NUMA nodes for each unique id.
>>
>> Insert a series of the unique PXM ids in the VM SRAT ACPI table. The
>> range of nodes can be determined from the "dev_mem_pxm_start" and
>> "dev_mem_pxm_count" object properties associated with the device. These
>> nodes as made MEM_AFFINITY_HOTPLUGGABLE. This allows the kernel to create
>> memory-less NUMA nodes on bootup to which a subrange (or entire range) of
>> device memory can be added/removed.
> 
> QEMU already has 'memory devices'. perhaps this case belongs to the same class
> CCing David.

There is demand for something similar for memory devices (DIMMs, 
virtio-mem) as well.

-- 
Cheers,

David / dhildenb



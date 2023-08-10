Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECAF777759
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 13:40:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU3hE-0007j0-78; Thu, 10 Aug 2023 07:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qU3h4-0007iJ-AC
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qU3h0-00085J-Cz
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691666340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pp+EZx2Jtbnhm6RJgieq1zEP7WiMD8qk35ak2B53/xY=;
 b=fMgcDaYP1gEn3qNWnYWu6L6iHf8MISloqdW8BCNlACMvrU/D2PHDKa9vIW4fOglGCBhB/b
 jx23AAo2FVZdHzc7lBBd2N6xl173NwretCvqTSCI9RtbDaXzCSxmchDRDQbNT/n0+8IghR
 4RBAywW8S9I+UYY5142jYqhrY4APwSo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-6D33pO0SMqayj4JqFiC9aQ-1; Thu, 10 Aug 2023 07:18:59 -0400
X-MC-Unique: 6D33pO0SMqayj4JqFiC9aQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe216798e9so5393805e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 04:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691666338; x=1692271138;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pp+EZx2Jtbnhm6RJgieq1zEP7WiMD8qk35ak2B53/xY=;
 b=kDvhKnNgLfpszRDwV6tcm7TIqkLPm5I548GkGNfpjrTh4lloucbef3YroWoWhFII1h
 N5BFJ1F6hN7YW8d/D39MX5EyCrP7icurVKOnJiwgMTZ/7saHkQiT6GDgEoqjsaSVqxQM
 vC1/3iQbrrcbssS3bSJlX+MKQh7R52USJmqAy9v/4deaIi9oICI46PB+11jyzEAUdItP
 x3zOQJuYHrnsBTVxe0cqWfRVCF0aEGun3lKXf7DZWaDKp4KqexsDrCzZ317FIOl7QKNR
 BpqFcwmMmkaYACH4OLVZeWa9uJqjMeN/0SwfdcEmKnM9A0CM/fWdJtBYi2lijpPLuefA
 dyuQ==
X-Gm-Message-State: AOJu0YzDnsekjpCNfSmZaU7PNmoi/bREaI20wxuXEsse2QOQsr3WHFqW
 Hi+1jwtTCCirem24lJK0nsgI8knoeRBCYt6CPB3N/d4WkzjIMpeUFKSXHxkcx9+0p+lS6WLeP6A
 UmtQkVkZaevZ2rt8=
X-Received: by 2002:a05:600c:2110:b0:3fe:22a9:910 with SMTP id
 u16-20020a05600c211000b003fe22a90910mr1761715wml.14.1691666337886; 
 Thu, 10 Aug 2023 04:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqqLYrhI1TLVlMgqRxwE6UMmFmmJCD2RU7DuOMU6qfaU+z/Yc6vZq/oj7pb2lTeyFRbjgyyA==
X-Received: by 2002:a05:600c:2110:b0:3fe:22a9:910 with SMTP id
 u16-20020a05600c211000b003fe22a90910mr1761696wml.14.1691666337468; 
 Thu, 10 Aug 2023 04:18:57 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a1c6a15000000b003fc02218d6csm4657610wmc.25.2023.08.10.04.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 04:18:57 -0700 (PDT)
Message-ID: <41f42c91-bcbe-cba6-c987-ae34d0879a9d@redhat.com>
Date: Thu, 10 Aug 2023 13:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: CXL volatile memory is not listed
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Maverickk 78 <maverickk1778@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
 <f64d5006-ae77-cc10-270a-0c0fc6e3a0ef@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f64d5006-ae77-cc10-270a-0c0fc6e3a0ef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.156, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10.08.23 12:59, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Cc'ing Igor and David.
> 
> On 9/8/23 00:51, Maverickk 78 wrote:
>> Hello,
>>
>> I am running qemu-system-x86_64
>>
>> qemu-system-x86_64 --version
>> QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
>>
>> qemu-system-x86_64 \
>> -m 2G,slots=4,maxmem=4G \
>> -smp 4 \
>> -machine type=q35,accel=kvm,cxl=on \
>> -enable-kvm \
>> -nographic \
>> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
>> -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
>> -object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=1G,share=true \
>> -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
>> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
>>
>>
>> I was expecting the CXL memory to be listed in "System Ram", the lsmem
>> shows only 2G memory which is System RAM, it's not listing the CXL
>> memory.

We are talking about the memory via inside the guest, right?

In the guest, that memory most probably has to be added as "System RAM" 
explicitly using the dax/kmem driver.

https://lwn.net/Articles/922944/

Contains some details on how to use "daxctl reconfigure-device".

-- 
Cheers,

David / dhildenb



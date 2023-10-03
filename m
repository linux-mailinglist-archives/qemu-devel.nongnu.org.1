Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 198687B6072
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 07:40:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnY8b-0002q0-Dt; Tue, 03 Oct 2023 01:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnY8V-0002n3-Tv
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 01:39:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnY8S-0001A0-Oi
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 01:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696311596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQwXNFD1mmfjoJgOAPuBsqjLKn6rTm/R5yvDWHsaB84=;
 b=DZk7neD/CXpX/Ygnl5m1z6WOn9BIazEvVWntfXkGzbBjsYL3qzRxG7R3bOaRlkVfQ+d5l5
 wHWvW12fEH9Uzk0FUs90riUKkE4jKXNjvR5AgiiZxBuyiUr3kP78+QAAUqs9MdGXZPqx8S
 VJbobDmgDq0tA9oRvwZiEj6eTVei/7U=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-KVqgL4lYNaKBVrRMl1CtKw-1; Tue, 03 Oct 2023 01:39:45 -0400
X-MC-Unique: KVqgL4lYNaKBVrRMl1CtKw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6933caa92a9so427861b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 22:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696311584; x=1696916384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tQwXNFD1mmfjoJgOAPuBsqjLKn6rTm/R5yvDWHsaB84=;
 b=Y1BBwqdHbaO4dz3GKBFAVP9+TUiRtXZlDr+CGK3QZyVFKOh9t7ss/ZzaHxim87GhA6
 k0EbN496tyUPXOlPQXBqW1xw0GLO2931FIc/cTvkwHlUTa6ihl0Uo/DwH89OUXQOtxmq
 3Jh3AqC4toWMprSnJuyyM9J9S4lFZdmXfZw19BGBF4ch0bs+Dm3WhPy+QAhMy0UQAubI
 WXFn5n+gR3TfU8M3t1jwqchoJLrRpaLGV/Qq4Ymxa2Gk/FlsBZjcTCuIhRQSkm/3WWnL
 nQpLlXhszq+3++2LVFDugFqlb6XuqcOvetq0HfQnblHeMe85oSvMhZVRZ0dFdx1kWK6R
 xiYA==
X-Gm-Message-State: AOJu0Yw3r9v3pUTEUKpV8KskVfRHzgzQIShHKOiZ43Zp7Gzj2wZsaWzb
 Wucx+iOZ9pQL6y3sbIR9mqZMRwCarMvVyHw+OfyT2vlPFYcnwCcEsLnXTLrysiuDumtSnqsLrAv
 VSx8Km0+7YntJtqA=
X-Received: by 2002:a05:6a20:158e:b0:159:b4ba:a5bf with SMTP id
 h14-20020a056a20158e00b00159b4baa5bfmr13579909pzj.13.1696311583971; 
 Mon, 02 Oct 2023 22:39:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPkSJRLDsfc7NHFoo2ijK+LZFDK8qrCQ6tImltiPB06L7AJXKUuGdHXTisatyrgD+mm3e6Dg==
X-Received: by 2002:a05:6a20:158e:b0:159:b4ba:a5bf with SMTP id
 h14-20020a056a20158e00b00159b4baa5bfmr13579866pzj.13.1696311583614; 
 Mon, 02 Oct 2023 22:39:43 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a170903019200b001c72f4334afsm471544plg.20.2023.10.02.22.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 22:39:43 -0700 (PDT)
Message-ID: <dafa4d84-4e23-6bb9-fa33-17861c28ee4a@redhat.com>
Date: Tue, 3 Oct 2023 15:39:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC V2 05/37] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-6-salil.mehta@huawei.com>
 <d58c51d2-53e4-3873-7c87-c6ccc3025ed9@redhat.com>
 <2a1d9be1afb54290b6b0e4a54711e030@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <2a1d9be1afb54290b6b0e4a54711e030@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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


Hi Salil,

On 10/3/23 02:20, Salil Mehta wrote:
>> From: Gavin Shan <gshan@redhat.com>
>> Sent: Wednesday, September 27, 2023 7:52 AM
>> To: Salil Mehta <salil.mehta@huawei.com>; qemu-devel@nongnu.org; qemu-
>> arm@nongnu.org
>> Cc: maz@kernel.org; jean-philippe@linaro.org; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; lpieralisi@kernel.org;
>> peter.maydell@linaro.org; richard.henderson@linaro.org;
>> imammedo@redhat.com; andrew.jones@linux.dev; david@redhat.com;
>> philmd@linaro.org; eric.auger@redhat.com; will@kernel.org; ardb@kernel.org;
>> oliver.upton@linux.dev; pbonzini@redhat.com; mst@redhat.com;
>> rafael@kernel.org; borntraeger@linux.ibm.com; alex.bennee@linaro.org;
>> linux@armlinux.org.uk; darren@os.amperecomputing.com;
>> ilkka@os.amperecomputing.com; vishnu@os.amperecomputing.com;
>> karl.heubaum@oracle.com; miguel.luis@oracle.com; salil.mehta@opnsrc.net;
>> zhukeqian <zhukeqian1@huawei.com>; wangxiongfeng (C)
>> <wangxiongfeng2@huawei.com>; wangyanan (Y) <wangyanan55@huawei.com>;
>> jiakernel2@gmail.com; maobibo@loongson.cn; lixianglai@loongson.cn
>> Subject: Re: [PATCH RFC V2 05/37] accel/kvm: Extract common KVM vCPU
>> {creation,parking} code
>>
>> Hi Salil,
>>
>> On 9/26/23 20:04, Salil Mehta wrote:
>>> KVM vCPU creation is done once during the initialization of the VM when Qemu
>>> threads are spawned. This is common to all the architectures. If the architecture
>>> supports vCPU hot-{un}plug then this KVM vCPU creation could be deferred to
>>> later point as well. Some architectures might in any case create KVM vCPUs for
>>> the yet-to-be plugged vCPUs (i.e. QoM Object & thread does not exists) during VM
>>> init time and park them.
>>>
>>> Hot-unplug of vCPU results in destruction of the vCPU objects in QOM but
>>> the KVM vCPU objects in the Host KVM are not destroyed and their representative
>>> KVM vCPU objects in Qemu are parked.
>>>
>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>> ---
>>>    accel/kvm/kvm-all.c  | 61 ++++++++++++++++++++++++++++++++++----------
>>>    include/sysemu/kvm.h |  2 ++
>>>    2 files changed, 49 insertions(+), 14 deletions(-)
>>>
>>
>> The most important point seems missed in the commit log: The KVM vCPU objects,
>> including those hotpluggable objects, need to be in place before in-host GICv3
>> is initialized. So we need expose kvm_create_vcpu() to make those KVM vCPU
>> objects in place, even for those non-present vCPUs.
> 
> 
> This is a patch common to all architectures. The point you are making is specific
> to the ARM architecture. This patch is now part of the common patch-set. Here,
> 
> https://lore.kernel.org/qemu-devel/20230930001933.2660-1-salil.mehta@huawei.com/
> 
> 

Yes, reviewed it again. Lets have more discussions over there.

Thanks,
Gavin



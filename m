Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F117BE230
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:12:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpqyc-000814-4o; Mon, 09 Oct 2023 10:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpqyZ-00080d-Et
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpqyX-0006mf-F5
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696860672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxlXWmITfzST20kPRPo6Pmoy2PQ26O72HSJaXVgs8lQ=;
 b=SQcJjC1TEgbJH7nDBZbO5obD4PGImV1l0WsiVcCvZwzBu7L4iWTuXX4VHtc7aP1tdMTCwU
 G8dDulLisGbej9Bh7PScwAVHB4wgAorMbPnMvzofK64i5JXQ9JdFE17s3K1bOE6k55aloY
 WSXR55WWVrpo1KH1zA4Lk/DN0pJAm1k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-ZcZv_TKYOCiqExiOB2a_8A-1; Mon, 09 Oct 2023 10:11:10 -0400
X-MC-Unique: ZcZv_TKYOCiqExiOB2a_8A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso3220883f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 07:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696860669; x=1697465469;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LxlXWmITfzST20kPRPo6Pmoy2PQ26O72HSJaXVgs8lQ=;
 b=UTRFvGNnZto30fXc/ONtrRjRbuHTR9HayGaGvrQhakx0ppCjdJUKjJ7C1pXXowlJr6
 MC4oVhA8skiyIYkmOJQX3Rzpe4/Cwo6kcsGR8vWGmpUymIkkBl81bGImUwRFdcCiCMb9
 8+G4s9wDZi56oa6q+gXH67W49GXBxqcuGQXgWvAdDEFvI4WV1QsthKrtevYs93S2llJn
 dyxWRQecAO0P0mowcHDuhVMKlGYXw0kcQfk+xMfEd5OsxvpKCG+JhzKpkWyEHij6dEuW
 PLxVuNRY9CSZxzVPqth7mjSPydzwjnIAw1HOoDrCmnvyz03xKu5VgdoosytTkQMvQm1d
 bg9w==
X-Gm-Message-State: AOJu0YyPrX23Rd4+McvDRK7MNfe2FOXUnwVX3uw1XOkNW8u10F0ji6g6
 F2Umu9VOfFOrKeS6hh5+vPtiqqOwc8sQYQQGSCyLu45RoVYkhkMwpAzVFIDd5lXi3o2BszKoJWM
 3UBznKVl4wMpNhDGhU0GFoYI=
X-Received: by 2002:a5d:46cf:0:b0:31f:8e7c:6ebe with SMTP id
 g15-20020a5d46cf000000b0031f8e7c6ebemr12959046wrs.5.1696860669656; 
 Mon, 09 Oct 2023 07:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPc5rTWDo84dwa8Pl2iguI9Ib++hH+6jY9LRoCLkmOwVDi8JGu0GVWjlicFoxQRhFc++2umg==
X-Received: by 2002:a5d:46cf:0:b0:31f:8e7c:6ebe with SMTP id
 g15-20020a5d46cf000000b0031f8e7c6ebemr12959014wrs.5.1696860669084; 
 Mon, 09 Oct 2023 07:11:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548?
 (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de.
 [2003:cb:c733:6400:ae10:4bb7:9712:8548])
 by smtp.gmail.com with ESMTPSA id
 b3-20020adff243000000b0031431fb40fasm9819678wrp.89.2023.10.09.07.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 07:11:08 -0700 (PDT)
Message-ID: <ae2e0fc1-7967-2bae-e4fa-b4d886ba4671@redhat.com>
Date: Mon, 9 Oct 2023 16:11:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
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
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
References: <20231009112812.10612-1-salil.mehta@huawei.com>
 <20231009112812.10612-2-salil.mehta@huawei.com>
 <a02eae26-6018-6f5c-1b82-e6061544022b@redhat.com>
 <63f8e47efcd045b1b8481f6fd427c4b1@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH V3 01/10] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
In-Reply-To: <63f8e47efcd045b1b8481f6fd427c4b1@huawei.com>
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

On 09.10.23 15:42, Salil Mehta wrote:
> Hi David,
> Thanks for the review.
> 
>> From: David Hildenbrand <david@redhat.com>
>> Sent: Monday, October 9, 2023 1:21 PM
>> To: Salil Mehta <salil.mehta@huawei.com>; qemu-devel@nongnu.org; qemu-arm@nongnu.org
>> Cc: maz@kernel.org; jean-philippe@linaro.org; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; lpieralisi@kernel.org;
>> peter.maydell@linaro.org; richard.henderson@linaro.org;
>> imammedo@redhat.com; andrew.jones@linux.dev; philmd@linaro.org;
>> eric.auger@redhat.com; oliver.upton@linux.dev; pbonzini@redhat.com;
>> mst@redhat.com; will@kernel.org; gshan@redhat.com; rafael@kernel.org;
>> alex.bennee@linaro.org; linux@armlinux.org.uk;
>> darren@os.amperecomputing.com; ilkka@os.amperecomputing.com;
>> vishnu@os.amperecomputing.com; karl.heubaum@oracle.com;
>> miguel.luis@oracle.com; salil.mehta@opnsrc.net; zhukeqian
>> <zhukeqian1@huawei.com>; wangxiongfeng (C) <wangxiongfeng2@huawei.com>;
>> wangyanan (Y) <wangyanan55@huawei.com>; jiakernel2@gmail.com;
>> maobibo@loongson.cn; lixianglai@loongson.cn; Linuxarm <linuxarm@huawei.com>
>> Subject: Re: [PATCH V3 01/10] accel/kvm: Extract common KVM vCPU
>> {creation,parking} code
>>
>> On 09.10.23 13:28, Salil Mehta wrote:
>>> KVM vCPU creation is done once during the initialization of the VM when Qemu
>>> thread is spawned. This is common to all the architectures.
>>>
>>> Hot-unplug of vCPU results in destruction of the vCPU object in QOM but the
>>> corresponding KVM vCPU object in the Host KVM is not destroyed and its
>>> representative KVM vCPU object/context in Qemu is parked.
>>>
>>> Refactor common logic so that some APIs could be reused by vCPU Hotplug code.
>>>
>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>
>> [...]
>>
>>>
>>>    int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>> @@ -395,19 +434,14 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>>>
>>>        trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>>>
>>> -    ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
>>> +    ret = kvm_create_vcpu(cpu);
>>>        if (ret < 0) {
>>> -        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
>>> +        error_setg_errno(errp, -ret,
>>> +                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
>>
>> Unrelated change.
> 
> 
> It is related. I think you missed kvm_get_vcpu -> kvm_create_vcpu change
> in the string.

Indeed, I did :)

> 
> 
>>>                             kvm_arch_vcpu_id(cpu));
>>>            goto err;
>>>        }
>>>
>>> -    cpu->kvm_fd = ret;
>>> -    cpu->kvm_state = s;
>>> -    cpu->vcpu_dirty = true;
>>> -    cpu->dirty_pages = 0;
>>> -    cpu->throttle_us_per_full = 0;
>>> -
>>>        mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>>>        if (mmap_size < 0) {
>>>            ret = mmap_size;
>>> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
>>> index 399aaeb0ec..08e2dc253f 100644
>>> --- a/accel/kvm/trace-events
>>> +++ b/accel/kvm/trace-events
>>> @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
>>>    kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
>>>    kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
>>>    kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
>>> +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id) "creating KVM cpu: cpu_index: %d arch vcpu-id: %lu"
>>> +kvm_get_vcpu(unsigned long arch_cpu_id) "unparking KVM vcpu: arch vcpu-id: %lu"
>>> +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "destroy vcpu: cpu_index: %d arch vcpu-id: %lu"
>>> +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "parking KVM vcpu: cpu_index: %d arch vcpu-id: %lu"
>>
>> It's a bit confusing that there is now
>>
>> 1) create (create new or return parked)
>> 2) destroy (cleanup + park)
>> 3) park (park only)
>>
>> Why would one use 2) instead of 3) or the other way around? But I
>> suspect that kvm_destroy_vcpu() is only supposed to be a KVM-internal
>> helper ...
> 
> kvm_destroy_vcpu is more than just parking:
> 
> 1. Arch destroy vcpu
> 2. Unmap cpu->kvm_run
> 3. Parking logic
> 
> To support virtual CPU Hotplug on ARM platforms we pre-create all
> the KVM vCPUs but their corresponding Qemu threads are not spawned
> (and hence cpu->kvm_run is not mapped). Unplugged vCPUs remains
> parked in the list. Hence, only step-3 is required.

IIUC, your current flow is going to be

1) Create
2) Park
3) Create [which ends up reusing the parked VCPU]
4) Destroy [when unplugging the CPU]

If that's the case, that API really is suboptimal.

What speaks against an API that models 1) and 2) in a single step

kvm_precreate_vcpu
kvm_create_vcpu
kvm_destroy_vcpu

One could even make kvm_create_vcpu() fail on ARM if the VCPU hasn't 
been pre-created.

Or did I get it all wrong? :)

-- 
Cheers,

David / dhildenb



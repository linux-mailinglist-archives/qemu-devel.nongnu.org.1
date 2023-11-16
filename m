Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A13207EDDAB
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 10:35:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Ylq-0008NF-OB; Thu, 16 Nov 2023 04:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1r3Yli-0008H6-3Z
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 04:34:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1r3Ylf-00027O-96
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 04:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700127274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QuTQg4Oyw0769gWhs5zrEa0uRXRA0CYB8AH2mm3Alio=;
 b=Qhy+eINqONiJGkAqinAIBWMvx/1jUkLVtu8u3+uBWZius1Q0xKtFMqg2Hi5IpD6rWUlQ9H
 75P/oHdDpmPWXA5QoDaNpkqS+GhwTrW+VKO4IklpxvSZ+shV8c+JAuw69SQtYcNSPOYlF4
 3O1KYeM77Ir5sIjPSBIuGVFTk6v8FO4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-lFM6rTf7Nj-imFisNt8gEA-1; Thu, 16 Nov 2023 04:34:32 -0500
X-MC-Unique: lFM6rTf7Nj-imFisNt8gEA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5bd4037c930so89891a12.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 01:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700127271; x=1700732071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QuTQg4Oyw0769gWhs5zrEa0uRXRA0CYB8AH2mm3Alio=;
 b=FoAg2ClEm/5xtGn9JlNTU6Id4+C7iwnmzn+ebcjZsqOWAlXihKXx+Pb/TT3UCoEWRs
 o69xAI3WPkIxFKeDoGUd8LKMCLgkFRw4OpCoJ87JYVEkDC/a6WN+D9Za003Z5NaMfrXN
 nsNKCHpHadLgn6tPdPHoq3qGVrV1VJgn1rw5tLSOyVa7KoRPHs9oDf+RDdWUs6uicX/7
 J7Yrh0Q7iUnaKYVdgV1287LLPKsPSiqUE9K+eE0judNaZvhLO9yOR6w2Zq67SUtP9QdJ
 DOoM6m0oxUNHRZmGzM6Cs91V8fodou6SB0S/hqShHGLk6CTqTzHmgPB1tkVo6aSJbhYK
 Z5zQ==
X-Gm-Message-State: AOJu0YwXibO0UXpLT32KUSgemuc3bVUa3YtGzCHS4BvX2woeRod0U1fz
 GrreOD/2+TGAn8xD4EUs1+dPKX1X13QdFcqulYKNGyQxEpKvq09q24QCX3jHmPdw3HH+F4+Zj4N
 M3gSe26q+lcJ5iDA=
X-Received: by 2002:a17:902:e74f:b0:1cd:fbc7:270e with SMTP id
 p15-20020a170902e74f00b001cdfbc7270emr5851476plf.2.1700127271316; 
 Thu, 16 Nov 2023 01:34:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ3UeuSMW7xPsMYOmA57fbxtROXVUGVQani83bu2ED+ywYPs4rrxWnRJXXPCovjl8EldRadQ==
X-Received: by 2002:a17:902:e74f:b0:1cd:fbc7:270e with SMTP id
 p15-20020a170902e74f00b001cdfbc7270emr5851458plf.2.1700127270996; 
 Thu, 16 Nov 2023 01:34:30 -0800 (PST)
Received: from [10.72.112.142] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a170902f68e00b001ca4ad86357sm8743043plg.227.2023.11.16.01.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 01:34:30 -0800 (PST)
Message-ID: <eb794c0d-51c8-ecbd-2b24-d93ae00466a0@redhat.com>
Date: Thu, 16 Nov 2023 17:34:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20231113081713.153615-1-shahuang@redhat.com>
 <3a570842-aaec-6447-b043-d908e83717ec@redhat.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <3a570842-aaec-6447-b043-d908e83717ec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.895, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Sebastian,

On 11/15/23 20:17, Sebastian Ott wrote:
> Hi,
> 
> On Mon, 13 Nov 2023, Shaoqin Huang wrote:
>> +    ``pmu-filter={A,D}:start-end[;...]``
>> +        KVM implements pmu event filtering to prevent a guest from 
>> being able to
>> +    sample certain events. It has the following format:
>> +
>> +    pmu-filter="{A,D}:start-end[;{A,D}:start-end...]"
>> +
>> +    The A means "allow" and D means "deny", start if the first event 
>> of the
>                                                        ^
>                                                        is
> 

Thanks for point it out.

> Also it should be stated that the first filter action defines if the whole
> list is an allow or a deny list.
> 
>> +static void kvm_arm_pmu_filter_init(CPUState *cs)
>> +{
>> +    struct kvm_pmu_event_filter filter;
>> +    struct kvm_device_attr attr = {
>> +        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
>> +        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
>> +    };
>> +    KVMState *kvm_state = cs->kvm_state;
>> +    char *tmp;
>> +    char *str, act;
>> +
>> +    if (!kvm_state->kvm_pmu_filter)
>> +        return;
>> +
>> +    tmp = g_strdup(kvm_state->kvm_pmu_filter);
>> +
>> +    for (str = strtok(tmp, ";"); str != NULL; str = strtok(NULL, ";")) {
>> +        unsigned short start = 0, end = 0;
>> +
>> +        sscanf(str, "%c:%hx-%hx", &act, &start, &end);
>> +        if ((act != 'A' && act != 'D') || (!start && !end)) {
>> +            error_report("skipping invalid filter %s\n", str);
>> +            continue;
>> +        }
>> +
>> +        filter = (struct kvm_pmu_event_filter) {
>> +            .base_event     = start,
>> +            .nevents        = end - start + 1,
>> +            .action         = act == 'A' ? KVM_PMU_EVENT_ALLOW :
>> +                                           KVM_PMU_EVENT_DENY,
>> +        };
>> +
>> +        attr.addr = (uint64_t)&filter;
> 
> That could move to the initialization of attr (the address of filter
> doesn't change).
> 

It looks better. Will change it.

>> +        if (!kvm_arm_set_device_attr(cs, &attr, "PMU Event Filter")) {
>> +            error_report("Failed to init PMU Event Filter\n");
>> +            abort();
>> +        }
>> +    }
>> +
>> +    g_free(tmp);
>> +}
>> +
>> void kvm_arm_pmu_init(CPUState *cs)
>> {
>>     struct kvm_device_attr attr = {
>>         .group = KVM_ARM_VCPU_PMU_V3_CTRL,
>>         .attr = KVM_ARM_VCPU_PMU_V3_INIT,
>>     };
>> +    static bool pmu_filter_init = false;
>>
>>     if (!ARM_CPU(cs)->has_pmu) {
>>         return;
>>     }
>> +    if (!pmu_filter_init) {
>> +        kvm_arm_pmu_filter_init(cs);
>> +        pmu_filter_init = true;
> 
> pmu_filter_init could move inside kvm_arm_pmu_filter_init() - maybe
> together with a comment that this only needs to be called for 1 vcpu.

Good idea. Will do that.

Thanks,
Shaoqin

> 
> Thanks,
> Sebastian
> 



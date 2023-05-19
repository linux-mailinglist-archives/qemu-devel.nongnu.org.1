Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF727709695
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 13:33:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzyLV-0003wq-JV; Fri, 19 May 2023 07:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1pzyLT-0003wZ-CK
 for qemu-devel@nongnu.org; Fri, 19 May 2023 07:32:28 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1pzyLR-0007Gr-Kv
 for qemu-devel@nongnu.org; Fri, 19 May 2023 07:32:27 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-62382e86f81so13617976d6.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 04:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684495943; x=1687087943;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g3TvzKEFJnEMVCYxQv3dx+AxrtRbYrFctzVbiDmqYTs=;
 b=tvyvGQIkyFg/QCoiEa0UeGBQjd8gxX0G7fOUfNgebzOMJ50pnT5xpoN+2mC4+k+9Y/
 M/VLVRsGmFV6v6lNlF1Np56bJVOlLegAqdZ22n7VyfHpGaSUWPu8Bnp+fzr0TQzUFE0j
 VsNtW9BRY/q31qBZX5PH81ntTucECtMnbmXpLXGuZ46yIwX4h7sdia5VE9Uyv9QsawEt
 oxfeuE47xZJsHOuAuOLM/oSOGDlUO2Wp0eGKKK8veSEJ3rN92i2zTL0P+gISYk/psWvO
 AqkvnLTOpAV3AWLiS2XOPnmTklztVfrtkX9ySNnqud6KnukSwOQmXwN0eUAayx3dRmQK
 3cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684495943; x=1687087943;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g3TvzKEFJnEMVCYxQv3dx+AxrtRbYrFctzVbiDmqYTs=;
 b=TG9KNPIjQDhkTG+QBKjbmQ5Jz38wQhLT8MWWJz8HNev6QkYf/3bwMNqZpBWClIaTiM
 10QKMAYxjX3foqN1EzFS79iy+IlERAFnVut4cGlH86nI0BHYClW9NPa/e2ISzJZa3DOW
 PUBLKz9asfU2LYFFtUwLnnaSDj16yRQADhferQ19IN/FaEeUSwSdKUzZ8PClgNHmECu9
 ZqH/iQ4YMoY5DQU37C9kVxs06UXo5pJDO5n0KE5S4z5NB1apTnQaebN21YKQ09NTcgV/
 3OWAddf1EB2CKgNy0b5bSXtepMSANrywLIKhggFDYuWXSG0rRhqtX0LdXtzGVrhkxS3l
 Ut9Q==
X-Gm-Message-State: AC+VfDwsM+BmkWxJDyyKtj01JH8DSVt2LjaJggkgZ66+gcNWsAQqKyvq
 K2qnS0gfqnPO7VxzoRUuSX/IsA==
X-Google-Smtp-Source: ACHHUZ4McPgkIOWVlNQv7DKt6gIkIYkxSmLf+YmnMYiai+UccZkc/IIaY/7fNygmyFMM4n1AJjVolg==
X-Received: by 2002:ad4:5742:0:b0:621:64c7:235f with SMTP id
 q2-20020ad45742000000b0062164c7235fmr3915277qvx.27.1684495943052; 
 Fri, 19 May 2023 04:32:23 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr.
 [176.184.41.228]) by smtp.gmail.com with ESMTPSA id
 l9-20020ac87249000000b003e89e2b3c23sm1216558qtp.58.2023.05.19.04.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 04:32:22 -0700 (PDT)
Message-ID: <d6118a9c-1e3f-4c29-520e-26562bbac600@linaro.org>
Date: Fri, 19 May 2023 13:32:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] Add support for RAPL MSRs in KVM/Qemu
Content-Language: en-US
To: Anthony Harivel <aharivel@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com
References: <20230517130730.85469-1-aharivel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230517130730.85469-1-aharivel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=philmd@linaro.org; helo=mail-qv1-xf2c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Anthony,

On 17/5/23 15:07, Anthony Harivel wrote:
> Starting with the "Sandy Bridge" generation, Intel CPUs provide a RAPL
> interface (Running Average Power Limit) for advertising the accumulated
> energy consumption of various power domains (e.g. CPU packages, DRAM,
> etc.).
> 
> The consumption is reported via MSRs (model specific registers) like
> MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are
> 64 bits registers that represent the accumulated energy consumption in
> micro Joules. They are updated by microcode every ~1ms.
> 
> For now, KVM always returns 0 when the guest requests the value of
> these MSRs. Use the KVM MSR filtering mechanism to allow QEMU handle
> these MSRs dynamically in userspace.
> 
> To limit the amount of system calls for every MSR call, create a new
> thread in QEMU that updates the "virtual" MSR values asynchronously.
> 
> Each vCPU has its own vMSR to reflect the independence of vCPUs. The
> thread updates the vMSR values with the ratio of energy consumed of
> the whole physical CPU package the vCPU thread runs on and the
> thread's utime and stime values.
> 
> All other non-vCPU threads are also taken into account. Their energy
> consumption is evenly distributed among all vCPUs threads running on
> the same physical CPU package.
> 
> This feature is activated with -accel kvm,rapl=true.
> 
> Actual limitation:
> - Works only on Intel host CPU because AMD CPUs are using different MSR
>    adresses.
> 
> - Only the Package Power-Plane (MSR_PKG_ENERGY_STATUS) is reported at
>    the moment.
> 
> - Since each vCPU has an independent vMSR value, the vCPU topology must
>    be changed to match that reality. There must be a single vCPU per
>    virtual socket (e.g.: -smp 4,sockets=4). Accessing pkg-0 energy will
>    give vCPU 0 energy, pkg-1 will give vCPU 1 energy, etc.
> 
> Signed-off-by: Anthony Harivel <aharivel@redhat.com>
> ---


> diff --git a/target/i386/kvm/vmsr_energy.h b/target/i386/kvm/vmsr_energy.h
> new file mode 100644
> index 000000000000..5f79d2cbe00d
> --- /dev/null
> +++ b/target/i386/kvm/vmsr_energy.h
> @@ -0,0 +1,80 @@
> +/*
> + * QEMU KVM support -- x86 virtual energy-related MSR.
> + *
> + * Copyright 2023 Red Hat, Inc. 2023
> + *
> + *  Author:
> + *      Anthony Harivel <aharivel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef VMSR_ENERGY_H
> +#define VMSR_ENERGY_H
> +
> +#include "qemu/osdep.h"
> +
> +#include <numa.h>
> +
> +/*
> + * Define the interval time in micro seconds between 2 samples of
> + * energy related MSRs
> + */
> +#define MSR_ENERGY_THREAD_SLEEP_US 1000000.0
> +
> +/*
> + * Thread statistic
> + * @ thread_id: TID (thread ID)
> + * @ is_vcpu: true is thread is vCPU thread
> + * @ cpu_id: CPU number last executed on
> + * @ vcpu_id: vCPU ID
> + * @ numa_node_id:node number of the CPU
> + * @ utime: amount of clock ticks the thread
> + *          has been scheduled in User mode
> + * @ stime: amount of clock ticks the thread
> + *          has been scheduled in System mode
> + * @ delta_ticks: delta of utime+stime between
> + *          the two samples (before/after sleep)
> + */
> +struct thread_stat {
> +    unsigned int thread_id;
> +    bool is_vcpu;
> +    unsigned int cpu_id;
> +    unsigned int vcpu_id;
> +    unsigned int numa_node_id;
> +    unsigned long long *utime;
> +    unsigned long long *stime;
> +    unsigned long long delta_ticks;
> +};
> +
> +/*
> + * Package statistic
> + * @ e_start: package energy counter before the sleep
> + * @ e_end: package energy counter after the sleep
> + * @ e_delta: delta of package energy counter
> + * @ e_ratio: store the energy ratio of non-vCPU thread
> + * @ nb_vcpu: number of vCPU running on this package
> + */
> +struct packge_energy_stat {

"package"

> +    uint64_t e_start;
> +    uint64_t e_end;
> +    uint64_t e_delta;
> +    uint64_t e_ratio;
> +    unsigned int nb_vcpu;
> +};
> +
> +typedef struct thread_stat thread_stat;
> +typedef struct packge_energy_stat package_energy_stat;
> +
> +uint64_t read_msr(uint32_t reg, unsigned int cpu_id);
> +void delta_ticks(thread_stat *thd_stat, int i);
> +unsigned int get_maxcpus(unsigned int package_num);
> +int read_thread_stat(struct thread_stat *thread, int pid, int index);
> +pid_t *get_thread_ids(pid_t pid, int *num_threads);
> +double get_ratio(package_energy_stat *pkg_stat,
> +                        thread_stat *thd_stat,
> +                        int maxticks, int i);

Would prefixing these declarations with 'vmsr_' provide
a clearer API? Otherwise, maybe this isn't the best header
to declare them.

> +
> +#endif /* VMSR_ENERGY_H */



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 295857FB966
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 12:25:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7wCM-0002hB-Lh; Tue, 28 Nov 2023 06:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7wCK-0002h2-E3
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 06:24:12 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7wCF-0004s2-Nd
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 06:24:10 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50943ccbbaeso7412689e87.2
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 03:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701170646; x=1701775446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lkgqpMWNN9aIWkoN208jbZ0DCwqJ9JVKRs3aY9WvOQI=;
 b=T6QB++2Fgt5kYSbjtUfjfeTd0P1LALtT0sUvSCKPFTGVXtTuFAdOewjR9/lNvfdnIm
 J5x7p3kGEA+AJY0DLudTgh5jbGJAC8hVRDDliuPQa4+5sS81wsRgUOJcZPixqNiT1CZm
 53/vwFW2xvWSHeIijxpNYFRBcGLPfMfDFOtbvwxd20gHYptKD/JemTSCYUbKvd9KCE1h
 zs9HC8xkH1LQSNg281p+Os/6IirRKv5l/3Bh5r9jrBSw3CKvm4xOrtwuzqwIzn6NroAq
 Z1iJ0YD1NUFIH3PFHbGKN29twaoXeBGH/NUsn2rNOrf/+SaKErCFBazJOWm2TVNHYWgx
 4Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701170646; x=1701775446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lkgqpMWNN9aIWkoN208jbZ0DCwqJ9JVKRs3aY9WvOQI=;
 b=JZESrrciDHHyoOvM30H+n3eXJQcNdGuP5ozv+H05MUfoxcJdkZACVRQFl1aly0wm/r
 GDNg4CsXzxMQPO8ybOXQBXUPj7VfuxCHGnxseZ07IHhefchCIoBfdWRAfsGpeQqLhWcL
 N1XjP2N8u2VOf+dXiX3KQzWqq55QWMEdh0oXoLgLd9lS4Tnq5qL7IhLdNgH7InahbwQA
 37nT+kCq/hkA+rtjTiWpVbF7NB+/T/3A17T7gdf8VSP0aYruGE8+OE66X87BhpV1M/1B
 xB1gzdo2Gs6JWffTTjq4bATxPz5/ALhdZBjuw71nQP1Ai+5ZUQaXlNQqfKK894qluHgV
 Apjg==
X-Gm-Message-State: AOJu0YwjLCNgDJApCAqoRbgSZM8lMEJuWcRv8Jhf03/oPnq4Fy10SV5g
 Vu9SfHjlckSZOCjBYRwB5HpYxQ==
X-Google-Smtp-Source: AGHT+IGXeLI2wCQpXZNzdB4uxDCqUyCp1OJlpKs9UU+Sg1bL32mP6ZiclXPs1YQBkS3f5h9N7YLHFQ==
X-Received: by 2002:a05:6512:3b0b:b0:509:1301:8470 with SMTP id
 f11-20020a0565123b0b00b0050913018470mr13302170lfv.45.1701170645773; 
 Tue, 28 Nov 2023 03:24:05 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 h9-20020a05600c314900b0040b32edf626sm11521547wmo.31.2023.11.28.03.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 03:24:05 -0800 (PST)
Message-ID: <95cc7c22-939f-4ce0-aecd-d0ff7b0e7c9c@linaro.org>
Date: Tue, 28 Nov 2023 12:24:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] target/arm: Add support for DC CVAP & DC CVADP ins
Content-Language: en-US
To: peter.maydell@linaro.org, richard.henderson@linaro.org,
 Beata Michalska <beata.michalska@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: quintela@redhat.com, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
References: <20191105234100.22052-1-beata.michalska@linaro.org>
 <20191105234100.22052-5-beata.michalska@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20191105234100.22052-5-beata.michalska@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

On 6/11/19 00:41, Beata Michalska wrote:
> ARMv8.2 introduced support for Data Cache Clean instructions
> to PoP (point-of-persistence) - DC CVAP and PoDP (point-of-deep-persistence)
> - DV CVADP. Both specify conceptual points in a memory system where all writes
> that are to reach them are considered persistent.
> The support provided considers both to be actually the same so there is no
> distinction between the two. If none is available (there is no backing store
> for given memory) both will result in Data Cache Clean up to the point of
> coherency. Otherwise sync for the specified range shall be performed.
> 
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> ---
>   linux-user/elfload.c |  2 ++
>   target/arm/cpu.h     | 10 ++++++++++
>   target/arm/cpu64.c   |  1 +
>   target/arm/helper.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 69 insertions(+)


> +#ifndef CONFIG_USER_ONLY
> +static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
> +                          uint64_t value)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +    /* CTR_EL0 System register -> DminLine, bits [19:16] */
> +    uint64_t dline_size = 4 << ((cpu->ctr >> 16) & 0xF);
> +    uint64_t vaddr_in = (uint64_t) value;
> +    uint64_t vaddr = vaddr_in & ~(dline_size - 1);
> +    void *haddr;
> +    int mem_idx = cpu_mmu_index(env, false);
> +
> +    /* This won't be crossing page boundaries */
> +    haddr = probe_read(env, vaddr, dline_size, mem_idx, GETPC());
> +    if (haddr) {
> +
> +        ram_addr_t offset;
> +        MemoryRegion *mr;
> +
> +        /* RCU lock is already being held */
> +        mr = memory_region_from_host(haddr, &offset);
> +
> +        if (mr) {
> +            memory_region_do_writeback(mr, offset, dline_size);
> +        }
> +    }
> +}


> +#ifndef CONFIG_USER_ONLY
> +    /* Data Cache clean instructions up to PoP */
> +    if (cpu_isar_feature(aa64_dcpop, cpu)) {

Am I correct understanding this is a TCG-only feature?


> +        define_one_arm_cp_reg(cpu, dcpop_reg);
> +
> +        if (cpu_isar_feature(aa64_dcpodp, cpu)) {
> +            define_one_arm_cp_reg(cpu, dcpodp_reg);
> +        }
> +    }
> +#endif /*CONFIG_USER_ONLY*/
>   #endif
>   
>       /*



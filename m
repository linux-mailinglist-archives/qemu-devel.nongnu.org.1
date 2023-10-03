Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 969B37B60D5
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 08:35:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnYyl-0001gc-Fi; Tue, 03 Oct 2023 02:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnYyj-0001fQ-NE
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:33:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnYyh-0002us-SG
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 02:33:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4065f29e933so5558825e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 23:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696314833; x=1696919633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CbybdjagOW0E12ZUgpvobkKWcAkVuvl1rqYjBghDq3w=;
 b=KBRbs5DJuoraeltRa3GCSvgUNxGuXLSiIx+P6Sog+kKdMznFN/VkotEeALDNfDAlJ8
 SjhL6ilP6jjgjP1HPY8Li6dwZKCExEFll2NxKE4gq7MrnSXttMETXg1hQmuM4igMiio5
 qIHzwAfT8RUnsMBuujNtNkbOOCkEC8evg7EPn9avHbdUNbmLf6wj3vnRuE4CVt7vAVa9
 z+Z7up0W/AhfV4Pu5hCaU5kzdx9LmAX4C61DzwXIEd/Sjy9dltbCNYpxyHUX1k8+hFGn
 OMGJhNyYD6ByLsTsNi9tV0n4m9hHVuoO6El/dSubXj9YOfqWHKukr79nObUaUmOiNMdV
 zVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314833; x=1696919633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CbybdjagOW0E12ZUgpvobkKWcAkVuvl1rqYjBghDq3w=;
 b=oh66B9A7/CuUf+XfOPb0t6ebaXp1Bp7kIntCsx6YLehiQUGdEwxZVF58fQSti0zisi
 j2FpqDNyC57ZF2atFagFhi1ekgTaiemPXIqC5AqOxSvtMrWVBuyyg5ECeJH4npj9oyto
 XSKztB/AHx+6ajo+ry30TLQhVfS9mEEXl28BaXCJTHOQ5Hp0gh0lEPKA19Y9x6LWrUJD
 wTKNi7RNviTkC5wWyEmEIK9ojBzJIMgseOILJGQVD8OmuftvYbH5yOi6IT7SSRCiV8Vk
 bRfNwQKHcMJ0H6BdL7bTE+pnRaLZcoagHr+hsWCCINuw1UH2IqrrGfou1i439ML7jNzZ
 PWVA==
X-Gm-Message-State: AOJu0YxI8ov9FKwaWiiJCIsEPd62SNEtf/UHFlZZpBBWc1WR2lubn0Ce
 zi0dZPYeMwtBPkXn+tT4z+ao1Q==
X-Google-Smtp-Source: AGHT+IHhPkbA1TBCzpYsp+Ke9IRYEFIe+iPHiSzReTvJ76g7qdSLSAYuYdQEWyQd9XgXa0bexeaXqQ==
X-Received: by 2002:a05:600c:294a:b0:403:7b2:6d8f with SMTP id
 n10-20020a05600c294a00b0040307b26d8fmr11878375wmd.2.1696314833096; 
 Mon, 02 Oct 2023 23:33:53 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 p7-20020adff207000000b003253523d767sm750699wro.109.2023.10.02.23.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 23:33:52 -0700 (PDT)
Message-ID: <b71a91cc-a0fe-230b-f895-e163b37be157@linaro.org>
Date: Tue, 3 Oct 2023 08:33:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH RFC V2 31/37] physmem,gdbstub: Common helping
 funcs/changes to *unrealize* vCPU
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 gshan@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-32-salil.mehta@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230926100436.28284-32-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Salil,

On 26/9/23 12:04, Salil Mehta wrote:
> Supporting vCPU Hotplug for ARM arch also means introducing new functionality of
> unrealizing the ARMCPU. This requires some new common functions.
> 
> Defining them as part of architecture independent change so that this code could
> be reused by other interested parties.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   gdbstub/gdbstub.c         | 13 +++++++++++++
>   include/exec/cpu-common.h |  8 ++++++++
>   include/exec/gdbstub.h    |  1 +
>   include/hw/core/cpu.h     |  1 +
>   softmmu/physmem.c         | 25 +++++++++++++++++++++++++
>   5 files changed, 48 insertions(+)


> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index dab572c9bd..ffd815a0d8 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -366,6 +366,7 @@ struct CPUState {
>       QSIMPLEQ_HEAD(, qemu_work_item) work_list;
>   
>       CPUAddressSpace *cpu_ases;
> +    int cpu_ases_ref_count;
>       int num_ases;
>       AddressSpace *as;
>       MemoryRegion *memory;
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 3df73542e1..a93ae783af 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -762,6 +762,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>   
>       if (!cpu->cpu_ases) {
>           cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
> +        cpu->cpu_ases_ref_count = cpu->num_ases;
>       }
>   
>       newas = &cpu->cpu_ases[asidx];
> @@ -775,6 +776,30 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>       }
>   }
>   
> +void cpu_address_space_destroy(CPUState *cpu, int asidx)
> +{
> +    CPUAddressSpace *cpuas;
> +
> +    assert(asidx < cpu->num_ases);
> +    assert(asidx == 0 || !kvm_enabled());
> +    assert(cpu->cpu_ases);
> +
> +    cpuas = &cpu->cpu_ases[asidx];
> +    if (tcg_enabled()) {
> +        memory_listener_unregister(&cpuas->tcg_as_listener);
> +    }
> +
> +    address_space_destroy(cpuas->as);
> +    g_free_rcu(cpuas->as, rcu);
> +
> +    if (cpu->cpu_ases_ref_count == 1) {
> +        g_free(cpu->cpu_ases);
> +        cpu->cpu_ases = NULL;
> +    }
> +
> +    cpu->cpu_ases_ref_count--;

See Richard comment from:
https://lore.kernel.org/qemu-devel/594b2550-9a73-684f-6e54-29401dc6cd7a@linaro.org/

"I think it would be better to destroy all address spaces at once,
"so that you don't need  to invent a reference count that isn't used
"for anything else.

> +}
> +
>   AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
>   {
>       /* Return the AddressSpace corresponding to the specified index */



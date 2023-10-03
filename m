Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 920ED7B5EBA
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 03:38:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnULN-00027m-J8; Mon, 02 Oct 2023 21:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnULJ-00026w-Et
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 21:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnULH-0005Nb-TA
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 21:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696297015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTv0J1qp9acbOQ+Hqz/QicTRToQwM0piQLmWmZTl0ko=;
 b=baiIvuk052G7V823PCkIFVjU2ll429IGvcGU0eQyVGahRCce1tbzReZLvuTePxmstEwB5n
 sgA2i06mj26xHGZMJZkDV3cbqZZbX92DqDWiGMVSLl1Fdt/fT+yfjWIwUxiFznuukxREA9
 uctwDhbwkhopGhdhTPDX88yjC4GdqJg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-4ypkt45MO0GfMaZI756DgA-1; Mon, 02 Oct 2023 21:36:49 -0400
X-MC-Unique: 4ypkt45MO0GfMaZI756DgA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-573fdb618eeso339203a12.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 18:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696297008; x=1696901808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xTv0J1qp9acbOQ+Hqz/QicTRToQwM0piQLmWmZTl0ko=;
 b=DruL8mUjMHAL1kPEphrAAGPEJXiFLBl+bU7XTloCLIruU531yLraPiLxIkg/Bg4Ouw
 9UwC8laF7i0aEsA9FBbGzwW8l/y1wNfLbbRowUEHMP8eJrLobaG7Q1mGgOeYrvePmmVC
 ZBQ6RCkQHUmcc1eaMy2bIdxu9Eu8KRtAjk/615H/T83LFC2u1DYGm0QDaGvrQDYvQ+jR
 3bIe/ivTDJLN/7BEjOoKKko+Yas6gCuprMAW+zSXirLOeT0MCVJOxvT7qZ4uwxqbb9Jk
 eOJnMsDLAQ69S7NZQ1I/KQ8a3OeZQVTL30uieKbOoRrVpOBlyxNeZR1iZnN10D8Hs7wN
 Pb5Q==
X-Gm-Message-State: AOJu0Yw2U4PbaYxt6a+feS9gZdZHq3mxoHYZyWFGgNLp7I3m+BHxndox
 BlD9hQD3FwI7R4ztTR6/l9wrQa0FRERs10ZAyLRjOr+QrCJ1YaTLvWnV0lQT+D8PcpROlD0OTsv
 un/Z6O0HCRoVgwKM=
X-Received: by 2002:a05:6a20:3d21:b0:15e:7323:5c0f with SMTP id
 y33-20020a056a203d2100b0015e73235c0fmr16503315pzi.16.1696297007958; 
 Mon, 02 Oct 2023 18:36:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLKLoGLUL6nlwaGYgbP4Zrk0efPFdD7IeyG78Cg76vI/EPmghnNHS3p9a2NVMMRKiGA9q3Gw==
X-Received: by 2002:a05:6a20:3d21:b0:15e:7323:5c0f with SMTP id
 y33-20020a056a203d2100b0015e73235c0fmr16503273pzi.16.1696297007608; 
 Mon, 02 Oct 2023 18:36:47 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 jk12-20020a170903330c00b001c6189ce950sm111426plb.188.2023.10.02.18.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 18:36:47 -0700 (PDT)
Message-ID: <bc5e5558-8899-30d1-e64a-c1012437766e@redhat.com>
Date: Tue, 3 Oct 2023 11:36:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 08/10] physmem: Add helper function to destroy CPU
 AddressSpace
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, rafael@kernel.org, alex.bennee@linaro.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 linuxarm@huawei.com
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-9-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230930001933.2660-9-salil.mehta@huawei.com>
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

On 9/30/23 10:19, Salil Mehta wrote:
> Virtual CPU Hot-unplug leads to unrealization of a CPU object. This also
> involves destruction of the CPU AddressSpace. Add common function to help
> destroy the CPU AddressSpace.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   include/exec/cpu-common.h |  8 ++++++++
>   include/hw/core/cpu.h     |  1 +
>   softmmu/physmem.c         | 25 +++++++++++++++++++++++++
>   3 files changed, 34 insertions(+)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 41788c0bdd..eb56a228a2 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -120,6 +120,14 @@ size_t qemu_ram_pagesize_largest(void);
>    */
>   void cpu_address_space_init(CPUState *cpu, int asidx,
>                               const char *prefix, MemoryRegion *mr);
> +/**
> + * cpu_address_space_destroy:
> + * @cpu: CPU for which address space needs to be destroyed
> + * @asidx: integer index of this address space
> + *
> + * Note that with KVM only one address space is supported.
> + */
> +void cpu_address_space_destroy(CPUState *cpu, int asidx);
>   
>   void cpu_physical_memory_rw(hwaddr addr, void *buf,
>                               hwaddr len, bool is_write);
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 648b5b3586..65d2ae4581 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -355,6 +355,7 @@ struct CPUState {
>       QSIMPLEQ_HEAD(, qemu_work_item) work_list;
>   
>       CPUAddressSpace *cpu_ases;
> +    int cpu_ases_count;
>       int num_ases;
>       AddressSpace *as;
>       MemoryRegion *memory;

@num_ases and @cpu_ases_count are duplicate to each other to some extent. The
real problem is @cpu_ases is allocated at once and we need to make the allocation
sparse. In that way, each CPU address space is independent and can be destroyed
independently. The sparse allocation for the CPU address space can be done in
cpu_address_space_init() like below:

#define CPU_ADDRESS_SPACE_MAX 8

struct CPUState {
     CPUAddressSpace *cpu_ases[CPU_ADDRESS_SPACE_MAX];
}

void cpu_address_space_init(CPUState *cpu, int asidx, const char *prefix, MemoryRegion *mr)
{
     assert(asidx < CPU_ADDRESS_SPACE_MAX);

     /* The address space has been initialized ? */
     if (cpu->cpu_ases[asidx]) {
         return;
     }

     cpu->cpu_ases[asidx] = g_new0(CPUAddressSpace, 1);

}

void cpu_address_destroy(CPUState *cpu, int asidx)
{
     assert(asidx < CPU_ADDRESS_SPACE_MAX);

     /* The address space isn't initialized? */
     if (!cpu->cpu_ases[asidx]) {
         return;
     }

     :
     g_free(cpu->cpu_ases[asidx]);
     cpu->cpu_ases[asidx] = NULL;
     
}

> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 4f6ca653b3..4dfa0ca66f 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -761,6 +761,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>   
>       if (!cpu->cpu_ases) {
>           cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
> +        cpu->cpu_ases_count = cpu->num_ases;
>       }
>   
>       newas = &cpu->cpu_ases[asidx];
> @@ -774,6 +775,30 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
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
> +    if (cpu->cpu_ases_count == 1) {
> +        g_free(cpu->cpu_ases);
> +        cpu->cpu_ases = NULL;
> +    }
> +
> +    cpu->cpu_ases_count--;
> +}
> +
>   AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
>   {
>       /* Return the AddressSpace corresponding to the specified index */

Thanks,
Gavin



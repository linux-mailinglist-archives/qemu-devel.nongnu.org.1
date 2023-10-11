Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9336D7C6121
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 01:33:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqigO-0000uT-Au; Wed, 11 Oct 2023 19:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qqigH-0000tQ-UA
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 19:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qqigF-0007oA-9C
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 19:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697067114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ccvT5bgod8s4o55Wr4OsVK5LtH0zk3OUuCZrUegvhBw=;
 b=MbzcrzTfvOkRc88LDhRPxi9WTPW9vt+wOpEIim/IP8cHkCTtTvnEN1Qfvlb/Mf/zXlPXo2
 r/pNyvg45a4xxz9FmOXb5KxXCDer4x7gIyy6bO4qIcMm6/Gey9ri2pUkInTGLmiZ53GXzh
 sV6DLal8pxoP4KTpGUErho+4h6Fe9hY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-NOdWhTnEN6a6Uz8BsIfqcQ-1; Wed, 11 Oct 2023 19:31:52 -0400
X-MC-Unique: NOdWhTnEN6a6Uz8BsIfqcQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6a439b414ccso260659b3a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 16:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697067112; x=1697671912;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ccvT5bgod8s4o55Wr4OsVK5LtH0zk3OUuCZrUegvhBw=;
 b=FU/E3pCxlMuEnMJmH54AVlpiVsCak5ES3VnwkAIiwWHf7/Su2WsFRrItnrQPZ+wP+U
 jqKp2ZtWC5qS76J1fE96mG1wpFvCMOdgkvr2sjcVRhjPTGCT06EufgResvPTqub0feEx
 DyzcP+HD/ByXMhJa5VA71Qj52LrIfoBrVNL7+nto5cSPFSzfacdc5aXv0XkP0MzK5FUw
 /p1ywbhP4575yHZxnuJxqywgZGqZtlIbN7gRA3XEB0zSVpJ9lnRj7+DPLpFB77AuhIuY
 JZuC2tbs2qIMSoJZ/ZtsXdLvThMmWXUz5fzr1iiziAWcl8vdz3+Ii4U67Qq0VECwGQ7B
 KWSA==
X-Gm-Message-State: AOJu0Ywg3suN6z8kBI2JCY61jd3rUf3Gai4sdM/4mCjPhzkbBef7+XL/
 Z3XJR/QZgsJAscvF/af6MrwfF4U5VL0Xu6+cJRn97IASE9fwFUuir9AYBaMZdp6ACdH5uiYbaN0
 PEVlNujBUwsiqNQ0=
X-Received: by 2002:a05:6a00:248a:b0:690:d008:8d02 with SMTP id
 c10-20020a056a00248a00b00690d0088d02mr25192759pfv.19.1697067111853; 
 Wed, 11 Oct 2023 16:31:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL4JaIqBUrYobz3B8fe0ZBI67l+7p5+0QTInqS9OSRB1qzvPAuR0Ex+Gzna6U0hqSXKtbpoA==
X-Received: by 2002:a05:6a00:248a:b0:690:d008:8d02 with SMTP id
 c10-20020a056a00248a00b00690d0088d02mr25192722pfv.19.1697067111491; 
 Wed, 11 Oct 2023 16:31:51 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15?
 ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a62bd03000000b0063b898b3502sm10555190pff.153.2023.10.11.16.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 16:31:51 -0700 (PDT)
Message-ID: <69098d56-8b68-2734-ef40-7338386d7fa9@redhat.com>
Date: Thu, 12 Oct 2023 09:31:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V5 8/9] physmem: Add helper function to destroy CPU
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
References: <20231011194355.15628-1-salil.mehta@huawei.com>
 <20231011194355.15628-9-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231011194355.15628-9-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
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

Hi Salil,

On 10/12/23 05:43, Salil Mehta wrote:
> Virtual CPU Hot-unplug leads to unrealization of a CPU object. This also
> involves destruction of the CPU AddressSpace. Add common function to help
> destroy the CPU AddressSpace.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> ---
>   include/exec/cpu-common.h |  8 ++++++++
>   include/hw/core/cpu.h     |  1 +
>   softmmu/physmem.c         | 25 +++++++++++++++++++++++++
>   3 files changed, 34 insertions(+)
> 

I guess you need another respin since 'softmmu/physmem.c' has been
renamed to 'system/physmem.c' by 8d7f2e767d ("system: Rename softmmu/
directory as system/"). So please consider leveraging the respin chance
to address the following minor comments. With that,

Reviewed-by: Gavin Shan <gshan@redhat.com>

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

The prefix 'cpu_' is duplicate here because the container (CPUState)
indicates it explicitly. I think it was inherited from @cpu_ases.
Besides, @ases_count seems not better than @remaining_ases. If it
makes sense, please rename it to @remaining_ases

>       int num_ases;
>       AddressSpace *as;
>       MemoryRegion *memory;
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

The two asserts on @asidx and @cpu->cpu_ases can be combined
to one so that these 3 asserts can be combined to two.

        /* Only one address space is supported by KVM */
        assert(asidx == 0 || !kvm_enabled());
        assert(asidx >= 0 && asidx < cpu->cpu_ases_count)

> +    cpuas = &cpu->cpu_ases[asidx];
> +    if (tcg_enabled()) {
> +        memory_listener_unregister(&cpuas->tcg_as_listener);
> +    }
> +

We need to detach CPUState::as here if @asidx == 0 because the alias was
populated in cpu_address_space_init(). Even the CPUState is going to be
release pretty soon, we have inconsistent states temporarily.

        /* Detach the alias to address space 0 */
        if (asidx == 0) {
            cpu->as = NULL;
        }

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

I'm not sure, but Linux's kref_put() decreases the reference count before
the object is released. In order to follow that pattern, we need something
like below. However, it's something related to personal taste, I guess :)

        if (--cpu->cpu_ases_count == 0) {
            g_free(cpu->cpu_ases);
            cpu->cpu_ases = NULL;
        }



>   AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
>   {
>       /* Return the AddressSpace corresponding to the specified index */

Thanks,
Gavin



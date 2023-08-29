Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B67378C7C8
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:41:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaztw-0008DC-Dq; Tue, 29 Aug 2023 10:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaztu-0008Bx-C8
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:41:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaztq-0002Xe-QK
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:41:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40037db2fe7so41779865e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693320057; x=1693924857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w0CNklfibqXbDKfZVvUCVaujjhjo60UQl5856c99JOs=;
 b=eXeO7MI/C6aW0HX6yLFcekHuY8UDnXBoS4vcAMYj2gUgUmKIohcuDeZHMrOkezLsXP
 d5Rxmhc3Vge56MKBVhOJtdXjlpMqTbp0943K2+rGc1YYeWT/tMJQ3IGDLiqAg8h1DNtl
 ByWJWGtPYj2aoiv/BqPiO9Tgxynhf1BeDNQVcYIbqMSIIM+jMH/DlO7wxMvOUcttfPU/
 T4Lh9QkI4UH7/HxoE2Rtbz7iJ7DSdGyB7fzvo7YuDO23tCqAkolvqLSJ2e1wFYySWqng
 wmLUsH6Av+zGwqzWohUDZv1uk/SCS5Wz5IjPb5WKaShSfd4e2x3iRm7zYVHZJZAltZkO
 VfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693320057; x=1693924857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w0CNklfibqXbDKfZVvUCVaujjhjo60UQl5856c99JOs=;
 b=eBisF7xSkNTWXrgGVAxTE9vcl8Pojrp9MLP4Po40j7wdqzDyQ9M57AJ+H4LoAOtxAF
 sXgv8vBM2TFneJqTvdptLQhyxI0aPxFFX3xslC8ynjOftDHXjlO1q7417pVRFUrmuYwM
 aAaXx65j9Ym3tSfM6oqsjHOQxFFk6XhC0eZ97Vnt/qs2H3QKVLNNQu3yObUohhxOl0Tr
 9HfwiZzL47N6tiYft0iB96SivYOAmTOsIt4LPYay5SwUEqC9aCfXYqex08T07X7zdIh9
 P7cyP64984z+Im/7yA9iq7ZHa2y6UrB8my9vJZZXA6AVjCsUd8ZeNd4A7zrBlnHHYVvv
 ODeg==
X-Gm-Message-State: AOJu0YwxfjN6sIBH/Owuqzz9urJ602THM+xAC/LqDUWlcWvxoN80NJPe
 Es2zPMxduR30gMfJhFuWepHPJg==
X-Google-Smtp-Source: AGHT+IEKwu0zMOwgggoBJBjwjIgM9e28048wpJanrm3VmQYZq2jz55q/wmH7eaIV8Y5UrLtD6h2hHA==
X-Received: by 2002:a05:600c:d1:b0:401:5443:55a1 with SMTP id
 u17-20020a05600c00d100b00401544355a1mr11124651wmm.3.1693320057189; 
 Tue, 29 Aug 2023 07:40:57 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 o36-20020a05600c512400b00401dc0e5aa0sm43552wms.17.2023.08.29.07.40.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:40:56 -0700 (PDT)
Message-ID: <5bfefa59-6e1e-dcfd-a2a6-e49a0b71fded@linaro.org>
Date: Tue, 29 Aug 2023 16:40:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 13/58] kvm: Introduce kvm_arch_pre_create_vcpu()
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-14-xiaoyao.li@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818095041.1973309-14-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 18/8/23 11:49, Xiaoyao Li wrote:
> Introduce kvm_arch_pre_create_vcpu(), to perform arch-dependent
> work prior to create any vcpu. This is for i386 TDX because it needs
> call TDX_INIT_VM before creating any vcpu.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   accel/kvm/kvm-all.c  | 12 ++++++++++++
>   include/sysemu/kvm.h |  1 +
>   2 files changed, 13 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c9f3aab5e587..5071af917ae0 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -422,6 +422,11 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
>       return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
>   }
>   
> +int __attribute__ ((weak)) kvm_arch_pre_create_vcpu(CPUState *cpu)
> +{
> +    return 0;
> +}

kvm_arch_init_vcpu() is implemented for each arch. Why not use the
same approach here?

>   int kvm_init_vcpu(CPUState *cpu, Error **errp)
>   {
>       KVMState *s = kvm_state;
> @@ -430,6 +435,13 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>   
>       trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>   
> +    ret = kvm_arch_pre_create_vcpu(cpu);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "%s: kvm_arch_pre_create_vcpu() failed",
> +                        __func__);
> +        goto err;
> +    }
> +
>       ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
>       if (ret < 0) {
>           error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 49c896d8a512..d89ec87072d7 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -371,6 +371,7 @@ int kvm_arch_put_registers(CPUState *cpu, int level);
>   
>   int kvm_arch_init(MachineState *ms, KVMState *s);
>   
> +int kvm_arch_pre_create_vcpu(CPUState *cpu);
>   int kvm_arch_init_vcpu(CPUState *cpu);
>   int kvm_arch_destroy_vcpu(CPUState *cpu);
>   



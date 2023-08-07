Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DDA7719BF
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 07:55:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qStBP-0001pU-5t; Mon, 07 Aug 2023 01:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qStBM-0001or-Oe
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 01:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qStBK-00048M-Nj
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 01:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691387608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCp7b56SWxgUbUzJQ28m6nrXlScD4v5IlsPvQl+WPo8=;
 b=OjDkASwZj/gwWOCeQgTLrbGMjmuIZOfiTVe6U2Aibr6/T2bfmzr5Oc1BKMCty4s839nvL9
 njWg/Bxv8IyoQ/HXFGUUQAk599Oqc7jVS9cCJAXntVM99YE2V3n0yByQ1YnaxmrzOld8sN
 n2qrQKkpplBgU0YXmQ/1aRpM1QM6HvM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-2WJwPFrDOpCa3W27e-VySQ-1; Mon, 07 Aug 2023 01:53:27 -0400
X-MC-Unique: 2WJwPFrDOpCa3W27e-VySQ-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1bc4abfca29so23076755ad.3
 for <qemu-devel@nongnu.org>; Sun, 06 Aug 2023 22:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691387606; x=1691992406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uCp7b56SWxgUbUzJQ28m6nrXlScD4v5IlsPvQl+WPo8=;
 b=jPK9THmjPpBpvYd1+O6Qe/vSPS+0HrVE5v3mJpHIwH+j61elk/L4YjxQKyQ+SrFYPZ
 Tp+fWb2cwfGLaFPTW6XlZFvtdQTbMtlZ9CkpGqAATt5kcivKZ9Ub0UAL6ES0r4/nthUL
 BX310fxWzQGjL8sG7YHfVXou0C3ANQE5dadEZkJeNMfYKnI50u01uEOg/aWAoVOXnUF7
 9dcFLLKnlTW2aTCA2gWF5KKHsSDRZ9TS1qkVqd4RrfuP8cqc8XSx5uFoBW2GQPU+Ul18
 aKhg0Xsy3wlbmhXesB3nCUa3PZI6RpqPwfuQG7KUBb+i5/IgrukdiB/LcyEsc1tgIrP3
 MRkA==
X-Gm-Message-State: AOJu0YyphIYgIKUToV0qTWEuDIKWMT+CQz0RqG7ciPoLfiiOmIL7ebFX
 L3WdFMrtah0pCqwI+dXc2zTGlFqTc4cNyqY/P7K9px2th2E+bOzlpukt9IvTe2nrYcQXtxc9A96
 UpK05+TIPHrjWfZM=
X-Received: by 2002:a17:903:24d:b0:1bb:20ee:e29e with SMTP id
 j13-20020a170903024d00b001bb20eee29emr9355931plh.1.1691387606263; 
 Sun, 06 Aug 2023 22:53:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLTiMPAC3WZUAEQaGsEGz2qaBAjymsiBDnj7GUjFknatNXn31GlCeE4lq72fKDuLk4ncT72w==
X-Received: by 2002:a17:903:24d:b0:1bb:20ee:e29e with SMTP id
 j13-20020a170903024d00b001bb20eee29emr9355912plh.1.1691387605870; 
 Sun, 06 Aug 2023 22:53:25 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 ix14-20020a170902f80e00b001bc7306d321sm551156plb.282.2023.08.06.22.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 22:53:25 -0700 (PDT)
Message-ID: <c76de653-489c-ea4a-3163-f7d114c72d0f@redhat.com>
Date: Mon, 7 Aug 2023 15:53:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH] arm/kvm: Enable support for
 KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, ricarkol@google.com, kvm@vger.kernel.org,
 jonathan.cameron@huawei.com, linuxarm@huawei.com
References: <20230725150002.621-1-shameerali.kolothum.thodi@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230725150002.621-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.139, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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


On 7/26/23 01:00, Shameer Kolothum wrote:
> Now that we have Eager Page Split support added for ARM in the kernel[0],
> enable it in Qemu. This adds,
>   -eager-split-size to Qemu options to set the eager page split chunk size.
>   -enable KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE.
> 
> The chunk size specifies how many pages to break at a time, using a
> single allocation. Bigger the chunk size, more pages need to be
> allocated ahead of time.
> 
> Notes:
>   - I am not sure whether we need to call kvm_vm_check_extension() for
>     KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE or not as kernel seems to disable
>     eager page size by default and it will return zero always.
> 
>    -ToDo: Update qemu-options.hx
> 
> [0]: https://lore.kernel.org/all/168426111477.3193133.10748106199843780930.b4-ty@linux.dev/
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   include/sysemu/kvm_int.h |  1 +
>   target/arm/kvm.c         | 73 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 74 insertions(+)
> 
> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 511b42bde5..03a1660d40 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -116,6 +116,7 @@ struct KVMState
>       uint64_t kvm_dirty_ring_bytes;  /* Size of the per-vcpu dirty ring */
>       uint32_t kvm_dirty_ring_size;   /* Number of dirty GFNs per ring */
>       bool kvm_dirty_ring_with_bitmap;
> +    uint64_t kvm_eager_split_size; /* Eager Page Splitting chunk size */
>       struct KVMDirtyRingReaper reaper;
>       NotifyVmexitOption notify_vmexit;
>       uint32_t notify_window;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index b4c7654f49..985d901062 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -30,6 +30,7 @@
>   #include "exec/address-spaces.h"
>   #include "hw/boards.h"
>   #include "hw/irq.h"
> +#include "qapi/visitor.h"
>   #include "qemu/log.h"
>   
>   const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
> @@ -247,6 +248,23 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
>       return ret > 0 ? ret : 40;
>   }
>   
> +static bool kvm_arm_eager_split_size_valid(uint64_t req_size, uint32_t sizes)
> +{
> +    int i;
> +
> +    for (i = 0; i < sizeof(uint32_t) * BITS_PER_BYTE; i++) {
> +        if (!(sizes & (1 << i))) {
> +            continue;
> +        }
> +
> +        if (req_size == (1 << i)) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>   int kvm_arch_init(MachineState *ms, KVMState *s)
>   {
>       int ret = 0;
> @@ -280,6 +298,21 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           }
>       }
>   
> +    if (s->kvm_eager_split_size) {
> +        uint32_t sizes;
> +
> +        sizes = kvm_vm_check_extension(s, KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES);
> +        if (!sizes) {
> +            error_report("Eager Page Split not supported on host");
> +        } else if (!kvm_arm_eager_split_size_valid(s->kvm_eager_split_size,
> +                                                   sizes)) {
> +            error_report("Eager Page Split requested chunk size not valid");
> +        } else if (kvm_vm_enable_cap(s, KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE, 0,
> +                                     s->kvm_eager_split_size)) {
> +            error_report("Failed to set Eager Page Split chunk size");
> +        }
> +    }
> +
>       kvm_arm_init_debug(s);
>   
>       return ret;

Do we really want to fail when KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES isn't supported?
I think the appropriate behavior is to warn and clear s->kvm_eager_split_size
for this specific case, similar to what we are doing for s->kvm_dirty_ring_size
in kvm_dirty_ring_init(). With this, the behavior is backwards compatible to the
old host kernels.


> @@ -1062,6 +1095,46 @@ bool kvm_arch_cpu_check_are_resettable(void)
>       return true;
>   }
>   
> +static void kvm_arch_get_eager_split_size(Object *obj, Visitor *v,
> +                                          const char *name, void *opaque,
> +                                          Error **errp)
> +{
> +    KVMState *s = KVM_STATE(obj);
> +    uint64_t value = s->kvm_eager_split_size;
> +
> +    visit_type_size(v, name, &value, errp);
> +}
> +
> +static void kvm_arch_set_eager_split_size(Object *obj, Visitor *v,
> +                                          const char *name, void *opaque,
> +                                          Error **errp)
> +{
> +    KVMState *s = KVM_STATE(obj);
> +    uint64_t value;
> +
> +    if (s->fd != -1) {
> +        error_setg(errp, "Cannot set properties after the accelerator has been initialized");
> +        return;
> +    }
> +
> +    if (!visit_type_size(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value & (value - 1)) {
> +        error_setg(errp, "early-split-size must be a power of two.");
> +        return;
> +    }
> +
> +    s->kvm_eager_split_size = value;
> +}
> +
>   void kvm_arch_accel_class_init(ObjectClass *oc)
>   {
> +    object_class_property_add(oc, "eager-split-size", "size",
> +                              kvm_arch_get_eager_split_size,
> +                              kvm_arch_set_eager_split_size, NULL, NULL);
> +
> +    object_class_property_set_description(oc, "eager-split-size",
> +        "Configure Eager Page Split chunk size for hugepages. (default: 0, disabled)");
>   }

Thanks,
Gavin



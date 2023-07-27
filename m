Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E9376589C
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:27:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP396-0001As-JH; Thu, 27 Jul 2023 11:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP393-0001A7-JE
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:43:17 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP391-0003hy-Sl
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:43:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so12316445e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690472593; x=1691077393;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hEX2yXanu6lI6E29oJscX+qcEyz7+geVl0H0uFbsIWY=;
 b=hvd1QyVrBZDYC1iVAlTK2lIxwDqf3WPN47mB29iOitO2K9J2D1T5tREezyINzni2N7
 8jgHYX+s84S1LwmsB9fHcR3RjzljyFeT9d5TDQ3cOxrMDYvuI7CQZLmvNSxxwVwvn4aB
 /dS8y16OfiLNnqjVBCYQSVVuhSx75YMHceuNTKWp+INE1J+si8nGgDHKJuEw0G0o3Y1k
 SEGbpexUuzsQcY/Bi96Pi+L5A3ykGVe3quuVDwt7hVTmZbYR7qG5XgLkkOH9s3YRWuPo
 8BK7wFSBWZOJOR2l9fvRNAcoctJRaIWdkRi7hFNKAcX0+Egcjy4UootkNgG/YwoaJMkI
 qPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690472593; x=1691077393;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hEX2yXanu6lI6E29oJscX+qcEyz7+geVl0H0uFbsIWY=;
 b=gEDdswVBKCeF3B5SYBXY0lfsKPUN/7SdZ0kzGWn6qIDSdRpVpgzIhnQ/CyZJcA9HYh
 82eZGEgHIG7SenZfzaehe53yPTdH5F8ajAv3YXdyVBrRDPIeB0KAat2sEL4WsQZnvePN
 usmp4QF8hgO6ROxy9mH/vXiT4qbG7mWVgHwNqdGCoerMxFKL+H02fmUTkItM0w52q39a
 yB14EwhXhd1/Q+N5Rx/VIf+qFEzJ4qv3GOQFSiu1T8GTzGtto3hoQCmV7nLjiqxEq2BZ
 v18KgkG0srkWjabXqEf1Xo1DaZm2ur1zXHTImNlx9kHrlIS9SkORLB5jcXWXTcVYG4Is
 05hA==
X-Gm-Message-State: ABy/qLaHTsef5obhTgwZZaT4XSwvzrGEjCSAU0DLxM/epfby0t8SDn26
 aSu1x5U6LtMm0QyChbYRBr1B1MwhN218RZgdP+Z7zQ==
X-Google-Smtp-Source: APBJJlGpR3oAOSauh2N1BylSzmAfP6iFM60UW3z8HrfrOSG1YRXj7cF+fMCUIZdImPCWGjSV53Y7DxtIkoaY2MsAyzI=
X-Received: by 2002:a5d:6706:0:b0:315:a043:5e03 with SMTP id
 o6-20020a5d6706000000b00315a0435e03mr2363865wru.55.1690472593068; Thu, 27 Jul
 2023 08:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230725150002.621-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20230725150002.621-1-shameerali.kolothum.thodi@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 16:43:02 +0100
Message-ID: <CAFEAcA_3+=m8nt6_eJMiEpxyGcSAXJRC5LWMVvU3f9CHAxKzCw@mail.gmail.com>
Subject: Re: [RFC PATCH] arm/kvm: Enable support for
 KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, ricarkol@google.com, 
 kvm@vger.kernel.org, jonathan.cameron@huawei.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

On Tue, 25 Jul 2023 at 16:01, Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> Now that we have Eager Page Split support added for ARM in the kernel[0],
> enable it in Qemu. This adds,
>  -eager-split-size to Qemu options to set the eager page split chunk size.
>  -enable KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE.

It looks from the code like you've added a new sub-option
to -accel, not a new global option. This is the right thing,
but your commit message should document the actual option syntax
to avoid confusion.

> The chunk size specifies how many pages to break at a time, using a
> single allocation. Bigger the chunk size, more pages need to be
> allocated ahead of time.
>
> Notes:
>  - I am not sure whether we need to call kvm_vm_check_extension() for
>    KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE or not as kernel seems to disable
>    eager page size by default and it will return zero always.
>
>   -ToDo: Update qemu-options.hx
>
> [0]: https://lore.kernel.org/all/168426111477.3193133.10748106199843780930.b4-ty@linux.dev/

Speaking of confusion, this message says "It's an optimization used
in Google Cloud since 2016 on x86, and for the last couple of months
on ARM." so I'm not sure why we've ended up with an Arm-specific
KVM_CAP and code in target/arm/kvm.c rather than something more
generic ?

If this is going to arrive for other architectures in the future
we should probably think about whether some of this code should
be generic, not arm-specific.

Also this seems to be an obscure tuning parameter -- it could
use good documentation so users have some idea when it can help.

As a more specific case of that: the kernel patchset says it
makes Arm do the same thing that x86 already does, and split
the huge pages automatically based on use of the dirty log.
If the kernel can do this automatically and we never felt
the need to provide a manual tuning knob for x86, do we even
need to expose the Arm manual control via QEMU?

Other than that, I have a few minor coding things below.

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

We know req_size is a power of 2 here, so if you also explicitly
rule out 0 then you can do
     return sizes & (1 << ctz64(req_size));
rather than having to loop through. (Need to rule out 0
because otherwise ctz64() returns 64 and the shift is UB.)

> +
> +    return false;
> +}
> +
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      int ret = 0;
> @@ -280,6 +298,21 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          }
>      }
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
>      kvm_arm_init_debug(s);
>
>      return ret;
> @@ -1062,6 +1095,46 @@ bool kvm_arch_cpu_check_are_resettable(void)
>      return true;
>  }
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

"if (!is_power_of_2(value))" is a clearer way to write this.

> +        error_setg(errp, "early-split-size must be a power of two.");
> +        return;
> +    }
> +
> +    s->kvm_eager_split_size = value;
> +}
> +
>  void kvm_arch_accel_class_init(ObjectClass *oc)
>  {
> +    object_class_property_add(oc, "eager-split-size", "size",
> +                              kvm_arch_get_eager_split_size,
> +                              kvm_arch_set_eager_split_size, NULL, NULL);
> +
> +    object_class_property_set_description(oc, "eager-split-size",
> +        "Configure Eager Page Split chunk size for hugepages. (default: 0, disabled)");
>  }
> --

thanks
-- PMM


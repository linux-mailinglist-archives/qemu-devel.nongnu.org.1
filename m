Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FD27426A6
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:39:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEqvA-00068T-HL; Thu, 29 Jun 2023 08:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEqv8-00067I-Ao
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:38:46 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEqv5-0000N3-Mu
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:38:46 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fb5bcb9a28so936745e87.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688042321; x=1690634321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxfhJxOdFDvYU3qX7hvs8tBo8Gmcl1dQu4NFgo5HPEU=;
 b=rGRM8DCpGxMdjMclSO/y9NELDVEbR56kDAMryk/iLX8KknlyUbwkX18E0exGVUkNV1
 x89tvo2xhDeB0GpklKnNGgUPQBLaW69FmFcc65ezE8DFo27sg0nD1scbtcZ561XwkD14
 h7C7dO6i5QQPJq2NbhposzInyEgZpi6Bdz7F1n9BeubNhzTSgtblrNSml7Dg+pwJlmv7
 V+HVb+IxQl1ZyTBTiPp0m9S86Mw/RKlhni7OF0zMt8/Qsfl1GqN+HP8i0Q8DncQ88r36
 iwNUYyCp/G9tpQEMuX6TE70AJ4+stZZU9oh/Fxvsdg+vHMwkaVnRTnnIRzFSrZalcN+W
 lueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688042321; x=1690634321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxfhJxOdFDvYU3qX7hvs8tBo8Gmcl1dQu4NFgo5HPEU=;
 b=Me3hChq4+OngZ2Z0kFlqcgsE+a46oMjBLTNagBQWYBZef53Mx+S9rTxPxSrEg8BPnf
 iYBY4//yUZc9zGbJFKZll7e/zEQk4V9LVsQjR2otUZSSZtSvNBwPUAxOO6XT8ZnfPHw5
 /EFYJCiYV0m1pCnkIDhoA1x+UrNaKiRSSblt2J7o3Cw0/8SzyMBxKLdxEpvrC+5qrACd
 YxOv5+0zXgy/P1gFPxO0oa5/6sE8JSF75XPHUOHO58p9eaDbnGKyNgKq0//dJfQfNaQJ
 1z0N3B1xCF0krnvrRFGLRcarNfka6fWIudjyUAba2ePlwD0/JVh/m6zj8ewUzLFqkQHl
 mjBw==
X-Gm-Message-State: AC+VfDy2Lbt5lwEhTnFrQ/3f1BAYaufwvk4dO24Z4ffxjXjhPqBKzJX2
 CY+ggAr/Dfr/fBLEvgCo/EP70H9RElN2fOSOEKA=
X-Google-Smtp-Source: ACHHUZ5bzGhLt/f+37MH8rCgEFkzwps6PmngkTB9lvXvXjml/ZkEIl0JLLRgYODeXTlVkcU7aBhcJg==
X-Received: by 2002:a05:6512:1319:b0:4f8:6625:f2ca with SMTP id
 x25-20020a056512131900b004f86625f2camr14962047lfu.61.1688042321634; 
 Thu, 29 Jun 2023 05:38:41 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a5d69cb000000b00313f07ccca4sm11605117wrw.117.2023.06.29.05.38.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 05:38:41 -0700 (PDT)
Message-ID: <0d527f32-4e69-55a8-20b8-e357292f64a3@linaro.org>
Date: Thu, 29 Jun 2023 14:38:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/2] accel/kvm: Extract 'sysemu/kvm_irq.h' from
 'sysemu/kvm.h'
Content-Language: en-US
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org
References: <20230405163001.98573-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230405163001.98573-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

Ping?

On 5/4/23 18:29, Philippe Mathieu-Daudé wrote:
> Posted individually because it is modifying a lot of files.
> 
> RFC: this might not be the best API cut, but "sysemu/kvm.h"
>       is a mixed bag hard to sort...
> 
> Based-on: <20230405160454.97436-1-philmd@linaro.org>

(not based-on actually)

> Philippe Mathieu-Daudé (2):
>    accel/kvm: Extract 'sysemu/kvm_irq.h' from 'sysemu/kvm.h'
>    accel/kvm: Declare kvm_arch_irqchip_create() in 'sysemu/kvm_int.h'
> 
>   include/sysemu/kvm.h           |  88 -----------------------------
>   include/sysemu/kvm_int.h       |  13 +++++
>   include/sysemu/kvm_irq.h       | 100 +++++++++++++++++++++++++++++++++
>   target/i386/kvm/kvm_i386.h     |   1 +
>   accel/kvm/kvm-all.c            |   2 +
>   accel/stubs/kvm-stub.c         |   1 +
>   hw/arm/virt.c                  |   1 +
>   hw/cpu/a15mpcore.c             |   1 +
>   hw/hyperv/hyperv.c             |   1 +
>   hw/i386/intel_iommu.c          |   1 +
>   hw/i386/kvm/apic.c             |   1 +
>   hw/i386/kvm/i8259.c            |   1 +
>   hw/i386/kvm/ioapic.c           |   1 +
>   hw/i386/kvmvapic.c             |   1 +
>   hw/i386/pc.c                   |   1 +
>   hw/i386/x86-iommu.c            |   1 +
>   hw/intc/arm_gic.c              |   1 +
>   hw/intc/arm_gic_common.c       |   1 +
>   hw/intc/arm_gic_kvm.c          |   1 +
>   hw/intc/arm_gicv3_common.c     |   1 +
>   hw/intc/arm_gicv3_its_common.c |   1 +
>   hw/intc/arm_gicv3_kvm.c        |   1 +
>   hw/intc/ioapic.c               |   1 +
>   hw/intc/openpic_kvm.c          |   1 +
>   hw/intc/s390_flic_kvm.c        |   1 +
>   hw/intc/spapr_xive_kvm.c       |   1 +
>   hw/intc/xics.c                 |   1 +
>   hw/intc/xics_kvm.c             |   1 +
>   hw/misc/ivshmem.c              |   1 +
>   hw/ppc/e500.c                  |   1 +
>   hw/ppc/spapr_irq.c             |   1 +
>   hw/remote/proxy.c              |   1 +
>   hw/s390x/virtio-ccw.c          |   1 +
>   hw/vfio/pci.c                  |   1 +
>   hw/vfio/platform.c             |   1 +
>   hw/virtio/virtio-pci.c         |   1 +
>   target/arm/kvm.c               |   1 +
>   target/i386/kvm/kvm.c          |   2 +
>   target/i386/kvm/xen-emu.c      |   2 +
>   target/i386/sev.c              |   1 +
>   target/s390x/kvm/kvm.c         |   2 +
>   41 files changed, 155 insertions(+), 88 deletions(-)
>   create mode 100644 include/sysemu/kvm_irq.h
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8737178D653
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:49:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLZK-0008Jz-D3; Wed, 30 Aug 2023 09:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbLZJ-0008JN-4x
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:49:13 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbLZG-00011K-Qi
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:49:12 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bf57366ccdso6246955ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693403349; x=1694008149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4F2Wkkz6t2wdGIOM1IEvRHYNK0VOendtwF1XMt1rGrQ=;
 b=MPTKlG2pX8pdNW9/aM02Raf03q35SbwCSH9gpzl1Uxmc/QNiFs442Z6qp+NZvjTvd4
 gxRV49jW4LUogQianXH+wwCg9Rr05YrAaUij9XJF0TL4N0i3/j71qJc5qA+sQCPeVE5B
 3ZmodL244zXNYMRtOur58ywSOfRYId7CoTA3t+jekiWHuCQ4R0omMJbuB7v5Kaqyh00G
 x2OtpTpFhvyYQ+wj7yg1nwztPNQPVuPhKYeSbikYJccTLLhAPZJadP3NK5LJ29GJDC1V
 rrU7jc3B3JV+Sxd1QoiwHp/DH0VAauX019BAs6crQhzLH42+xV9uFZ7nyo3bZ0vGY87j
 pDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693403349; x=1694008149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4F2Wkkz6t2wdGIOM1IEvRHYNK0VOendtwF1XMt1rGrQ=;
 b=CejxNvmQTL9IvCbEFnvuSTNWU3EyVlTWJNQc8Op/IBdUVSkqzQvUeguWQZiD13XiLr
 hlPHuMhmpDCssMPA10d91gTwhbx835cegpgJ/ylyTvTFJzwNgihO/j3HMHe3bNru28pN
 XQz7nCrutgV3Mp6TLklbsYxDPz2LjkTkHoFFo+RWzCWXqcEgBVHJUQTKobJfanXDyMvw
 9z5DG9oPxgoybg9XvhG2/RFv+OEA1UtFFTqS0fR1pICrvo8iAcHWlpqwxpHe0KqJeqUA
 RGgkGxnmQV6mK+j9iMqStK6ONpgKOiBIWt/PWkC81APoM3bMMMpi6HRQnobgae7YUoIA
 h1tQ==
X-Gm-Message-State: AOJu0YwRv/gEopvYdVkppG1/8+nvTUmtT0bcwia1ex37o3aNVUdj71vE
 MAbKvbh9xSPe4MMu8agDoS/81Q==
X-Google-Smtp-Source: AGHT+IG2ZZMCBCDh6xFUGDEtwBQMH8GkBuyZOoiI9/2Pg5D6QmzDzI2QBTEKtoXdhmQRwbZBObOytg==
X-Received: by 2002:a17:90b:f90:b0:26f:ac36:623a with SMTP id
 ft16-20020a17090b0f9000b0026fac36623amr8173257pjb.3.1693403348987; 
 Wed, 30 Aug 2023 06:49:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 n63-20020a17090a2cc500b0026094c23d0asm1394900pjd.17.2023.08.30.06.49.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 06:49:08 -0700 (PDT)
Message-ID: <98970e02-993c-d8c6-ebda-e0448904e0ff@linaro.org>
Date: Wed, 30 Aug 2023 06:49:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] hw/riscv/virt.c: fix non-KVM --enable-debug build
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20230829122144.464489-1-dbarboza@ventanamicro.com>
 <20230829122144.464489-3-dbarboza@ventanamicro.com>
 <c0089044-54d2-43ab-6b30-854a4fa3aa4f@linaro.org>
 <72de2f6a-5ede-40f4-5edc-a22d89587e4e@ventanamicro.com>
 <63d099a2-ac5e-1ce9-3663-10e317d7dc5a@linaro.org>
 <40938464-2008-aff3-ffb7-37fbb16615d3@ventanamicro.com>
 <d2f1ad02-eb03-138f-9d08-db676deeed05@linaro.org>
 <7a309a5c-c88e-4cfc-7811-5643a53def81@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7a309a5c-c88e-4cfc-7811-5643a53def81@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 8/30/23 02:34, Daniel Henrique Barboza wrote:
> TBH I'm bothered why this doesn't work:
> 
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 592c3ce768..251e08ddc4 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -839,12 +839,16 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>        * Only root APLICs have hardware IRQ lines. All non-root APLICs
>        * have IRQ lines delegated by their parent APLIC.
>        */
> -    if (!aplic->parent) {
> -        if (is_kvm_aia(aplic->msimode)) {
> -            qdev_init_gpio_in(dev, riscv_kvm_aplic_request, aplic->num_irqs);
> -        } else {
> -            qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
> +    if (kvm_enabled()) {
> +        if (!aplic->parent) {
> +            if (is_kvm_aia(aplic->msimode)) {
> +                qdev_init_gpio_in(dev, riscv_kvm_aplic_request, aplic->num_irqs);
> +            } else {
> +                qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
> +            }
>           }
> +    } else if (!aplic->parent) {
> +        qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
>       }
> 
> Why is the compiler refusing to crop an "if kvm_enabled()" block? There's no other
> conditionals to handle, and it is able to crop "if (kvm_enabled() && virt_use_kvm_aia(s))".
> 
> Is this solely because riscv_kvm_aplic_request() will be an unused function if the crop
> happens and, as you said above, "the compiler won't eliminate entire unused functions with
> -O0"?

Yes, exactly.


r~


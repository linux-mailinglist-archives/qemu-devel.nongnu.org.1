Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E76078D686
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:24:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbM7J-0006Vs-SM; Wed, 30 Aug 2023 10:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbM7H-0006TY-Ji
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:24:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbM7C-0001uc-TD
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:24:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-401b3ea0656so51371275e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693405451; x=1694010251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JjNYgkdAZBVOu1KVPWW4idIdDppYKL1hUn47hWLZTHk=;
 b=Nr2YpS482jiwOwKHyD1gHofeLz7jkuEa5a33SUBF+0gvTfM6EYCTv7PghlIxrYfnaH
 XZ9dDeYIgMjpQxv3JO4JQBRbzDL/gTBpCZm6WIykX/8W79DXxaMINF2YbSxPeqnXQvdk
 JKc0y3DR+OLFSKnP+dL4EE6xZHcrBZ0zPFDFLVGQoZTphECy1UqP9lVCc2HAnpIqvig2
 KopVVT+P7l3tcWiep3ZJeJIKl5PHZfAumAhTj8CexyVzlw5GyyRtoYe5zC7qi/SI3t3d
 lBrmU9WS8PKe66pD4aKXOyKgFjrKHQFd3YQUE2qWCQFyuf31WH+W2VKmFVjkHEuwRa9R
 kwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693405451; x=1694010251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjNYgkdAZBVOu1KVPWW4idIdDppYKL1hUn47hWLZTHk=;
 b=MzK8Te/W0U4/8lPGDXVr54k8KtoXh3FvnZvKCrNoG47x38YOcL6fLtGL1VpToJw7fb
 nDcBGAvdBkQO+qsTQf05X0US7t3rKxuZK/8Tj+RU1msRIBk89/4EKSkaSeH++b56Cz99
 5UcoX2D7z6uXSDWZwvkVsneDV6dChVU58qR+vm5p+TJK98ro7KQIq1CahZAISJqy4M5i
 RPf5K64Cm1S+swwH3sPrjdw1WjT8nr2mbRT/mJRnY45FAJ+GiwgVGSwdHKxTO/uCJcVY
 R4deyOmODa9Pa4f5v9u2hKQIp1TDcFHYeBvT/6aw6XZmc/hO4Tz6gLT0jT7B6JHsxtbs
 mXoA==
X-Gm-Message-State: AOJu0YwV1TD2B/3i6tLfQwWyJCrQodbnGuKWfFyep9+9TE3w6UjqIkTp
 jKT0lwhKDq1+IrCQHwqbE2XMbA==
X-Google-Smtp-Source: AGHT+IH+V9+sbABR3mBzL8eRdMAbTYY6yqvd4Q060xTjB0J5LsrY08OLDEKBowtOqUEdwB4bSAEAVQ==
X-Received: by 2002:a05:600c:3658:b0:3fe:2bb1:11ba with SMTP id
 y24-20020a05600c365800b003fe2bb111bamr2088486wmq.27.1693405450967; 
 Wed, 30 Aug 2023 07:24:10 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 s14-20020adfea8e000000b003196b1bb528sm16950513wrm.64.2023.08.30.07.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 07:24:10 -0700 (PDT)
Message-ID: <75673960-234c-cb1b-baae-8c41c4c726f0@linaro.org>
Date: Wed, 30 Aug 2023 16:24:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] hw/intc/riscv_aplic.c fix non-KVM --enable-debug
 build
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org
References: <20230830133503.711138-1-dbarboza@ventanamicro.com>
 <20230830133503.711138-3-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830133503.711138-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 30/8/23 15:35, Daniel Henrique Barboza wrote:
> Commit 6df0b37e2ab breaks a --enable-debug build in a non-KVM
> environment with the following error:
> 
> /usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_intc_riscv_aplic.c.o: in function `riscv_kvm_aplic_request':
> ./qemu/build/../hw/intc/riscv_aplic.c:486: undefined reference to `kvm_set_irq'
> collect2: error: ld returned 1 exit status
> 
> This happens because the debug build will poke into the
> 'if (is_kvm_aia(aplic->msimode))' block and fail to find a reference to
> the KVM only function riscv_kvm_aplic_request().
> 
> There are multiple solutions to fix this. We'll go with the same
> solution from the previous patch, i.e. add a kvm_enabled() conditional
> to filter out the block. But there's a catch: riscv_kvm_aplic_request()
> is a local function that would end up being used if the compiler crops
> the block, and this won't work. Quoting Richard Henderson's explanation
> in [1]:
> 
> "(...) the compiler won't eliminate entire unused functions with -O0"
> 
> We'll solve it by moving riscv_kvm_aplic_request() to kvm.c and add its
> declaration in kvm_riscv.h, where all other KVM specific public
> functions are already declared. Other archs handles KVM specific code in
> this manner and we expect to do the same from now on.
> 
> [1] https://lore.kernel.org/qemu-riscv/d2f1ad02-eb03-138f-9d08-db676deeed05@linaro.org/
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/intc/riscv_aplic.c    | 8 ++------
>   target/riscv/kvm.c       | 5 +++++
>   target/riscv/kvm_riscv.h | 1 +
>   3 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



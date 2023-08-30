Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3818378D66B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:15:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLxF-0003cY-4C; Wed, 30 Aug 2023 10:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbLxD-0003cA-6e
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:13:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbLxA-00080N-L2
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:13:54 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68c0d262933so3661711b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693404831; x=1694009631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MmbH+T00FLFWjOm50zRpg3FoY8QbiomyYP9EjPj6WuQ=;
 b=okbSJVNOsOO77A/uiv7i7VaV3Cm++VzfxegHceDEWKAQTudw5eSeG4A43IlyTDm7Sf
 AyupN/93Qo4FU7nMEoB53OvuHoIKAsjN/JlvKzvnsankwHffTiqc0gzf92l1oxzQSHkR
 1RXMe3wRQ+Ps1aq7DlA7Ls5P5br8Gz70Gxs5WgCj5+liiouUJapLLOCJ0HVDM2RU8WC8
 Tf6lS4N7mnwiRT+MTtacrYYKcSDuT8ISabK3vPS+fBw7Rr2bJTOkPu807d2kLa5P/jvS
 CoLOfmZj+KQZVbBo5RbUFk9SrS3TO7wBlN8f3H3NiID9zIKObccAfuX4LxE0om99heEe
 Ujig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693404831; x=1694009631;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MmbH+T00FLFWjOm50zRpg3FoY8QbiomyYP9EjPj6WuQ=;
 b=WtKnWeSKDD29Ov2/YCA6KS/Akl/mDRf9grgTSyjXCP6LEDKG34cnrnRvOThh3IG+K5
 xbJvX7K2oXD0OgracjB5P9tQ6eopput59lm1VpIJhs+51q+EckeiFXtaf7H7tUoH/QAd
 9Ur9hBE+wVWA6zICuEaGa09FH9JweshtBnmMMz5fDWNDs1BigtRNRV8WoHAwjomYdubJ
 V2GFYOGwT9ZgZRQSFwviBa7BGoRt4tUdbKw6ycP9z68qg8BVT11lYoLEatN72Cr+UVa4
 LRuO29gFTggyyB4C/xofyieme7SLspPwzd/kn91ygeaxSYoybmgrMpM9jVaQKvcykWeY
 2yww==
X-Gm-Message-State: AOJu0YxWkF7H54ZQ4W75aNFP8DM1av6QdYaesZ+2vCNGyhoDQLJILvav
 SVys7fiSS/+Ip4bUIgiSJuF9iQ==
X-Google-Smtp-Source: AGHT+IGtUnG+6oBX3J9xurE8WIDMchev7SVITEKYZHX9YXz49PRyYLIj9PodOThCAtn+MxRh/x/dhw==
X-Received: by 2002:a05:6a20:9497:b0:14c:6cd9:bf9d with SMTP id
 hs23-20020a056a20949700b0014c6cd9bf9dmr2178273pzb.35.1693404830855; 
 Wed, 30 Aug 2023 07:13:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 k21-20020aa78215000000b0063f00898245sm10475355pfi.146.2023.08.30.07.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 07:13:50 -0700 (PDT)
Message-ID: <a0a62c44-baad-52e3-39d3-9e74ac0cdd83@linaro.org>
Date: Wed, 30 Aug 2023 07:13:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] hw/intc/riscv_aplic.c fix non-KVM --enable-debug
 build
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20230830133503.711138-1-dbarboza@ventanamicro.com>
 <20230830133503.711138-3-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830133503.711138-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 8/30/23 06:35, Daniel Henrique Barboza wrote:
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

Much better.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


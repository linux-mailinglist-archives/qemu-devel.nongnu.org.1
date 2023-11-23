Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 443CD7F5C36
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:24:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66s0-0003Cm-5v; Thu, 23 Nov 2023 05:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r66rz-0003CW-3j
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:23:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r66rx-0002lW-Fl
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:23:38 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40b27b498c3so4640415e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 02:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700735016; x=1701339816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BQXlq2DBaRvDl0dUwf6hitoVzbMvjzP4AsQvCnP7xJc=;
 b=R6BtQrTmj0nKyRSUcUZNRmKnn8JMRjOnOEiGG7rxecv2dEpq1GGpJiNXKG1P31i0ie
 QYKuGFEOwgmfvSKiLQV7zWU4/dY5K7hprcq4uQU9zLCDm9zwoCx+X5Qm9qb41NxcEYTM
 ZJREiIrB3LA7ONPXs8LOpbRH886JXRzQFwVwDmdeHMek5ZeB4lrEK/WzmGxJkN8AcPxP
 dNduG7yU7r0IpwOl8j78N6dhnNMccaYUP1Tr5NeiY7VkEAMcxMmF4UWLKeSd9vIFTWk2
 cfwx1a0kdD8qXi1TQ+8sOHQM/yedZV38BIKzta+Zb8oQRnw30t/2ClJIsg9e81KoRHbL
 ct7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700735016; x=1701339816;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BQXlq2DBaRvDl0dUwf6hitoVzbMvjzP4AsQvCnP7xJc=;
 b=jVEUu9mfXpW2WSh7UbaTXKmjO34jYmhMYACANm6U2WDQG9Olezipve480gNrUAUV27
 fSWLnFooksmowasd6Lu+QfSs/0POofbTCE+jUXcURiwd9/6RblRGqfywDTICyi08dWQl
 uVtH5JpQEQ+HfLuE4pcdCx0gCpyM/UkFtAqSttBLvBvie8pP8SYDF+wlTIT9VplIT5Dm
 /qxO1147T/VMpVBDCKw+s0ahjkxDbTVjQMqdZKL5e6M6Mbq/bKJKgqI5BjHWuUflAILp
 Dy0j+Ay/2ozqBAM3KB6VD4LKQWgzw3mwLR2XLL74tPyyc/s7i2EJYTKOiY8taMzwGo41
 YpJw==
X-Gm-Message-State: AOJu0YwKa0dGlTmVOOkfL5rAW9GmxgkP0hUf7Pgg/ZUXA8/TZ4yQmfZJ
 eLl4pLxffACfvQMWNgYgf92wQQ==
X-Google-Smtp-Source: AGHT+IEemMFpGEFEPgsAp7CH2cAZXG0zxAZgZvKV9H81rmOvRXXj+yTnDHlcQN9feY6l8KiIhCVTrg==
X-Received: by 2002:a05:600c:5250:b0:409:1841:3f42 with SMTP id
 fc16-20020a05600c525000b0040918413f42mr3625320wmb.13.1700735015882; 
 Thu, 23 Nov 2023 02:23:35 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 24-20020a05600c231800b0040b36050f1bsm1464159wmo.44.2023.11.23.02.23.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 02:23:35 -0800 (PST)
Message-ID: <5cb07d83-934d-4db0-8fee-3146f3751743@linaro.org>
Date: Thu, 23 Nov 2023 11:23:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2] target/riscv/kvm: fix shadowing in
 kvm_riscv_(get|put)_regs_csr
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com
References: <20231123101338.1040134-1-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123101338.1040134-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 23/11/23 11:13, Daniel Henrique Barboza wrote:
> KVM_RISCV_GET_CSR() and KVM_RISCV_SET_CSR() use an 'int ret' variable
> that is used to do an early 'return' if ret > 0. Both are being called
> in functions that are also declaring a 'ret' integer, initialized with
> '0', and this integer is used as return of the function.
> 
> The result is that the compiler is less than pleased and is pointing
> shadowing errors:
> 
> ../target/riscv/kvm/kvm-cpu.c: In function 'kvm_riscv_get_regs_csr':
> ../target/riscv/kvm/kvm-cpu.c:90:13: error: declaration of 'ret' shadows a previous local [-Werror=shadow=compatible-local]
>     90 |         int ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
>        |             ^~~
> ../target/riscv/kvm/kvm-cpu.c:539:5: note: in expansion of macro 'KVM_RISCV_GET_CSR'
>    539 |     KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
>        |     ^~~~~~~~~~~~~~~~~
> ../target/riscv/kvm/kvm-cpu.c:536:9: note: shadowed declaration is here
>    536 |     int ret = 0;


> The macros are doing early returns for non-zero returns and the local
> 'ret' variable for both functions is used just to do 'return 0', so
> remove them from kvm_riscv_get_regs_csr() and kvm_riscv_put_regs_csr()
> and do a straight 'return 0' in the end.
> 
> For good measure let's also rename the 'ret' variables in
> KVM_RISCV_GET_CSR() and KVM_RISCV_SET_CSR() to '_ret' to make them more
> resilient to these kind of errors.
> 
> Fixes: 937f0b4512 ("target/riscv: Implement kvm_arch_get_registers")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/kvm/kvm-cpu.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E010A8025D1
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 18:00:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9poG-0000NL-6L; Sun, 03 Dec 2023 11:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r9poE-0000Mw-Jo
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 11:59:10 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r9poC-00036N-RE
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 11:59:10 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50bce78f145so4354829e87.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 08:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701622746; x=1702227546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6fGhnCM7SbEHKPat590JFJQR983+thRlWEhndyCO1KE=;
 b=RPr+l+iPbwcDfgli6YTdw5RbLuJy2BUMvB5RMqjgWTGkaGbfTH61DCJrK0uSjCahd6
 wKc+iEH/zcphwDXQ3JFWVj7PXwA0L5xBt3f9Pli8+E/TaqtnfkOuvFjDKl6LTg8+pRMK
 kTRpYrUQlxwTaftZ4to/ZjRlEjOA6yatauY2R9DuEM1lJFFOSKS9P4BxsW9LBxvlgHm2
 6aso6+PMWE2UbC3AFxNl/LV1zb6mn0bEBGpHEZGJ+kduf8b7UiIYvUykucy9YRZPDDQG
 uPoqR0Poc00FXk0WxWNd04tRaWETf8cjdFEECt1aejt9/H+GXXcYH0bO5yhBRHmQdXNO
 VGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701622746; x=1702227546;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6fGhnCM7SbEHKPat590JFJQR983+thRlWEhndyCO1KE=;
 b=QyyRHIkwKEql15SH08cNjUAErjc2/GajSSbLwUVrnxm4/HiLsZKZIZO7se5LsoRCve
 //zg8nsdwMhXn3eOAwUmfXdKVHKOFNcfdaGywowa7a+FN56avgPpkwtgbgVvXnVAlTT/
 OOT95y2PxFtsTIUMtoY+jCEM1pdMAgE+qEWHAdRvf+5Zq+e54Q9tc5BGFiSwyhaJ+bil
 PgWwBttZ7say5MOrI2CedZ5tBHKTy/fWvtfB3Lq5Dmw4vbOlkqP6tRqth9LwsJx/mglk
 F/srtt8Oeg60jHlnbc2AQRWix+mc02QZutuPy9EddxViIncUWYJEvaPvEbNQrhxqwg0R
 YsGA==
X-Gm-Message-State: AOJu0YyY7nhsnguIkbB0gdWXwtn4PJaakgSH9vLMrCvdS2PTrJ7gSpGy
 5IUfYk7QQY6o70sqsmP/EPBMNg==
X-Google-Smtp-Source: AGHT+IHWDv2dKEM+R58KLRLEMaa39+FAVecuLHNVgQCJ7VMKH4xMXmCfGr3hMh17Dbj8LY/HRpwG2A==
X-Received: by 2002:a19:5e56:0:b0:50b:f4fc:8cf2 with SMTP id
 z22-20020a195e56000000b0050bf4fc8cf2mr125091lfi.151.1701622746099; 
 Sun, 03 Dec 2023 08:59:06 -0800 (PST)
Received: from [192.168.69.100] ([176.176.132.189])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a1709062b8700b00a1aad4d92dbsm1677086ejg.123.2023.12.03.08.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 08:59:05 -0800 (PST)
Message-ID: <94455c2c-dba0-454e-b9b6-3413f272e13f@linaro.org>
Date: Sun, 3 Dec 2023 17:59:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2] target/riscv/kvm: fix shadowing in
 kvm_riscv_(get|put)_regs_csr
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, Markus Armbruster <armbru@redhat.com>,
 zhiwei_liu@linux.alibaba.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, palmer@rivosinc.com, ajones@ventanamicro.com,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20231123101338.1040134-1-dbarboza@ventanamicro.com>
 <5cb07d83-934d-4db0-8fee-3146f3751743@linaro.org>
In-Reply-To: <5cb07d83-934d-4db0-8fee-3146f3751743@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 23/11/23 11:23, Philippe Mathieu-Daudé wrote:
> On 23/11/23 11:13, Daniel Henrique Barboza wrote:
>> KVM_RISCV_GET_CSR() and KVM_RISCV_SET_CSR() use an 'int ret' variable
>> that is used to do an early 'return' if ret > 0. Both are being called
>> in functions that are also declaring a 'ret' integer, initialized with
>> '0', and this integer is used as return of the function.
>>
>> The result is that the compiler is less than pleased and is pointing
>> shadowing errors:
>>
>> ../target/riscv/kvm/kvm-cpu.c: In function 'kvm_riscv_get_regs_csr':
>> ../target/riscv/kvm/kvm-cpu.c:90:13: error: declaration of 'ret' 
>> shadows a previous local [-Werror=shadow=compatible-local]
>>     90 |         int ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, 
>> csr), &reg); \
>>        |             ^~~
>> ../target/riscv/kvm/kvm-cpu.c:539:5: note: in expansion of macro 
>> 'KVM_RISCV_GET_CSR'
>>    539 |     KVM_RISCV_GET_CSR(cs, env, sstatus, env->mstatus);
>>        |     ^~~~~~~~~~~~~~~~~
>> ../target/riscv/kvm/kvm-cpu.c:536:9: note: shadowed declaration is here
>>    536 |     int ret = 0;
> 
> 
>> The macros are doing early returns for non-zero returns and the local
>> 'ret' variable for both functions is used just to do 'return 0', so
>> remove them from kvm_riscv_get_regs_csr() and kvm_riscv_put_regs_csr()
>> and do a straight 'return 0' in the end.
>>
>> For good measure let's also rename the 'ret' variables in
>> KVM_RISCV_GET_CSR() and KVM_RISCV_SET_CSR() to '_ret' to make them more
>> resilient to these kind of errors.
>>
>> Fixes: 937f0b4512 ("target/riscv: Implement kvm_arch_get_registers")
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/kvm/kvm-cpu.c | 19 +++++++++----------
>>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Also:

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Alistair, if you don't have any pending riscv pull request
I can take this patch with the one I plan to post tomorrow
(this is the last fix missing to get our CI green again).


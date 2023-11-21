Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6537F2DCF
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 13:56:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5QHY-0006e4-8G; Tue, 21 Nov 2023 07:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r5QHV-0006dm-3T
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:55:09 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r5QHL-0004Bu-Jf
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:55:07 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc3542e328so40521945ad.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 04:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700571298; x=1701176098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=meUBYdOP22fl+Zx1rl9mhG9Zehql+ZMDsSHp/CND19Q=;
 b=blQkAu2zCZcVEde7+yxrrO6+zh5ST5f6ONfN42RL42WNMjBEeIi2yyUGpk503vm6wF
 gnsBYVUvQumQqDRZDAkl5mRpoJ+Xq2x/Y6xda3TSha/Wl/OCEOuMiITCoGbHT2/chD7o
 69p8hlQRRlAOo3soHv5LBZCtENH0MiKVVR60J3KyW278c+t6nZjaWimZ7nUje+fyH3gQ
 K5WxMpl9csQ0gvaAUn/G6RTBj/gz13FX+Ms1M5Kj9YafMdcx+aw+8z4DLZoWblpDtJYc
 bnUxRzx6VwGWEVl7/7N9LLBv9LhG0HpvB2tCwE9LAUVZl2jfT2vF7qSJJd6nXZQ0ZH+6
 veLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700571298; x=1701176098;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=meUBYdOP22fl+Zx1rl9mhG9Zehql+ZMDsSHp/CND19Q=;
 b=r0Eg9zaDKSlM/Fvnn+Pxb2S7MFF34zwcDlEen2luAuYg7j2MuUakx/9aJohcUSkPxC
 YplA8NWlr5UX8ZwlEYRTHkhqsBGRG/vf8CWEsA/1bSaRHsPtXRpDWME87rLOfyqutI+k
 T0EMLrUSO0acMrWU4+ksKAiTS0eIW1/+LHmXzNGt6RFVbnmbF6SCzLGI/M8ab+/J5jCr
 4CgkBN6WN2KnfoDj2z9Xq8M0Mi+t99pemmOKkR+W/5tXV0bS2sWY1tRL2+q6aG9OzgSN
 h7z3Hr0XUFOlHton0Ne/n+/KXkh7GrGD6mxk8Mw8be0EEaDjxWUWRJN4t6F6c0lJLpah
 q2Ag==
X-Gm-Message-State: AOJu0YzDOpVBN5r/rMW960hw7cnLWO8l3B9pknDbq7lNE83ExSyG0W82
 /dWRcg+senoKDH3wS7GeyhMEOQ==
X-Google-Smtp-Source: AGHT+IHTDRgiE3b3A3y1/0qsrRtpJw/TGMURgElGl7YDAkdgzX8IBp7Yu9jN1rk8dits6ldpl/GpWA==
X-Received: by 2002:a17:90b:164c:b0:285:24bb:4524 with SMTP id
 il12-20020a17090b164c00b0028524bb4524mr5120334pjb.24.1700571297967; 
 Tue, 21 Nov 2023 04:54:57 -0800 (PST)
Received: from [192.168.68.109] ([152.250.131.119])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a17090aa38a00b0028328057c67sm7027577pjp.45.2023.11.21.04.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 04:54:57 -0800 (PST)
Message-ID: <8ec16fea-c8af-47d9-afe4-20a6f3f74a8e@ventanamicro.com>
Date: Tue, 21 Nov 2023 09:54:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/riscv/cpu_helper.c: Invalid exception on
 MMU translation stage
Content-Language: en-US
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
References: <20231121071757.7178-1-ivan.klokov@syntacore.com>
 <20231121071757.7178-2-ivan.klokov@syntacore.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231121071757.7178-2-ivan.klokov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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



On 11/21/23 04:17, Ivan Klokov wrote:
> According to RISCV privileged spec sect. 5.3.2 Virtual Address Translation Process
> access-fault exceptions may raise only after PMA/PMP check. Current implementation
> generates an access-fault for mbare mode even if there were no PMA/PMP errors.
> This patch removes the erroneous MMU mode check and generates an access-fault
> exception based on the pmp_violation flag only.
> 
> Fixes: 1448689c7b ("target/riscv: Allow specifying MMU stage")
> 
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_helper.c | 30 +++++++-----------------------
>   1 file changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index b7af69de53..9ff0952e46 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1143,47 +1143,31 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
>                                   bool two_stage_indirect)
>   {
>       CPUState *cs = env_cpu(env);
> -    int page_fault_exceptions, vm;
> -    uint64_t stap_mode;
> -
> -    if (riscv_cpu_mxl(env) == MXL_RV32) {
> -        stap_mode = SATP32_MODE;
> -    } else {
> -        stap_mode = SATP64_MODE;
> -    }
> -
> -    if (first_stage) {
> -        vm = get_field(env->satp, stap_mode);
> -    } else {
> -        vm = get_field(env->hgatp, stap_mode);
> -    }
> -
> -    page_fault_exceptions = vm != VM_1_10_MBARE && !pmp_violation;
>   
>       switch (access_type) {
>       case MMU_INST_FETCH:
>           if (env->virt_enabled && !first_stage) {
>               cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
>           } else {
> -            cs->exception_index = page_fault_exceptions ?
> -                RISCV_EXCP_INST_PAGE_FAULT : RISCV_EXCP_INST_ACCESS_FAULT;
> +            cs->exception_index = pmp_violation ?
> +                RISCV_EXCP_INST_ACCESS_FAULT : RISCV_EXCP_INST_PAGE_FAULT;
>           }
>           break;
>       case MMU_DATA_LOAD:
>           if (two_stage && !first_stage) {
>               cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
>           } else {
> -            cs->exception_index = page_fault_exceptions ?
> -                RISCV_EXCP_LOAD_PAGE_FAULT : RISCV_EXCP_LOAD_ACCESS_FAULT;
> +            cs->exception_index = pmp_violation ?
> +                RISCV_EXCP_LOAD_ACCESS_FAULT : RISCV_EXCP_LOAD_PAGE_FAULT;
>           }
>           break;
>       case MMU_DATA_STORE:
>           if (two_stage && !first_stage) {
>               cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
>           } else {
> -            cs->exception_index = page_fault_exceptions ?
> -                RISCV_EXCP_STORE_PAGE_FAULT :
> -                RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
> +            cs->exception_index = pmp_violation ?
> +                RISCV_EXCP_STORE_AMO_ACCESS_FAULT :
> +                RISCV_EXCP_STORE_PAGE_FAULT;
>           }
>           break;
>       default:


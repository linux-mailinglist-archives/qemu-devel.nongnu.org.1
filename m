Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87146722EEC
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 20:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6FEu-00041c-2a; Mon, 05 Jun 2023 14:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q6FEk-00040s-QJ
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 14:47:28 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q6FEj-0004KA-10
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 14:47:26 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-392116ae103so3504989b6e.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685990843; x=1688582843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k1Kg1wIo2iyavH4s8HpoaY6EzhUcDlXe84Pa6j9p1cE=;
 b=YtC+NNgE3CElzt9CkB/sbJ4biwdC4bWHyk21lpIun5XmOTB5+aNIhamP7iDECe/swU
 RzAA+9SXvphdX0dadqvJsOdo2a/PI4+OAr8/pW19+sAc29lyAyJNF59pjmhRhTVQeVGN
 b6Gz4VS+2NKMLCFWd2V058NLLTZ9w3bTD4R+yHRuPoioX0Ct+CJOJebKylF3b2R2A0YE
 3UYyt0r3YEv6dlUpPnHtkZI8vAUOiAgmMIDLs7dQgLE1B6zpTLcD8UjMB8KcxX93C2Xn
 F5MeqUDKHKIAHLMhn8JaLzkF/wyURs5+hR0J6XD3XALXDEdLXuODIVyz5yTkeUFtRo70
 pyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685990843; x=1688582843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k1Kg1wIo2iyavH4s8HpoaY6EzhUcDlXe84Pa6j9p1cE=;
 b=iAWaNdLc8KaIjJPXL3hQ1Luxf6+YHu6q49dtVQl6vOEFGuRW+MO5Ayo+OQsGfbAPPK
 9wO10um/k6gDkeFKlohPQnWstwFoMPf2WeHC3lXr7j7YPX5VByWXv4YIeDz1kjIRZNvY
 2nRs4Yzn5dLKrdq2040Fai2kvTPzCrRNkA3LadwAC0o+bZ+J2OxkfI82Q4hR6yeSbEwC
 ZEJKLXOcPGa31gXAvKXKd9IKp0gZ2fly3LpCvWP4GJuS3MdY79d63piKYsQaJ/pczEez
 pPGBb/4oBTzvfFL8VzrpPn2r8E8OHDFy9O7SIX4vSkCUPM0klsuP0Shmu3P4mLdjwa7I
 JeAg==
X-Gm-Message-State: AC+VfDzUrFYRjJvXPCH4sJJ0x3DfyQhpqFZP4oSUCGRg6lnFr4Z3ihw3
 4dL0DFUocYFRBYTfx93xSHOCOQ==
X-Google-Smtp-Source: ACHHUZ4mFsJjGwJnmczcu4jXVsnwWgG2CwbMbNXTwqXSMV0yBJBslVJi5AiDRhXrKE3vjXUA7/iwdw==
X-Received: by 2002:a05:6808:2:b0:396:fa0:f580 with SMTP id
 u2-20020a056808000200b003960fa0f580mr5151359oic.59.1685990843476; 
 Mon, 05 Jun 2023 11:47:23 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 v5-20020acade05000000b0039a016ec102sm3790313oig.15.2023.06.05.11.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 11:47:23 -0700 (PDT)
Message-ID: <2a3c6c6d-e37c-83cc-ea32-5f341ee1e24c@ventanamicro.com>
Date: Mon, 5 Jun 2023 15:47:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/6] target/riscv: check the in-kernel irqchip support
Content-Language: en-US
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, rkanwal@rivosinc.com, anup@brainfault.org,
 atishp@atishpatra.org, vincent.chen@sifive.com, greentime.hu@sifive.com,
 frank.chang@sifive.com, jim.shu@sifive.com
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20230526062509.31682-1-yongxuan.wang@sifive.com>
 <20230526062509.31682-4-yongxuan.wang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230526062509.31682-4-yongxuan.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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



On 5/26/23 03:25, Yong-Xuan Wang wrote:
> We check the in-kernel irqchip support when using KVM acceleration.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/kvm.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index 0f932a5b96..eb469e8ca5 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -433,7 +433,18 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>   
>   int kvm_arch_irqchip_create(KVMState *s)
>   {
> -    return 0;
> +    if (kvm_kernel_irqchip_split()) {
> +        error_report("-machine kernel_irqchip=split is not supported "
> +                     "on RISC-V.");
> +        exit(1);
> +    }
> +
> +    /*
> +     * If we can create the VAIA using the newer device control API, we
> +     * let the device do this when it initializes itself, otherwise we
> +     * fall back to the old API
> +     */
> +    return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
>   }
>   
>   int kvm_arch_process_async_events(CPUState *cs)


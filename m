Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB45A725F04
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 14:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6sA3-0001p4-J8; Wed, 07 Jun 2023 08:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6sA1-0001on-IH
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:21:09 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q6s9z-0004ds-Lu
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:21:09 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30e4eec95c8so1654378f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 05:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686140466; x=1688732466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W0LpT8sdQEWQzJfKUi7AGseEz3npKiUVVQMj8I8yLZo=;
 b=ehFVBKbRtuKiWxqnKk1la+ZW8718eq9cGuOF78q0XcbbkcJOcZFDO7kiTmcrLI7qpa
 xuWDCdBtn5fSe+WGDlKaht4FezhIl/zQgWrtu+UqiVcb8glo3Hb81YAYTf2dukiRZLbp
 BqAT1uruAA7ZtKmk3d0ugZMGGeGwvnWlWBTI4dAAVsHA0oqdmsVwk+a0CECk1IWhQ97/
 6T/oBVy4VAtg5a+3DKRXuFGTmbgfsSFs7aPNL7N7SPcorzFelsQDX0nZzq/ciHQjlq6/
 tzfKR5lAqqLAw/OKHvy+tM6XeLFH0AKt/NschYaUkoH80gdgJHZDx3B2nOCwBPydnqiP
 bKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686140466; x=1688732466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0LpT8sdQEWQzJfKUi7AGseEz3npKiUVVQMj8I8yLZo=;
 b=D34JoE5xXMabmNB0P5fGdAklZzQarQ5BTGW74oihHK1HGMfFHgaA53NnZhJlIZqsYy
 0/BRkMtgSJVimesSRAtgvRYBTtcnUkue+fmDnevvVX7ZZg55qPfHkTa0iPGMd9I2fNN5
 Pw+GOsDPzKCSH6h892KY4JdiVs80uCv0EOFYJAi8dh1Rj2nRezGPS+ke96peBq3C8IWu
 nMD+J+xzQKaL9LJ+xJvuTb5gTPhj3TNmZ2DzNpTrRApKUQ6l9jyO+tGe2WfFRnuobGzn
 gnIJ2kLJJpG7zmA5T23iHT/EFO+aC74nijOQLt+AmZHmRITvCQiK2FdQj6rPrxEUnykO
 oW7g==
X-Gm-Message-State: AC+VfDxLacGvcEKejzVa368XNXK+nP/25WzXLGx8YftTLz16Hb451x+C
 fNUJS0yTgc+wWIlNCVY/dJMt8mEOrjydwjdUVCc=
X-Google-Smtp-Source: ACHHUZ5RoBcqwmSarNqXJ5MiLdF9IC+9LSKcAs0c80cdbnyN16w4TxcxlCz+yaAgtPPrZ4X+iuzWzQ==
X-Received: by 2002:a5d:6882:0:b0:30e:3df6:b994 with SMTP id
 h2-20020a5d6882000000b0030e3df6b994mr6963946wru.38.1686140465954; 
 Wed, 07 Jun 2023 05:21:05 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adff54e000000b0030aec5e020fsm15465179wrp.86.2023.06.07.05.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 05:21:05 -0700 (PDT)
Date: Wed, 7 Jun 2023 14:21:04 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 14/16] target/riscv: adapt 'riscv_isa_string' for KVM
Message-ID: <20230607-8e2b65e6a054c4f5f2962e85@orel>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
 <20230530194623.272652-15-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530194623.272652-15-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42a.google.com
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

On Tue, May 30, 2023 at 04:46:21PM -0300, Daniel Henrique Barboza wrote:
> KVM is not using the same attributes as TCG, i.e. it doesn't use
> isa_edata_arr[]. Add a new kvm_riscv_isa_string_ext() helper that does
> basically the same thing, but using KVM internals instead.
> 
> The decision to add this helper target/riscv/kvm.c is to foster the
> separation between KVM and TCG logic, while still using
> riscv_isa_string_ext() from target/riscv/cpu.c to retrieve the string
> to not overcomplicate things.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c       |  5 +++++
>  target/riscv/kvm.c       | 19 +++++++++++++++++++
>  target/riscv/kvm_riscv.h |  2 ++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3c348049a3..ec1d0c621a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1956,6 +1956,11 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
>      char *new = *isa_str;
>      int i;
>  
> +    if (riscv_running_KVM()) {
> +        kvm_riscv_isa_string_ext(cpu, isa_str, max_str_len);
> +        return;
> +    }
> +
>      for (i = 0; i < ARRAY_SIZE(isa_edata_arr); i++) {
>          if (cpu->env.priv_ver >= isa_edata_arr[i].min_version &&
>              isa_ext_is_enabled(cpu, &isa_edata_arr[i])) {
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index b4193a10d8..675e18df3b 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -320,6 +320,25 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
>      }
>  }
>  
> +void kvm_riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
> +                              int max_str_len)
> +{
> +    char *old = *isa_str;
> +    char *new = *isa_str;
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
> +        RISCVCPUMultiExtConfig *multi_ext_cfg = &kvm_multi_ext_cfgs[i];
> +        if (kvm_cpu_cfg_get(cpu, multi_ext_cfg)) {
> +            new = g_strconcat(old, "_", multi_ext_cfg->name, NULL);
> +            g_free(old);
> +            old = new;
> +        }
> +    }
> +
> +    *isa_str = new;
> +}
> +
>  static int kvm_riscv_get_regs_core(CPUState *cs)
>  {
>      int ret = 0;
> diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
> index e3ba935808..1a12efa8db 100644
> --- a/target/riscv/kvm_riscv.h
> +++ b/target/riscv/kvm_riscv.h
> @@ -20,6 +20,8 @@
>  #define QEMU_KVM_RISCV_H
>  
>  void kvm_riscv_init_user_properties(Object *cpu_obj);
> +void kvm_riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
> +                              int max_str_len);
>  void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
>  
> -- 
> 2.40.1
> 
>

Hmm, more duplication. I think we need an abstraction which can support
both TCG and KVM extension lists. Allowing functions like
riscv_isa_string_ext() to be shared for them.

Thanks,
drew


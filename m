Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F21A7204E8
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:53:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q568o-0004tA-4P; Fri, 02 Jun 2023 10:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q568m-0004sg-Ox
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:52:32 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1q568k-0000lX-Vg
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:52:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-30ad8f33f1aso2171020f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685717549; x=1688309549;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wdBprvCcJXIN8y9umyt0+Ldwisd3w1YNbTs16nEW6Dg=;
 b=IxwRZCTAKCqim2T0RDMRKbjtK6E1rbSOYAySTC1VPNOJHILkBHu/buF/aTMvXE/js4
 /mWwHrfu2DgJ/JiKtpHwev4ffhOtILcnlUbm8RwFUmlau3sUbgtjhxwKowYZ5ce3u1aT
 EY9IQRQlqKaRopoufKT6aZ6IfQ3dFK3OHFGX6aLNHes+6pbZ3te6GLRViSXZxffaBEo3
 nT44NX7ZgccZriGP0AYfAy0ptrSsYhLaZkWIvo2hI7U7W1VSxrV86BDeAA3WQ5j4Nypz
 KL+jTyKa5ZcrqWxD0ocxLtcLNSA8hnszn27uvp1D6pTEhGJraWMihToCafQcOcKVyepi
 8CyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685717549; x=1688309549;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdBprvCcJXIN8y9umyt0+Ldwisd3w1YNbTs16nEW6Dg=;
 b=EX0g1hIANi2Y48VhIeJOAi8NqH0c+m4bX95PAfFC+rPF8aL6ZBsdCeU/HYYVTzxKOE
 cZ615KTefO9zom5r/j3ImU/mpGggPJXM6FGoQbDIuuSsJZx1M/LTGPdrDZBtotfiailm
 LzLc9XQ3rTMcISNfSTlJggOiCdkFQICQQ8eFr3adggANiToQX6cYG1xL2e4CgGLvzF2F
 HhpWZweMYCYMDD7+W833HCZk2qlk5uovt5SQiDZFL2FxecB/t48ykwR+ijBehX1x76vM
 jl+zfpdYawVht1jKhPbn4Xpha06QUKnaIcroa16ZQXEFTGrKw7eVF6Ff5CzFFQyXvfBt
 rLIg==
X-Gm-Message-State: AC+VfDyJVTMLt0a9xLq13uOOfiVqJN1Fi0o8UgsIMBE/We2e/aIzzmRL
 uQncVrLB0ifotTAY4NRTo/sGpQ==
X-Google-Smtp-Source: ACHHUZ4fjvMr3I3NZrrWqDJhD4nUnHUZcLj7+rk+j3HYoIUTtYAk5KJm2nDm3mqpr7UVxvp7gczGBQ==
X-Received: by 2002:a05:6000:885:b0:30a:e465:5b29 with SMTP id
 cs5-20020a056000088500b0030ae4655b29mr148340wrb.57.1685717549414; 
 Fri, 02 Jun 2023 07:52:29 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 y6-20020adfd086000000b0030631a599a0sm1915587wrh.24.2023.06.02.07.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 07:52:28 -0700 (PDT)
Date: Fri, 2 Jun 2023 16:52:27 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 01/16] target/riscv: skip features setup for KVM CPUs
Message-ID: <20230602-7ceb7c223fdd817d647e204a@orel>
References: <20230530194623.272652-1-dbarboza@ventanamicro.com>
 <20230530194623.272652-2-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530194623.272652-2-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x431.google.com
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

On Tue, May 30, 2023 at 04:46:08PM -0300, Daniel Henrique Barboza wrote:
> As it is today it's not possible to use '-cpu host' if the RISC-V host
> has RVH enabled. This is the resulting error:
> 
> $ sudo ./qemu/build/qemu-system-riscv64 \
>     -machine virt,accel=kvm -m 2G -smp 1 \
>     -nographic -snapshot -kernel ./guest_imgs/Image  \
>     -initrd ./guest_imgs/rootfs_kvm_riscv64.img \
>     -append "earlycon=sbi root=/dev/ram rw" \
>     -cpu host
> qemu-system-riscv64: H extension requires priv spec 1.12.0
> 
> This happens because we're checking for priv spec for all CPUs, and
> since we're not setting  env->priv_ver for the 'host' CPU, it's being
> default to zero (i.e. PRIV_SPEC_1_10_0).
> 
> In reality env->priv_ver does not make sense when running with the KVM
> 'host' CPU. It's used to gate certain CSRs/extensions during translation
> to make them unavailable if the hart declares an older spec version. It
> doesn't have any other use. E.g. OpenSBI version 1.2 retrieves the spec
> checking if the CSR_MCOUNTEREN, CSR_MCOUNTINHIBIT and CSR_MENVCFG CSRs
> are available [1].
> 
> 'priv_ver' is just one example. We're doing a lot of feature validation
> and setup during riscv_cpu_realize() that it doesn't apply KVM CPUs.
> Validating the feature set for those CPUs is a KVM problem that should
> be handled in KVM specific code.
> 
> The new riscv_cpu_realize_features() helper contains all validation
> logic that are not applicable to KVM CPUs. riscv_cpu_realize() verifies
> if we're dealing with a KVM CPU and, if not, execute the new helper to
> proceed with the usual realize() logic for all other CPUs.
> 
> [1] lib/sbi/sbi_hart.c, hart_detect_features()
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 41 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 938c7bd87b..72f5433776 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -331,6 +331,15 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
>  }
>  #endif
>  
> +static bool riscv_running_KVM(void)

KVM should be lowercase

> +{
> +#ifndef CONFIG_USER_ONLY
> +    return kvm_enabled();
> +#else
> +    return false;
> +#endif
> +}
> +
>  static void riscv_any_cpu_init(Object *obj)
>  {
>      RISCVCPU *cpu = RISCV_CPU(obj);
> @@ -1295,20 +1304,12 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
>      }
>  }
>  
> -static void riscv_cpu_realize(DeviceState *dev, Error **errp)
> +static void riscv_cpu_realize_features(DeviceState *dev, Error **errp)
>  {
> -    CPUState *cs = CPU(dev);
>      RISCVCPU *cpu = RISCV_CPU(dev);
>      CPURISCVState *env = &cpu->env;
> -    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
>      Error *local_err = NULL;
>  
> -    cpu_exec_realizefn(cs, &local_err);
> -    if (local_err != NULL) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
>      riscv_cpu_validate_misa_mxl(cpu, &local_err);
>      if (local_err != NULL) {
>          error_propagate(errp, local_err);
> @@ -1354,6 +1355,28 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>          }
>       }
>  #endif
> +}
> +
> +static void riscv_cpu_realize(DeviceState *dev, Error **errp)
> +{
> +    CPUState *cs = CPU(dev);
> +    RISCVCPU *cpu = RISCV_CPU(dev);
> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
> +    Error *local_err = NULL;
> +
> +    cpu_exec_realizefn(cs, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    if (!riscv_running_KVM()) {
> +        riscv_cpu_realize_features(dev, &local_err);
> +        if (local_err != NULL) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
>  
>      riscv_cpu_finalize_features(cpu, &local_err);
>      if (local_err != NULL) {
> -- 
> 2.40.1
> 
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


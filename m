Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE1C7DFFD7
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 09:52:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyptM-0007s4-1v; Fri, 03 Nov 2023 04:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qyptF-0007rV-Nj
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 04:50:54 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qyptA-0001w6-DU
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 04:50:53 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9d2c54482fbso286142566b.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699001446; x=1699606246; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U6Fvi81VSm944UMI0Pe1LOqSYJk2/CYiA8QinHkUup8=;
 b=Vbm3iovI316iTtbwzPbGC/RwYPSFbZ4W6uen3QaKp8Dp025V3Cl1bgbHwxn82ZvtFb
 ksUIj4dK/iUpsdaWzVita9klXh+B9wgXQ2uyiQRL0u+tRfj6SVP7bi8w/tHOFf/PAeeZ
 /pkrSpg3GMgEvLN+6so/hKm6pDb4xnR37lBuK8tNdh2sfUdS1go1mSVch/jGSQtX5Wk/
 4/pENwXM7PJazLCZoSCmeYc9mjGDtx4c/nL6ynSLdJPlJEnxmf3F5e5EPUHeidUKxime
 sXm83lZMGhadeykUNC8TyDTFtjmauTykbEEQh+cqiPkFDD2hd9YPfS6nTW7Ys946MApL
 TRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699001446; x=1699606246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U6Fvi81VSm944UMI0Pe1LOqSYJk2/CYiA8QinHkUup8=;
 b=v+CoJ9WTshBbZyyeiUvqg8RbSEyVFCuhP7E8BP3m8NXftlYPiFAc+NieE6zxnNSmDr
 QnyR1qdKnk8IGNmEhCx5xfiIaen69ehavckJjDpxYhge6aT3kjqQTcFo2IKNiFpwNiuQ
 eD2XnfjpVZkOxBIl0JhR9JZAI+CFS9HdGzvlzoxr+X4+JqubHgBg9wNMtYqmHcZ4Uqem
 zjvotuQrt2GwzNnTZYtrYuXo8giex/iMN4hxtwESXBWtqgMkwMPZPBxAfTnocZlH+Jjo
 KqsfKa17NcnU8RajZnB55y1EEPp5aye/IG8EtxGvQY3OOnfIjFnuYXCPiLNzlP6Dua9v
 DupA==
X-Gm-Message-State: AOJu0YwYtCVrngB0CejBvYZV9O+0yxkaFqpZnLxNVdJrOFtJiE+wLvH+
 TR8rjbFBhfSzD0RDOr16Ew8fpg==
X-Google-Smtp-Source: AGHT+IG2/AHAga99xnGPWaOfAhck1CNLzLevbQDCAHtunnJ4/yj4OXPVmr49OaZt3/5NTmLu60Ihqw==
X-Received: by 2002:a17:907:a646:b0:9da:f391:409a with SMTP id
 vu6-20020a170907a64600b009daf391409amr5038044ejc.26.1699001446218; 
 Fri, 03 Nov 2023 01:50:46 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 by25-20020a170906a2d900b00982a92a849asm654142ejb.91.2023.11.03.01.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 01:50:45 -0700 (PDT)
Date: Fri, 3 Nov 2023 09:50:45 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v9 18/19] target/riscv: add 'rva22u64' CPU
Message-ID: <20231103-4793031b6694bd214f656e3f@orel>
References: <20231102224445.527355-1-dbarboza@ventanamicro.com>
 <20231102224445.527355-19-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102224445.527355-19-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Nov 02, 2023 at 07:44:44PM -0300, Daniel Henrique Barboza wrote:
> This CPU was suggested by Alistair [1] and others during the profile
> design discussions. It consists of the bare 'rv64i' CPU with rva22u64
> enabled by default, like an alias of '-cpu rv64i,rva22u64=true'.
> 
> Users now have an even easier way of consuming this user-mode profile by
> doing '-cpu rva22u64'. Extensions can be enabled/disabled at will on top
> of it.
> 
> We can boot Linux with this "user-mode" CPU by doing:
> 
> -cpu rva22u64,sv39=true,s=true,zifencei=true
> 
> [1] https://lore.kernel.org/qemu-riscv/CAKmqyKP7xzZ9Sx=-Lbx2Ob0qCfB7Z+JO944FQ2TQ+49mqo0q_Q@mail.gmail.com/
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu-qom.h     |  1 +
>  target/riscv/cpu.c         | 10 ++++++++++
>  target/riscv/tcg/tcg-cpu.c |  9 +++++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index ea9a752280..ac38ffc6cf 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -37,6 +37,7 @@
>  #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
>  #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
>  #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
> +#define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>  #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d24ffbf3f8..1f2932031a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1542,6 +1542,15 @@ static Property riscv_cpu_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +#if defined(TARGET_RISCV64)
> +static void rva22u64_bare_cpu_init(Object *obj)

The "rva22u64_bare" name is a bit weird, indicating it's both an rva22u64
type and a bare type, which isn't possible. Why not just
rva22u64_cpu_init()?

> +{
> +    rv64i_bare_cpu_init(obj);
> +
> +    RVA22U64.enabled = true;
> +}
> +#endif
> +
>  static const gchar *riscv_gdb_arch_name(CPUState *cs)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
> @@ -1876,6 +1885,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,   rv64_veyron_v1_cpu_init),
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,  rv128_base_cpu_init),
>      DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I, rv64i_bare_cpu_init),
> +    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RVA22U64, rva22u64_bare_cpu_init),

Oh, I see. Because we want to use DEFINE_BARE_CPU() here we wanted bare in
the init function name. Maybe, for self-documentation / less confusion
purposes, we should have a DEFINE_PROFILE_CPU() macro even if it's just an
alias for DEFINE_BARE_CPU().

>  #endif
>  };
>  
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index ef43264cb3..553fb337e7 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1068,6 +1068,15 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
>          object_property_add(cpu_obj, profile->name, "bool",
>                              cpu_get_profile, cpu_set_profile,
>                              NULL, (void *)profile);
> +
> +        /*
> +         * CPUs might enable a profile right from the start.
> +         * Enable its mandatory extensions right away in this
> +         * case.
> +         */
> +        if (profile->enabled) {
> +            object_property_set_bool(cpu_obj, profile->name, true, NULL);
> +        }
>      }
>  }
>  
> -- 
> 2.41.0
> 

Other than the naming nits.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew


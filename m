Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AA37D7175
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 18:10:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvgRf-0007DR-A6; Wed, 25 Oct 2023 12:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvgRc-0007CX-AC
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:09:20 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvgRZ-0005aL-Pf
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:09:20 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso928084666b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698250156; x=1698854956; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JkzyCyjR+k3ifO6fdn3zmtFmH3dodqawzdDuH7wDHiI=;
 b=mAp+SEFDwKqTPjRGGPJzQ4aLfsWOf2SKT+veqSoA4zJT49LgGYupIp/0U2kBPrkWRm
 x1V6bAuko0qUjvJQx3Y01DvAVTSikVk1ahyZ2Ii+ZQRQe4vpHM2xK+ZxOYmvRWI84ByM
 lZP1tG+2FtxC2fmaj1Z/u1Gt1FpVb3po/yGMMbIjkWQzJUxteUtG/MQ81mprKzlx/xDG
 OmHf0ROmHIQE66+H5y3HpdjNiuhTBn7g3YFl9+x7ECXJGrfdRlH+un1pmggrkEZfvfX1
 XEXDS7+TtdZ+SuwO4DWnaTXtjrPUZZhOuHfccXhpG73yTEJ8wXid458n+oCSUUDQD50c
 z/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698250156; x=1698854956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JkzyCyjR+k3ifO6fdn3zmtFmH3dodqawzdDuH7wDHiI=;
 b=IAcQPGe9dmaMKq2PqmxUWA6q/+mEDQPcqf2tSCNGxXf3EDCrJn3ouhhUqaqvb52Kdn
 xhfDQQFGjE1pKvkNzsJJf/Zr0PMq7hqjPg2srbpKphDTI9hXuzz36uVR+U3TWW1/PbEg
 TnRZT8lWeGVyNxow+hKXzpIDHaVlz9ENQFvmvRP7PZ83wvUejbc3EqH7+STD/Jx62rDz
 LBS5ANSMO7N1kz6xKAJX4MFPndmSM4xHQbPjhNjisVhkl/8LdvvOtDoCF3P2x+4wv/sK
 jzaFzR00dk2ZcacjbzOYlEFRYltYsz8qTrSze4gOFL/eiz1ZSXRVK6GzJhPlgMp9be4B
 qaeA==
X-Gm-Message-State: AOJu0YxniiYR5wGlBfExOXbtvdaaegFx53iZbpKehXFhi/n9GzQKkdGH
 J63mfnoresQ1VuHUTIpyd243ig==
X-Google-Smtp-Source: AGHT+IF2IKE5n0ZBDnVTQ5kLnCaXTKAYsOibuHULi1jmZpOmTVnxqduxb/XsrHYOylx18kQWFT5rWw==
X-Received: by 2002:a17:907:3f09:b0:9ad:c763:bc7a with SMTP id
 hq9-20020a1709073f0900b009adc763bc7amr14708616ejc.23.1698250155707; 
 Wed, 25 Oct 2023 09:09:15 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a170906354c00b0098f33157e7dsm10026274eja.82.2023.10.25.09.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 09:09:15 -0700 (PDT)
Date: Wed, 25 Oct 2023 18:09:14 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v4 2/9] target/riscv/kvm: add 'rva22u64' flag as
 unavailable
Message-ID: <20231025-0ea673952495b43f37709a75@orel>
References: <20231025135001.531224-1-dbarboza@ventanamicro.com>
 <20231025135001.531224-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025135001.531224-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Oct 25, 2023 at 10:49:54AM -0300, Daniel Henrique Barboza wrote:
> KVM does not have the means to support enabling the rva22u64 profile.
> The main reasons are:
> 
> - we're missing support for some mandatory rva22u64 extensions in the
>   KVM module;
> 
> - we can't make promises about enabling a profile since it all depends
>   on host support in the end.
> 
> We'll revisit this decision in the future if needed. For now mark the
> 'rva22u64' profile as unavailable when running a KVM CPU:
> 
> $ qemu-system-riscv64 -machine virt,accel=kvm -cpu rv64,rva22u64=true
> qemu-system-riscv64: can't apply global rv64-riscv-cpu.rva22u64=true:
>     'rva22u64' is not available with KVM
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 6d1c0a7915..2243dfde64 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -393,7 +393,7 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
>      }
>  
>      if (value) {
> -        error_setg(errp, "extension %s is not available with KVM",
> +        error_setg(errp, "'%s' is not available with KVM",
>                     propname);
>      }
>  }
> @@ -474,6 +474,11 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
>      riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_extensions);
>      riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_vendor_exts);
>      riscv_cpu_add_kvm_unavail_prop_array(cpu_obj, riscv_cpu_experimental_exts);
> +
> +   /* We don't have the needed KVM support for profiles */
> +    for (i = 0; riscv_profiles[i] != NULL; i++) {
> +        riscv_cpu_add_kvm_unavail_prop(cpu_obj, riscv_profiles[i]->name);
> +    }
>  }
>  
>  static int kvm_riscv_get_regs_core(CPUState *cs)
> -- 
> 2.41.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


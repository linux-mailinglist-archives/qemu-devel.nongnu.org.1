Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CED7F7A38
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:17:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Zmw-00079D-LI; Fri, 24 Nov 2023 12:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1r6Zmi-0006v8-Oc
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:16:09 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1r6Zmg-0007qW-Sz
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:16:08 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a06e59384b6so255413166b.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 09:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700846165; x=1701450965; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GKEZ6B1bmwogyZtQp8o4PjJ5TXVHB/9HxJAZuwQAeRc=;
 b=kK9K8s0e1uM3q9WRbkYq9K5AYPPtlOAucuq4tMwD8b2bB6U4mFNhQB5EaOFANV/UXm
 /x3NcVhzzyjdL06hnhpFvPDof6SiKTNfYRy2H/kSF/4UbcpM+ll1ud8AYgA+mi8mxgl8
 iUqBgpLfYJZAzw4er619Xsk6RAFTmA/Lp47F7p/qhww5DIf53LPZcERRggeOhKS7JyMc
 OPwFRLd3cdkHTQ5iqYte5MlaJ55Guk5GOICo915Ra2VqPabPo6B0oLPK5ez9Vxp/62Pf
 eEf1wZLw/SoKb0ozBxJUInn3egmN2yplTxe4bpMzvd33ERqtwUaZzID4ZbBeIH1MyfuP
 rvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700846165; x=1701450965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKEZ6B1bmwogyZtQp8o4PjJ5TXVHB/9HxJAZuwQAeRc=;
 b=sbgRtDpQIokYJX4jmNpfN/IiYMg9rKygZsIh8fuRB8jaumrWQSPbiYsdlKa9A9OEAD
 hKuWg4n+sCdAhEXAJ81D/vGiopGKMhDG7l0qnLMmbv86OK/amZGDHEWDCECMZAQpS5Gw
 6aTpYgUKopO4Ag1KCND8Dd2H0QDpja1s9hvvDBBbKti5xfI5CYH1BQ7KPhY4K1mjtw3Z
 pSrTfFPnuvlvKja9kFcMmLn1ckhuxxn0YjOTw6w6QJe8+RhQGmMUUuelIY7T+KXfd5P1
 yS7zDC+fVlhDB40glgiJIdqQ2UKNqFpHyWkNE7hvI+d0wvMNgW6aHktmM35cd+Sgf3YG
 lA5g==
X-Gm-Message-State: AOJu0Yw7yMObq4kqPdJlldH+ZtQTxEC0ad3HQJV3g/Fi9ABin+w26rgv
 xspfCuj9Hnm/3I0Y0nCkNcCXkw==
X-Google-Smtp-Source: AGHT+IFqqdDc6X2TXYbWnv7a0lwoF335rspSiprsJxA2zJExBCqiFHRF2sndgJky9zDtyEc88kmW8g==
X-Received: by 2002:a17:906:4a0d:b0:9e0:dde:cc9f with SMTP id
 w13-20020a1709064a0d00b009e00ddecc9fmr3197334eju.22.1700846165041; 
 Fri, 24 Nov 2023 09:16:05 -0800 (PST)
Received: from localhost ([81.19.4.232]) by smtp.gmail.com with ESMTPSA id
 i17-20020a170906265100b009ff10bfcefbsm2294515ejc.106.2023.11.24.09.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 09:16:04 -0800 (PST)
Date: Fri, 24 Nov 2023 18:16:03 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH for-9.0 6/7] target/riscv: add RVA22S64 profile
Message-ID: <20231124-bd1c3479fa6c2bd9fdba7cc9@orel>
References: <20231123191532.1101644-1-dbarboza@ventanamicro.com>
 <20231123191532.1101644-7-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123191532.1101644-7-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62e.google.com
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

On Thu, Nov 23, 2023 at 04:15:31PM -0300, Daniel Henrique Barboza wrote:
> The RVA22S64 profile consists of the following:
> 
> - all mandatory extensions of RVA22U64;
> - priv spec v1.12.0;
> - satp mode sv39;
> - Ssccptr, a cache related named feature that we're assuming always
>   enable since we don't implement a cache;
> - Other named features already implemented: Sstvecd, Sstvala,
>   Sscounterenw;
> - the new Svade named feature that was recently added.
> 
> Most of the work is already done, so this patch is enough to implement
> the profile.
> 
> After this patch, the 'rva22s64' user flag alone can be used with the
> rva64i CPU to boot Linux:
> 
> -cpu rv64i,rva22s64=true
> 
> This is the /proc/cpuinfo with this profile enabled:
> 
>  # cat /proc/cpuinfo
> processor	: 0
> hart		: 0
> isa		: rv64imafdc_zicbom_zicbop_zicboz_zicntr_zicsr_zifencei_zihintpause_zihpm_zfhmin_zca_zcd_zba_zbb_zbs_zkt_svinval_svpbmt
> mmu		: sv39
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a77118549b..d00548d164 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1559,8 +1559,48 @@ static RISCVCPUProfile RVA22U64 = {
>      }
>  };
>  
> +/*
> + * As with RVA22U64, RVA22S64 also defines 'named features'.
> + *
> + * Cache related features that we consider enabled since we don't
> + * implement cache: Ssccptr
> + *
> + * Other named features that we already implement: Sstvecd, Sstvala,
> + * Sscounterenw
> + *
> + * Named features that we need to enable: svade
> + *
> + * The remaining features/extensions comes from RVA22U64.
> + */
> +static RISCVCPUProfile RVA22S64 = {
> +    .name = "rva22s64",
> +    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU | RVS,
> +    .priv_spec = PRIV_VERSION_1_12_0,
> +    .satp_mode = VM_1_10_SV39,
> +    .ext_offsets = {
> +        /* rva22u64 exts and features */
> +        CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
> +        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
> +        CPU_CFG_OFFSET(ext_zbs), CPU_CFG_OFFSET(ext_zfhmin),
> +        CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
> +        CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
> +        CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
> +        CPU_CFG_OFFSET(zic64b),
> +
> +        /* rva22s64 exts */
> +        CPU_CFG_OFFSET(ext_zifencei), CPU_CFG_OFFSET(ext_svpbmt),
> +        CPU_CFG_OFFSET(ext_svinval),
> +
> +        /* rva22s64 named features */
> +        CPU_CFG_OFFSET(svade),
> +
> +        RISCV_PROFILE_EXT_LIST_END
> +    }
> +};
> +
>  RISCVCPUProfile *riscv_profiles[] = {
>      &RVA22U64,
> +    &RVA22S64,
>      NULL,
>  };
>  
> -- 
> 2.41.0
>

Since S-mode profiles will all presumably state they support everything a
U-mode profile supports too, then I wonder if we shouldn't be able to
point S-mode profiles at U-mode profiles somehow, rather than redundantly
add their extensions.

Anyway,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew


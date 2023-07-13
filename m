Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08876751D26
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 11:27:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJsas-00021w-27; Thu, 13 Jul 2023 05:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qJsaq-00021D-CP
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 05:26:36 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qJsao-0001aO-VF
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 05:26:36 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9939fbb7191so102262766b.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689240393; x=1691832393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=15U9uDXPb/OlRHK4Y6KhNZVmgYaDgAPnXX1XqWhvPsI=;
 b=oDKowRgrbThGORJOiQUmTLsnoWKLaggAwOdM/nJLAxNGfq4vLnSXSZv1XMi8MqLvRY
 bcYCyyUyEbN92KwJcHjNlAXSIdjDZdGHvg6V9aNdecCuebZIYpmVevh1fKMmKTupLCGc
 fJAgqjF0ebZTT8NETa+XGvuU6wfjBFXD9Hbf526tr69jWpcB2M00+lPdX1HnNj0JkTou
 lY/8ylX2ElnlMSupifkn6mNEQb93IlZ5yeATyXnw39q2ml3sSunoq5iIMB8n2YaqPOCy
 2WeFhT8jnbfvWUXcciFkLse8gbxYpEgwK8D/ddswST8uUBjZa9ArmeJ869WPDfAVYqhH
 3v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689240393; x=1691832393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15U9uDXPb/OlRHK4Y6KhNZVmgYaDgAPnXX1XqWhvPsI=;
 b=Vmk+Iq4cl668pRsI/P529VWNiRrPgNuW4SZCnQsAhmNc6/iPoFs9EK9F02m3wHuPR6
 HCCgHc0KtgOk5IxIMDxaWIRbWSrzr32RyNMYylK/HZ4/cN3m9t8XLoBO3+JGqVG6G2KX
 tge8JD901WLgfZMyfTIcC4wy8kHnDIz5+rs++EQxicgLVdmL1QTY0MMNsCB6irM3JaDB
 gfTYX2bt2r6uv/Z8BfpSIvA9Vsc4be/g0VRboA0QaLYiQge/wyZwZtBk/TQiXXbyO0Qe
 ZAyY65Si1f+D5mVor2Gr9TbH3/sVsIMwZeInMunqC/O1qPh6XWoFLOFtzKbx/IauMRXS
 1ryg==
X-Gm-Message-State: ABy/qLbxC+y09/CRgWDYmLylRYg6ncrYlcBiM1rR0K+dK/xCEwEtrkiU
 s1JsSWCk+mcsftyTWcoAzBNWWA==
X-Google-Smtp-Source: APBJJlHmTjnTAYkm3Z19cBosH9qp3zmPxyq9tVsa/Eyq79OXIqYKyMduKLtN3h0ITyRDHmVRkc0+yg==
X-Received: by 2002:a17:907:a410:b0:993:da5f:5a9b with SMTP id
 sg16-20020a170907a41000b00993da5f5a9bmr6076165ejc.8.1689240393511; 
 Thu, 13 Jul 2023 02:26:33 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 v1-20020a1709063bc100b00992b7ff3993sm3710877ejf.126.2023.07.13.02.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 02:26:33 -0700 (PDT)
Date: Thu, 13 Jul 2023 11:26:32 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, rkanwal@rivosinc.com, 
 anup@brainfault.org, dbarboza@ventanamicro.com, atishp@atishpatra.org, 
 vincent.chen@sifive.com, greentime.hu@sifive.com, frank.chang@sifive.com, 
 jim.shu@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v5 2/5] target/riscv: check the in-kernel irqchip support
Message-ID: <20230713-c8221857f478558194b4d5bd@orel>
References: <20230713084405.24545-1-yongxuan.wang@sifive.com>
 <20230713084405.24545-3-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713084405.24545-3-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62a.google.com
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

On Thu, Jul 13, 2023 at 08:43:54AM +0000, Yong-Xuan Wang wrote:
> We check the in-kernel irqchip support when using KVM acceleration.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> index 9d8a8982f9..005e054604 100644
> --- a/target/riscv/kvm.c
> +++ b/target/riscv/kvm.c
> @@ -914,7 +914,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>  
>  int kvm_arch_irqchip_create(KVMState *s)
>  {
> -    return 0;
> +    if (kvm_kernel_irqchip_split()) {
> +        error_report("-machine kernel_irqchip=split is not supported on RISC-V.");
> +        exit(1);
> +    }
> +
> +    /*
> +     * We can create the VAIA using the newer device control API.
> +     */
> +    return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
>  }
>  
>  int kvm_arch_process_async_events(CPUState *cs)
> -- 
> 2.17.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


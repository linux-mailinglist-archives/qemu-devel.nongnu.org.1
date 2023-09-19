Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA52F7A610E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 13:19:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiYkl-0004yJ-6Y; Tue, 19 Sep 2023 07:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qiYkZ-0004vr-5E
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:18:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qiYkX-0006Qo-C4
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:18:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-404314388ceso58791805e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 04:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695122313; x=1695727113; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qHMdr9Hl7ljAtr1rL/7pB/eJ0cwmgEbSRu5B7jd4s4A=;
 b=Q1fiXDGfZ7664R6Pu9qZIeocbcyFCtHxMZ0YOnqfv9vMFZF2A1kfNb9huPazGtNjU2
 2y6wU3+DJzt2/OcMYArifqMpUzEeUDAxQEgtCvwZc2sLZRq7vc5k3BKNmOhmsgAZbs9M
 h29gNOoVfzIDUh6D0cXRVCb48kNjwKILSh0Ja0cHLbRZ1vY6rwYaaAfdZUfQ96jAA1su
 OipJai1AzqHmsFnKQtygfCw71co1dMB+c/zb916QtMeKYL+sWV7p4HjFG1iYp6vWRGY8
 KJ67esvOdT+Q57zvrN76iZbkxzu6kCi2L9FPSvIWCdEubI6BGH/JqrKY5oyQbnEeGcNk
 FanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695122313; x=1695727113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHMdr9Hl7ljAtr1rL/7pB/eJ0cwmgEbSRu5B7jd4s4A=;
 b=ax2sdkIQGQS+DUMJAXjvO91jUcvhAEPaEVKIyKdyGZFkKcNPjC/TI8jEZKsQZBptiL
 alHDxhfSKwJwd0QjrQ2zzQLnux/VMJiom/eLySTuoBddBueRJ4QcLRT9Z/L5WlWyHlgJ
 lj99UiDzI9jqV9SBsm/TviNONlTkJlwKhC+dQggmDF8GIjNKy8YgI/Exvm0hVCb1TAeT
 27bLPlqK4FIBVW+R0AaqHPB8caFXK+3oqbdS8QWCnMlrFxVsGIfF1ZjxhqqgvJ6MS0ay
 nZARzigMROaC/jZdBVpPGxIDXLZSlxbKJaQQgG6PZHyksf+iHgQBF7WoQjD6zYo1Kw6/
 ix+Q==
X-Gm-Message-State: AOJu0YziCkm4Xzh/ABY/oV8sVqlkttSa+ZheD6klcD+0IRydP6ZaPJKr
 gmZI0IUuc45mXbnIrNz2p3KLQQ==
X-Google-Smtp-Source: AGHT+IH37qSyvzaak/lGNfer9FWAEWTAyMs9BKviXpoRMsI9Q4Ol9imvB1/d0KGaU0uZnA+2cCQAjg==
X-Received: by 2002:adf:f110:0:b0:319:7c7d:8d1 with SMTP id
 r16-20020adff110000000b003197c7d08d1mr9809809wro.44.1695122312956; 
 Tue, 19 Sep 2023 04:18:32 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 h16-20020a5d5490000000b0031773a8e5c4sm15062182wrv.37.2023.09.19.04.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 04:18:32 -0700 (PDT)
Date: Tue, 19 Sep 2023 13:18:31 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Andreas Schwab <schwab@suse.de>
Cc: qemu-devel@nongnu.org, Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Bin Meng <bmeng@tinylab.org>, Frank Chang <frank.chang@sifive.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH] riscv: Call set_satp_mode_max_supported in
 riscv_host_cpu_init
Message-ID: <20230919-853624bc6079021587741eb4@orel>
References: <mvm34zavbmb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvm34zavbmb.fsf@suse.de>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 19, 2023 at 09:57:32AM +0200, Andreas Schwab wrote:
> When running in KVM mode with -cpu host, cfg.satp_mode.supported is not
> initialized, causing an infinite loop in riscv_cpu_satp_mode_finalize.
> 
> Fixes: 6df3747a27 ("riscv: Introduce satp mode hw capabilities")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  target/riscv/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f227c7664e..bb8dc3bb40 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -623,8 +623,10 @@ static void riscv_host_cpu_init(Object *obj)
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
>  #if defined(TARGET_RISCV32)
>      set_misa(env, MXL_RV32, 0);
> +    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
>  #elif defined(TARGET_RISCV64)
>      set_misa(env, MXL_RV64, 0);
> +    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
>  #endif
>      riscv_cpu_add_user_properties(obj);
>  }
> -- 
> 2.42.0
>

This should be fixed by

https://lore.kernel.org/all/20230911064320.939791-37-alistair.francis@wdc.com/

Thanks,
drew


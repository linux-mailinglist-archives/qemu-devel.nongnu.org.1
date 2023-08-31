Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4550078EE30
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhI1-0007Yb-2L; Thu, 31 Aug 2023 09:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbhFB-0002xh-Ok
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:54 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbhF2-0005Lx-KK
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:50 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so4164541a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693486663; x=1694091463; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uNXW750vA6R1Aa75og4R46d2dzEIu2KoYPCzpFV0L+Y=;
 b=kzfkFSMLVfFqZbq3SN1yRM7HRO7ip0BgMSNfQID2g1yrH/GizAeXDp/NR6+4fu0diM
 txnkD3Zh42ACO329rXxxrKWDVqIbDRUkNRVK0/AmFNwhH3vbFgkLj0B4TlJwmS2ONI1z
 NB5kpiTmoD8nOcLCqbSFKbgJeEXOQxA4KsPuLfKl1tWtn2wL2Qyu0beU2lL9M+Amb574
 T9ToagGhCcncP+W66YwQCRSUGXvOkkjRxScmsOtPLoNC4eqK1XxxdrdfmTqqS7e/bFAl
 pT9FCZ4Bv45VIkYDiBLPUBjh6ZKMv3GaZdfBBoMBTwoITaiUOyBPOL6k0tOVZUkgMpp0
 SwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486663; x=1694091463;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNXW750vA6R1Aa75og4R46d2dzEIu2KoYPCzpFV0L+Y=;
 b=MvXWHhbsME6LjkWg1/H+rZqN5ite0jxUtVMzyykmbfQv4i8AzzbabLwYOJyREY/gCW
 bq1F1aGbBfJp0TnfRvRZHEj3FfmgGy4qmJDt2YuEWvSsFtkBfdo9HQRy468RacuUDyaU
 9gkp9j8L4l2P+vRal2AbTNQ2zgif1/efRqH7wuu0KFpoj4vEcOsNOu44Fafl37owbGWe
 OyWf7Moc621P+hPYHvqizcWh9opQAGIFbcK4JKedJtusU98h8dKCOT9C7xW49RLO64wG
 SCCHehZLP1BRaG8p1xg9ebC1C4IORXCQnGrkpZCp+Mh8Kj9TD+tsl+sLMVqHZ3KVCNM2
 5DpA==
X-Gm-Message-State: AOJu0Yytd9kNoy51Jb+0IqxdfWUMoznl4+4UQc1fOPWsUwuESoCRhK8o
 SOIGtzUD5q63WSkBUX6nlydmww==
X-Google-Smtp-Source: AGHT+IGMozpbrRYSSEXixFAUWMy4mZ9BM1W5YL/rB95NaCC7EVE9VFJsD51rjmSNZuI/oCjRGI+HSw==
X-Received: by 2002:a05:6402:2712:b0:523:463d:1ed3 with SMTP id
 y18-20020a056402271200b00523463d1ed3mr2836997edd.15.1693486663175; 
 Thu, 31 Aug 2023 05:57:43 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 x26-20020aa7d39a000000b005257f2c057fsm770034edq.33.2023.08.31.05.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 05:57:42 -0700 (PDT)
Date: Thu, 31 Aug 2023 14:57:41 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH RESEND v8 06/20] target/riscv/cpu.c: split vendor exts
 from riscv_cpu_extensions[]
Message-ID: <20230831-77dbf9fff032d3b5cc1ac73b@orel>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
 <20230824221440.484675-7-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824221440.484675-7-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x529.google.com
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

On Thu, Aug 24, 2023 at 07:14:26PM -0300, Daniel Henrique Barboza wrote:
> Our goal is to make riscv_cpu_extensions[] hold only ratified,
> non-vendor extensions.
> 
> Create a new riscv_cpu_vendor_exts[] array for them, changing
> riscv_cpu_add_user_properties() and riscv_cpu_add_kvm_properties()
> accordingly.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 78eb2ac6bd..668522db01 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1860,7 +1860,10 @@ static Property riscv_cpu_extensions[] = {
>      DEFINE_PROP_BOOL("zcmp", RISCVCPU, cfg.ext_zcmp, false),
>      DEFINE_PROP_BOOL("zcmt", RISCVCPU, cfg.ext_zcmt, false),
>  
> -    /* Vendor-specific custom extensions */
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static Property riscv_cpu_vendor_exts[] = {
>      DEFINE_PROP_BOOL("xtheadba", RISCVCPU, cfg.ext_xtheadba, false),
>      DEFINE_PROP_BOOL("xtheadbb", RISCVCPU, cfg.ext_xtheadbb, false),
>      DEFINE_PROP_BOOL("xtheadbs", RISCVCPU, cfg.ext_xtheadbs, false),
> @@ -1973,6 +1976,10 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
>          riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
>      }
>  
> +    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
> +        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
> +    }
> +
>      for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
>          riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
>      }
> @@ -2017,6 +2024,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
>          qdev_property_add_static(dev, prop);
>      }
>  
> +    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
> +        qdev_property_add_static(dev, prop);
> +    }
> +
>      for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
>          qdev_property_add_static(dev, prop);
>      }
> -- 
> 2.41.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


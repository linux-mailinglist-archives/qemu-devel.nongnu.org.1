Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A95F78EDEF
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhEO-0002FK-6E; Thu, 31 Aug 2023 08:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbhEL-0002Dp-9G
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:01 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbhEH-00054X-2T
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:01 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso90176766b.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693486615; x=1694091415; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C4l2uMumWMiMt/kZEsLPjsauoaZLoTuUhXl7YwuCku8=;
 b=annnjPAcwSWI1AohWhYb5du1unH4JvOk0HD249MybjDiHMx07muhDNJte4BBXn5lq2
 jm32RJsw57e7Kv24XlfOiKPR5kxh7EmTkRpHLLmkY4XGFBDsJVn8LYokL0X52YMvfhHY
 gn90gtlkZPxhP3mzW+psrV0GO7iUlI4jbWp4562FMsfHHiD6RicSpW2PqgnZm8HIaGmH
 NvGH+/bMyJVk4uiEAvE0DQpTuFLhP2Kg7Vw6qBjtgPZ5ZL5ZVnMxlgwug7y4cg1uW9ew
 MGfOInG3cncRbvq2fscSqZ3jmckH6Jtiw4l6Be8sBBZnHg4JsE7DtUexkGD9zRErD4Fp
 u+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486615; x=1694091415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4l2uMumWMiMt/kZEsLPjsauoaZLoTuUhXl7YwuCku8=;
 b=NtD6gE8dqpaNMBjC6mrKYaQPTMhdxggj1cI1oFZbLpS2W/WqGYFnDxwl0c6a0QxM/K
 V/WdgD2YYnbF/3fyX418je85si9/VMcH8OecCeVAd/GICKsPUJpmMjUfAsRsLI6gOHxc
 mYOoOiq7QvHF7oauKM6hnpWethwybWL9YrBlwElzSEqd8hNLuZCn2f2DYlq+kVonuvEK
 vJzOGzRD/dYQ7Om2eFDT3wjJcrIJYBuqtUhucnPo+klGQoTMj+hdss1dPzuh520lcljg
 LVCAb/ikP3eu6B5pakXxx9OtjLwlEcpb/SNBItCwMj+gZlAbAqJtYMdBSSAzD2gVMlTE
 j6kQ==
X-Gm-Message-State: AOJu0Yzu0zODR8yqD0dhROc/1O9l95y0wprhJbcASnIAzqVG05i4MPxy
 FXQXh+V+sOw/HqtQXKehxgLJhg==
X-Google-Smtp-Source: AGHT+IGASl6kuA2BVfANBAG0B2dksMm2RNUJ3l5bd3IUkkOJv2RBpimUn2s+C+4sSyT+Av5Jmeuujw==
X-Received: by 2002:a17:906:739c:b0:9a5:8269:2c94 with SMTP id
 f28-20020a170906739c00b009a582692c94mr3381288ejl.57.1693486615538; 
 Thu, 31 Aug 2023 05:56:55 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 l23-20020a1709060e1700b0097073f1ed84sm737517eji.4.2023.08.31.05.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 05:56:55 -0700 (PDT)
Date: Thu, 31 Aug 2023 14:56:54 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH RESEND v8 05/20] target/riscv/cpu.c: split non-ratified
 exts from riscv_cpu_extensions[]
Message-ID: <20230831-f7aff5aadae6aa730ee39299@orel>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
 <20230824221440.484675-6-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824221440.484675-6-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x633.google.com
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

On Thu, Aug 24, 2023 at 07:14:25PM -0300, Daniel Henrique Barboza wrote:
> Create a new riscv_cpu_experimental_exts[] to store the non-ratified
> extensions properties. Once they are ratified we'll move them back to
> riscv_cpu_extensions[].
> 
> riscv_cpu_add_user_properties() and riscv_cpu_add_kvm_properties() are
> changed to keep adding non-ratified properties to users.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 272edaadf0..78eb2ac6bd 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1874,7 +1874,11 @@ static Property riscv_cpu_extensions[] = {
>      DEFINE_PROP_BOOL("xtheadsync", RISCVCPU, cfg.ext_xtheadsync, false),
>      DEFINE_PROP_BOOL("xventanacondops", RISCVCPU, cfg.ext_XVentanaCondOps, false),
>  
> -    /* These are experimental so mark with 'x-' */
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +/* These are experimental so mark with 'x-' */
> +static Property riscv_cpu_experimental_exts[] = {
>      DEFINE_PROP_BOOL("x-zicond", RISCVCPU, cfg.ext_zicond, false),
>  
>      /* ePMP 0.9.3 */
> @@ -1969,6 +1973,10 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
>          riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
>      }
>  
> +    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
> +        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
> +    }
> +
>      for (prop = riscv_cpu_options; prop && prop->name; prop++) {
>          /* Check if KVM created the property already */
>          if (object_property_find(obj, prop->name)) {
> @@ -2008,6 +2016,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
>      for (prop = riscv_cpu_options; prop && prop->name; prop++) {
>          qdev_property_add_static(dev, prop);
>      }
> +
> +    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
> +        qdev_property_add_static(dev, prop);
> +    }
>  }
>  
>  static Property riscv_cpu_properties[] = {
> -- 
> 2.41.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


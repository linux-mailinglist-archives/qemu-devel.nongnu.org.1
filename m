Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E29FB79149E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:19:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5jd-00017k-3f; Mon, 04 Sep 2023 05:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qd5jY-00017J-Pg
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:19:00 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qd5jI-0006Uy-RU
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:19:00 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c5a2e8501so936727f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693819123; x=1694423923; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nm5KqoAd+HSN4XenoZPzE6h42aQKOGVLcNJvjlXSQ1A=;
 b=mXK+CrqETUL60lQ6q76sIeVPdNd5r2c9rvm2IUx4ZgURHlM9iW2CEMsAP7dv11awcr
 qvimaaRbIb/zZeRZd3n7P/8EjMuaizEVxFJ544up+hXIjwLzBuTiQAFNuXtr5DbQMgsU
 ykccwSgo28CL6wVfMeCSeLgygO3JssJNdEPSGO2aElaBvh7wALiIWi/IvlYbZyrOTOhL
 L/gGpOzShx5HDjejBVZ+8Wq4XtiBZHFI9Ng7DC0ppN1nZwpKn9S7q+eZEy5+QUr0MN0Y
 P3jHUTP4XJ0WxjMrNH1gcrtfbgtNqbPZYxJxcZ4/rP2f5Pkh0x14HrzrL7dtmTAAuSly
 MZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693819123; x=1694423923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nm5KqoAd+HSN4XenoZPzE6h42aQKOGVLcNJvjlXSQ1A=;
 b=koZ1aUC+2secFDxDkQaHMIx5TVfA0kMDcaOdJlhz8rWX3ojkuWZpi4SeP+kKo3tlCZ
 ScpC0+WUkiawZWmG0Bowb5Ds395bh9nCQkJqTbuTOc3al6tEGUtQzLI78PN3DIFJ0TNJ
 fzrn9cJ81GTwAYIjcJYhcDW/HUDA4ZcwW04mAC6VqMisNPuCXj+nwTvdZHiZFM7fftdO
 IWehKzZgM3HbRu0vTURMY7FTZP81viXfO70z+Iaw3vmeuq3ncV/unUXRDGoHoEY5Vd7K
 u8NEdA2CaSZ9fCFTP9sG1mfU9k/NGnexmEtGzPyG2alvlV4qvi0yu3emFmQkYbZH257y
 S+RA==
X-Gm-Message-State: AOJu0YyE9tDuKluAVCB46QVLMJBfWTGDo1aEEuCyKw5q+g2venM60oH1
 jfuoWALakQksXvoDpiZHN1CglA==
X-Google-Smtp-Source: AGHT+IFBUGAesEM4nr1ejCFfXkjo/2xQm4yQAMPYXedZD5DHOwOhH3CVOW70tNrAIl6pDIgfYHoQBQ==
X-Received: by 2002:a5d:69c5:0:b0:317:e1a2:dccf with SMTP id
 s5-20020a5d69c5000000b00317e1a2dccfmr7847101wrw.62.1693819123210; 
 Mon, 04 Sep 2023 02:18:43 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 w2-20020adff9c2000000b00317ddccb0d1sm13908274wrr.24.2023.09.04.02.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 02:18:42 -0700 (PDT)
Date: Mon, 4 Sep 2023 11:18:41 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v9 20/20] target/riscv/cpu.c: consider user option with RVG
Message-ID: <20230904-3492f3db40617b7780ed7861@orel>
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
 <20230901194627.1214811-21-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901194627.1214811-21-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, Sep 01, 2023 at 04:46:26PM -0300, Daniel Henrique Barboza wrote:
> Enabling RVG will enable a set of extensions that we're not checking if
> the user was okay enabling or not. And in this case we want to error
> out, instead of ignoring, otherwise we will be inconsistent enabling RVG
> without all its extensions.
> 
> After this patch, disabling ifencei or icsr while enabling RVG will
> result in error:
> 
> $ ./build/qemu-system-riscv64 -M virt -cpu rv64,g=true,Zifencei=false --nographic
> qemu-system-riscv64: RVG requires Zifencei but user set Zifencei to false
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 78382cb5f2..be1c028095 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1153,9 +1153,23 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>            riscv_has_ext(env, RVA) && riscv_has_ext(env, RVF) &&
>            riscv_has_ext(env, RVD) &&
>            cpu->cfg.ext_icsr && cpu->cfg.ext_ifencei)) {
> +
> +        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_icsr)) &&
> +            !cpu->cfg.ext_icsr) {
> +            error_setg(errp, "RVG requires Zicsr but user set Zicsr to false");
> +            return;
> +        }
> +
> +        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_ifencei)) &&
> +            !cpu->cfg.ext_ifencei) {
> +            error_setg(errp, "RVG requires Zifencei but user set "
> +                       "Zifencei to false");
> +            return;
> +        }
> +
>          warn_report("Setting G will also set IMAFD_Zicsr_Zifencei");
> -        cpu->cfg.ext_icsr = true;
> -        cpu->cfg.ext_ifencei = true;
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_icsr), true);
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_ifencei), true);
>  
>          env->misa_ext |= RVI | RVM | RVA | RVF | RVD;
>          env->misa_ext_mask |= RVI | RVM | RVA | RVF | RVD;
> -- 
> 2.41.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


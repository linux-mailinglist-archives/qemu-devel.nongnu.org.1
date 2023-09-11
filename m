Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8125679A52E
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:57:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbmZ-0006LH-3k; Mon, 11 Sep 2023 03:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qfbmW-0006L4-2J
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:56:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qfbmT-0000vO-QX
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:56:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-401da71b7c5so46810495e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 00:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694418984; x=1695023784; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lneNkDzAYx6Q5HS8mTmeVNCQRhhaKvgMQEdq2Q7Cm9Q=;
 b=Gk4zyXzOn/XPTaPS1DjhZr3AJjF8KScEMBMuJWpNb55oyGxed9YVdoOo7uF1/O1eOB
 uWxPpvhMGqOjDHPe/n6py+Q7Ao92YSJkbDYUtIynt9EdCrBehl2QoAbQyvWus44ROgmt
 f1/3v6jGwExxbxvkx2cy/uvUttaSssKDqH0wxlkzHJWtav3mXmBgeRCEziYcAcMe+9dG
 kM0UxAYiAzioDSv1cYeTUNJ9XKZBOzvTzqd7zRYBRvkWeFc9MCZMyUiiajYbkv04OtUp
 VOZHXSHJaE8xjx8+BVeagiwE3d8QpA9FpzgpiTjmj8dMLb7ihuZ3k+rp+oryEVml57Jv
 UKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694418984; x=1695023784;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lneNkDzAYx6Q5HS8mTmeVNCQRhhaKvgMQEdq2Q7Cm9Q=;
 b=vWY0daP+LQ1ItlZEIYSlPRCtV/EioI7goVgUvWOU/dNECvZdJUjL1tMrxUP0nNj0fp
 LpJPQTQAlXfw7uaxxuFNH7uiW9umB5lath1lIvjIZ0vDNzRNIAFx0mOTkUzU6x+2a2a1
 EtWzyN9YuwLbHzCIpVqbpHDG5dCTbXyofDkXw5Uhk+nrV1lMH8C0EsoqAEp95B1a0MKR
 M1x0odC7ZrPugg0hukDMCHHt9nJxEWqV4meyIG8U/qcIAIsE/10gVluPzxPFWaIxYI8L
 xIjQOt3J5L67F0RzO/E/N873GAF373KN0Oxrhic+zd7my/nvNenDZkM2VhEaR01QFWk7
 BhHA==
X-Gm-Message-State: AOJu0Yyq2SuPxfoRsdy19C+gfgDoSOM9rf68hW1A38qnGYy8l1S706ua
 hFkuK4XQ6duiIGdYxHhE7IxMvQ==
X-Google-Smtp-Source: AGHT+IFMAyURJ7eMZ40AHz/QqX+y9/ylX0U3Y505r+CCGR3TG/p17k6i67MNgGY69UpdrxhTryRw3Q==
X-Received: by 2002:adf:e743:0:b0:31a:e6c2:770d with SMTP id
 c3-20020adfe743000000b0031ae6c2770dmr6981455wrn.36.1694418984387; 
 Mon, 11 Sep 2023 00:56:24 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 n6-20020adfe786000000b003197efd1e7bsm9217160wrm.114.2023.09.11.00.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 00:56:24 -0700 (PDT)
Date: Mon, 11 Sep 2023 09:56:23 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, philmd@linaro.org
Subject: Re: [PATCH v2 16/19] target/riscv/cpu.c: make misa_ext_cfgs[] 'const'
Message-ID: <20230911-b3b72181e2aa0ef1585884a2@orel>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
 <20230906091647.1667171-17-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906091647.1667171-17-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x333.google.com
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

On Wed, Sep 06, 2023 at 06:16:43AM -0300, Daniel Henrique Barboza wrote:
> The array isn't marked as 'const' because we're initializing their
> elements in riscv_cpu_add_misa_properties(), 'name' and 'description'
> fields.
> 
> In a closer look we can see that we're not using these 2 fields after
> creating the MISA properties. And we can create the properties by using
> riscv_get_misa_ext_name() and riscv_get_misa_ext_description()
> directly.
> 
> Remove the 'name' and 'description' fields from RISCVCPUMisaExtConfig
> and make misa_ext_cfgs[] a const array.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8616c9e2f5..4875feded7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1212,8 +1212,6 @@ static void riscv_cpu_init(Object *obj)
>  }
>  
>  typedef struct RISCVCPUMisaExtConfig {
> -    const char *name;
> -    const char *description;
>      target_ulong misa_bit;
>      bool enabled;
>  } RISCVCPUMisaExtConfig;
> @@ -1317,7 +1315,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
>  #define MISA_CFG(_bit, _enabled) \
>      {.misa_bit = _bit, .enabled = _enabled}
>  
> -static RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
> +static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
>      MISA_CFG(RVA, true),
>      MISA_CFG(RVC, true),
>      MISA_CFG(RVD, true),
> @@ -1344,25 +1342,22 @@ void riscv_cpu_add_misa_properties(Object *cpu_obj)
>      int i;
>  
>      for (i = 0; i < ARRAY_SIZE(misa_ext_cfgs); i++) {
> -        RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
> +        const RISCVCPUMisaExtConfig *misa_cfg = &misa_ext_cfgs[i];
>          int bit = misa_cfg->misa_bit;
> -
> -        misa_cfg->name = riscv_get_misa_ext_name(bit);
> -        misa_cfg->description = riscv_get_misa_ext_description(bit);
> +        const char *name = riscv_get_misa_ext_name(bit);
> +        const char *desc = riscv_get_misa_ext_description(bit);
>  
>          /* Check if KVM already created the property */
> -        if (object_property_find(cpu_obj, misa_cfg->name)) {
> +        if (object_property_find(cpu_obj, name)) {
>              continue;
>          }
>  
> -        object_property_add(cpu_obj, misa_cfg->name, "bool",
> +        object_property_add(cpu_obj, name, "bool",
>                              cpu_get_misa_ext_cfg,
>                              cpu_set_misa_ext_cfg,
>                              NULL, (void *)misa_cfg);
> -        object_property_set_description(cpu_obj, misa_cfg->name,
> -                                        misa_cfg->description);
> -        object_property_set_bool(cpu_obj, misa_cfg->name,
> -                                 misa_cfg->enabled, NULL);
> +        object_property_set_description(cpu_obj, name, desc);
> +        object_property_set_bool(cpu_obj, name, misa_cfg->enabled, NULL);
>      }
>  }
>  
> -- 
> 2.41.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


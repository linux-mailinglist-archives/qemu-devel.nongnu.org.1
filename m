Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF547DFFE2
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 10:01:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyq3F-0002LI-4U; Fri, 03 Nov 2023 05:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qyq3B-0002KA-St
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:01:09 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qyq3A-00052U-0L
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:01:09 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso14226435e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699002066; x=1699606866; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pcC47FSKbo5Fm1RgD6cevhhdU0V0PFmltnzdC/P9+54=;
 b=UCnQjOZVHxiEAoiZDK9qhn/4KyNk+dnblyazR1IXTYP7EANOJ/e+NkBfBPTGAxgzu3
 fPCB8R+a3qiDKTeAAxrFOmxEggMs85jQ8os9ouYCW84SjDkQwyyABc1GlZ7p9hqXMyKq
 Zz3+4OLjfexG2xP14vqWvHmhr/8mQIsOlz78TAzECoTUW+VS9XGVjqVQ21mTJQWJQ6rL
 PESIDf+JkpY42Hkgl+vEw4XSSSbnnuj0fgLDwqLAdkK12qF3Y6/GljvEvtTvb9qAgDWz
 rkVfuTcxmfbgRGw7pUaJHpZOyGq3Slf987Ijn7m9sEjQSxY88+0TOS/Jb/MdULeGh5Gm
 gyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699002066; x=1699606866;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcC47FSKbo5Fm1RgD6cevhhdU0V0PFmltnzdC/P9+54=;
 b=bYoVFfCvwVLFC3HDy8y3bk6EM+ROQi5UYb6clh9NTK20ajv00cYIm3crplLTJaT0Z7
 WfRzVX/ZPH0co0tFpBoiTFE5Js+Egk9hgZSVk1tcXKxszI67lpGAcEAcTNJOYes/YTZc
 4PjGphU+O1HQf7o0LaM8+vKamjgyglJRUb0suP9FqQjc54obEGziQ4z7A5QHV3Z84Qzs
 f10UBNThpCa3QHycIDdlKw1Blyo3CQuYv6y27OrN5XdrFgjjXdVYqDWMCPjoU87fh2DM
 Gv8hAbP90K95MHQcxuQVDFFWL3d2aoULjvYWsj+SXfhCoBQXLf3yxMrmrinUd9esxNm1
 Vzwg==
X-Gm-Message-State: AOJu0YxihrEbie4ebkGQH6rwe2nDg0KorPKF6fwGfmNN/2VmNViVIy4q
 W7ywCmrrh9oZfU5QLoX9ne1oEQ==
X-Google-Smtp-Source: AGHT+IEde1P1qOxij7mpgdgAW1P6VXmF7MUNqVjD5JvaPFaNcGTMmx9gOE2+2SkYhSMs01rqDaicNg==
X-Received: by 2002:a5d:5002:0:b0:32d:88dc:b219 with SMTP id
 e2-20020a5d5002000000b0032d88dcb219mr15733516wrt.45.1699002066182; 
 Fri, 03 Nov 2023 02:01:06 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a5d6550000000b0032dbf6bf7a2sm1313810wrv.97.2023.11.03.02.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 02:01:05 -0700 (PDT)
Date: Fri, 3 Nov 2023 10:01:04 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v9 19/19] target/riscv/tcg: do not support profiles for
 'max' CPU
Message-ID: <20231103-00c3877949914a4e56f4be79@orel>
References: <20231102224445.527355-1-dbarboza@ventanamicro.com>
 <20231102224445.527355-20-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102224445.527355-20-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Nov 02, 2023 at 07:44:45PM -0300, Daniel Henrique Barboza wrote:
> There's no gain in allowing the 'max' CPU to support profiles, since it
> already contains everything that QEMU can support. And we'll open the
> door for 'unorthodox' stuff like users disabling profiles of the 'max'
> CPU.

I don't see a lot of value in this patch, but maybe I'm just too cruel to
users that don't know what they're doing. I even see a negative value to
this patch because I can conceive of writing a script where I generally
want to use rv64i with my explicit list of profiles/extensions, but then
I may want to temporarily "boost" my CPU to 'max' for some reason. If
I write my script like

 CPU=rv64i
 EXTENSIONS=profile=on,extension=on
 qemu -cpu $CPU,$EXTENSIONS ...

then I can't just do

 CPU=max ./my-script

to boost my CPU, since max will error out when it sees profiles being
enabled (even though that should be no-op for it). Instead, I need to
do

 CPU=max EXTENSIONS= ./my-script

which isn't horrible, but a bit annoying.

So, personally, I would drop this patch.

Thanks,
drew

> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 553fb337e7..9a964a426e 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -825,6 +825,11 @@ static bool riscv_cpu_is_vendor(Object *cpu_obj)
>      return object_dynamic_cast(cpu_obj, TYPE_RISCV_VENDOR_CPU) != NULL;
>  }
>  
> +static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
> +{
> +    return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
> +}
> +
>  /*
>   * We'll get here via the following path:
>   *
> @@ -1003,6 +1008,12 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> +    if (riscv_cpu_has_max_extensions(obj)) {
> +        error_setg(errp, "Profile %s is not available for the 'max' CPU",
> +                   profile->name);
> +        return;
> +    }
> +
>      if (cpu->env.misa_mxl != MXL_RV64) {
>          error_setg(errp, "Profile %s only available for 64 bit CPUs",
>                     profile->name);
> @@ -1251,11 +1262,6 @@ static void riscv_init_max_cpu_extensions(Object *obj)
>      }
>  }
>  
> -static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
> -{
> -    return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
> -}
> -
>  static void tcg_cpu_instance_init(CPUState *cs)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
> -- 
> 2.41.0
> 


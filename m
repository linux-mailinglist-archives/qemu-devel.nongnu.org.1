Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7556B78EDB8
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 14:55:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhBe-0006wy-RY; Thu, 31 Aug 2023 08:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbhBZ-0006qV-Vz
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:54:10 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbhBX-0003zR-Iq
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:54:09 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-986d8332f50so92626266b.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693486446; x=1694091246; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FHA2omMtVmZZitjWuDVlKBdJFp5gC45hOylRExb3d8s=;
 b=Taeu14vUSmj+YhKFYRNDgd5xuSv+P7DQWj/ZYQAJhIZDwGPRVksn90WBNJBNanO0AT
 tRObUi9E35XSuc73Dv4JyDP79D2xGaOM2PPkTUmuwb6+Zg8uvFXwQvNsrbj2kTtN3smC
 XxdLuJY6J1uSKIRVhe8GzrlhdBspvt+CjL+81XeYRew59LbddqpNJG9obTHKUzN7SEZY
 nJvm7L5G5Yn1hPdKpOxukB34UVnycV5YIdJvBeUk/DYCe9fUxKvvl2d9ZV8mCuGwwIYx
 E5dCiJKe4irbBD+ZxgffBBHV5k+1kk8LGiAlQ03jGrx63bb8pJrtGnFCq9mvtzKGQ0ae
 EYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486446; x=1694091246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHA2omMtVmZZitjWuDVlKBdJFp5gC45hOylRExb3d8s=;
 b=FA+5CcrmdTVhsbP7v3575oybUU6dKCY8K/n6vpv1J1/fSYRpRcpQaOcKFhQU3GRj6U
 P9Lu5PshJ/yJMYN4V0aUrj19kGWzpbzOsu5YpuQcCX2jca0uw4SpxecNNoR/XDa2Y3dN
 jFeQpsdmA9eS96jyzonzjPrs77b+0MlGlBfqZinKSv1W+O225emqBVUVXi0zCegMYa0j
 wn7p5dqBDlfenO3wA9qjFMlOn7SKiUVfohMh0Jmlk+DA49gSXPco+r10lLhJkuxuW91q
 HVVUNIRzDNnCJKboi7+Tzd8qks7Q48XbA5qzu4Gbj/VU/VFzjAUTRYxBv2/+C8Unognd
 5Sgg==
X-Gm-Message-State: AOJu0YyuptqL0eqC1Im7EmqnvQQSL/jmkns8XUz5BruPRgaRmJ8O6IR2
 XveTX3oBKDc8+4HwJMp4Vlm9Fu11khdJjNu0PAHxrg==
X-Google-Smtp-Source: AGHT+IGR7TSAA5i+Kjd6vme9TjNtO/9cUNwovFSDIVKoET0GE7V234uOcC3vf6D5XuZ/NMkRQqdCuw==
X-Received: by 2002:a17:907:7758:b0:9a1:b5fc:8c5f with SMTP id
 kx24-20020a170907775800b009a1b5fc8c5fmr4082435ejc.49.1693486446036; 
 Thu, 31 Aug 2023 05:54:06 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 yy10-20020a170906dc0a00b0099364d9f0e2sm739110ejb.98.2023.08.31.05.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 05:54:05 -0700 (PDT)
Date: Thu, 31 Aug 2023 14:54:04 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH RESEND v8 04/20] target/riscv: add
 DEFINE_PROP_END_OF_LIST() to riscv_cpu_options[]
Message-ID: <20230831-6b0f5100a4bda44dc3415bb7@orel>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
 <20230824221440.484675-5-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824221440.484675-5-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x631.google.com
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

On Thu, Aug 24, 2023 at 07:14:24PM -0300, Daniel Henrique Barboza wrote:
> Add DEFINE_PROP_END_OF_LIST() and eliminate the ARRAY_SIZE() usage when
> iterating in the riscv_cpu_options[] array, making it similar to what
> we already do when working with riscv_cpu_extensions[].
> 
> We also have a more sophisticated motivation behind this change. In the
> future we might need to export riscv_cpu_options[] to other files, and
> ARRAY_LIST() doesn't work properly in that case because the array size
> isn't exposed to the header file. Here's a future sight of what we would
> deal with:
> 
> ./target/riscv/kvm.c:1057:5: error: nested extern declaration of 'riscv_cpu_add_misa_properties' [-Werror=nested-externs]
> n file included from ../target/riscv/kvm.c:19:
> home/danielhb/work/qemu/include/qemu/osdep.h:473:31: error: invalid application of 'sizeof' to incomplete type 'const RISCVCPUMultiExtConfig[]'
>  473 | #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
>      |                               ^
> ./target/riscv/kvm.c:1047:29: note: in expansion of macro 'ARRAY_SIZE'
> 1047 |         for (int i = 0; i < ARRAY_SIZE(_array); i++) { \
>      |                             ^~~~~~~~~~
> ./target/riscv/kvm.c:1059:5: note: in expansion of macro 'ADD_UNAVAIL_KVM_PROP_ARRAY'
> 1059 |     ADD_UNAVAIL_KVM_PROP_ARRAY(obj, riscv_cpu_extensions);
>      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> home/danielhb/work/qemu/include/qemu/osdep.h:473:31: error: invalid application of 'sizeof' to incomplete type 'const RISCVCPUMultiExtConfig[]'
>  473 | #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
>      |                               ^
> ./target/riscv/kvm.c:1047:29: note: in expansion of macro 'ARRAY_SIZE'
> 1047 |         for (int i = 0; i < ARRAY_SIZE(_array); i++) { \
> 
> Homogenize the present and change the future by using
> DEFINE_PROP_END_OF_LIST() in riscv_cpu_options[].
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a51b946804..272edaadf0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1916,6 +1916,8 @@ static Property riscv_cpu_options[] = {
>  
>      DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
>      DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
> +
> +    DEFINE_PROP_END_OF_LIST(),
>  };
>  
>  #ifndef CONFIG_USER_ONLY
> @@ -1967,12 +1969,12 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
>          riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
>      }
>  
> -    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
> +    for (prop = riscv_cpu_options; prop && prop->name; prop++) {

Checking prop->name is sufficient.

>          /* Check if KVM created the property already */
> -        if (object_property_find(obj, riscv_cpu_options[i].name)) {
> +        if (object_property_find(obj, prop->name)) {
>              continue;
>          }
> -        qdev_property_add_static(dev, &riscv_cpu_options[i]);
> +        qdev_property_add_static(dev, prop);
>      }
>  }
>  #endif
> @@ -2003,8 +2005,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
>          qdev_property_add_static(dev, prop);
>      }
>  
> -    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
> -        qdev_property_add_static(dev, &riscv_cpu_options[i]);
> +    for (prop = riscv_cpu_options; prop && prop->name; prop++) {
> +        qdev_property_add_static(dev, prop);
>      }
>  }
>  
> -- 
> 2.41.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


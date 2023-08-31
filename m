Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0587778EF17
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:58:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbiBl-0005id-2R; Thu, 31 Aug 2023 09:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbiBi-0005VC-0g
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:58:22 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbiBd-0007GH-Tj
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:58:21 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-500a398cda5so1657281e87.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693490292; x=1694095092; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FphzdIhXcWGeug1uWLhZXCjTN7COEKVkyEuBROmgYjs=;
 b=mKHst14FaLp5HdsTyub+OqpicikBQaJUfEnzxFH6OGnFdAmz0sr5PizcTP/wnpB7U5
 CRH8HPnqC2ZBWpkbuyuw/KyOXMnPrdbyqO8ExljwkqOlZMuTsdLvbaMolfPrbjaBJHah
 D38qQvi8ozEHpfr1dfQYVkqi/4Z+z/B5GR0pCm8HsJbCDtXDtnJC/UE6HhjIQd/NAUpR
 +/4J0Wv3yYwKYiGuxxE6KDKIr3cYpckBYoCVtY/z6XRoeNNBJn6Yze2Xf2FcJ43rC42o
 h+rUGNnkBECsiCzVCKhKb3hT72emlXi3adSAZaP4oabBTFdGjBd8r2x3t+dfpklTgYu8
 mfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693490292; x=1694095092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FphzdIhXcWGeug1uWLhZXCjTN7COEKVkyEuBROmgYjs=;
 b=ApckW9GO75Z+3+pxBrURGaBap8f8hmyAwkAe+pan33B3zZyC/N5km9b4eLn50xxznT
 q5ffZwaZ9HuNrzi+BRXDy22oU28KZHQ2u9noQ4l826XAvLxMOgAMF7hBQlM0TLUSjUO9
 AHQnAmmN3Eon4vps5k0evQwspeeqjkxcFK0mVj5tVZ6gxjTG2xtXp2UcbOpfWK23BnNw
 HgU58MdCFWLeGi/Jl7gQ4YxoYWRhTIs+KEXWk6mK04RVo6EPO9aLt8Hb4zZ9xXF/wKI3
 WsE/T1nwx2sL55gx5CPdqxviYMR37rbC2NIx4aJr1cmQ2QG4nJ2c5tTYnsnkC5upeiPx
 CS6w==
X-Gm-Message-State: AOJu0Yy4HS745P4lQusojgxsrZ+ME8SkRNNQSalbU4yb7IaaQ/eGJQhK
 9ylv5QW88uSnvJOMUdTQbKg1QA==
X-Google-Smtp-Source: AGHT+IEIuoHWICu/DvA/gtWCzY7E3QgSvV8ZSM5/qXXifFaHGcL6CgpKBSTcRJbE4N5w++Cy1dnhsA==
X-Received: by 2002:a05:6512:34c1:b0:500:ac0b:8d52 with SMTP id
 w1-20020a05651234c100b00500ac0b8d52mr3581663lfr.7.1693490292505; 
 Thu, 31 Aug 2023 06:58:12 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 gu18-20020a170906f29200b0098f99048053sm800364ejb.148.2023.08.31.06.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 06:58:12 -0700 (PDT)
Date: Thu, 31 Aug 2023 15:58:11 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH RESEND v8 19/20] target/riscv/cpu.c: honor user choice in
 cpu_cfg_ext_auto_update()
Message-ID: <20230831-6f6003f2a9624ed0ae68a3b6@orel>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
 <20230824221440.484675-20-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824221440.484675-20-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=ajones@ventanamicro.com; helo=mail-lf1-x132.google.com
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

On Thu, Aug 24, 2023 at 07:14:39PM -0300, Daniel Henrique Barboza wrote:
> Add a new cpu_cfg_ext_is_user_set() helper to check if an extension was
> set by the user in the command line. Use it inside
> cpu_cfg_ext_auto_update() to verify if the user set a certain extension
> and, if that's the case, do not change its value.
> 
> This will make us honor user choice instead of overwriting the values.
> Users will then be informed whether they're using an incompatible set of
> extensions instead of QEMU setting a magic value that works.
> 
> For example, we'll now error out if the user explictly set 'zce' to true
> and 'zca' to false:
> 
> $ ./build/qemu-system-riscv64 -M virt -cpu rv64,zce=true,zca=false -nographic
> qemu-system-riscv64: Zcf/Zcd/Zcb/Zcmp/Zcmt extensions require Zca extension
> 
> This didn't happen before because we were enabling 'zca' if 'zce' was enabled
> regardless if the user explictly set 'zca' to false.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ae8c35402f..e07b2c73e7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -196,6 +196,12 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
>      return PRIV_VERSION_1_10_0;
>  }
>  
> +static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
> +{
> +    return g_hash_table_contains(multi_ext_user_opts,
> +                                 GUINT_TO_POINTER(ext_offset));
> +}
> +
>  static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
>                                      bool value)
>  {
> @@ -207,6 +213,10 @@ static void cpu_cfg_ext_auto_update(RISCVCPU *cpu, uint32_t ext_offset,
>          return;
>      }
>  
> +    if (cpu_cfg_ext_is_user_set(ext_offset)) {
> +        return;
> +    }
> +
>      if (value && env->priv_ver != PRIV_VERSION_LATEST) {
>          /* Do not enable it if priv_ver is older than min_version */
>          min_version = cpu_cfg_ext_get_min_version(ext_offset);
> -- 
> 2.41.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


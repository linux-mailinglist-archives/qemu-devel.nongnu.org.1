Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB7878EE0C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:05:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhLY-0008C5-Vl; Thu, 31 Aug 2023 09:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbhKL-0006U2-Qv
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:03:13 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbhKI-0007UB-Ra
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:03:13 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52a4b62c2f5so978752a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693486989; x=1694091789; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DgboMzHcr+BZbFPxUsAkwt5xa7gabhmrGuTsJtYRfaE=;
 b=eE0EoRx0vduIu7pHbyXih5CLruvRPyvJOvpECrzPx50aFBte00uO4GZlEHtcY91Aye
 mj/ckJZpW6R1vPbFlYakNXCIPZOEMDC1nivPcgTYCE2+9iMKQGIAJBMSx7cde/Fra2UL
 ZT/Hn0soAuH8RTD4nj1XVY6TE3ez6EJ3iZRWbWLCoFnnUNEw+SSJdeiOeFtEc+F3K6zQ
 S+YFNNDu9zTVFOD9OTxQH9p8pk/6smvHtFwbGDjcjxJPDv1OwJ5HBd247SC+LnBse9b4
 uJFnHIgUZgy4oilGNd+m/HUB+KI/rfLEH06sU8raIWbqbp34dpqZ05YHZ8wz4iVgOX3l
 mjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486989; x=1694091789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgboMzHcr+BZbFPxUsAkwt5xa7gabhmrGuTsJtYRfaE=;
 b=I0slsZjM56RghZu+betwtV51hVp9eJTPnG+M4BKFZOuL6LKlAAMQcEVsDtrO5DsDYs
 K0AdiJvR69I1Bla09QVzfM5oH+MOygk8jqm77Bb2IwheFDF4D/E+mxa/C3Pnvgec1f5z
 ShrM7qefN9AO/qRlrV7fBJUHXaiUHjHO1r7fbVBD7ePYLmhqcST+/UweO9wXFB9VQqZ7
 rsYHmHG7Ih+q/BjMNw2MpVfVtsqIq6bdmGI3JW71/8IHC58ugslWO2Fl2yRfyubNVcSb
 B2pnQsnw0VUxSNcy3AwKBSHyNk/8g33whGMFIUOaOnNwVtK1bRMBHHGDv4TD+dQztYk4
 Bz1w==
X-Gm-Message-State: AOJu0YwTt+LMZRJ5nYdVPyQPWqFBMhqFoO8W30FTZ7xUvY7FPr4330sN
 ZQdH9/dIJAF46DAscIxMRkylqG313eC2UMmRHjQMbw==
X-Google-Smtp-Source: AGHT+IHs7hgssfeMzmvqobgnd6db+zeDL/JAoFdWDJlLjSc3wOlCFF+WqVSagSokeSzSfQtA7KqhwA==
X-Received: by 2002:a17:906:cc56:b0:9a1:bcf9:4f92 with SMTP id
 mm22-20020a170906cc5600b009a1bcf94f92mr3694088ejb.8.1693486989218; 
 Thu, 31 Aug 2023 06:03:09 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a170906255600b0099cd008c1a4sm741142ejb.136.2023.08.31.06.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 06:03:08 -0700 (PDT)
Date: Thu, 31 Aug 2023 15:03:06 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH RESEND v8 08/20] target/riscv/cpu.c: add
 riscv_cpu_add_kvm_unavail_prop_array()
Message-ID: <20230831-a0eb7c29ec39f4c58e492159@orel>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
 <20230824221440.484675-9-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824221440.484675-9-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52f.google.com
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

On Thu, Aug 24, 2023 at 07:14:28PM -0300, Daniel Henrique Barboza wrote:
> Use a helper in riscv_cpu_add_kvm_properties() to eliminate some of its
> code repetition.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4608fa2378..d78c2c058f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1971,6 +1971,14 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
>                          NULL, (void *)prop_name);
>  }
>  
> +static void riscv_cpu_add_kvm_unavail_prop_array(Object *obj,
> +                                                 Property *array)
> +{
> +    for (Property *prop = array; prop && prop->name; prop++) {
> +        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
> +    }
> +}
> +
>  static void riscv_cpu_add_kvm_properties(Object *obj)
>  {
>      Property *prop;
> @@ -1979,17 +1987,9 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
>      kvm_riscv_init_user_properties(obj);
>      riscv_cpu_add_misa_properties(obj);
>  
> -    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
> -        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
> -    }
> -
> -    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
> -        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
> -    }
> -
> -    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
> -        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
> -    }
> +    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
> +    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_vendor_exts);
> +    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_experimental_exts);
>  
>      for (prop = riscv_cpu_options; prop && prop->name; prop++) {
>          /* Check if KVM created the property already */
> -- 
> 2.41.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


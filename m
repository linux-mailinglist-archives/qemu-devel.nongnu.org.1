Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2B878EE47
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:14:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhLW-0008Be-2v; Thu, 31 Aug 2023 09:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbhJ2-0003ac-UL
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:01:52 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbhIz-0007Ax-T4
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:01:52 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99c93638322so155649166b.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693486908; x=1694091708; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lH6TnAo/w2WPYjZUcsWekEb1RNbiIJUFMjSMObAamQQ=;
 b=KWMRuLhlCUXxGRGx9/41S1N5rsGzIwzKu1fGPrSIu3/uA4IYuZSXhT45Crc1MPfERg
 +DfxjCA/CvbLeTsE/qQgd/tBwN4BtdumJ1MOFbMANcF8kOQLZxC0L3qqRQJ2U+fqFsOT
 rswSCLHTUo/pKfN/xMmv4Zh1OecHwcZPyKCXo6hUfqaTOWMWvO4e13Ut4Kcm0ZrK/ZaT
 kd8HApeBhqdFwTiUMkoKJgPpVIC0PTEyvTA9Ocih1oHQ8a7lzezjREb649S169M8Nyb3
 Svyxs277gkefQTBWV8+z4m/y7LZGrEuU1p1uFHyA6+DlFIxkzFdhf2aK1F+2RhP5MNWr
 Si8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486908; x=1694091708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lH6TnAo/w2WPYjZUcsWekEb1RNbiIJUFMjSMObAamQQ=;
 b=kjfkioodZ6YR9oNeoqUrctY5wEwMeBld3/qT1F86uPItRPaEoKQkhsKNbQM9CftErj
 fXCpkZKZ+9rPsI+mpO9X/om6fTBEkGSAOYCPYOKqcG2a056OU8l2RrVi3hfyDMCyN4eh
 8f3PW1D4GmVHrfn9LzXoRr9vyqJTVYEzz8jlHOzIsbilf1SpsPKbPCvrRDthOMrWv2rz
 6V79cDtp9rwCL6mi6izLVZpbZOoxKN3yYOlBh7dcyydD6OzAncnKowporHICf4jQMP/K
 YEsNeXk5zj/v8fR8LF1JQQsyOPaWanCTaAyOVTw+jDWT2UU/WDuv5afC3xsGLMQ7DppW
 C0DA==
X-Gm-Message-State: AOJu0YypYpYa4DxBiG54ecOZk4VsZYdDhggznUxOo8ZVX5S6SI/G0dFw
 esMh+pNAe1UJ5xEUt+LiIXG/og==
X-Google-Smtp-Source: AGHT+IGzSKDoEdWZXZomZFxKuoPqXhgoniJvRRKG4bWMHDxqxmkUFYT/5gaxOIAgLuRQVlaSNBnghg==
X-Received: by 2002:a17:906:3043:b0:9a1:ca55:d0cb with SMTP id
 d3-20020a170906304300b009a1ca55d0cbmr2802076ejd.23.1693486907155; 
 Thu, 31 Aug 2023 06:01:47 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ja8-20020a170907988800b0099bd6026f45sm726869ejc.198.2023.08.31.06.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 06:01:46 -0700 (PDT)
Date: Thu, 31 Aug 2023 15:01:44 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH RESEND v8 07/20] target/riscv/cpu.c: add
 riscv_cpu_add_qdev_prop_array()
Message-ID: <20230831-bf8480410d43227a4308903e@orel>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
 <20230824221440.484675-8-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824221440.484675-8-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x629.google.com
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

On Thu, Aug 24, 2023 at 07:14:27PM -0300, Daniel Henrique Barboza wrote:
> The code inside riscv_cpu_add_user_properties() became quite repetitive
> after recent changes. Add a helper to hide the repetition away.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 668522db01..4608fa2378 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1946,6 +1946,13 @@ static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
>  }
>  #endif
>  
> +static void riscv_cpu_add_qdev_prop_array(DeviceState *dev, Property *array)
> +{
> +    for (Property *prop = array; prop && prop->name; prop++) {

Here checking prop first is a good idea, as a caller could pass NULL for
'array'. But, if we don't want callers to ever pass NULL for array, then
dropping the prop check will ensure we get a segfault to spot the bug (or,
a bit cleaner, we could add an explicit assert(array)).

> +        qdev_property_add_static(dev, prop);
> +    }
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
>  {
> @@ -2002,7 +2009,6 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
>   */
>  static void riscv_cpu_add_user_properties(Object *obj)
>  {
> -    Property *prop;
>      DeviceState *dev = DEVICE(obj);
>  
>  #ifndef CONFIG_USER_ONLY
> @@ -2016,21 +2022,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
>  
>      riscv_cpu_add_misa_properties(obj);
>  
> -    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
> -        qdev_property_add_static(dev, prop);
> -    }
> -
> -    for (prop = riscv_cpu_options; prop && prop->name; prop++) {
> -        qdev_property_add_static(dev, prop);
> -    }
> -
> -    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
> -        qdev_property_add_static(dev, prop);
> -    }
> -
> -    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
> -        qdev_property_add_static(dev, prop);
> -    }
> +    riscv_cpu_add_qdev_prop_array(dev, riscv_cpu_extensions);
> +    riscv_cpu_add_qdev_prop_array(dev, riscv_cpu_options);
> +    riscv_cpu_add_qdev_prop_array(dev, riscv_cpu_vendor_exts);
> +    riscv_cpu_add_qdev_prop_array(dev, riscv_cpu_experimental_exts);
>  }
>  
>  static Property riscv_cpu_properties[] = {
> -- 
> 2.41.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


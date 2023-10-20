Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB517D16BF
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:04:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtvjd-000426-Ae; Fri, 20 Oct 2023 16:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtvjb-0003x4-VT
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:04:39 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtvjZ-0005tV-Ef
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:04:39 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b709048f32so1107666b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697832275; x=1698437075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3qtPEMnjbXS/VQ0mGxfdQ1sEQoiygD6WyM0+vaO1Nfk=;
 b=YE25GssFQ7OjSpJd4QUW/dB/EDWQgItawvb6WvVKJSkSTxlc7iZ1Kqo4/SV4nyl1//
 LPYKmCux1IzJbwcXUu7oVF6Qho2JXIIgtX8OJXU9UgIJHJic8a8AtfvJQbhVjfo+soI8
 V3cIk+ZsiY+S/QNTDkW2yOSbuh4XpX9ecx++w4MowDKobzpqWMD7EjqT1VDCfIHPQq3+
 cBWkbrDwIu9NgKQE53svWMiiNYoClyTlG4TkpnhoxLjwZrXWlxrDmhcclVOLKz2/dDYy
 EFIKF9ZOAhriHZz/TDXn+XSEEoE3ycPz3YVEkBEBbCRQpWfSBkam1OGkZppYBCkU6xJ0
 OlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697832275; x=1698437075;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3qtPEMnjbXS/VQ0mGxfdQ1sEQoiygD6WyM0+vaO1Nfk=;
 b=wsB9mfb57UdYKzzZa3Ny5nGerZ70kBqOvJEnVndUa9hCkGl4JYraAp+1JfVeFAwbUw
 dfuNO8bUrXkgDQ/en4HPIvJ9rYgjVGC4rU/ycL0c3Iy45cIUA6g0U/zl0mDx7ZinTZyk
 NQjqjB92DL84plRnpEzA3C6Q28X2pSEk7JegC5vBpqPHK+cjwYdjocXOux3dGAbX/n9p
 K1qMH5vdeh7zLtqsFvCcy/AcpsVyS0w6ys+yCGQgLFkO+fR1kl7GrnCtPMY81I0qVDE+
 1HQmaeI5TELOjnDaEshS6UbGVzesAgrFTOzIAFLRtqurjOFnQTdkPKLaboMtlAZYeHeq
 Cj8g==
X-Gm-Message-State: AOJu0YwlcDN1Lhpo+KWf06umlKRCxNj6xe67FO8wTiffQZpHQpZ3BeXr
 sHQ98FWGm7uTBkekShZR76nKso73VrjeUgserAI=
X-Google-Smtp-Source: AGHT+IH3kQysdkpr5+Ul0wEeQIjYrbDwU/oXTsFVDYHwLmNCpAEhLeUyhAyBl/MYqcrwcAbdEPHoCg==
X-Received: by 2002:a05:6a20:840b:b0:163:5bfd:ae5b with SMTP id
 c11-20020a056a20840b00b001635bfdae5bmr3477508pzd.15.1697832275500; 
 Fri, 20 Oct 2023 13:04:35 -0700 (PDT)
Received: from [192.168.68.107] ([177.45.186.249])
 by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1913031pfn.208.2023.10.20.13.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 13:04:35 -0700 (PDT)
Message-ID: <56726933-267f-4018-9632-e9bf0b476901@ventanamicro.com>
Date: Fri, 20 Oct 2023 17:04:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system/riscv: remove core limit from virt machine
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20231019134812.241044-1-dbarboza@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231019134812.241044-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

The commit title is misleading. We're not removing the core limit, we're
updating it.

I just sent a new version with an appropriate commit title. Thanks,


Daniel

On 10/19/23 10:48, Daniel Henrique Barboza wrote:
> The 'virt' RISC-V machine does not have a 8 core limit. The current
> limit is set in include/hw/riscv/virt.h, VIRT_CPUS_MAX, set to 512 at
> this moment.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1945
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   docs/system/riscv/virt.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index f9a2eac544..f5fa7b8b29 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -12,7 +12,7 @@ Supported devices
>   
>   The ``virt`` machine supports the following devices:
>   
> -* Up to 8 generic RV32GC/RV64GC cores, with optional extensions
> +* Up to 512 generic RV32GC/RV64GC cores, with optional extensions
>   * Core Local Interruptor (CLINT)
>   * Platform-Level Interrupt Controller (PLIC)
>   * CFI parallel NOR flash memory


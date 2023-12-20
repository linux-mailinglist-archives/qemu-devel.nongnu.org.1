Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDF081A758
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 20:40:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG2Q5-0007j8-G2; Wed, 20 Dec 2023 14:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rG2Q3-0007ir-A5
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 14:39:51 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rG2Q1-0003EJ-PZ
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 14:39:51 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-28bc8540299so13864a91.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 11:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1703101187; x=1703705987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fzbFaEy/KGm9WK3voBtagHjtNo8g1rpCrqKZeZHhuxI=;
 b=gpodAaETZPi2m56l9ykP+3Dn7x9WTq66dfAqlYt2biIsZR0tdgGTZlACI+EJDeD3yY
 aWQ1sYMbp/24lNHpFxqnksEoVnTF2uvsEcc+HCMZ+aep0HtDEth1g6uK/gsFvWkLSZ4+
 B4cjM89XgBV/N6+UVVP1Kuy5bijXnnaqQRPjrVDEOgVBxcpNPDmF1xd603n20+OXQRzx
 sLVuNayx4BBV8wMZw4WFpYElJsAgIaGU1P/uEaddDIwlIdRSEn3QcaZJikL5XZSgojRi
 nJMJASkA8A1itLFmnspz9e208vPKnkCmvSxUAUrjtE8e6UoWMX7ydWvdTqqt8ypzUAf3
 jRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703101187; x=1703705987;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fzbFaEy/KGm9WK3voBtagHjtNo8g1rpCrqKZeZHhuxI=;
 b=jLPjuMM+7HxHMRJ1uluVcl3vyjVEsFRSgxyH3WIVKEGs0i4n1lNQPntn9AKruGLK+x
 CM5QwbbaXEokorgJt+cR0KVdsqkWat0o3k2ozSYrIBut8LeNSHxUTda60r6KE1FwW4tv
 oDZTqaCmCExVHaiUAjjAWKlxhgHMq5hH+qH9+qk4HOnFaVbOizlxEIBAn4Eupr7H+TXZ
 8UwcM2YLUwqDA5OoXtU47J00N3yL7MVfZpcm9LgLBdCNOEz7wjRrZbQbDtyp/l8u8o9Y
 GHPjWWI223USeY36yayAkK0zB09pemNPQo9hhyqczSxQo8jW/2KDclS/sVJy+2J3BHXy
 Xcxw==
X-Gm-Message-State: AOJu0Yzsml2YqbTwF/ZwSSt3gjV249VwsCbRXNhwNwhQC+YWEcw8N6iT
 DNLRQU1lTTRJPEz5L8VLF0JSIQ==
X-Google-Smtp-Source: AGHT+IGeAtYoWLNeKSH5deICY6gph4R7zylyhXczg8e7t0UeEKlDPjSh5xjeriS9+q3i5PUvaNVjow==
X-Received: by 2002:a17:90a:da05:b0:28b:894b:4494 with SMTP id
 e5-20020a17090ada0500b0028b894b4494mr3071960pjv.55.1703101187634; 
 Wed, 20 Dec 2023 11:39:47 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.205])
 by smtp.gmail.com with ESMTPSA id
 68-20020a17090a09ca00b0028bdd7b50b6sm256090pjo.42.2023.12.20.11.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 11:39:47 -0800 (PST)
Message-ID: <f5f2d12d-a444-49f6-8fc3-00f582b87799@ventanamicro.com>
Date: Wed, 20 Dec 2023 16:39:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] docs/system/riscv: document acpi parameter of virt
 machine
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
References: <20231220193436.25909-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231220193436.25909-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 12/20/23 16:34, Heinrich Schuchardt wrote:
> Since QEMU v8.0.0 the RISC-V virt machine has a switch to disable ACPI
> table generation. Add it to the documentation.
> 
> Fixes: 168b8c29cedb ("hw/riscv/virt: Add a switch to disable ACPI")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> v2:
> 	mention that acpi=on is the default
> ---
>   docs/system/riscv/virt.rst | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index f5fa7b8b29..9a06f95a34 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -95,6 +95,11 @@ The following machine-specific options are supported:
>     SiFive CLINT. When not specified, this option is assumed to be "off".
>     This option is restricted to the TCG accelerator.
>   
> +- acpi=[on|off|auto]
> +
> +  When this option is "on" (which is the default), ACPI tables are generated and
> +  exposed as firmware tables etc/acpi/rsdp and etc/acpi/tables.
> +
>   - aia=[none|aplic|aplic-imsic]
>   
>     This option allows selecting interrupt controller defined by the AIA


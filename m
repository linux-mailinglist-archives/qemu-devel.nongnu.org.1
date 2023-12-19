Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A21818AF6
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 16:15:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFbny-0005Zg-Ty; Tue, 19 Dec 2023 10:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFbnw-0005ZI-TW
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:14:44 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFbnv-0001qC-Bi
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:14:44 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5cd82917ecfso2457306a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 07:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702998881; x=1703603681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QKozxVtLxp2LOE0IA7OsfMhVxm8SuAfFJLKlnZyENIg=;
 b=eTqqMRgyXqH6tOUm//sLwQVCBawQ8xjoxC3gmWyr3Zw6gRVgqf2MSoJl7529DYc87S
 AD5E1nkaSYFyAaHvp0f0kZi4wO5cz6Fyu4YdWeG0xIMOGnW3M8fCkrqJXPrUnHMjftHm
 KmqMZt0fJ3YWXm3Bcn2jq8wHvPzxPOjkX6FAqXKAfCzWoVP+3IJ8ccH191I24/PHmHXo
 SZeuM/nllPrtHnmhvIWeCw8XxcmuBckevdL0bBO+3vsRFQGL4/p8lg77B0JeTyu8lP+u
 Ihm6fFNabh8HlasuoRTNCxiji6dCJJxX7qtY8ISgtopKaEICFJ7RutIkxRp3f+PWNJib
 hEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702998881; x=1703603681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QKozxVtLxp2LOE0IA7OsfMhVxm8SuAfFJLKlnZyENIg=;
 b=L1FMLkgKS+1n6WivjdlMMKD1X/qUeymy7UllCVNSvip7r6+Sp40E1BjG/KSQF4/oXW
 ugxZPFhFJ29p+C6tuMhIHkLemYrVsurNyzCYNKXHd030Y9OAQbXAqwUbploFIf6w9sKN
 lgT95q1Na47YwGR+MuqenYnZeRTCl5HjbcD2tP6ahaK7Yu1TUaLXGoQsRYC8N3w6IH2C
 5TdJzsmfAHTvAve7EnRYjv4KJ+c3OxLOwFQJjsylmqQ8cNk/qoKRXK5taRaRr5DDQA0w
 wibqHfpFtXZ0GWTtTM8DKAt7Az5nKPl1RN50CGS+yw0Xp/yEJ6NvoAaHnlC57Rb1og7J
 Cp3w==
X-Gm-Message-State: AOJu0YxrQm668M2JD5OVNkGDFJOizUYDtIwzwBlmSVobjqEm/aHo2XrC
 CXQRDaqWoL1pfYxLy+3pdZpI6g==
X-Google-Smtp-Source: AGHT+IEPxbUazkkY8lc2PgyN6A/tegAqAJExVYyHhkCXORCcylDyn/MPmHDL8IvC34Y0svNjhL1wMQ==
X-Received: by 2002:a17:90b:17c3:b0:286:cc3d:9df8 with SMTP id
 me3-20020a17090b17c300b00286cc3d9df8mr11706789pjb.16.1702998880979; 
 Tue, 19 Dec 2023 07:14:40 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.205])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a17090b070b00b0028b338470a0sm1691944pjz.3.2023.12.19.07.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 07:14:40 -0800 (PST)
Message-ID: <359a0622-2c0e-4f97-904f-290d87538613@ventanamicro.com>
Date: Tue, 19 Dec 2023 12:14:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] docs/system/riscv: document acpi parameter of virt
 machine
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
References: <20231219143829.8961-1-heinrich.schuchardt@canonical.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231219143829.8961-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x533.google.com
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



On 12/19/23 11:38, Heinrich Schuchardt wrote:
> Since QEMU v8.0.0 the RISC-V virt machine has a switch to disable ACPI
> table generation. Add it to the documentation.
> 
> Fixes: 168b8c29cedb ("hw/riscv/virt: Add a switch to disable ACPI")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   docs/system/riscv/virt.rst | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index f5fa7b8b29..4e134ff2ac 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -95,6 +95,11 @@ The following machine-specific options are supported:
>     SiFive CLINT. When not specified, this option is assumed to be "off".
>     This option is restricted to the TCG accelerator.
>   
> +- acpi=[on|off|auto]
> +
> +  When this option is "on", ACPI tables are generated and exposed as firmware
> +  tables etc/acpi/rsdp and etc/acpi/tables.
> +
>   - aia=[none|aplic|aplic-imsic]
>   
>     This option allows selecting interrupt controller defined by the AIA


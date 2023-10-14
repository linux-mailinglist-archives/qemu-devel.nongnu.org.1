Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 915497C95D1
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 20:05:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrizl-0001Dw-3r; Sat, 14 Oct 2023 14:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qrizj-0001D2-Is
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 14:04:11 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qrizh-0007PW-KU
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 14:04:11 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5859a7d6556so2341337a12.0
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697306647; x=1697911447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OTyFJpzixiHGEOr7idBGNlBPwe+6+2TFrHoRXmgkduo=;
 b=W1CgPIzZA8Ye9vHMs7/kmiCsLgVn3mak62tcXmHrGvOVFCCCJmYZlhkN8K5IuQfd/C
 lMitZ9rzVEtKv29YfKQUMF/87H9589ORu0fcj6vOiS1pJUP+5yCjvQWEsDMRpqjbbYl6
 p4w4Xm+VyHse8DdQA+Eng05VHyj3HKCeSlQM8HS02adcR11qS2awwrG5HyPn9Cq03Gh3
 OclJbWIer+bwkXJzbLJzWjSE1QHZi96YrVptOycJ5qmE958fOz/tjyVxFRxChwe9yte5
 Xpt+N4prytn1OChugYsqhauACIArJok3N3LtiPohF+cfnN3DwlYD2jciAJxeMT/+flEk
 MHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697306647; x=1697911447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OTyFJpzixiHGEOr7idBGNlBPwe+6+2TFrHoRXmgkduo=;
 b=KWho1V/casK5XtHneoKecCrIcOROILvg6JWGnj+TFOhVW3yNAKrojN9rBl/pvp7S+n
 XK/0UdbayMEZeDpZTmXcKeTQVQsMm+WUsYLeWr2y1s0ZPWm9o2xkOCjgOQ2fN2t4Bm3V
 XL9PAxLoa9TuHmxlAzgszd0H5GlLnAwWxlUzCPKc3hNAbUAXUS/K7airZ9y7iaTWcHc6
 QpEFNEjCBckjVa5KKjtXU5MOxXmMZKnjwfNC62DI0p4mZcRQ+ua77KdKDCv0nabtGt15
 NFCD8oSYo2uRbzCHOca6aYJc+yYzuAY1IgGVL0denxs0nNxl5am8u587dVIhAiHDKLfe
 Y/9w==
X-Gm-Message-State: AOJu0YxQz40dYPmbpugd6f7iLLVE9H1Np8o61e3T3vsNemw12K0T+bml
 Utw225VRr1EMleY+0ZO063yI1g==
X-Google-Smtp-Source: AGHT+IF03cPUVi7JizBaR9wPKxSwKmImJb3AilcDQHIXWHpnwQNb9jIfXxuJVWJpX0tK10SgBs0k3w==
X-Received: by 2002:a17:90a:4a8b:b0:27d:3ed2:86a5 with SMTP id
 f11-20020a17090a4a8b00b0027d3ed286a5mr4330569pjh.33.1697306647479; 
 Sat, 14 Oct 2023 11:04:07 -0700 (PDT)
Received: from [192.168.68.107] ([177.45.186.249])
 by smtp.gmail.com with ESMTPSA id
 23-20020a17090a005700b0027cf7818fb6sm2114870pjb.37.2023.10.14.11.04.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 11:04:06 -0700 (PDT)
Message-ID: <597bf4be-207b-400a-be49-bc18900809a0@ventanamicro.com>
Date: Sat, 14 Oct 2023 15:04:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/riscv: Do not allow MXL_RV32 for
 TARGET_RISCV64
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20231014033545.15220-1-akihiko.odaki@daynix.com>
 <20231014033545.15220-2-akihiko.odaki@daynix.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231014033545.15220-2-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x536.google.com
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



On 10/14/23 00:35, Akihiko Odaki wrote:
> TARGET_RISCV64 does not have riscv-32bit-cpu.xml so it shouldn't accept
> MXL_RV32.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/tcg/tcg-cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index a28918ab30..e0cbc56320 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -161,10 +161,11 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
>       case MXL_RV128:
>           cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
>           break;
> -#endif
> +#elif defined(TARGET_RISCV32)
>       case MXL_RV32:
>           cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
>           break;
> +#endif
>       default:
>           g_assert_not_reached();
>       }


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F98F740596
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 23:31:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEGGA-0008Rh-8V; Tue, 27 Jun 2023 17:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEGG8-0008R4-Ol
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:30:00 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEGG7-0002AE-2z
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:30:00 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f9fdb0ef35so5186118e87.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687901397; x=1690493397;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oSyOoR4apmMwHh1ifoJzPajoRu3FUVsBx7YDK8G8qBk=;
 b=hhMGPGBpw0auJ+UIyR133Fd9RJIKBUr2Cr1afvAmgAewCRLdQBiH3Tvz0U6b6/MpwV
 dDiHwhtFENQegA+JS57pc/sDUO4VU2qCkWZb+UCb3rxhuevtn1BcW4hVjzx2k9OWnsUs
 BRWv9TYXyxIAlMI0gtSVOMvMMC6eUxxIDABhlaGe2Iyz70qpzIUEDPoZdK8vKAj0cl1R
 HIkozPXvlrGW5F2YqjP8tkRFUrRSiFOo49y6qR6f6JmAkE2DUxsdCSy53hU0DbbLWGd1
 CNFDtQ4zl0LWkevO8otL4+o3wPQdXl3eKaFJsJfU/IHcXv3F5OXcn6PPoKXlO0d5q3Ai
 WOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687901397; x=1690493397;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oSyOoR4apmMwHh1ifoJzPajoRu3FUVsBx7YDK8G8qBk=;
 b=iGLI8olYskMNMJcc+USepoHORNJHYE/ybx5lvjn8Aql6g1Wd/HeHIt0tI9E82SiUtQ
 rIEE3+LG0AaRi/2lb6RhGsF0wJAyyqM+8fjCDvFH+QbJslNO/LiG8DKAQD6Fq/JrZE6V
 dcgTMOabjXJZC6LDQrle6AuPJcR0ZYpsz9/mx1l/+FTh/sVzfBFvddcDX5r7Ylb8oCiZ
 mGIM/ncqzgONzNx/AyxfajWk/GLdcIBOuBevOva4JFTbZOYauvKIBep9OKuu3M/qvdMj
 F3CbE2rJboe4PfJPYnMIQk/+I/ZmAo8dkoZhB5HMCvgwRggpDOIakwdhxsXD3/LA4mqB
 koaw==
X-Gm-Message-State: AC+VfDwhUenQSuKp3HYbOiQbh9isvgqsHutkJu79lLgZBVhSF1ee+1Ph
 1pdPaULPpjlJL1OSRx34L7ZYVA==
X-Google-Smtp-Source: ACHHUZ6KeHqFzjMGxx+vd3O3tLX90JdRiVXfX/it3dxoIYVcTkzFhG9ifL5bWOT84doGobvPTQhilA==
X-Received: by 2002:a19:da19:0:b0:4f8:4719:1f4a with SMTP id
 r25-20020a19da19000000b004f847191f4amr18250990lfg.7.1687901396799; 
 Tue, 27 Jun 2023 14:29:56 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa7d312000000b0051a2d2f82fdsm4242454edq.6.2023.06.27.14.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 14:29:56 -0700 (PDT)
Message-ID: <e217dfb9-a4c2-12e3-6053-ef2167f30a05@linaro.org>
Date: Tue, 27 Jun 2023 23:29:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v5 11/19] target/riscv/cpu: add misa_ext_info_arr[]
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com
References: <20230627163203.49422-1-dbarboza@ventanamicro.com>
 <20230627163203.49422-12-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627163203.49422-12-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 27/6/23 18:31, Daniel Henrique Barboza wrote:
> Next patch will add KVM specific user properties for both MISA and
> multi-letter extensions. For MISA extensions we want to make use of what
> is already available in misa_ext_cfgs[] to avoid code repetition.
> 
> misa_ext_info_arr[] array will hold name and description for each MISA
> extension that misa_ext_cfgs[] is declaring. We'll then use this new
> array in KVM code to avoid duplicating strings.
> 
> There's nothing holding us back from doing the same with multi-letter
> extensions. For now doing just with MISA extensions is enough.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   target/riscv/cpu.c | 60 ++++++++++++++++++++++++++--------------------
>   target/riscv/cpu.h | 11 ++++++++-
>   2 files changed, 44 insertions(+), 27 deletions(-)


> +const MISAExtInfo misa_ext_info_arr[] = {
> +    [RVA] = {"a", "Atomic instructions"},
> +    [RVC] = {"c", "Compressed instructions"},
> +    [RVD] = {"d", "Double-precision float point"},
> +    [RVF] = {"f", "Single-precision float point"},
> +    [RVI] = {"i", "Base integer instruction set"},
> +    [RVE] = {"e", "Base integer instruction set (embedded)"},
> +    [RVM] = {"m", "Integer multiplication and division"},
> +    [RVS] = {"s", "Supervisor-level instructions"},
> +    [RVU] = {"u", "User-level instructions"},
> +    [RVH] = {"h", "Hypervisor"},
> +    [RVJ] = {"x-j", "Dynamic translated languages"},
> +    [RVV] = {"v", "Vector operations"},
> +    [RVG] = {"g", "General purpose (IMAFD_Zicsr_Zifencei)"},
> +};

Personally I prefer using a getter() helper because we can check in
a single place for empty entries in the array.

IIUC this 13-entries array takes 4MiB (RVV is '1<<21' = 2MiB).

Wouldn't it be clever to index by [a-z]? Except "x-j"...




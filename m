Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A0170B4CB
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 08:04:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0ydh-00074i-Lo; Mon, 22 May 2023 02:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0yde-00071R-C6
 for qemu-devel@nongnu.org; Mon, 22 May 2023 02:03:22 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0ydb-0001Nh-DF
 for qemu-devel@nongnu.org; Mon, 22 May 2023 02:03:20 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30a1fdde3d6so1759132f8f.0
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 23:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684735397; x=1687327397;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zIfNP92u4uyRaaw1sC6ivfRxv9/SM/ggPfC6wbvjWgY=;
 b=idqNGJMc7AsfiX35u+m7+eV97pwfrn6/8JRmWqaE9FiLhy7WdkNdyLnzWnw0KimSC/
 KoIi+X4i5/y3Y7ZXFKqk6XEimj8SUsnfEswIMNFmjmtZUH3tyQR7Z9BG1fI/8AFJFJDN
 01S+Jt1JowqZIQ/zijjhKwP0N5lQ/5Eute7+aviis+ZWgkBPf74v79SpgE18Vzb8N6Cv
 zVFyM9v78LoTIJkfJIquPX5SskQzZX9dCfRCZjaue0q49VdGBl+FIvwtG9+XHOBHfsgt
 6QeEMDDcn+lUtBj8mEuGPrVAWxmz9iJSzmxPoc0em3NFV2UOOCoXpkdovBdyph2ScZrK
 NPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684735397; x=1687327397;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zIfNP92u4uyRaaw1sC6ivfRxv9/SM/ggPfC6wbvjWgY=;
 b=hVVLOuTOOTYXRCO9JXaWFR4Cab39eCRQ6Z4wwK4+DQxcdFVnhYSSpRfU7OWuAuGFAm
 LWcBULtdPe2wDMJb76yjpS1om+aX6499+9W7SpojiSFq/JkISxc94OlgPRu3ywhu+c1P
 PjVIVoQdxbCwl/lk60Y0LmB0yIzX5QG9XlUTYBOsREPiS72pe3G/z8IZ3thTjxfmA+rT
 BXaZVCgI3KArESFLS9L8IOo6QKxeXZQwOCAdOW89WAB4SJBlBrIcwaQLtYYldscp8dGd
 9RZR01r1pRKjdd1pRInU8Fqqr44IA0bVoiaLh5XUjookXUIrUmoZMw9by3W8QCH08TCt
 Mdww==
X-Gm-Message-State: AC+VfDztu0OnmT8BN3WmH6hloSEw3LQxkHKZ1hjIADdBG8SKnISL9sJR
 GMoS5fuFiTBSvilitereaWB+LQ==
X-Google-Smtp-Source: ACHHUZ7O5JDPNVCLqYIEji5UOJDyqGbrhxspJmPTbLF9hNJrt8R7HkpOwI7ztDt69MlvgXvI1Uzfmg==
X-Received: by 2002:adf:fac4:0:b0:306:39e5:f338 with SMTP id
 a4-20020adffac4000000b0030639e5f338mr6566131wrs.62.1684735397309; 
 Sun, 21 May 2023 23:03:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 j2-20020adfff82000000b00304832cd960sm6489449wrr.10.2023.05.21.23.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 23:03:16 -0700 (PDT)
Message-ID: <c5738a5e-03b3-180f-2e26-70e27abd3443@linaro.org>
Date: Mon, 22 May 2023 08:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] hw/mips/loongson3_virt: Remove CPU restrictions for
 TCG
Content-Language: en-US
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, chenhuacai@kernel.org
References: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
 <20230521214832.20145-3-jiaxun.yang@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230521214832.20145-3-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 21/5/23 23:48, Jiaxun Yang wrote:
> After implemented CPUCFG and CSR, we are now able to boot Linux
> kernel with Loongson-3A4000 CPU, so there is no point to restrict
> CPU type for TCG.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/mips/loongson3_virt.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index a57245012598..47289fb6bf85 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -488,10 +488,6 @@ static void mips_loongson3_virt_init(MachineState *machine)
>           if (!machine->cpu_type) {
>               machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
>           }
> -        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
> -            error_report("Loongson-3/TCG needs cpu type Loongson-3A1000");

Hmm, shouldn't we check for CPUs supporting the INSN_LOONGSON3A
insn_flags at least?

> -            exit(1);
> -        }
>       } else {
>           if (!machine->cpu_type) {
>               machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A4000");



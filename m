Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEA070BF90
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:22:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15Tp-0005mH-FI; Mon, 22 May 2023 09:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q15Tn-0005m5-RA
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:21:39 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q15Tm-0000vZ-76
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:21:39 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-397fe20a2b5so387394b6e.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684761696; x=1687353696;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=auOmq+12x07fwhP1oh8Gkgzt7UcHeioWEHLBzPygiu8=;
 b=EOerP9tBfS9rBg4DY2YgLooQd+YcnwB3Aesz8tjQxV2LIhATnWZaQN3IGTPlIwOjXb
 7jcLbKcqIe+PE2qv7Uv1Rr+JanaaavivSu8+FncT1QZdx8Oypbcj4wcv3t4dCfWYCzMi
 pZi4slrbdqDsOvp2y+COO+LV2m+WKXlqeflg/3tCSc+l2pLFOVx7ojpggN/jlcrv1ZlI
 mDXhbteHZAXNcL7JH2RKp0uMuCEm8c5r278U+LvdYL5tk/l49nSkMyrDRrhL553u74+W
 AVryt3HjBtEDoQeCjfjK322UyktcThlRV33R81yaCgjTO3v+MubzSnPTdkg44cPWgYst
 mA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684761696; x=1687353696;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=auOmq+12x07fwhP1oh8Gkgzt7UcHeioWEHLBzPygiu8=;
 b=TBLVDwBbdVRI6IqQTas5sb8dt32g00SWmwTqtW3RpP+J7YdPdVbINKCz5iZjrFvCMI
 X9HhmgdZQNWulp7eHpG2x4+VnGoncbxFWAd7DFp1kQKroob2GCTTEcZOYqQzvgeVFHgz
 pBPHb+m/WaBK0198qMFE35xjcRiFiigt+vz2/puvHe/ipsJvq28dHDy1sOJik9EO6Epw
 dZ8p+OpwxFrVUKjBjsk3+2JiyNuRdoxgcyQ04/UEC2/upRnLEqsVaBu79ToCmVTLM2lA
 jvtCfzT0Dmw+Nxto4xaprGrP1px77Y8AjRZUyQ3hoH4VT36JvVQvy/aklOYCzWzYoPgj
 OvYA==
X-Gm-Message-State: AC+VfDzldZ7imdm6B8SpF7B5ICxCeJDpElHYWsx3fFDnw9WM82KoKaTj
 YgzTS0zwa+Zi1TztCjoRHEqjZw==
X-Google-Smtp-Source: ACHHUZ5rOtHCYGvhct8UvZqrdiVMtSyUiCVyYv+fK0mytFG6kGd2k4Ev/lKMrCWiTIZQuqcclQV0/Q==
X-Received: by 2002:aca:2105:0:b0:396:3ae5:65a4 with SMTP id
 5-20020aca2105000000b003963ae565a4mr5371215oiz.57.1684761696690; 
 Mon, 22 May 2023 06:21:36 -0700 (PDT)
Received: from [192.168.68.107] ([179.111.98.125])
 by smtp.gmail.com with ESMTPSA id
 s205-20020acaa9d6000000b00397f453aae6sm2075148oie.38.2023.05.22.06.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 06:21:36 -0700 (PDT)
Message-ID: <04873b9a-d6d4-1d6f-ce25-89a8e18ab5f1@ventanamicro.com>
Date: Mon, 22 May 2023 10:21:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/5] hw/riscv/opentitan: Rename machine_[class]_init()
 functions
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org
References: <20230520054510.68822-1-philmd@linaro.org>
 <20230520054510.68822-2-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230520054510.68822-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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



On 5/20/23 02:45, Philippe Mathieu-Daudé wrote:
> Follow QOM style which declares FOO_init() as instance
> initializer and FOO_class_init() as class initializer:
> rename the OpenTitan machine class/instance init()
> accordingly.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/opentitan.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index bc678766e7..2d21ee39c5 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -75,7 +75,7 @@ static const MemMapEntry ibex_memmap[] = {
>       [IBEX_DEV_FLASH_VIRTUAL] =  {  0x80000000,  0x80000     },
>   };
>   
> -static void opentitan_board_init(MachineState *machine)
> +static void opentitan_machine_init(MachineState *machine)
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       const MemMapEntry *memmap = ibex_memmap;
> @@ -108,17 +108,17 @@ static void opentitan_board_init(MachineState *machine)
>       }
>   }
>   
> -static void opentitan_machine_init(MachineClass *mc)
> +static void opentitan_machine_class_init(MachineClass *mc)
>   {
>       mc->desc = "RISC-V Board compatible with OpenTitan";
> -    mc->init = opentitan_board_init;
> +    mc->init = opentitan_machine_init;
>       mc->max_cpus = 1;
>       mc->default_cpu_type = TYPE_RISCV_CPU_IBEX;
>       mc->default_ram_id = "riscv.lowrisc.ibex.ram";
>       mc->default_ram_size = ibex_memmap[IBEX_DEV_RAM].size;
>   }
>   
> -DEFINE_MACHINE("opentitan", opentitan_machine_init)
> +DEFINE_MACHINE("opentitan", opentitan_machine_class_init)
>   
>   static void lowrisc_ibex_soc_init(Object *obj)
>   {


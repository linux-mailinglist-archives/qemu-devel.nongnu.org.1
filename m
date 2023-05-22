Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3417370BFB5
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:27:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15Yy-0007WZ-T7; Mon, 22 May 2023 09:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q15Yl-0007K4-5O
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:26:49 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q15Yi-0001ha-GD
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:26:46 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-552b65f527dso3432408eaf.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684762002; x=1687354002;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mz+eWTZ93sRG2v/WFnrN0Ma6v+wVFXzzxfeVL8F55bs=;
 b=RYUEAQ3IubLvQ26zfhkEAMqcEgKtsk1rNwj3yu8JdR2jiN5Nk3yEfYIF/Vo3IOV+0o
 TrrPFyfi8yFqort/0xksbd8XdvofY2NyEo0WPG3MK3e8XBdwHEUYyOMsa3GGsxIHnSgi
 qDYR5dMzNbPJO3445BEroMG9EJCPn3FMuk61AyVtWRlPlTmzPevFUbR5b8xjrbhUc+mo
 kAqJaUZQyyeCRxdQuf1Xi9ec7K4yoiA3LMbTesnHZx6t8LlzulVncI5aXDTPHr/gWHNd
 9frdWiuH3Rnx5ZQDWPNdUoUOHEQnj4xxJouXXgNn/yihSBLgJ7xPSAkRTG78k1+rYds0
 V/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684762002; x=1687354002;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mz+eWTZ93sRG2v/WFnrN0Ma6v+wVFXzzxfeVL8F55bs=;
 b=JNmJhR39eG0LltA36DJoq5vpSHulVV/XjD0mt7LmVXs0kFcfXnb4XVJQmOv7Ju5KQ1
 OK4jN+bRSXzyljOsea08vk2W5hAaSvHDdZ2pNjV+BawJ3s+bufm0Btxv/W+jb0WVqz6z
 KcFGx6lie1I7x8BI2eqQytJvTWgkIEyHLPK2I+aY0OPVnqQ3SqeMK1WEVXMF+O8Gj/CV
 hFIZSfnQUWzDTvsNp3vhRCYPsSIy1fPDEnqhN1Ca9YOd3KCDwEETyGXt1tGEkJHh6YrD
 CPFXFqC/s25B7iHI6X2U8mutIGWKUE2BJtLDfxMXsyqzty2u7CjpHl/MD1Pbif1Fk8KU
 YWjw==
X-Gm-Message-State: AC+VfDyt+b8x7lNC6KXsELui3GtoZe+kdXBsg2y08AW59yv7ob+Zin+E
 AAJrhNL9Do+zOSUnkdTo/O1jeg==
X-Google-Smtp-Source: ACHHUZ6A8ejp0V8S52peUcTuX/nsPjesZvoAlVrHhm28io61QLg5OWCBeE8yG/HINqiL/F0dUp9Opg==
X-Received: by 2002:a54:4809:0:b0:396:f06:8349 with SMTP id
 j9-20020a544809000000b003960f068349mr5730812oij.58.1684762002328; 
 Mon, 22 May 2023 06:26:42 -0700 (PDT)
Received: from [192.168.68.107] ([179.111.98.125])
 by smtp.gmail.com with ESMTPSA id
 k24-20020a056820017800b00552465a754esm2292149ood.44.2023.05.22.06.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 06:26:42 -0700 (PDT)
Message-ID: <d6897060-b744-802c-88df-afbe9ddf4301@ventanamicro.com>
Date: Mon, 22 May 2023 10:26:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/5] hw/riscv/opentitan: Add TYPE_OPENTITAN_MACHINE
 definition
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org
References: <20230520054510.68822-1-philmd@linaro.org>
 <20230520054510.68822-4-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230520054510.68822-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> QOM type names are usually defined as TYPE_FOO.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   include/hw/riscv/opentitan.h | 2 ++
>   hw/riscv/opentitan.c         | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
> index c40b05052a..fd70226ed8 100644
> --- a/include/hw/riscv/opentitan.h
> +++ b/include/hw/riscv/opentitan.h
> @@ -53,6 +53,8 @@ struct LowRISCIbexSoCState {
>       MemoryRegion flash_alias;
>   };
>   
> +#define TYPE_OPENTITAN_MACHINE "opentitan"
> +
>   typedef struct OpenTitanState {
>       /*< private >*/
>       SysBusDevice parent_obj;
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index 294955eeea..7d7159ea30 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -118,7 +118,7 @@ static void opentitan_machine_class_init(MachineClass *mc)
>       mc->default_ram_size = ibex_memmap[IBEX_DEV_RAM].size;
>   }
>   
> -DEFINE_MACHINE("opentitan", opentitan_machine_class_init)
> +DEFINE_MACHINE(TYPE_OPENTITAN_MACHINE, opentitan_machine_class_init)
>   
>   static void lowrisc_ibex_soc_init(Object *obj)
>   {


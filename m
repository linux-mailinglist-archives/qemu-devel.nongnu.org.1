Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AB6712415
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2U8W-0005nu-6o; Fri, 26 May 2023 05:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2U8U-0005nB-2j
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:53:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2U8R-0001fm-Ax
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:53:25 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6e68cc738so3808555e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 02:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685094800; x=1687686800;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cB3zr0suaBZGp6c80XgkJtn+TYwnAZf0InhhW2LNjXU=;
 b=beD0aup2vJspxnsLhLo55zd7ZJi3RwgVaaMxF6OcUlT5hVx2Vk7mCMc1nTXT8c7iz2
 Xkr8h8uZpG8bxUwjdDLX6RMWwKmlbLfmctj0oG50cuPt4X90peYbhTOgR+veYeB1hua8
 ScObKPjD89no4kF7tWHSVyyj+qUmMmi2Yuebs6cgWYC5hHtIQ6LagWHQ2qGMj71c1oBC
 4q7YqUSveJ06HvHvtSrud5hC5tBL6pnvm4HXmFTDnLRY0kqTJyw/ZsAAzYni822wm9uv
 BjaDftqxSOiVJK4F3te+hKYjw+ETor8y5BI69A6ZywolaOf6PTBYApDrevRqWCe/CHjh
 xYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685094800; x=1687686800;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cB3zr0suaBZGp6c80XgkJtn+TYwnAZf0InhhW2LNjXU=;
 b=P8B04y8iG4OkoqBUpxmbFx68Uj3TNTDvKmV2ieuf9b6ovDkHFXNwCqDmEHTJ5aLgSM
 9fIqvpVDgFS/FaIiP1//hJIxIXaZXOwCLa86EHRTfzVhH9M1reC4eMAzAPBUPs0DvhER
 q8PZ8GcYzczCrRiGD8iCSWqKVs+O+BtR60SON/y/y2UvSpuZOfjutuIgOBEt7SCD8Kw4
 Q/vp6PlVeAIPYRlKO0CiOrvP9NqUINPgVX2zRmw5SQRlSLs0zmczTmKjuVvDQ5pUHe7i
 YoU8wC4+bxhyPsfCgcPW+38xcTNzMoof9QeaH5pVSrOoXdZrcRaDB7YeIO2qkZ93QscG
 xAUg==
X-Gm-Message-State: AC+VfDxFaIRrH68VtN5x9/DvJNsWmAkUO6OpnkrjjWfEWo/xjjvAzeSb
 IzIWJqnMbEq2bNv8JTTzI0Zbgw==
X-Google-Smtp-Source: ACHHUZ5QJBhpqwCWIdkLcfXUY7dNBYySpg4wLI5uwV7p+GpmR9T8x+9idlzHKJawVUZVwdxU1gfEwA==
X-Received: by 2002:a7b:c38a:0:b0:3f6:ffe:9ef1 with SMTP id
 s10-20020a7bc38a000000b003f60ffe9ef1mr1056375wmj.36.1685094800504; 
 Fri, 26 May 2023 02:53:20 -0700 (PDT)
Received: from [192.168.69.115] (vit94-h02-176-184-29-207.dsl.sta.abo.bbox.fr.
 [176.184.29.207]) by smtp.gmail.com with ESMTPSA id
 p26-20020a05600c205a00b003f4f1b884cdsm8141601wmg.36.2023.05.26.02.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 02:53:20 -0700 (PDT)
Message-ID: <dbfd6f2a-1ff4-7baf-8ff4-0d47a97f5ff4@linaro.org>
Date: Fri, 26 May 2023 11:53:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/3] riscv/virt: Support using pflash via -blockdev
 option
Content-Language: en-US
To: Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrea Bolognani <abologna@redhat.com>
References: <20230525164803.17992-1-sunilvl@ventanamicro.com>
 <20230525164803.17992-3-sunilvl@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230525164803.17992-3-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 25/5/23 18:48, Sunil V L wrote:
> Currently, pflash devices can be configured only via -pflash
> or if=pflash options. This is the legacy way and the
> better way is to use -blockdev as in other architectures.
> libvirt also has moved to -blockdev method.
> 
> To support -blockdev option, pflash devices need to be
> created in instance_init itself. So, update the code to
> move the virt_flash_create() to instance_init. Also, use
> standard interfaces to detect whether pflash0 is
> configured or not.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reported-by: Andrea Bolognani <abologna@redhat.com>
> ---
>   hw/riscv/virt.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)


> @@ -1265,21 +1267,22 @@ static void virt_machine_done(Notifier *notifier, void *data)
>   
>       firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
>                                                        start_addr, NULL);
> -
> -    if (drive_get(IF_PFLASH, 0, 0)) {
> +    pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
> +    if (pflash_blk0) {
> +        flash_mem = pflash_cfi01_get_memory(s->flash[0]);
>           if (machine->firmware && !strcmp(machine->firmware, "none")) {
>               /*
>                * Pflash was supplied but bios is none, let's overwrite the
>                * address we jump to after reset to the base of the flash.
>                */
> -            start_addr = virt_memmap[VIRT_FLASH].base;
> +            start_addr = flash_mem->addr;

I don't understand this change. Besides you access MemoryRegion::addr
which is an internal API field.

>           } else {
>               /*
>                * Pflash was supplied but bios is not none. In this case,
>                * base of the flash would contain S-mode payload.
>                */
>               riscv_setup_firmware_boot(machine);
> -            kernel_entry = virt_memmap[VIRT_FLASH].base;
> +            kernel_entry = flash_mem->addr;
>           }
>       }


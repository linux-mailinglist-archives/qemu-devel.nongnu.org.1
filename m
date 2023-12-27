Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF1381ED76
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 09:53:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIPeW-0004M5-MY; Wed, 27 Dec 2023 03:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIPeU-0004Lx-U0
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 03:52:34 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIPeT-00009C-3V
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 03:52:34 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a22f59c6ae6so606205566b.1
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 00:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703667151; x=1704271951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mB10JU0NvqSKBWw7ErbbmyIYhVKSXhagNjrJyT/0+OU=;
 b=uyAvQRZJYhQoow+aZLqUO5Wa0Q2Nenzwc/LjjYand3Nw0BE5hveaKAFXe8HzQmZZkW
 KtcmoZ0ZSlUkhKTx2JyOXHdiDi2V3pypXLsHO/mGLIWv1dtemSi2yu7fx5YFgRKUVkQB
 rQZKeBOcs1MnHLTTF97wRLIqyuqtZzEbQxAsT1e0kQSvPKPQVKyGwXIXM2CxDg4DeYaK
 cn6T0pYIef/sLv0xPKRvG30NdKyqtC9L7bRS7RyXIdDRidc9DPkAT4w3WOPyRSe3JNyC
 kr/XzTjKEQ3BDpf1O2DN+yS2u8uZXgF803G3EnItC+durvm+kXi4kn4Nb+/lV3Fgo00o
 lX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703667151; x=1704271951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mB10JU0NvqSKBWw7ErbbmyIYhVKSXhagNjrJyT/0+OU=;
 b=d7ReTbOkdp/WYlh985dHzr90oml/8Yk6t2yDsgqNI4bHtjcus3LOX1h2IR57onNEU9
 i3eq2O2qkZFkK3kP9M4vaDuCa3YpPwKcOFwx2MRLBAtCnnDQPReAnerlJ6ZjKkf3GATj
 2d4HmjhoqY3mCox1TlA7sjDpKUzApwMMAYk7PZZPKUA/4pApN4gAwuO6qQFuh61LXlgZ
 sqW1bUSD4I3igKD7dYCSLoJonz8zJQEjJT6+wY109V2eGcij6geV09wXnqjdaeqUk37B
 Cog1Po7Lm9raXNCLaKRUO4uYPOWeHoDqJ0yOCXDKx1MG9Wt3idOBaRtgNbA3L++X2j10
 0eBg==
X-Gm-Message-State: AOJu0YxVdfn2OuigmboKN+IL+HAgeQ7tpd75II49VRvEUNYgoYqKOdg9
 4UNucWYkC4Lj1fsMvf2wPZPuF1I5bn0nmdIeqDmeeoZfB17Fdg==
X-Google-Smtp-Source: AGHT+IHLcRIDRSfcs7H8AOFHWz8S3ibWY+eKE56btIQj3rG4lEwwcxRjOYOFSRv5PuX+AFBSe557lA==
X-Received: by 2002:a17:906:289:b0:a1f:5729:1044 with SMTP id
 9-20020a170906028900b00a1f57291044mr2178707ejf.278.1703667151306; 
 Wed, 27 Dec 2023 00:52:31 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.122])
 by smtp.gmail.com with ESMTPSA id
 qy25-20020a170907689900b00a2361104d5asm6377446ejc.221.2023.12.27.00.52.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 00:52:30 -0800 (PST)
Message-ID: <30753721-2f4f-4666-9717-48fcf4f136d9@linaro.org>
Date: Wed, 27 Dec 2023 09:52:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/17] hw/loongarch: Add slave cpu boot_code
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, maobibo@loongson.cn
References: <20231227080821.3216113-1-gaosong@loongson.cn>
 <20231227080821.3216113-4-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231227080821.3216113-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Hi,

On 27/12/23 09:08, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c | 71 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 3075c276d4..faff880153 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -14,6 +14,54 @@
>   #include "qemu/error-report.h"
>   #include "sysemu/reset.h"
>   
> +static unsigned int slave_boot_code[] = {

'const'

> +                  /* Configure reset ebase.         */
> +    0x0400302c,   /* csrwr      $r12,0xc            */
> +
> +                  /* Disable interrupt.             */
> +    0x0380100c,   /* ori        $r12,$r0,0x4        */
> +    0x04000180,   /* csrxchg    $r0,$r12,0x0        */
> +
> +                  /* Clear mailbox.                 */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
> +    0x06481da0,   /* iocsrwr.d  $r0,$r13            */
> +
> +                  /* Enable IPI interrupt.          */
> +    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
> +    0x0400118c,   /* csrxchg    $r12,$r12,0x4       */
> +    0x02fffc0c,   /* addi.d     $r12,$r0,-1(0xfff)  */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038011ad,   /* ori        $r13,$r13,0x4       */
> +    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
> +
> +                  /* Wait for wakeup  <.L11>:       */
> +    0x06488000,   /* idle       0x0                 */
> +    0x03400000,   /* andi       $r0,$r0,0x0         */
> +    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
> +    0x43fff59f,   /* beqz       $r12,-12(0x7ffff4) # 48 <.L11> */
> +
> +                  /* Read and clear IPI interrupt.  */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x064809ac,   /* iocsrrd.w  $r12,$r13           */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038031ad,   /* ori        $r13,$r13,0xc       */
> +    0x064819ac,   /* iocsrwr.w  $r12,$r13           */
> +
> +                  /* Disable  IPI interrupt.        */
> +    0x1400002c,   /* lu12i.w    $r12,1(0x1)         */
> +    0x04001180,   /* csrxchg    $r0,$r12,0x4        */
> +
> +                  /* Read mail buf and jump to specified entry */
> +    0x1400002d,   /* lu12i.w    $r13,1(0x1)         */
> +    0x038081ad,   /* ori        $r13,$r13,0x20      */
> +    0x06480dac,   /* iocsrrd.d  $r12,$r13           */
> +    0x00150181,   /* move       $r1,$r12            */
> +    0x4c000020,   /* jirl       $r0,$r1,0           */
> +};
> +
>   static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
>   {
>       return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
> @@ -110,11 +158,19 @@ static void loongarch_firmware_boot(LoongArchMachineState *lams,
>       fw_cfg_add_kernel_info(info, lams->fw_cfg);
>   }
>   
> +static void init_boot_rom(struct loongarch_boot_info *info, void *p)
> +{
> +    memcpy(p, &slave_boot_code, sizeof(slave_boot_code));
> +    p += sizeof(slave_boot_code);
> +}
> +
>   static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
>   {
> +    static void  *p;

Why 'static'?

>       int64_t kernel_addr = 0;
>       LoongArchCPU *lacpu;
>       CPUState *cs;
> +    void *bp;
>   
>       if (info->kernel_filename) {
>           kernel_addr = load_kernel_info(info);
> @@ -123,11 +179,24 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
>           exit(1);
>       }
>   
> +    /* Load 'boot_rom' at [0 - 1MiB] */
> +    p = g_malloc0(1 * MiB);
> +    bp = p;
> +    init_boot_rom(info, p);
> +    rom_add_blob_fixed("boot_rom", bp, 1 * MiB, 0);
> +
>       CPU_FOREACH(cs) {
>           lacpu = LOONGARCH_CPU(cs);
>           lacpu->env.load_elf = true;
> -        lacpu->env.elf_address = kernel_addr;
> +        if (cs == first_cpu) {
> +            lacpu->env.elf_address = kernel_addr;
> +        } else {
> +            lacpu->env.elf_address = 0;
> +        }
> +        lacpu->env.boot_info = info;
>       }
> +
> +    g_free(bp);

(besides, IIUC 'p' now points to released memory).

>   }
>   
>   void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)



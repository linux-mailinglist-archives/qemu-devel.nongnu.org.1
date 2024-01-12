Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC4882C7DB
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 00:12:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQgM-0001W0-DM; Fri, 12 Jan 2024 18:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOQgJ-0001Vd-1T
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 18:11:19 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOQgG-0007uu-MW
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 18:11:18 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3bd6581bca0so440029b6e.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 15:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705101074; x=1705705874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4r6ixZxrWTWNuQ2VzYakFVLcevMFcy6mRTel3i5MQn0=;
 b=mGso8vYUDEyahHPHSggpRDByDuQwEFItAT20g7MEhYUVnHlMYyUgC8TTZwa+jGUM0d
 9uvC8lMhlC62j1MvJ8BszfZNCKAfrXGKwBLpIOfU3s3gJ7+Ep7sPuLuCZECvmZCMBwf7
 n7K1N7daZRkEqMj6Q8Fq1eVaKJGe43yGXeZNIX4/M/9+qZkUosPrgv7KoaHjqVZzjSKL
 32nG0GBaZbQJbItXexBFFF266IGg1iSeqJI3dvbn8XTOfYhPNZgma4IX5mfGgIb8BX89
 OpzcEozdQQL1TWAgUXcy/sOqscLo1NbmgFf5c5u2hB7nkHcUNvhWLbQ0dq0HO1WCZJRd
 k0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705101074; x=1705705874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4r6ixZxrWTWNuQ2VzYakFVLcevMFcy6mRTel3i5MQn0=;
 b=VSI+4xwI+QJM7MxLBrzPzni3zatVICrHsmaj5pg9A+ENUqk0GsSDo982IGqyLO+qtW
 9jXMMJRAsAf1cpE3D5silnUyEF2G5WvBO8AUifboFsVXtUw1pQPVim+6GTfGDqaoWYda
 KDw1lr2Fcb77qakHg40EHOzKYlkyw1NzQVTwSehm6dctXNFbrmEVeIjL89dvp2jqVEN3
 mXkg/AR1J7CVFyet9NYgha/PmN2ZEKSpiCvE0kXCOHyfVETpoO/9/KHnbelRPQgGI7AC
 KgddoMMDLDAqWSBDqwRchrHA2SU2YpOSlkV2ehiFGKryAtooc+Fz2hNcYvjXdMiMgS2J
 Oydg==
X-Gm-Message-State: AOJu0YySDOWyb2qm5OTQB/XSiXkFhN253fmuJyfc3/+FItyEA94O4lJ5
 zehBVW4yOWCP6rc/86aM7k62OOeAiLAhIQ==
X-Google-Smtp-Source: AGHT+IG1B7EZJZfHifVqGlkYZZ6/mTqLYDWL9Il6sU4A0Etv2d8dQvTm45kmBl8JcGTkyvpoKzsoag==
X-Received: by 2002:a05:6808:640e:b0:3bd:6a95:ab6f with SMTP id
 fg14-20020a056808640e00b003bd6a95ab6fmr372492oib.28.1705101074680; 
 Fri, 12 Jan 2024 15:11:14 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 v3-20020aa78083000000b006d9b4303f9csm3655190pff.71.2024.01.12.15.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 15:11:14 -0800 (PST)
Message-ID: <f2b0458c-f793-4b9d-a0bf-c7af22aaf099@linaro.org>
Date: Sat, 13 Jan 2024 10:11:09 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] hw/hppa: Move software power button address back
 into PDC
Content-Language: en-US
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240112102927.35406-1-deller@kernel.org>
 <20240112102927.35406-6-deller@kernel.org>
 <477fa733-0957-4026-ac06-57d76d4b0388@linaro.org> <ZaHAwUC1V3WJpk5T@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZaHAwUC1V3WJpk5T@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 1/13/24 09:44, Helge Deller wrote:
>> I think it would be better to pass this as a parameter to create_fw_cfg, or
>> to drop the translated FW_CFG_IO_BASE parameter and merely pass in translate
>> itself.
> 
> Like this?
> 
> 
> The various operating systems (e.g. Linux, NetBSD) have issues
> mapping the power button when it's stored in page zero.
> NetBSD even crashes, because it fails to map that page and then
> accesses unmapped memory.
> 
> Since we now have a consistent memory mapping of PDC in 32-bit
> and 64-bit address space (the lower 32-bits of the address are in
> sync) the power button can be moved back to PDC space.
> 
> This patch fixes the power button on Linux, NetBSD and HP-UX.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Tested-by: Bruno Haible <bruno@clisp.org>
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 54ca2fd91a..da85050f60 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -36,8 +36,8 @@
>   
>   #define MIN_SEABIOS_HPPA_VERSION 12 /* require at least this fw version */
>   
> -/* Power button address at &PAGE0->pad[4] */
> -#define HPA_POWER_BUTTON (0x40 + 4 * sizeof(uint32_t))
> +#define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
> +static hwaddr soft_power_reg;

You've forgotten to remove the global.


r~

>   
>   #define enable_lasi_lan()       0
>   
> @@ -45,7 +45,6 @@ static DeviceState *lasi_dev;
>   
>   static void hppa_powerdown_req(Notifier *n, void *opaque)
>   {
> -    hwaddr soft_power_reg = HPA_POWER_BUTTON;
>       uint32_t val;
>   
>       val = ldl_be_phys(&address_space_memory, soft_power_reg);
> @@ -191,7 +190,7 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>   }
>   
>   static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
> -                                 hwaddr addr)
> +                                 hwaddr addr, hwaddr pwr_button_addr)
>   {
>       FWCfgState *fw_cfg;
>       uint64_t val;
> @@ -221,7 +220,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
>       fw_cfg_add_file(fw_cfg, "/etc/hppa/machine",
>                       g_memdup(mc->name, len), len);
>   
> -    val = cpu_to_le64(HPA_POWER_BUTTON);
> +    val = cpu_to_le64(pwr_button_addr);
>       fw_cfg_add_file(fw_cfg, "/etc/hppa/power-button-addr",
>                       g_memdup(&val, sizeof(val)), sizeof(val));
>   
> @@ -295,6 +294,8 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
>           ram_max = 0xf0000000;      /* 3.75 GB (32-bit CPU) */
>       }
>   
> +    soft_power_reg = translate(NULL, HPA_POWER_BUTTON);
> +
>       for (unsigned int i = 0; i < smp_cpus; i++) {
>           g_autofree char *name = g_strdup_printf("cpu%u-io-eir", i);
>   
> @@ -407,7 +408,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>       qemu_register_powerdown_notifier(&hppa_system_powerdown_notifier);
>   
>       /* fw_cfg configuration interface */
> -    create_fw_cfg(machine, pci_bus, translate(NULL, FW_CFG_IO_BASE));
> +    create_fw_cfg(machine, pci_bus, translate(NULL, FW_CFG_IO_BASE),
> +        translate(NULL, HPA_POWER_BUTTON));
>   
>       /* Load firmware.  Given that this is not "real" firmware,
>          but one explicitly written for the emulation, we might as



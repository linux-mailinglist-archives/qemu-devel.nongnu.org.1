Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C517CAA59
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:48:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsNxC-0006fl-QT; Mon, 16 Oct 2023 09:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsNxB-0006fY-GA
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:48:17 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsNx9-0004kQ-L4
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:48:17 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9bdf5829000so420369266b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697464094; x=1698068894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m++cGk8gAmSPxgQZ7WCoCEUhvru/pIABxgXWOSxujPw=;
 b=P2gtlIylWWXJjVTUQmoz/b1iDqHuOU3sbUhg+dmZ9FcGbbU/eHh1CZwst4Al69P7I/
 Fm66sy36tUzbKFXEzAKC3YQVzXF/n70q/7TQ2gdsU6exHmHGJNs6J0FEC/ZqEu93/suo
 fNG1fCxBj0L/c0IVGFyhVbv8A6ywWz5UWe8zxEBsKF3EKXftFRKlcwfPEoAKKU2ZI6Dk
 kcwSH8onNDl/HC8GtDWH82wgyszq9c/HUU8iQn/2sD1uce61h6JZzeAkDCk4M+794yiq
 huLj7NbkmyDjkgH0AWFcrXtFLjCavbbmLB+3Im7EEsfEpnjdWqP+WRCO2/aOgHCx8zvk
 Wgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697464094; x=1698068894;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m++cGk8gAmSPxgQZ7WCoCEUhvru/pIABxgXWOSxujPw=;
 b=S+Q1HkK7qE53g/fSZj40ut//0xscGsPYIuQFp5lCR8F+bkHCS3YePJ8AMLXKTt7p7C
 SG+HYjuavhYKdvKumGS5vCIoeehIZJZaopCdwXO5H0EkoDwKO21mKi92Vwvw4oW6JPpg
 cpKehtGktmIleFBMke0868zqyuQjskEMDT3JhlWVrKvBWNp3IAf9iEWmhmDlesSEopns
 pyLdH4RgS75aSqMveuB7gznaw67lrN+vLb5wvVMVUPY/RwfFaygff16VJ4IE7dbG2or2
 rB0XKYYCrZDt1kDCU+JRzPt8GRTyYJYgxqKAXm80XMtWK7P5sBHEwllhe8K7LtQiapeN
 /eSA==
X-Gm-Message-State: AOJu0YxzbhRydRSwbL4ogJtSPW8J+D25xZC5D4SKEnqnXzYc55LSQU+f
 uu87E4O4tYVsPZELNLxpuhZ2yJWnt0EIeP3rBgI=
X-Google-Smtp-Source: AGHT+IGNix6U5XFeGJfBlxUC4mqlr5h4WxHXAq5JBi8JUgBgb85Xcqd3cCnnD9l8xf8i+QtB0aCB7w==
X-Received: by 2002:a17:907:c0d:b0:9be:5ab2:73c0 with SMTP id
 ga13-20020a1709070c0d00b009be5ab273c0mr6767728ejc.8.1697464093836; 
 Mon, 16 Oct 2023 06:48:13 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-186.dsl.sta.abo.bbox.fr. [176.171.211.186])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a17090634ca00b009ae6a6451fdsm4113618ejb.35.2023.10.16.06.48.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 06:48:13 -0700 (PDT)
Message-ID: <74d29b49-6a95-55c2-9c0f-216c67197c3d@linaro.org>
Date: Mon, 16 Oct 2023 15:48:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 09/12] hw/hppa: Export machine name, BTLBs, power-button
 address via fw_cfg
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20231014195719.151397-1-deller@kernel.org>
 <20231014195719.151397-10-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231014195719.151397-10-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Helge,

On 14/10/23 21:57, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Provide necessary info to SeaBIOS-hppa.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   hw/hppa/machine.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index c6d8deffcf..be0caf4675 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -37,6 +37,7 @@
>   
>   #define enable_lasi_lan()       0
>   
> +static PCIBus *pci_bus;

I don't understand what this unassigned variable is doing here.

>   static void hppa_powerdown_req(Notifier *n, void *opaque)
>   {
> @@ -123,6 +124,8 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
>       FWCfgState *fw_cfg;
>       uint64_t val;
>       const char qemu_version[] = QEMU_VERSION;
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    int len;
>   
>       fw_cfg = fw_cfg_init_mem(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
> @@ -137,8 +140,20 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
>       fw_cfg_add_file(fw_cfg, "/etc/cpu/tlb_entries",
>                       g_memdup(&val, sizeof(val)), sizeof(val));
>   
> +    val = cpu_to_le64(HPPA_BTLB_ENTRIES);
> +    fw_cfg_add_file(fw_cfg, "/etc/cpu/btlb_entries",
> +                    g_memdup(&val, sizeof(val)), sizeof(val));
> +
> +    len = strlen(mc->name) + 1;
> +    fw_cfg_add_file(fw_cfg, "/etc/hppa/machine",
> +                    g_memdup(mc->name, len), len);
> +
>       val = cpu_to_le64(HPA_POWER_BUTTON);
> -    fw_cfg_add_file(fw_cfg, "/etc/power-button-addr",
> +    fw_cfg_add_file(fw_cfg, "/etc/hppa/power-button-addr",
> +                    g_memdup(&val, sizeof(val)), sizeof(val));
> +
> +    val = cpu_to_le64(CPU_HPA + 24);
> +    fw_cfg_add_file(fw_cfg, "/etc/hppa/DebugOutputPort",
>                       g_memdup(&val, sizeof(val)), sizeof(val));
>   
>       fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ms->boot_config.order[0]);
> @@ -148,6 +163,8 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
>                       g_memdup(qemu_version, sizeof(qemu_version)),
>                       sizeof(qemu_version));
>   
> +    fw_cfg_add_extra_pci_roots(pci_bus, fw_cfg);

IIUC you have a MachineState pointer, so you can resolve the bus
from there, or in all qomtree using:

   object_resolve_path_type("", TYPE_PCI_BUS, ...);

>       return fw_cfg;
>   }
>   



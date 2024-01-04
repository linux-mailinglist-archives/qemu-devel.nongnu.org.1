Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6989382468E
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:46:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQqc-0000hN-GV; Thu, 04 Jan 2024 11:45:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQqX-0000fo-3p
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:45:29 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQqU-00015u-NK
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:45:28 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2cd0d05838fso8394981fa.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704386724; x=1704991524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WWJ6WzWmsa8QNUilexY35zmIrgj3QC2FvoJSbFBddgo=;
 b=piv0CYJSn0vBHrWdt2ObdbzNrFC+h8sKZmR/7Ij0JX9+B+vlHUjsseXQHvTqczlwQk
 fWYoWf46I/Vvtr9I5RKgfw6e5iFRFHPdvvOK2CAzHPcV+4E5ReWKT/SfG9tAuyynxmRB
 u9u4HnyIIBa/4rD8jEmh/npmXKMJEvmnoIoAQFcGaZUy+cj/HmacqU+6rUXpxZh0Xrqq
 OrNf6aamS9iLxF61NvtXQLEhIPjjOwj4/EyUZtuojF31TgQXJ0XogEdpDf1Aiu2wLMX2
 r/S9mZcAh7mOqah1L0vKEX9Uw1yBbsa1xNqY8bYjRNbzvN3ghqjK1P8UEK4zzdAxgbLp
 fXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704386724; x=1704991524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WWJ6WzWmsa8QNUilexY35zmIrgj3QC2FvoJSbFBddgo=;
 b=FLvyAHWcqsHT3BQHzbreGImVoDdWN4AjjeIScSuNcLFsQWBkJgYDKYc+rMG3E0qBdr
 wtq03g9fv0OVUJaiNNn+kbdCt2pVvPl0aLXqQeLzZFiYS5TE33SUXAF8s1acBfHQn5i2
 cxEgr737Hw92529i/XJq8rHn1pr1DAVnZ7TQZxixTlugr+kNMmXJ9mcO0s5Ihuur6THo
 JiPfos6fdkNTcHdiDRgrK4TLQKQowz8epkWm64XzE+8MIdnKvFHH47389zajadGXlAmG
 vB1BfIuJ1nYoLtOGf2ijbJGN+U+ejo5F0B5G32SkS0NhDA2ZzzVK9TyydUlXP/bUGsQS
 qtZA==
X-Gm-Message-State: AOJu0YzShMNgLhAAvDJLJ0HZVtU4LWqI3RzHXE6b4GrbFBQz6GxbzrEk
 RwrFJ1HPGU5BAY+9ipMrnj8MdXySm6Ig4J6hGOdnLE1xZ/mjTw==
X-Google-Smtp-Source: AGHT+IFHa2kUtOOnNvHnHHNXzRxXnQj2Xflv+VYUm9WZ6KCXT9HXQEgQl1QKDpt0AU4tom/dVmXOKQ==
X-Received: by 2002:a2e:8816:0:b0:2cc:77b0:7655 with SMTP id
 x22-20020a2e8816000000b002cc77b07655mr475992ljh.8.1704386724287; 
 Thu, 04 Jan 2024 08:45:24 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 k24-20020a056402049800b00555e52fed52sm8110588edv.91.2024.01.04.08.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 08:45:23 -0800 (PST)
Message-ID: <eeba727d-c0a5-4973-af96-460fe16efbf6@linaro.org>
Date: Thu, 4 Jan 2024 17:45:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.0] hw/display/qxl: Directly use
 VGACommonState::vram_size
Content-Language: en-US
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20231124192216.96413-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231124192216.96413-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

+Paolo

On 24/11/23 20:22, Philippe Mathieu-Daudé wrote:
> PCIQXLDevice::vram_size seems to be some shadow of
> VGACommonState::vram_size. Just use the latter.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: I don't understand this field otherwise.
> ---
>   hw/display/qxl.h |  1 -
>   hw/display/qxl.c | 17 ++++++++---------
>   2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/display/qxl.h b/hw/display/qxl.h
> index fdac14edad..47463bd485 100644
> --- a/hw/display/qxl.h
> +++ b/hw/display/qxl.h
> @@ -102,7 +102,6 @@ struct PCIQXLDevice {
>       uint16_t           max_outputs;
>   
>       /* vram pci bar */
> -    uint64_t           vram_size;
>       MemoryRegion       vram_bar;
>       uint64_t           vram32_size;
>       MemoryRegion       vram32_bar;
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 7bb00d68f5..0e1c4efc0c 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -2067,20 +2067,19 @@ static void qxl_init_ramsize(PCIQXLDevice *qxl)
>   
>       /* vram (surfaces, 64bit, bar 4+5) */
>       if (qxl->vram_size_mb != -1) {
> -        qxl->vram_size = (uint64_t)qxl->vram_size_mb * MiB;
> +        qxl->vga.vram_size = (uint64_t)qxl->vram_size_mb * MiB;
>       }
> -    if (qxl->vram_size < qxl->vram32_size) {
> -        qxl->vram_size = qxl->vram32_size;
> +    if (qxl->vga.vram_size < qxl->vram32_size) {
> +        qxl->vga.vram_size = qxl->vram32_size;
>       }
>   
>       if (qxl->revision == 1) {
>           qxl->vram32_size = 4096;
> -        qxl->vram_size = 4096;
> +        qxl->vga.vram_size = 4096;
>       }
>       qxl->vgamem_size = pow2ceil(qxl->vgamem_size);
>       qxl->vga.vram_size = pow2ceil(qxl->vga.vram_size);
>       qxl->vram32_size = pow2ceil(qxl->vram32_size);
> -    qxl->vram_size = pow2ceil(qxl->vram_size);
>   }
>   
>   static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
> @@ -2135,7 +2134,7 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
>   
>       qxl->guest_surfaces.cmds = g_new0(QXLPHYSICAL, qxl->ssd.num_surfaces);
>       memory_region_init_ram(&qxl->vram_bar, OBJECT(qxl), "qxl.vram",
> -                           qxl->vram_size, &error_fatal);
> +                           qxl->vga.vram_size, &error_fatal);
>       memory_region_init_alias(&qxl->vram32_bar, OBJECT(qxl), "qxl.vram32",
>                                &qxl->vram_bar, 0, qxl->vram32_size);
>   
> @@ -2159,7 +2158,7 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
>       pci_register_bar(&qxl->pci, QXL_VRAM_RANGE_INDEX,
>                        PCI_BASE_ADDRESS_SPACE_MEMORY, &qxl->vram32_bar);
>   
> -    if (qxl->vram32_size < qxl->vram_size) {
> +    if (qxl->vram32_size < qxl->vga.vram_size) {
>           /*
>            * Make the 64bit vram bar show up only in case it is
>            * configured to be larger than the 32bit vram bar.
> @@ -2177,8 +2176,8 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
>       dprint(qxl, 1, "vram/32: %" PRIx64 " MB [region 1]\n",
>              qxl->vram32_size / MiB);
>       dprint(qxl, 1, "vram/64: %" PRIx64 " MB %s\n",
> -           qxl->vram_size / MiB,
> -           qxl->vram32_size < qxl->vram_size ? "[region 4]" : "[unmapped]");
> +           qxl->vga.vram_size / MiB,
> +           qxl->vram32_size < qxl->vga.vram_size ? "[region 4]" : "[unmapped]");
>   
>       qxl->ssd.qxl.base.sif = &qxl_interface.base;
>       if (qemu_spice_add_display_interface(&qxl->ssd.qxl, qxl->vga.con) != 0) {



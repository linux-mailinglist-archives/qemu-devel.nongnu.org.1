Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67266811B50
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:37:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDTAR-0006lF-To; Wed, 13 Dec 2023 12:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDTAQ-0006ix-3E
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:37:06 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDTAO-0003NB-BT
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:37:05 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-54c77e0835bso10075420a12.2
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 09:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702489022; x=1703093822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5vwRN1sNyZz3XfediGoZtixZNg586aWMaSs+/+7K2Qc=;
 b=ZIvt9WlfeZfGo3GeLJKpk3uK/4ADRXSAe0zzEPoMPafdNRSMpgiu990UsELf7EOi9l
 3LKyi7kNqKvWyPlz41iKAxp5hwaYCFuU8aoS7JxpRdtLgPLgE0ist1zo43rD1CPy8N+n
 Bn89PU64bbzYeAFZ44nfNcC3/bs+WvE0J4j0sQH3SEXVvsl3mVDyVp0kvjfv/e6kJSs+
 8gHKKxhs/nD+cSIdYomig6uLz9seNjvEgE1fV6EXWBDO9Db/dosEB7T+IEjFr1olppyX
 QAKFTdsLtkvJ9+fZ50Ts8YR9v2XUYaLQABIJpYo8GcmEgVygTUi7o7QZfHFGNF4vjsfk
 4EVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702489022; x=1703093822;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5vwRN1sNyZz3XfediGoZtixZNg586aWMaSs+/+7K2Qc=;
 b=h1sthUSAaml0IN4zc3aGWRJ4xicEEYwDB54KB3Hl0PA++RlwGpF0yZptPykc47bCuJ
 PIERyt4ZW0LERzF9z8t41QM3iGK2pu26GeXBpQwjTJDSjDGCxRbLVyW6Mo0pg9v0nLNG
 /pjPrl6dVChMb5CLPiOtr81RutHpAu2lz/1/AR3V/CwWXZYvpmctnCMx+plkAsFbCKKv
 gKj7I4O6rAIEoabhQXdztNoCe9OckD2M2vmpcOBKaz2QnadpEQCZZvNrcA7bhen171t9
 Tb+oMGy11z49NOXNvebL73kptGB8KqHPSZhzVh3Vmlf48VERzHEked/siAllbvdyBrsn
 y3pA==
X-Gm-Message-State: AOJu0YwXJbLeQGsMDUZVylG4axcOemuqVHlPOdcnbpzzKF981uQ7XwoT
 yK+GPcinjccel4KY4UdhqmHLkLJpy0lGtjr69VgHQQ==
X-Google-Smtp-Source: AGHT+IGqPuDhJJVMrMtN2lXKzV1lfC18lfoerlZP4qYHADcKaEvGhgxrTmtL3qK8oHKa5zPbRCnw7A==
X-Received: by 2002:a17:906:413:b0:a19:a19b:78bf with SMTP id
 d19-20020a170906041300b00a19a19b78bfmr4014149eja.130.1702489022530; 
 Wed, 13 Dec 2023 09:37:02 -0800 (PST)
Received: from [192.168.79.175] ([93.23.251.22])
 by smtp.gmail.com with ESMTPSA id
 vx12-20020a170907a78c00b00a1ddb5a2f7esm8203849ejc.60.2023.12.13.09.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 09:37:02 -0800 (PST)
Message-ID: <4d23f484-a5f3-47e2-a002-26249860f330@linaro.org>
Date: Wed, 13 Dec 2023 18:37:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.0] hw/display/qxl: Directly use
 VGACommonState::vram_size
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20231124192216.96413-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231124192216.96413-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

ping?

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



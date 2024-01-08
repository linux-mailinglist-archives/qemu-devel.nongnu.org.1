Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F36D826D59
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:02:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMoJq-0000un-Ut; Mon, 08 Jan 2024 07:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMoJa-0000sA-3F
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:01:10 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMoJW-00050a-KZ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:01:09 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e461c1f5cso10843695e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 04:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704715263; x=1705320063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=63hD7NV97qAtvHhrTepD1K2VRHp54OGg6fm+PARkOJA=;
 b=co+NdO9gJOfe6e1UHrxhMbWzYRBRJyqdFce5geal+PJQq7eV+l9mrnKyvnAjH7sap4
 7J145Dk6bKlpnE4XBM+mrmwLGHRK3yjofhtR0R8n3+v/oDcXhDzT5IHSjbMIdVFB1fWk
 j5YCVRIf4sfHn1YSnTaJ5PUOC3aQiEd958IhsA1HxnEVLXNrw/E9PbGxKmz8wsa23oM/
 208OHXAgILN85iOmLhyWVg/o4AZicPq3dqbmdwraEXrY0JC7mlpAEdtrEQkwGA3kRG/P
 iE+HEaQUcurcXjZ8wzTnl4hnBQe2dClO/KlVVLOfyss0R0DBHYVq1aPP+btC8C+eYgjd
 93dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704715263; x=1705320063;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=63hD7NV97qAtvHhrTepD1K2VRHp54OGg6fm+PARkOJA=;
 b=Bgj3+OxOBW65uhFoyP3xLQueHU/3FXduZIygbJVE4R3/tYD4cqt/uUfIkHAhbLpPf/
 RoBKGLq+sra/Cklwy9hQZbN/jiBqEf3qTPsAxvKSNO0d52m1aaCOBZuokr4n9UIBQgus
 K6/Ofj84xcfH7LN2hPtXwh9HrQLuHT65lZDOadEhzlwBarktfFnn/xiIk1TvhBCahteX
 U4ShO4pjIrRvVhLBVOCEVk/1zcmJgjyLwaRfE/JnoA9L2NiEE2Gzu0jkPsa1litLTPXi
 7hQhdRqBtTbxQZo8LBFFBT7eAowaSUbfwucqxP2zFACGIl3X9bsDS+kPROBmqry67Rwg
 PmQg==
X-Gm-Message-State: AOJu0YzkpOCeDIDmtRrs4PtbhjlmTBKiw1MJ0N91tGSPpSFG8PXiB/UU
 RijS1jaQkGXDH1NUwTk4HC/fdJai/u4ACw==
X-Google-Smtp-Source: AGHT+IGYojOe+hAnRcAD2P3QygCYYNiIsCXjQAF70e7PHo1BRGSBjuFBQ+ZDkGuCbbyhKOKikTXsPQ==
X-Received: by 2002:a05:600c:204f:b0:40d:9237:daf5 with SMTP id
 p15-20020a05600c204f00b0040d9237daf5mr1326268wmg.69.1704715262879; 
 Mon, 08 Jan 2024 04:01:02 -0800 (PST)
Received: from [192.168.1.102] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 d7-20020adfe2c7000000b00336d24b4847sm7613746wrj.114.2024.01.08.04.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 04:01:02 -0800 (PST)
Message-ID: <685bc632-4cdb-499e-a23a-584578792681@linaro.org>
Date: Mon, 8 Jan 2024 13:01:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nubus-device: round Declaration ROM memory region
 address to qemu_target_page_size()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
References: <20240107212538.227627-1-mark.cave-ayland@ilande.co.uk>
 <20240107212538.227627-2-mark.cave-ayland@ilande.co.uk>
Cc: laurent@vivier.eu, elliotnunn@fastmail.com, qemu-devel@nongnu.org
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240107212538.227627-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 7/1/24 22:25, Mark Cave-Ayland wrote:
> Declaration ROM binary images can be any arbitrary size, however if a host ROM
> memory region is not aligned to qemu_target_page_size() then we fail the
> "assert(!(iotlb & ~TARGET_PAGE_MASK))" check in tlb_set_page_full().

IIUC this isn't specific to NuBus but to any ROM used to execute code
in place.

Shouldn't this be handled in memory_region_init_rom()?

> Ensure that the host ROM memory region is aligned to qemu_target_page_size()
> and adjust the offset at which the Declaration ROM image is loaded so that the
> image is still aligned to the end of the Nubus slot.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/nubus/nubus-device.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
> index 49008e4938..e4f824d58b 100644
> --- a/hw/nubus/nubus-device.c
> +++ b/hw/nubus/nubus-device.c
> @@ -10,6 +10,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/datadir.h"
> +#include "exec/target_page.h"
>   #include "hw/irq.h"
>   #include "hw/loader.h"
>   #include "hw/nubus/nubus.h"
> @@ -30,7 +31,7 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
>       NubusDevice *nd = NUBUS_DEVICE(dev);
>       char *name, *path;
>       hwaddr slot_offset;
> -    int64_t size;
> +    int64_t size, align_size;
>       int ret;
>   
>       /* Super */
> @@ -76,16 +77,23 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
>           }
>   
>           name = g_strdup_printf("nubus-slot-%x-declaration-rom", nd->slot);
> -        memory_region_init_rom(&nd->decl_rom, OBJECT(dev), name, size,
> +
> +        /*
> +         * Ensure ROM memory region is aligned to target page size regardless
> +         * of the size of the Declaration ROM image
> +         */
> +        align_size = ROUND_UP(size, qemu_target_page_size());
> +        memory_region_init_rom(&nd->decl_rom, OBJECT(dev), name, align_size,
>                                  &error_abort);
> -        ret = load_image_mr(path, &nd->decl_rom);
> +        ret = load_image_size(path, memory_region_get_ram_ptr(&nd->decl_rom) +
> +                                    (uintptr_t)align_size - size, size);
>           g_free(path);
>           g_free(name);
>           if (ret < 0) {
>               error_setg(errp, "could not load romfile \"%s\"", nd->romfile);
>               return;
>           }
> -        memory_region_add_subregion(&nd->slot_mem, NUBUS_SLOT_SIZE - size,
> +        memory_region_add_subregion(&nd->slot_mem, NUBUS_SLOT_SIZE - align_size,
>                                       &nd->decl_rom);
>       }
>   }



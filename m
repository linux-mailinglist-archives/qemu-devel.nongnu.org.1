Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DED4827B4E
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 00:08:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMyhw-0007EA-Fi; Mon, 08 Jan 2024 18:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMyhu-0007Dy-AW
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:06:58 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMyhs-0003U7-88
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:06:58 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33765009941so1964002f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 15:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704755214; x=1705360014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QB4QWbe+SnCKOBCfZZ36siCOYNJ+x05fBJlGSyx1J8E=;
 b=GnfLyti9NBr8MABh/Efe2CqCfArzN5HE8XbuYQtD+i1SURbONCWrgYYknN5ffTshDD
 ELee0aNDaQBgLFwnkT8is5wrToDPuDBFAj9W/RPlJvLFlbF9BBM8cFMKhrchidQhUhNq
 KJxF6N8fFTNQaE0rcqqSvrsOmas1Snfi1m/fIrbdUqdHoerhIYf1eY8ktw+4aRNmnS9Q
 8siap4IdlVvpaIehLf1DA0kBoJgvITuaPLBCIulDgFpo+UCQLPdlLO6Z8uVdj04t+cIj
 v3O2+avF/gFTrzY/HIxczXKjNHeDLPeyVer+x4yDbywSshz7CmF2004zHa9Q8ch7fhFN
 tqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704755214; x=1705360014;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QB4QWbe+SnCKOBCfZZ36siCOYNJ+x05fBJlGSyx1J8E=;
 b=g91u+cbCe1Gs5wfur8bQX8Er8P4B/KXdAaa+LWynzSZtaF2oJSgeSWEFU75gX/QnBZ
 MFb9aHovBDpW2YSauCrDqV7lg7fIFIxzkQtYwYqn1V0lq7Aqd3Hx+0lg/oQkcUv6cbI/
 p58oEe2PivNByy6RKLkAyAhuqKrBYsDGWvKrCOXAfXQeQeNeyemnE9zPpVqVNUNgmIDW
 t9M/xIMIYuk8TGGEBv3hiQeg3XzU4zb7gIOAuT3jiMNIaPWeIiEiPDUzBWHcKFUobvsv
 Gd9auTuP/A+NoKS5PrOtYnuP1wNnI/sOnhTbBFcTkVE4ANYvrEBNQ9IUVKx1VpnoKKxN
 /FOg==
X-Gm-Message-State: AOJu0Yx6oYPsAgTwfmxAPE/hNAxqibUNyKXt870mdPFnh7PEfS422A8+
 GGeSB/IZuZSowTPMvFtOcTeCyK0Xzq9kn93LAWKl6d/ceuo=
X-Google-Smtp-Source: AGHT+IGswbOYh/3sjRPNeDWGE8xxKjcjO3sn1j6CEhuoKbzI3xZ3lRkKe3x7Rl08E/Ncl/qIdnHeYQ==
X-Received: by 2002:a05:6000:1d99:b0:336:79df:6c35 with SMTP id
 bk25-20020a0560001d9900b0033679df6c35mr81520wrb.12.1704755214393; 
 Mon, 08 Jan 2024 15:06:54 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.16])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a5d4488000000b00337464bf71bsm778336wrq.39.2024.01.08.15.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 15:06:53 -0800 (PST)
Message-ID: <cc1c2370-e516-478b-abfa-620cc8542118@linaro.org>
Date: Tue, 9 Jan 2024 00:06:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nubus-device: round Declaration ROM memory region
 address to qemu_target_page_size()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org, elliotnunn@fastmail.com
References: <20240108192013.272112-1-mark.cave-ayland@ilande.co.uk>
 <20240108192013.272112-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240108192013.272112-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 8/1/24 20:20, Mark Cave-Ayland wrote:
> Declaration ROM binary images can be any arbitrary size, however if a host ROM
> memory region is not aligned to qemu_target_page_size() then we fail the
> "assert(!(iotlb & ~TARGET_PAGE_MASK))" check in tlb_set_page_full().
> 
> Ensure that the host ROM memory region is aligned to qemu_target_page_size()
> and adjust the offset at which the Declaration ROM image is loaded, since Nubus
> ROM images are unusual in that they are aligned to the end of the slot address
> space.
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

Both are 'size_t'.

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

memory_region_get_ram_ptr() returns a 'void *' so this looks dubious.
Maybe use a local variable to ease offset calculation?

   char *rombase = memory_region_get_ram_ptr(&nd->decl_rom);
   ret = load_image_size(path, rombase + align_size - size, size);

Otherwise KISS but ugly:

   ret = load_image_size(path,
             (void *)((uintptr_t)memory_region_get_ram_ptr(&nd->decl_rom)
                      + align_size - size), size);

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



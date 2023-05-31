Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AC57183E5
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:53:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MG1-0000de-0X; Wed, 31 May 2023 09:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MFt-0000a5-3f
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:52:51 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MFr-0003lA-Hc
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:52:48 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30ae69ef78aso807623f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685541166; x=1688133166;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mxaN/mnJ2+p8DEoJGWciFkl2+RzlfuBDLxIn7HDRd9c=;
 b=G+NpGEsyGRaxpSZLAL/OtnwCeAqZ2vX2tSP70AcMKKzwATCB6dewirtDX2DtRIUg2C
 J/0Yz+Th3E/TwqnOu/0ccpDivHYsc2l1np1A1TnLLtB/4JDLWD4Bh2dFBYLzRBuQJb1M
 HI9C2sbA1yNmBflE0fB2TPzvNZwU044OB0BPyt+mKn2MSHW9TOS2ldbHnmRG3a/iBOCv
 u8L2mvzpCwxP1O0P6OvtK9VnX2lpYqiqkdWH7XV8N0kg6vXI1Orqom7KoVd0QzFHc+V/
 a5F6lGU351Jjt5hCSpEDgCTttB0Ar4r7zV8Xoe0Kufu5uu8fdKDwZENR5pNSw9wp/9Zz
 n85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685541166; x=1688133166;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mxaN/mnJ2+p8DEoJGWciFkl2+RzlfuBDLxIn7HDRd9c=;
 b=OlJ9+W5mCV+NiPM8L+uMFOghZakcZ294+jNFfXSXdJecQL6/GGxYLE++ucA2xzdpUS
 rOa1pn5fWa4I9wmLIrQ1l7ZSGJkGJRXhE/RVslgNjjwwIclkdsDDxxktILUbxipIkUD3
 1zr9dOzATn5SLka4nLNQnQFhxYohhI9Yizq+KXK37RA5UCgB15I/OwoN+Yfzxt1uk4UV
 20c2+z8VFoGsx1Ow2O6Mt+nzgjhtIIiAAq+umW7BayZup7Su6M/4YkjZHQTUvMuvteI7
 INy7KJzvBYQl0NgyC2y3Y6/9BbXaBaoIEb2tXqbgs2tvLITGmTTuzKWcKV949b04hVUQ
 ILlg==
X-Gm-Message-State: AC+VfDxMlprmP1QPe0KrtJT6v9S92WGuzWPbYRkdoH1jbuimVfG0I2r4
 h3BVSyrycZ3QR5B1l9tUJ0i7Hw==
X-Google-Smtp-Source: ACHHUZ5ynIyvlw2j0NYLJ7AiwvaDYQv1kYf7xBMd8wyXK8dj51UYbnPKAoz+A1PN75bOx4rx4J+zjQ==
X-Received: by 2002:a5d:5966:0:b0:2f0:583:44be with SMTP id
 e38-20020a5d5966000000b002f0058344bemr4450533wri.0.1685541165956; 
 Wed, 31 May 2023 06:52:45 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a5d4d87000000b0030af8da022dsm4012966wru.44.2023.05.31.06.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:52:45 -0700 (PDT)
Message-ID: <694a19ea-226e-7e69-3dad-9cb9f16cd387@linaro.org>
Date: Wed, 31 May 2023 15:52:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 19/23] q800: move mac-nubus-bridge device to
 Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-20-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-20-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> Also change the instantiation of the mac-nubus-bridge device to use
> object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 5 ++++-
>   include/hw/m68k/q800.h | 2 ++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index f85ccf83af..d02a1a7a1f 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -416,7 +416,10 @@ static void q800_machine_init(MachineState *machine)
>   
>       /* NuBus */
>   
> -    dev = qdev_new(TYPE_MAC_NUBUS_BRIDGE);
> +    object_initialize_child(OBJECT(machine), "mac-nubus-bridge",
> +                            &m->mac_nubus_bridge,
> +                            TYPE_MAC_NUBUS_BRIDGE);
> +    dev = DEVICE(&m->mac_nubus_bridge);
>       qdev_prop_set_uint32(dev, "slot-available-mask",
>                            Q800_NUBUS_SLOTS_AVAILABLE);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);

No need to unref(), right?

> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index ce8dbcd68f..3f3e87b3dc 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -30,6 +30,7 @@
>   #include "hw/or-irq.h"
>   #include "hw/scsi/esp.h"
>   #include "hw/block/swim.h"
> +#include "hw/nubus/mac-nubus-bridge.h"
>   
>   /*
>    * The main Q800 machine
> @@ -48,6 +49,7 @@ struct Q800MachineState {
>       OrIRQState escc_orgate;
>       SysBusESPState esp;
>       Swim swim;
> +    MacNubusBridge mac_nubus_bridge;
>       MemoryRegion macio;
>       MemoryRegion macio_alias;
>   };



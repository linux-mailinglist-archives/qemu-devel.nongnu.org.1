Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E222479FC45
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:45:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgg4p-0003Wb-0q; Thu, 14 Sep 2023 02:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgg4d-0003Uf-Ol
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:43:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgg4Z-0006qJ-Ea
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:43:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-404539209ffso2691565e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 23:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694673809; x=1695278609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0c0RdhxjT9fw3zfg4l4zqfkSQr52Mx0YOhxeNDT5qb8=;
 b=XWrKcIFzaFBU8jYxvsb67zPtOC+OzcNES5frrfiSDEXFSgGNfinfh4rlU0VOCDEnXN
 dP5u60zPfiumkypMjBUHbcRy4PSdlwm6mA7FTt2p4iqqu82vqj6jBGoL/Db9OVqUEAVC
 +aIeBj3tLGIqucsp1B4K2aASmPDZFCAi6T9QT5l2VnM5z3xsb/ZpLfW2/LGmWHFTRC2s
 yvntC7p7/6PnzuWT9oQirx9h6JLvT/PyA9EUIJ27pr6bWe36UggroddO/KmUL5+IrwA1
 alXPAZTuqECB5c9PhUq+azNj5suASKfWf23a0WQRhP8TPSiRrWkgJsPfS3623V/iGFOb
 kJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694673809; x=1695278609;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0c0RdhxjT9fw3zfg4l4zqfkSQr52Mx0YOhxeNDT5qb8=;
 b=xUCfQSewtOCPChMWRfG22XT/4DEZfuo1xWFGj4utm9yD/sJMr1FwylOolP9bCsZoiK
 tD2a8Or3GVpzjzezemmhldEj2khML8OqoxMyii3pemR2VaZbWZRGUVvTtlYEeFoM2WsX
 egHTKhc7FbynbRS+Hn4TSdMXfWdh+i2D2L5ZjRjcYb06Z0N1tlufxaRe7FmdUNtcP5EA
 x9j94sMOY3Nu4D2cPsUEZGic6SXHCT4rlAnjb2SxSzaAC9LN0DiYyYOLkUm/4UCaIduy
 deSMClbYK0d1hPeXxZmnTZOIFHxolYhsKi/mfmroyPV8g82qNqxGt3I0Qn5C4Ie4iI2w
 0FgA==
X-Gm-Message-State: AOJu0YxsXW2mvgKDZ1caOqcUlAsGChcJlz359SeBdIZbijzGMQwE/I5s
 4hByp0UZ2N/UxmTDdmVJZSG7FQ==
X-Google-Smtp-Source: AGHT+IG2VFpDUqYn3lGBsLZurKj7+msGQWMiUAbNcr/X9hur1uv4sdY7azS2/yDJGwAnWySGTIX1ig==
X-Received: by 2002:a7b:cbc8:0:b0:3fe:111a:d1d9 with SMTP id
 n8-20020a7bcbc8000000b003fe111ad1d9mr3989932wmi.25.1694673809498; 
 Wed, 13 Sep 2023 23:43:29 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 t11-20020a1c770b000000b003fc04d13242sm3905804wmi.0.2023.09.13.23.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 23:43:28 -0700 (PDT)
Message-ID: <8fe21876-be8c-22ba-ac91-78e8d014acf7@linaro.org>
Date: Thu, 14 Sep 2023 08:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] esp: use correct type for esp_dma_enable() in
 sysbus_esp_gpio_demux()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, qemu-devel@nongnu.org
References: <20230913204410.65650-1-mark.cave-ayland@ilande.co.uk>
 <20230913204410.65650-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230913204410.65650-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 13/9/23 22:44, Mark Cave-Ayland wrote:
> The call to esp_dma_enable() was being made with the SYSBUS_ESP type instead of
> the ESP type. This meant that when GPIO 1 was being used to trigger a DMA
> request from an external DMA controller, the setting of ESPState's dma_enabled
> field would clobber unknown memory whilst the dma_cb callback pointer would
> typically return NULL so the DMA request would never start.
> 

Cc: qemu-stable@nongnu.org
Fixes: a391fdbc7f ("esp: split esp code into generic chip emulation and 
sysbus layer")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index e52188d022..4218a6a960 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -1395,7 +1395,7 @@ static void sysbus_esp_gpio_demux(void *opaque, int irq, int level)
>           parent_esp_reset(s, irq, level);
>           break;
>       case 1:
> -        esp_dma_enable(opaque, irq, level);
> +        esp_dma_enable(s, irq, level);
>           break;
>       }
>   }



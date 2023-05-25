Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BB17112FA
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 19:59:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FE7-0002Om-J0; Thu, 25 May 2023 13:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2FE5-0002NV-HM
 for qemu-devel@nongnu.org; Thu, 25 May 2023 13:58:13 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2FE3-0002NR-I8
 for qemu-devel@nongnu.org; Thu, 25 May 2023 13:58:13 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-309550d4f73so986834f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685037489; x=1687629489;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2JVT+kc6UWaLkLbQHTU0GmzVy0hhDpI/SkYTipoY5A4=;
 b=F3opaujsktw87CGkUArW6VsDLqg2cIp1+pj+n5/tBF7kqL+w+mEOOpd/JZy+bRZaok
 doOuSzZXGndfT+YVYkOSxukK8o81JfU/qwAkzNFueMYv2XZ5caLxUyiRWtCYtadkFOBh
 5MA3Lw3NG7+HvPx12/mg7MoaZCUqHJQId/lemgvEeriaDGi+Dnrh3SGAVHKMm1q61xA1
 SDR96+38A8GgWk3Rv8LluOhSwCT02JHpthjJQ4XGIiwP6UZ+UVYMkyLZgVTSAHrWF6Lm
 e7Gs44NWs5mI45tX7WTqVZuxKMuPLMVXxlv/Ohp7gaRNJQWOTI9QtNxgDAAmzGvejP+x
 n5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685037489; x=1687629489;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2JVT+kc6UWaLkLbQHTU0GmzVy0hhDpI/SkYTipoY5A4=;
 b=lVPfsZsACuRNYY0TDb6o5woS2TiXdMtuivgZ9Vs9vMe4scByc4oSjgK8s77pcTWI1w
 zYFovSlAChPm2jg6qH6QblkaGAc7kEb+hBeP9KbZWmMQfSNB9nqUMymlpMpH/CtnycSH
 NirsVbLnYBJ7qWc2bjyqS8AzxND3epk6LjRQPi3hop/2uoVmZi3PNnwq9Z26MayHybWx
 fT6bbaN4wTo+yw7N2zFwYkZWbj9JXFo84hz3eZrZ7lC3rKKO2CJ668JnEr6UIx4ZJgUk
 dxyn+FkOce59dgEyyGw4uXibz6yHja/IxqoCBso26WzOBSaP+b/2y7tSY1Bv++yQY0LC
 NRKA==
X-Gm-Message-State: AC+VfDzUcP5C0zFKe93g5bx89Q41aGkFQxh0oOHFeTDZFGpIBdB4NyDl
 H6403AljsSF+WqBQANuYRNhfAg==
X-Google-Smtp-Source: ACHHUZ6DEpga8umq4nXa5OinHFCGdL9c5rClbwJSooedrsYMSdrygnCDaXqpMfoMkgkZUvdteyITIg==
X-Received: by 2002:a5d:5185:0:b0:30a:c5dc:6c47 with SMTP id
 k5-20020a5d5185000000b0030ac5dc6c47mr1681418wrv.34.1685037489630; 
 Thu, 25 May 2023 10:58:09 -0700 (PDT)
Received: from [192.168.69.115] (cor91-h02-176-184-30-254.dsl.sta.abo.bbox.fr.
 [176.184.30.254]) by smtp.gmail.com with ESMTPSA id
 e16-20020a5d5950000000b003078cd719ffsm2481889wri.95.2023.05.25.10.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 10:58:09 -0700 (PDT)
Message-ID: <2a8469e0-760a-356c-0f61-bc3aa705f1d1@linaro.org>
Date: Thu, 25 May 2023 19:58:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 18/30] swim: add trace events for IWM and ISM registers
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-19-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230524211104.686087-19-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 24/5/23 23:10, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/block/swim.c       | 14 ++++++++++++++
>   hw/block/trace-events |  7 +++++++
>   2 files changed, 21 insertions(+)


> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 34be8b9135..c041ec45e3 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -90,3 +90,10 @@ m25p80_read_data(void *s, uint32_t pos, uint8_t v) "[%p] Read data 0x%"PRIx32"=0
>   m25p80_read_sfdp(void *s, uint32_t addr, uint8_t v) "[%p] Read SFDP 0x%"PRIx32"=0x%"PRIx8
>   m25p80_binding(void *s) "[%p] Binding to IF_MTD drive"
>   m25p80_binding_no_bdrv(void *s) "[%p] No BDRV - binding to RAM"
> +
> +# swim.c
> +swim_swimctrl_read(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
> +swim_swimctrl_write(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
> +swim_iwmctrl_read(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64
> +swim_iwmctrl_write(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64

Preferably 'unsigned reg', otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




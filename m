Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE77745665
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:50:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEK8-0007J1-2w; Mon, 03 Jul 2023 03:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGEK5-0007Ic-Bq
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:50:14 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGEK3-0008Lu-H8
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:50:13 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99364ae9596so99941766b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688370609; x=1690962609;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=149K1InlJpzNKUIw2KcSnQF/UGq7hBqdJOZiL31Xjjc=;
 b=rGBzo47GUgReh0FEyuL6Ls1SQD/KQCTrGEHDkkeemRZQ9rxcMl8qSQ2IxjozXWM2vr
 eK8auJvmBToOSLHBKxpD4+A4jeSaGIHvPibf2tLM+AsUe6Jwblw5H2ban5TOwkIEIjLf
 wLjsxEOw32g34ndVLMRfBR202RXT1zouCgTk2e5uW+kes+ajA/jcIfrmB7zZDwkB3jC4
 x4ez1bpFv2YmUXgn+z/EHjtguIvR72rqUYfQ+is8Lx5JfrjO5TkCIqLhWMOUibMwQHeh
 k7MKnVa+kgarTKSJ/rR5xpAvYpz8cQY4yN9eaIMZNAYIN4K2vsBz84PX/keGAQTfpsW7
 pLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688370609; x=1690962609;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=149K1InlJpzNKUIw2KcSnQF/UGq7hBqdJOZiL31Xjjc=;
 b=PNj74MaikS7L/XW3EQ0ikfzEKvpDRThVimSyt/cohUhSuSP3ihtXYJDS3n0PFWgaCD
 6Rd98u7uc4U6WcRXPu70hXlCcqnkrAiYCyZaifxIp6/tdrbk0zTJLIpVHl0tIAkgOQiw
 ewgkTm5mwpQELmsT9ByoPJkN1r/VPSbohNzDKBKfHPfdT08LSVP/4DEjCQ01G7H0VgqW
 L2/kN7jTYCh0RwLxYd4mlgmsltznGIU6b1qSbTpWiZuyjazO0areaM9k1RLSoFjqZh2X
 tlnPLDdyHCpzlS68vCBWpFqcTpj1ZzsKMFjStAtRUeSNizKkoNlZ9NV+V+xbBzW2K6sD
 g2mw==
X-Gm-Message-State: ABy/qLYZpgturh71pBCEZ3QDPA634RqzZLs2o+cdoD12/y7p/MAf79FB
 le2ZI7O/FhBeUJcLoSOsTM3jww==
X-Google-Smtp-Source: APBJJlG4lHOBJaT5em8fXC6Rko+6RmiECgxF6LSZIudrrP2Th90a4Q5iJsU/nIGT7Zi0PchXDnh6gg==
X-Received: by 2002:a17:906:ae51:b0:966:471c:2565 with SMTP id
 lf17-20020a170906ae5100b00966471c2565mr6285736ejb.48.1688370608903; 
 Mon, 03 Jul 2023 00:50:08 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 qx22-20020a170906fcd600b009931baa0d44sm3184596ejb.140.2023.07.03.00.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 00:50:08 -0700 (PDT)
Message-ID: <b01c1b87-83bf-cbc6-f223-149ca41520d0@linaro.org>
Date: Mon, 3 Jul 2023 09:50:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 03/21] q800: add machine id register
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-4-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230702154838.722809-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 2/7/23 17:48, Mark Cave-Ayland wrote:
> MacOS reads this address to identify the hardware.
> 
> This is a basic implementation returning the ID of Quadra 800.
> 
> Details:
> 
>    http://mess.redump.net/mess/driver_info/mac_technical_notes
> 
> "There are 3 ID schemes [...]
>   The third and most scalable is a machine ID register at 0x5ffffffc.
>   The top word must be 0xa55a to be valid. Then bits 15-11 are 0 for
>   consumer Macs, 1 for portables, 2 for high-end 68k, and 3 for high-end
>   PowerPC. Bit 10 is 1 if additional ID bits appear elsewhere (e.g. in VIA1).
>   The rest of the bits are a per-model identifier.
> 
>   Model                          Lower 16 bits of ID
> ...
>   Quadra/Centris 610/650/800     0x2BAD"
> 
> Co-developed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 29 +++++++++++++++++++++++++++++
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 30 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



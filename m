Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F156E745755
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:30:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEx1-0001F0-4Z; Mon, 03 Jul 2023 04:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGEwy-0001Eg-PQ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:30:24 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGEws-0008Jo-IW
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:30:24 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-98de21518fbso471980366b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 01:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688373016; x=1690965016;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vpgbUviu618QmLVwAVgqRqxnyhSynTZEc6pbEDidceA=;
 b=qKDIscCuUtnn342rkCStl8RXW53XFbw2Wd4GQkgO+CY7oZMP7dpoVYjOtfAk2SzBs/
 n8QpL0OIApXsqmECRYbtwKyzjJwTKsLaknnv/kqekGV1mz1kVZFG/Qj3dFOQTCBFeBf9
 /oqmT9Sn6jjCvJl4a3k7XLTzTP1FdHbwcU7ID9j/O9tO9c7m2Xel50YN9qrXGya6s1ce
 LCwKYgYnogOTI50uELdJAmvTtywgVl+3xquY7Kzu6m6QdxYkMuZii0z1RleXMbuMF8mL
 2Q9pYneuu/PwzYtv6WXSajeH1ubLOkE41sah96Bu53aRb6uQlyGWvGg/qS/bWYDWaa0/
 I+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688373016; x=1690965016;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vpgbUviu618QmLVwAVgqRqxnyhSynTZEc6pbEDidceA=;
 b=BD79uHdIbT+hSGLhNqNncbQFMz/fA+BTZ5qYlRUIiX6KqLQ3mp2S9kYVrtkbpUPNbG
 iTWDgtOUIQjYkvIzKRK2g6DqAe/wmk+KtIYFzy5E6B0ePcuaPgwBuaqNK8tRtIbylGuJ
 aJ13lBvvmRdEa7CwaYkkbUXcTxNKVezZY4xV6yxfj1a0+FTOos2Fo1Ktj6fkPIoBRkhf
 03UMKyLnzig83LiV1ew1o5IRsxm8vumrvvjJGSGHHlTPKfs7aPYPRvBJ/VSFL3MbS2uS
 FTcsWtJ/qRL1sWeDwtKg5MRE59ZMpBo77N4pRrzRsmWha6CCtTxPbLm8CqTMR1PHSba1
 veEQ==
X-Gm-Message-State: ABy/qLaQBFbZcCO/+Mbw29E4pfGQJiv0vqtfokmpagh4A/83pwqbqvvD
 P7mOtE9iLONv/+gFiTsYocg0Tg==
X-Google-Smtp-Source: APBJJlEhttGwYIWxNGhPsyJ5hAQHLYIV+4VZalpKrn2aQ5LdX9KUEX45fnWP+XgaA+Js/sz6/YKAsg==
X-Received: by 2002:a17:906:af79:b0:992:4250:5462 with SMTP id
 os25-20020a170906af7900b0099242505462mr7062095ejb.50.1688373016557; 
 Mon, 03 Jul 2023 01:30:16 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 jo19-20020a170906f6d300b00992d70f8078sm4499472ejb.106.2023.07.03.01.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 01:30:16 -0700 (PDT)
Message-ID: <13c93212-0dc4-b7f6-0e29-eb8753f30801@linaro.org>
Date: Mon, 3 Jul 2023 10:30:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 14/21] mac_via: work around underflow in TimeDBRA timing
 loop in SETUPTIMEK
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-15-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230702154838.722809-15-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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
> The MacOS toolbox ROM calculates the number of branches that can be executed
> per millisecond as part of its timer calibration. Since modern hosts are
> considerably quicker than original hardware, the negative counter reaches zero
> before the calibration completes leading to division by zero later in
> CALCULATESLOD.
> 
> Instead of trying to fudge the timing loop (which won't work for TimeDBRA/TimeSCCDB
> anyhow), use the pattern of access to the VIA1 registers to detect when SETUPTIMEK
> has finished executing and write some well-known good timer values to TimeDBRA
> and TimeSCCDB taken from real hardware with a suitable scaling factor.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/misc/mac_via.c         | 115 ++++++++++++++++++++++++++++++++++++++
>   hw/misc/trace-events      |   1 +
>   include/hw/misc/mac_via.h |   3 +
>   3 files changed, 119 insertions(+)
> 
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index baeb73eeb3..766a32a95d 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -16,6 +16,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "exec/address-spaces.h"
>   #include "migration/vmstate.h"
>   #include "hw/sysbus.h"
>   #include "hw/irq.h"


> +/*
> + * Addresses and real values for TimeDBRA/TimeSCCB to allow timer calibration
> + * to succeed (NOTE: both values have been multiplied by 3 to cope with the
> + * speed of QEMU execution on a modern host
> + */
> +#define MACOS_TIMEDBRA        0xd00
> +#define MACOS_TIMESCCB        0xd02
> +
> +#define MACOS_TIMEDBRA_VALUE  (0x2a00 * 3)
> +#define MACOS_TIMESCCB_VALUE  (0x079d * 3)
> +
> +static bool via1_is_toolbox_timer_calibrated(void)
> +{
> +    /*
> +     * Indicate whether the MacOS toolbox has been calibrated by checking
> +     * for the value of our magic constants
> +     */
> +    uint16_t timedbra = lduw_be_phys(&address_space_memory, MACOS_TIMEDBRA);
> +    uint16_t timesccdb = lduw_be_phys(&address_space_memory, MACOS_TIMESCCB);

Rather than using the global address_space_memory (which we secretly
try to remove entirely), could we pass a MemoryRegion link property
to the VIA1 device?


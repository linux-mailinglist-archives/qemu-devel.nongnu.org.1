Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CCC80DF14
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 00:00:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCpG4-0002mw-Hd; Mon, 11 Dec 2023 18:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpG0-0002mj-3l
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 18:00:12 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpFy-0002lv-9H
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 18:00:11 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-58cecfb4412so2861788eaf.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 15:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702335608; x=1702940408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ym6l72SbMJK9GUYidD1T5f+beoBSpQct3yIyzYwSgZk=;
 b=fB4Zd627tbuina7C2BMh4mQ31erOI9IPxwCTpFyy1z56SKpaolgTyhnBFTTQJJ2IcD
 gecWChGAXUL3lYhihowLJHWW/vDV5ORJ0WZxUtG/5fWyHinqcYiFC1QsBhKC8ckJN6yg
 MWXu2tDSlSDBpTLAToPIPuAGKgBGKENRl+GAYqv5+FMCHtqTezlAmD+QeE26FBvkRJzF
 J4KrOshP5DeayMDdx1kp1zb6OALwB5Y7zcxvz1TPTPXB/Qh5Mz2hcr4SkyydGOWNaOQT
 SR7UtxuznvjebBTPYlT7a6+j81LR1YvOP0eb7yeOrd3/yBYfxj8S23c2vmcKW4+FwXQd
 qPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702335608; x=1702940408;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ym6l72SbMJK9GUYidD1T5f+beoBSpQct3yIyzYwSgZk=;
 b=ngFO4dcB2L87n1CseIERmvAAkXa+Hprj07BiZEan75VpFfjDjNaLUahBnsjGMB9Swd
 DzMa4A3MIU02cVapBwvgqMgs/s5vZKvJWMKWc5lNCW1GO6s6WX8GMGFCPzhKCP41BbZb
 uaNbllL3DD5eDzmmcEy+RK4iuZlDMv9U2c9OfWmBvx+aY7UR9SeMhjXH9ivjBRkUSmi/
 FC9DMZ7NsbuR8w50ULgPZrA9BYV9egPeXS5YA1JQY0/CzeNqW71LeygB+RLbmgV27Dsi
 ibUrfW4GIJg+Vs8JaP2eEp/GZAIDnl5kPFeMyU2jvgav2jBfCqp2gasGylb2MuZJ5P6x
 E8bQ==
X-Gm-Message-State: AOJu0YzO9t7Z6Wy3BZnEDS+/Seh1DH573O6TNVwdsxf/jhUyCYHKfyH3
 D7xPj5drUrbFd6bHBwzBe8oJ7A==
X-Google-Smtp-Source: AGHT+IEEtsUUGSH9PFQbZO0CugkujZCYpx3XFKfCRP+Uwx8qlvdkhSu13kX1sVlRb4cobEg5TWIuFg==
X-Received: by 2002:a05:6358:8829:b0:170:9546:ebd1 with SMTP id
 hv41-20020a056358882900b001709546ebd1mr7224356rwb.0.1702335608428; 
 Mon, 11 Dec 2023 15:00:08 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a17090ad08600b00286117f8c15sm9022612pju.4.2023.12.11.15.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 15:00:08 -0800 (PST)
Message-ID: <02cfd4a9-9d6c-4f61-b25e-deb0cbec2838@linaro.org>
Date: Mon, 11 Dec 2023 15:00:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] semihosting/guestfd: Remove unused
 'semihosting/uaccess.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211212003.21686-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
> Nothing in guestfd.c requires "semihosting/uaccess.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   semihosting/guestfd.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/semihosting/guestfd.c b/semihosting/guestfd.c
> index 955c2efbd0..fd7e609790 100644
> --- a/semihosting/guestfd.c
> +++ b/semihosting/guestfd.c
> @@ -15,7 +15,6 @@
>   #ifdef CONFIG_USER_ONLY
>   #include "qemu.h"
>   #else
> -#include "semihosting/uaccess.h"

Then I would be surprised if qemu.h is required either -- that's where uaccess is done for 
user-only.


r~


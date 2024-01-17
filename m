Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DACC9830127
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:19:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ18O-0003d6-Ph; Wed, 17 Jan 2024 03:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ18G-0003ar-V9
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:18:45 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ18D-0005UW-Ig
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:18:44 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e8ca16511so617395e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705479520; x=1706084320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lEqi/RHj4sq69B79PKZvqrWq3QqVccKHRwjCNfNa65c=;
 b=cEOC1nLvAhJRKz5uWzTOLJWISBy5Nh+39KW9hZu6zDATLX/I2br3iA054auyXvOrvt
 VcZeGDLvNRtgm8g8fGyatOTR98qA3Z7HzG+KDROpHd9aiju2SnkNabbMuSb5XFE+R6S4
 yWwL0gBBfoizHOJdyFGayPhsfvziW/KFwUl3xoUpKceQBlVsSLgIW/J4oyLa8jqINuq6
 VyU6AbBdymrMCZx0zvT8Nr8L250D+t9Az2D0g4sObbNnbZDPnwnTQkxnK5aubpjfhyx4
 xxlJDClgyN7ug10hNVqUQxWf0oNcWy3+UpTo+/ibkhjGJU4Yid/hwpUW/zjdoJv3JmcZ
 0wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705479520; x=1706084320;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lEqi/RHj4sq69B79PKZvqrWq3QqVccKHRwjCNfNa65c=;
 b=M85dN5kYotPfFhlvP/iIJOv+4mJEyTOOHgmyxei0uyKoyTfsUGyWYGzxCGuBRbnTHp
 dqvNTxfaCHYUIEin1lTmtEjVT62R8j99tsaZHSFaKMs96bgOMIVnpSFiO8rmzplDa55q
 iJCzpOpkOX/y3+7e9Fq6kN8dBLLw8akF9CZ4OPpuH+bOQJjpMBVk5ZHayMelv5qlYENk
 +JNR+aJoapjQponYGAdqFNO9dUifayXyE3RPv7rVxWO2Z0J34uuacAQui5N8LaitjgrC
 4iW360T+s5EuHeIoSUwhcZlwlPZlXMsiXnY9obWiVw6s88sZpOxU8Tcz8/pfCbErjCUj
 1zHw==
X-Gm-Message-State: AOJu0YxDRCQmALlHkasLUUB4jvIkTcAscWPwmF48AXhAmHcqf/hkUC8A
 JRhrMK7iC9vwpKty1RrFoibFfhPC+8DKAg==
X-Google-Smtp-Source: AGHT+IGo4cNCTlz6ARVTtNQwuGY8oEGVsH643qjynmF8jxShghyo6bhOtir45ppGo8/pc1zYnYUtRA==
X-Received: by 2002:a05:600c:458b:b0:40e:6397:f42c with SMTP id
 r11-20020a05600c458b00b0040e6397f42cmr5491187wmo.7.1705479519927; 
 Wed, 17 Jan 2024 00:18:39 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d51cd000000b0033673ddd81csm1033645wrv.112.2024.01.17.00.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:18:39 -0800 (PST)
Message-ID: <ef36646f-fed5-4b46-8542-44100b9d58bb@linaro.org>
Date: Wed, 17 Jan 2024 09:18:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/elf_ops: Ignore loadable segments with zero size
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20240116155049.390301-1-bmeng@tinylab.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240116155049.390301-1-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 16/1/24 16:50, Bin Meng wrote:
> Some ELF files really do have segments of zero size, e.g.:
> 
> Program Headers:
>    Type           Offset             VirtAddr           PhysAddr
>                   FileSiz            MemSiz              Flags  Align
>    RISCV_ATTRIBUT 0x00000000000025b8 0x0000000000000000 0x0000000000000000
>                   0x000000000000003e 0x0000000000000000  R      0x1
>    LOAD           0x0000000000001000 0x0000000080200000 0x0000000080200000
>                   0x00000000000001d1 0x00000000000001d1  R E    0x1000
>    LOAD           0x00000000000011d1 0x00000000802001d1 0x00000000802001d1
>                   0x0000000000000e37 0x0000000000000e37  RW     0x1000
>    LOAD           0x0000000000000120 0x0000000000000000 0x0000000000000000
>                   0x0000000000000000 0x0000000000000000         0x1000
> 
> The current logic does not check for this condition, resulting in
> the incorrect assignment of 'lowaddr' as zero.
> 
> There is already a piece of codes inside the segment traversal loop
> that checks for zero-sized loadable segments for not creating empty
> ROM blobs. Let's move this check to the beginning of the loop to
> cover both scenarios.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
> 
>   include/hw/elf_ops.h | 75 +++++++++++++++++++++++---------------------
>   1 file changed, 39 insertions(+), 36 deletions(-)

Thanks, patch queued.


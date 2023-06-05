Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6022172264B
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69cu-0002C9-FQ; Mon, 05 Jun 2023 08:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69cs-0002Bi-78
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:47:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69ce-0005dq-Km
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:47:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f70fc4682aso41374565e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969263; x=1688561263;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=48Jd+K9fuRrpjYbEPvVzq5KiHPGlKwsZTwmdFVRMBL8=;
 b=dHnCbPOSCrdgVf6PjSsPJZkt6Zfgjo22ow7Mz//jESOZIRustFX+O32c5Q7K2HiFPu
 nNv8f83MDrLc1hq/i8Bx80RjUDSv5jJuEWOURYzReCjjCB6kws+7/21WxhSrAHV/lIjF
 d+8D8VolIQ7vZzhN//ylVuG4RuFTWQP3jJV52fMFsoIxUc3HLVDAoPzARjYuDHdMkeoJ
 5moKhFISSEs7RhDUx2fMLrHfNJoIweLwcLh356/xgnD/+xJ3jXCYFPgCjWGl0Px01C81
 iVwJIramVPuj4rYhUaMcOJKzp/cqdFkuSIJlXqe3UFTPFn4qRFdXZ0ky6WvFvNHcGg2L
 zVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969263; x=1688561263;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=48Jd+K9fuRrpjYbEPvVzq5KiHPGlKwsZTwmdFVRMBL8=;
 b=UtJhvRSAbI3/BzuohS+YFjl5M9J6s1QHHOwGZYE3sPRdpCzuwhHbbPaUrqfgPehmPe
 LOrt2XmyIEFuaqIyFVS/0+tETG7z0UmbrLu6G56EQFHRchSxP3v4GgCSFmDCLhE/QNyT
 91DBZM68i0SFEj0wwBf9y0yGKUYWr0jl63NcwEGID3SEfFZPDEZJJX4R1vzRCuhJ/gGE
 foydncpz4yYIIGBQtTgSfnwKidTv3MVOmjdHo/1YDYYe2g2pcZd/wy1knH28BBkBA5r7
 oPWK7GDGoqvWiaU4vZbUkGhToJdIsX9tg1wv3sxgEwnivP8SN2ptIy4eFLfLcOL/SDYV
 kaCw==
X-Gm-Message-State: AC+VfDwyEfmLXNM40NBLtMwp7G8xlbuz8FfaeeDhHNDGO5MBBD1dzJVE
 m2DDwK2mvIP8kUFwSCN744TT5g==
X-Google-Smtp-Source: ACHHUZ4mCRY9rvco+j4apMJaQ5bB66QI9ft52PqddAC4FNBpL99t3jHGHJBwwO9mFpXH0yzjZSp7pA==
X-Received: by 2002:adf:e550:0:b0:30d:7c09:b60a with SMTP id
 z16-20020adfe550000000b0030d7c09b60amr4137547wrm.7.1685969262882; 
 Mon, 05 Jun 2023 05:47:42 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a056000110d00b003047dc162f7sm9713399wrw.67.2023.06.05.05.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:47:42 -0700 (PDT)
Message-ID: <ed23ec22-ef67-6364-4c6e-4370efd26f13@linaro.org>
Date: Mon, 5 Jun 2023 14:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 19/23] q800: move mac-nubus-bridge device to
 Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-20-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230604131450.428797-20-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 4/6/23 15:14, Mark Cave-Ayland wrote:
> Also change the instantiation of the mac-nubus-bridge device to use
> object_initialize_child() and map the Nubus address space using
> memory_region_add_subregion() instead of sysbus_mmio_map().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 21 ++++++++++++++-------
>   include/hw/m68k/q800.h |  2 ++
>   2 files changed, 16 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



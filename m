Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E2382D818
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 12:07:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKo6-00068q-DE; Mon, 15 Jan 2024 06:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPKo4-00068A-MR
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:07:04 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPKo3-0005GT-5L
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:07:04 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a277339dcf4so957897366b.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 03:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705316820; x=1705921620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jJJ1XssqEEeqeEQ+1czPyZxou/Xjsx3aqQEkHSMvTYA=;
 b=J845m/Ss0Y+X0WkXbVYb3iFc9BRSFBqXH9cpST/4r16tQSDt+v+ezMKwi6z+7Y9vgP
 Y7XqDWNcMe5QH4Lolr+r0XFMem1mbnUTvkjeDoQkTakgGmtft/PJvVTmht///CvbzmDd
 XRJ0HiG/Oac8dARywyN2XRcQpUCCIPm7UsJkhCQ/Cl/Vqru8zd0j1l0hPcY2mA9HPos4
 yixxarsWEz670OMsrmLz3lqTET3KP1n0gCqAY0LEenkFXAtgR0Bx26Z9aYlMNb4dtzM8
 EwVGhWov6FaATToBxnnMw8ASU2dTYmddUf0q7w1knoalCRxVAZ4jhSMZ6QrlSMevc/4F
 yEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705316820; x=1705921620;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jJJ1XssqEEeqeEQ+1czPyZxou/Xjsx3aqQEkHSMvTYA=;
 b=bSd3K/R1pkycufDON3VnztNVqnD6g4MD4GUkwSsdM6mNXX1qCrzqO3+WJOh7RVdy+D
 PiziTI9qGTEBVKhW1J2e9VakctaVcMd8x1AbF4p/gIg/EqOpIMVWG0a0JVgCO3j0N9Hh
 zJ5NkwVhv3z9SL2kIi4X3J4ttjAmsMmV/LEy3LBotzxG0N5CS6zn572EXBLyIOaZXK62
 FICLrQcrtINfzQ1WqHCKKf8KnO0gTVeEwTMw68FlHh7UzxWhT7kOEJTcwt49zaHvQtyd
 ceUk4mrnE0pOnGlHpmhdRLZrhSpka6q3C/7VALb+x0LkxoSM8cfLwD7mEOaVC8dlDt6p
 uD+A==
X-Gm-Message-State: AOJu0YwCcrQNgMHg98SB0YyRH67gsY/m0cIY1878aVbpFffqDiSAh5ba
 RGXpC5osFkcY61RUC4qGTlzbKr4nA46jCw==
X-Google-Smtp-Source: AGHT+IEYR1Rz35DrhqsqOve1mnJhIxTPN39kVOcW8/oBbmLmaoQ3xYnUbhoJCYzW96TyiM9Kzd74jQ==
X-Received: by 2002:a17:907:2cd2:b0:a27:e711:8b7e with SMTP id
 hg18-20020a1709072cd200b00a27e7118b7emr2174637ejc.106.1705316820630; 
 Mon, 15 Jan 2024 03:07:00 -0800 (PST)
Received: from [192.168.1.102] ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 vs7-20020a170907a58700b00a2caa85c0c1sm4253888ejc.30.2024.01.15.03.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 03:07:00 -0800 (PST)
Message-ID: <5e0b0da5-c737-41c4-9c8e-52450ca14af3@linaro.org>
Date: Mon, 15 Jan 2024 12:06:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/arm: Refactor struct arm_boot_info::get_dtb()
Content-Language: en-US
To: Bin Meng <bin.meng@windriver.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
References: <20240115043431.3900922-1-bin.meng@windriver.com>
 <20240115043431.3900922-2-bin.meng@windriver.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240115043431.3900922-2-bin.meng@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 15/1/24 05:34, Bin Meng wrote:
> At present we expect struct arm_boot_info::get_dtb() to return the
> device tree pointer as well as the device tree size. However, this
> is not necessary as we can get the device tree size via the device
> tree header directly. Change get_dtb() signature to drop the *size
> argument, and get the size by ourselves.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
> 
>   include/hw/arm/boot.h     | 8 ++++----
>   hw/arm/boot.c             | 3 ++-
>   hw/arm/sbsa-ref.c         | 3 +--
>   hw/arm/virt.c             | 4 +---
>   hw/arm/xlnx-versal-virt.c | 4 +---
>   5 files changed, 9 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



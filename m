Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D697D7564
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 22:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvkND-0002rh-Fa; Wed, 25 Oct 2023 16:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvkNB-0002rI-K1
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:21:01 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvkNA-0006hF-4Q
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 16:21:01 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-27d3c886671so86285a91.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698265258; x=1698870058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0fZqjurnMDCcUXDR86JAfumOWdbL7SoJxoXEMh2PUJ0=;
 b=e7MlSC64iqZgL6OqyNOYBsXDx84ZPUKsct0lAFLOyz5ZYGHoZbODYseoG6s7+GWY7j
 0ad0+24xxzfw5njGficauSGhQD2sn3dtylxCczlm5lwYfL/Y8QzOyRoCHTI3a3SRMJqD
 oEED1Y17g1ngcWLmEkm8/EN6Whv9p7s5rr6GPTCjqPF2Owdwn3o8imIQP98Q6KmesL95
 jqrIKfdhI+nD3JPbrNzKK6NQt3vNkU9GdBGCXLSumoVeYjX5kavu6Edsu1mLQDaqmW/v
 F95mrT5fYnZWXR7XU/a22SyvtvOFnJ44TpkePhFQyKvWmuF1ePi4e65AvmVAHvNdwzXi
 NUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698265258; x=1698870058;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0fZqjurnMDCcUXDR86JAfumOWdbL7SoJxoXEMh2PUJ0=;
 b=rTuKTDRlHf2nrZE3QB6Hu19+mLafIGQK+MoLiaPMV+63PQ5qC9uy1X2rlB+thuFyJ1
 NWzKxeQmGVe0m76pIAGrJF3Z5XnEElKd90rybKMpCPOhgS+eId5Ae2u5bEglyvZ64qSA
 7ZYMz2Cp03cb+YFvwWQHL3BgZM4B4bHU8hImz4ca+bVbWfRS0jpfiI+IxwnyVw8vyB5A
 Pw1iTWwK/73IKUdmAeAxXJL8UhxVJp4InkEUnnYOQ2X8htp2boFy+e2xpzWwQv2idjdP
 OCErHddreCEXPxWcNxJmNKtabBULRol+Ve8g2/2mZYHpzwB00Y5Y919zQYYXierhwzJo
 SOKw==
X-Gm-Message-State: AOJu0YwIfCVsYs9IQcBMMO6VXvvjOeDHH66y0H05r9PXOoFmhzbJlPBB
 J+z+qwh5rimqABDhyyzi1oNDWw==
X-Google-Smtp-Source: AGHT+IFeNUQJ86398LtmQ/LPY8k6H9V95K/zrMAV06eSkqYG3Gb3DVhQorXknxzlJnK/Q9ZCdBqG6A==
X-Received: by 2002:a17:90a:ac02:b0:27d:b3d:5c33 with SMTP id
 o2-20020a17090aac0200b0027d0b3d5c33mr16397764pjq.28.1698265258537; 
 Wed, 25 Oct 2023 13:20:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 24-20020a17090a19d800b0026b46ad94c9sm320918pjj.24.2023.10.25.13.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 13:20:58 -0700 (PDT)
Message-ID: <cc1b1909-03f6-4104-8e2b-afcf526e6bc0@linaro.org>
Date: Wed, 25 Oct 2023 13:20:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: Avoid using 'first_cpu' when first ARM CPU is
 reachable
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20231025065909.57344-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231025065909.57344-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/24/23 23:59, Philippe Mathieu-Daudé wrote:
> Prefer using a well known local first CPU rather than a global one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/bananapi_m2u.c   | 2 +-
>   hw/arm/exynos4_boards.c | 7 ++++---
>   hw/arm/orangepi.c       | 2 +-
>   hw/arm/realview.c       | 2 +-
>   hw/arm/xilinx_zynq.c    | 2 +-
>   5 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


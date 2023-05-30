Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D51D5716FAF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:28:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46sJ-0003aZ-Qa; Tue, 30 May 2023 17:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46sI-0003a8-0J
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:27:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46sF-0006g8-EU
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:27:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f6ffc2b314so2460195e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685482041; x=1688074041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iE15bGtQQeyfUNU1+Xr91UXiNC5Y62gPfcZSsnTaSVQ=;
 b=COb1nVH3D9zTAQc7nmaVOXIhvPXV1IQTS8nrtlXadukk43GYyYmwMWBsqyNglxfD9J
 ns2H2fpey8DiO+lsZrtS7xQoT9b1gawLqPprJdLcm8BHMqupNrNcJDYALQJNY6AKgJdc
 E/LZVOhFs8zigTRsU6Ix3BrD9r35SwVorElH8wikPDcfTYyf2FoCvy7JO/L1l97g5TfQ
 I6BPVQONkPqgNEQiweJ75hD6CuyNHRrssPGpcaHK0yJzpj9h3ETR0ne/V3INn8jgwC9y
 yNZEyTYAJBEmy5ROkaR3GKeSjcAU1Ad6ys331CbHLCGuCFVp5/McL0rZL8rBJB0GAUDx
 FzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685482041; x=1688074041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iE15bGtQQeyfUNU1+Xr91UXiNC5Y62gPfcZSsnTaSVQ=;
 b=lOKVG9oiInHie7FeDboftx5y4yVl37CE3EXY5cE5qFvkTs9QwboVtUpoLEFMMt4jPw
 0ra3+jra7VUheTMxOTMy5XMw4zv8O+PHJCjKmlhZ+QtqWhdWv531s2XS4RzgBEw2RTdC
 gvhoyQuNk3w4YWXALONlTnIgUj7fJKpj2EbKmLyayq/yWxu8XjfKlJPSKaJ/rSB/syd9
 GjSP6w5fmjQlc5yBD2QTK+Wz3SYOBtnJdMxVAED1MtxnYIfUckb+FkTVAymcnXYVpT3m
 576kZy4QIas0o/fpXDVbeb+MCDSBNUSbpGVp6SFnyGmj6lxtYjYUeEyiuYy3D3rENxDK
 rvnQ==
X-Gm-Message-State: AC+VfDzFwLY/V/PNUP4SIdhWDnoIqMM+toy2g0xZzUDMIpuZtTaq2gIJ
 PsW6qvFYV87PhLSYWlEu6SoQag==
X-Google-Smtp-Source: ACHHUZ4Nngbk8SQQqqf3nDC2GjQGlCsuJrs2MWmBVTjCyR8xR/IljpNMccqKN1DEZfGhtWKY1pPjYg==
X-Received: by 2002:a5d:4f84:0:b0:307:f75:f581 with SMTP id
 d4-20020a5d4f84000000b003070f75f581mr3258511wru.18.1685482040974; 
 Tue, 30 May 2023 14:27:20 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 b10-20020adfee8a000000b0030aefd11892sm4357182wro.41.2023.05.30.14.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 14:27:20 -0700 (PDT)
Message-ID: <981dd9cc-9d2a-9e41-8ae9-4fa355b0b061@linaro.org>
Date: Tue, 30 May 2023 23:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 03/12] aspeed: Use the boot_rom region of the fby35 machine
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Peter Delevoryas <peter@pjd.dev>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-4-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230508075859.3326566-4-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 8/5/23 09:58, Cédric Le Goater wrote:
> This change completes commits 5aa281d757 ("aspeed: Introduce a
> spi_boot region under the SoC") and 8b744a6a47 ("aspeed: Add a
> boot_rom overlap region in the SoC spi_boot container") which
> introduced a spi_boot container at the SoC level to map the boot rom
> region as an overlap.

2nd patch,

> It also fixes a Coverity report (CID 1508061) for a memory leak
> warning when the QEMU process exits by using an bmc_boot_rom
> MemoryRegion available at the machine level.

1st patch?

> Cc: Peter Delevoryas <peter@pjd.dev>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/arm/fby35.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)



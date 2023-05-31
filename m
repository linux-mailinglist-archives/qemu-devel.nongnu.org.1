Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71054718470
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MZw-0007cT-Cb; Wed, 31 May 2023 10:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MZu-0007cL-Kv
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:13:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MZs-0000Hb-Uw
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:13:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6e13940daso61826865e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685542407; x=1688134407;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KNq9eXK/3VhQXX6J+rmXyE2T1QXRN8k68DN6UuqCVdQ=;
 b=jDPA/Y/V4cb8ZoXcisaZjsv7dhq4hslQvXMwLkHrXVxskGIVP5wkX1MSHqkHTpf6rh
 430MCo9wfYHhjAjbB0fgxemSoFn7fsTozPkcXqKiYJ8olNeVGNZs4KncyOxG4f9yPi3B
 IJSNNbBDtoCcXgdDjBQY/WDvYeN8gpTvjbNFcjM474xFL1fpzryZ2+g+r+4166Vx5tY1
 FBmrlR22fiQAyNEy/6GRW8no/GaluZCeYz9cS89qHPt5ee55pU7OKx8e8WjHCn11tYw1
 BDI8A0owBLWVKhQM8CmbCTJLcmCvAnbfkpdpXp/IeajGvaeOIbsA40Ma0CLOsHCePIAU
 /aJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685542407; x=1688134407;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KNq9eXK/3VhQXX6J+rmXyE2T1QXRN8k68DN6UuqCVdQ=;
 b=MkDCtfUEUyRNq8qFzr+QZ2wm56UkQpNUrJrWTGZ6jMNdQSvzsIkTYZHeSPMtg7Z5c6
 TuDyq9LaOvLXO91D9Gah7WBc5MlZKcTAeFXu9hIVan/6zbVswmjGUHvBx6aIeSKZ3V8u
 8Z+dueBrpBIEyx3VlTiJAXX6jhREzUMztCy0OqyRJV9Cj5hgvnEYpBUtl7YN6rYdasWI
 1UCbs+RbC6v06GVEwUOjCOD4tc3VIAKlZwP/394gTWqzRr1oN7XFFTNJdlIQr8W95oFr
 ajmZaTJQhrG+kcE7vCgqjJ7rABB2cOg/pO1nCCZtGkysTXRIWCZjvqYkN9X2i4ozrMQP
 YLqA==
X-Gm-Message-State: AC+VfDxvMTKvFb/N2pQrhkKsrg2FVaBlWWIQASYnIHvr4xBnNAqY/qRu
 ybXFzIB5OcTJ80dNAmdJvOpbUQ==
X-Google-Smtp-Source: ACHHUZ6s+ARIO9+WOtD5Rr1lX3SA5mR1kF5t27RNfx/SrqwVMSXAbJOcfOkcCvwitbpg4oaE1pyJvw==
X-Received: by 2002:a05:600c:2208:b0:3f6:a66:a36d with SMTP id
 z8-20020a05600c220800b003f60a66a36dmr4343845wml.10.1685542407268; 
 Wed, 31 May 2023 07:13:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a05600c294b00b003f6129d2e30sm24559454wmd.1.2023.05.31.07.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 07:13:26 -0700 (PDT)
Message-ID: <77703afd-3396-a7a4-ad58-f49afcdd28b8@linaro.org>
Date: Wed, 31 May 2023 16:13:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 16/48] target/arm: Include helper-gen.h in translator.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 31/5/23 06:02, Richard Henderson wrote:
> This had been included via tcg-op-common.h via tcg-op.h,
> but that is going away.
> 
> It is needed for inlines within translator.h, so we might as well
> do it there and not individually in each translator c file.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h     | 1 +
>   target/arm/tcg/translate-a64.c | 2 --
>   target/arm/tcg/translate-sme.c | 1 -
>   target/arm/tcg/translate-sve.c | 2 --
>   target/arm/tcg/translate.c     | 2 --
>   5 files changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



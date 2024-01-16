Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 860A782FBC9
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 23:04:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPrX7-0004Bg-2V; Tue, 16 Jan 2024 17:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrX2-00044c-4x
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:03:40 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrWz-00024z-Fz
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 17:03:39 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2cd33336b32so136665291fa.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 14:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705442615; x=1706047415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KiMgGDkwPrToKnZK16RWh5v9BV6qvbDxPizoiGrvc1E=;
 b=eqmB5CfD0NU5+UjXNiGUWlDTR9PCRMpJYYOwRskZZHkFASomtVxruvo5lbH2mHWthz
 yxV8Z/bDH5okWVGry6tgZO8HdAkFwwvGKoEGEpIZ/Xqg3b3LLsrtcg5/lG3k0ZVwTzyr
 9B615xGP3VtD7i9+bAVVDpO95lP7LUoIY8CaA75FHPRvkVvunF6HnUszbkLyZfFMow1G
 2WhZA4pOwYww3sSMvSQZUdYH3GnEkWmFuwdl3uupcS2KaZS2tPdTgww8RiJuqrSLjq+H
 Msxs3fFuaV4owwo3swFF3x1w0wL9VzvrpL2jjtKaMuY7ZHRXpYEIZEXHF+sen8tYG6+z
 og/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705442615; x=1706047415;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KiMgGDkwPrToKnZK16RWh5v9BV6qvbDxPizoiGrvc1E=;
 b=ipzRwUvrGAHHz/4IAveP1Zxl0RAHbNNJbVTXXUDTBi8qr/fhgk9AQyCnSpE+maJIfi
 22xxg0oBjSnpndB8N1+CdpeHQBPuiSYD2Djr2inJdKOwlX3jEvU2chzS0rcybB8f70N1
 /DbqR0WU73XVkotGFoLP5yHWd+Dk7ZPx/oDtu0vJbAai1KinDWhcJHFv9J8g4R0mCH/3
 g6KwXIDhzBTEA2SgWZOpa6pXTXyYCDWMLZNUVjgP6AQiuT7TN9XRwxJ80IPpS3On7wIT
 bOJ30RwSmH/FdRI4Bvyfkhh6TMRrd5DAuDqmK4kdya/xp3EdL1Kfir0K2L5YW31jTjKM
 Bpvg==
X-Gm-Message-State: AOJu0YyI8+gZpcNzs3M5N9olPoqqYEfuaBd/3wRj/QbfCqCGYcOfXJBq
 UR1buKVP7g3DQczSoQlCEQLVPzWtXMBD2g==
X-Google-Smtp-Source: AGHT+IGIJnOq6Zb7QGBKQoWOB4yua0sif2cwTPVlEaP6vyNd5JIGUUd1A6PO5V/M4pGefM3Gcq0b5w==
X-Received: by 2002:a2e:9083:0:b0:2cc:695b:a12b with SMTP id
 l3-20020a2e9083000000b002cc695ba12bmr4043925ljg.85.1705442614827; 
 Tue, 16 Jan 2024 14:03:34 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 dj17-20020a05640231b100b00559bb146ecbsm849813edb.6.2024.01.16.14.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 14:03:34 -0800 (PST)
Message-ID: <3f3416e3-222c-4c50-817f-33d43775bac0@linaro.org>
Date: Tue, 16 Jan 2024 23:03:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/38] target/alpha: Use TCG_COND_TST{EQ,NE} for
 BLB{C,S}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 10/1/24 23:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20231028194522.245170-33-richard.henderson@linaro.org>
> [PMD: Split from bigger patch, part 2/2]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20231108205247.83234-2-philmd@linaro.org>
> ---
>   target/alpha/translate.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C34A7932292
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jul 2024 11:18:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeIa-0006TF-NI; Tue, 16 Jul 2024 05:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTeIU-0006QG-9B
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:16:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTeIS-0003Xp-OV
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:16:33 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso33371085e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721121391; x=1721726191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JZJ2FaC1aColOK8m8UOtkXUAgeNFiyILyU4C1KWmjGA=;
 b=IB7eD45Lw24UM198pLO/5+c1loze6W0TSMF1SQFrze/aoEB8dMjfOp+9TuuojtmCzX
 mwVECLltPg77xCUTN3vDZo2dsMCBe0/Phf3VuNljt691bX9ZPBQECQ3oteYNmUdOvnFS
 QuTgQRkZD5cTmTsHw8BRhmdqg4IBKKOpdUOYggpi0M0/Ctnyp6GaA0NIz+saW0nqCXtt
 9W5EWVGzv0gGU0IkFxwN1lP9JPGMG2jELKE2CB/G46eqktEcFBSNB27ocvWdTMbNxa8I
 2haUKieYnbHi4rNzUywlqbwYA+7QByzIQQKEXLgGbU5x4DDvj32a9jeiZFcCGf8BLYQ+
 tQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721121391; x=1721726191;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JZJ2FaC1aColOK8m8UOtkXUAgeNFiyILyU4C1KWmjGA=;
 b=ORt2hB3Hc8xKbrVpjv6NPzWckDkpoh/nBedeccNVF6UWDI1bdSB3LsrPehry/5Y2LH
 Q9Ls4T1TywIqOyEiUz7maCbdE3+nFCh4A42P39Rqljf/gwPTvLOGBbGRatcj2WT6CATT
 3OeUZFlErBDPa3AvP2zRt0+1uKXrL23XgKp5AbRbvVKIpHqGwjeIgzODxiD79SUE9VdV
 t+CQs2kCYsJznt90+TaxryFrh1CY0vyptjfLnw09zD3SUQ0nlSHJv7zx5FiymoKXeffL
 wWW17mF0cnyLA+LWOiB+X1uaRHtgs4XYgfJ43RwqrqZ6EEmWcQmi8izCmoAtLl4OVJxn
 bS8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfQBV8oNDI2/7VoQnU0BLCuenRSsCmrzcgEnbcZWOxQJ84qLNTx1I0foWHYCFqpyEWgJZGeYLsfkHj1Cq8CzpcdJ2grpo=
X-Gm-Message-State: AOJu0YzezuD8S8vOB9nXj2xml7xPyGqGZ7xU+o83F4z9VrC8si4HmaOd
 nGjJJAMII4iXqeTAMAyth/NY11rhCAC+GzWDeGqjSF8u/uy2ZlOKtNpQATBNrK8=
X-Google-Smtp-Source: AGHT+IHx98a1B/GIP3m5X2nLelK9E2sWyQXI2JaqxucqrxVtvGj4xoEreEPs/a+JFermqf0PdGglbg==
X-Received: by 2002:a05:600c:19c7:b0:426:4765:16f7 with SMTP id
 5b1f17b1804b1-427ba654628mr8920065e9.21.1721121390848; 
 Tue, 16 Jul 2024 02:16:30 -0700 (PDT)
Received: from [192.168.86.175] (233.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.233]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427b8609d54sm27755325e9.42.2024.07.16.02.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 02:16:30 -0700 (PDT)
Message-ID: <066eef24-c136-4b18-947f-64ded0c77b48@linaro.org>
Date: Tue, 16 Jul 2024 11:16:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] tests/arm-cpu-features: Do not assume PMU
 availability
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
 <20240716-pmu-v2-1-f3e3e4b2d3d5@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240716-pmu-v2-1-f3e3e4b2d3d5@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/7/24 10:28, Akihiko Odaki wrote:
> Asahi Linux supports KVM but lacks PMU support.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   tests/qtest/arm-cpu-features.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



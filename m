Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E978C66A3
	for <lists+qemu-devel@lfdr.de>; Wed, 15 May 2024 14:56:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EAr-0004NR-P2; Wed, 15 May 2024 08:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EAj-0004Ki-Dh
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:55:53 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EAh-0001DL-8t
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:55:52 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51ef64d051bso8037532e87.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715777749; x=1716382549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ram6h2Jm5t+IcqbxVWOMN0xdlLbO0E0/wif8Gk9IKjk=;
 b=jKRBePdaLuCABx0hRzjmgcIbkJPoLg1IRuHYwoE4VmDyA9DWW8oZo+U1FxB8UMsAwG
 afGV12Nin1VaPCmYgGAc0I3AHEg0BC6sQ13cLABr6FXBy3UPINzR370y73+wvQIj0Bdq
 1e3XgvHmZxZiO++KrD5hY0Un8CoWm+Yj8q6hwPYNC3aMzHObDT/BGzlnN/TPGcn1Kobo
 8z1xSV2p7F9ZxbUJVtpoC1A+UYaQls1AXEX3uXtsXv25pZ+mzI4WCyyVInS2sGa8ranq
 AmA0g4UgIGZtTqGJWJlKpLUGlJUqhGR8aA0PBn3w2AJOjWVQBCfe5HngqMthzstpjkhr
 313w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715777749; x=1716382549;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ram6h2Jm5t+IcqbxVWOMN0xdlLbO0E0/wif8Gk9IKjk=;
 b=UQ9x8nKjeGjSa7CgeOWBNhttAAUPxsmtCT/VAI4uG4zww7R+poUuHAdM7Jy3sG8Fht
 jcjT1aSIrOU97LUINWz2lD73fWLJBkj512GCR3Dr+/8PM+eob4wZ8g2SdFiLSIs4PAvd
 MRqXrwWkyO7Uflk71XnHAkGMenL2raa56HEY04weSVBfzPf3lNBIoRIpTv+/YVXpl8a7
 86aElQU2AMnfebSY5z9uNJ3R7IkCQvCxP4KlsdEZ0NJ5dSdFmgpPjuB9I7A0GwrQogHc
 m13c8oKuaUExL3eWrUuJUYF8nyjpZtohfz6s1ML4ghS09DkZ6pW6jljjtd6KuwXUKg+0
 cptg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfhVuRrJLAZinj7SxEgbc8gApAJ+Z60TcoY/6qN4ZUZDyGpcv126AxruJaFZxuNt96drPWUsYJUJsUI/27qNFmSxt5s8E=
X-Gm-Message-State: AOJu0Yyxzl5BvUh3NK39zk5wPn3kH0WBswVS90ePuZO21GyJjXL/GxKS
 DaQviFtFetL/U6pJXVpb/R32/Iyn9nENdHaf/gL1hITyJQyUveQUaZ9D1/lel7A=
X-Google-Smtp-Source: AGHT+IHLlifstczdq17fRpalsMSQxamtKhE2YZnKQTA/UMU6OxHPYNoOsggU6ug3A4JYlx5CAL0r2A==
X-Received: by 2002:a05:6512:4020:b0:519:63c1:6f45 with SMTP id
 2adb3069b0e04-5220ff72dfamr11440654e87.61.1715777748704; 
 Wed, 15 May 2024 05:55:48 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-420273cff03sm10124865e9.26.2024.05.15.05.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:55:48 -0700 (PDT)
Message-ID: <13e31a99-042e-4eb6-896a-eb57bd1d55ce@linaro.org>
Date: Wed, 15 May 2024 14:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] aarch64: Tidy reginfo dumping ahead of ZA state
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511115400.7587-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

On 11/5/24 13:53, Richard Henderson wrote:
> A misalignment for sve_vl, plus add a bit more space
> on the left for the ZA[n] field name.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   risu_reginfo_aarch64.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



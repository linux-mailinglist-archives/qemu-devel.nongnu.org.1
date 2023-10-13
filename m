Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4D47C871F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:45:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrISC-0003Mj-02; Fri, 13 Oct 2023 09:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrISA-0003Lu-1l
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:43:46 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrIS8-0005ls-FN
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:43:45 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9fa869a63so4640325ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697204623; x=1697809423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oDmSkFss6nlfgD9Rgqd4FwyGJcveI3/V+lTNsZVHSOk=;
 b=kRbhasSG590sMAnYn3nppM4y9PGNTwqi4OyccGS0CSSlZ0bobdtlkmTIK1XTmMyaaf
 gLMOaJEybdCgkPAwbGOXxFty/YGJ2tmaznrof8M/EzUeheHT7bGzAhhkkcU6qzleH9/U
 JTDy6pN7gIhfeXmUjBeoThcho1OaB/U0cFxTdLHjXaWnaT9NVvvPCbG/EYiQT4zauFqX
 F7VNRIehL/tX50gLlVw2migZtmUazef3zdilEKm2VfA+dQRno6BVb4LXJ0ujjYS4xaAl
 64aODjx9m5H1WD5T3+WmyV8yjAYsCwCxbo1BhPjTDrUn/89G+eo2WhX8+C5ZkfBxonpI
 wg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697204623; x=1697809423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oDmSkFss6nlfgD9Rgqd4FwyGJcveI3/V+lTNsZVHSOk=;
 b=odTwNj41XjaSB+K3FS5Y5R+pqxizdrLONJVoCz8CQ00ywptNxQn0+QZ4d2E/wv4l2t
 0C0YK/yf7I+VhU/sg+tEiBpeAtXQpevMuIacb6ZuvSSqvEvM0NA/kR4gjUZCdaw9HNSB
 o1LGwDKcgJsue2WKe/jhvSckDYhy/12TfLzioHsvzQ86MdfEGMqNFPVKl/0dkpkmPde8
 MJ7FNmEznrYcBTGcdvHLNq6ZgD4HyWXT7yJpGOxQ51yL+37agqDB3zNuayve6FQj9vOM
 8kEuqNOf4E/F3m/QSwIILD+OURi73YZWQDJgUJTyAQ21DDj1h+2QW2oIispqkR45ejjC
 q+aQ==
X-Gm-Message-State: AOJu0YzKzsCKFD/1BFE0r1EEifrRyQOh3YO0PYT1AOlj8UH1GwwrGYQE
 3D41jYMxU0r6IIfLiaKdW0slgA==
X-Google-Smtp-Source: AGHT+IGMA74752w7QWIUrPQOTOZUG3QTGPk53PXqkaBxgF6PI+1noF997s5UiZ8Lw+JLWIdO6vEDEw==
X-Received: by 2002:a17:902:ea09:b0:1c9:af6a:6d11 with SMTP id
 s9-20020a170902ea0900b001c9af6a6d11mr11338053plg.55.1697204622825; 
 Fri, 13 Oct 2023 06:43:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jh10-20020a170903328a00b001bdb85291casm3905528plb.208.2023.10.13.06.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 06:43:42 -0700 (PDT)
Message-ID: <299a324a-e244-4684-87bc-f1c7790c4279@linaro.org>
Date: Fri, 13 Oct 2023 06:43:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] target/ppc: Move powerpc_mmu_t definition to 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231013125630.95116-1-philmd@linaro.org>
 <20231013125630.95116-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013125630.95116-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 10/13/23 05:56, Philippe Mathieu-Daudé wrote:
> The powerpc_mmu_t definition is only used by target/ppc/, no need
> to expose it. Restrict it by moving it to "target/ppc/cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu-qom.h | 43 -------------------------------------------
>   target/ppc/cpu.h     | 42 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+), 43 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


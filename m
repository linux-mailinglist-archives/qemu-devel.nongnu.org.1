Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0803B7F72CF
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:34:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6USD-0007Ce-3J; Fri, 24 Nov 2023 06:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6USB-0007CW-II
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:34:35 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6USA-0007Ii-1z
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:34:35 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c873cf9f74so23233541fa.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 03:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700825672; x=1701430472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VqtibrAOQibndLf6C2EZ9ZrkwOkiHEPpjtCAXoyJQNE=;
 b=Ez9LLpu8Nnb3RPrXGNGw6J1N0QgORbWzpOHrnCGEHPojCkhshMcZ6eV9wdPP/RyLax
 NlaIuyUNbvmWtGakHQqgm3k2b3QeTH1u/w25sawavFJ+nKkAXBTBTFXb0e9AQs+I7p1h
 Nbyb9Npxgbceru/UgI622CKRb7oGdIdq577Z4AWkS3eMh1y8ulzwKnFC9hQonrETOPky
 pf2aZuLEa1+TifRZeHwOwZDMov0jHnw9tSzQoKr6Y0zaCrxC9asGr50uRaAkuySsmPwp
 KEpguL3hJIogFtFQpwMakEotdUTmNllZR1Kg0ISVD5TY2s4SG//r/kdC4fWdx2aAr24F
 roWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700825672; x=1701430472;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VqtibrAOQibndLf6C2EZ9ZrkwOkiHEPpjtCAXoyJQNE=;
 b=bFtqun+FTWbVpfFqACq01HDMKOFlPnPFgzTCbfSKW5NZe94ELMJlMkLsq1rs/L5nc4
 cWg/cL27Q0BptTkJfJ5zHl27gNWC4xd0nH1bv6ThiCnwZHLu13cyUaBQkh6Q14QCWX8z
 ZXUY5SNnaYks32mvze7S298iEBqGo945KdiLEafwo7ypItIZRgvCtE5F7Ssab7sIxrcd
 +/1w57NcBxHnqslvVdN1/JnKYetQXZbkRcuO7M4A/P7CPRgjc92r8hwKXGtf2mS3Gfd/
 CJWZPRguNt/IglR8lK0aTlizbKBjYs9Oq7W5Kfz+a+bw2LpPq7v6wuAFV5D/KIQzLF5A
 jzZg==
X-Gm-Message-State: AOJu0Yz4BxgPiYM1pz9kiXRc2hYq9o4dAD2wb96328UgmjsUrg7jLjn7
 qB/ErpgzqFdjhp2ja/AhBqXF9klDMbzYvSp11Ek=
X-Google-Smtp-Source: AGHT+IHU0r87T7xIzgwhJa3mlNlnksORb+ovM2mvlkH7ZKnNhJAVZTWNr3hsxRK7f+7ueZKfK4iwiw==
X-Received: by 2002:a2e:874f:0:b0:2c5:22c0:582c with SMTP id
 q15-20020a2e874f000000b002c522c0582cmr1683983ljj.11.1700825672326; 
 Fri, 24 Nov 2023 03:34:32 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a5d504b000000b0032d96dd703bsm4076728wrt.70.2023.11.24.03.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 03:34:31 -0800 (PST)
Message-ID: <e917bb45-e463-4ff4-8d5f-3333d95fa871@linaro.org>
Date: Fri, 24 Nov 2023 12:34:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/21] target/arm/kvm: Move kvm_arm_cpreg_level and
 unexport
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 23/11/23 05:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h |  9 ---------
>   target/arm/kvm.c     | 22 ++++++++++++++++++++++
>   target/arm/kvm64.c   | 15 ---------------
>   3 files changed, 22 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



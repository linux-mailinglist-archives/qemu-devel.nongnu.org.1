Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A89B572F42F
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 07:36:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9JAW-0005Oo-BB; Wed, 14 Jun 2023 01:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9JAT-0005O3-MM
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 01:35:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9JAS-00056T-2y
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 01:35:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso187123f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 22:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686720938; x=1689312938;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YTepOwZjAtLFEGurG0Na895JDeGDsFrRU+W+VFHVgac=;
 b=H+R60nOlZ8xDi9RmpOyljX45AcsE6/ue2pD40Vu86nYhENaJ2pCwcMJ7/8Og12oxVp
 AaIOL/xI3sfQQcMWJmFOWFBAKVdltQ/IVhXmeX8VsGl7DLbnbmGx69gVabkaRBR4Rad+
 qgardgl0Gs2yTz/YUgnabtCW3rZXX1XTEgW2G620BctaaIXqHdUhwF8V2c7DFjrSC+IR
 hXJqBIWoF+4jQsKO1e/0tDlxq/+fdsuwOlEV8JnTZKPbZlaChU6+Rbc6exCvHXE3Vryo
 y8qL0IK4vS013ZWhzhpob0cGVFKXJ3/RFPAVe4hbx73AGKKGULXsUCwRTA47pBCQtzMO
 Tp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686720938; x=1689312938;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YTepOwZjAtLFEGurG0Na895JDeGDsFrRU+W+VFHVgac=;
 b=MlbQalBbYRzHdcRhGY37A4iwjP4OTt5ndnuir9lFq5rhEEFkWQCdxV7y0ns9AWrgMl
 TBKHwEjRJVZK6ImkB9Qh9pj6d4gEJR6ljj2c5mzq1yymD6anQdotK+MuLXmdKJNjunJ7
 OuA8brqpdFidhXYshPYhIjIq7tumAmvbU/e4GPyJg2JyFd1noFVtmQIuqf8RtJvgh1KM
 9CHh7OGtFT6J7yyBQ5Qp5tNeZH3AtbDgv6BgzK64pqs/4naQ6iY83wY54qidcQ74yE7Y
 fg+J3i6xBT1TfYzG6F4Ou2tCsb5czAVaap63Ylj6O/eQ/2OHB7emA4cHar8JqwJoihCi
 ZcAw==
X-Gm-Message-State: AC+VfDyptA1iAa6wok4VKe0fNWCaXh8niCSAPDEWfz/sIOOSaSDDFPZk
 KL0D0ORS0Mna4IORNOVROgeGJg==
X-Google-Smtp-Source: ACHHUZ7ynG3hdxtT9cBfNeQnWuT1dPvpb9ThUApgmeH8iEjR6PVEIavkx33haPcVSheXylMY6HyoUg==
X-Received: by 2002:a5d:5289:0:b0:30a:d8f3:3e41 with SMTP id
 c9-20020a5d5289000000b0030ad8f33e41mr8271674wrv.7.1686720938287; 
 Tue, 13 Jun 2023 22:35:38 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a1c7719000000b003f7eeec829asm16215079wmi.10.2023.06.13.22.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 22:35:37 -0700 (PDT)
Message-ID: <096a97a3-bfac-a0c4-6e11-d99cbce10cbf@linaro.org>
Date: Wed, 14 Jun 2023 07:35:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 22/23] target/arm: Convert load/store single structure
 to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230611160032.274823-1-peter.maydell@linaro.org>
 <20230611160032.274823-23-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611160032.274823-23-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/11/23 18:00, Peter Maydell wrote:
> Convert the ASIMD load/store single structure insns to decodetree.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Message-id:20230602155223.2040685-20-peter.maydell@linaro.org
> ---
>   target/arm/tcg/a64.decode      |  34 +++++
>   target/arm/tcg/translate-a64.c | 219 +++++++++++++++------------------
>   2 files changed, 136 insertions(+), 117 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


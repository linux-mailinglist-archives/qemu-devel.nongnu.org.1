Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B790981F299
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:54:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIcmT-0002jh-V0; Wed, 27 Dec 2023 17:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcmR-0002i1-LQ
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:53:39 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcmQ-0002rn-6F
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:53:39 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d480c6342dso6324575ad.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703717617; x=1704322417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=365qb37Q0DAEuqITeiMUwz6y92ad6Qj2aC2LOO58cWQ=;
 b=l4gJ9tZHaOMkgbZ7hBSBdNQ8XifSzBjMd4U/iOND4U3M0KxRQkrC9b6SpNOiPgNCl6
 OcTn6KgPycZTjnoHvtdvW7AiyZiyVi6/GxJnGAjIDoGxcHv2imN23L3H0P1FtbGLxKPS
 AzyxquxWcaynVoIXY/DmkfZ5jPlHdikg8cVDB5t7JlHw9I6AZozhqCZa0IDw7baMijmE
 ckbLWj+730B03aMzzed0liI2mEK/GEse5hVikd2iEZl9vfIQ8J9a+72CvpvmT+/bMLc3
 pCokxqY+6rOpKzqE5NlEBvcE2hBIz94/3WksuuzFUiVZo1KVnJrhalFQcgVKW+puHB3c
 h5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703717617; x=1704322417;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=365qb37Q0DAEuqITeiMUwz6y92ad6Qj2aC2LOO58cWQ=;
 b=nDrqqlq8a4crqLh9ddN6OxO92ih0b/aJ1GgfSi65eNmA/CCZihzNyaoURWVquwDG2t
 LjKs4GO3rEjMqWa59lvf4EoD9Y6h+Qsjlq0CeD/DcF4/kAetG9bq+ukjL+n3GdVk4ASh
 PvUZcV7tLcn7H7PmocUQPaVVhUNJbcZburEdqsFOZ6Fbe/egfl93dJTjcXsjh+XQ4OOT
 CQZCR8Og8Aq90qhH54W+tj3KtMvroiueA2G+kM0mq3lGeel852jd5XU0DYsPpivDxkZl
 QQCSfiOZlho7OliY7pNinZdSSVC5wcYuS052te2Jm90qcdWF80KvkDeEtuxZoVHv7/ZF
 w5Bw==
X-Gm-Message-State: AOJu0YzyTyjdUZMh05VfjkdzjnPUqTaxvtNawaYiaVLiGzOmhhpcorzB
 MfQuhAmOFLqoItlcH3Y0dKhGrye0bTFvpA==
X-Google-Smtp-Source: AGHT+IFlonY13x4FEM/QJ/xLI1XemXU9go53jKy+u3PV525gjkpaP7Srql2G+D3x/zcrkRsnCa0Teg==
X-Received: by 2002:a17:902:7b81:b0:1d4:6dea:9ad9 with SMTP id
 w1-20020a1709027b8100b001d46dea9ad9mr3621541pll.51.1703717616918; 
 Wed, 27 Dec 2023 14:53:36 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a17090264c800b001d1cd7e4ad2sm12800875pli.125.2023.12.27.14.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:53:36 -0800 (PST)
Message-ID: <578cbece-f2e1-4330-954f-43865bec639c@linaro.org>
Date: Thu, 28 Dec 2023 09:53:33 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/35] target/arm: Treat LDTR* and STTR* as LDR/STR when
 NV, NV1 is 1, 1
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-20-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 12/18/23 22:32, Peter Maydell wrote:
> FEAT_NV requires (per I_JKLJK) that when HCR_EL2.{NV,NV1} is {1,1} the
> unprivileged-access instructions LDTR, STTR etc behave as normal
> loads and stores. Implement the check that handles this.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/hflags.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


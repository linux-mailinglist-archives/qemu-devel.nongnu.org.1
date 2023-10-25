Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C26E57D78A2
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:36:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnPT-0002dt-0j; Wed, 25 Oct 2023 19:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnPO-0002SI-Lc
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:35:32 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnPI-0007LL-DT
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:35:30 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5b8f68ba4e5so286796a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698276923; x=1698881723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O2pilWRePzvSoyeM1yhjxkxPGX0uFHZh2Jp65UYM19I=;
 b=Ts4/+UqRrdUGZhH8M1JGWlzW/fWH6WKRFo4cBYxdyr9b4zx2/mvpxSyNazE36I1sTj
 StjFcym05C8bdi9vW0/VBjeWrxYVoeJRbGuJLc1WpVbrgathMT5fL/zSF79380wVJpQ/
 XyOkYcAYrdfCPP1SF6YiAVJ+ro9Phfwd704zX7/hrcB7VgYg+bve7XhwSaoYa1iNyQwV
 pvMuS07z/0PBOL7WYmxcY1aPENs/gjnNr+v/c6f3ufoYHZkzZB/FDdhYYZ4BAUCjppbf
 fTrGFCrQLKjv0OQ/WkDFYMg1Wphcm1uxesq18rCR6xKRI09CTgaWlvbyFkf+Ue5CQzbP
 U7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276923; x=1698881723;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O2pilWRePzvSoyeM1yhjxkxPGX0uFHZh2Jp65UYM19I=;
 b=sHoNLlantY16JFycmNwkYpZtLYX8UtKabbWeZIu40IzGu0H8dKc+5rs0/ADUFpsWGn
 8evRqldJXrtnYGzZvW9dKUMVwol84OBhLGhdxIT1kDfTrexclwcYxcS180rVp+Dnc+KB
 Axoi2D2WZ2Baz68RMFdzw3syHGzD296sID0pbkZ8c3qA+quodmUsaBTYWIR8iYw4OZYK
 D1SFvxIFyB8MH9PoJ6r5DOEXAUv9mUpBQBb3gISLFxvX+mUmq2N3RZJBBNt8R3BsIpet
 lqAdBNYggZ+f0Fv1QNNd8vgVjsBMNZBICwVFs4KDtelHOeLBkSlWUyd3zN3h8DnMS3j2
 ZdZw==
X-Gm-Message-State: AOJu0Yyj82S8Z27GJJ7FPGW3DjH9ArCoSEungL17Ut4bG8Y4d92Zp/z/
 5gkyQID14bpAh1nmNNewwzOE8A==
X-Google-Smtp-Source: AGHT+IEI7f2Sas1yM6dODM5thhLbqGfoAdhJOj0K+ITsTDy9o8+uuyRWZdITjgd5Y+LIa/nKJpZx3A==
X-Received: by 2002:a17:90b:88d:b0:27d:375a:e322 with SMTP id
 bj13-20020a17090b088d00b0027d375ae322mr14440462pjb.31.1698276922803; 
 Wed, 25 Oct 2023 16:35:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a17090a6b8500b00277371fd346sm475304pjj.30.2023.10.25.16.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 16:35:22 -0700 (PDT)
Message-ID: <3c52350e-cf99-4fbb-b8bb-dd07128290fb@linaro.org>
Date: Wed, 25 Oct 2023 16:35:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/arm: Move ID_AA64MMFR0 tests up to before
 MMFR1 and MMFR2
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231024163510.2972081-1-peter.maydell@linaro.org>
 <20231024163510.2972081-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231024163510.2972081-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 10/24/23 09:35, Peter Maydell wrote:
> Move the ID_AA64MMFR0 feature test functions up so they are
> before the ones for ID_AA64MMFR1 and ID_AA64MMFR2.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h | 120 +++++++++++++++++++-------------------
>   1 file changed, 60 insertions(+), 60 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


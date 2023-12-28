Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7560881F381
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 01:58:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIejA-0002GM-CB; Wed, 27 Dec 2023 19:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIej6-0002G8-PL
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:58:20 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIej3-0001VC-T8
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:58:20 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d3aa0321b5so46174125ad.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 16:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703725095; x=1704329895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mnEAOwfXzrlKK0lUl3roWBrEHcVSedn2aQKv5mBA+Ro=;
 b=UtmHPmZf83q+Yj0HmwD58nG8ziCalTchCWENl9IwkNjdyGir70OviCLbfKMQ3D6NCh
 5CnA/D2rpbjAzyXC2oyR3FB6OtCZ+3FziTb0br1JLddTFiQW7qei1evqxCB3K2zuNUHw
 eqRG6op573gOJawAHqasecP5tM9HmBojLLDqToPz8LKTFPuzuRnhULVtkcfhGKsJ5tP4
 BPqZ4ABsteDKMRLtviMS1LKunqTU0iz+wzJCQOh/qYTbuClgLfAQ4NVX2n/42uZhpH66
 LfzLXbEFP+fe6sStYbd7BVoYyZvodcLVVIV+jUJtbmm7Xr9WtTxIGaLMdU6GUxc827El
 9SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703725095; x=1704329895;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mnEAOwfXzrlKK0lUl3roWBrEHcVSedn2aQKv5mBA+Ro=;
 b=ttX1Zy6FFXIxhLl5124zmc6+PiU980B84mxexIGQ9pRy37NOnmGBnNvqNmNN9yw7Wu
 I7AKLlj9C/i9iAQeqVpVoFohYJEBBLv8LhU0L7BtpCDl9qEoRbhwSaPJbt+hxyp90bn7
 18ABx3U2Q5Hjmbg9u87PlYw7Ynz2Siih9cRWh8l4mhmQ2hgryYwIxF8CnHEukorjvaoS
 G1rJU0UannckPi13eLYIvvymWelLr7awXqhKy/OvFHND4UQZEkij/4q84+Fqqov9cKdP
 FpwMVxycE4sUst0ToWn2Q7v0NHRDAPdltsRNUYYFtRSqzPnnCxw34I4NvOOw1MOpPug2
 /hWA==
X-Gm-Message-State: AOJu0Yx03+1YtnKfut06B5HvExPdvne+pcZt5iEnBoOl57oEGy3oDhQT
 Qq4hxMtuMbQs/cBBMTs029ky1hNkHORdrg==
X-Google-Smtp-Source: AGHT+IFr2zDhh7ccPApDvYtLSOiPChH25pmJsOP0Na3fihMULtOD/bvzEunlQEyYUdstjP9dWINhMg==
X-Received: by 2002:a17:902:7ed0:b0:1d4:691e:817f with SMTP id
 p16-20020a1709027ed000b001d4691e817fmr3673440plb.126.1703725095370; 
 Wed, 27 Dec 2023 16:58:15 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 r4-20020a170902ea4400b001d3f285157dsm12580343plg.124.2023.12.27.16.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 16:58:15 -0800 (PST)
Message-ID: <cf50d75a-6191-4946-bf08-db3a31ae64c6@linaro.org>
Date: Thu, 28 Dec 2023 11:58:10 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/35] target/arm: Add FEAT_NV2 to max, neoverse-n2,
 neoverse-v1 CPUs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-36-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-36-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/18/23 22:33, Peter Maydell wrote:
> Enable FEAT_NV2 on the 'max' CPU, and stop filtering it out for
> the Neoverse N2 and Neoverse V1 CPUs.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/cpu.c              | 5 -----
>   target/arm/tcg/cpu64.c        | 2 +-
>   3 files changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF9673694E
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:31:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYd2-0005xv-D6; Tue, 20 Jun 2023 06:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYcy-0005wd-88
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:30:24 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYcq-0001yk-6Y
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:30:23 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f86d8a8fd4so3256853e87.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687257013; x=1689849013;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ClpX5cEhMJ84qtuDhZeVacC8rTiIqSalkuU37T9uZrI=;
 b=AIAPY9Y8Y4mvIzcuNUAJe1jmpC529LT4u88SaSDTcrqwreQ18yNiVEULz/UVBJnw/Z
 djJ3Br8XjF5a8EaRcf7oJM6HtXV++HYMyZHSTRzojoMAWI8lijd5NKLPARkVZinvpXtK
 vZ2ZVrnXfwr/dYqG1CPaMc9mkw7yt94VSA6E2/pFZyDgWsNBtKvhIXzB2ncM3l2ML/A5
 SLwNCFyG3XKEnjPgD1YJbmMgihU6KM6uyo4pU/3fZfb9WO0mohx7JJrLsXQ2dgRMFrYJ
 0nYH0y05JIJDlU8RkQ9PQFEf0Sje2n7nPYVy0bVHVLJ88E9uHLK5CHQnmDhY9PZmRTQu
 XkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257013; x=1689849013;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ClpX5cEhMJ84qtuDhZeVacC8rTiIqSalkuU37T9uZrI=;
 b=PDq7bjVLxADzQecMriGpa0RToaRhRXZ74I6LKS2nPbRMl1FiaC/ip4IopvytOnHUnd
 KWiObx/z1Q3hetgT/kjHJJPRGld5qxJMpEVgwJv79Tw4/0JZ5/uptoU3stHo0S29e6Dv
 ze2sVuViIx4wzhqeyS2ktaAVQNxlIPAcaHWx78LGUMY+zCgvJ/P2Wfvh0AtY2QwoTK6V
 6f2t+Ij7S+EOrM1chfavDOTrOmBZnQc0dQPgoRU1QH2VfDxCJMXyUJofyGoDR/t5VxNM
 grm/4oeQvIsCMUWKySqAdE/UneNwpfwRgk9k+cTnPEL4ME4ttTsA9wOFfBb7/NRZF+tY
 7p6Q==
X-Gm-Message-State: AC+VfDwy1Vm7DrHQ5wBQnSq4ToARfHvLb+lTT9iuEgRAkZaN76dfLarq
 wvC9zJNNyDZWAiciPGtc7TgT/Q==
X-Google-Smtp-Source: ACHHUZ7e6TAFRIY0RL+9lwWcGBdGS5RE3rRN/cNcDG+3EculqyjuE9SMuKuir/fdTvjiVi7NZT7LKA==
X-Received: by 2002:a19:e346:0:b0:4f8:3b17:e0c7 with SMTP id
 c6-20020a19e346000000b004f83b17e0c7mr6379049lfk.7.1687257013542; 
 Tue, 20 Jun 2023 03:30:13 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 j7-20020aa7ca47000000b0051a5437a6c5sm941075edt.22.2023.06.20.03.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:30:13 -0700 (PDT)
Message-ID: <5feda935-d68e-7b71-62a2-156b1c5b83d4@linaro.org>
Date: Tue, 20 Jun 2023 12:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 20/34] target/arm/tcg: Reduce 'helper-sve.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 17:54, Philippe Mathieu-Daudé wrote:
> Instead of including helper-sve.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h            | 1 -
>   target/arm/tcg/sve_helper.c    | 4 ++++
>   target/arm/tcg/translate-sme.c | 4 ++++
>   target/arm/tcg/translate-sve.c | 6 ++++++
>   target/arm/tcg/vec_helper.c    | 4 ++++
>   5 files changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


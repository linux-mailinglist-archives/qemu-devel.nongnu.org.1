Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B59720AAF
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 23:00:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5BsU-0004RX-5I; Fri, 02 Jun 2023 17:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5BsR-0004Qw-P0
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:00:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5BsQ-00042s-1q
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:00:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f6cbdf16d2so23442325e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 14:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685739599; x=1688331599;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TDjR0EH7QMos0IFZKjvWT7+u29DxSXhxrI5pXJeLuVQ=;
 b=PUMjKO0QGOzrvOGuRwcdzIR4lZhLcbfJR/vzppNeBYsKwRY8Ig7qYq1Cpg1Nu1V0i1
 1dQIX8tjY8TK65OjkFF6JR2ILtuqVxNyr3WvqjTXidm5IaJ0jmzLurCfNfDruJxlzDue
 +eyy3etvYEgudEEhZEfORIw0M7CMkbuG1eHltsHMKzm0XZno8RxgBt0ud+0BpBGQfaSr
 UuNJ1DwVmpzfnU4yWuX9uJlSl41WojAgMgx0vZoYYqFFfULAnpSc77DL69Fe6Sc2egN1
 wjfbjxogNrGHbwRFy6S+5WwB54DS8SwwY1JvCTwYTix743mze7tIADmguVxFwJIHjUZQ
 k1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685739599; x=1688331599;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TDjR0EH7QMos0IFZKjvWT7+u29DxSXhxrI5pXJeLuVQ=;
 b=OsNgH+90JEaSNF0f3BiyfHJuJMZ63ZhORVIMAGKNvNCSjyqTIw1ZdDemF71x1x9D9d
 6IndNi1F7nLo5sbMmANDlk+2hAiA+oplUzzhG4xh8zcFUQdtdm3MofiBYeFokxFcMZWv
 Lo2LpBW11nZFVDkQqQHuGQCKmI7ULPGTRDdHSEuhSs6FASl+EMY+vt3bEcKDW+nqwqya
 coNwLUqloilvZyWjzXdR9gtCgpII83/hQaQIPU3FmUlgjVBoc9FL+DGLwuHDTgyoSeZs
 yHiTbOlxJkbrISf7h+iS6URJKnLL23R/FXMJUJakXDhe4WxK6EzS2uxnRwBWNN+Ztlbl
 rd3Q==
X-Gm-Message-State: AC+VfDz9PkWdac+089ISwM683Q5gUYCx/dHq0HvNN3RR+h6zr7NpmPSK
 ujNg10D12iq3v2rEjO+xok/UfzTO/GNnS+thtMY=
X-Google-Smtp-Source: ACHHUZ6hWisAe0Y5pM8mNo9vlJFIcSuAuCmEAwmJyis8sly8l1ITn16f1hcAEKAuT9EymXP3GtYY2g==
X-Received: by 2002:a7b:c5d2:0:b0:3f6:426:eae with SMTP id
 n18-20020a7bc5d2000000b003f604260eaemr2779837wmk.15.1685739599624; 
 Fri, 02 Jun 2023 13:59:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a5d4282000000b003047ea78b42sm2594519wrq.43.2023.06.02.13.59.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 13:59:59 -0700 (PDT)
Message-ID: <5f368f78-e3f9-c2e9-79c3-3f549051ece4@linaro.org>
Date: Fri, 2 Jun 2023 22:59:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 42/48] tcg: Fix PAGE/PROT confusion
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-43-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 31/5/23 06:03, Richard Henderson wrote:
> The bug was hidden because they happen to have the same values.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/region.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



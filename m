Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2426B70E40C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:50:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1W92-0002TY-KB; Tue, 23 May 2023 13:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1W90-0002OD-Q3
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:49:58 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1W8z-0003Eo-7T
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:49:58 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso66688b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684864195; x=1687456195;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MFDeKYNhzW5LPD9hj/JuzMFAFSB9w9UyysZyv1sLGJ8=;
 b=D6dh4Oa8ENFV9c9SXnm5ieanYdR7QSRVwHdDoHFe4K5dNKMQv6tNRj0lDl75+058J5
 pJ2iNZWhvjcxUOUwb1KhlkEb6NDyGr3WOC1lupK/jjnN+XO5crYFdT+DC33KNQGcTQ5S
 4bOcH2p88kQe4xXUak4H1MQdZWu6FUcHdyQgF5N5fs455vakSK7FHXD0ZbaJ5s8mSOd0
 /bpcqUEe3zY8CYGUaYS3afGO373UvGP8oikGtL3b2tUdBezTBQScF0c/rW+1jjuQVaJr
 SERgQitLjpDBWf8/vJzCnxVZWNMDUllBpK1PED5ReDwQMZ/b4OIADtA5m1sRzaF9V8KZ
 155Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684864195; x=1687456195;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MFDeKYNhzW5LPD9hj/JuzMFAFSB9w9UyysZyv1sLGJ8=;
 b=DMAkpy6ge/U9nioktdt43IZdjiWNwkzYpgF1xlu0ym9g1jyFKz2bf3MPqpmTJBIy9n
 HDD+ZeYzTstgY/PK0chv9SSnrdU61WZV5lAQoVrkF/rS3TaXYQzQnFDKMeUFrP0E0Nia
 1fWdmSJu0eLfI8GyXCmpYEXajDAWwfOxfY/Yuy6b5Mzh2FzBWIajgCVFYuBHwO3dTj4e
 DV5yWaoPKHxVipNi9BfAje4rOtZihbidIg3svovSctMA4kIndHbdaGf+ruamPLO4+sU3
 ZvvZCwAP/2jDltxgi4ZJ1GA/q9oK9nXZewweXdkwUUjGJej23uMVwbtuxUhdSWBsN4Tz
 2lgQ==
X-Gm-Message-State: AC+VfDwiHYKVZKuySyE4QUQPoju+/yyr9U5YBk6y8HEzgTx8BKBvwX6X
 j/1f7pja2xfEO/4NTvcxV0sgGQ==
X-Google-Smtp-Source: ACHHUZ7r2WogQOMrXjkYJILT9/DNJxH+CIlrITlVnRYeR2Hl8iCNNlzVm0WRakPUSvFy3q2Lc7g0Kg==
X-Received: by 2002:a05:6a00:1a46:b0:62a:d752:acc5 with SMTP id
 h6-20020a056a001a4600b0062ad752acc5mr22431663pfv.32.1684864195556; 
 Tue, 23 May 2023 10:49:55 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a056a00270600b0064c98c87384sm6018421pfv.44.2023.05.23.10.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 10:49:55 -0700 (PDT)
Message-ID: <2394ce4a-85a1-40df-da75-c0eea4fc8e6f@linaro.org>
Date: Tue, 23 May 2023 10:49:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/6] tests/decodetree/check.sh: Exit failure for all
 failures
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230523120447.728365-1-peter.maydell@linaro.org>
 <20230523120447.728365-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523120447.728365-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 05:04, Peter Maydell wrote:
> The check.sh script doesn't set its exit status to 1 for failures in
> the succ_* (should-pass) tests, only for the err_* (should-error)
> tests.  This means that even on a test failure meson will report that
> the test suite passed.  Set the exit status for all failures.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> In an ideal world we'd tell meson how to run each test, so that
> we got per-test pass/fail/log information, I suppose.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But I've also just sent a conversion to meson.


r~


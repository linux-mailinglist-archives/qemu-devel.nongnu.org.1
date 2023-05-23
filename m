Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 408DF70E47E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WcS-0001AD-RG; Tue, 23 May 2023 14:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WcP-00013I-7Z
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:20:22 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WcM-0002eZ-5Q
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:20:20 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ae507af2e5so1360005ad.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684866015; x=1687458015;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3VsGEG5wcvrY+HW+erps92WjCYWVg4pemd0avCLo9hw=;
 b=aRjUj3JEoE7FZfEOtkz1lV7rexuIhAgqD51yO185rKxB2j+Az3WMvu+Dpq63op7/b1
 QxyDvkbxZJ2lPwprHg+o6hzozaThT1iHl+V9NRgzQb3SE8H5I9Tn+1Z3/jwnedjnfNTQ
 DNotPy4XxuGnk/Bi58OR5wOKiGxV+YEETFpdpRaZzeMTTmGc/I/GSOC2rbYLXvNrzL/Y
 +zVsDlg9uH/7T3Awev/4svvZzQOEFI1aRB1NBiTigBrpi7iE9s4/sm6CbL6U2lX7yHFS
 OuSWhQBJ4VyeJXh2YqZYrsC1ci0LAr4zgTWH+bZcOrw3AfbwLHXSryHMVGCxInaxTG1d
 6Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684866015; x=1687458015;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3VsGEG5wcvrY+HW+erps92WjCYWVg4pemd0avCLo9hw=;
 b=X7KDSGmBXqN7YCMSYAlo4F2N0MGCxGparj6vTQQw5GKOVH13yfBn4ExGYxpEN1Kl4I
 R/I3EPr9sNe26LnR5Ft1f7PmbdY5CBEfTUEiDmb7YFzP/SzBdnCVWJN7CoYN5MMysSXr
 RRlY1t0l9oSVfEs91rx2rrEckx3eUGEbhMKRpJpo25jKbJtQr2qDdEY+mSYrSa563RGs
 eQ7rGFTCjf8tJKtEvefc7ZemM/+Se/c3orAwXm7aTKCgRpfszwqiYS6cggn7CpKctM1V
 QXqrtU4OhtscmDvOH1YoFxlq2gNjptI/omxV7tzsOiEh2F46ptSfVNkpRmFOHBkn9IWW
 nx2w==
X-Gm-Message-State: AC+VfDxQbp6qHcvzLR1xfrAMdQBgPzYa6njvs07030XNRx2pPF5N+EUX
 kGgg+Y5qVBvbjWsuXLtz//3RJhLS0DwFzT67NIw=
X-Google-Smtp-Source: ACHHUZ4M6DDtPMj06nFyKC0bmtOIWU7lUVaypri1rayyq3draeIH+vpwKgdGWu63Pxn2W0B7oBwfjQ==
X-Received: by 2002:a17:902:d48b:b0:1ae:9105:10a5 with SMTP id
 c11-20020a170902d48b00b001ae910510a5mr13936978plg.2.1684866015408; 
 Tue, 23 May 2023 11:20:15 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170902d50b00b001a641ea111fsm7075101plg.112.2023.05.23.11.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:20:14 -0700 (PDT)
Message-ID: <518325d4-c385-014f-238e-562b03667add@linaro.org>
Date: Tue, 23 May 2023 11:20:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/6] tests/decode: Add tests for various named-field cases
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230523120447.728365-1-peter.maydell@linaro.org>
 <20230523120447.728365-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523120447.728365-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
> Add some tests for various cases of named-field use, both ones that
> should work and ones that should be diagnosed as errors.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   tests/decode/err_field1.decode       |  2 +-
>   tests/decode/err_field10.decode      |  7 +++++++
>   tests/decode/err_field7.decode       |  7 +++++++
>   tests/decode/err_field8.decode       |  8 ++++++++
>   tests/decode/err_field9.decode       | 14 ++++++++++++++
>   tests/decode/succ_named_field.decode | 19 +++++++++++++++++++
>   6 files changed, 56 insertions(+), 1 deletion(-)
>   create mode 100644 tests/decode/err_field10.decode
>   create mode 100644 tests/decode/err_field7.decode
>   create mode 100644 tests/decode/err_field8.decode
>   create mode 100644 tests/decode/err_field9.decode
>   create mode 100644 tests/decode/succ_named_field.decode

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


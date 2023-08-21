Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0054C782F7B
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 19:34:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY8n3-00058J-K5; Mon, 21 Aug 2023 13:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY8my-00053K-NJ
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 13:34:04 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY8mw-0004J2-Ce
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 13:34:04 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fef56f7222so5250985e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692639241; x=1693244041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=18KtdlXGbR2sOXS0a2JOX+svZCJ4qvm9b6Ro1RVEOTM=;
 b=CduA+esDv+ZydfNcen9V0avUUzTHB4ZVI1sUKrmSRU/No5YGF4q+rCpni8/WJqQodL
 PT3AXJ/b3VGcVvrwFWZBEs9J53U/k7SXtnauyIKFkWv1RrdtBbXO4NaoKz6H+KXjV3ib
 9PmyURYBBZe6Xp6NVUvoP2/vIRHTz8Z+VSL63ReU4jDcmvPp9FOWjbGiNEh+u7WwvkXX
 XuGcisO07rDJnIehRxsKf5Up3O656hkMypHM3jYUMemKo0F7vjI8OKyrRFGHZikZJIyW
 LMcS469AWhiSHFIYcltSHs1JAKmhivmFzmsNs99jA3wCLkDSGQLtVRnuL4p/t57kAAdR
 krvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692639241; x=1693244041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=18KtdlXGbR2sOXS0a2JOX+svZCJ4qvm9b6Ro1RVEOTM=;
 b=h42tknYUVKHJeJnop0V7O6MKRn9qS/4L3p0dxSRjjvFgiLmoS1L1Z4QtceqChiuC3g
 B41Y7je/jetfqOtf0C0HKtT08H9jY4oh3MSMoBMwT14xJ8mwBpiKsUSD2gqk0GYV09vj
 tSm0GZ4/pXaor2XbTyuPzJ30l1PHMHZgj7tJyrmObEuPOxmN2IdFlkadZ8O0Bl7nzLnv
 6/1r6pAl7oKZsUGECHQo5hfdVu2OCQnIotDUSjlVlXgWgf4LbWDUujaTarc7WoDpIzKK
 kDuXLBsBXkabMbkuUjmvCjpA26yHzegwY0rjJvGqiy4/fw95veO36ampHDoX5OVwPK0/
 2eaA==
X-Gm-Message-State: AOJu0Ywd1xHNaE73XwUKnG90NNcJ8u0/9m8er3VDHkeZiRaujlsJnDjK
 9JDA2Ytc7eL4FpYgPYP5rIaGgQ==
X-Google-Smtp-Source: AGHT+IFTcA5EFuOg3ycxVGJ1HMGtLr7ihOWGMV3lHtSSAtltK5XOGA4otplet3BeKE1MWsX8xsrQuA==
X-Received: by 2002:a1c:4c04:0:b0:3fe:18d8:a61b with SMTP id
 z4-20020a1c4c04000000b003fe18d8a61bmr5562277wmf.29.1692639240789; 
 Mon, 21 Aug 2023 10:34:00 -0700 (PDT)
Received: from [192.168.69.115]
 (cor91-h05-176-171-248-246.dsl.sta.abo.bbox.fr. [176.171.248.246])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c040c00b003fe2397c17fsm16897591wmb.17.2023.08.21.10.33.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 10:33:59 -0700 (PDT)
Message-ID: <5840b259-1287-cafa-e95b-d80598310888@linaro.org>
Date: Mon, 21 Aug 2023 19:33:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 19/19] host/include/aarch64: Implement clmul.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230821161854.419893-1-richard.henderson@linaro.org>
 <20230821161854.419893-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230821161854.419893-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

On 21/8/23 18:18, Richard Henderson wrote:
> Detect PMULL in cpuinfo; implement the accel hook.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/aarch64/host/cpuinfo.h      |  1 +
>   host/include/aarch64/host/crypto/clmul.h | 41 ++++++++++++++++++++++++
>   util/cpuinfo-aarch64.c                   |  4 ++-
>   3 files changed, 45 insertions(+), 1 deletion(-)
>   create mode 100644 host/include/aarch64/host/crypto/clmul.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



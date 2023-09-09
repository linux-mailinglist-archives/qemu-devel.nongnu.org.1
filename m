Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 048B4799A16
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 18:55:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf1DP-00059V-7N; Sat, 09 Sep 2023 12:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf1DN-00059E-HY
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 12:53:45 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf1DL-0004sZ-AO
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 12:53:45 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a440a8a20so2894145b3a.3
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694278421; x=1694883221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2pRqy5toNnN9vCDtrYvDbygxTzH5HJnKC176qwibKrg=;
 b=R+KpYnChlBTH8TsqHelOP9xd1NiFBfXRz3hnzRcQc/grg/gWY+VPfN/utqzCVPcVWo
 /xxvTAE0LJhAIBNUBFdSRn3g54QU+s/6aMfkcE+ivpqCaAnuuixG7sxfmhfLAxWBb2AE
 6ltP/Njoqd/U/GM05qTlBa3+tiMkHgIxoOqtzHmhhU0OkDl2pl1pt31iLJDrNbh7/8TW
 55jelKOE1i3+Lu4GElhIy9GIJSW5jHOfrG2oNGrvwpTgniHBI6jcI6eF6rQrJsA4sFKe
 n7+Qj4fuPJEp4HMhq9Gf54XLxXrcq4UweF211OP6tSZPDlbMqgBy3fbp5m792Yt7RElT
 JF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694278421; x=1694883221;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2pRqy5toNnN9vCDtrYvDbygxTzH5HJnKC176qwibKrg=;
 b=OnTYPPUxbZE+m7lnFYhGYCpUoyjPX+bBb1eeceBl9H5X2LIxNFFK71DjWs2WljqcTW
 dM7UVAcTK+GPRl2tIu2iM5qpuCvtpBLHLtP8Q4p0hDVsdhIuYMvdOGTkiYqVAEquT5vC
 jxUOZBa4YVa5xe1fJZqcIjRCCECVJNai5MWtvS6OKiyMqlnWd7uEWXWwdxvsaMsPcRFi
 Ne1IAHk0c+wZnL1JGKMXf8fRx7wVgKn0ZRwBQ1U52E9h7v7mmfY1bdoRYWZgpVgbbqOo
 WP2hVjtL7clLy7geFABPR9zyuj7MZgKZVancwE7pMX8+PznziEAoTTrBfe6AgBFvpXXP
 3yCw==
X-Gm-Message-State: AOJu0YyTc2IpQhMyQm1ikRC/zxtY4d8CfXGEOuXCODBLQ8K5ac3iSrFI
 zPmZ0Hi5hkl7BqwWfHixKRBYHg==
X-Google-Smtp-Source: AGHT+IEQsAHz15J8HdpVWDm5OkuVUjm9dAiXz7RhRRjT2jB16akMn1gfFCRiLfH0nK6HQ1A4wZQl1Q==
X-Received: by 2002:a05:6a20:3d13:b0:105:6d0e:c046 with SMTP id
 y19-20020a056a203d1300b001056d0ec046mr7528080pzi.26.1694278420972; 
 Sat, 09 Sep 2023 09:53:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a17090aae0500b0026b3ed37ddcsm2986201pjq.32.2023.09.09.09.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 09:53:40 -0700 (PDT)
Message-ID: <e4338a80-c36a-2546-8471-d481c2b9ebb2@linaro.org>
Date: Sat, 9 Sep 2023 09:53:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 14/14] target/arm: Enable FEAT_MOPS for CPU 'max'
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907160340.260094-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 09:03, Peter Maydell wrote:
> Enable FEAT_MOPS on the AArch64 'max' CPU, and add it to
> the list of features we implement.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/tcg/cpu64.c        | 4 ++++
>   2 files changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


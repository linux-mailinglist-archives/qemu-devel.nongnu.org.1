Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5173073A232
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:52:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKhl-00043s-5N; Thu, 22 Jun 2023 09:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCKhj-00041v-4F
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:50:31 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCKhh-0004ip-2b
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:50:30 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f86a7a5499so7543956e87.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687441827; x=1690033827;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hjQNZd3BDm77lXtqXKVNu1kKhGW4DxLqknmFkpEV9Eg=;
 b=BFwLIErXnmYF6Bmffny7xpOiNlsrF1B9w6u/QMsb9FnFUrAxyaZksKh9g58OEVb919
 yNH/y/rY7s/Kb8EBopTyL54mFFLah2N9uZCVwMctYnLLngwfx3JiJXYPSGJKH8FWLs9C
 aHBhyt88Z15pEuOrJOhtsX9swXqh19+9G3vJF+NcOeKJQCiGh3MsPSQgLJ6sCGzuUcBD
 1BpCgrckNFIUmVvb2Y5ZzBC5npOefv1PhRcXdYNpqbdqwSpWtGK4vTDbIIjALQ77LcNy
 95tGw+/Gz/7iqs/IYVeDYh9G4JFDdynMEx/Of1SZQD6tDgecHzowlw2iRMpzPRjFopj4
 GTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687441827; x=1690033827;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hjQNZd3BDm77lXtqXKVNu1kKhGW4DxLqknmFkpEV9Eg=;
 b=H7bXbA/Vdf4Q8yJenx4WF9ic0khxnDhyXnbT3JNlNYXh0DlNq6cgTjmQnG+pKZE6gJ
 2DclTdeOyKGjtj6hKotfEfqisQTv5vBgHqC/Tgpt0J1YWKJDHPyi24rcdgWhG79qhTC1
 NgwWCNi1bNxb/qLMXl8wC5pEFhibOuYP7RQ27ApTSUgnMhYBudcb9ApAxebl5jjb8olM
 7dsT1sOF4YoYSQf3Y2cU/sT57FYSRQo4/qc1lRwiqCYufGaYPGRrZJU6YD1fHa+ugJFc
 vwNqGZk8PnenvBaqS2pyeNdJEZ0IdXGb5HF1vKgjeeVRRtouP8ljQW1wA7dYdtEkvqCa
 osTg==
X-Gm-Message-State: AC+VfDyKjkE7hM2IhnRU6o9qzKKHAc1PNr9Gzf10r4XPAL3imVVZIwQB
 M3z+EApn2RUu8QJ7BJ/KReFW6g==
X-Google-Smtp-Source: ACHHUZ48nGzp5sca0i1X0SF8iqEuIYZ7YWWGeNQVGrHh1d0YlDo5F3tBJEOUVHa7YuE37mYdfzK78w==
X-Received: by 2002:a05:6512:1c3:b0:4f8:7010:149d with SMTP id
 f3-20020a05651201c300b004f87010149dmr8067532lfp.46.1687441826861; 
 Thu, 22 Jun 2023 06:50:26 -0700 (PDT)
Received: from [192.168.157.227] ([91.223.100.38])
 by smtp.gmail.com with ESMTPSA id
 b27-20020a056512025b00b004f87726f531sm1123037lfo.174.2023.06.22.06.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 06:50:26 -0700 (PDT)
Message-ID: <1e159a47-ec06-8369-ab2b-b88150200fd7@linaro.org>
Date: Thu, 22 Jun 2023 15:50:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] host-utils: Avoid using __builtin_subcll on buggy
 versions of Apple Clang
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230622130823.1631719-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230622130823.1631719-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/22/23 15:08, Peter Maydell wrote:
> We use __builtin_subcll() to do a 64-bit subtract with borrow-in and
> borrow-out when the host compiler supports it.  Unfortunately some
> versions of Apple Clang have a bug in their implementation of this
> intrinsic which means it returns the wrong value.  The effect is that
> a QEMU built with the affected compiler will hang when emulating x86
> float80 division.
> 
> The upstream LLVM issue is:
> https://github.com/llvm/llvm-project/issues/55253
> 
> The commit that introduced the bug apparently never made it into an
> upstream LLVM release without the subsequent fix
> https://github.com/llvm/llvm-project/commit/fffb6e6afdbaba563189c1f715058ed401fbc88d
> but unfortunately it did make it into Apple Clang 14.0, as shipped
> in Xcode 14.3 (14.2 is reported to be OK). The Apple bug number is
> FB12210478.
> 
> Add ifdefs to avoid use of __builtin_subcll() on Apple Clang version
> 14 or greater.  There is not currently a version of Apple Clang which
> has the bug fix -- when one appears we should be able to add an upper
> bound to the ifdef condition so we can start using the builtin again.
> We make the lower bound a conservative "any Apple clang with major
> version 14 or greater" because the consequences of incorrectly
> disabling the builtin when it would work are pretty small and the
> consequences of not disabling it when we should are pretty bad.
> 
> Many thanks to those users who both reported this bug and also
> did a lot of work in identifying the root cause; in particular
> to Daniel Bertalan and osy.
> 
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1631
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1659
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> I don't have a setup to test this, so this needs testing by the
> people who've encountered this compiler bug to confirm it does
> the right thing...
> ---
>   include/qemu/compiler.h   | 13 +++++++++++++
>   include/qemu/host-utils.h |  2 +-
>   2 files changed, 14 insertions(+), 1 deletion(-)

Ouch.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


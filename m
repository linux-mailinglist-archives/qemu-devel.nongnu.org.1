Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E352277E63E
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 18:21:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWJFQ-0001G1-GI; Wed, 16 Aug 2023 12:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWJFO-0001FW-4R
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:19:50 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWJFL-0004BQ-Ub
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:19:49 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68730bafa6bso5198192b3a.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 09:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692202785; x=1692807585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gXnTbTf6A4HY57w0Fnc3Ur+Ep689FAD6R3EpGjHk0cg=;
 b=PNBJeotwqJhl1E+f6ZI1OrQ/q600/WnwIdmwBIw5K555QBiF5mXGXl4pEffuQv1EUk
 jsC35l9HUCfc2RHzoqyP7bkBrIF6t6YF3Wyru4UVDo+xHMwtbK1S79QRWIOLVfQ3vDHE
 +rwZGcDsHA0dAJMNTVPypOFC4gcYtsHBnMcMcIcn2/CAxmA6YmBulCR6TKOpYhUkmFy0
 2vTT/UTWLohHzb6gMjNbNVrVxdEXII/bqTHDdscutmrhVuJc0cb78e3KQT1kZY0EhBGt
 HUnZ7cktWigMVEqzD/pa77hMTslBU6F+OGfqjSc6NyYo/mX/7t6KYZCVU3NlQCIUs9Ud
 JFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692202785; x=1692807585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gXnTbTf6A4HY57w0Fnc3Ur+Ep689FAD6R3EpGjHk0cg=;
 b=Ol+btE8xLDfXKMR6V0cqB4mupzjZb2YfC6eqRZHr0N1yaVmIpVWxMEymsMVpyAIoPi
 wPrld0bC9T5dFxYeNEXEWM12OiXlMDMb8B3ye+9s7uI3EJdNP4ABBKDQ9WrABqlRlKHk
 EDMoC4GdSnPToXjptHxqPMThKNyVcbyA50r/IWbMWdNvoLBIey8Z98ug/dSmPPPSIFcn
 BZXw4FZ7k742r5uVsLyR/kZTkGHrflPY1SsvL/YAiYvmc1CjwjIH2UmbU3Ak1JdXCkSv
 bdXQb8BgveBwWalYNc8AWgXwZd6hqg3JZYzvEU2JzCSh60b1JOZLuMBbYvmya0Uo/v5t
 6JNw==
X-Gm-Message-State: AOJu0Yyn36wknoIcHXu0LwOziLQQhDLUhrcv4BLWHt9V6TfbfJvZR+Wm
 6nheQUZi6rXo4nZChBX/aqt1tNYlUvwl7udQEyI=
X-Google-Smtp-Source: AGHT+IGLkaEO++uPFCPiNDqpecVPF/6YavaQzyugXla2VrXzWrefvfZ+NsqGUPfD6kmtooh+CeJ3nA==
X-Received: by 2002:a05:6a20:1455:b0:127:76ab:a6ff with SMTP id
 a21-20020a056a20145500b0012776aba6ffmr174377pzi.22.1692202785316; 
 Wed, 16 Aug 2023 09:19:45 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:a064:e3f9:a812:973b?
 ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a63a804000000b005651c9351e1sm12159045pgf.64.2023.08.16.09.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 09:19:44 -0700 (PDT)
Message-ID: <f51caa46-f26b-0828-18a5-99acf27d786d@linaro.org>
Date: Wed, 16 Aug 2023 09:19:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 08/25] target/arm: Use GDBFeature for dynamic XML
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20230816145155.21049-1-akihiko.odaki@daynix.com>
 <20230816145155.21049-9-akihiko.odaki@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230816145155.21049-9-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 8/16/23 07:51, Akihiko Odaki wrote:
> In preparation for a change to use GDBFeature as a parameter of
> gdb_register_coprocessor(), convert the internal representation of
> dynamic feature from plain XML to GDBFeature.
> 
> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
> ---
>   target/arm/cpu.h       |  20 +++---
>   target/arm/internals.h |   2 +-
>   target/arm/gdbstub.c   | 134 ++++++++++++++++++-----------------------
>   target/arm/gdbstub64.c |  90 ++++++++++++---------------
>   4 files changed, 108 insertions(+), 138 deletions(-)

This is quite large, and I think you could have converted the different subsystems one at 
a time (especially since you renamed the structure, and so both could exist side-by-side). 
  But I won't insist.

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~


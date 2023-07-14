Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B597531E2
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 08:24:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCDE-0005Qa-6K; Fri, 14 Jul 2023 02:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCDC-0005QS-Bv
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:23:30 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCDA-0004Xe-Bx
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:23:30 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-55bac17b442so1191446a12.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 23:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689315807; x=1691907807;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BLPJ3Cw7QFaADYtcIMkSZMv+kIHoWIbOm4PGvEBvHck=;
 b=oK/OVNHf881HNTtV7yKWnsnq8tNiQYe2aIbifCDztOPbHvjQFNr5Sb0k3GSKQNIohX
 Y86atfFUv3VGYCxFH4P5293UKuTZW9MpMHZkYt+U7LQa1Xls/EFw5dIK2d9RgfKfBF1/
 7LntFWn4dvM3IIU+i0WutEFEKcotoTaCPcZtTL/0APC5F7ewBSNlaa57JNKCZ0vAtv2h
 zre6sTz8gXJg7Wj7ecI8ZyBkQ+prEOOTdcFEY2rryHp/1023LEL7KH1fJcjSqUZ4Pxqz
 c5wx1o0hflYAdw4OuGmcBGuBfOTJ6EclcuNy0jDanD0yNN6oSbQugxl2VmlqPb+HaV1i
 tYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689315807; x=1691907807;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BLPJ3Cw7QFaADYtcIMkSZMv+kIHoWIbOm4PGvEBvHck=;
 b=N98L8WdFeMiRpGFbXPaZua6i669jXkbUIEHtjBcnhNFuswy6Kuyg3Dg4/i0o3Hh/YZ
 S0JB4pdQlGq5ALnlMPR8lPcJBQIlz8WiD+xVTpkrkoyumJwbXBhSMC1sRuGs6Dqbu1Lk
 yRIUldAHeaQvzOn44QX2ntOmluk9og+gzofh2aliPd50FA8bBHYbRqLX1+H7wIdh1pew
 paloPv7gXYmsxMqa2znS4oEM77JYLh1ME0wpJY4hZLw6fLD+rZGRtvxGVum8zCPVHNYE
 85cZ0AjAkJTRNN3nKBuKCr0Tnf24rcwi+7TUSWBN9D3UYMWEyRq2Pj36Uqtj1WGvWlYH
 fduA==
X-Gm-Message-State: ABy/qLagEVzzdRrFmDXEWkbPldMvGHLZIe7l3i7OPzC8S8rdJwtqX532
 /Tpr7zsxY+OPoSWJwM41vQf8rg==
X-Google-Smtp-Source: APBJJlFhH7iWeI+wh6P36UX6efmSXuHhKC4oEBRymN71DSOqJv3tlrTZjtoHV3UyXWnYqnKCdpC2OQ==
X-Received: by 2002:a05:6a20:2453:b0:12c:9100:362f with SMTP id
 t19-20020a056a20245300b0012c9100362fmr4364507pzc.4.1689315806822; 
 Thu, 13 Jul 2023 23:23:26 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 x28-20020aa793bc000000b0067f11aa76cbsm6385536pff.108.2023.07.13.23.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 23:23:26 -0700 (PDT)
Message-ID: <c412a56e-0049-f7a6-19b1-12dcfcf0bab4@linaro.org>
Date: Fri, 14 Jul 2023 07:23:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH-for-8.1] linux-user/arm: Do not allocate a commpage at all
 for M-profile CPUs
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Christophe Lyon <christophe.lyon@linaro.org>
References: <20230711153408.68389-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230711153408.68389-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 7/11/23 16:34, Philippe Mathieu-Daudé wrote:
> Since commit fbd3c4cff6 ("linux-user/arm: Mark the commpage
> executable") executing bare-metal (linked with rdimon.specs)
> cortex-M code fails as:
> 
>    $ qemu-arm -cpu cortex-m3 ~/hello.exe.m3
>    qemu-arm: ../../accel/tcg/user-exec.c:492: page_set_flags: Assertion `last <= GUEST_ADDR_MAX' failed.
>    Aborted (core dumped)
> 
> Commit 4f5c67f8df ("linux-user/arm: Take more care allocating
> commpage") already took care of not allocating a commpage for
> M-profile CPUs, however it had to be reverted as commit 6cda41daa2.
> 
> Re-introduce the M-profile fix from commit 4f5c67f8df.
> 
> Fixes: fbd3c4cff6 ("linux-user/arm: Mark the commpage executable")
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1755
> Reported-by: Christophe Lyon<christophe.lyon@linaro.org>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   linux-user/elfload.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)

Queued to tcg+linux-user.

r~


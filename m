Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D7C74F996
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 23:10:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJKax-0005Ao-9t; Tue, 11 Jul 2023 17:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJKav-0005AW-1s
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 17:08:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJKap-00071Q-T8
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 17:08:24 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fc02a92dcfso44707045e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689109697; x=1691701697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zRnvCU7b/U1M1lXqyUEYDfCHJk3iKdwlgTp8puJp12s=;
 b=XqS7B/n6cl+JPAQw07ubWS0v1NTmGIOSMgh5hgYAPQNkfE8Xy3TmeDcFv0ndZn8Pxs
 57FDPvpJFT2xFfkxVnW9OCajePAIgNmlDe2nuJefp9F5s1V3DeJq6WcnXlq2AT/hGgr5
 7WdIC1TQwfodEdmBDPP+8ZHatp7eZCKudEr6b2m19V6OUPavVw/aw9wqwkh4ZmbfEnM2
 AyeJWzvy4ttQeYVfpbXqxxrBgz4N+Z81pFzYn6ARLdthoo+eNyXevTwnC506KTsquCDy
 p7iRMxM1F5zz0YPWt94h9pPucpqmDW2c/3NsOCW3wEwJdTGbJtGToacpuSVPYNLzczoC
 cLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689109697; x=1691701697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zRnvCU7b/U1M1lXqyUEYDfCHJk3iKdwlgTp8puJp12s=;
 b=Ii95cHK4lJ6FaE/a9yPxpHwA9pER9fWoB07zdRDw81b+X2EyjWhxyIWroBN+ojf2cp
 wEh1Lno6DSj3UdEzzl8CwAaO8H5FvYXHlM/X6W5596RX+S3gDg1CsO+d1jXEzA1/CQKN
 Ngz9u51aFQMCYr0hv2Ynq01ZrvmjPyk2Or30qnbN/l5XDL8ztYoDQbdfk4pXbAr0GcRg
 /abOJlEszxddHzG6ukxjD6jfL6E0lIoY9iViVp1Zui90PfeRpksPIYlDJpLzVnfiCCQV
 3qAW5O1TxW79sydzBQc/xfqLn5qLMg0f46Z9+BB6DHKRuLhsILkpb+e5UXasWkEBIkiX
 8j4w==
X-Gm-Message-State: ABy/qLZJM9JlapuSFie0r2MMyamUkvM1Bvo9ldfvB1UBCtlB9inXnJxQ
 jjUlRJz2WBU1Y1lwzquDvj6cww==
X-Google-Smtp-Source: APBJJlHHSDqiAhEZq7Q16gDXMTWxGoURMoACjQCV42g9wkkv+N5ztPOgCgAzlN5Z53f3cy41iKASKw==
X-Received: by 2002:a05:600c:20cb:b0:3fc:f9c:a3e6 with SMTP id
 y11-20020a05600c20cb00b003fc0f9ca3e6mr8074736wmm.9.1689109697415; 
 Tue, 11 Jul 2023 14:08:17 -0700 (PDT)
Received: from [192.168.11.252] ([185.65.165.31])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a1cf213000000b003fc080acf68sm10037446wmc.34.2023.07.11.14.08.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 14:08:16 -0700 (PDT)
Message-ID: <0e498f85-1573-1d9f-ad72-900776b0eb24@linaro.org>
Date: Tue, 11 Jul 2023 22:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
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
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Thanks.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


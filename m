Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA6C709B7B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q02Cr-0001SS-DK; Fri, 19 May 2023 11:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q02Cp-0001PH-9t
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:39:47 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q02Cn-0000Af-PY
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:39:47 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d3578c25bso772387b3a.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684510784; x=1687102784;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ocOealVbkxxtISawBFyEiX8VLW2RQGz3Iy6jl6FEg50=;
 b=l3cWx6XwmkScW09AwEu7f2n20PC4MOjQftswDWABIHeo7tqj6GewMfkyjz7cpQT6gJ
 UDlzxzFglMnu0QzZX9u6o5PcN/QaZTI+s3omHi8gPLxePsMRQyPoT711p7qSuWu7ubji
 S5/oswVJXS2ZaPWqnNr7MTqd3a38tzmTkW0Sh5e/BkAREicD3MfVGEad6ZsavAkyUiu5
 9qxUfDf6OT+bgxemGRANwdrhXwPc7kxCMK8PR09b3Kd3wooBc/1CYpkOecwIrVB/GFAt
 DbbzmZAQXiFcz/eLKbIJcwcrbIxLBDDrHNE1a8hqGP7v359jZ5uWghAGpWIujJrqWwOs
 Fwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684510784; x=1687102784;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ocOealVbkxxtISawBFyEiX8VLW2RQGz3Iy6jl6FEg50=;
 b=hnpEcneKV0wU8EE3BAdoF9Rj9+4bkuFiNySncwkPoBk05tGinlA8YogEzSjWG6I0of
 qMH4VmE1Xq0HXo2q00kji1FnmWWFrbnGi/6XEfgriSXaRqBWv4R0U1uq4++UHQzK6uAJ
 4DWI0bt3sCAwilDdv9eQpu87g9EhEU3yMPD75jd4lIrp9idWq+oIE99V3xVnXckxDisW
 3Nn9sen8M2U5YT2MB1nZqLKDLLVS1PHlT5IB5TA0VarReHgZBfRPdJi5ZJfT8FMtcNGT
 wVckwsNmK8X8PJeSfl+rHkKVFgjkpzbff2JrGOo3wgnO8hOaN62E4KvHdgk6/qZvF7Ng
 +qkg==
X-Gm-Message-State: AC+VfDxs+anfw1Km4+5RheEUXcNNDg2cAcc61r4DCHClB8uAzTrHVNt6
 ff6CLAXKYRKbYPROT+xeNzkYQRbhyTl8CQ/pG10=
X-Google-Smtp-Source: ACHHUZ6ZMgDhG+wPgQh+LEwFpKfRfZCShrHjEfV38oIOfi8GQYq8LNgKhfzc+XvKSUm2uQ6QsRj5Zw==
X-Received: by 2002:a05:6a00:1505:b0:64c:c5c0:6e01 with SMTP id
 q5-20020a056a00150500b0064cc5c06e01mr4238875pfu.31.1684510784053; 
 Fri, 19 May 2023 08:39:44 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:686f:d1bb:8fc4:dc38?
 ([2602:ae:1598:4c01:686f:d1bb:8fc4:dc38])
 by smtp.gmail.com with ESMTPSA id
 b19-20020aa78113000000b0064cf410c0edsm3132303pfi.62.2023.05.19.08.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:39:43 -0700 (PDT)
Message-ID: <597f502c-87de-ba5d-b673-027bed7fb750@linaro.org>
Date: Fri, 19 May 2023 08:39:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: gitlab shared runner time expired
Content-Language: en-US
To: Eldon Stegall <eldon-qemu@eldondev.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <58b8067d-3136-94ed-f53e-2ccd0feb8c75@linaro.org>
 <ZGbFya2IqoDR8153@invalid>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZGbFya2IqoDR8153@invalid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

On 5/18/23 17:41, Eldon Stegall wrote:
> On Thu, May 18, 2023 at 12:26:33PM -0700, Richard Henderson wrote:
>> So, here we are again, out of runner time with 13 days left in the month.
>>
>> Did we come to any resolution since last time?  Holding development for that long just
>> isn't right, so I'll continue processing the hard way -- testing on private runners and
>> local build machines.
> 
> Hi Richard,
> We should have capacity for private runners to execute several jobs in
> parallel.  Here [1] is an example of one that ran on a private runner today.

That is excellent news, thank you.

> 
> I have been thinking about suggesting a strategy to run jobs that lend
> themselves to amd64 linux runners pinned to private runners that match,
> so more "shared" minutes can be spent on runners that have different
> capabilites.

Yes, I think that would be a good strategy.

> Particularly it seems like a lot of people are trying to use qemu to
> support amd64 linux on M1 macs, so it might make sense to have a private
> mac silicon macOS runner.

Yes, we get a fair few bug reports for macos.

> 
> Also, since we have a hardware runner that can run with kvm capabilites,
> it might make sense to carve some of those tests out for that tagged
> runner.
> 
> Since this is relatively new, I think I was personally in an observational
> period before seeking input on those goals, but let me know you thoughts.

Indeed.


r~



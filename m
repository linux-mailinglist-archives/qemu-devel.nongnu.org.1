Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC1A720DB6
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 06:06:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5IVZ-0001j9-NV; Sat, 03 Jun 2023 00:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5IVW-0001iv-7t
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:04:50 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5IVP-00009r-Cx
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:04:49 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-256d1b5f7c0so2229205a91.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 21:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685765069; x=1688357069;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zWIN7139pW3uEdKDeAjNXPh4IDsqgPf+wRv+5xpCjxw=;
 b=cVkiSgsImIZXfB0ZhR9TSv5OhL3Yq7Gig3CrXohfsKEdmCDmPeMdy4oMw8Nqz18JBl
 JW5SRZaAG4N+u5QM30/MGKDgu/Pi6khZgVLRDMboXEnh9Uthnar2szSYKx4TMC17wdtt
 7A4aSzuu8WrdeTPXK3IAQezlb9WpUiSJTct4IMxB/QOYzyac2qIzEfM+VhxBnVzeFsPT
 x0wHruEW6JukaMe9dv9mu9Wce6mOngkF945iNHOPcLALmFvrTaBgo3fYe/IwUBB0fh/i
 tH0RRu4MB8RzF+jfJ0E8kRvVpoKdOCRF9WyDMl+1+WxjBgdUOOzLVQRnIulheIlBUel8
 FGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685765069; x=1688357069;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zWIN7139pW3uEdKDeAjNXPh4IDsqgPf+wRv+5xpCjxw=;
 b=QgFW9NfhSeLlERhuV5LeNtmtXIwdPkYVpozCVKDn1+e3bbdJSi3P9x88zLAthLRgGn
 aIUUNYRXSVaaG/FVmdbKlg64yCqPKrhafCwHuYFWiLQkoFp+8W3nOPw1etOFl37gpz5I
 Xj6V53KOE1/YRgUxnbmtke0W6bn8zGhlus4mGjiXUl9F7lkqwjPeHZoa6RnbHe6pWoLJ
 CTVEmoQ67uALNW0sOHRF16XXjHC0Lnx6+fvdwEa5cB9kafus13eU1BCc+3R0hhpDc/Br
 oFyv7UnRgPInjlL5I9pcTLl2XWeWypL5/M5KDVcOVIdpiG6+V4i+7NohaSmix1Aa2KT4
 TcKQ==
X-Gm-Message-State: AC+VfDx6B0T7SCXeJBQbOqeAdM3hW2Ny4C7BQWheDXqDWtQVOVyDK4sK
 bhnlsNZT2gqtrluCL+/BjF0BlA==
X-Google-Smtp-Source: ACHHUZ667qJ4OB+dk4Bc7NfRov4IDm1uXlf7S5AYrltT+GZ3INvnUqbOVK8kSqF4WjBFdjrCWCrg5g==
X-Received: by 2002:a17:90a:13:b0:250:af6d:bd7b with SMTP id
 19-20020a17090a001300b00250af6dbd7bmr1360844pja.24.1685765069661; 
 Fri, 02 Jun 2023 21:04:29 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a17090a8d0200b0024df6bbf5d8sm1264650pjo.30.2023.06.02.21.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 21:04:29 -0700 (PDT)
Message-ID: <477597b6-737f-1f39-9173-1dc21f97273c@linaro.org>
Date: Fri, 2 Jun 2023 21:04:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 15/48] tcg: Split tcg/tcg-op-common.h from tcg/tcg-op.h
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-16-richard.henderson@linaro.org>
 <5c824199-6da0-85b6-cadf-587eb46294e6@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5c824199-6da0-85b6-cadf-587eb46294e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 6/2/23 14:29, Philippe Mathieu-Daudé wrote:
> On 31/5/23 06:02, Richard Henderson wrote:
>> Create tcg/tcg-op-common.h, moving everything that does not concern
>> TARGET_LONG_BITS or TCGv.  Adjust tcg/*.c to use the new header
>> instead of tcg-op.h, in preparation for compiling tcg/ only once.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg-op-common.h |  996 ++++++++++++++++++++++++++++++++++
>>   include/tcg/tcg-op.h        | 1004 +----------------------------------
>>   tcg/optimize.c              |    2 +-
>>   tcg/tcg-op-gvec.c           |    2 +-
>>   tcg/tcg-op-ldst.c           |    2 +-
>>   tcg/tcg-op-vec.c            |    2 +-
>>   tcg/tcg-op.c                |    2 +-
>>   tcg/tcg.c                   |    2 +-
>>   tcg/tci.c                   |    3 +-
>>   9 files changed, 1007 insertions(+), 1008 deletions(-)
> 
> Trivial review using 'git-diff --color-moved=dimmed-zebra'.

r-b?

r~


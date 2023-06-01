Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C0B7191A0
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 06:11:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Ze2-0000jd-0Q; Thu, 01 Jun 2023 00:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Zdz-0000jF-FP
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 00:10:35 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Zdx-00050r-OM
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 00:10:35 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d3578c25bso549002b3a.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 21:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685592632; x=1688184632;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3o+e8GmsOn5rGqT27wLWvGYBEfpCPrKplX8XoKc0rjM=;
 b=NdQZaFumrVcB4UEAIbxmjIJqsBGlyfqrDqiPuQfUyDe3uiji4+XVVfXGmU8onCPstU
 fvKf4d1KbCJh7vzHEwGLbWa2YKfuq05DQMXvPId0uht8VOvia+qraG/cb4nZi595Zeux
 2bQeO29Qvwn2zjzOCLutCK+QjPAkwFu7pDxG/qRGSg22w36lDVpn2cfTL77o1RK8yNcs
 BLbAU1ItwykkENjqdxWINZGvYB3uf440p3b10CZrL+2ANavF0zM9qFu2fc6IeUQdusUb
 Bp+zv/95C0HfHf67tBTqpeHK22omsV07sCXJuVdzoxDTO9VWuvRygeL3zgnoYrnyc7Le
 xAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685592632; x=1688184632;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3o+e8GmsOn5rGqT27wLWvGYBEfpCPrKplX8XoKc0rjM=;
 b=ce4QJKLNzihjJGVwCpXL5ZAz4k7+7JAEWRf7Qo5B38d5lYHJw/2ou0jUPnpixlj0+d
 5ByP/4zLu6OpmK85yrrGL9E59mzMbR1EE86DA/qJzQQ6iHAzsx3RDYMCoC5KTGn0TMCo
 6A5q/MtSJjm6JKiIC+FqZDqPdNdCdxHBVO+eZUMZwzKbofQuTsMlpXNNf8kJ1Iy6ZXTf
 Busk5N4Rlv9oUzziLHe9fiQxk+ub+Kbddwbunpuzrz4IytHvjHyu3exXrPU1u0OZfFQ4
 MOKwgOMeGU9/RnZG7EPBxR3hGPvey91b/9pKdv3kE2lBvJBlzpL5tMBBZqQBkF7UWkrA
 JQxA==
X-Gm-Message-State: AC+VfDxL7i1zq0Y4QOpFZ/oDjQywncWAKVck59bns+ydM3fVEBIUdz0P
 H8fWiFMjKjHn2WmYCauCRBFqdw==
X-Google-Smtp-Source: ACHHUZ7jqe0U/t6/+mVOJFNbXwVpvWKgvwI9tJAIgWXSvRUMDq4fM3bwa6UR6FMtmzxqcyfzJvtEBg==
X-Received: by 2002:a05:6a20:d397:b0:104:a096:6ac7 with SMTP id
 iq23-20020a056a20d39700b00104a0966ac7mr7566513pzb.34.1685592631845; 
 Wed, 31 May 2023 21:10:31 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 i28-20020a63541c000000b0053efb8fae02sm2089119pgb.24.2023.05.31.21.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 21:10:31 -0700 (PDT)
Message-ID: <cfca5d8b-9caf-d2be-bd01-3d37e0d5f5e7@linaro.org>
Date: Wed, 31 May 2023 21:10:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] decodetree: Add --output-null for meson testing
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20230531232510.66985-1-richard.henderson@linaro.org>
 <731efff0-3230-e3f6-5caa-1b2d1082f266@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <731efff0-3230-e3f6-5caa-1b2d1082f266@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/31/23 18:51, Thomas Huth wrote:
> On 01/06/2023 01.25, Richard Henderson wrote:
>> Using "-o /dev/null" fails on Windows.  Rather that working
>> around this in meson, add a separate command-line option so
>> that we can use python's os.devnull.
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Fixes: 656666dc7d1b ("tests/decode: Convert tests to meson")
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   scripts/decodetree.py    | 18 ++++++++++--------
>>   tests/decode/meson.build |  4 ++--
>>   2 files changed, 12 insertions(+), 10 deletions(-)
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 

Thanks.  Applied, with typo in the first line above fixed, to master in preparation for 
tomorrow's refresh of ci minutes.

r~


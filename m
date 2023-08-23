Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F3C785CBF
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 17:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYqCq-0003cK-S7; Wed, 23 Aug 2023 11:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYqBP-0003Xh-7R
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:54:11 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYqBN-0003Wr-CD
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:54:10 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a7d4030621so3511770b6e.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692806047; x=1693410847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mbo9xthiYpyiuX8HpVhTCj5ZDtbPzcTo+dOqtUXbZvs=;
 b=R8sN/6knwFQjiJ8+RkhqKUvGCP8YbhDJs54RRJGxQgALnVci7ATAd/daaHkksxXHgo
 rq8fNzXA7NVdR05Q4a8QNFAhvMiSmyV2vBqmnbBlOdfkBtKIjLQ2stj3UDXDh+dOF+nA
 fIFCn2Bve2jTDHPhOBVFaZ81DfFD6ouwFrj3bM0fTp5EcFdO9d+BHkXmcLKXjaNWtuH1
 7iNuiEyIvp38cd9G2cwAarf8Qx7vC5/I4eumZLyveBescjpHyB0CPtFv6U5ViOp3Ajkx
 munLZtytWfrtxjRBiwXyKe1kxkcYYCB2SDQgiN0W5jANbl72mcOMdOEO0JuHIkKRW6jE
 yLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692806047; x=1693410847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mbo9xthiYpyiuX8HpVhTCj5ZDtbPzcTo+dOqtUXbZvs=;
 b=j5rIlRqEkc0HC22+IF7G52poW3ojOeJNC9rbuLpodmbLDwYPAM4ZCuY40SWOO0DrIS
 0wx5EkhUrpQjTIs+bIogPRSNeLymr3lYJ2x02+kFvWJ3nTWfqRtT6ADwYSmAbfRN9l26
 zvHjaoKNiaVR17Nh14kRh1e9w4YPUDc0nL53hwEQHRDFhpDXv51d/NUdh75057wcX7a6
 xPLZ/WcNwVCECw9AFbCehVgTEYPJ9Fedeo4Ph1n2W4PD+wHvIOxKfOOuUFcjoapzDuA6
 chorUxhvlFwDB0dYvvKziYJKONO34W75r6lnGmqI0urTQt49Hnw1xPCoh0XqqgEUkfV/
 s6tw==
X-Gm-Message-State: AOJu0YxWpG+YXyQkDqyH5ja1FDiPaE3i0coSEtOCKzGpAaeWHRQIqCXG
 rZ+BV2ToiEYvK9RUWTZ1iFtGzQ==
X-Google-Smtp-Source: AGHT+IGU9mAFGosVeb5/Dcf1wGPgDq1fQsOdwHkWHSN7XwZGl2GzTUVPx3MuFkOYA23BjKrQ1hyACQ==
X-Received: by 2002:a05:6808:5d1:b0:3a7:48d2:fc82 with SMTP id
 d17-20020a05680805d100b003a748d2fc82mr11805490oij.38.1692806047612; 
 Wed, 23 Aug 2023 08:54:07 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:72f0:1ea7:85d2:141e?
 ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a638f45000000b00528db73ed70sm9839306pgn.3.2023.08.23.08.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 08:54:07 -0700 (PDT)
Message-ID: <9c1329b2-83f4-c9e1-6a64-7d78c0cfef55@linaro.org>
Date: Wed, 23 Aug 2023 08:54:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/7] tcg/tcg-op: Document bswap32() byte pattern
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230822093712.38922-1-philmd@linaro.org>
 <20230822093712.38922-3-philmd@linaro.org>
 <fd59f5e2-c125-6d12-cbd5-a12e3aca37ce@linaro.org>
 <6d4f5e8c-82ae-4396-3c4e-fe0bfd721341@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6d4f5e8c-82ae-4396-3c4e-fe0bfd721341@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 8/23/23 06:14, Philippe Mathieu-Daudé wrote:
> On 22/8/23 18:00, Richard Henderson wrote:
>> On 8/22/23 02:37, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   tcg/tcg-op.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
> 
> 
>>> +/*
>>> + * bswap32_i64: 32-bit byte swap on the low bits of a 64-bit value.
>>> + *
>>> + * Byte pattern:  bswap32_i64(xxxxabcd) -> ....dcba     (TCG_BSWAP_OZ)
>>> + *                bswap32_i64(xxxxabcd) -> ssssdcba     (TCG_BSWAP_OS)
>>> + *                bswap32_i64(xxxxabcd) -> xxxxdcba
>>> + */
>>
>> Again, TCG_BSWAP_IZ.
> 
> Whether TCG_BSWAP_IZ is set or not doesn't change the result, at the
> end we have:
> 
>    bswap32_i64(xxxxabcd) -> ....dcba     (TCG_BSWAP_OS not set)
>    bswap32_i64(xxxxabcd) -> ssssdcba     (TCG_BSWAP_OS set)

It changes the input: not 'x' but '.'.


r~


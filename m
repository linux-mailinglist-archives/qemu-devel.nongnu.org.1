Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E60756BFB
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 20:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLSuu-0000hB-Gn; Mon, 17 Jul 2023 14:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLSuq-0000gs-66
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:25:48 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLSun-0004MF-Vr
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:25:47 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-635ddf49421so21139876d6.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689618343; x=1692210343;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9IeOP55QkjsRPNBhlXocf2k3zCG5sDVUepnyS3K59cg=;
 b=wxc1KVGsI/EUOVAYfwFdXfeyxCR0py2DZy/SkGPmEUNgxrpC23l9C8DqY99UsbydKQ
 gzuJ9jbnTskLomD46a/i8/YPK6buQ/IsvgirsttN7V+M8IXsUXPWGOhia2kSo8skLRjt
 /v+OO28M7xOq9vXzAbOPegNNmaaMusvD7NwxlPW3NcA4/P8KXTaflU1fW2C8sQUf1Qo3
 EVVVcmQXq97kyYtJyG9Ksnc8C1iWoslshZ2pYUH3tiHflVcyjx6KazOGVO/gZeHNpkip
 /5kmwf7RvNLGSIth+4sNoTJiSN5bqnW5esieFffbuseXzwqn5kYkns2pJDMQn4XgccFA
 f7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689618343; x=1692210343;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9IeOP55QkjsRPNBhlXocf2k3zCG5sDVUepnyS3K59cg=;
 b=eoRSP9GWe+6z2mTRedQpNuV6MoOCV99sWdrRAqPsyAZ2bXhLaxCgY2m03Jkz49c9rZ
 KJvY0f2UpRQbIUEYRIziEuGAp8OQoYPU+SKOPHRpqpT09HgRFHqu7sgHlQaUaYuPspf2
 BgZ0+8GLMsFgTBXZI3+roZVIJVWwRg7XUSD3LEWtofhe9uCffQ1x4BiSDTTjNYR0yPij
 PztB1eg9/nOubFbUnR6dxVFwAKxaFquxDOZkmbSx/SEHjKIobVGM5hdCGocYO3pSxqAY
 eEa1JvVOwtMK2YzxhQcaMsXtoNqrPP1NXQYt+H2iBA9aGamo4CyMmrRjYhfneyIdOp5t
 UkjQ==
X-Gm-Message-State: ABy/qLYU959R9vyyXqRizZxEA8L8LXNoS5gh65bq11LPZDNVoR70VIKW
 MkspM8YDPsI5k51UpE7hbEQBKw==
X-Google-Smtp-Source: APBJJlFxc0Vyik6vHTNbDuPmEkrRORnWPRVRERmAMUrfoGySDqAuzmYKanJyEp6JABFs94lhaVw/8g==
X-Received: by 2002:ad4:4443:0:b0:637:2dd2:755b with SMTP id
 l3-20020ad44443000000b006372dd2755bmr11092001qvt.36.1689618342919; 
 Mon, 17 Jul 2023 11:25:42 -0700 (PDT)
Received: from [192.168.224.227] ([172.58.27.30])
 by smtp.gmail.com with ESMTPSA id
 kh18-20020a056214515200b0062fffa42cc5sm90251qvb.79.2023.07.17.11.25.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 11:25:42 -0700 (PDT)
Message-ID: <60ac1fd4-f58f-361e-6b37-3226862f296a@linaro.org>
Date: Mon, 17 Jul 2023 16:07:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] accel/tcg: Take mmap_lock in load_atomic16_or_exit
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230716170150.22398-1-richard.henderson@linaro.org>
 <CAFEAcA9dD8SmAFQrt9eRfsMuG3vEh03ex9b+LsgTjg2TRcbiJQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9dD8SmAFQrt9eRfsMuG3vEh03ex9b+LsgTjg2TRcbiJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf35.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.097, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 7/17/23 11:12, Peter Maydell wrote:
> On Sun, 16 Jul 2023 at 18:03, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> For user-only, the probe for page writability may race with another
>> thread's mprotect.  Take the mmap_lock around the operation.  This
>> is still faster than the start/end_exclusive fallback.
>>
>> Remove the write probe in load_atomic8_or_exit.  There we don't have
>> the same machinery for testing the existance of an 8-byte cmpxchg.
> 
> "existence"
> 
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/ldst_atomicity.c.inc | 54 +++++++++++++++-------------------
>>   1 file changed, 24 insertions(+), 30 deletions(-)
>>
>> diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
>> index 4de0a80492..e7170f8ba2 100644
>> --- a/accel/tcg/ldst_atomicity.c.inc
>> +++ b/accel/tcg/ldst_atomicity.c.inc
>> @@ -152,19 +152,6 @@ static uint64_t load_atomic8_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
>>           return load_atomic8(pv);
>>       }
>>
>> -#ifdef CONFIG_USER_ONLY
>> -    /*
>> -     * If the page is not writable, then assume the value is immutable
>> -     * and requires no locking.  This ignores the case of MAP_SHARED with
>> -     * another process, because the fallback start_exclusive solution
>> -     * provides no protection across processes.
>> -     */
>> -    if (page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
>> -        uint64_t *p = __builtin_assume_aligned(pv, 8);
>> -        return *p;
>> -    }
>> -#endif
> 
> I don't really understand the comment in the commit message:
> why would it be wrong to wrap this "test writeability and
> do the operation" in the mmap-lock, the same way we do for the
> 16-byte case?

It would not be wrong.  I was just thinking of the cmpxchg8 part, for which we do not have 
a configure probe, and for which I *think* there's no call, because there are no 32-bit 
hosts that have cmpxchg8 but not the full CONFIG_ATOMIC64.


r~


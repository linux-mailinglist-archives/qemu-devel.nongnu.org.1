Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA057595CD
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 14:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM6WF-00037U-0d; Wed, 19 Jul 2023 08:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM6W5-00036u-8f
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 08:42:54 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM6Vx-0002w5-Mt
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 08:42:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fd0f000f22so3586965e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 05:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689770564; x=1692362564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I0i+I/Td/eZI0KSmSFeUS3CdMdIXpwjAkbaiKSHz/n8=;
 b=MkG2xjyLe3RMkbKghG8/VNhacPjbHqeS2ARN3REWFpUKpsWhexEoAe16wmiDa45xHM
 fKINHm01iA/ah3rCNucY3nRhV6In9g44svGcepoaRqDHbxe5v8HHgVx0CPifgi8tQVwc
 d2kFMRbovFJy2HIzU2Hqjp0PUyGuyXVoBkbMwak3UsnqMg19S9WH+kPlc9P6RBqpdAzu
 ND6fzVmlwzp+tYFYTTHc4t1xTxOzqAd25mVUKBlJOgCg7pNpVmnygQ2nAeJdSkZAEFqg
 hIbITMiAkVdp/9P8/uuPUy3R2CHYApE0jLRdu+3ymD0bafQFExdjiWpa610gLUyPh9K/
 teXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689770564; x=1692362564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I0i+I/Td/eZI0KSmSFeUS3CdMdIXpwjAkbaiKSHz/n8=;
 b=As/C4J0MJbGqBdbT/+JYAWq91JhpdNyZ4EW1gXV6rtgYaIk7dfy2hSP3ZfEhwFxd0w
 OI2KSiIwFJN1jBK41ByDI/t7zFxrbawBmI4wToYpRbKJfFTmIY7sbXpjylMpmJBw4OMm
 fiMlUmAfNWqbHWRVZF7sN01rAvVVrOkYxhz9IuOMSxV3BE1e86AlC0cwbHDVdG8eAk6B
 KEc+OC4ZNidgGgwTrL5ud2IemFqLIKkIYSO3v5RxNv4c73QChO8B1qqh/mZaY/IkOMKQ
 fqhM2F4vOSdWuL79DDPg8lwW/8QGaeTOyJCVAnbtCgaIL9UrcYiVUoKvwS8x8uQ5qNx6
 jkew==
X-Gm-Message-State: ABy/qLb8IDlkG6SaOt2Zm4WpQHEUusIyle+zFKycL298IP60lFo0r09x
 C8kut8oe2RAmiAyFBOqjDA59sA==
X-Google-Smtp-Source: APBJJlE6E8192f+ymy7FbwBjFPYBjcbh/h6iLlMRQUvd1znZG9mqViUaNk+ot1COhSdTeE9+oSdyhA==
X-Received: by 2002:a5d:4443:0:b0:314:358a:64d5 with SMTP id
 x3-20020a5d4443000000b00314358a64d5mr18736839wrr.13.1689770564160; 
 Wed, 19 Jul 2023 05:42:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.201.220])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a5d6289000000b00314417f5272sm5252357wru.64.2023.07.19.05.42.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 05:42:43 -0700 (PDT)
Message-ID: <fb2c25e1-3ccd-3bf2-3694-85f0a24b45d0@linaro.org>
Date: Wed, 19 Jul 2023 14:42:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/14] tcg/{i386, s390x}: Add earlyclobber to the
 op_add2's first output
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230719094620.363206-1-iii@linux.ibm.com>
 <20230719094620.363206-7-iii@linux.ibm.com>
 <61be191f-c1b1-cfbc-d50a-1ee9cdd7d667@linaro.org>
 <ddf29fdedb5dbbe10a0204ed0d3714315e33174d.camel@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ddf29fdedb5dbbe10a0204ed0d3714315e33174d.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 19/7/23 14:30, Ilya Leoshkevich wrote:
> On Wed, 2023-07-19 at 14:08 +0200, Philippe Mathieu-Daudé wrote:
>> Hi Ilya,
>>
>> On 19/7/23 11:44, Ilya Leoshkevich wrote:
>>> i386 and s390x implementations of op_add2 require an earlyclobber,
>>> which is currently missing. This breaks VCKSM in s390x guests.
>>> E.g., on
>>> x86_64 the following op:
>>>
>>>       add2_i32 tmp2,tmp3,tmp2,tmp3,tmp3,tmp2   dead: 0 2 3 4 5
>>> pref=none,0xffff
>>>
>>> is translated to:
>>>
>>>       addl     %ebx, %r12d
>>>       adcl     %r12d, %ebx
>>>
>>> Introduce a new C_N1_O1_I4 constraint, and make sure that
>>> earlyclobber
>>> of aliased outputs is honored.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: 82790a870992 ("tcg: Add markup for output requires new
>>> register")
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    tcg/i386/tcg-target-con-set.h  | 2 +-
>>>    tcg/i386/tcg-target.c.inc      | 2 +-
>>>    tcg/s390x/tcg-target-con-set.h | 5 ++---
>>>    tcg/s390x/tcg-target.c.inc     | 4 ++--
>>>    tcg/tcg.c                      | 8 +++++++-
>>>    5 files changed, 13 insertions(+), 8 deletions(-)
>>
>>
>>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>>> index 652e8ea6b93..ddfe9a96cb7 100644
>>> --- a/tcg/tcg.c
>>> +++ b/tcg/tcg.c
>>> @@ -648,6 +648,7 @@ static void tcg_out_movext3(TCGContext *s,
>>> const TCGMovExtend *i1,
>>>    #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2,
>>> I1, I2),
>>>    #define C_O2_I3(O1, O2, I1, I2, I3)     C_PFX5(c_o2_i3_, O1, O2,
>>> I1, I2, I3),
>>>    #define C_O2_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_o2_i4_, O1, O2,
>>> I1, I2, I3, I4),
>>> +#define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1,
>>> O2, I1, I2, I3, I4),
>>
>> No need for O2. Also can you place it earlier just after C_N1_I2?
> 
> Shouldn't it still be a 6-argument constraint?
> INDEX_op_add2_i32 and friends take 6 arguments after all.

Oops sorry, you are right.


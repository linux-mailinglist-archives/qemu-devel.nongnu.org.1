Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 689A3712B67
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 19:08:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2aum-00076M-MM; Fri, 26 May 2023 13:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2auk-00076A-Qd
 for qemu-devel@nongnu.org; Fri, 26 May 2023 13:07:42 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2auj-0005I8-6B
 for qemu-devel@nongnu.org; Fri, 26 May 2023 13:07:42 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-25355609a04so1073042a91.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685120859; x=1687712859;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7KCFF8fuAyO7w0earSoVfEnZisT63NEg0lck/5lAnKY=;
 b=MD9OQbXogfvvHYEWBd89FvSPyXeYmFFYXfWw1QbMsLfeSZtQxUtDkXRi0VqXwLiF8i
 Svih8KlaAQycgtpZTyMVEOLQLsIMXKKBbhbzUhh6H+GJJumZLLMSNl8KqUHtUQNCgB9g
 0/eULzfOWChcBX/FQSUv5b9lPQDZvtuZT9yB8If5+Oo4eQW3FHP/XqJkla3RC1SpeYNc
 QDQn4QyVCP8TTFuFr1r7uUKFPJycCohiWYp7zfQD6LFEVGLlLUXdB210RvfHzSzJtS0c
 tfNmtFg3Kp4U6Oe4mg6QjiCxXV2/fAapcJajC/z4RebDRtPI2QIdgHLhPQVqzv453Hb/
 hdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685120859; x=1687712859;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7KCFF8fuAyO7w0earSoVfEnZisT63NEg0lck/5lAnKY=;
 b=D0sQ2o6fq0L5Iiu6WWysT1uN8IV0F5VVTNJfz/cMyh4dGqLQrhxzaPLr+vuH1ZXTZQ
 7Ab+PczekY1dVBRtZN0WBjSJkiaHi8GhH/ktJOBtvTjeR/S4mDpo6jNwcxq6BRvA+GyS
 YK8rh9BW2Bvxwe1wn0uzv6owCIZJsI9qKCS00fKnCOoRdgyBfVkBuD1VPcaPNTPzBQob
 bFx4fyspmly7AJ8+9AfJ8s/7/vjxAv1KLVgtXN5yCJ1HCBOtIVoTuDZdkxsM1bB0/6Vx
 uE9VLLkkrIXWvymZDz3I5z12YEHWvNThUIZKeRda2k+8X6nVIv8Ch8i23Xv1FKhqmAUR
 IwgQ==
X-Gm-Message-State: AC+VfDzHdjWkR/brxLXxhdsXpVUXptLJPEci851QU4auELi5UeYtvvVE
 cd3X7hX9cgdNrOfu8fHbwNP6fQ==
X-Google-Smtp-Source: ACHHUZ4pBssw+gBMphAgPVQeHkd6Po8vR3qkUSnYDcziHwpJ4qrVheey6sF3WzCiVdhfkeqd30s47A==
X-Received: by 2002:a17:90b:4a51:b0:253:3cfa:e310 with SMTP id
 lb17-20020a17090b4a5100b002533cfae310mr3083081pjb.19.1685120859264; 
 Fri, 26 May 2023 10:07:39 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a17090a460d00b0024dfbac9e2fsm4752916pjg.21.2023.05.26.10.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 10:07:38 -0700 (PDT)
Message-ID: <aed8ee53-9482-8932-d2e8-d3b520de809f@linaro.org>
Date: Fri, 26 May 2023 10:07:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/6] tests/decode: Add tests for various named-field cases
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230523120447.728365-1-peter.maydell@linaro.org>
 <20230523120447.728365-7-peter.maydell@linaro.org>
 <CAFEAcA-5DvFB1JiCwj1Gb7WUST4-OAyJ8nYDQax_msFZuFNhnQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-5DvFB1JiCwj1Gb7WUST4-OAyJ8nYDQax_msFZuFNhnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/24/23 03:26, Peter Maydell wrote:
> On Tue, 23 May 2023 at 13:04, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> Add some tests for various cases of named-field use, both ones that
>> should work and ones that should be diagnosed as errors.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   tests/decode/err_field1.decode       |  2 +-
>>   tests/decode/err_field10.decode      |  7 +++++++
>>   tests/decode/err_field7.decode       |  7 +++++++
>>   tests/decode/err_field8.decode       |  8 ++++++++
>>   tests/decode/err_field9.decode       | 14 ++++++++++++++
>>   tests/decode/succ_named_field.decode | 19 +++++++++++++++++++
>>   6 files changed, 56 insertions(+), 1 deletion(-)
>>   create mode 100644 tests/decode/err_field10.decode
>>   create mode 100644 tests/decode/err_field7.decode
>>   create mode 100644 tests/decode/err_field8.decode
>>   create mode 100644 tests/decode/err_field9.decode
>>   create mode 100644 tests/decode/succ_named_field.decode
>>
>> diff --git a/tests/decode/err_field1.decode b/tests/decode/err_field1.decode
>> index e07a5a73e0e..85c3f326d07 100644
>> --- a/tests/decode/err_field1.decode
>> +++ b/tests/decode/err_field1.decode
>> @@ -2,4 +2,4 @@
>>   # See the COPYING.LIB file in the top-level directory.
>>
>>   # Diagnose invalid field syntax
>> -%field asdf
>> +%field 1asdf
> 
> I just realized that this specific change needs to go before patch 5:
> it's updating an existing test because "asdf" used to be invalid
> syntax and now is not. Otherwise bisection will break.

Really?  The test still fails here at patch 5:

/home/rth/qemu/bld/../src/tests/decode/err_field1.decode:5: error: invalid field token "asdf"


r~



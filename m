Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6069D7B7C71
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:41:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnyNV-0001RX-O7; Wed, 04 Oct 2023 05:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnyNS-0001OQ-2U
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:41:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnyNN-0006y8-8x
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:41:09 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32003aae100so418886f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696412463; x=1697017263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mPyR7fzdvBJO20jq6WndE4wgUv3adp8c62vlDAveGHM=;
 b=e9YB/61OV1ko+o1r+LSKV6GGy0RjWNKSn22mdWSeOw1j99BtU1JKCu/ZOq5wb2QJ4v
 lWQCA+Z8H74GU9M57iFFjfDEMCb+6mpMOfRdRkZcagV1YMnZQt4AydMjIMhHX6vX97gw
 4mghDSOF+ouhDDYuXP52EdgSeIvvWxx1NC5gQOHXPFLW0AbwCyK24E0ttuZSOHAtcr1p
 cmSfRfh5x5iaRUGA9wNPcec47MQGInBivuctS0/ILJHJZghqLqo7RvCDIOLLSUmJ0wFX
 F0cy4wf9wLyYeD7rcBeTL2jN7qZvuyUeRtDIjrkW51a4SdVdxVJcOmsyU8WmbTuoH+ny
 WmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696412463; x=1697017263;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mPyR7fzdvBJO20jq6WndE4wgUv3adp8c62vlDAveGHM=;
 b=bp27bjOTfrMZHRpPju5jjs5gBSE2pgMgeRQLqTa9niNvSnov3HPNYLmYgOBRy9s5YT
 cEthWZj22+yaeWN3+agtTBydUcVeCwIBDtV5Fo3RqftRaicfV/3RJWUD8PBCSVuaS5LJ
 g/3xyjj0t1CJaeBdIjtucVoRiS1DGIW865jkOG25FND7oeKahxc7UOnn1Az3zlO6/exg
 8QCU9QPAxfFr+zrC/eCUeWUOcfOur85XWlALiv8cHOBtehNWGwjAfI57jtop/RDhbD6e
 M5HHOyXVoLxKMwZ526DlC7vo9QetRmcT5/BQ8aBMpkWZq6o+ixvu8OQCUw86Mjt7U0DJ
 H66g==
X-Gm-Message-State: AOJu0Yy5PPAcAALqSSwWj+VEXDEKjeHwVy8vGUKVFxIrep09OId1KVsV
 7V2aILkNee3930Ejn5dsswp/hQ==
X-Google-Smtp-Source: AGHT+IG5u9t/Fu2nFNQ1orE3UNBHQBQ3LDCyWgqbnTvlCVgYDh7o8ZjNKy38BsKJpGRjT+NHiAt4jw==
X-Received: by 2002:a5d:6801:0:b0:314:314e:fdda with SMTP id
 w1-20020a5d6801000000b00314314efddamr3829028wru.23.1696412463511; 
 Wed, 04 Oct 2023 02:41:03 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 c15-20020a5d63cf000000b003143c9beeaesm3539672wrw.44.2023.10.04.02.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 02:41:03 -0700 (PDT)
Message-ID: <877d2851-09ef-f275-d608-2766bceb7132@linaro.org>
Date: Wed, 4 Oct 2023 11:41:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 18/22] semihosting/arm-compat: Clean up local variable
 shadowing
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-19-philmd@linaro.org>
 <CAFEAcA-rV+VtS=2nVPDuh=bhdoy3LKdzfXOtX_2Shb58i3fS6g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-rV+VtS=2nVPDuh=bhdoy3LKdzfXOtX_2Shb58i3fS6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Peter, Alex,

On 8/9/23 14:36, Peter Maydell wrote:
> On Mon, 4 Sept 2023 at 17:15, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Fix:
>>
>>    semihosting/arm-compat-semi.c: In function ‘do_common_semihosting’:
>>    semihosting/arm-compat-semi.c:379:13: warning: declaration of ‘ret’ shadows a previous local [-Wshadow=local]
>>      379 |         int ret, err = 0;
>>          |             ^~~
>>    semihosting/arm-compat-semi.c:370:14: note: shadowed declaration is here
>>      370 |     uint32_t ret;
>>          |              ^~~
>>    semihosting/arm-compat-semi.c:682:27: warning: declaration of ‘ret’ shadows a previous local [-Wshadow=local]
>>      682 |                 abi_ulong ret;
>>          |                           ^~~
>>    semihosting/arm-compat-semi.c:370:9: note: shadowed declaration is here
>>      370 |     int ret;
>>          |         ^~~
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   semihosting/arm-compat-semi.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> If I'm reading the code correctly, the top level 'ret' variable
> is only used by the SYS_EXIT case currently. So rather than
> changing the type of it I think it would be better to remove
> it and have a variable at tighter scope for SYS_EXIT. I
> think that's easier to read than this kind of "single variable
> used for multiple purposes at different places within a
> long function".

Yes you are right.

Now looking at it, we currently use a uint32_t type, but per
https://github.com/ARM-software/abi-aa/blob/main/semihosting/semihosting.rst#652entry-64-bit:

   In particular, if field 1 is ADP_Stopped_ApplicationExit then
   field 2 is an exit status code, as passed to the C standard library
   exit() function. A simulator receiving this request must notify a
   connected debugger, if present, and then exit with the specified
   status.

exit() is declared as:

LIBRARY
      Standard C Library (libc, -lc)

SYNOPSIS

      void
      exit(int status);

So it expects a signed status code, but we convert it to unsigned...
Alex, shouldn't we use a 'int' type here instead of 'uint32_t'?

>> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
>> index 564fe17f75..85852a15b8 100644
>> --- a/semihosting/arm-compat-semi.c
>> +++ b/semihosting/arm-compat-semi.c
>> @@ -367,7 +367,7 @@ void do_common_semihosting(CPUState *cs)
>>       target_ulong ul_ret;
>>       char * s;
>>       int nr;
>> -    uint32_t ret;
>> +    int ret;
>>       int64_t elapsed;



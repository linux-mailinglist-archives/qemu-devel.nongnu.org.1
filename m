Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9737BB48E
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:52:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qohVb-0007qM-9N; Fri, 06 Oct 2023 05:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qohVM-0007nv-Pa
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:52:22 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qohVL-0004V9-5l
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:52:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4065f29e933so18325685e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696585937; x=1697190737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lkxtq6zBjf5UHtX1+6CZtmIjrMzsgVf/RPnnvqwXTTs=;
 b=xMI4INBz6Kdr164kr8XrH1C+F4KPu4S5PywD+YEUsMDszZe+4FI3L/9D7rJ7vqUdWa
 9ndQsrKUIX8VJlX1YLmH0lYUT19NO9GYEIJvk4WG+86kqGnCgKu9eYFDKrM6ftrII7jL
 MFM6oOLq9HIWuNINAvpwhEQJVTCprZHmUKQxq5GukS1zouHFj0kqkgM9u+nL7L6eg2R/
 Hw36+fILsID2tUcZr/lWV89XL7430+Jd0wl72XZ4r7kL+wnBICTjGj2jqNF5JteJ9cZA
 EN5FA1r5jPYhEcHKM09DxKvTyv7hmdawcBmUs7djRVTWCwCMXaV9omDlRRJpD+L1X4gr
 LqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696585937; x=1697190737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lkxtq6zBjf5UHtX1+6CZtmIjrMzsgVf/RPnnvqwXTTs=;
 b=CXWvtGFcrwLyAhbtNF5eKE4bYg1LA6uEqcL+yiL6pQA9lC+r6RMQQFJnb89UEupjC1
 PagUnj9sQlPLEJGV4SMuIhStbh4PWhczQuPuNMYKrzewsna3s9EPbxruRWBRmUCaV/nq
 I+PU41A5xUGCbqMBCUzuImoVgz8/wukYdAJnfTnVjYv6m4A9oHslO8u+HEyX2Vfj3Amg
 SdSaUYOCDSitOkEzsQO6S8+yIY4WyVeIfH9Ylpiol1PpTLo7+Z0U3eBLCnl0udfDElES
 dPlrwrtY7MGB3UBSExWBtR7o83JnkQZ5LrE6aJ5HcUNXSGR+MWyHT9h8/Lxv5CHMEn+O
 L97A==
X-Gm-Message-State: AOJu0YxkMclzDRN6CQ09ckhsoLFL4k2PS3h3c70aHDpkX/D+1ylVqe0l
 c+qIEfSNko4zk2e8a6Yn6H/mIg==
X-Google-Smtp-Source: AGHT+IEquhbIMFIvLETwotfiSBewAAhyJHScVnXO+vKM63Ld3huKq39YGhDH3tuvoXKh3ta8hfnzew==
X-Received: by 2002:a5d:60d2:0:b0:317:6fff:c32b with SMTP id
 x18-20020a5d60d2000000b003176fffc32bmr7107607wrt.53.1696585937554; 
 Fri, 06 Oct 2023 02:52:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.115.173])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a5d5408000000b0031c5b380291sm1243032wrv.110.2023.10.06.02.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 02:52:17 -0700 (PDT)
Message-ID: <50dbbbc6-9893-a9c6-38a6-124973a7f838@linaro.org>
Date: Fri, 6 Oct 2023 11:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 13/16] semihosting/arm-compat: Clean up local variable
 shadowing
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-14-philmd@linaro.org> <87h6n6h93v.fsf@linaro.org>
 <878r8gp0yp.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <878r8gp0yp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 6/10/23 11:14, Markus Armbruster wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> Fix:
>>>
>>>    semihosting/arm-compat-semi.c: In function ‘do_common_semihosting’:
>>>    semihosting/arm-compat-semi.c:379:13: warning: declaration of ‘ret’ shadows a previous local [-Wshadow=local]
>>>      379 |         int ret, err = 0;
>>>          |             ^~~
>>>    semihosting/arm-compat-semi.c:370:14: note: shadowed declaration is here
>>>      370 |     uint32_t ret;
>>>          |              ^~~
>>>    semihosting/arm-compat-semi.c:682:27: warning: declaration of ‘ret’
>>> shadows a previous local [-Wshadow=local]
>>>      682 |                 abi_ulong ret;
>>>          |                           ^~~
>>>    semihosting/arm-compat-semi.c:370:9: note: shadowed declaration is here
>>>      370 |     int ret;
>>>          |         ^~~
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   semihosting/arm-compat-semi.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
>>> index 564fe17f75..0033a1e018 100644
>>> --- a/semihosting/arm-compat-semi.c
>>> +++ b/semihosting/arm-compat-semi.c
>>> @@ -367,7 +367,6 @@ void do_common_semihosting(CPUState *cs)
>>>       target_ulong ul_ret;
>>>       char * s;
>>>       int nr;
>>> -    uint32_t ret;
>>>       int64_t elapsed;
>>>   
>>>       nr = common_semi_arg(cs, 0) & 0xffffffffU;
>>> @@ -725,6 +724,9 @@ void do_common_semihosting(CPUState *cs)
>>>   
>>>       case TARGET_SYS_EXIT:
>>>       case TARGET_SYS_EXIT_EXTENDED:
>>> +    {
>>> +        uint32_t ret;
>>> +
>>
>> I suspect this could just as well be an int with an explicit cast for ret = arg1
>> because the consumers are all expecting int anyway.
>>
>> Otherwise:
>>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Philippe, would you like to follow up on Alex's suspicion, or would you
> like me to queue the patch as is?

Please queue as is. The signed conversion is done here (well
documented):
https://lore.kernel.org/qemu-devel/20231005062610.57351-1-philmd@linaro.org/



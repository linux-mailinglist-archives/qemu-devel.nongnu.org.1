Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 580887D7CCA
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 08:18:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvth7-0007k0-Jv; Thu, 26 Oct 2023 02:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvtgz-0007gQ-RC
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 02:18:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvtgv-00059F-6N
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 02:18:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40891d38e3fso3860215e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 23:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698301079; x=1698905879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=izueQmn1+pj4TxeWtxbgQ4c4Hr6+8JnyLpG9TK8UQxQ=;
 b=o4gtNqjQTa78e6AnZTi/eR0fmfNx2CBKxRg4ZIcptTvzruCNlz5ggRMt4UG9uirdth
 hi6LG7ydVZPO5y58acwrDj3W18kY7XfeZ3BXK1D2DnICpj6tTIdjLIff3HL2VRJHVm76
 aNcB26szwgHTWAQ1UmvT9zpjFDjQr3j+aw6MMwYdh7BfbcgdOM1RZ7WWKGd3uTfxOeUc
 ybjsZKwxQQmMa0aU7SKZNpE1IhQrUO0xZA67G1hIOLZOT5vXmwdAfJlVNIhqO20U0Zwk
 j27AUmzpE6LY8KvI0jujF8AD+sOpQLHGtdyUCVu5VS+HXvogv/kAmoUKLMWzzc8GgAq/
 t5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698301079; x=1698905879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=izueQmn1+pj4TxeWtxbgQ4c4Hr6+8JnyLpG9TK8UQxQ=;
 b=InhMKDnu2jF0aWYsJfhseCrLnWqZQGmzfRxnstiyT5NK8f3An0r8EXYMy5UdwssYnc
 yOZdG3bHe6fRbBH2/0/9XGlyvtmV+pxqSshDpoCEfzHY/ULRT9BEu/5hsiWWtEbqiCZp
 mwmeD908+1dhYn3TD3uCwLKQjZ+LFbACF2AEPW57WRlQopvIktpk1V6RePnaPvb0cbjP
 R32MamIfoqcIpZPcahN6jiL76S2TDmhhn+pfKxKJm0W6V3kCa0nuBgshA4JfGxy1mBGU
 3JpJi3oSvUvlndDURX05QAMKVsYXEAHPxOfWN3T/S2Z6gdMkB5IIpGUWAdqdoNGEb011
 136g==
X-Gm-Message-State: AOJu0YzUn0djrxPkuNBbi7WGo/wr5imOonKQPnCagSdWBlT09m0jUQ5S
 icMxtSEH0grKyIF4649ADPRNiw==
X-Google-Smtp-Source: AGHT+IGWXxgw0KokUWL7yoAJT9CrCPMib9Fr8fu3LUKTQNXgqbKQQYVfH85vW6dWTAss76KPwvGLGQ==
X-Received: by 2002:a05:600c:1912:b0:401:b1c6:97dc with SMTP id
 j18-20020a05600c191200b00401b1c697dcmr12579627wmq.23.1698301078905; 
 Wed, 25 Oct 2023 23:17:58 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-114-150.dsl.sta.abo.bbox.fr. [176.172.114.150])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a7bc849000000b00405d9a950a2sm1568111wml.28.2023.10.25.23.17.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 23:17:58 -0700 (PDT)
Message-ID: <5f330d44-6e42-3275-8be6-8b06cb40f093@linaro.org>
Date: Thu, 26 Oct 2023 08:17:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] meson: Enable -Wshadow=local
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 bcain@quicinc.com, imp@bsdimp.com, stefanha@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
References: <20231026053115.2066744-1-armbru@redhat.com>
 <20231026053115.2066744-2-armbru@redhat.com>
 <148731e1-7734-6f87-5b7c-e91e0e121880@linaro.org>
 <ad92f0db-7640-492d-a966-4cf883f46308@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ad92f0db-7640-492d-a966-4cf883f46308@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 26/10/23 08:12, Thomas Huth wrote:
> On 26/10/2023 07.58, Philippe Mathieu-Daudé wrote:
>> On 26/10/23 07:31, Markus Armbruster wrote:
>>> Local variables shadowing other local variables or parameters make the
>>> code needlessly hard to understand.  Bugs love to hide in such code.
>>> Evidence: commit bbde656263d (migration/rdma: Fix save_page method to
>>> fail on polling error).
>>>
>>> Enable -Wshadow=local to prevent such issues.  Possible thanks to
>>> recent cleanups.  Enabling -Wshadow would prevent more issues, but
>>> we're not yet ready for that.
>>>
>>> As usual, the warning is only enabled when the compiler recognizes it.
>>> GCC does, Clang doesn't.
>>>
>>> Some shadowed locals remain in bsd-user.  Since BSD prefers Clang,
>>> let's not wait for its cleanup.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   meson.build | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index dcef8b1e79..89220443b8 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -462,6 +462,7 @@ warn_flags = [
>>>     '-Wno-tautological-type-limit-compare',
>>>     '-Wno-psabi',
>>>     '-Wno-gnu-variable-sized-type-not-at-end',
>>> +  '-Wshadow=local',
>>>   ]
>>>   if targetos != 'darwin'
>>
>> Using Clang on Darwin:
>>
>> $ ../configure
>> The Meson build system
>> Version: 1.2.1
>> Build type: native build
>> Project name: qemu
>> Project version: 8.1.50
>> C compiler for the host machine: cc (clang 15.0.0 "Apple clang version 
>> 15.0.0 (clang-1500.0.40.1)")
>> C linker for the host machine: cc ld64 1015.7
>> Host machine cpu family: aarch64
>> Host machine cpu: aarch64
>> Program sh found: YES (/bin/sh)
>> Objective-C compiler for the host machine: clang (clang 15.0.0)
>> Objective-C linker for the host machine: clang ld64 1015.7


>> Compiler for Objective-C supports arguments -Wshadow=local: NO
>>
>> So:
>>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Now don't blame me for posting patches with trigger shadow=local
>> warnings because I am not testing that locally.
>>
>> I find it a bit unfair to force me rely on CI or other machines
>> rather than my host machine to check for warnings. I'd have
>> rather waited this option support lands first in Clang before
>> enabling this flag.
> 
> Huh, that situation is already pre-existing, e.g. with 
> -Wimplicit-fallthrough=2 ... and if you're too afraid, you can always 
> install gcc via homebrew to check.

OK, fine.



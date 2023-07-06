Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2818F749668
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 09:32:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHJRz-00038S-Qg; Thu, 06 Jul 2023 03:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1qHJRq-000386-10
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:30:46 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1qHJRo-0006pa-4P
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:30:41 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3143798f542so277572f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 00:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688628638; x=1691220638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wWuH+5Pz1Egi9rZuQN0gb5NGXUmUpImz8Z0aA1Vhxt8=;
 b=ausk4CyHZVxxOP78X1zq/ATbgaX6p+/JK0lFUjVTVU4x8eC7XaI7iUHRTlcVwcKHry
 VLSYMIzqwF9yJjWx29tfVqDdHx7eB9ASfeVCmOExN+3hEfIHToh0nUVSNY5xxJTQvk+T
 X8WpV8L8NyMizluPvolDYElTBYcoc+Z076vHxe8bzn5luMkN97MyClbLEULdAOj16v/W
 v69RtaLHIMX+7r5E9d4F+dPdRixACkQ+yVA2ut5d7l3em/Q3yD1G1PiDMOkx4L8Y6DN8
 gpYdmjSIclYWLtjbwR76Ntw/GcJ3Ei/1aMxuY+geTuDrJVEyg/VwVH7ocgq8Vgu4mDxW
 DI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688628638; x=1691220638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wWuH+5Pz1Egi9rZuQN0gb5NGXUmUpImz8Z0aA1Vhxt8=;
 b=XAKFtCun+NqP2mRnoyL+3DiqdT2aSYhurmj+Y4iQGeYmMEXIbwGOvJFCw0/bMtGc4f
 m/lQZEP5zu/kpaaz6PBgdC3r5r7kzjekrnpArnAobgFxhWgos/YoNg1MukTNXpJNOH0A
 bYSX3NpZg4ogdZpoyV6mEZTJV4wpuAGD9V9e6+HXDlJx+Y/NJF+ggFaHKLC3Sj1/+fyK
 kQpmChaiHKAuCrhF7NyXG3oBKgYZZ17V7b3A1FE4VCNLT8WBJlwNMb0a2loHKVf3Sd3Q
 miN2WLA7GrvA/rg0E32633BdXq2KWh0LSwY3U3qzCQK3t9fdPIhiI5gBu9ZQl62DjsLp
 GhKA==
X-Gm-Message-State: ABy/qLYXvo/B9yP1PsBRlYqfqBmlsYURDjePqL+O1akQpYkwsicf8bUJ
 jXo/gPir2w4UH+BF0T7WdfxH7Q==
X-Google-Smtp-Source: APBJJlFuB6rkfvzkfwmCnMWyPG3Se9yDLLGtR9DgbYK9M09WtNdn95iKKkeWw5EGN0vbz3YUU9CH3g==
X-Received: by 2002:a5d:4d8e:0:b0:314:3e77:f210 with SMTP id
 b14-20020a5d4d8e000000b003143e77f210mr734383wru.59.1688628637967; 
 Thu, 06 Jul 2023 00:30:37 -0700 (PDT)
Received: from ?IPV6:2a01:cb16:17:9b7:7202:56c8:8848:ac68?
 ([2a01:cb16:17:9b7:7202:56c8:8848:ac68])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a056000004f00b003140fff4f75sm1096500wrx.17.2023.07.06.00.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 00:30:37 -0700 (PDT)
Message-ID: <696064fd-0509-b4d9-ff93-f60385fb00d0@linaro.org>
Date: Thu, 6 Jul 2023 09:30:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] linux-user/syscall: Implement execve without execveat
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, sir@cmpwn.com, philmd@linaro.org
References: <20230705121023.973284-1-pierrick.bouvier@linaro.org>
 <4e5a77e3-17bc-f4bf-b0d3-476469b768c2@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <4e5a77e3-17bc-f4bf-b0d3-476469b768c2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/5/23 17:46, Richard Henderson wrote:
> On 7/5/23 14:10, Pierrick Bouvier wrote:
>> Support for execveat syscall was implemented in 55bbe4 and is available
>> since QEMU 8.0.0. It relies on host execveat, which is widely available
>> on most of Linux kernels today.
>>
>> However, this change breaks qemu-user self emulation, if "host" qemu
>> version is less than 8.0.0. Indeed, it does not implement yet execveat.
>> This strange use case happens with most of distribution today having
>> binfmt support.
>>
>> With a concrete failing example:
>> $ qemu-x86_64-7.2 qemu-x86_64-8.0 /bin/bash -c /bin/ls
>> /bin/bash: line 1: /bin/ls: Function not implemented
>> -> not implemented means execve returned ENOSYS
>>
>> qemu-user-static 7.2 and 8.0 can be conveniently grabbed from debian
>> packages qemu-user-static* [1].
>>
>> One usage of this is running wine-arm64 from linux-x64 (details [2]).
>> This is by updating qemu embedded in docker image that we ran into this
>> issue.
>>
>> The solution to update host qemu is not always possible. Either it's
>> complicated or ask you to recompile it, or simply is not accessible
>> (GitLab CI, GitHub Actions). Thus, it could be worth to implement execve
>> without relying on execveat, which is the goal of this patch.
>>
>> This patch was tested with example presented in this commit message.
>>
>> [1]http://ftp.us.debian.org/debian/pool/main/q/qemu/
>> [1]https://www.linaro.org/blog/emulate-windows-on-arm/
>>
>> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
>> ---
>>    linux-user/syscall.c | 20 ++++++++++++--------
>>    1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 08162cc966..90777c5833 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -659,6 +659,7 @@ safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
>>    #endif
>>    safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
>>                  int, options, struct rusage *, rusage)
>> +safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
> 
> I guess we'll quickly get a build-time error if there's no host execve syscall
> (which looks to be, eventually, compat-only).
>

Out of curiosity, is there any plan for deprecation (or removal) of 
execve on a specific architecture? I thought it had to stay there, just 
for backward compatibility.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


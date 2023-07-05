Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E84B7483CD
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:10:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1KP-00086A-Iu; Wed, 05 Jul 2023 08:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1qH1KM-00085t-Ar
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:09:46 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1qH1KK-0004Kj-80
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:09:46 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-314172bac25so7181582f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 05:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688558982; x=1691150982;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lkr+3Hzdb9pbG1KsieDwKwp4B547qG7b6m+9u/XP3bQ=;
 b=VBkPj1+4scGeoNWtxdHbqllgma993grvjXaYPDBxv7lURVc5QtUtBHAoqPJuBSqiX2
 Sz1GPgPHW2c3DIUdRN7b+LATjQjnisZC5OW8QIPgvmYhIqV0G0I3KBNQLqw2YhW8OYJF
 AtAt+F8xJIhU98XlRgPtl8+4x8Lm5Sl/k/85vIedmPjUlktMczcOJERjrnkovsISSpdp
 JelpkiY0uOiaa9nQdI1ShEbOEIvUqJchnxhG83Q4ENjWGlwI1MMKD95T5vYuvi7+OqVV
 0WDhIfg4B4+ZonJKtMl28t1FSnjV3fdmUMOyG6QiXf7x2ESv958HF94DqpjVODNAQbge
 rLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558982; x=1691150982;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lkr+3Hzdb9pbG1KsieDwKwp4B547qG7b6m+9u/XP3bQ=;
 b=FO0JQuVgXglrWhBMXYuNxOcWfPBagYV7L3kMcApCIL09vURKdqk4/SaNDpRUV+O6he
 GGaYeRtKiaJVHNfeKcqu+O04Sa1wyl+djsQ6fixZHwa+6Qljy2RKnLB4QrRVwUNxjcYf
 OlmyMoWjpHO9zrAPLjZP/37eCmJlHCS4PMj4noMvezKVxz0tKuMXw+PDdalBBF3v7Ncy
 tC21/aac24c9a9Q6o+uuqp8V5P6Q5GOqo3ybcsGYFE3vuDdZ9MSjGLmQDqfTz1qFjy1f
 DLQbCb/lRf/XACJqfu/kILTC2UwKn2gLZtlwCSxTfN0Pfq7uMWTt3RgYItz3UNhcHJGW
 BQ3A==
X-Gm-Message-State: ABy/qLYjRbrlGjKoZsT4Ocppzbqg6/rj8dDXEwswxzWLzPSX8gLQVBWi
 AZ0n7nzmp7M6P6ZAYsidJnIy5A==
X-Google-Smtp-Source: APBJJlGXMfEE72qFESiMkvozHkkHTSAGkegYptRRA0fBE5K+3CRUT0aK8IwpF+gg/lZ0UyARtp5bYQ==
X-Received: by 2002:a5d:6a49:0:b0:314:7c0:c406 with SMTP id
 t9-20020a5d6a49000000b0031407c0c406mr13032951wrw.40.1688558982361; 
 Wed, 05 Jul 2023 05:09:42 -0700 (PDT)
Received: from [192.168.23.104] ([31.32.81.187])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a5d6dc9000000b0030ae53550f5sm30677250wrz.51.2023.07.05.05.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 05:09:42 -0700 (PDT)
Message-ID: <92781c52-f70a-88bf-1ce4-0ef6d9e1d2e4@linaro.org>
Date: Wed, 5 Jul 2023 14:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] linux-user/syscall: Implement execve without execveat
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.henderson@linaro.org, sir@cmpwn.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230705090056.610699-1-pierrick.bouvier@linaro.org>
 <8fbd6900-7c33-17e4-600a-e4799719686b@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <8fbd6900-7c33-17e4-600a-e4799719686b@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x435.google.com
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

On 7/5/23 12:26, Michael Tokarev wrote:
> 05.07.2023 12:00, Pierrick Bouvier wrote:
> ...
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 08162cc966..4945ddd7f2 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -659,6 +659,7 @@ safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
>>    #endif
>>    safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
>>                  int, options, struct rusage *, rusage)
>> +safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
>>    safe_syscall5(int, execveat, int, dirfd, const char *, filename,
>>                  char **, argv, char **, envp, int, flags)
>>    #if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
>> @@ -8615,9 +8616,9 @@ ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
>>        return ret;
>>    }
>>    
>> -static int do_execveat(CPUArchState *cpu_env, int dirfd,
>> -                       abi_long pathname, abi_long guest_argp,
>> -                       abi_long guest_envp, int flags)
>> +static int do_execv(CPUArchState *cpu_env, int dirfd,
>> +                    abi_long pathname, abi_long guest_argp,
>> +                    abi_long guest_envp, int flags, bool is_execveat)
>>    {
>>        int ret;
>>        char **argp, **envp;
>> @@ -8696,11 +8697,14 @@ static int do_execveat(CPUArchState *cpu_env, int dirfd,
>>            goto execve_efault;
>>        }
>>    
>> +    const char* exe = p;
>>        if (is_proc_myself(p, "exe")) {
>> -        ret = get_errno(safe_execveat(dirfd, exec_path, argp, envp, flags));
>> -    } else {
>> -        ret = get_errno(safe_execveat(dirfd, p, argp, envp, flags));
>> +        exe = exec_path;
>>        }
>> +    ret = is_execveat ?
>> +        safe_execveat(dirfd, exe, argp, envp, flags):
>> +        safe_execve(exe, argp, envp);
>> +    ret = get_errno(ret);
> 
> 
> This one has 2 issues reported by checkpatch.pl:
> 
> $ git show | ./scripts/checkpatch.pl -
> 
> ERROR: "foo* bar" should be "foo *bar"
> #161: FILE: linux-user/syscall.c:8700:
> +    const char* exe = p;
> 
> ERROR: spaces required around that ':' (ctx:VxE)
> #169: FILE: linux-user/syscall.c:8705:
> +        safe_execveat(dirfd, exe, argp, envp, flags):
>                                                        ^
> 
> total: 2 errors, 0 warnings, 47 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> As I mentioned in the v1, I don't remember offhand how the arithmetic if
> should be styled in qemu.  At the very best, the v2 variant is difficult
> to read because ":" is too close to ";" visually, an extra space before
> it will make it more explicit.
> 

Sorry about it.
I'll fix it, and use style advised by Philippe.

> Other than that, I'm fine with this version.
> 
> With the checkpatch issues fixed,
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> Thanks,
> 
> /mjt


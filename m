Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D20C07482C6
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:15:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH0Su-0002cY-Qy; Wed, 05 Jul 2023 07:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH0St-0002b3-Dv
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:14:31 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH0Sr-0004GY-Bu
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:14:31 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-992b66e5affso755532566b.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688555668; x=1691147668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t+gTD/VP/iPwL+akZPkVl1SCkyXZuNpJIHDM3AOBEXw=;
 b=xXTmBJwjmc2MWhaNeaEDqDrCDkc4zkwrxxEtNx5TiLFuTTrbw7cJPaJfHqh8rSKmta
 b+uy4x2XT3ClYfn/JD2FYGjTKzF38t0Z0kKKNI+VgzfnssnnfpV1fkcgyUyPTDtGycS/
 SBqBzcvLD0SzDTc7IMYXsvbskOTnMF1EN5CWzI2XqOuX7tX67rRxw3y5gZC9VZY4S7y5
 EjHi0dhn0kPV0lof1OeqG/gswVYRDYR4rtcpGXR8eTR6Pu4jdK8bDsI6VpdXcuO9dGat
 NunMWqk4l69l0lH0CF4+UJ+baQrJ7kLtwMG+za5bas5cuLWd0VR17XjfbCZApbp0RoVU
 KhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688555668; x=1691147668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t+gTD/VP/iPwL+akZPkVl1SCkyXZuNpJIHDM3AOBEXw=;
 b=BVNnA2IG7f/J1zL1ZaFwZTYFEGwifXDDfJE3A6hihThCRtBLSZDL331altG4UkhtYX
 sQrs9LvR6UUI2Y1tAozAUXAI1TBWbGqjwLGU4sPk7rOiEtXc7yuC9setlxni90ZCHCX0
 6w/rQWrC4wS6hN2ppSFvR+7+7apLPdjxwSrQtFo5YwnLJJYn+YK4YfBRpsTXAfn7kzjZ
 HzWRfMZbtbtq2ZsTz8cpwWLQYOd7R3Ww+gIdtyBrXtxm/nyQmU5dHzJIdxt2uZtv1ZE9
 It4XD3ME2pb/PSH0JTQud0sRjwKVfyXpvzp996E68sZ1q9diyscniO8uTkG8A2D6ZfdQ
 DJNw==
X-Gm-Message-State: ABy/qLYeKKNTUi7Ho2G5Zg8cwcnyjNFjULk8sD2pa0b6BTl8hUKMrL5U
 LPhCCAo2R1KS8onMAeofWc8jWA==
X-Google-Smtp-Source: APBJJlGDQHESvHw5TunUo83+HqXNuabDUJggLoCfY5nIBJMaI/t5fDmTd3i2ijmaIKn9Mf6IkHoZVw==
X-Received: by 2002:a17:906:824d:b0:991:b292:695 with SMTP id
 f13-20020a170906824d00b00991b2920695mr11804355ejx.55.1688555667797; 
 Wed, 05 Jul 2023 04:14:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.96])
 by smtp.gmail.com with ESMTPSA id
 bv12-20020a170906b1cc00b00988a0765e29sm14410570ejb.104.2023.07.05.04.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 04:14:27 -0700 (PDT)
Message-ID: <d8dee538-30ad-e116-36ac-64c06003f378@linaro.org>
Date: Wed, 5 Jul 2023 13:14:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2] linux-user/syscall: Implement execve without execveat
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.henderson@linaro.org, sir@cmpwn.com
References: <20230705090056.610699-1-pierrick.bouvier@linaro.org>
 <8fbd6900-7c33-17e4-600a-e4799719686b@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <8fbd6900-7c33-17e4-600a-e4799719686b@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 5/7/23 12:26, Michael Tokarev wrote:
> 05.07.2023 12:00, Pierrick Bouvier wrote:
> ...


>> @@ -8696,11 +8697,14 @@ static int do_execveat(CPUArchState *cpu_env, 
>> int dirfd,
>>           goto execve_efault;
>>       }
>> +    const char* exe = p;
>>       if (is_proc_myself(p, "exe")) {
>> -        ret = get_errno(safe_execveat(dirfd, exec_path, argp, envp, 
>> flags));
>> -    } else {
>> -        ret = get_errno(safe_execveat(dirfd, p, argp, envp, flags));
>> +        exe = exec_path;
>>       }
>> +    ret = is_execveat ?
>> +        safe_execveat(dirfd, exe, argp, envp, flags):
>> +        safe_execve(exe, argp, envp);
>> +    ret = get_errno(ret);


> ERROR: spaces required around that ':' (ctx:VxE)
> #169: FILE: linux-user/syscall.c:8705:
> +        safe_execveat(dirfd, exe, argp, envp, flags):
>                                                       ^
> 
> total: 2 errors, 0 warnings, 47 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> As I mentioned in the v1, I don't remember offhand how the arithmetic if
> should be styled in qemu.  At the very best, the v2 variant is difficult
> to read because ":" is too close to ";" visually, an extra space before
> it will make it more explicit.

KISS, alternatively:

     ret = is_execveat
           ? safe_execveat(dirfd, exe, argp, envp, flags)
           : safe_execve(exe, argp, envp);



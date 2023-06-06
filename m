Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C32724D29
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:36:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6cTb-0007OS-DE; Tue, 06 Jun 2023 15:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6cTa-0007Nx-64
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:36:18 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6cTY-00056t-5j
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:36:17 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b01d912a76so30821575ad.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686080174; x=1688672174;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jr5TwznhxyR1unbJBcqdkZuJ775uNWON7gbhKd+JAtc=;
 b=MI1pGulz0Xk5e006/6FxyvoklXUm5NldXNt5uhQpzmZhb2yN9mAy0fYW3s2zDjOokd
 xVs6eE1xNZPJ2MyzROUY2VF91ONCOHgJxdKcRi6ZGjgmEcrBzpxFa8h9i+PFYH2ePfyb
 ulzcORvvN19hI45V9tHkykEWDP9njXrpB52nXkWG/hIJSwwUotzU+3jcfzh+Pj0KCG5p
 GDPXI4dbVtjkzPuhjumz55pUW9MvoHI9DV5SW5o0LOdppETw0/aQfGZ18Qfh46viXE4j
 fqfq5XJ6ce6l+9oFE3JLj0rpwxmCt+9ulzN1EjwMkAcn59fwtcnfdX+qW05q11ZH+JXM
 9IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686080174; x=1688672174;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jr5TwznhxyR1unbJBcqdkZuJ775uNWON7gbhKd+JAtc=;
 b=SoOZgkP+ajT67CZ6D9v75HZ1OXkfjJ2d2w3aavPvKgivnUIix4/zfDc29XNR3XEV1r
 9Elcz0iGZZvY38/pyuemZTAfFMQRGVfPv7PqM8kLMD0h8rnNZIZO5ewDxJ4aTAM/Mf+5
 BAguh57TENDG7vSfFIz0MinEGHyw7z3Niff0pGGKx07/f+DjVNFMYLrKGPOq1BUrfk5m
 96Huy13r9XdZViJkKZqZtyCciLEe0fVm7l3K5b0Na01dLqUOBJ1D3MjYvvZEFY+RVlyr
 /X9zbSjERUVNd5sPmNLAMhGXuIYDq+T7NiDVqeF14aXhWAlqDzrIPTunmimVB6H6R8sZ
 Uz/Q==
X-Gm-Message-State: AC+VfDxD4IWmAA3ZjC5muvnrQsIuXMMLTHo83gBVm+crPXmde+tYHp8i
 qcURS/35ZtqaZtKY4VawcK9rRuV9jvVU1gP3lMs=
X-Google-Smtp-Source: ACHHUZ4hEtInU9slWIYg+0jgZq+2rX2f/dkgHWPVjmOHhuo/YQlSXyt8g63feXx+jy7yZgge33aibg==
X-Received: by 2002:a17:902:ce8a:b0:1b2:3f01:eb06 with SMTP id
 f10-20020a170902ce8a00b001b23f01eb06mr951790plg.0.1686080174611; 
 Tue, 06 Jun 2023 12:36:14 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 v24-20020a1709028d9800b001b1920cffd5sm8895922plo.267.2023.06.06.12.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 12:36:14 -0700 (PDT)
Message-ID: <55957a86-c976-a42b-9b15-1633390a2f06@linaro.org>
Date: Tue, 6 Jun 2023 12:36:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] gitlab: Disable io-raw-194 for build-tcg-disabled
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, berrange@redhat.com, jsnow@redhat.com
References: <20230606162556.58110-1-richard.henderson@linaro.org>
 <95b2ae8b-e2d3-7554-d810-85aafc1a9c35@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <95b2ae8b-e2d3-7554-d810-85aafc1a9c35@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 12:24, Philippe Mathieu-Daudé wrote:
> On 6/6/23 18:25, Richard Henderson wrote:
>> This test consistently fails on Azure cloud build hosts in
>> a way that suggests a timing problem in the test itself:
>>
>> --- .../194.out
>> +++ .../194.out.bad
>> @@ -14,7 +14,6 @@
>>   {"return": {}}
>>   {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": 
>> "USECS", "seconds": "SECS"}}
>>   {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": 
>> "USECS", "seconds": "SECS"}}
>> -{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp": 
>> {"microseconds": "USECS", "seconds": "SECS"}}
> 
> Is it useful to modify 194.out.bad ...

This is not a patch, it's the testsuite output.


r~

> 
>>   {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": 
>> "USECS", "seconds": "SECS"}}
>>   Gracefully ending the `drive-mirror` job on source...
>>   {"return": {}}
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   .gitlab-ci.d/buildtest.yml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index 0f1be14cb6..000062483f 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -236,7 +236,7 @@ build-tcg-disabled:
>>       - cd tests/qemu-iotests/
>>       - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
>>               052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
>> -            170 171 183 184 192 194 208 221 226 227 236 253 277 image-fleecing
>> +            170 171 183 184 192 208 221 226 227 236 253 277 image-fleecing
> 
> ... if we don't run test #194 anymore?
> 
>>       - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
>>               124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
>>               208 209 216 218 227 234 246 247 248 250 254 255 257 258
> 



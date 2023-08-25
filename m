Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FD37880D8
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRCV-0002KB-W9; Fri, 25 Aug 2023 03:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRCP-0002IW-Bf
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:25:41 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRCM-0004Mu-I2
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:25:40 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4ff9abf18f9so887553e87.2
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692948336; x=1693553136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xz0R2t2eRhZYHrr1LB/v3IF7fgznOpylhFNIUsiaMrA=;
 b=hWALECmlo7Dj9IYJbWCmsvQBufERHs7UCQt9qEW6lnP5HvVDQKz4V6otXemUHKhNY0
 k2XR84cHpXrjCC4ngkJjnlZVL5BslaDj6B46U9ra1n+cEtYV3HgVCI3K1clShwUhhWFB
 2N4zDWG1HkBbwytuL0LWzqVElzY8yrrI8B6HWKingjxkMRliI2kN8yIN5wzVb66+OyL3
 7pBpAY9xes6Y1B3y0gWhqA0bRfeUlz6LBQnBBUfbFKPPjpswAs1r4CGnXhwSo9kR+raV
 rCwf0P+jopm/xzHzGNyni2u8GhVBgcmy6wT5u0XaaiQ1ybDhXn4B1NLuA65jXnPPZLSD
 Ourg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692948336; x=1693553136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xz0R2t2eRhZYHrr1LB/v3IF7fgznOpylhFNIUsiaMrA=;
 b=fdTtiemZDRHZ1bgM5VCqgFm7maJ20yobY3fFMJlvYCIGhOOVvFXPYF3vAO7+2T0VnS
 5B+fHtacOlrJupPelApVDEmFEVFT1RRRBclNWe/gm6ha7DdDFybftBMpFjQPZ2xLPCgY
 k/DNBn1Oo31efKD+V5f89HBxSOjB+iSWnkDbGnykNDBNQRwOLqgBjTsonmyiOpV10wdP
 VcCqmOPPJKFkYrnOlqJroHQF++6LWzuOhKC048CF+yORfQ4B8/+XHQAv/IZ5Zvp9Txsv
 pS/8wOYneNg8GuVfG+gUSHUkDew8bcNfXBBfVI6oYX0x/GWiINA+meQhMh+mg0oZP0um
 1S6g==
X-Gm-Message-State: AOJu0YzwbGQNbFGB5bdKzRuWYuRiKmNPsJM3izr2Ycr1mOA9Pjx7dayG
 zuOtXun6vl44f1YyGghR6k6q+g==
X-Google-Smtp-Source: AGHT+IH+eneaPll9YzHo0YDjIXUjEWvsyCq7hdbBUmqji1p5uM0vVLUpHrYDrpd17lEvJcoN1fzMNA==
X-Received: by 2002:ac2:5981:0:b0:500:9839:b13a with SMTP id
 w1-20020ac25981000000b005009839b13amr3762296lfn.66.1692948336088; 
 Fri, 25 Aug 2023 00:25:36 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 p8-20020aa7d308000000b005288f0e547esm700150edq.55.2023.08.25.00.25.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:25:35 -0700 (PDT)
Message-ID: <1aae8aab-8f92-e30a-7b40-e090aecdcd8e@linaro.org>
Date: Fri, 25 Aug 2023 09:25:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 06/13] docs/devel: simplify the minimal checklist
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: fam@euphon.net, berrange@redhat.com, f4bug@amsat.org,
 aurelien@aurel32.net, pbonzini@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, Thomas Huth <thuth@redhat.com>
References: <20221117172532.538149-1-alex.bennee@linaro.org>
 <20221117172532.538149-7-alex.bennee@linaro.org>
 <82434e83-d156-1a29-fb82-d6127162c185@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <82434e83-d156-1a29-fb82-d6127162c185@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

Ping?

On 5/7/23 13:44, Philippe Mathieu-Daudé wrote:
> Hi Alex,
> 
> On 17/11/22 18:25, Alex Bennée wrote:
>> The bullet points are quite long and contain process tips. Move those
>> bits of the bullet to the relevant sections and link to them. Use a
>> table for nicer formatting of the checklist.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>> Message-Id: <20221111145529.4020801-8-alex.bennee@linaro.org>
>> ---
>>   docs/devel/submitting-a-patch.rst | 75 ++++++++++++++++++++-----------
>>   1 file changed, 49 insertions(+), 26 deletions(-)
> 
> 
>> @@ -314,10 +320,12 @@ git repository to fetch the original commit.
>>   Patch emails must include a ``Signed-off-by:`` line
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> -For more information see `SubmittingPatches 1.12
>> -<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__.
>> -This is vital or we will not be able to apply your patch! Please use
>> -your real name to sign a patch (not an alias or acronym).
> 
> Revisiting this patch, asking for some real name instead of alias
> was at least helpful during patch review, we could address the
> contributor by its name. Addressing an acronym is socially weird
> (at least in my culture netiquette).
> 
>> +Your patches **must** include a Signed-off-by: line. This is a hard
>> +requirement because it's how you say "I'm legally okay to contribute
>> +this and happy for it to go into QEMU". The process is modelled after
>> +the `Linux kernel
>> +<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__
>> +policy.



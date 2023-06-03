Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37260721034
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 15:39:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5RSh-0001tR-N6; Sat, 03 Jun 2023 09:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5RSf-0001tI-Mp
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 09:38:29 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5RSd-0004Sq-Vf
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 09:38:29 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30af86a966eso2699980f8f.2
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685799506; x=1688391506;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U8yaiJw+q8tWJLtU4WABcqyRNULyx37ZadHJ4wOZs+k=;
 b=m3ZKOKVNU8FLg3iTvf5P1cr84wcuHM42b+1TlImTMhUgdMdIRwjEe/REWQ7J5Yx8Ss
 5w3pO8RLzC0rzc8qpuqhxVR8Tt/nlZ1Ch2sUzK9S1Rya5x9KSSv/+YZCMOzrTJeBXN0J
 rLg6PWSmZH9OoM2sdJxwUvHQGanHjFJMB1bbe7a6HsO9mfEWAr/qw6Do6nEf9uwPq/Iq
 CSlMY1tT6weMuC3E81pwCcLY/MkKkHXb6/6fTkbqlOtgzJ4l5By621+jg6+/p9MtyTVF
 AgcB6tFE7NX/H90R4xJxnUu40NNExwK9pNcrRN2N5Eie4+2IOWxRXwwQewGNVoLT7RDU
 oWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685799506; x=1688391506;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U8yaiJw+q8tWJLtU4WABcqyRNULyx37ZadHJ4wOZs+k=;
 b=j0LLYeYUdDSv5MzHBMo8Eql4SLlxriyuvpXVD4i6A/kUf0BLsSHktwTq5501kOYqYR
 hyth1s7uDUg07aYuI2VmfXhEmLlYSt5sQxOFluEzMFVKEcTjKpUf3hGCfJExpEjP8UMO
 goWQClwl78b2a0USjEFLWZGJrbFOBX+3yQzremAVZ4hF3LQAQIh4FKI7GV6KFBUvL4RK
 YAST1lWCNkBj9bb4M6J+bcHysOhm3BtFAhw91nGfl+gprdaNm01Qnwv2HFB8LWIBNrP1
 ydxLaGA72jzNVSlXmYaKCVnucAOhS5Jy96whsZTup24kKLd34ZqT4Qmh4cdHX/DYZLqu
 5o5g==
X-Gm-Message-State: AC+VfDwcQUH8DBhA357w3D/RKo1FYkXEFfDrjkBFVrDLLT6CPEKsPJvQ
 N4ju2wAGUDe4OoxmsqLb23hrbA==
X-Google-Smtp-Source: ACHHUZ7yOwT8aVsgdpN0p5vDTrybLA90T/TYUOHXeSDRApWjJnelp2JiQwNvzPYV3grpk7RWlcDuXA==
X-Received: by 2002:a5d:574e:0:b0:309:4988:7f83 with SMTP id
 q14-20020a5d574e000000b0030949887f83mr2082426wrw.20.1685799506340; 
 Sat, 03 Jun 2023 06:38:26 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.140])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a5d5407000000b0030903371ef9sm4559941wrv.22.2023.06.03.06.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 06:38:25 -0700 (PDT)
Message-ID: <df5d1199-6487-7487-3a95-34453cd04654@linaro.org>
Date: Sat, 3 Jun 2023 15:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 00/48] tcg: Build once for system, once for user
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <afdebaa1-6c7c-af7b-2e53-297576f10964@linaro.org>
 <8a6feaa6-1c0b-0d22-129c-de1e01a67524@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <8a6feaa6-1c0b-0d22-129c-de1e01a67524@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 3/6/23 06:34, Richard Henderson wrote:
> On 6/2/23 14:25, Philippe Mathieu-Daudé wrote:
>> On 31/5/23 06:02, Richard Henderson wrote:
>>
>>>   133 files changed, 3022 insertions(+), 2728 deletions(-)
>>
>>>   create mode 100644 include/exec/helper-gen-common.h
>>>   create mode 100644 include/exec/helper-proto-common.h
>>
>>>   create mode 100644 include/exec/helper-gen.h.inc
>>>   create mode 100644 include/exec/helper-proto.h.inc
>>>   create mode 100644 include/exec/helper-info.c.inc
>>
>> These new files miss a license.
> 
> The old file from which they were split didn't have one either.
> But I think there's no reason not to add
> 
>     SPDX-License-Identifier: GPL-2.0-or-later
> 
> to the top of each.

That would match with commit 6b620ca3b0 ("prepare for future GPLv2+
relicensing"):

  "Contributions after 2012-01-13 are licensed under the terms of the
   GNU GPL, version 2 or (at your option) any later version."


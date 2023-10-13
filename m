Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0187C8C76
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:41:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrM92-0006kA-Vu; Fri, 13 Oct 2023 13:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrM91-0006jx-4A
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:40:15 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrM8z-0002ws-0h
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:40:14 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c9b1e3a809so18097205ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697218810; x=1697823610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x0hwMzEW4NXYgGGazupgEUwRiCIbxvtmUbJERhzngug=;
 b=F+cCtQdi0U04SH/C3Iaj0rWNGOCahJXxvjCgaIW6W3958UnR6dIo3H7wqReOaeFYFo
 0UofLgJ9P0isNOS8MoSOC3i1bEgVeihJ75Tq9JAlgFO8jI7JPZKSxHtnuxwUx6sLy0/A
 P1YrkjZHkoxHY74KgKBnICaySRbfE2DGpeN/lf7m/jXQGbXyZcIUwbbKxT9nq6bKK2zc
 huZX6E6XUWNjLw8sBxkSRu0B5ko9imNOmd6BENClzorBftSHzZ4vErx9a0H2dmhg++qc
 0jijo6cZah/Rvp8rp9ODwuKZZLX1hIhulbb2ovOcQQafrEp30/aMsVVCRYilAsZgQCRp
 4jYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697218810; x=1697823610;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x0hwMzEW4NXYgGGazupgEUwRiCIbxvtmUbJERhzngug=;
 b=SoroBofzuquAYlPAy6mtBri9/w2PJW7Fpsn7N/WZ9xMRudoHSOcMIAMHekSRwT91pu
 VAmbG9IuIDJExNwoClTmDe96cQfQ171g4CJEHC6+VmA8iLK+K6WG38W5f/RwTknE/1EG
 Y+RMBiYIK2GoPVoF4PqTBqLrWHfCXNiFbcjie/4QAwSQTIiwshyoYtM8/6smywd3dVtK
 sF+CN9FLxH0xhdGjmiimM9Vf7PMTRSxpYNrEGh+6r+AGbAjFbdwqHkPMtRHrv0Lx9hvy
 Mj4V9T14bVE0FLRyysWVKJXX2zfKrR6xB6kQc/y/LOjxowmhPmx9iz2Z92RiA/MPWAhf
 +ICw==
X-Gm-Message-State: AOJu0YwYzgBMyj7egBDh9mBtM9gIDjR4qQP70RJmBVtl+sqPsgvVXH7H
 iuJHeJPrbuRGonazoPk/d4A8+BzZetiTmY4UNXo=
X-Google-Smtp-Source: AGHT+IEmvxu9x4V86kJPNsMyPKUUw+3WK9aJz2hVPsbbpndVNvpIW2bHGNfinpoBQSlih6y2XrcA0w==
X-Received: by 2002:a17:902:cec1:b0:1c9:e229:f5e2 with SMTP id
 d1-20020a170902cec100b001c9e229f5e2mr5905799plg.34.1697218810155; 
 Fri, 13 Oct 2023 10:40:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a170902eb4c00b001c444106bcasm4152581pli.46.2023.10.13.10.40.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 10:40:09 -0700 (PDT)
Message-ID: <2346fab5-62dd-4841-927b-33ee1b4359de@linaro.org>
Date: Fri, 13 Oct 2023 10:40:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tcg: Optimize loads and stores to env
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230831025729.1194388-1-richard.henderson@linaro.org>
 <ed9a5058-a26a-6e7f-c6c5-0cc68b016632@linaro.org>
In-Reply-To: <ed9a5058-a26a-6e7f-c6c5-0cc68b016632@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Ping 2.

On 9/28/23 15:45, Richard Henderson wrote:
> Ping.
> 
> r~
> 
> On 8/30/23 22:57, Richard Henderson wrote:
>> This is aimed at improving gvec generated code, which involves large
>> numbers of loads and stores to the env slots of the guest cpu vector
>> registers.  The final patch helps eliminate redundant zero-extensions
>> that can appear with e.g. avx2 and sve.
>>
>>  From the small amount of timing that I have done, there is no change.
>> But of course as we all know, x86 is very good with redundant memory.
>> And frankly, I haven't found a good test case for measuring.
>> What I need is an algorithm with lots of integer vector code that can
>> be expanded with gvec.  Most of what I've found is either fp (out of
>> line) or too simple (small translation blocks with little scope for
>> optimization).
>>
>> That said, it appears to be simple enough, and does eliminate some
>> redundant operations, even in places that I didn't expect.
>>
>>
>> r~
>>
>>
>> Richard Henderson (4):
>>    tcg: Don't free vector results
>>    tcg/optimize: Pipe OptContext into reset_ts
>>    tcg: Optimize env memory operations
>>    tcg: Eliminate duplicate env store operations
>>
>>   tcg/optimize.c    | 226 ++++++++++++++++++++++++++++++++++++++++++++--
>>   tcg/tcg-op-gvec.c |  39 ++------
>>   2 files changed, 225 insertions(+), 40 deletions(-)
>>
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A6782C737
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:24:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPve-0003Y1-6V; Fri, 12 Jan 2024 17:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPvS-0003Xd-G5
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:22:56 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPvQ-0002Xr-Tr
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:22:54 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9af1f12d5so6047722b3a.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 14:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705098171; x=1705702971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hrGhe1NUhsYtDqHujMOz+i96xExYDsCq8Ku+cdUJMuA=;
 b=pD3WM49EugSZhXG1HYke2ppZm2SJU3qk2icWcQg13LCUB5PaltL7iAMU/Kp9DhgPNb
 ts+lP0JGduJtEthByaQShzlo1omFixeWzFXvqH658OHz5oLGVbj4N3o2vUy64DAXBf3y
 Jn7NxFUbwEm1iqgbuDacBvtlRXBCIkkTZIAPkzxWE9uF9ucstTVpY2A8Rsb5iTNaOr1f
 UV6mjW+euGidRksSYTRjgDFQ72hHsgl4SQ8eRYwUb2OMTneBPEk5be0wuDObbs8SuzZi
 BBXqhRkyHrW4TwHAksLIG9vwsiHI+5VnRMovDk2UAw8ZK+yt2KvS4x3X3GqEVcLx5cYN
 Z99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705098171; x=1705702971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hrGhe1NUhsYtDqHujMOz+i96xExYDsCq8Ku+cdUJMuA=;
 b=ZWkRCjj0ucf4w7h0CTtZWuvp8+FtEb5dEWtUdaxPAS25AVJ3gbjRNEEvvZbulAg3Cn
 tE0C6sBV5HZb0QAdOYGq2lhexOXRDJz+6PgAR6+UWr58N57O7R8y+IpMiW3aeg4/XWCW
 NQpKTkweduv6PuR5ofx/humzE+jGjP8y3eqby0K0EFO1Z/ysWtJgyF7EQNatN0TSkZJT
 HVoWTWO3c3F2XxbR2MKJu+T3N8WnQowhwGwUqpU55hnS190eYaE5m2QrS/kELgBfm/Hx
 5/H6r/eIS3jhbD1T8THBSPHvF9IBk4b+bAecLXEOxl0283JwZtPX6Be1UymjHk+hlN3T
 yJug==
X-Gm-Message-State: AOJu0YzjwkPAxoL1mRG/ZT2FYJR3u8BlFEC9Huqdf2je5Wcg8SJ+jYqH
 xbQ8q4NqHXJH9MTlouPkRs9N3Oz2Qgd3Qw==
X-Google-Smtp-Source: AGHT+IELG+YI8qPe97ebP95T302LmDxqUMlRYH5yDLE0oIyUX5NO9DGdJRpTJLUxg9b9dz/+ctwwGA==
X-Received: by 2002:a05:6a20:7598:b0:19a:4846:5245 with SMTP id
 n24-20020a056a20759800b0019a48465245mr1472107pze.67.1705098171502; 
 Fri, 12 Jan 2024 14:22:51 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 p19-20020aa78613000000b006d93ca7f8f3sm3642335pfn.150.2024.01.12.14.22.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 14:22:51 -0800 (PST)
Message-ID: <a9f0ae34-5b9d-4cdb-acb7-1f1e1ef13636@linaro.org>
Date: Sat, 13 Jan 2024 09:22:43 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] plugins: implement inline operation with cpu_index
 offset
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-2-pierrick.bouvier@linaro.org>
 <76fa391a-9f3c-4308-a84c-2b84ddadbb88@linaro.org>
 <e10e21ea-0bf9-4565-9552-e03928610161@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e10e21ea-0bf9-4565-9552-e03928610161@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/13/24 01:27, Pierrick Bouvier wrote:
> On 1/12/24 02:04, Richard Henderson wrote:
>> On 1/12/24 01:23, Pierrick Bouvier wrote:
>>> Instead of working on a fixed memory location, allow to index it based
>>> on cpu_index and a given offset (ptr + cpu_index * offset).
>>> Current semantic is not modified as we use a 0 offset, thus inline
>>> operation still targets always the same memory location.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    accel/tcg/plugin-gen.c | 60 +++++++++++++++++++++++++++++++++++-------
>>>    include/qemu/plugin.h  |  1 +
>>>    plugins/api.c          |  7 ++---
>>>    plugins/core.c         | 11 +++++---
>>>    plugins/plugin.h       |  5 ++--
>>>    5 files changed, 65 insertions(+), 19 deletions(-)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> For the to-do list: add mul -> shl strength reduction in fold_mul().
>>
> 
> Would you like me to add a todo somewhere about it? Or is it a reminder for follow-up work?

It's a reminder to myself for follow-up-work.


r~



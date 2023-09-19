Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A6F7A5CBC
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:39:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWFm-0001cv-Kj; Tue, 19 Sep 2023 04:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qiWFl-0001cm-04
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:38:41 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qiWFj-0005c8-7o
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:38:40 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so718234166b.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695112717; x=1695717517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xhf9Hy3LvIR/9VrJMr0HpvFF89rTkP7zLhOwg2duDe8=;
 b=oyhVJRSK3lcK2D51sVkk8bhIzm7Pr9LzZm1mLkGZd+bRRL8LMsqpSXzhS7o/Gnxz98
 2TFPW/y6gy1AI+aEkLC7BBJbty5YE14ew7BMI55bg4fOcUmXGFNOF4iXHq4piEuz5RWa
 SEagyM/mDk9apoU71zF+f5DSTtH+B1TUVX1Y4EL/r2UmrUQy5fJ0NjIle4LFpMVUes9z
 3r1Er6wFix4tDU8jQkxAHB9KkJPzi+rtD03oKgzss1hM9BuLEjrHXRKwyOVUudD+FWuy
 3N9/w17nacInn8CyX4HKy9K1LGTOR7zQrDppLvnAIHA2fn1TpV+OzYI72tH4Fo565fK+
 UiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695112717; x=1695717517;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xhf9Hy3LvIR/9VrJMr0HpvFF89rTkP7zLhOwg2duDe8=;
 b=E7OIch51AeuptsWSWMxm8YJmMhX+OvECriSVSh5iw3IfRG0o4OGfTsSP/YMqfeq/H3
 aqr6uPXHw0qA38ad87LrPbiDrmqQBhAcXlIibTdO1W2BC25LRv3D7H8KxxS9AZqQwqF5
 wI4Tcko/LDIcMlPClxa38L0oXnvVTD+TgvAXWw0r9Y0hIGLd29xePWnQJTC/IlGrNVXy
 JTBDpz+KFUh4LH1gZFVAKAWfM+dHRIqq5ipUzdR9GYJNTVlYRWu7yeSohYor4l6MF3MT
 Zgdh74JuZSx6HLEfApTppxbTFsTEWcyym1lNRx70BfIsJZICX89N6eKlRbU2Y1rg5/S3
 mi2w==
X-Gm-Message-State: AOJu0YxZqy/bHVt1nw70X7if3tAFv1O7G9u5tVbSRW7nWssWrzIr1Z45
 nM9pZqSe2lbnLhjcC6lOeuUdgA==
X-Google-Smtp-Source: AGHT+IEONB/YisBt8DAyqJhFERQAtSGxe02gprSX8QdXsCo0o781HZ+3Bc48dILQd5GiBBLvr2atOA==
X-Received: by 2002:aa7:d905:0:b0:524:9564:4fee with SMTP id
 a5-20020aa7d905000000b0052495644feemr10283639edr.10.1695112716289; 
 Tue, 19 Sep 2023 01:38:36 -0700 (PDT)
Received: from [172.20.66.192] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 z7-20020aa7cf87000000b0052718577668sm6983077edx.11.2023.09.19.01.38.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 01:38:36 -0700 (PDT)
Message-ID: <df4b309f-6de2-42f5-4c2b-3103fb0d929e@linaro.org>
Date: Tue, 19 Sep 2023 10:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 00/10] linux-user: Detect and report host crashes
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
 <d2e3266e-dbb8-07a6-07d7-008e788c3862@linaro.org>
 <329a2c4b-9fa9-5e73-aa95-57512d60c1ec@gmx.de>
 <36562fcb-77f2-2a18-acec-47f155decf71@tls.msk.ru>
 <51b980aa-1a80-7565-44d6-8dcba3ead422@gmx.de>
 <7a2ccda6-4f23-961c-4d53-b6929af6bd6f@tls.msk.ru>
 <c3e39816-b16a-d3f2-135e-95796814ebf0@gmx.de>
 <4aa85a6c-26ce-0683-e65e-e0e0cb9546a7@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <4aa85a6c-26ce-0683-e65e-e0e0cb9546a7@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/19/23 10:26, Michael Tokarev wrote:
> 19.09.2023 11:00, Helge Deller wrote:
> ..
>>> Probably the right solution is to use qemu_abort() (and qemu_assert() etc),
>>> and maybe #define abort(x) qemu_abort(x).  Even if some way to redefine
>>> abort like the above will work on glibc, it does not mean it will work
>>> on *bsd and in other contexts.
>>
>> True. That's probably the better solution.
> 
> That wont work, since abort() gets called from a lot of libraries
> (gilbc has 1000s of calls to it)
> 
> Sigh.
> 
> /mjt

A possible solution that occurs to me is to treat SIGABRT like patch 7 of this patch set 
treats SIGPROF: remap the guest signal to one of the host RT signals.

Then we leave the host SIGABRT as SIG_DFL, producing the expected crash when the signal 
originates from a host abort() (etc).  A guest abort() would use a different signal which 
is caught and emulated.

Things do get confusing across processes, but should be no worse than any of the existing 
signal number swizzling.

Thoughts?


r~


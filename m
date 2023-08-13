Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E477A4BD
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 04:31:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qV0sA-0007A6-DC; Sat, 12 Aug 2023 22:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qV0s2-00079p-GZ
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 22:30:24 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qV0rz-0001rr-1I
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 22:30:20 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686b91c2744so2198371b3a.0
 for <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 19:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691893817; x=1692498617;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c2wjJWHNhY48TiqKIWKKiAIOR5NUWotQuYMqB1ht4O8=;
 b=JfA3etiATQALFrr7s6dj0JF4XRAug7SqZ9CioyJQbZD5/us3dS+WlZx1GNIRv7PrWQ
 ZJxI49Jr4L3EdNPRAdTiAcoLR7yuL6MXsFh5HDB3Uvlz6TMgs2wmQw5ie5H7SBOcMmuV
 sJZNILcydS2cFUZ09a3EkqEIoBC2ZspN+Wt0c4BRwWMvOZdYANzOT6xf94v9LK/klsu8
 vdBH8BWGctRoGRfV99hqe03dAAw4a8SNNsoXsBrNiUP2cRuIWhRXZvK5wzApTkx9DSdH
 1SGEMtrobZ3z08jwLhwSVwgReKq2yrmJorLhFRmvh0YjFIFxaMqqga6oDZfKrK9a/773
 2kKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691893817; x=1692498617;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c2wjJWHNhY48TiqKIWKKiAIOR5NUWotQuYMqB1ht4O8=;
 b=ic4VkDkOz9qRSsDRKK6kTtpWG/XQnKepOolWtIJxdcpQBKPozfVId2xcq7yX+WkCo7
 Rh1noX7dnrRmJkUh4T0YvhtPfKmZ4qkQ/fOZGH3XPx+llIlaEwzjYjebO3dtZmU8D1nw
 IBDsWAjML2atfCr2oef4QVkYYUYFT7T0YGHn5eZ0CFfr8V8tuK25Mo3wbVSHLPvrOzSU
 w47yqnXUOwM1LTc9yVqpomEPt0Mrq4PQbPVRIDEvGpHW/y4wsDi6Qhf2n3DR3r+Mpd0h
 2GgFTmuwD+Qzp5kaRNju7f0c8oxYcOj7VfXKX+BenzOYkz5w75D4g/1qxXCsn6x9a8CE
 Xyxw==
X-Gm-Message-State: AOJu0YwFp6Ow/1IvKU52Pi0HtpHCsELWM3I0sMqbJ6rFhUp0DqUa4FdR
 Fk3n19AEZYRF+e4HlcLbmrKB2A==
X-Google-Smtp-Source: AGHT+IGqklbtVVThQjbg0xSus5m+bbT+LBU5dlh0ulJK2b77SINPzmGNZ2zqN+oeZHLGp9o2dBCsLg==
X-Received: by 2002:a05:6a00:8cb:b0:687:42be:a274 with SMTP id
 s11-20020a056a0008cb00b0068742bea274mr6349535pfu.5.1691893817100; 
 Sat, 12 Aug 2023 19:30:17 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:c7b9:78a3:4318:6f36?
 ([2602:47:d483:7301:c7b9:78a3:4318:6f36])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a62b502000000b00687cb400f4asm5427488pfe.24.2023.08.12.19.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Aug 2023 19:30:16 -0700 (PDT)
Message-ID: <0f1090bc-6799-24df-a7fd-f86e7f2907d1@linaro.org>
Date: Sat, 12 Aug 2023 19:30:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Fix signal handler to detect crashes in qemu-linux-user
Content-Language: en-US
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org
References: <20230812164314.352131-1-deller@gmx.de>
 <56908f79-c883-0d83-c990-e7a86714b6da@linaro.org> <ZNfLn22w8bA5X3YV@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZNfLn22w8bA5X3YV@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 8/12/23 11:12, Helge Deller wrote:
>> I did mention that you should look at adjust_signal_pc,
> 
> Yes, you did.
> Maybe I was blind or didn't fully understood yet.
> 
>> which has a lot of commentary on the subject.
>>
>> (0) Place this after the write-protect and restart check
>> just below, since that is not an error of any sort.
>>
>> (1) If helper_retaddr == 1, then this is a fault reading
>> for translation and is a guest SIGSEGV.
>>
>> (2) If helper_retaddr != 0, then this is a fault in some
>> cpu_ldst.h operation and is a guest SIGSEGV.
> 
> (1) and (2) means host SIGSEGV can only happen if
> helper_retaddr == 0.

Yes.

> 
>> (3) If in_code_gen_buffer(host_signal_pc()), then this
>> is a fault within generated code and is a guest SIGSEGV.
>>
>> Otherwise it's a host SIGSEGV.
> 
> So, basically like this?

Looks about right.


r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A95876871B
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 20:18:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQAkh-0004Pe-DB; Sun, 30 Jul 2023 14:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQAke-0004PR-NK
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 14:02:44 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQAkd-0000ye-9j
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 14:02:44 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686ea67195dso2695620b3a.2
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690740161; x=1691344961;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bRugIUXZ2l54U34P6aJD9oybWjEaGVrpz8p78j0yS/g=;
 b=zS2Q13uG/LUd/Qz2BBDtPKiHK7qA6NtEsZ61e+zdGy7vRaOmvYCPNZe2lbp4mf2P1h
 /8K+xYvusUFb00XCrdPCoWWHXSmAh2EttzefDYY7jztkHUNx8h8mhm1xe9o9BlCIFjHP
 t5xsydExv12z3Ekm+ABe/RRjJ5mNdTUjqheVsplLRezQQob5i9MkHgA99X7IUGwNv4cm
 nIiS7qZZiDqkW4SlsoUGZ/gcB9Yj5KiJO8WT85BJclbZIvc7PCOGuzgaJdBmIRHNAGub
 53A/jxbCxYXZz/xMPrNDfWM0rMi/HcAfRG+fIEurDaxNmQ8Rx5gdBXF/HJXgOsxyro58
 1RFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690740161; x=1691344961;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bRugIUXZ2l54U34P6aJD9oybWjEaGVrpz8p78j0yS/g=;
 b=BWQl3P/LBxHlYlSP6lw4VHJuBcDnMSbsZDZOdEoj6YxofZLxHg1PdyOa86x5MhRLeC
 Ts3en+D3emHJ1iye/iorPQ7gJh4iTV2bN9E/Z/tun/G7zRplmSHKAZoHwYQlDgqy+bXm
 pyhbuyiBxqYm+HzQYVNZivt7lyy5BxPAunxCNNiYdImnKPS3WRpjfxzP6u5ELwJx9QkM
 IrLl8K5w32CJPPlduioblWZpF6VYmICU5/8uHPrGkou1Y/79BXuFYMvUiYXmYxpUcwbq
 N7CPmK34TSQL3hUsOw2NyTPIQAUnCiOliuWbiI+LAOkqLte5o13qeqOVUa68pcPZhqKz
 45fg==
X-Gm-Message-State: ABy/qLbEQJfidm680YDQTWoT7ZO94p8Gome9fub65qSI/blWS9HLzbyZ
 uawQK4ogQL/HjKBZ4sK2Ovt4iwfQv2i6hrBBIYQ=
X-Google-Smtp-Source: APBJJlHO3DOVvwXwN1Z0JpNRm+MMKliiX3PGQfgvj/CDXKbqSU9x4rmQlD/JNkLMqmNMKKNnjrdJTQ==
X-Received: by 2002:a05:6a20:840d:b0:12d:23ea:9ccc with SMTP id
 c13-20020a056a20840d00b0012d23ea9cccmr9820729pzd.39.1690740161414; 
 Sun, 30 Jul 2023 11:02:41 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:a7b4:380e:e513:5ef2?
 ([2602:47:d490:6901:a7b4:380e:e513:5ef2])
 by smtp.gmail.com with ESMTPSA id
 k14-20020a637b4e000000b00563d5e31e13sm1924558pgn.13.2023.07.30.11.02.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 11:02:40 -0700 (PDT)
Message-ID: <f12379de-1e90-74f4-2c24-6199e904344c@linaro.org>
Date: Sun, 30 Jul 2023 11:02:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH] accel/tcg: Use lookup_and_goto_ptr() for linux-user
 in translator_use_goto_tb()
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <ZMakYpOgco2Ihg0G@p100>
 <1f3bd7a5-ac39-1706-99f1-6ae56a7cf4a7@linaro.org>
In-Reply-To: <1f3bd7a5-ac39-1706-99f1-6ae56a7cf4a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/30/23 11:01, Richard Henderson wrote:
> On 7/30/23 10:56, Helge Deller wrote:
>> +++ b/accel/tcg/translator.c
>> @@ -124,8 +124,13 @@ bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
>>           return false;
>>       }
>>
>> +#ifndef CONFIG_USER_ONLY
>>       /* Check for the dest on the same page as the start of the TB.  */
>>       return ((db->pc_first ^ dest) & TARGET_PAGE_MASK) == 0;
>> +#else
>> +    /* linux-user doesn't need to fear pagefaults for exec swap-in */
>> +    return false;
>> +#endif
>>   }
> 
> No, we still need to stop at pages for breakpoints.

... and munmap for e.g. dlclose.


r~



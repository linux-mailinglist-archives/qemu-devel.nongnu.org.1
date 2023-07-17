Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0532755D46
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 09:45:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLIu5-00022M-OV; Mon, 17 Jul 2023 03:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLIu3-000221-8W
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 03:44:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLIu1-0002Fd-8N
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 03:44:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so31740985e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 00:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689579854; x=1692171854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rbs2oHT7s3LfgCocQglHg6LSlz5+ButrFY//3LZDYPs=;
 b=zprxhd1pwXCOlzNN6y9WbIRrIiqOTwM1AjtkZSHRU91C6FVR+AYPT+CurjGKRxFxt+
 s7hP2iMF7YLfB7xz81C6lBJitnL9Nt9MtyD6IOeSBSPDIvZZiiwGt/3Sl/IOmiMkpC0u
 5TW3yzy9uxkoqNTGUvL8EURUDFjOYfSRdL9FJpJFy81URH/nTEznWxm3sUmwOQAHtKgC
 qLfgNUr6jUo5Gn0z3JHZ/F3A7YSqBcg/1ix1dEz05jaQjraJbtYE6dOwnaezjPuiq8Xe
 eOfq+u9FtyBeiys24eQhvzOPRSPpELRBkklLi+ddOIPXy//EczUT8kPMHRZkDwW6c+6n
 OYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689579854; x=1692171854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rbs2oHT7s3LfgCocQglHg6LSlz5+ButrFY//3LZDYPs=;
 b=LoBz28Me+HlUNIZ+FDHyK/u7CrqngCh6TqG0FHuOh9N3XFso/5JtkaNQa5vJijvi4Z
 9QXB3RSSdaqxFw6AAoB4mdl6va0D0WuRwl0f2otnzeTGOwL9T9Pr3rUBI3Ta3knlDMai
 iHm8ltJHhpoBN08Cx1svbBGmtGASgLE06961ZGQpsCk1AClO0UwGpDxJHN3jpf8GLU4T
 3QxGAN52E+NVg/xGtbaBeyt4k4Swf+D+GjY7FWFTiGj2wGHMHg+8y4wV/RxvGvoEIqo/
 IZy4cSHv8YW/IOtztNnhpS+lr/5IeG4nXUZ2qFYtiSBgVjwp6aEOkHMHXjjQYgl2Qr3e
 hQLw==
X-Gm-Message-State: ABy/qLZ4Pmcc9eEV8si+1Vl/UTIBZ6xq7GZlZWp7q9r6IdFkOb1Lre/n
 1J0oIFsGgTZXiNW6ofRLmlLU4g==
X-Google-Smtp-Source: APBJJlG08ikHFTqlHCq3HpuzesyaT2NmlJ3bTOG/jSav4ZnYzblKiW/V5LKK/UNRnf5RPEYSuU3/nA==
X-Received: by 2002:adf:f04f:0:b0:314:3108:500a with SMTP id
 t15-20020adff04f000000b003143108500amr7623499wro.0.1689579854672; 
 Mon, 17 Jul 2023 00:44:14 -0700 (PDT)
Received: from [192.168.1.205] ([51.219.12.49])
 by smtp.gmail.com with ESMTPSA id
 d3-20020a5d6443000000b0031433443265sm18492659wrw.53.2023.07.17.00.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 00:44:14 -0700 (PDT)
Message-ID: <13598a41-d17d-4d8f-ef0c-4bd41677c775@linaro.org>
Date: Mon, 17 Jul 2023 08:44:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH][PING] linux-user/elfload: Fix /proc/cpuinfo features: on
 s390x
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20230627151356.273259-1-iii@linux.ibm.com>
 <f359dae7-e0a3-42cf-c2cd-fff7f9c3a607@linaro.org>
 <a55d41f884e6ff50872d389fa1a7c3dcf61afcc1.camel@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a55d41f884e6ff50872d389fa1a7c3dcf61afcc1.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/14/23 13:16, Ilya Leoshkevich wrote:
> On Wed, 2023-06-28 at 09:49 +0200, Richard Henderson wrote:
>> On 6/27/23 17:13, Ilya Leoshkevich wrote:
>>> elf_hwcap_str() takes a bit number, but compares it for equality
>>> with
>>> the HWCAP_S390_* masks. This causes /proc/cpuinfo to display
>>> incorrect
>>> hwcaps.
>>>
>>> Fix by introducing the HWCAP_S390_NR_* constants and using them in
>>> elf_hwcap_str() instead of the HWCAP_S390_*. While at it, add the
>>> missing nnpa, pcimio and sie hwcaps from the latest kernel.
>>>
>>> Output before:
>>>
>>>          features        : esan3 zarch stfle msa
>>>
>>> Output after:
>>>
>>>          features        : esan3 zarch stfle msa ldisp eimm etf3eh
>>> highgprs vx vxe
>>>
>>> Fixes: e19807bee357 ("linux-user/elfload: Introduce elf_hwcap_str()
>>> on s390x")
>>> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
>>> ---
>>>    include/elf.h        | 66 +++++++++++++++++++++++++++++++--------
>>> -----
>>>    linux-user/elfload.c | 41 ++++++++++++++-------------
>>>    2 files changed, 69 insertions(+), 38 deletions(-)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> r~
> 
> Hi,
> 
> I noticed that while the other s390x fixes were picked up and are in
> master, this one wasn't. Is there anything I need to improve here?
> 

I just missed it while collecting patches.  Sorry about that.
Queued to tcg-next.


r~



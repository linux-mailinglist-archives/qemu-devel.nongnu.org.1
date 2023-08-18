Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5073A7802AE
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 02:20:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWnDa-0007rP-1t; Thu, 17 Aug 2023 20:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWnDY-0007r8-Gj
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 20:19:56 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWnDS-0006OY-Fq
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 20:19:56 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bee82fab5aso3074115ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 17:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692317985; x=1692922785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Zg8MKojZZFXiSemwnfUdR8+clTCJX/9tgwoXBCcYsc=;
 b=Hsz17zXNocn4EcX2cvWS0zo5dQkUh6XekrNsdmkYnRWkJh/zkqFt6tHON4i8kcM1IB
 a2BPVcJMUN19SZG3Zi0sOqiGx6OSs8/7UXc6uHtnscduq7ZZBQPUz7Y5DfZDCBRpozuA
 HoS5wDAyfCguv45Az/WSNL+MCV6a2jhEQpg5hg47G/RGj8dpQlTzwrIr+wL1xV0oQcNB
 MYyoaGpMXNwCQP5KT5OqXIQimcR+oR7H8QLtVCxMKvjHwiCHIjjYmrXh78fI27E9JH00
 GeqO41NEHd54MmNpzsAvmegRnSn2HiHwVJjtxMMta2sScW6FcowIfZjbXWf+2b13XY1Q
 VKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692317985; x=1692922785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Zg8MKojZZFXiSemwnfUdR8+clTCJX/9tgwoXBCcYsc=;
 b=NSslye4esu2MvHesK5RmY871tseIfnBbyEjf64SOURWHhkC/z5rLjQQGTkW61ZLVrQ
 fW+jDWSdn8sq160YN/2twmCfvxRSNyxNpXWHO23hqN8QWV880V1VQYxLzlHNIdrRsAPW
 Jy7UZnX99eRJWozzLyImG7AZtE/lT76s19QCQEn7NEiVRi7kzzUmkYzvByzNJMY57C2I
 Qp8y1sOkIZklWFQmiyFgJT9ebq2IN7up/Eg9nkN5zyVwVtDhs4jZUn7/Vb4vpEwiD+1Z
 JaaWhp44os8Lold7BebSGIvLKDClxYYZ1xtUbQBO3smPjDFt9+xYSIQryvrEhkpd4dqR
 T+PA==
X-Gm-Message-State: AOJu0YyVoOB5xGlBgkqWhibU+NUESxIL+eR56H4fuf40VpXSLXv5Cyef
 +IU9wKGL3lqB3Bx5pJeW+303PCa1u6eIBpjT568=
X-Google-Smtp-Source: AGHT+IFMedGRs5P7qn0ahQ3hjB0+ZAM/cWcyalpSKMeOTyKGOx/nm7+J2ilJdskFz5o4FmU09qHARA==
X-Received: by 2002:a17:902:b405:b0:1b8:a70e:8a7e with SMTP id
 x5-20020a170902b40500b001b8a70e8a7emr847764plr.66.1692317984961; 
 Thu, 17 Aug 2023 17:19:44 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:3858:36b1:43e1:e747?
 ([2602:47:d483:7301:3858:36b1:43e1:e747])
 by smtp.gmail.com with ESMTPSA id
 jh13-20020a170903328d00b001b83e624eecsm362744plb.81.2023.08.17.17.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 17:19:44 -0700 (PDT)
Message-ID: <19bd7b77-9add-e418-c0fe-800a90fd8383@linaro.org>
Date: Thu, 17 Aug 2023 17:19:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] linux-user: Remove ELF_START_MMAP and
 image_info.start_mmap
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, deller@gmx.de, Warner Losh <imp@bsdimp.com>
References: <20230816181437.572997-1-richard.henderson@linaro.org>
 <20230816181437.572997-6-richard.henderson@linaro.org>
 <3b8a822c-cdf7-bdae-4cb4-5c66d93479d5@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3b8a822c-cdf7-bdae-4cb4-5c66d93479d5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
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

On 8/17/23 02:00, Philippe Mathieu-Daudé wrote:
> On 16/8/23 20:14, Richard Henderson wrote:
>> The start_mmap value is write-only.
>> Remove the field and the defines that populated it.
>> Logically, this has been replaced by task_unmapped_base.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/qemu.h    |  1 -
>>   linux-user/elfload.c | 38 --------------------------------------
>>   2 files changed, 39 deletions(-)
> 
> Can we squash similar removal in bsd-user?
> Either that or in a different patch:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

A different patch, for sure.  I don't want trivial patches to interfere with the ongoing 
merge process.


r~


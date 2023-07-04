Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89804746B83
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:07:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGb41-00077F-EH; Tue, 04 Jul 2023 04:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGb3x-00074C-LK
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:07:06 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGb3w-0000yx-6D
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:07:05 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313f3a6db22so6076317f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688458020; x=1691050020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xPm+FX/LX848rA7rsJcPu8ZynDhBnEhSs6D+c57a3mk=;
 b=PjdjlDIImLN1AFnRrBjRWT4/lilxJXDz3QaUFjP96lj/1Qir4WEB23Cz0jL8OJx4WV
 v3T2PBSNNaSDdYSTzdEVwXVkni4IZdfQTbCVR8/A+YybJeeHz8xSguwxwky82ne3Ty6Q
 zufNikMdNoxoubOfWg0DM9brH8kNpAtB7BvVsZzvVhKvOvZWvJUt/LVaVyDF/DVt7E0v
 7CFzuN63AmFMPEMF/+oQvOhFKN6u6tNazp0dQFVjPpu9jZPgmeDTfBGHIkewIJ9IneQP
 +E/bOK+JgfJ1qYPsfIMcX3jkoQrm2m35ILOL1lyT+cPjwUy7ZDGx0a29B8qv5FKAKeTh
 CaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688458020; x=1691050020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xPm+FX/LX848rA7rsJcPu8ZynDhBnEhSs6D+c57a3mk=;
 b=TfHffaJAnwHlYPWimve4Vs9yOOeE4MTGeyGsZIim3iksaorHFkUqxpf9WKQLF5pxKn
 /hGcH448e4ryElH4Zt5cMoRH/ShAiWgl17iWYzAqCAk29b7nlkywnD57rGxeM4hO+ZPR
 1IRCDQPqrpRf2mBuMhRHX/2I7ezi/yLGKmKj4NKGcUQifEliUN+8WCAVH3KM9DLddfcV
 jPaziwPweCqqM7DS/3UytpfIZfbm4LCpUDpxetcAc1gaGDI/VyA9Px82fY5vxx17Db+6
 5yz3C0fxwDpicL+Tyyso1Z4xBtLKZdVQCg3qjqxZ56iqzj123tclPZWxbkfRkzQXETOA
 SB0Q==
X-Gm-Message-State: ABy/qLary+r6xHiyRwW9TU2YHFzmh6RfdRG1/U35Ed0n3YysKIBGoTbK
 3p9O+jyaMevKeEAnmS7BP5efkg==
X-Google-Smtp-Source: APBJJlHB4jsfOokzm81356es+jKx5dhe5JGvIqgo8BFpZmrKAkPEi3eoC1KFVZqwwVMZGYxzGXFxtQ==
X-Received: by 2002:a5d:5272:0:b0:314:1270:8fc with SMTP id
 l18-20020a5d5272000000b00314127008fcmr11963474wrc.0.1688458020473; 
 Tue, 04 Jul 2023 01:07:00 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 j8-20020adfff88000000b0031412b685d2sm14071110wrr.32.2023.07.04.01.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:07:00 -0700 (PDT)
Message-ID: <330622b9-97eb-53e2-48e8-5be65c777b47@linaro.org>
Date: Tue, 4 Jul 2023 10:06:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/12] target/s390x: Fix LRA overwriting the top 32 bits
 on DAT error
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-6-iii@linux.ibm.com>
 <b105761d-9602-030a-e578-12d9cd0a0283@redhat.com>
 <e893b9be6e71946120f6e54422814f7d4219f484.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e893b9be6e71946120f6e54422814f7d4219f484.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 7/4/23 10:05, Ilya Leoshkevich wrote:
>>> +        ret = (r1 & 0xFFFFFFFF00000000) | exc | 0x80000000;
>>
>> ull missing for large constant?
> 
> Will do.
> 
> Just for my understanding, why is this necessary?

32-bit host; you'll get a warning for the large constant.


r~


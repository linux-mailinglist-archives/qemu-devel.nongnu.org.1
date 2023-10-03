Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1404F7B747E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:06:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnoSK-0001Y3-5h; Tue, 03 Oct 2023 19:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnoSA-0001Xi-MQ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:05:23 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnoS9-0006i1-3J
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:05:22 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3af8b498d31so1047502b6e.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696374319; x=1696979119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xAOitkLt+YqqsIsxYzDNqCzmf8/h5SM5Rj/6SWhydGk=;
 b=AYXWeefcWwwM1lCSU+vBPnydNMuWfLBjFhAMCANi9bV8X5Zk42r7WxrzdWoi+uZF4V
 UTdFk8ii2+2Q56V7GZnAtwPbKUvcUJEvUjLk7AFZEErxp5BKQ5n/uHTzYU2O001bjyhq
 wM3KlNSp65OkPyrDNPE/haFXJGry+GSVP/mTWqYWgeqqT5wFHuhljgQhpRwhFZx2ZBBt
 pd1DMjyOZXvII/HrNlGWTfEUzkmqlRqvP6UuhB7Hue3n5hOk0vSNM5dPOwj+JinovY0t
 Af/4SNO+/aC+JmtPTgxdOHG7Y6jFA4w+oeZPmrITXJzrO6T6BI/XAkt/VNeDwDpN/DVq
 MMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696374319; x=1696979119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xAOitkLt+YqqsIsxYzDNqCzmf8/h5SM5Rj/6SWhydGk=;
 b=b6OY8dnW61G9Sw4wiroMq4K5OCo1pLG23hEEr5eJOsflvUU+kJQ6fOuVAFU8wAswkE
 m52JFfVKm8Susl0EyGtknFTCX6+2dgOA+zm8jNf0rs7kySSGZPG+E8qVdos6Of8cUReL
 6BZoLAburShn6X/IVRESoFEi6HxV8WxhyhGTLruc6JiLRLibqyTO8cmsFGG4PgQPWrZf
 I3S1pP8gwjJtwNNPl2YTbRiJhySHICKV0T9YRzXVWR0tugv3R+roeGk5qgulwWbNUJFU
 GZ2DdNgTJFlJmSmoRugXMu2OGDNSiP51myWiUhmPgYRzTvS2IpH+zDqmF7jlpfVCxy7n
 yXgA==
X-Gm-Message-State: AOJu0YzRiHEmz/zbE/ACN6UfKYNaHzaW8DZiOH60y0xH6KEZsT8pked0
 /80N2Hn8vP/m7zcjufnGQYICzw==
X-Google-Smtp-Source: AGHT+IE1e96+UlkW/e6UdbfoJDVE+LvEWOvsX6P2Rsa6KP7nFa2N4ytC3D04NscLhX+O/1JUtPiF8w==
X-Received: by 2002:a05:6808:1527:b0:3a7:2390:3583 with SMTP id
 u39-20020a056808152700b003a723903583mr1129799oiw.38.1696374319701; 
 Tue, 03 Oct 2023 16:05:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a63a009000000b00578b8fab907sm1919884pge.73.2023.10.03.16.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 16:05:19 -0700 (PDT)
Message-ID: <ad44a134-75c8-2ba0-e890-b6b89f2f0b04@linaro.org>
Date: Tue, 3 Oct 2023 16:05:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 08/19] linux-user: Add gen-vdso tool
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-9-richard.henderson@linaro.org>
 <0afc2728-882a-6f4b-d343-2ce126745034@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0afc2728-882a-6f4b-d343-2ce126745034@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 10/3/23 06:00, Philippe Mathieu-Daudé wrote:
> On 30/9/23 04:15, Richard Henderson wrote:
>> This tool will be used for post-processing the linked vdso image,
>> turning it into something that is easy to include into elfload.c.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/gen-vdso.c          | 223 ++++++++++++++++++++++++
>>   linux-user/gen-vdso-elfn.c.inc | 307 +++++++++++++++++++++++++++++++++
>>   linux-user/meson.build         |   6 +-
>>   3 files changed, 535 insertions(+), 1 deletion(-)
>>   create mode 100644 linux-user/gen-vdso.c
>>   create mode 100644 linux-user/gen-vdso-elfn.c.inc
> 
> 
>> +static void output_reloc(FILE *outf, void *buf, void *loc)
>> +{
>> +    fprintf(outf, "    0x%08lx,\n", (unsigned long)(loc - buf));
> 
> uintptr_t? Otherwise nice!

uintptr_t would require more complex printf.

Actually, I should just use %tx for the ptrdiff_t one gets from pointer subtraction.


r~


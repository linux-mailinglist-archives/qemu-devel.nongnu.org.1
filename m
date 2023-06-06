Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC54724B55
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 20:26:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6bMA-0000gE-Vh; Tue, 06 Jun 2023 14:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6bM6-0000fx-1V
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:24:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6bM4-0004Xr-HH
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:24:29 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b011cffe7fso30553955ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686075867; x=1688667867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kY7Zrm/Boo75QWDxWVkY4Hezx+pVdKx5ddpDMQwuUD0=;
 b=UUs+6ENy4KPnIYeKTtnkpRLfEU02V84KoW9jLK0FuqEkvwcCVURfBhwJFs12bQG4kL
 uZ2ZY4VT7JPhka2MbE3jOHLpnpBBfY7XdzatenFGsEUMfI6NQW1gBPpKAyuR4JlZjyUh
 4QAEkAf5tEHeda7aBLTxQ4wql/85swVi58X1Or/6V/jY7j4+5jK1htJ5plN1iJ4jjbkU
 flB20LMeOJvHMysdYYnnWArZSVtuGaWQJNz6LCxyZwebFXW+fbyyFBGkNpiCgFJzRrZj
 Snn79e2U5g5qfu7GtfEruEQR+8+HcL9S6pvCwQck42nUHQyhgMMdBMbOqm1/AO0nZtv0
 8JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686075867; x=1688667867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kY7Zrm/Boo75QWDxWVkY4Hezx+pVdKx5ddpDMQwuUD0=;
 b=JJGsHtHq1WRgQEKdH8FAOwj1I0U/5qUt+/49Hqsx/hnnZiPg5s/MYAWuYuTa0Yl0Wi
 koe9CbereIvXmd2VT1XXRBHmYEpr5BVGNP6nJj5/+hsKGPoaPEp7+L/5LA4P5tHAkcYC
 P4BicR32TexSq4I/Sd/F7hcgemAp+6p0qBOiwcZH8X8wtK6Im0M1Dp2oZnQJbQ7Xq2Mf
 ump0sDLeDprLapfM959lG8CskISnwKsQL0SLGmm74A1IQ/wgeB/FJ3893i8wc1bwWHSF
 uwyUfuqpYa13wQxJJIkncRJBsGqBIrQmj3CHSc1WDdsYu8oSMjrngm5UtJVD5Zq5X9Tf
 BKGg==
X-Gm-Message-State: AC+VfDx+fB7aOXvy7swdwNpsXV5kVFW6V+DE+LBZ2wtC4KEbRcEbw7qr
 9TmHwCzdIU8NyLB7HJ5hqBwf1A==
X-Google-Smtp-Source: ACHHUZ6R0LRrxlR/sigHQDZ6YHU46rAuIXQxBHgVdt+pgj7UQamI9XSh/Xa7qtQMIYldS44j2Wco/Q==
X-Received: by 2002:a17:902:ec88:b0:1b2:450f:9cb with SMTP id
 x8-20020a170902ec8800b001b2450f09cbmr616978plg.51.1686075866867; 
 Tue, 06 Jun 2023 11:24:26 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a170902db0d00b001b042e8ed77sm8802302plx.281.2023.06.06.11.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 11:24:26 -0700 (PDT)
Message-ID: <ad49111a-5dd9-671b-f18f-009a7eae73b0@linaro.org>
Date: Tue, 6 Jun 2023 11:24:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/8] linux-user: Add "safe" parameter to
 do_guest_openat()
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20230606132743.1386003-1-iii@linux.ibm.com>
 <20230606132743.1386003-3-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230606132743.1386003-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 06:27, Ilya Leoshkevich wrote:
> @@ -8518,7 +8522,11 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
>           return fd;
>       }
>   
> -    return safe_openat(dirfd, path(pathname), flags, mode);
> +    if (safe) {
> +        return safe_openat(dirfd, path(pathname), flags, mode);
> +    } else {
> +        return openat(dirfd, path(pathname), flags, mode);
> +    }
>   }

I'm not keen on this, as it seems like the wrong abstraction.  But I can't immediately 
think of how it could be better structured.

The only concrete objection I have is the change of API, which could be fixed with return 
get_errno(openat(...)).

With that,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


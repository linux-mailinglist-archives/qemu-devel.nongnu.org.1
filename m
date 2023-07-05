Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 957A2748823
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:35:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4XI-0002sn-Dk; Wed, 05 Jul 2023 11:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4XF-0002s1-Ss
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:35:18 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4XE-0007am-0p
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:35:17 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b6f97c7115so28557971fa.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688571314; x=1691163314;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2DHe1QaVgK8mtorbJNzJ6CmI76dQhNUVHpBsBIhL9cA=;
 b=pJILxbqDCJ44poaULK00l8fw1sYFRUV+aC58WSTfQ617Zo18sdxy+zZ0C2wbuVw/wk
 PzNl5g1ZVTZe+6O8yzkojhKkBktSdMeakU/RcHJhs/ognRsB0BvJwT/S/bgP3HSQwQ6b
 5IOM0WsEhLxbXUTjUzTv/Vgh25lbmHH2xeaU1hUKs7NRAYCV/GK9uL9vhavOsbRb/0qM
 DbpSDOOoKPsE2c3IgVM60OQNjCylx+YauDR3KWDiVwxufDRnW4hBojUHqco61o2vJORg
 ZHJjdPNhSBdyT0SUc+yi5gszs9/57CI04CkPordIOqQOg5gk4u0xkCqti9CYydSpQtQP
 QZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571314; x=1691163314;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2DHe1QaVgK8mtorbJNzJ6CmI76dQhNUVHpBsBIhL9cA=;
 b=IJ8Pq3mABzgCcSjWJcWdU66QiDQ6qov/dwt1nFXV+GsUYibDfD72cQRYiqlPGx/N+C
 cjGuVlnOj7uTlbW4Rfj1MKznn5YC8Gnk0BvWyJZrmk1hndGS41cGycq7MRZ4futO0gAJ
 fL59vNCaXG76JDki0mFfeHzTpgPCwT2zyXyye875xAbDbEEqo/UoHASJF3ClFV/Yb8iZ
 adSOOezAP0/4HKiaUFl+pBprccfbAzvDr5jd86x2Scjw/RsnzKyftrc1/DM8K1JMLuHw
 Kc1RSOgwJ7aek54vRJwsyjYJXINDeM1dYYMGIFmYf2Bp37i3IBLS3GFl8Ty9iE5ikJ0n
 yaDw==
X-Gm-Message-State: ABy/qLZzIJYOyU0bZxESw4K0yS2GyqIcLP8MAahBsf+HYbHC7DMvMFkd
 T9BqKAS0zvCjzy1KgZqSb10uEQ==
X-Google-Smtp-Source: APBJJlHO3uAhYv+B8MQ8vZm5oc3E3vZ+GQoFLIXkIqOlVBH+J+EoyXakv028Uykr5Xy0oHY2CC+HcA==
X-Received: by 2002:a2e:7016:0:b0:2b6:a6e7:5afa with SMTP id
 l22-20020a2e7016000000b002b6a6e75afamr10815819ljc.12.1688571313754; 
 Wed, 05 Jul 2023 08:35:13 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a2e9b11000000b002b6dc99f858sm2788328lji.66.2023.07.05.08.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:35:13 -0700 (PDT)
Message-ID: <383855df-366e-5bd0-6663-7517e2dc526e@linaro.org>
Date: Wed, 5 Jul 2023 17:35:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 09/19] hw/timer/arm_timer: Convert read/write handlers
 to MemoryRegionOps ones
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/4/23 16:50, Philippe Mathieu-Daudé wrote:
> In order to simplify the QOM convertion of ARM_TIMER in a few
> commits, start converting the read/write() handlers to follow
> the MemoryRegionOps::read/write() prototypes.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/timer/arm_timer.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


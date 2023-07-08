Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D7474BC65
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 08:40:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI1bB-0000ui-2G; Sat, 08 Jul 2023 02:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI1b5-0000uZ-AR
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 02:39:11 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI1b3-0002E1-QM
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 02:39:11 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31297125334so2239213f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 23:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688798347; x=1691390347;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1XekqY/C4MwrH1JTYoFhI4QBa0zu12SV61WcIUE41sA=;
 b=WWvy0EV+5GazIuQXmXKIE3TCg7U11tBedkrCW5l3low7YRB6uOagSuyVBnRQXViYcb
 Sdcjskv/JFgED+Yp+/p/Jc3n77Fqlyd4Ww85pzii4NheLGGOmw7U3YQlfZLvhKWK95vM
 RQ/k30dXGdBFyaV/TsHKAtf6N1ytU86gGvGw6x9jq+nAP88GMFunnNIw4xrhWWj8t3Pi
 jL+a0t0ob5yybabcf/w81DlUEP/KkjxQ/DesBWb6Yn2yz0Evxq60ywfTdE6qBauj/lyt
 L5pU5XugiD1oFqEd5PdAwaCZ6d+ZhpB8EGp6shMVPyiXnT9mLM7FOEpLTlkbFXYJm1GY
 8m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688798347; x=1691390347;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1XekqY/C4MwrH1JTYoFhI4QBa0zu12SV61WcIUE41sA=;
 b=TDrl/KZT96dbR0uAqEZRgqWzkitUQfl+F1T4xsTcxsDW/EZ8qRYD9tVX23JqUF0s3B
 UHf5UaW/Uo2sxo+Fhilf3Loww2i2U5RH/p35zfWDdiDLAdP6gl2MApgALbfMs1Pvb30F
 xLJpGYwDWVbhzyQSRybp0hZuGw2YLTCbQcQVxptKkFYnar1MKn/TEQzKGuVEJK2TI556
 E7sZJvMYgvHwdR5ww7ZwTNvzMIqDM9SEhIyPiJQGL74kNSC3lCpEHoYfO1oHNUo+zWHc
 Z9qsFUKGXyAMNHYvfVltW2QqKHbs7QoSkiQNE24H/cYbdAxWdbgQ8jEa6RkQq6qLBxnx
 av/A==
X-Gm-Message-State: ABy/qLZLPBjVGrVVqgADFuSw+vaHqv/9kcB/G4Uz+iqAv+gETe7FXhSh
 MWQeP5hha7vx6Rh6ZwIDMNB7T9ZstV0e2P0w+Diy8Q==
X-Google-Smtp-Source: APBJJlGHURsXOvxt/s6cLUCoi4amx6F1cEwd+ifYSI0lmibpaUN/rfOVNrZ3009Yir+iT763jIih9Q==
X-Received: by 2002:a5d:6947:0:b0:314:2736:ba3e with SMTP id
 r7-20020a5d6947000000b003142736ba3emr10038690wrw.3.1688798346583; 
 Fri, 07 Jul 2023 23:39:06 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a7bcd16000000b003fc01495383sm2614602wmj.6.2023.07.07.23.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 23:39:06 -0700 (PDT)
Message-ID: <a128c6f3-1e29-4fee-f0ed-7e78b55a4b71@linaro.org>
Date: Sat, 8 Jul 2023 07:39:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] linux-user: Fix fcntl() and fcntl64() to return
 O_LARGEFILE for 32-bit targets
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20230708054249.10245-1-deller@gmx.de>
 <20230708054249.10245-2-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230708054249.10245-2-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/8/23 06:42, Helge Deller wrote:
> When running a 32-bit guest on a 64-bit host, fcntl[64](F_GETFL) should
> return with the TARGET_O_LARGEFILE flag set, because all 64-bit hosts
> support large files unconditionally.
> 
> But on 64-bit hosts, O_LARGEFILE has the value 0, so the flag
> translation can't be done with the fcntl_flags_tbl[]. Instead add the
> TARGET_O_LARGEFILE flag afterwards.
> 
> Note that for 64-bit guests the compiler will optimize away this code,
> since TARGET_O_LARGEFILE is zero.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   linux-user/syscall.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B1756F15
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:44:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLW0Q-0001pd-MT; Mon, 17 Jul 2023 17:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLW0O-0001pS-W0
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:43:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLW0M-0001bO-7H
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:43:44 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso31540345e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689630220; x=1692222220;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5UK7P/y1HSKvfrOPAMEAOl0htOtvXJGH3BEZ2mgeBbY=;
 b=KMpeXi+T0TwFAv8HivsLs37di5ETxBuQkCeG7HLqHrZgdBy2AkvatB4qnXpoBk9hEN
 Rq5VuXLvO+BLDjmn6dGtrbEfSDeDwaq9K67kUpPActS1Dd9thl5giivaW9rzr5ODl9mb
 /vNTPaBMf38qkviQKBma6zp4uxgFLOZkwWTt8y5ioP4n21EhlXkXpgsPPuYLxnl469CD
 FfOFDm1d6A7PXZRctxGkP796b/MDDzoc85vxWYU6yf7lPy2xJJWIFbn7nI2sVAPaESwk
 YmFlFPX6sH3ZaVTxOYG0NdtuTq+wj0T9wjjPjXufyxbpZjvA3VLlxNHfEqllRO3UwQ3r
 GSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689630220; x=1692222220;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5UK7P/y1HSKvfrOPAMEAOl0htOtvXJGH3BEZ2mgeBbY=;
 b=YQYbEvl9jBCZ5IhaBOi8Sp5lMoidx/wg48pLXtGYba5hhTWvsfQJ9xEnT9gBcqwuXq
 zucu3itjF7cN+QLxjTsdygmSv+bQ8wHtf1PffUqPGq2dDg1tEV7aenczz5jgUg8frIYh
 2tKLc07QSjnmhBhGU6x0WSkurZd3Ri239D4nu8NsbSqO4aTDB9STOlp/I2Y9NbYF3S6S
 4EQrfs8/4Z5NHntjTXTdvvu9V2u7LrEzf7D6OEs4YveADAMNI1LU7Leay5CP9QCmmzXG
 DSLgAMFR58VgXaFn076g9th6AVITs/7lvg+/UCO+K6OtS1xYJ4e+ND8mF84vdFFGDUws
 4Hjw==
X-Gm-Message-State: ABy/qLZCKrtrvgKBDYRQfd/TF6lXgXH/GaBmVlni2cA5906J6jFuxu7/
 I2ar8q/LUy7pktlG16HV6jVTWQ==
X-Google-Smtp-Source: APBJJlHclvSaOXTYSY7ga3ilQUsxNoNVRQcTaYmIpW5+0sfba2ByWNf/0wFWNCkQjGoKbZETE0pwXQ==
X-Received: by 2002:a7b:c852:0:b0:3f7:e7a2:25f6 with SMTP id
 c18-20020a7bc852000000b003f7e7a225f6mr336417wml.17.1689630220062; 
 Mon, 17 Jul 2023 14:43:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.144.39])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a05600c2a4a00b003fc0505be19sm624788wme.37.2023.07.17.14.43.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 14:43:39 -0700 (PDT)
Message-ID: <bbd0229b-8401-4672-7a61-4bc3bdc8d32d@linaro.org>
Date: Mon, 17 Jul 2023 23:43:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 0/6] linux-user: brk() syscall fixes and armhf static
 binary fix
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230717213545.142598-1-deller@gmx.de>
Cc: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230717213545.142598-1-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 17/7/23 23:35, Helge Deller wrote:
> Commit 86f04735ac ("linux-user: Fix brk() to release pages") introduced the
> possibility for userspace applications to reduce memory footprint by calling
> brk() with a lower address and free up memory.
> This change introduced some failures for applications with errors like
> - accesing bytes above the brk heap address on the same page,
> - freeing memory below the initial brk address,
> and introduced a behaviour which isn't done by the kernel (e.g. zeroing
> memory above brk).
> 
> This patch set fixes those issues and have been tested with existing
> programs (e.g. upx).
> 
> Additionally it includes one patch to allow running static armhf executables
> (e.g. fstype) which was broken since qemu-8.0.
> 
> Helge
> 
> Helge Deller (6):
>    Revert "linux-user: Make sure initial brk(0) is page-aligned"
>    linux-user: Fix qemu brk() to not zero bytes on current page
>    linux-user: Prohibit brk() to to shrink below initial heap address
>    linux-user: Fix signed math overflow in brk() syscall
>    linux-user: Fix strace output for old_mmap
>    linux-user: Fix qemu-arm to run static armhf binaries

I'm not sure this series will reach Markus at
Markus F.X.J. Oberhumer <notifications@github.com> =)
Cc'ing his "minilzo.h" address.


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05687800B3C
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 13:42:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r92qY-0000HZ-Ot; Fri, 01 Dec 2023 07:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r92qT-0000H8-Du
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 07:42:13 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r92qR-0004Ai-4X
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 07:42:12 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50bdebb1786so136754e87.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 04:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701434529; x=1702039329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rzr2C3tYaTtpvC5YjlZy+d5GSu5v+cRvuPJ4uwng2do=;
 b=pxdvT0ZOioFNWatz3xVRod5NmcIwUUViZTUXzRvqemW9xiCi/QBVRNTCx4e/IEuoJV
 qvc8P67BKcCageEfrddNCjMmB0fzrEInZ5tvRwSrf8Kb7SMfyrHro87v+Opmj8V7HFI5
 ovt9IdawYNabSbI3QHGHhfYKm8b1bQ3aesl6J2SKekelGV3v2jjt89dFQJlsi8lJj68W
 Q0DMHjmc34N4mCZhXrcVqTZgHzrhnTzRruQIFhBoTBeGGLUUf5bOETomWgq9aOeqh/Hf
 Vqae3gPb3M/zSzsAfAjhvhsoPeb04ywooQ8Mf4Hyby6lyI59TydcH4/4fd/81dCb3sWF
 v8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701434529; x=1702039329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rzr2C3tYaTtpvC5YjlZy+d5GSu5v+cRvuPJ4uwng2do=;
 b=N9ppruVuDrz8QeMUdLR8uGC05lTvvnXBKoCF0YRfLKqczqyBCIuw+BJ7fm1Tp/Ln2x
 18B0S+DQVZ22t5I9Tg0yVtq3d+86wCRkRVV8Juc6B6skqvfRnPdKTccsL2WDJ2GHfXn+
 k4/FP3Ik3OABbI3KzdnXHU7n/geRxbIRtg9pOMpHkuedUFM3Tl3NqSjtd3qnto4jwIcB
 dyteZQRTEYS4Sq43lzzHAw+f3nEmTIvHUJAQt9Ws+aQoYll1RtIxWw2q/tndCIo3mfl8
 PdTBOBZkUXGA8H49GYZ/7GSyvG3TxGfi5OxrTtOkxjSDMgz8KDUcN13swjAhyrnMbYCK
 rJ4A==
X-Gm-Message-State: AOJu0YxeNdbXSnUPeMCux5UQUDgb5tYylcSTY29W5uS2o7cx8+SCsEJT
 8HevDoYc8bupBbGwRHSKu5qKCA==
X-Google-Smtp-Source: AGHT+IGy6DXeCHekWscBu5A+XV6JibkKF+ChfM6qbl0dYiQPfLd8+DUzxv1hU6jvFQRVX0OQTHV8TQ==
X-Received: by 2002:ac2:52ba:0:b0:50b:d177:d9e7 with SMTP id
 r26-20020ac252ba000000b0050bd177d9e7mr640922lfm.3.1701434529422; 
 Fri, 01 Dec 2023 04:42:09 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 e2-20020adf9bc2000000b003332fa77a0fsm2094388wrc.21.2023.12.01.04.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 04:42:09 -0800 (PST)
Message-ID: <63d6f19a-ec9b-4397-bf90-95e89a618838@linaro.org>
Date: Fri, 1 Dec 2023 13:42:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user: Fix openat() emulation to not modify atime
Content-Language: en-US
To: Shu-Chun Weng <scw@google.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, Jonah Petri
 <jonah@petri.us>, Edoardo Spadolini <edoardo.spadolini@gmail.com>
References: <20231201032140.2470599-1-scw@google.com>
 <20231201032140.2470599-3-scw@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231201032140.2470599-3-scw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Shu-Chun,

On 1/12/23 04:21, Shu-Chun Weng wrote:
> Commit b8002058 strengthened openat()'s /proc detection by calling
> realpath(3) on the given path, which allows various paths and symlinks
> that points to the /proc file system to be intercepted correctly.
> 
> Using realpath(3), though, has a side effect that it reads the symlinks
> along the way, and thus changes their atime. The results in the
> following code snippet already get ~now instead of the real atime:
> 
>    int fd = open("/path/to/a/symlink", O_PATH | O_NOFOLLOW);
>    struct stat st;
>    fstat(fd, st);
>    return st.st_atime;
> 
> This change opens a path that doesn't appear to be part of /proc
> directly and checks the destination of /proc/self/fd/n to determine if
> it actually refers to a file in /proc.
> 
> Neither this nor the existing code works with symlinks or indirect paths
> (e.g.  /tmp/../proc/self/exe) that points to /proc/self/exe because it
> is itself a symlink, and both realpath(3) and /proc/self/fd/n will
> resolve into the location of QEMU.

Does this fix any of the following issues?
https://gitlab.com/qemu-project/qemu/-/issues/829
https://gitlab.com/qemu-project/qemu/-/issues/927
https://gitlab.com/qemu-project/qemu/-/issues/2004

> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>   linux-user/syscall.c | 42 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 33 insertions(+), 9 deletions(-)



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CD479D94B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 21:06:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8hZ-0007Jp-2V; Tue, 12 Sep 2023 15:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg8hV-0007HM-Ng
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 15:05:30 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qg8hH-0002Qa-Jm
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 15:05:29 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c09673b006so41507295ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694545508; x=1695150308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9cE6dlOK7PUKJvQKUhn22FMshXGllyUQFOniRyleHH0=;
 b=Wkzc5gcyVSL3lv5JUOf7iBhvRT39c0Rxlvt88AvqmYbL9r298x3Q/wnezIjIKnTDQU
 e0T7MJgo8AcvltJ8D51OXnH3Lz7+GzH9ZX3vOhmln+f7gUgoMvp2yhOgFNp8eZbifM09
 hSDuALBDX8MOUhsOXfb073XorizrsO1oaHmRyo/QWhqCHy9ecNYYBB9ZnaG8ZERXuM4k
 L+mKiqgS3Kn+1xNTLeX+VUSSQ7O+aKDyl4bLIzAZoMrQLursIY46jzA2PF2d1s+FUNX+
 gVGeeMT/TsfLsvxv6eH9uYDSwg6Zw+0NR2lXc7Bu4Kwtmw3F9d1upPeI9Kw3SqoslR6N
 4B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694545508; x=1695150308;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9cE6dlOK7PUKJvQKUhn22FMshXGllyUQFOniRyleHH0=;
 b=qSZBJf98UAGR86rUI7PuNe6byGEUv41aceuXTw6RrNUpodzKLWIOPoeC4jvRw2WXaR
 PaEi/Zc/XRd4NlXjbUMorUMF0zggSILM7dCSMyshASnvTxnEhOGToZBXRW08YVk27cer
 OcwrNdsdq6e8MW4W9RfAKljLi2O+7APIVoPP+FGJyclecAJ5vZjdS8V3v3x9n/lZDVkl
 Ph1+nUd0gC1niUHzSU9o3zvP7rB8GSFr6Ot9HULZooR+qeIM0dliXwUN8/4xLTV+lOrM
 zZ8++NmCN5AW2PRwHlBCDfyPl/lRFwT8eRfoAHJ2f76LKMwjFuHw2Ek99062CSJJ6rZg
 RNwg==
X-Gm-Message-State: AOJu0YzIBOFWO0rMevPkjUQ2ofDHCDZ65tI9BSsI4OusK8LzroDSBnUV
 fpIkSl0XOYxcgq9mlx/ulasvLg==
X-Google-Smtp-Source: AGHT+IGkjSTCE+3iQGR9tf//8t5vf/K4kdxCvpTUzDC++n26FhVR4jBo7ghUZlnKYn/+wb21OaZTLg==
X-Received: by 2002:a17:902:ce85:b0:1c1:ec40:9321 with SMTP id
 f5-20020a170902ce8500b001c1ec409321mr742423plg.60.1694545507678; 
 Tue, 12 Sep 2023 12:05:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a170902a40c00b001b891259eddsm8753322plq.197.2023.09.12.12.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 12:05:07 -0700 (PDT)
Message-ID: <c2993aec-a002-a7ad-b27e-c9c9253d2abe@linaro.org>
Date: Tue, 12 Sep 2023 12:05:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/4] qtest: kill orphaned qtest QEMU processes on FreeBSD
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>
References: <20230912184130.3056054-1-berrange@redhat.com>
 <20230912184130.3056054-3-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230912184130.3056054-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/12/23 11:41, Daniel P. Berrangé wrote:
> On Linux we use PR_SET_PDEATHSIG to kill orphaned QEMU processes
> if we fail to call qtest_quit(), or the test program aborts/segvs.
> This prevents meson from hanging forever due to the orphaned
> process keeping stdout open.
> 
> On FreeBSD we can achieve the same using PROC_PDEATHSIG_CTL, which
> gives us the equivalent protection against hangs.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/libqtest.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 34b9c14b75..b1eba71ffe 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -24,6 +24,9 @@
>   #ifdef __linux__
>   #include <sys/prctl.h>
>   #endif /* __linux__ */
> +#ifdef __FreeBSD__
> +#include <sys/procctl.h>
> +#endif /* __FreeBSD__ */
>   
>   #include "libqtest.h"
>   #include "libqmp.h"
> @@ -414,6 +417,10 @@ static QTestState *G_GNUC_PRINTF(1, 2) qtest_spawn_qemu(const char *fmt, ...)
>            */
>           prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>   #endif /* __linux__ */
> +#ifdef __FreeBSD__
> +        int sig = SIGKILL;
> +        procctl(P_PID, getpid(), PROC_PDEATHSIG_CTL, &sig);

We could use 0 for "current process", but this works too.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


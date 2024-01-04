Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE395824622
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:27:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQYd-00068a-74; Thu, 04 Jan 2024 11:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQYa-00067s-OD
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:26:56 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQYY-0001pK-UT
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:26:56 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3367601a301so544790f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704385613; x=1704990413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ABRr9DwPYWDIh06BsEiyMJoio67xealvfTczb5e8umg=;
 b=R/Ngc7J/6Rf4sdb9XJOq7hSNyydzJcgiQzMZTmvD+akus1EUU43Mo4qGAy6VZ3yAmD
 09XBspMuOg61wEq4sgOQ98CLnZIEoT/pcGB/+4hRaC3iqxctH5SjlQSW4pmUIEQQiYT4
 Prx+0O4EiFz0qaslf5WBwiyO6LM+VYJ9rv9/xjHIl8ER4x1KeAyXvkwHZefMObEsprD4
 efPtkyU327M2dF7O28N49SJaa6vN9MJF46ql1XsGKm+ZjFXPbaP6SnNKg73X3TGzAS9Y
 PWGnVh8sRQUCkB6G705JJaxd3ie2LeicbW2MSi3iQ+FPMDk8Cd48GvtwggNqYnSXtF9S
 V8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704385613; x=1704990413;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ABRr9DwPYWDIh06BsEiyMJoio67xealvfTczb5e8umg=;
 b=mVCPr+FSrYY3NhG7W8zWhMyrWwfeOzk9dVgWOf+9K4ksrNSSfsO2X37WUKUr+omZJk
 9glWdRub6AQOjCuQ6eiSuK70l7TBEW94bqg6DIhh1r6i9udgXj4zh5ljpHyRTtD39cU5
 n9YufUzFVs2PwaECgPHnpcw4o8sC67yx8QL6sNmPmyCIWrvOePfx7xa/D1oot5p+h6Mt
 HWQF+4mYo3neC233bkYe5tBc/qYUKvuOenA7VDdYqMM+KB8UdNmkwzKZ+H3a/Q3YEoY8
 4s6XfA4065CZ50ck6D+tTmiTekNEQcPF300MBtT0Wcjav+P+pfciwabiAha3e31vQ/b4
 YGuA==
X-Gm-Message-State: AOJu0YyhTCTCe1VlKR3DknfHx9yKnH1AUDpBqQW84aXUoHhX2tlok//l
 u2CorWuSNyOehAbC9sE+DXs44vpcbEGkGw==
X-Google-Smtp-Source: AGHT+IF0zXUjl2ZVrGMPNtVfCYbsoSWAtrBaGBsmAyN1Pp49BlXsCbwLig5vv2BvkntWrPFUdbiStA==
X-Received: by 2002:a5d:5902:0:b0:336:d9a6:494f with SMTP id
 v2-20020a5d5902000000b00336d9a6494fmr360338wrd.131.1704385613411; 
 Thu, 04 Jan 2024 08:26:53 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a5d5948000000b00336aa190139sm28477953wri.5.2024.01.04.08.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 08:26:52 -0800 (PST)
Message-ID: <5f7b5921-b6e3-48f1-8bec-b4fdbfdac2f1@linaro.org>
Date: Thu, 4 Jan 2024 17:26:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util: fix build with musl libc on ppc64le
Content-Language: en-US
To: Natanael Copa <ncopa@alpinelinux.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231219105236.7059-1-ncopa@alpinelinux.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231219105236.7059-1-ncopa@alpinelinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Natanael,

On 19/12/23 11:51, Natanael Copa wrote:
> Use PPC_FEATURE2_ISEL and PPC_FEATURE2_VEC_CRYPTO from linux headers
> instead of the GNU specific PPC_FEATURE2_HAS_ISEL and
> PPC_FEATURE2_HAS_VEC_CRYPTO. This fixes build with musl libc.
> 
> Fixes: 623d7e3551a6 (util: Add cpuinfo-ppc.c)

Hmm this commit barely moved the code. Maybe it revealed the
issue from the following commits?

Fixes: 63922f467a ("tcg/ppc: Replace HAVE_ISEL macro with a variable")
Fixes: 68f340d4cd ("tcg/ppc: Enable Altivec detection")

Anyhow, changes LGTM.

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1861
> 
> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
> ---
>   util/cpuinfo-ppc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
> index 1ea3db0ac8..b2d8893a06 100644
> --- a/util/cpuinfo-ppc.c
> +++ b/util/cpuinfo-ppc.c
> @@ -6,10 +6,10 @@
>   #include "qemu/osdep.h"
>   #include "host/cpuinfo.h"
>   
> +#include <asm/cputable.h>
>   #ifdef CONFIG_GETAUXVAL
>   # include <sys/auxv.h>
>   #else
> -# include <asm/cputable.h>
>   # include "elf.h"
>   #endif
>   
> @@ -40,7 +40,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>           info |= CPUINFO_V2_06;
>       }
>   
> -    if (hwcap2 & PPC_FEATURE2_HAS_ISEL) {
> +    if (hwcap2 & PPC_FEATURE2_ISEL) {
>           info |= CPUINFO_ISEL;
>       }
>       if (hwcap & PPC_FEATURE_HAS_ALTIVEC) {
> @@ -53,7 +53,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>                * always have both anyway, since VSX came with Power7
>                * and crypto came with Power8.
>                */
> -            if (hwcap2 & PPC_FEATURE2_HAS_VEC_CRYPTO) {
> +            if (hwcap2 & PPC_FEATURE2_VEC_CRYPTO) {
>                   info |= CPUINFO_CRYPTO;
>               }
>           }



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8038F80DD15
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:28:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnpJ-00021J-3M; Mon, 11 Dec 2023 16:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnpG-0001sG-SI
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:28:30 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnpD-00075d-JW
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:28:30 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c4846847eso13156235e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702330106; x=1702934906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X5fiX191P4G5pBLsLalRnbHg5N0cH0B6SHCS4O/yB3g=;
 b=lnIki7Ee4hFuOUfBzwIqjrikWC2HSncy8TRwDYk6s/5mI8K8iuJejP1o1u6/8CTePh
 d5yTO/DpONZTSyorfqJUAKMjXtlv8tPQF2+X0lOnjsedfFssqv5eTmVrQyOsd/gmZ+On
 wqX3N7eXgwzOqtkO7lOTIzsjK6VNaCgIzrlPNb7M3AOfugCc7zQ9ifs1vvP9le7+XGLp
 G0skBeS1mt2WinqkNNH63aMb/v2ehFiwad6YH6cfAEBSSsdYE2WCrrBiPKim8f3UdEik
 p+WXlmfQMh2dZDz+QI6LTprM7hb0JSiCaYlAUdCrGCTSzq4cTdaR1J/f7vSmjNleu8mN
 lpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702330106; x=1702934906;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X5fiX191P4G5pBLsLalRnbHg5N0cH0B6SHCS4O/yB3g=;
 b=nROzO4LGBkz/BkG1BjMyo5cgSYC21muItiOFBsa7ZNFOdCpgV1a8OC88UJbJEBhKjb
 B1EPKRztDS9ETzTUMPy9iutQ4hmva/BvF2vZ7CtH/sNY/HmaoT+cnbPpn4Rndt5OjFx4
 XcS5c8fFC80j0n2wAn3N2weeQQUpH/phcfIOXvKI0xN6g/QcX5ijKJVFthnubwo6PkJH
 0AKpNR3iIY5V7JR4YH6TPESyBiUDAsY+4PZy5zr7LtKXC/+nv+BOBIWmtE5CWRc8a8Rj
 cduOg5E/8xdeMAn0s59DIcPtEMjFN+t0npxEk2ifPkQ1FzMcRNsipgAIqsgaSL9AkVB8
 gxSA==
X-Gm-Message-State: AOJu0YxoQ8Vc6m5KyqPDJnAtn1aQJhnDOylDU8Y+Z2Bzb09rT9FDDd8F
 cu9j+VYLEFrtKRFJWERO/85mdPc9C37HwGNmd/ue8w==
X-Google-Smtp-Source: AGHT+IGF9wlJDqbTFsQ+lI7POZDFz1IPDejuBWORh8oTC1zt3ac9hgvmD2JUuv0T0TaVCeR5cmcUZg==
X-Received: by 2002:a1c:770b:0:b0:40c:7a3:888e with SMTP id
 t11-20020a1c770b000000b0040c07a3888emr2762705wmi.148.1702330105669; 
 Mon, 11 Dec 2023 13:28:25 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a056000114f00b0033359ae2d52sm9380197wrx.17.2023.12.11.13.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 13:28:25 -0800 (PST)
Message-ID: <1738ff77-057a-4f92-9a58-e1e1573db3d2@linaro.org>
Date: Mon, 11 Dec 2023 22:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] exec: Declare abi_ptr type in its own
 'tcg/abi_ptr.h' header
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Claudio Fontana <cfontana@suse.de>, Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-21-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231211212003.21686-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/12/23 22:19, Philippe Mathieu-Daudé wrote:
> The abi_ptr type is declared in "exec/cpu_ldst.h" with all
> the load/store helpers. Some source files requiring abi_ptr
> type don't need the load/store helpers. In order to simplify,
> create a new "tcg/abi_ptr.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu_ldst.h   | 17 +++--------------
>   include/exec/exec-all.h   |  1 +
>   include/exec/translator.h |  5 ++++-
>   include/tcg/abi_ptr.h     | 32 ++++++++++++++++++++++++++++++++
>   accel/tcg/cputlb.c        |  1 +
>   5 files changed, 41 insertions(+), 15 deletions(-)
>   create mode 100644 include/tcg/abi_ptr.h
> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 25e7239cc5..c69f02b699 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -65,18 +65,9 @@
>   #include "exec/memopidx.h"
>   #include "qemu/int128.h"
>   #include "cpu.h"
> +#include "tcg/abi_ptr.h"
>   
>   #if defined(CONFIG_USER_ONLY)
> -/* sparc32plus has 64bit long but 32bit space address
> - * this can make bad result with g2h() and h2g()
> - */
> -#if TARGET_VIRT_ADDR_SPACE_BITS <= 32
> -typedef uint32_t abi_ptr;
> -#define TARGET_ABI_FMT_ptr "%x"
> -#else
> -typedef uint64_t abi_ptr;
> -#define TARGET_ABI_FMT_ptr "%"PRIx64
> -#endif
>   
>   #ifndef TARGET_TAGGED_ADDRESSES
>   static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
> @@ -120,10 +111,8 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
>       assert(h2g_valid(x)); \
>       h2g_nocheck(x); \
>   })
> -#else
> -typedef target_ulong abi_ptr;
> -#define TARGET_ABI_FMT_ptr TARGET_FMT_lx
> -#endif
> +
> +#endif /* CONFIG_USER_ONLY */
>   
>   uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
>   int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr);


> diff --git a/include/tcg/abi_ptr.h b/include/tcg/abi_ptr.h
> new file mode 100644
> index 0000000000..415e31cabb
> --- /dev/null
> +++ b/include/tcg/abi_ptr.h
> @@ -0,0 +1,32 @@
> +/*
> + * TCG abi_ptr type
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +#ifndef TCG_ABI_PTR_H
> +#define TCG_ABI_PTR_H
> +
> +#include "cpu-param.h"
> +
> +#if defined(CONFIG_USER_ONLY)
> +/* sparc32plus has 64bit long but 32bit space address

Forgot to squash:

-- >8 --
@@ -11,3 +11,4 @@
  #if defined(CONFIG_USER_ONLY)
-/* sparc32plus has 64bit long but 32bit space address
+/*
+ * sparc32plus has 64bit long but 32bit space address
   * this can make bad result with g2h() and h2g()
---

> + * this can make bad result with g2h() and h2g()
> + */
> +#if TARGET_VIRT_ADDR_SPACE_BITS <= 32
> +typedef uint32_t abi_ptr;
> +#define TARGET_ABI_FMT_ptr "%x"
> +#else
> +typedef uint64_t abi_ptr;
> +#define TARGET_ABI_FMT_ptr "%"PRIx64
> +#endif
> +
> +#else /* !CONFIG_USER_ONLY */
> +
> +#include "exec/target_long.h"
> +
> +typedef target_ulong abi_ptr;
> +#define TARGET_ABI_FMT_ptr TARGET_FMT_lx
> +
> +#endif /* !CONFIG_USER_ONLY */
> +
> +#endif



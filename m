Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F7E7B4025
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 13:41:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmYKs-0004iS-WF; Sat, 30 Sep 2023 07:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qmYKq-0004ZL-Nd
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 07:40:36 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qmYKo-0007x7-KX
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 07:40:36 -0400
Received: from [192.168.1.2] (unknown [223.72.88.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 7F53144345;
 Sat, 30 Sep 2023 11:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1696074033; bh=tzPbO8A6Z2+bEvBhmefwyLemAs+i685mx+X8l4EBSXs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=nvmKJjBijMa/wF3AQzPWM/GpwYDKaKWrPy0SZBx7j1ILWLu2qjJiMMSRMtNWNr8/D
 9TAiOlpLilqEI4WTzX+XbcedQCRyIkJtFqpmyjX1PXXMp85kas+R5XJ2X/4kmSzGcg
 1cDryA/0w8H9qj4HsEG2dyg6dUR3pJtGEf6YRRHg=
Message-ID: <c030c757-9fa6-4137-b303-abf2dcd202fc@jia.je>
Date: Sat, 30 Sep 2023 19:40:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] util: Add cpuinfo for loongarch64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, gaosong@loongson.cn, yangxiaojuan@loongson.cn
References: <20230916220151.526140-1-richard.henderson@linaro.org>
 <20230916220151.526140-4-richard.henderson@linaro.org>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <20230916220151.526140-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


On 2023/9/17 06:01, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/loongarch64/host/cpuinfo.h | 21 +++++++++++++++
>   util/cpuinfo-loongarch.c                | 35 +++++++++++++++++++++++++
>   util/meson.build                        |  2 ++
>   3 files changed, 58 insertions(+)
>   create mode 100644 host/include/loongarch64/host/cpuinfo.h
>   create mode 100644 util/cpuinfo-loongarch.c
>
> diff --git a/host/include/loongarch64/host/cpuinfo.h b/host/include/loongarch64/host/cpuinfo.h
> new file mode 100644
> index 0000000000..fab664a10b
> --- /dev/null
> +++ b/host/include/loongarch64/host/cpuinfo.h
> @@ -0,0 +1,21 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Host specific cpu identification for LoongArch
> + */
> +
> +#ifndef HOST_CPUINFO_H
> +#define HOST_CPUINFO_H
> +
> +#define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
> +#define CPUINFO_LSX             (1u << 1)
> +
> +/* Initialized with a constructor. */
> +extern unsigned cpuinfo;
> +
> +/*
> + * We cannot rely on constructor ordering, so other constructors must
> + * use the function interface rather than the variable above.
> + */
> +unsigned cpuinfo_init(void);
> +
> +#endif /* HOST_CPUINFO_H */
> diff --git a/util/cpuinfo-loongarch.c b/util/cpuinfo-loongarch.c
> new file mode 100644
> index 0000000000..08b6d7460c
> --- /dev/null
> +++ b/util/cpuinfo-loongarch.c
> @@ -0,0 +1,35 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Host specific cpu identification for LoongArch.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "host/cpuinfo.h"
> +
> +#ifdef CONFIG_GETAUXVAL
> +# include <sys/auxv.h>
> +#else
> +# include "elf.h"
> +#endif
> +#include <asm/hwcap.h>
> +
> +unsigned cpuinfo;
> +
> +/* Called both as constructor and (possibly) via other constructors. */
> +unsigned __attribute__((constructor)) cpuinfo_init(void)
> +{
> +    unsigned info = cpuinfo;
> +    unsigned long hwcap;
> +
> +    if (info) {
> +        return info;
> +    }
> +
> +    hwcap = qemu_getauxval(AT_HWCAP);
> +
> +    info = CPUINFO_ALWAYS;
> +    info |= (hwcap & HWCAP_LOONGARCH_LSX ? CPUINFO_LSX : 0);
> +
> +    cpuinfo = info;
> +    return info;
> +}
> diff --git a/util/meson.build b/util/meson.build
> index c4827fd70a..b136f02aa0 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -112,6 +112,8 @@ if cpu == 'aarch64'
>     util_ss.add(files('cpuinfo-aarch64.c'))
>   elif cpu in ['x86', 'x86_64']
>     util_ss.add(files('cpuinfo-i386.c'))
> +elif cpu == 'loongarch64'
> +  util_ss.add(files('cpuinfo-loongarch.c'))
>   elif cpu in ['ppc', 'ppc64']
>     util_ss.add(files('cpuinfo-ppc.c'))
>   endif


Reviewed-by: Jiajie Chen <c@jia.je>




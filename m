Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D35C7781E0A
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 16:13:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXjAb-0006Hs-39; Sun, 20 Aug 2023 10:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjAZ-0006Hk-Pf
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:12:43 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjAX-0004hT-C9
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:12:43 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6bd0a0a675dso2046438a34.2
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692540759; x=1693145559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pTuQ1PoWywkbA3xHLPXKEhb1ECKXgvcN/IYTsRNAw5c=;
 b=q739wwIQ3jnHMO/ENh+4UwVSyIrm1d2wakiPiXKBnRAznHH00ejP9jRFyel6vObGSS
 ycvhZxsrdB8oVvmb62DTCftbgeABP5YkkYmya5BF7ATXcSzYkTjT+hg04X32pgeig286
 tRuWTPxDqZiWD6j0eVbOcQ5gTC/TuxGYebuyHfyBBpI7Ej84zP/ki0DOamtzvpUtXggg
 cIkZp2viwVE928CYnKvTrC5vz8pkDnDaaCUq9tXejCw6pjj7zHyhRyyi/kF6EgGatvOe
 +UweW/TgiwnrBL6COixezV51cT4Qn9GdmhmA8ZgI4kXA7+9YzzlTJFWx7cNgvJYJ9fE3
 WoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692540759; x=1693145559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pTuQ1PoWywkbA3xHLPXKEhb1ECKXgvcN/IYTsRNAw5c=;
 b=f/35Yl1ZTzOWkELfGwDPnK5+QcalUugd5q2gOrRRwHOB+GybZGUzp7xBvJ2Yj1Fku1
 VotE55AtIijolICCWq4AD/4CtQ1nYxEuUo1Flt+6lwTmlePfxgloS5i2xQcJT6k6oQqw
 j5bfpltvtejhgagiHtdYNHEKNWLv3JhnWTYruOAlnfb6KYHudru2g5jqD8AMblw9a3fI
 muRPplEsI06QCCVJJ86sWCr2z8p9GeSHfD1TbeTnIki+qMatSB60VKaD9NM0diTZ5saU
 vQUgBXgFt9tYPV5736mnUdtmDr56bhOgZhidaS0Rfn7372/7pHCs49jiIelt5jGEbC06
 665A==
X-Gm-Message-State: AOJu0YxHB/+orpkUvM+iCHVudH4UexVKmTSO+jbvxo0pJMonmfgl7l1M
 Zgs2lJJ5ymEnry5/HdWfZeD9YA==
X-Google-Smtp-Source: AGHT+IFFVzFqA6qEWdiUBl8+21NWL/jQAbQ3XT4YJCLVCdxcZGNJSs8efHO7rANA+7U6gOGzNBDQSg==
X-Received: by 2002:a05:6870:e412:b0:1b0:80d0:b895 with SMTP id
 n18-20020a056870e41200b001b080d0b895mr5354158oag.12.1692540759470; 
 Sun, 20 Aug 2023 07:12:39 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 bg23-20020a17090b0d9700b002680b2d2ab6sm6305650pjb.19.2023.08.20.07.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 07:12:38 -0700 (PDT)
Message-ID: <95a1ef9d-60c7-cb2c-3f3c-db7232c4628f@linaro.org>
Date: Sun, 20 Aug 2023 07:12:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/22] Implement target_set_brk function in bsd-mem.c
 instead of os-syscall.c
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?Q?Mika=c3=abl_Urankar?= <mikael.urankar@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-9-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-9-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/19/23 02:47, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Co-authored-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.c            | 38 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  4 ----
>   2 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
> index e69de29bb2..6c123abf04 100644
> --- a/bsd-user/bsd-mem.c
> +++ b/bsd-user/bsd-mem.c
> @@ -0,0 +1,38 @@
> +/*
> + *  memory management system conversion routines
> + *
> + *  Copyright (c) 2013 Stacey D. Son
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +
> +#include <sys/ipc.h>
> +#include <sys/shm.h>
> +
> +#include "qemu.h"
> +#include "qemu-bsd.h"
> +
> +struct bsd_shm_regions bsd_shm_regions[N_BSD_SHM_REGIONS];


This and the ipc/shm includes don't belong with this patch.


> +
> +abi_ulong bsd_target_brk;
> +abi_ulong bsd_target_original_brk;
> +abi_ulong brk_page;
> +
> +void target_set_brk(abi_ulong new_brk)
> +{
> +

Blank line.

> +    bsd_target_original_brk = bsd_target_brk = HOST_PAGE_ALIGN(new_brk);
> +    brk_page = HOST_PAGE_ALIGN(bsd_target_brk);

I encourage you to use TARGET_PAGE_ALIGN instead.
This will match changes made in linux-user during the 8.1 cycle.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


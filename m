Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 331F278CFF7
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:09:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n4-0000qh-Oe; Tue, 29 Aug 2023 19:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4T6-0007kb-Ql
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:33:42 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4T4-0002pU-1D
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:33:40 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso37659485ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693337614; x=1693942414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uV/9uEyRUKpdVwHTpr43oW5Sg+3ITqtobdL1fUNdPMo=;
 b=Hkm70mBArWKGbunuA2bgnJZzfQBo8caILek8CosrxWKO3ouD0LqsRnjtdV2bY5PZAs
 UyBXLYB8OzOd9ZGR6q0lkyId9clWQpFHNnqxA/mcQ6QNarOOAX6ibD2DLfNsFcyl9V+M
 V4joyGKmkeL7HXtrsGg2cB8r9igiVqCqeaIGLS26+AQ6NVodXzlQlr3ddfJSKx8pi5NV
 HHHNvKGQdDLuQfNcJHBDKOBB5UmpG1ZBweADfJvoUwcxF5p/Epf0FR4ss7nxYt+TeEVs
 /ECmk/b7lCrqadT/ifR6pU9jTX1Z2HQ+uUNtCwBCyRj2bulC/X5G9IZBvA/4hhHlLw/B
 49yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693337614; x=1693942414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uV/9uEyRUKpdVwHTpr43oW5Sg+3ITqtobdL1fUNdPMo=;
 b=IyfZ6Nskaj50bxQSwpvMHfo1hkZfsBKLtRs1vk2VdN5I6P31M6BgOOgB4JtZl+blKA
 sVvYbdGjCJI2S4ZcgImBxEUyv2hEcwGfxRPMa6+COEqMiBlAlvd2vKfMyGzTsrAnYr/2
 RJDWRUjAVdi439HhRo6TifglrH4QpfakAc3UjkEGW9tJ4JQ9OJRJN9wGVn37Sph5VasL
 o92XHsNw3jBd8TFdoZrFXMhL3KqZoMdhzusT8tDunCn3P5KSZNWoWq/m6pNl4TSnpeIn
 U4cvxj/bQs/GSIICmYFB2IAetPbG8SOCWtqlz9Skl54SfexX3G/i6g431sVshKDrnvkw
 RoWw==
X-Gm-Message-State: AOJu0Yw1X8J+cw+F3rQQlkhWBs2VXd4eElgToWON/Ka1X7CxG9frJmFp
 e3awM4z9H+o7bWIruSUmY3xAiA==
X-Google-Smtp-Source: AGHT+IHbCUFtno5+NpJvyFSNhGCb7AyCaOYcXKf8WmGoX7aUAnBEdX1KgiR568dNQWyL2BRxKssOsA==
X-Received: by 2002:a17:902:b7c4:b0:1b7:fd82:973c with SMTP id
 v4-20020a170902b7c400b001b7fd82973cmr33895plz.39.1693337614537; 
 Tue, 29 Aug 2023 12:33:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 iy4-20020a170903130400b001b016313b1dsm9745649plb.86.2023.08.29.12.33.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:33:34 -0700 (PDT)
Message-ID: <95746225-14ff-efa7-4c88-f51c44198162@linaro.org>
Date: Tue, 29 Aug 2023 12:33:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 07/32] bsd-user: Implement target_to_host_resource
 conversion function
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-8-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-8-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-proc.c | 83 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 83 insertions(+)
>   create mode 100644 bsd-user/bsd-proc.c
> 
> diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
> new file mode 100644
> index 0000000000..ae2e636bb3
> --- /dev/null
> +++ b/bsd-user/bsd-proc.c
> @@ -0,0 +1,83 @@
> +/*
> + *  BSD process related system call helpers
> + *
> + *  Copyright (c) 2013-14 Stacey D. Son
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
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include <sys/cpuset.h>
> +#include <sys/resource.h>
> +#include <sys/wait.h>
> +
> +#include "qemu.h"
> +#include "qemu-bsd.h"
> +#include "signal-common.h"
> +
> +#include "bsd-proc.h"
> +
> +/*
> + * resource/rusage conversion
> + */
> +int target_to_host_resource(int code)
> +{

This should be the identity function, correct?


r~

> +
> +    switch (code) {
> +    case TARGET_RLIMIT_AS:
> +        return RLIMIT_AS;
> +
> +    case TARGET_RLIMIT_CORE:
> +        return RLIMIT_CORE;
> +
> +    case TARGET_RLIMIT_CPU:
> +        return RLIMIT_CPU;
> +
> +    case TARGET_RLIMIT_DATA:
> +        return RLIMIT_DATA;
> +
> +    case TARGET_RLIMIT_FSIZE:
> +        return RLIMIT_FSIZE;
> +
> +    case TARGET_RLIMIT_MEMLOCK:
> +        return RLIMIT_MEMLOCK;
> +
> +    case TARGET_RLIMIT_NOFILE:
> +        return RLIMIT_NOFILE;
> +
> +    case TARGET_RLIMIT_NPROC:
> +        return RLIMIT_NPROC;
> +
> +    case TARGET_RLIMIT_RSS:
> +        return RLIMIT_RSS;
> +
> +    case TARGET_RLIMIT_SBSIZE:
> +        return RLIMIT_SBSIZE;
> +
> +    case TARGET_RLIMIT_STACK:
> +        return RLIMIT_STACK;
> +
> +    case TARGET_RLIMIT_SWAP:
> +        return RLIMIT_SWAP;
> +
> +    case TARGET_RLIMIT_NPTS:
> +        return RLIMIT_NPTS;
> +
> +    default:
> +        return code;
> +    }
> +}
> +



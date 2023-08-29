Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 694DB78D030
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:18:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7np-0001Z7-Tt; Tue, 29 Aug 2023 19:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb59U-0006OE-TK
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:17:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb59P-00029I-HF
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:17:27 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bf6ea270b2so30220845ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693340239; x=1693945039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t2G5p8UZ72Ji5VKPpsJ1h6cGzcUi+2WSVp3N33klaFM=;
 b=bnQu3ztCy9ZJ/UumiP8HAJnfoHOZ9yUIrnVVwEqdZav9kuEvpijQ5zZdfG5hnYxVcz
 hW5Pz3R4fCA3gjXvqkcZ/vQ+b58V10QQ/GJ8q0NlpPxLM8Ht/RfiHDIDyP8ct4xpkQkM
 XosD1SxSAmghZZk1ekOvTloSqOVuBnrtm0K6vIyAky0prpUwlK2aBSEdCh09KkzKIb4s
 /gi+tjBv2V27qV+ptV4MwbpE1sno1Ysq1GEymo4FvKk+CwXzEkNAoigHWuF5zOSgZSJW
 3z7Y4gO9vjW1hnvFSEGnVj9gXjeVSzf7qMD8zZ6LfsrK3qNP9j44uoS63lmMqFFvmiK3
 zFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693340239; x=1693945039;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t2G5p8UZ72Ji5VKPpsJ1h6cGzcUi+2WSVp3N33klaFM=;
 b=jgYnellrWXD0xgFcEeAnvWDLYSprgg12yoqPh46oW1X/bKSFTwPPJN3VKoONJOPqDR
 n0lm7sdYeoD2X0WizUujvoQ516uFiAbbIanawxf4KsT8yVRTfJ1VQM6Oe5MhRkINd+VD
 37bnncBR3EzljEivL4QE5sDMY3kyjTJSG0gdiw8+zXm5O4UfApDwjOz+vjfqxVgXyD7E
 P9d93D2tf6UsWAEtHrrQSsE+ScZrVxVZ8BJtWTE+iZJ+cdxwS53g2oyz1BsHjq4+t5ze
 wSSKS5yOcnbejeqEixJjXiuNXqQblB5RpTKW4ulzX5Ocu7C/FKhhMCDhNO9jOjtM+hof
 QwWw==
X-Gm-Message-State: AOJu0Yx2EcG92nPTM000uXXdM8Np5lQJrPMc6anAQpifLI2fBgUu5KKj
 NB7uLueZVEpPQa6+AjjqO85pTehh8Ye7l0UkrF4=
X-Google-Smtp-Source: AGHT+IElG8sTeEuwkRKQqYbvNWDrtCyCITshqyO27l3EMx7DyfP56hCO0tICR/sf5/daN+Jo78sieQ==
X-Received: by 2002:a17:902:e5c1:b0:1bf:3c10:1d72 with SMTP id
 u1-20020a170902e5c100b001bf3c101d72mr172505plf.66.1693340239251; 
 Tue, 29 Aug 2023 13:17:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 iy4-20020a170903130400b001b016313b1dsm9781101plb.86.2023.08.29.13.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:17:18 -0700 (PDT)
Message-ID: <b753bbef-4e73-5a89-eece-b57ac27780ff@linaro.org>
Date: Tue, 29 Aug 2023 13:17:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 21/32] bsd-user: Implement get_filename_from_fd.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-22-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-22-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
>   bsd-user/freebsd/os-proc.c | 74 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 74 insertions(+)
>   create mode 100644 bsd-user/freebsd/os-proc.c
> 
> diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
> new file mode 100644
> index 0000000000..5cd800e607
> --- /dev/null
> +++ b/bsd-user/freebsd/os-proc.c
> @@ -0,0 +1,74 @@
> +/*
> + *  FreeBSD process related emulation code
> + *
> + *  Copyright (c) 2013-15 Stacey D. Son
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
> +#include <sys/queue.h>
> +#include <sys/sysctl.h>
> +struct kinfo_proc;
> +#include <libprocstat.h>
> +
> +#include "qemu.h"
> +
> +/*
> + * Get the filename for the given file descriptor.
> + * Note that this may return NULL (fail) if no longer cached in the kernel.
> + */
> +static char *
> +get_filename_from_fd(pid_t pid, int fd, char *filename, size_t len)
> +{
> +    char *ret = NULL;
> +    unsigned int cnt;
> +    struct procstat *procstat = NULL;
> +    struct kinfo_proc *kp = NULL;
> +    struct filestat_list *head = NULL;
> +    struct filestat *fst;
> +
> +    procstat = procstat_open_sysctl();
> +    if (procstat == NULL)
> +        goto out;

Need braces.  Several checkpatch.pl errors.

With those fixed,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96821774CCB
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:18:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTU5J-0001u2-Ey; Tue, 08 Aug 2023 17:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTU5H-0001tZ-SX
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:17:43 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTU5G-0007jD-32
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:17:43 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6874d1c8610so4483823b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691529460; x=1692134260;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wYonWHb2qlLbJhqOBfwALXsAphH5Yty3eX6V2TK6kvQ=;
 b=x3J40E03E5UgZ1y+HTp+yY4oECzslPchb5n78c2SqzJHoFdGNCjxQ4sPqd64SOzcbv
 ZsuLChMtgF1/I9VBevgMl6ujZ9RMLL/9+7l+9yaAm9SXhLIYb5miScixvVx0/VGW6YKB
 QNdwblbUZRc4+kuPQNyTqg0vr7dthvjrAVO4XSMIi4l1OMQKTxqOKPsdRsBWtvbSARBd
 4nWUcrgS6bGCBHWDiqsIVMfjBOYakcLQUB+iSgs9KKfEBR8gCqIgEa7XUaNNeQVZ1eUs
 yFAErpVMglv6AQWJBd44V0h5rLRW3ZlLKpmpY1MpvpoGFOALIBV8pwUBXCkvmJtlKUx6
 pGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691529460; x=1692134260;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wYonWHb2qlLbJhqOBfwALXsAphH5Yty3eX6V2TK6kvQ=;
 b=fISAGVXMsEOue/eBc8grPjc/TnISlCCEEYi0JAl1xq2peX6G8LeR03Lk9RyxtkUr1k
 6fBkp44ZculfUlx9v4V8gaxT19owvBIv6m+9c7zvmCVEoXTrC8kp0CXrrf2OSnsJmQ9A
 V9rjqfzZ2EMhJWjXxLKuZWYcDPIC40C3CCluP+qQAzEUIXfJAlhNHNLBpjd158+8+JER
 Rr+O8XnDEN3KZC+IPP9ze35XbjGyQwL5ufB2x/c7yi9SHg6HnMZhl/hLtvLm+NUcM5qJ
 4lqk9MuR4GteYRR31ku35bwWqtO5L8btNN3/3UOlBrnqrZszqKfQwzEB0RsgOAfZnTJA
 EGVQ==
X-Gm-Message-State: AOJu0YytsYS0qPkZQ7s0eh1QI+SXazG4g8goGpBQoFSrwu5Ggf7F9dwJ
 fV0WNQuzhtdGfsRSWK0kMFimQA==
X-Google-Smtp-Source: AGHT+IHo1UFf42Bag5GInNQnM29/OsA3vIHcEBAKWpxxBxPYLDa2fZcwUVOEHtvGZaNjlFUWyigB1Q==
X-Received: by 2002:a05:6a20:7485:b0:13d:73c3:7ab3 with SMTP id
 p5-20020a056a20748500b0013d73c37ab3mr883112pzd.13.1691529460378; 
 Tue, 08 Aug 2023 14:17:40 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 x19-20020aa793b3000000b00668652b020bsm8525674pff.105.2023.08.08.14.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:17:40 -0700 (PDT)
Message-ID: <30573feb-4eb2-5dc7-3d32-4a7bc1577805@linaro.org>
Date: Tue, 8 Aug 2023 14:17:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/33] Declarations of h2t and t2h conversion functions.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-5-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-5-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 23:07, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Declarations of functions that convert between host and target structs.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/qemu-os.h | 35 +++++++++++++++++++++++++++++++++++
>   bsd-user/qemu.h            |  1 +
>   2 files changed, 36 insertions(+)
>   create mode 100644 bsd-user/freebsd/qemu-os.h
> 
> diff --git a/bsd-user/freebsd/qemu-os.h b/bsd-user/freebsd/qemu-os.h
> new file mode 100644
> index 0000000000..7ef4c55350
> --- /dev/null
> +++ b/bsd-user/freebsd/qemu-os.h
> @@ -0,0 +1,35 @@
> +/*
> + *  FreeBSD conversion extern declarations
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
> +
> +#ifndef QEMU_OS_H
> +#define QEMU_OS_H
> +
> +/* qemu/osdep.h pulls in the rest */
> +
> +#include <sys/acl.h>
> +#include <sys/mount.h>
> +#include <sys/timex.h>
> +#include <sys/rtprio.h>
> +#include <sys/select.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +
> +struct freebsd11_stat;
> +
> +#endif /* QEMU_OS_H */
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index c41ebfe937..1344c3fce6 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -38,6 +38,7 @@ extern char **environ;
>   #include "exec/gdbstub.h"
>   #include "qemu/clang-tsa.h"
>   
> +#include "qemu-os.h"
>   /*
>    * This struct is used to hold certain information about the image.  Basically,
>    * it replicates in user space what would be certain task_struct fields in the

The subject and comment do not match the patch, or at least not obviously.
This appears to merely include some extra system headers, not declare any sort of 
coversion functions.


r~


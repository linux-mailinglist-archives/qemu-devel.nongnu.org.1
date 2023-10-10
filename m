Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AEC7BFB97
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:35:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBwx-0007qT-Kl; Tue, 10 Oct 2023 08:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBwr-0007pL-6v
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:34:56 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBwp-0000AB-JL
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:34:52 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9b98a699f45so943772666b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696941290; x=1697546090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vfx2Ir6cqCUlrpN4ktqrmIdQP8T+TuX78vsFoNGqhx4=;
 b=AnGRMk6yh1JYPrLRI2K4GczFWq75/0t3HPKGu3Qdy6oQA6uThTT2ntHXNmuA5fGx6c
 qTBwZuXJZeuwoJuifP3W7PERLlZs/Xsr2cx3dCGBToHiqk/zNukaUfawQzdyZHZXw1Ds
 yQx72zsPAkv9uAwRWINGUHw/lzNzlGlawoxuVUIIHpfRcKkuWMacJXjg0G8ByicKZInT
 /AcclLXHVBexgA+4ngC3naMFanNj54evJMy4EfZDVlArk2chX4lTNR8y1gD4gSykbZHu
 t/3YUpK2YdZUcrgr4lS5285p2PLgmWmoM73hWMv1N4m11tZmTGuWfqrSKf+eAXxnN1R4
 Z6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696941290; x=1697546090;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vfx2Ir6cqCUlrpN4ktqrmIdQP8T+TuX78vsFoNGqhx4=;
 b=eTIcnWOCgvqp66g8u1fRXJhs1C0sALVJITMEf3d6MtgfA62yhXxmYG6XZj/PnlSbxl
 ffiPJKLt0Kqf60qnvQXQR7/a6WissBgRlRzZa+0CrPqf+ABjXiwZDWbEQO4idsNinULO
 ft7mw4tNOpkdrnpbUmIs5jzVfobC+luFfmFWke4C6xVau4mwNYxotPev5XqDtjnasClp
 2rJoI/oDJRdrDwd1qaDb0uC1fn6UXcQo5oDJYB7/d4GIOpxsjNnRErhyhibhYntf6Las
 rEy7FKa+nnI/184uRu70wQOEq1d9QGh74c6obQxFJfltlyspPyoK15c+NJGTxoJQ7Ik0
 Jdvg==
X-Gm-Message-State: AOJu0YzcASAIl+RAQJ1IrmliMtqSx+qZgPL5oJ/kEQurr9Z+4JGigkFb
 OnYvM4RxkXoE9GMjpIeIaB7zPw==
X-Google-Smtp-Source: AGHT+IGiEtvxGzWwTluEqCxH8ScKFi/B2ZvYZRrT1NUWzdvJfWp+GwB+2Ot321tYl/FdjAH9+KuB/A==
X-Received: by 2002:a17:906:2d1:b0:9b2:b765:8802 with SMTP id
 17-20020a17090602d100b009b2b7658802mr17676912ejk.40.1696941289919; 
 Tue, 10 Oct 2023 05:34:49 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 a23-20020a17090680d700b00993cc1242d4sm8331125ejx.151.2023.10.10.05.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:34:49 -0700 (PDT)
Message-ID: <9fcdaa43-7cf4-2b0c-3a29-a71767453702@linaro.org>
Date: Tue, 10 Oct 2023 14:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v17 10/16] util/log: Add -d tb_stats
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: fei2.wu@intel.com, "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003183058.1639121-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 3/10/23 20:30, Richard Henderson wrote:
> From: Fei Wu <fei2.wu@intel.com>
> 
> Enable TBStatistics collection from startup.
> 
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> [rth: Change "tb_stats_foo" to "tb_stats:foo"]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   stubs/tb-stats.c  | 16 ++++++++++++++++
>   util/log.c        | 36 +++++++++++++++++++++++++++++++-----
>   stubs/meson.build |  1 +
>   3 files changed, 48 insertions(+), 5 deletions(-)
>   create mode 100644 stubs/tb-stats.c
> 
> diff --git a/stubs/tb-stats.c b/stubs/tb-stats.c
> new file mode 100644
> index 0000000000..ceaa1622ce
> --- /dev/null
> +++ b/stubs/tb-stats.c
> @@ -0,0 +1,16 @@
> +/*
> + * TB Stats Stubs
> + *
> + * Copyright (c) 2019
> + * Written by Alex Bennée <alex.bennee@linaro.org>
> + *
> + * This code is licensed under the GNU GPL v2, or later.
> + */
> +
> +
> +#include "qemu/osdep.h"
> +#include "tcg/tb-stats.h"
> +
> +void tb_stats_init(uint32_t flags)
> +{
> +}

We don't need this stub anymore.


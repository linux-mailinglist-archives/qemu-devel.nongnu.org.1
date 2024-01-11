Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533C82AF16
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 14:01:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNug9-0003Rf-DC; Thu, 11 Jan 2024 08:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNufy-0003GC-9D
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:00:53 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNuft-0002u5-Rw
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 08:00:50 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d4414ec9c7so26999515ad.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 05:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704978032; x=1705582832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZhkqY9wbwdboUzlaO1BQoY73+y7tIrtaZflHeIsbim4=;
 b=IQjzNMAYsnZB0XfsSW6nrAz+clRzuxA7kvSLj+vwybMJHCioGYRdTVAo6E2/b7Rlsx
 lmIMVd3wr2db6hObiqMUvTTxpN8MLXWDnrBqZsiQSs5e8rV5+HUayLfwayVAOHcXTG0W
 Cht0BX5ir+KpRow4dftkrxwTqRqOBPU6n2EDHXwfxp5MJCYYilkiWRBIZXCkMsiekI36
 6pdc6FHl+mywv3LVFjzKdjeh9P7bIJ4vcSir1f2cgCuui6YZoenbDbFZhxKLE08IGsdM
 Vr4vXC9CAODgjI/9JmJIxpIxy+lf2GZZ63ZwuYsoQmNLPznj0dz5GnbGQ8rCcK/0rVPK
 A5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704978032; x=1705582832;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZhkqY9wbwdboUzlaO1BQoY73+y7tIrtaZflHeIsbim4=;
 b=Pa1tpRlaGxMI9iLQl2JjV3cOgeVOD6Noa4tPKw2ZbHux2qN1kybZEl2R3WOs/V4hYt
 5L0uj3GiYim4DlyXObc6oglrYRDY9BGFkjak1PHBOtd063D8v3jphpiVkEE4DKFaMOHq
 Gf6W3bQzg2GMwq3OeSXAxsEHRJ6tJvQ/hVigHYSXvqFHM0eLj3xZsv4OsOiIjZFtRzAM
 MTieYK0wPLTZoCAbd/TZhjfVk3/xSzkci+z1jH5IkoxQ2GKR8TBvIPlIV6UNlxGU8pDF
 4T6cHUJGXqoAHSdtjnYxX5SuIyFa50Yw26fOlC4ljSaKSQCtnWcE6iGhNn/raCkRgSBY
 TmgA==
X-Gm-Message-State: AOJu0Yz7LL7t82LBEzU04rGzTBZi8SHSAt7PeXnK1xueWCkbUH5QKroN
 rw2IGNVg0t7NNt68ZOgUhaatiDvumJzsxA==
X-Google-Smtp-Source: AGHT+IGOayzWtXJlY08AFwGe0Jn0k/fb7tg2CUjzrvml/mlYHdtWkGQGhURYiacKgIP7atvqGyf96Q==
X-Received: by 2002:a17:902:d2c2:b0:1d3:f1b7:aaf3 with SMTP id
 n2-20020a170902d2c200b001d3f1b7aaf3mr1285418plc.7.1704978032674; 
 Thu, 11 Jan 2024 05:00:32 -0800 (PST)
Received: from [192.168.68.110] ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a170902c98b00b001d4c97a2adcsm1115031plc.108.2024.01.11.05.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 05:00:32 -0800 (PST)
Message-ID: <f51eb537-aa16-4c6f-929e-8e4de5b74491@ventanamicro.com>
Date: Thu, 11 Jan 2024 10:00:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] accel: Rename accel_init_ops_interfaces() to include
 'system'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, qemu-s390x@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bin.meng@windriver.com>,
 qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <laurent@vivier.eu>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Eric Farman
 <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
References: <20240111120221.35072-1-philmd@linaro.org>
 <20240111120221.35072-2-philmd@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240111120221.35072-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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



On 1/11/24 09:02, Philippe Mathieu-Daudé wrote:
> accel_init_ops_interfaces() is system specific, so
> rename it as accel_system_init_ops_interfaces() to
> ease navigating the code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   accel/accel-system.h | 2 +-
>   accel/accel-system.c | 2 +-
>   accel/accel-target.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/accel/accel-system.h b/accel/accel-system.h
> index d41c62f21b..2d37c73c97 100644
> --- a/accel/accel-system.h
> +++ b/accel/accel-system.h
> @@ -10,6 +10,6 @@
>   #ifndef ACCEL_SYSTEM_H
>   #define ACCEL_SYSTEM_H
>   
> -void accel_init_ops_interfaces(AccelClass *ac);
> +void accel_system_init_ops_interfaces(AccelClass *ac);
>   
>   #endif /* ACCEL_SYSTEM_H */
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index fa8f43757c..f6c947dd82 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -62,7 +62,7 @@ void accel_setup_post(MachineState *ms)
>   }
>   
>   /* initialize the arch-independent accel operation interfaces */
> -void accel_init_ops_interfaces(AccelClass *ac)
> +void accel_system_init_ops_interfaces(AccelClass *ac)
>   {
>       const char *ac_name;
>       char *ops_name;
> diff --git a/accel/accel-target.c b/accel/accel-target.c
> index 7e3cbde5df..08626c00c2 100644
> --- a/accel/accel-target.c
> +++ b/accel/accel-target.c
> @@ -104,7 +104,7 @@ static void accel_init_cpu_interfaces(AccelClass *ac)
>   void accel_init_interfaces(AccelClass *ac)
>   {
>   #ifndef CONFIG_USER_ONLY
> -    accel_init_ops_interfaces(ac);
> +    accel_system_init_ops_interfaces(ac);
>   #endif /* !CONFIG_USER_ONLY */
>   
>       accel_init_cpu_interfaces(ac);


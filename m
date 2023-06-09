Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A867297AA
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 13:00:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZqU-00023S-AM; Fri, 09 Jun 2023 06:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7ZqL-000212-OV
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:59:46 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7ZqK-0004Eg-9y
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:59:45 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51475e981f0so2880169a12.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686308381; x=1688900381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gSwM5ocFyjPjrFFGNW5+/3c2958Gcr72hfqR4DH6giI=;
 b=K0+8y9TmToeF8ITAO5JTWgd69Ot0bJ1OJGdd3LHX6uTYraamiY7KThfRtW9EX8Pur9
 K2T2bqoji5TdWx2Yzx7UqZwSUK2xEdksThmq7LUQEtp1MLkgHPS7mfx+9EoSXGERiVkA
 6mzBRKt+qDJNThjJTec5rcTghFZnsmPHKIOXlyIfMGq/AKXQ0UEFraQMhtkkZmhx40GM
 kdZWtTySVaHGzUMCpmoJbqDGarn4yZFT36ZxRy1YjYKR/iB4sFNRYQW/axdvmlKDJZWC
 njwOdbn+iIJZvsdeMvS6AMRfGw24k34majhIQbZk2eP4ptM67DTnjrQPcVpJK3VKf3e7
 oiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686308381; x=1688900381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gSwM5ocFyjPjrFFGNW5+/3c2958Gcr72hfqR4DH6giI=;
 b=VyAJEHJqolV5MBBvHuArgop/F0ewomJx1UWYYZITa5GYTTDxXrAULP3hAXal4jSCds
 DoLJuSuHrgvYbY2d/Ybpox7UqG5SeilCWpF3pckvRlrt6TNSENxUV7k6mM12cXatsJhO
 s91aLNWM/fqIs3oZ91NAfFuxALC6BpEC1KzIu4QevsrJevPD/cMiDcnEPuS0Kdg+6ldG
 Mi/DfJK02GhGqsH000efSyOARyaDxwDdnTOxK704qdf2PLhNl4sYA7jbAWgVbd8i4DTZ
 zuB/xGssVuqI+oibx0Y0kGBTht+9iQCYH07JAHTTaepgORWqLLSKh0OwlDY68t5YgVCv
 +l5A==
X-Gm-Message-State: AC+VfDxY1ZHHoYw6Xjg9yDMdEs45KMwzX7FuX28PtxoAHfpLjv5zpFKI
 L7x3FB1a3nz8uTS7f4/zdPSvZob7eFGlmlzaMCHJMg==
X-Google-Smtp-Source: ACHHUZ5I2xf9eUMnVOLHVKaPT8eBEH2KKCSCk2Tu1K9GgEdi8dKQ08RrbauOu+pmYtlYXzNuOcFb3fl5qW7Ekw3cjnU=
X-Received: by 2002:a05:6402:4ca:b0:514:94ff:f67e with SMTP id
 n10-20020a05640204ca00b0051494fff67emr1082375edw.5.1686308380979; Fri, 09 Jun
 2023 03:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
 <20230529151503.34006-5-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230529151503.34006-5-alexander.ivanov@virtuozzo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Jun 2023 11:59:30 +0100
Message-ID: <CAFEAcA_53f0zaoBYYAyingf0nOUg-qKA0WR0ehewba-DMhs4+g@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] parallels: Replace fprintf by qemu_log in check
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com, 
 stefanha@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com, 
 hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 29 May 2023 at 16:16, Alexander Ivanov
<alexander.ivanov@virtuozzo.com> wrote:
>
> If the check is called during normal work, tracking of the check must be
> present in VM logs to have some clues if something going wrong with user's
> data.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> Reviewed-by: Denis V. Lunev <den@openvz.org>
> ---
>  block/parallels.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 9fa1f93973..d64e8007d5 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -42,6 +42,7 @@
>  #include "qemu/bswap.h"
>  #include "qemu/bitmap.h"
>  #include "qemu/memalign.h"
> +#include "qemu/log-for-trace.h"
>  #include "migration/blocker.h"
>  #include "parallels.h"
>
> @@ -436,8 +437,8 @@ static void parallels_check_unclean(BlockDriverState *bs,
>          return;
>      }
>
> -    fprintf(stderr, "%s image was not closed correctly\n",
> -            fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR");
> +    qemu_log("%s image was not closed correctly\n",
> +             fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR");

Generally speaking you shouldn't directly call qemu_log().
Instead call qemu_log_mask() and pass it the relevant
QEMU_LOG_* constant for whichever kind of -d debug logging
this is. The raw qemu_log() function is for the odd case
of expensive logging where you want to say
 if (log category foo enabled) {
     do expensive calculation;
     qemu_log(result1);
     qemu_log(result2);
 }

But this doesn't look like the kind of logging we would usually
do with qemu_log(). Notably, the default for the qemu_log machinery
is to not output anything at all: it's only enabled if the user
explicitly turns on debug logging with a -d option.

You probably want warn_report() here.

thanks
-- PMM


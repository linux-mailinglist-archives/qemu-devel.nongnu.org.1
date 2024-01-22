Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA33836CE1
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:19:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxxR-0004Am-0X; Mon, 22 Jan 2024 12:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxxO-0003xS-Ai
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:19:34 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxxM-0000GT-KH
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:19:34 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50f11e3ba3aso4789238e87.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705943971; x=1706548771; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nOuVqYsY25fbSgS7lcvfK7yI74qqDUhmBtWz6qpie0M=;
 b=iUX3gF8k21RXRwDM4oNXkWElmUJ2mqkeIB+QAGytewyo14h+JrK8b4x4DzEU49FMq6
 rJU+f1ArtRwSzueyvuWNUvxAbZjphfWo/nbaM6d8rxwymK23gAUM3JYCrff973ywJaMQ
 7O8IvrcToGG6ipBlu6PiiRnu/xS9CPLT+sblbXkGadsb1W/J1wsuWYGmPPgnz8W0JG6I
 NVmQmNK9L8eg/LwX4ZX8CdvW8cjFRVKPozzmt2LKxdH8A/1/HV+xNZDW6yoOn9G+xBct
 yAZT48XSJOvjtiuoI98nOIQQGEjkiyFGK0JUb6lf9U00kCfntm3sP6PXqhNWj/Uub9ZT
 zZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705943971; x=1706548771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nOuVqYsY25fbSgS7lcvfK7yI74qqDUhmBtWz6qpie0M=;
 b=c/JUYGwMs9+IqC0FLiUwmU3K65XKeXL/9sM3Dq8jR2EolBGPTrq1yc7tS6iqh9hYH6
 svW73LKnXAeJ4FRdbi/bdFH158lQptG7ziWPg2TKLzvL45/9uzti/ZvbByKSWAdfeuY9
 Wbq/p+OQSZlxrohbYoyaBs6QugHcXW+XKKwhbusJ5ZNKJSM6I8Z3THkQZISX7QqVbiYW
 GhtRek9MNzP5Kv6sOWhDWN/aWlb1zdYJG8FaOnG+wVSn4Nb3DfbXPUyAtZbnFJV0yJOW
 c4u4JXlZ541pBNm90tFTFQogVZA4t8k5TNDx6QQILfLLNPKQ941fAPnq+p9IO4Wg3Vds
 eAlg==
X-Gm-Message-State: AOJu0Yxt82Sd4zNZHn1a+MAqYsNGnMi7n3HU/92TgWSNnG0RmNlmYu0t
 yAplI2CUo5JUEAO7Sh11mGwKz2IS3Q7scI4bHqIwisT865cOqIHu0lA4hXxHaVM/DrXWIRD0aPu
 KwPeynh+0VDF6bf1Q5o1L5kRgUECdua52yCYQyQ==
X-Google-Smtp-Source: AGHT+IEezds9HE4rr3Jx7va30iV5/CDxmS6KuUMefsLSvSUCtx/OgVW/sCxnWVjIzaoHTXdC3FsI4fbY9VOfC2W4yz0=
X-Received: by 2002:a05:6512:3991:b0:50e:69df:b067 with SMTP id
 j17-20020a056512399100b0050e69dfb067mr2265131lfu.11.1705943970616; Mon, 22
 Jan 2024 09:19:30 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mmk4cPk6ZHETfq5BtQxK63A6PiuCKrvv4yyOPBxVTW+OQ@mail.gmail.com>
In-Reply-To: <CAHP40mmk4cPk6ZHETfq5BtQxK63A6PiuCKrvv4yyOPBxVTW+OQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 17:19:19 +0000
Message-ID: <CAFEAcA_BAz3SyqHLkU6YKedHvZTVUNsjy2tkxWJTBd9JZNgtnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Include new arbitrary limits if not already defined
To: Manolo de Medici <manolodemedici@gmail.com>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org, Eric Blake <eblake@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Thu, 18 Jan 2024 at 16:03, Manolo de Medici <manolodemedici@gmail.com> wrote:
>
> qemu uses the PATH_MAX and IOV_MAX constants extensively
> in the code. Define these constants to sensible values ourselves
> if the system doesn't define them already.
>
> Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> ---
>  include/qemu/osdep.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 9a405bed89..9fb6ac5c64 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -363,6 +363,14 @@ void QEMU_ERROR("code path is reachable")
>  #define TIME_MAX TYPE_MAXIMUM(time_t)
>  #endif
>
> +#ifndef PATH_MAX
> +#define PATH_MAX 1024
> +#endif
> +
> +#ifndef IOV_MAX
> +#define IOV_MAX 1024
> +#endif
> +
>  /* Mac OSX has a <stdint.h> bug that incorrectly defines SIZE_MAX with
>   * the wrong type. Our replacement isn't usable in preprocessor
>   * expressions, but it is sufficient for our needs. */

Ccing some people who know more about portability concerns
than I do...

thanks
-- PMM


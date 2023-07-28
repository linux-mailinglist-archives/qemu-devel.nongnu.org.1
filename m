Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC9766A08
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 12:17:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPJt0-0005Fl-Ei; Fri, 28 Jul 2023 05:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPJsh-0005Ea-CO
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:35:35 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPJsf-0001Fa-33
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:35:30 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5222b917e0cso2603065a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690536927; x=1691141727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=62ulqA1XW4h2+mDWfEM+WylhbOuOKiiFv7P+O98DLt4=;
 b=YvP72YHKWzm7x1v/35TyVum2LufgjLlc+joepwXnA05Cam5LnlM93LaTgJPEj8Ezr3
 GTrw+qtQolz2wIYiczZxo9DLBLm8S5JoDFCrc63hC0w4GR6DwpRwANvtmGWFQLxp4eo0
 CdfwwCRprUFA0iWJSfkielARSDEIINMhr69b1qhvyg3ZD/7L00M+pBBK8MPfS/ORmOVl
 ks+jvIJaK5yy63jWJF7VmNPREL8p/0zhZQ4Sfpnwd+omyJ2AY2jw2/3WehJLHirHgZ6s
 Sq4+Ho67jz2mqeuykY3dwjK+h8ncODfSwuDDj1kbYnlb2MLKPV+OKMDcadz3ybmDOYJF
 MvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690536927; x=1691141727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=62ulqA1XW4h2+mDWfEM+WylhbOuOKiiFv7P+O98DLt4=;
 b=LevsajHyfHFRIcG5fMgjdLxfR00bz+nU6Th7IzpXt7mvPzuhvXKBzRpwKp+QUzoGwA
 1PzrHka+cQmYmrzSYG8CEKOO625foRj2cIyD++T5poYfRxu5NmauJRRf/aR8AAE/XKyq
 wS+m229kqosgjVY9OrHIORNbcP/9qmJN7VWRSmik569EoZZoVNC/DZEYqNzdCN7Yw5js
 Bqi7RzWwVzVunwecIZuaGLn7ZCpxPvkiQ+iJuSwBjq2AS3x9ZG+WX6YIK6ZUfApDj9MF
 Fn8sIe9oQg8TbwizqlferHP87wAS39U09xfyUF7nk3fPXRT3L/nhjzMfdNnK45tDhktT
 YAfg==
X-Gm-Message-State: ABy/qLZog76j+tFcE1ylboa9+rsJd/y0aKso2sKw/wPcz/mK20Oqgt8Z
 /i0zJYbGVaKxoDIh0YFfRdG4/yV+IaFmKIM5Co0BuA==
X-Google-Smtp-Source: APBJJlFuMzVNgUnnA3j18s5E7rPWlIdNdH9gYbEaihUtLe8TxrpFNBrjVFEjIqxEqnypB6IV/1u/Eu+DBGvAS5gTo/E=
X-Received: by 2002:a05:6402:326:b0:522:5855:ee78 with SMTP id
 q6-20020a056402032600b005225855ee78mr1426466edw.32.1690536927440; Fri, 28 Jul
 2023 02:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <ebdf2692-a155-6d2f-d46c-ddef02f4752a@linaro.org>
 <20230728051253.551-1-dinglimin@cmss.chinamobile.com>
In-Reply-To: <20230728051253.551-1-dinglimin@cmss.chinamobile.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2023 10:35:16 +0100
Message-ID: <CAFEAcA97SK=iGVfTbujC1iH32AYt8zVOkX+YzS7JtcxM-=jXsg@mail.gmail.com>
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc.
To: dinglimin <dinglimin@cmss.chinamobile.com>
Cc: mjt@tls.msk.ru, richard.henderson@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 28 Jul 2023 at 06:13, dinglimin <dinglimin@cmss.chinamobile.com> wrote:
>
> Replaced a call to malloc() and its respective call to free() with g_malloc() and g_free().
>
> Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
>
> v4 -> V5:Use g_try_malloc() instead of malloc()
> V3 -> V4:Delete null checks after g malloc().
> V2 -> V3:softmmu_unlock_user changes free to g free.
> V1 -> V2:if cpu_memory_rw_debug failed, still need to set p=NULL
>
> Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
> ---
>  semihosting/uaccess.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
> index 8018828069..35fdcd69db 100644
> --- a/semihosting/uaccess.c
> +++ b/semihosting/uaccess.c
> @@ -14,13 +14,20 @@
>  void *softmmu_lock_user(CPUArchState *env, target_ulong addr,
>                          target_ulong len, bool copy)
>  {
> -    void *p = malloc(len);
> -    if (p && copy) {
> +    void *p = g_try_malloc(len);
> +
> +    if (!p) {
> +        p = NULL;

This doesn't make sense -- if (!p) means p is already NULL,
so you don't need to set it to NULL.

> +        return p;
> +    }

This patch should just replace malloc() with
g_try_malloc() and free() with g_free(). You don't need to
change any of the rest of the logic in the function.

> +
> +    if (copy) {
>          if (cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0)) {
> -            free(p);
> +            g_free(p);
>              p = NULL;
>          }
>      }
> +
>      return p;
>  }
>
> @@ -87,5 +94,5 @@ void softmmu_unlock_user(CPUArchState *env, void *p,
>      if (len) {
>          cpu_memory_rw_debug(env_cpu(env), addr, p, len, 1);
>      }
> -    free(p);
> +    g_free(p);
>  }
> --
> 2.30.0.windows.2

thanks
-- PMM


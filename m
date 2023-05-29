Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E75D77147DF
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 12:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3a3V-00047L-Sz; Mon, 29 May 2023 06:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3a3T-00047C-Po
 for qemu-devel@nongnu.org; Mon, 29 May 2023 06:24:47 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3a3S-0006Qn-1N
 for qemu-devel@nongnu.org; Mon, 29 May 2023 06:24:47 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5147a478c38so4438156a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 03:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685355883; x=1687947883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TmiSPW6qkJCzv5y5ALJIMaVM8aSYBMyGS9WStSD8OIE=;
 b=fTceKxTgkWnQhLCuVNfA2T97T9UQ3eyzbWpSlcZekcOMYzf31WNoVz4THmAYXDGFj7
 +d/yaQnlEF+BtVUIqC/aW5x14+4nii/iAQGX8VjvQ+cN5Z8zaEdVVHn37Nd+ozgAry0T
 CHv+U90pxulYxvPw6057OZKy+vSu/4wnZQDw8Cvw/v0LiYxnuXcCUoaxlFhq3J35ZshL
 FfV4siAIBP8vv0YDzlAg+NQoBjPRsXUWNz7ND7Abfx9p1aw8s1Y/fQ/6oeZ+eLwcI/ma
 IaOQ/jEbhAaerixMYAo94O6PsKj2sHU1pSRD2/9ae2EWVEsXqsgJQcG6WV2iDpSetiT+
 s2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685355883; x=1687947883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TmiSPW6qkJCzv5y5ALJIMaVM8aSYBMyGS9WStSD8OIE=;
 b=IdcRHdL3h7pn4a3x3pqWlX+WDttzJzbPqnoxuFk+RROdAs8O8Opx3PPj5lafUXLvIH
 QmQ7/gCmeSCU8R2QQ+4dd+HroLYfsDAbGm5rPBclAczjq+V8mGx6AP/jbtBwH9sCt9CU
 63P8bTbO5Dpjn3tIGBez0P3VM0YcCuaJyJkqLZgXnvtq2Z1AP9nIiR6pWnBYOcoSvdUn
 bcsBJRsobrZlNXWgV6HcJr14kaBCvFzDuE6lne5M3A/UvIlPMmnILY3phcO9wSmzNGJ9
 JhTS4pQ/EUixDlBr08TUH1DGxobrE5fog/VlY1QeD3Nd0HY7C1U/CFIr3wUppyNjtVA0
 30ng==
X-Gm-Message-State: AC+VfDzaVLCk6leGKVyMoEu7shHGqaV5pkSzFbm5u7t1KobGxWCm9m/e
 cSyLVUuH7OKIDjz+A+XYEHmyJir6tn5c3yrGi5j1Tg==
X-Google-Smtp-Source: ACHHUZ411h+hfp6hKXpID2hUVxIQi6cAmN7NO60RZL5nlC2EDO6+szNUnjJGAsaDW9jP1IFd5mmMYrm+Zrs8T9HTfIk=
X-Received: by 2002:a05:6402:120a:b0:514:95e8:566c with SMTP id
 c10-20020a056402120a00b0051495e8566cmr3786179edw.42.1685355883565; Mon, 29
 May 2023 03:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <068f343a62de3dbc3764d0ad98111881b04a60d2.1685346951.git.mprivozn@redhat.com>
In-Reply-To: <068f343a62de3dbc3764d0ad98111881b04a60d2.1685346951.git.mprivozn@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 May 2023 11:24:14 +0100
Message-ID: <CAFEAcA_e9JmNacpFyG+SZareve2HJx+dFQwLbjyhmr6brm=9QQ@mail.gmail.com>
Subject: Re: [PATCH] meson: Avoid implicit declaration of functions
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 29 May 2023 at 08:58, Michal Privoznik <mprivozn@redhat.com> wrote:
>
> While detecting a presence of a function via 'cc.links()'
> gives desired result (i.e. detects whether function is present),
> it also produces a warning on systems where the function is not
> present, e.g.:
>
>   qemu.git/build/meson-private/tmph74x3p38/testfile.c:2:34: \
>   warning: implicit declaration of function 'malloc_trim' [-Wimplicit-function-declaration]

Produces a warning where ? On stdout/stderr ?

The linked bug report says "in the configure logs"
which is kinda vague. Warnings in the logfiles are
not a problem; warnings in the terminal output are...

> diff --git a/meson.build b/meson.build
> index 2d48aa1e2e..5da4dbac24 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1797,6 +1797,7 @@ malloc = []
>  if get_option('malloc') == 'system'
>    has_malloc_trim = \
>      get_option('malloc_trim').allowed() and \
> +    cc.has_function('malloc_trim', prefix: '#include <malloc.h>') and \
>      cc.links('''#include <malloc.h>
>                  int main(void) { malloc_trim(0); return 0; }''')
>  else

This seems super clunky -- surely this isn't the way Meson
intends people to write tests ?

thanks
-- PMM


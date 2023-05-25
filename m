Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF670710967
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 12:02:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q27ll-0004eG-Ry; Thu, 25 May 2023 06:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q27lk-0004e3-1h
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:00:28 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q27lh-0002V0-PP
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:00:27 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-510e90d785fso3526761a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685008823; x=1687600823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kiV8v/LYkR0Olbc5nUfPxouV8qF/v9cnDRmIXqEHKL8=;
 b=HprYFjnSI6PEg6cxBs3Jb9SbObZaLBimU+2Zs8nq3bevFu5TAC7pLr9WLGyYyGSAkJ
 8V5Pw+H+VDZl9Ve0f3+9qEo/+Ux5IT0fqwQq4/F8lcGYSNRu3TyjAeG5Bp6aA1+q6Jt/
 VLJdTPMEHg2VZ2jFbnMPeQqRMm+xHP1c9lIntau5I2eFiEL1Tp3SPKxXr5MFjbkM8skj
 NmIz8RhKKiS5U0K3wm50Cb+OzASzTaZvAgHhv7PLvX4oLC3ro/4P1voAY9a2LeIXyS1M
 fuBqLibmsKKjjn96BBtKNMLW+hB8fV6oTE2ldVdhhSsay5UCch0gabYKA7WEmTj50onq
 W5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685008823; x=1687600823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kiV8v/LYkR0Olbc5nUfPxouV8qF/v9cnDRmIXqEHKL8=;
 b=LJSN5H3n4DHotMqptN0QTKXzeKyUel/uWaMwyGxQU1JAdrxS/6TdSHMTiViyxoVgW9
 krPV9poyt14MP74EIJSoe6grFSnaC+dDvQ5l4xF2oS+ufmjtHJ5QjOleZ+BPVRWu9XM2
 jpEdw8u+wX/GJ3DkAuF+Ozru4/wTJjmCLXGY5zWz56YEaZhf9Jj+TIahnPAJcfYmvJbX
 Hw2Ckazd0wd08YLN8tFWHTNLLlGM3E46GFGPbqDjHMP1ystIybCPgzLz3e+GX9nWbGLT
 gH8SqFJX+28YLEopjohlKj7aiaUtEswRi2yMzJVHw1Ujly+3Jtp19/Zz3xb8XVWNxGyF
 deWw==
X-Gm-Message-State: AC+VfDw4WAOgg38E0mlZ77t93ntBcYrHIAK/ApcgT5qkiijb5kTax/6Z
 3TbViDHS4w3OWOJG066fmaFtz2Ls92wyJwt0h8pERw==
X-Google-Smtp-Source: ACHHUZ4QqJ3iPuex25lv1ZJLX2hY3LGF35ELkiyqeUqOIRuykDboHJVfb+hM23oXphrVeyyr0L5p3GIAn+AGiohhrzw=
X-Received: by 2002:a05:6402:3451:b0:510:ee0f:1eab with SMTP id
 l17-20020a056402345100b00510ee0f1eabmr3398742edc.41.1685008823600; Thu, 25
 May 2023 03:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230524173815.1148653-1-richard.henderson@linaro.org>
In-Reply-To: <20230524173815.1148653-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 May 2023 11:00:12 +0100
Message-ID: <CAFEAcA9+BGdG6bShPQ+SZzJNOjMAMJ2fVYqpcvR4vOVums+dMQ@mail.gmail.com>
Subject: Re: [PATCH] tests/decode: Emit TAP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 24 May 2023 at 18:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We currently print FAIL for the failure of a succ_* test, but don't
> return a failure exit code.  Instead, convert the script to emit
> Test Anything Protocol, which gives visibility into each subtest
> as well as not relying on exit codes.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/decode/check.sh | 36 ++++++++++++++++++++++++++----------
>  tests/meson.build     |  1 +
>  2 files changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/tests/decode/check.sh b/tests/decode/check.sh
> index 95445a0115..a3d879a099 100755
> --- a/tests/decode/check.sh
> +++ b/tests/decode/check.sh
> @@ -4,21 +4,37 @@
>
>  PYTHON=$1
>  DECODETREE=$2
> -E=0
> +E_FILES=`echo err_*.decode`
> +S_FILES=`echo succ_*.decode`

If you run shellcheck on this script it produces some
style complaints. Notably:

 * $(...) is better than `...`
 * j=$(($j + 1))  is better than j=`expr $j + 1`

At least some of its "missing quoting" complaints are
also legitimate, notably on $PYTHON and $DECODETREE.

thanks
-- PMM


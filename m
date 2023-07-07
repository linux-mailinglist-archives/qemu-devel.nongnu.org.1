Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D69474B06D
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 14:03:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHkAR-0008Pz-Lm; Fri, 07 Jul 2023 08:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1qHkAC-0008MH-Dt
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 08:02:18 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <naresh.kamboju@linaro.org>)
 id 1qHkAA-0003I3-S2
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 08:02:16 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4714e9f07c0so486594e0c.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 05:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688731331; x=1691323331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1fD1/s8Rr8USq+BqwdbXQVVmwBnxLCd0NcWZS3JC5Bg=;
 b=umXi5yArkAwiN/n9mTXgLHGqdF4VKbzP6F+EgLFsPtgxmajYaVeYaGOKSv8Gig3zUk
 xULUGADGBv7L75XAdemzVV7NvqSJQ+RWEzlsOWQ8eEpah/2YHBkKoBihWwUVWlzweRK9
 /g1f3ZX4/+P+NAfwDNul3YHp3WYFnqhyPUZEjgs7UdlO5wHNEL1zU3E7oKCq1M5/Juuk
 W8VYqXtaJyH8qjiBUZcNRla+DbUeRe+k6+HHBXXnddwv3UI54CTDNmXg+2Ome8n/Rn50
 YuWPlBFGQ4AO+PYqWwlwAMQv1kgdQp2cgn8XdGUDfl0K9VGpLxcwVmpJYKe277IZ2DOz
 GlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688731331; x=1691323331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1fD1/s8Rr8USq+BqwdbXQVVmwBnxLCd0NcWZS3JC5Bg=;
 b=TSD6+n4EEkTwrvUaIUgx+qmUQWUl/Jk0Kn11mOl899p2TIkPIw4tI/Csz1h+E5hHEz
 GMizisrzywZRd5U4HSzBGUlQIjXAktdXzSW+qnoLeX6E3DLKN80YEWKrjCt8CoPVvWml
 9TfVLlzh61G2Ac7vthO9jtJ2zW5koQBNRKefVKEXqbudvPgOiLHPWZP+dMSmgMo0SArC
 +3V5Y0Xs7dHrxe8PnkcStK9jhadMby08+nqukKXNAKMf/m4EYgtx3Waxzls5wneydmEz
 0vXy6wgGKtqW22cEY/XllLXSuHt4Wm6aVhXnbnWmYX9YaA+8ZJ3J4ybK8otNmfVui5HN
 yhVA==
X-Gm-Message-State: ABy/qLZ76iaIwugJ9wAgVr62vAbUVvBtJM07Gn5g3X5OUSNxKT5yzK6Q
 1xqB67JhLEkfXdg3+vi7zLVBm0jNuQ7QR1Q+8cOTvw==
X-Google-Smtp-Source: APBJJlEuByoAo+2h3fSm0XUgmVVrYyCj0oPh9BqxjX2ateTnFoMdZDd6t4wrsjCmbF0qXT1E7LyAgl1sRW3h/F8Bi9A=
X-Received: by 2002:a67:f643:0:b0:443:516b:782 with SMTP id
 u3-20020a67f643000000b00443516b0782mr1972918vso.33.1688731330651; Fri, 07 Jul
 2023 05:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230707103611.5906-1-richard.henderson@linaro.org>
In-Reply-To: <20230707103611.5906-1-richard.henderson@linaro.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 7 Jul 2023 17:31:59 +0530
Message-ID: <CA+G9fYtf+Yni==ZHcO_+Gqi2RE_k1FJ3z7MX+PuktVWYzbQ2+A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] accel/tcg: Fix race condition in tb
 create/invalidate
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, 
 lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=naresh.kamboju@linaro.org; helo=mail-vk1-xa34.google.com
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

On Fri, 7 Jul 2023 at 16:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v2:
>
> Adjust the change to cpu_exec_longjmp_cleanup, which should now survive
> user-only testing.  I'm not really happy with it.  I suggested two
> alternatives in the block comment, but neither of them are trivial.
>
> Please re-review, if you gave it a glance before.  And if you have
> any bright suggestions short of "use real exceptions", I'm all ears.

Thanks for your patch.
Since, The problem has been reported initially by LKFT, we would run our
LKFT test plans by using tuxtest with latest kernel and get back to you in the
next few days.

- Naresh

>
> r~
>
>
> Richard Henderson (2):
>   accel/tcg: Split out cpu_exec_longjmp_cleanup
>   accel/tcg: Always lock pages before translation
>
>  accel/tcg/internal.h      |  30 ++++-
>  accel/tcg/cpu-exec.c      |  63 ++++++----
>  accel/tcg/tb-maint.c      | 242 ++++++++++++++++++++------------------
>  accel/tcg/translate-all.c |  43 ++++++-
>  accel/tcg/translator.c    |  34 ++++--
>  5 files changed, 255 insertions(+), 157 deletions(-)
>
> --
> 2.34.1
>
>


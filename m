Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAC1753B4F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:50:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKIFb-00089b-Kp; Fri, 14 Jul 2023 08:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKIFI-00088o-Kf
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:50:06 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKIFG-00009c-OO
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:50:04 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-51e429e1eabso2288111a12.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689339001; x=1691931001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YJ5Jujc82u0z5kH9rnsFbWWRI2Pb1ytEMqh9R3JffMs=;
 b=tUF2nT78wZlDnVNSjvGonyKEPLTe7AZY7c40w3mcXFMGrJyOuAavE4oYJKg0QoMkDR
 9FB55b7uIWCb80a9+5MCEowOMlke2AslEjBwPYlrEmv7rtDgWC1AowvuLuzVyjQ3BFd3
 UljcfRMotf0rg6Y1xv1stiS1r2Fv3zfBCw2UBwbPNogXibIQBdzw9DLRlMvmBZ3WUVaU
 kwj2WkWrYNeMX0Bcx9nDcuGGzucxNPwW7b334H3mHcRAKdRFGF8CjtnDGg/1ZYSrzs7w
 Jsp2D66nsS1UAAX3vbSQRgIWNtIV6t7Oh05iOWfwr17fmT6O1f9X/v95E9WLj5u1BtBP
 pKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689339001; x=1691931001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YJ5Jujc82u0z5kH9rnsFbWWRI2Pb1ytEMqh9R3JffMs=;
 b=NaEeuCSxTlmTheSgDixliKdg6ccIXwKDLxyi7csBhPlBKiR8IGiULBM5LobIAbAQOa
 L7cY/b0NTlMV8YdXelm+KrfzbrCtilFQ2tjJC6BdFzPQCmAiJBYRgq1494zyHNWCWnXU
 0dpy0x67PKnh054yvgRV1gUzeGcvy9LPV+bb4bR+5gGVYueaQQrfaAK8fEnICO5oq9bO
 3Rpi2AxuyIb9wXm/1hgC6gwApPDBqgR4NZWvuTexxRyUDFHLcLfGBbFyYgCIZ6qSsR3M
 H+l45aIua0W5rudr5OY3eUTCJCxD95v/f549kDX7+I55VNaGC3TGSVy0Tx6X4OattZEH
 1ZBg==
X-Gm-Message-State: ABy/qLaW0jzOw0OHCeBzrBHXN3mTgO1ZU2mk7Jw/LTqXKsmY+ZQX143z
 8m7A9kmUWYSuK7124BA141UvOA2izpcjFCm3P49OVU1ItB90eht6
X-Google-Smtp-Source: APBJJlH4sJa/6DtqrPseH5U2GyKQdNfNJKQ7NzZJHM5cnyd48j2Jd0dEFXZhdsWvwtL91zxdhPaj63K844VWtt2CZJ0=
X-Received: by 2002:aa7:d8d4:0:b0:51d:8ab1:5df4 with SMTP id
 k20-20020aa7d8d4000000b0051d8ab15df4mr4087451eds.21.1689339000978; Fri, 14
 Jul 2023 05:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
 <20230714113834.1186117-17-mjt@tls.msk.ru>
In-Reply-To: <20230714113834.1186117-17-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2023 13:49:50 +0100
Message-ID: <CAFEAcA-VJG_Mt3AVtUeFPK+2sdg=kNabMijy0og9_fH=rQ92fw@mail.gmail.com>
Subject: Re: [PATCH, trivial 15/29] tree-wide spelling fixes in comments and
 some messages: other architectures
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 14 Jul 2023 at 12:40, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  host/include/aarch64/host/cpuinfo.h              |  2 +-

This...

>  hw/misc/allwinner-r40-dramc.c                    |  2 +-
>  hw/misc/exynos4210_rng.c                         |  2 +-

...these...

>  tests/tcg/aarch64/gdbstub/test-sve.py            |  2 +-
>  tests/tcg/aarch64/sme-outprod1.c                 |  2 +-
>  tests/tcg/aarch64/system/boot.S                  |  6 +++---
>  tests/tcg/aarch64/system/semiheap.c              |  2 +-

...and these are all arm, not "other".

But anyway, for the whole patch
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


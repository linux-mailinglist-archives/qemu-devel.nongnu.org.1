Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9526478C8E3
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:50:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb0xc-0000Wh-Tc; Tue, 29 Aug 2023 11:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb0xD-0000U6-QH
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:48:32 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb0x3-0005Ki-NZ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:48:27 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5009969be25so7166399e87.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693324096; x=1693928896;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EXPrfyyr2hdpxW518j3ac03xvpkVdrdr/zM5kAooNmk=;
 b=oxFqfeMf5HoU9CT+q3cG8vyocBqOscfnCXaiTsnDSTqQlwOTyHgkynkMWfNe7DPDoC
 ErS73L2pqN6baiR3yFSvzw7ARPmCG+pq6ZTrY7uZ0kVnQYfv+IlWPbTUDQcGPYU36Z6e
 wGkexazsJH+6lgY2fesi8kiNmuP6+egoPCGNK/QEZ3VzJ08vLWdhVmFjvfcG+glOxxsv
 foL/93g9N8Ys8VYzPuMR2vqJpahJsETNVMBnFZs2HgHFA++C4X7WKgDnsR91HoiG8t7K
 TVlfupOKUbVhWrhcPsb98iJA8j3We2WEzIAY+sJmTCVutS5qq6Ezd7eX1d8WObIXlVvJ
 z/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693324096; x=1693928896;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EXPrfyyr2hdpxW518j3ac03xvpkVdrdr/zM5kAooNmk=;
 b=d/kbQ5Wubt23xDuOA6xiFypSPYSehYeVgwjBGz/nEAbp+ZRvNHujEKEhomxJPi8NV8
 fE9o6mjsk7t4RevCmdbSx9UjiPFQg4F2X7641MnN9+C9SAz9vxouXA1g/l+6ZBig65/a
 XYiNS6IA5F/t028ba/Qy3Y6kSJhe7TVB683wAUXkoOmFRpxthqFWbthi52T3L7InYmht
 zshPPPmuwuYfNKaTGdzHjM9S0OorY27WQQXFcR/yMl873CITbKHaDcExunf5+lKWwK5h
 YqGU45nVrwsJVOjoILWmW0tc+C8Xd6tY/Q+tAOmCnLRuHRQNTT/RtLefPWxBAY9RAXqf
 gSnw==
X-Gm-Message-State: AOJu0YzLypoKMjOFHRfEZPJ4Uay+Myo/qIJEtAwlvpyGF9VFWOz35i0k
 3Qh5ADnehvbGyZmsXaExx/NEcX7IJl9prAqV2qTL7XqIit/f/Exo
X-Google-Smtp-Source: AGHT+IGIQhjBAd7ohyjX/vEuckaNOL3XmJSCGeiCaKld1bON0ZyDM8jrDSIu7YzjowFmMyWBddZaLo1JLzC7PWzMScQ=
X-Received: by 2002:a05:6512:ad3:b0:4f7:6966:36fb with SMTP id
 n19-20020a0565120ad300b004f7696636fbmr23015625lfu.12.1693324096583; Tue, 29
 Aug 2023 08:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230801154451.3505492-1-peter.maydell@linaro.org>
In-Reply-To: <20230801154451.3505492-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 16:48:05 +0100
Message-ID: <CAFEAcA-=HX59+S89oOu1QN_VQwzC2-V5RC=Qmx6wazHDfY9z-A@mail.gmail.com>
Subject: Re: [PATCH] target/m68k: Add URL to semihosting spec
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 1 Aug 2023 at 16:44, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The spec for m68k semihosting is documented in the libgloss
> sources. Add a comment with the URL for it, as we already
> have for nios2 semihosting.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/m68k/m68k-semi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
> index 239f6e44e90..80cd8d70dbb 100644
> --- a/target/m68k/m68k-semi.c
> +++ b/target/m68k/m68k-semi.c
> @@ -15,6 +15,10 @@
>   *
>   *  You should have received a copy of the GNU General Public License
>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + *  The semihosting protocol implemented here is described in the
> + *  libgloss sources:
> + *  https://sourceware.org/git/?p=newlib-cygwin.git;a=blob;f=libgloss/m68k/m68k-semi.txt;hb=HEAD
>   */
>
>  #include "qemu/osdep.h"
> --

Ping for review? I can take this through the arm tree if
you don't have an m68k pullreq planned.

thanks
-- PMM


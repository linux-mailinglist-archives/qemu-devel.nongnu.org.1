Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE90728236
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:06:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GGx-00066V-8e; Thu, 08 Jun 2023 10:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GGv-00066A-3T
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:05:53 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GGn-0007Sh-Kh
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:05:52 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51475e981f0so1124150a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686233138; x=1688825138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dAYS/l2DUM9PlpXuZSAtL8dWzCA7PHmkT0JRclpHbH8=;
 b=wNcJdrY8j922GxPLgXkHtAOWamPqbqZ3XO7lxl4yAk7ZKKR8Zb42zsNI+6kHChm9HI
 MRmZlJMi4bextmsLcxe3PNow6SX1jTKVXHnoWOQP0Rg4pGFf4U+Ov44Fwl6DdxoJvQH3
 442Zs7VXujsGe2HltFbeagqWedpIwcqBEprdua3YHT/UQxdSzwndXcWHzz+70lkNFZlN
 kTdAUjm8Kl8U2e0N9thQrX6DhR+DZ8FM5oFHbwocg/ufIvv2LaHGd5iR5Fvd/FUmtjq6
 oqNUyDfpNcSvI93ZzK1gvzJviWTVdy64PstjNVqBPGXa8XbWGeZkTiPlkd5k34ehA2oe
 crug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686233138; x=1688825138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dAYS/l2DUM9PlpXuZSAtL8dWzCA7PHmkT0JRclpHbH8=;
 b=dm1M9be8gnsNGOSgwAHCDyRfyD5RydZdjhsIdEfS3xS4L5N3g/rFdRuXlYi0uh+Y3G
 /sMadw5/bW/iadu5aflITHZpBLVUygp59uk0FUuZYuqqhY8lYl6WM8RCB1hPnNu9GTQx
 3E6EwwpbwaFIumJYAW/iun9iqL+u9ZzZ1hj9lGcJK/qweE4GEBFBN+74pbk59YNZsBM+
 n1MRVII8oVGSRHlVRY7xkzeSmMiclAya7eKIXJ4JygsdB4MwHB7qB8rKP2CSHyPKoR5O
 u4iNz10homzMSPDcKi+Iqz7Owm9gr2wgAT0rEoFjXJZP+RP5+nmR+PNLJyRi9reOE/Au
 h3cw==
X-Gm-Message-State: AC+VfDyidxSQ4YC2ngI6f+h3OWJxj489PXxuQIlAxdC4dkW4PgFuxhf4
 JYTls/y+vz9LWYCgTASE+eyM3J6pV95lU2FisPTjoA==
X-Google-Smtp-Source: ACHHUZ5/rFEtti9bEZQqrl1c0Fxt1cu/tzZnHVDdJTyQtiZ2KHKyXsRTnhWyfHXqzJVIIUTGFF6gfNw3Cofst9sGIho=
X-Received: by 2002:a05:6402:78b:b0:514:9248:d1dd with SMTP id
 d11-20020a056402078b00b005149248d1ddmr9442719edy.24.1686233137852; Thu, 08
 Jun 2023 07:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230517081204.30333-1-m.elsayed4420@gmail.com>
 <20230517081204.30333-6-m.elsayed4420@gmail.com>
In-Reply-To: <20230517081204.30333-6-m.elsayed4420@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:05:27 +0100
Message-ID: <CAFEAcA9hiOKsQ1DsLNEv6h5AJ9TGtY3S6=o6rJoJTCuiZiwCdQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] tiva c watchdog timers implementation
To: Mohamed ElSayed <m.elsayed4420@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 17 May 2023 at 09:14, Mohamed ElSayed <m.elsayed4420@gmail.com> wrote:
>
> Signed-off-by: Mohamed ElSayed <m.elsayed4420@gmail.com>
> ---
>  hw/watchdog/tm4c123_watchdog.c         | 297 +++++++++++++++++++++++++
>  hw/watchdog/trace-events               |   3 +
>  include/hw/watchdog/tm4c123_watchdog.h |  97 ++++++++
>  3 files changed, 397 insertions(+)
>  create mode 100644 hw/watchdog/tm4c123_watchdog.c
>  create mode 100644 include/hw/watchdog/tm4c123_watchdog.h

This one's just a variant of TYPE_LUMINARY_WATCHDOG,
which you can find in hw/watchdog/cmsdk-apb-watchdog.c.
Probably you only need to add a new variant with
the ID register values different. You want the
"is_luminary == true" behaviour in this variant.

thanks
-- PMM


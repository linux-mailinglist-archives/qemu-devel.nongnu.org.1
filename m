Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A007A477F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBmv-0000U5-I6; Mon, 18 Sep 2023 06:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiBmg-0000HN-8T
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:47:18 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiBme-0006z7-LC
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:47:18 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52683b68c2fso5291706a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695034035; x=1695638835; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hPtlAyriZNtI+mvNE/TyPP28F3dTSqdj4hAm8cN5QVM=;
 b=vLBmk0TJhgEZV+/zpwhkDeALLIcBHhV2yC5SrsZe3zW7ROROMGyAzpUbrkrSO5rZWp
 /tyLL1h7J0ROf2WUNp0OtzySOIS4URa307qm4HtCWqJh6eLtl//s+O8kCIuqX1XSs36u
 5AM0hUoRVzM7dWOCHDqNJmsLIZ9bFhRVVPkLhdGyswpa8Xkuq4oU4i01CO+BzsvEYq6y
 IZd/hbyDbzvLsYkvR/b3ORYDCM9KM778IDHyMTs5yt39JcZ3/NP954YSpYv+DEsPSLj5
 yyMbKIJ+lmerfGAlKNNnxe5pU2YNX6vMAaELuqSmJoZJfTJEG/ETe9FVhn0Fp3O7VM0I
 5q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695034035; x=1695638835;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hPtlAyriZNtI+mvNE/TyPP28F3dTSqdj4hAm8cN5QVM=;
 b=lUZouz7b3ih5FF+yXeuvuLfuKb6Yl0OHBhxxQFCABQgvnpWMmAftcQz4ONP8I1HsgB
 /RBdVvlo1buD7/LxhtS3qUjmp1+ro8W/QyqXdFG8VOPQvIs1tEVcAoi0QwcZyrKie0Ua
 CCHpRJL2hAXE417/WQ8oEmbs2AfT/R+WggS/WbwoBVGVrIJtOE/z2Jo1/QFzgT3/Kz89
 jT41LYqfUaLFjcl/OE+tlHM8Dk7ZpRcrkArKYmHR2AtazRS6NyreK5yWQL619swOvdkW
 jyPm8Gk7yKq6td36fQpBvzbTDGQ/5npWkeMzbxgc8YV6UJe1DbSzabbu0vSmArhdz5Nl
 7EPw==
X-Gm-Message-State: AOJu0YzO/6ZkxpO/yFdjADof7P57sAQkju4PRkfwzXXQbGXlwfVqajkl
 sHRl71DHCWwY+07ToFSD667B2ULQYq+dZUxcumb3BA==
X-Google-Smtp-Source: AGHT+IF/OzmN8KkhFJJ7ZPf3XCwhJ2QjV6zl/3WW+28F53aSxRF0+6vA6D7igb9l2dNxwmds6HJF8Jy/vqbYW2LgRfQ=
X-Received: by 2002:a05:6402:1bc8:b0:530:be79:49e7 with SMTP id
 ch8-20020a0564021bc800b00530be7949e7mr5365181edb.37.1695034035222; Mon, 18
 Sep 2023 03:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230915115535.129834-1-quic_llindhol@quicinc.com>
 <20230915115535.129834-3-quic_llindhol@quicinc.com>
In-Reply-To: <20230915115535.129834-3-quic_llindhol@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2023 11:46:56 +0100
Message-ID: <CAFEAcA-Khp_FGbgVefg-YtOoXGNHXa=--XJmuftJ6QyvQSE99A@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] include/hw/arm: move BSA definitions to bsa.h
To: Leif Lindholm <quic_llindhol@quicinc.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 15 Sept 2023 at 12:55, Leif Lindholm <quic_llindhol@quicinc.com> wrote:
>
> virt.h defines a number of IRQs that are ultimately described by Arm's
> Base System Architecture specification. Move these to a dedicated header
> so that they can be reused by other platforms that do the same.
> Include that header from virt.h to minimise churn.
>
> Signed-off-by: Leif Lindholm <quic_llindhol@quicinc.com>
> ---
>  include/hw/arm/bsa.h  | 35 +++++++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h | 12 +-----------
>  2 files changed, 36 insertions(+), 11 deletions(-)
>  create mode 100644 include/hw/arm/bsa.h
>
> diff --git a/include/hw/arm/bsa.h b/include/hw/arm/bsa.h
> new file mode 100644
> index 0000000000..b7db1cacf1
> --- /dev/null
> +++ b/include/hw/arm/bsa.h
> @@ -0,0 +1,35 @@
> +/*
> + * Common definitions for Arm Base System Architecture (BSA) platforms.
> + *
> + * Copyright (c) 2015 Linaro Limited
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#ifndef QEMU_ARM_BSA_H
> +#define QEMU_ARM_BSA_H
> +
> +#define ARCH_GIC_MAINT_IRQ  25

Given the confusion over indexing that seems to be endemic in the
GIC world, a comment
 /* These are architectural INTID values */

might help.

> +
> +#define ARCH_TIMER_VIRT_IRQ   27
> +#define ARCH_TIMER_S_EL1_IRQ  29
> +#define ARCH_TIMER_NS_EL1_IRQ 30
> +#define ARCH_TIMER_NS_EL2_IRQ 26
> +
> +#define VIRTUAL_PMU_IRQ 23
> +
> +#define PPI(irq) ((irq) - 16)
> +
> +#endif /* QEMU_ARM_BSA_H */

thanks
-- PMM


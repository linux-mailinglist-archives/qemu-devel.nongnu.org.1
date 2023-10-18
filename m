Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFDA7CD948
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:33:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3r7-0000OZ-Iq; Wed, 18 Oct 2023 06:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qt3r6-0000KH-Cb
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:32:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qt3r4-0003m7-CR
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:32:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-407da05f05aso12280195e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 03:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697625163; x=1698229963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zo3lpFdp0DqulFgpfPHMTcecL6u4LZW+6YyxdZGWvE=;
 b=NyFm2q5dx4dePTrRWo+l+xZ1kN/LTu8Q1Ki1GMoCfeQW4cAL2Rrzm9akraNFUJR8ks
 wgBol4LMTPandjaa+yBUXeO9MEwWqpfF9XCPiqsD/Duzd4ku17rSY4c/Fyf07mH14v3r
 ZyYzrPmcHxcCaQ4MgPe6RLLIoJX5t0EE1/pi8wuh+ZT0bfVDOIyTGVvQHPuYTu2CaZVw
 p3bzGjBxmzpiPSiJTDRTbDhkyHkCvbd9Po+0EpiaAm3CLl4VDi1qG/eWLGsyggDQkS/p
 CAd0OwK9FqmZkchDSZ75L/jT+C3M/aPIc6NAYCAPKC9kkV419wwCrsxuB72j62m87Kad
 PkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697625163; x=1698229963;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1zo3lpFdp0DqulFgpfPHMTcecL6u4LZW+6YyxdZGWvE=;
 b=JH8pNQQLqCQtrD9jRGKMcXPIqEQEhF8KOC9Aybx+HBqWB4aSX438nUUZ81LK2EOP+7
 hxTpo46zgWLrToQJm0EdcJNDnPM5PgD5O8Gpq3pKLijfimDa/fjfd6uhP6J/ylJOyQqg
 yGbKVLpjlcrPUVP5FfGxTbnzDapH/bROJQ7BSeSg491RbNT3wzCeHRP2/0xur6mmcA+a
 fRRfC/57p33V0O0xHsHordlhEIMG1iFBtglv2rqpvVBESobbyckwJ92sukDESCvsKbvf
 lQg1KyBZo/hsPKAYD2HSJ7ev53LvXymInSqwekESJSmhfLbWF0fiYgew6C2Fnvyt0pBp
 moWA==
X-Gm-Message-State: AOJu0Yy0YacTehidSPsgmiwiDVV0TMBmnagoJqTHY2XbRRJc7910ed6T
 aas4eAxa/LBMF7QNp+qfhAdnpg==
X-Google-Smtp-Source: AGHT+IFjkqeAEtwx3JX9ZUhB771X/F/qhHHm6VrFxPk7JOaGeaV6VD7rVslqOpXWr7bUj0Mrg79ahg==
X-Received: by 2002:a5d:5652:0:b0:31f:a256:4bbb with SMTP id
 j18-20020a5d5652000000b0031fa2564bbbmr3159810wrw.71.1697625163038; 
 Wed, 18 Oct 2023 03:32:43 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p4-20020adfcc84000000b00327de0173f6sm1805357wrj.115.2023.10.18.03.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 03:32:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 33EA81FFBB;
 Wed, 18 Oct 2023 11:32:42 +0100 (BST)
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
 <2e08cff874b2f9fc4143bdcde87ebba9b70b356c.1697183699.git.manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Eric Auger <eric.auger@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Richard Henderson
 <richard.henderson@linaro.org>, "open list:ARM SMMU"
 <qemu-arm@nongnu.org>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 01/78] include/qemu/compiler.h: replace
 QEMU_FALLTHROUGH with fallthrough
Date: Wed, 18 Oct 2023 11:32:14 +0100
In-reply-to: <2e08cff874b2f9fc4143bdcde87ebba9b70b356c.1697183699.git.manos.pitsidianakis@linaro.org>
Message-ID: <871qdsb4qd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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


Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  audio/pwaudio.c              |  8 ++++----
>  hw/arm/smmuv3.c              |  2 +-
>  include/qemu/compiler.h      | 30 +++++++++++++++++++++++-------
>  include/qemu/osdep.h         |  4 ++--
>  target/loongarch/cpu.c       |  4 ++--
>  target/loongarch/translate.c |  2 +-
>  tcg/optimize.c               |  8 ++++----
>  7 files changed, 37 insertions(+), 21 deletions(-)
>
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index 3ce5f6507b..bf26fadb06 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -1,29 +1,29 @@
>  /*
>   * QEMU PipeWire audio driver
>   *
>   * Copyright (c) 2023 Red Hat Inc.
>   *
>   * Author: Dorinda Bassey       <dbassey@redhat.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>=20=20
> +#include <spa/param/audio/format-utils.h>
> +#include <spa/utils/ringbuffer.h>
> +#include <spa/utils/result.h>
> +#include <spa/param/props.h>
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
>  #include "audio.h"
>  #include <errno.h>
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> -#include <spa/param/audio/format-utils.h>
> -#include <spa/utils/ringbuffer.h>
> -#include <spa/utils/result.h>
> -#include <spa/param/props.h>

Was this an autofmt change sneaking in? osdep.h should always be first
per style.rst.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


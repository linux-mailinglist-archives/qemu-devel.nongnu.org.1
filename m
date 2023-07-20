Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5BB75B20D
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 17:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMVGt-00059K-IB; Thu, 20 Jul 2023 11:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMVGs-00059B-Cn
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:08:50 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMVGq-0004xJ-Rq
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:08:50 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fb863edcb6so1429781e87.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689865726; x=1690470526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3y+BnH+vM1gjHnKvjA93o4R9sO1ZUtI01LCZNEOQm0k=;
 b=Zsnn+i9Gq54X03fvnHM5S5LRFdVC9l4/IYutpmoo/shRhFSJEcEQu9kBQCXC4rfHee
 pIUgHAAD81RLuzstCzIYc3ci38UTaUIncBNg/RK0UzFp/sLRi6WRCcBR5f7KOAj6zXmG
 tlvS8RL8h7BcK+qMXZt2JBrJp++aRoJi4MYThqfutjw48amK/ZJYHakyz0262ldnVvrg
 sF1Vy2hvE294sLFwy0t/l/oUV945+XmnafZdemkWEY4C3CyZd52d614bWv19FuoZz7Hz
 bocoAnQJaodmcKRG6AEjut0L/fnYc4qHSeo9WSo4p0dEY19VuCfHNXgdl7iTYxfhIAxb
 y+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689865726; x=1690470526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3y+BnH+vM1gjHnKvjA93o4R9sO1ZUtI01LCZNEOQm0k=;
 b=SrukVwfZKgfAHg55vuphK5M0t06OhHunfERr/t2QgKTszG0A4Ndsauf5I3QEH1pyLa
 EOLKiJx4zlZkmTN5X5DTMejSr/NP4DciEhQbIQvMNJMEyjbfhaGlKiCF381tuG/bQ+0T
 sxs1yinkhiHfGMG/RTHS05jvrtPyFm8YNULOhIbF9d/Da1/3Suk6zhqT9Ag5FaX/ro79
 MpXlxZyvdDftXU2J9ACe4mOr75De4Wi5oEPsaHkWiycsLuI7GqpPL3s7MWhuA7G+Fj2M
 JH1HD4Bid+lxYax28RNvSD3Uvt1Zhx8wgkktzjZ+hDaRi20iWbssEqy6F6vVD3EPo8/O
 zTog==
X-Gm-Message-State: ABy/qLbaRuOWkUJL0+O/4l4yhfwGV19QyVa308WbLJIhAvd1HCBAH8+E
 sIdZYstBPbMuc26ry8p26XrZveCWnZkWhOvo+Hneaw==
X-Google-Smtp-Source: APBJJlGl24JtxfSB4gEAHsry2JxFj0tFpPyqIOThI94auuFv7aBVdz/aWAtGP5MQ0mKjArfdCIDIHY5gigX823H6ljI=
X-Received: by 2002:a05:6512:78f:b0:4f9:6535:a56 with SMTP id
 x15-20020a056512078f00b004f965350a56mr2324403lfr.26.1689865725684; Thu, 20
 Jul 2023 08:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230606143116.685644-1-pbonzini@redhat.com>
 <20230606143116.685644-15-pbonzini@redhat.com>
In-Reply-To: <20230606143116.685644-15-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 16:08:34 +0100
Message-ID: <CAFEAcA_EVcaawDxqmNUbGqxUdZRo7-Ewm=Qmy67ZNZhUeUwaXw@mail.gmail.com>
Subject: Re: [PULL 14/21] git-submodule: allow partial update of
 .git-submodule-status
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Tue, 6 Jun 2023 at 15:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Allow a specific subdirectory to run git-submodule.sh with only a
> subset of submodules, without removing the others from the
> .git-submodule-status file.
>
> This also allows scripts/git-submodule.sh to be more lenient:
> validating an empty set of submodules is not a mistake.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I've noticed that when doing a build sometimes this
script now produces an error:

make: Entering directory
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang'
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/pc-bios/s390-ccw/../../scripts/g=
it-submodule.sh:
106: read: arg count
[1/154] Generating qemu-version.h with a custom command (wrapped by
meson to capture output)
[etc]


> -    $GIT submodule status $modules > "${substat}"
> -    test $? -ne 0 && update_error "failed to save git submodule status" =
>&2
> +    (while read -r; do

This is because "read" without a variable name argument is
a non-POSIX extension. I think the fix to this is to say
"read -r REPLY" rather than omitting the variable name and
assuming it will default to REPLY.

> +        for module in $modules; do
> +            case $REPLY in
> +                *" $module "*) continue 2 ;;
> +            esac
> +        done
> +        printf '%s\n' "$REPLY"
> +    done

I'll send a patch shortly.

thanks
-- PMM


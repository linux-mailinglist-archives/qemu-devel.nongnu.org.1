Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED957D2F9D
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 12:23:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qus4m-0001qO-Ib; Mon, 23 Oct 2023 06:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qus4k-0001pp-7s
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:22:22 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qus4g-0006gp-Vf
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:22:20 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507bd19eac8so4525264e87.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 03:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698056537; x=1698661337; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akSx94y29wJ1BBmll8Y5u7TkxESKwKfaGVRLD7rBkcs=;
 b=mE7Q835yWeAIeK3jO2MIIW36Ck3xxM1FmGDXtCMJRVIPtaXgKHfBopUUKyV/Lm+1gz
 zZJDf6rV0UX+qfjDsn0JsSEbjyuMSWwqRv9H03+ziY6CfVVhehcWAzpPcUIujPRKGcZi
 DfeQ6RBMMPluOmev48n9LidFIXo33ZS1fD2fP3TiWcVNlDh1g0BFRtmphbzsTKn8XDUe
 xVJZilGFOPjp9u+salqsFK8aYzxtypIm8TeAb95Y76dprOIVqclPzcP8ft0oq+LAOBZW
 +3wkxEqCZMJdwqfzj3oF+o7WZdYi7/cX7vcRq6CAkZqTdI+6J23ySF8B9VoPbBpEcPcu
 6AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698056537; x=1698661337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=akSx94y29wJ1BBmll8Y5u7TkxESKwKfaGVRLD7rBkcs=;
 b=mo7WDNL0TTUZGBBzxl6g5CA56CdrHz0jGgoDAoo7NGMRBsJbKpJBGnJd6Jqe8cs1xJ
 ps3znXu6J5W5IEHIDlVcjptYFb78YeiiUsMT/wPNq32HlpobsKhUNnSaKVU0DP30AK6m
 +MFT33x//4gn/orHb55kVwKjb0GhH61eSFI21ccRKDOCr2kyFWyRciBLXkVDG4di0neF
 1CTUtW8+72HBgB+i/lPdYRctj6tJGK35/jvnm1a9EtWayUYfbS4T/fmiYsNsKYr2/Ya9
 vDxmwf11ObsOC+rTgyckJ63sYuqPptPiqh2fyKrTYok8wGLXaWHM1AjGPcNNPHbj6Oxg
 4ZGg==
X-Gm-Message-State: AOJu0Yx7iLtiNTUDDqRUK0A1B+lUkmU7QPZvRBjdYFogMBviH8L5U1E1
 X7un7gEJXVuPmUUoG+jnnM1wGR3AX6IKhcPOS4pJMw==
X-Google-Smtp-Source: AGHT+IEGLJYNEeLG8veZiujgOlXgghnHt/Jqe+RAmmpj//wibCiq9pwtu5cLjb8/GEptDsI/g7Mn3BWhjyJvJtUgqHI=
X-Received: by 2002:a05:6512:3c9f:b0:507:96e7:c08d with SMTP id
 h31-20020a0565123c9f00b0050796e7c08dmr3585632lfv.61.1698056537025; Mon, 23
 Oct 2023 03:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231023024059.3858349-1-gaosong@loongson.cn>
 <b0e7be32-ab05-a39c-f722-44b2eaac8318@loongson.cn>
In-Reply-To: <b0e7be32-ab05-a39c-f722-44b2eaac8318@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Oct 2023 11:22:06 +0100
Message-ID: <CAFEAcA8UEC1XSsjuSbwDmiUs03VVK=wTY0PHSte-4f1=hk3EgA@mail.gmail.com>
Subject: Re: [PATCH] target/loongarch: Support 4K page size
To: maobibo <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org, 
 richard.henderson@linaro.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

On Mon, 23 Oct 2023 at 05:06, maobibo <maobibo@loongson.cn> wrote:
>
>
>
> =E5=9C=A8 2023/10/23 =E4=B8=8A=E5=8D=8810:40, Song Gao =E5=86=99=E9=81=93=
:
> > The LoongArch kernel supports 4K page size.
> > Change TARGET_PAGE_BITS to 12.
> >
> > Signed-off-by: Song Gao <gaosong@loongson.cn>
> > ---
> >   target/loongarch/cpu-param.h  | 2 +-
> >   target/loongarch/tlb_helper.c | 9 ++++-----
> >   2 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.=
h
> > index 1265dc7cb5..cfe195db4e 100644
> > --- a/target/loongarch/cpu-param.h
> > +++ b/target/loongarch/cpu-param.h
> > @@ -12,6 +12,6 @@
> >   #define TARGET_PHYS_ADDR_SPACE_BITS 48
> >   #define TARGET_VIRT_ADDR_SPACE_BITS 48
> >
> > -#define TARGET_PAGE_BITS 14
> > +#define TARGET_PAGE_BITS 12
> Hi Gaosong,
>
> The popular OS about LoongArch still uses 16K page size, qemu should
> follow the rule of OS rather than defining 4K page size alone.

The TARGET_PAGE_BITS value in QEMU is a property of the hardware,
not the guest OS. It should specify the smallest page size the
guest can configure the CPU to use. If the guest asks for a
larger page size than the minimum then that works fine. See
for example PPC64 -- on this architecture both 4K and 64K
pages are possible, so we define TARGET_PAGE_BITS to 12,
even though a lot of Linux guests use 64K pages.

It is slightly less efficient when the guest uses a page size
larger than the TARGET_PAGE_BITS value indicates, so if you
have an architecture where some CPUs support small pages
but most do not, you can do what Arm does, and use the
TARGET_PAGE_BITS_VARY support. This makes the TARGET_PAGE_BITS
macro be a runtime-configurable value, where a machine model can
set the mc->minimum_page_bits value to indicate that that
machine doesn't need the small-pages handling.

thanks
-- PMM


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9542673A337
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 16:39:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCLSa-00077G-M7; Thu, 22 Jun 2023 10:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCLSY-000770-7V
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:38:54 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCLST-0008FV-If
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:38:51 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-51a3e6a952aso8499389a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687444727; x=1690036727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9+Jg4Mj9r44eZP00JG28ERv0XqIg8oi8kMLW0LY80I=;
 b=rdy9Vk+R4bSGpeMQhhQ7D/I85uOp9iAgRIa5kkWk5mJuGLNYj2b/XXN0W4IJajA4q0
 ZnbeAVqwNhiun6g6LGb79zjM+f8FgOHjDcFFhbNCcnGbhNW8XMGQ/sXbyh7zmxPwp8DE
 3inxz2fQsXTUl3kRZhpQ9x90yOEUS0SeDNBxpjS21nTNnKj4X2gDkcikqbI9F020KZkX
 0PemXmcudI3aouYSc4IDgRH6HiMlK+f00qO0lOjVOAzdEM2ZpQvic5MyeE96NL6rlM6L
 wTfSj8ZaAlL0w/WtZTomcbLLjAi+e0dGhI47LS8Ukshra01b8427UmPZDQ9iD4KYnLZA
 4u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687444727; x=1690036727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9+Jg4Mj9r44eZP00JG28ERv0XqIg8oi8kMLW0LY80I=;
 b=PaQ8uHjiwybOgL5253ceLNlDX2ul5XQs0JETQTD0c48yWXZDl8gqyWl2B7kQBKiiWZ
 Plk2g5Hd4U/TEfFPq+cpHLSojx/pA8dzW2DbUtaJQpYEHpNdogYgRQy6TeGtHFX6XIOu
 pP+lcg4O2JlUpnqgw1CATMEesAdRmIjsVOFBa795MEBlkl9VWgeiBQ1+sxWvJzOiU2C6
 hPqqzJIFq3Cip1Y4auNf7954GxUs3gI1lQzl/sYa2KLCS4Z5gG15hhqt818nkOY33/s7
 0CIzLdek5UZwFNYKpMw00R4nycEeaivUjU5wP1VL4G/BacD5QrXymz1MVB9GF3Y+xt0M
 eJcA==
X-Gm-Message-State: AC+VfDxAj7yL75RSDg1E0g82CqIdQqN27eXREIv1+os0cREhwJ711qmC
 QN/fWaPMfCV5INA8Z6Aiy5zpQR9HiA0hMuWrvb+AWQ==
X-Google-Smtp-Source: ACHHUZ42TNm/j4dbG2MXDMAHFUAe5An8IvxtyGHkC2qVtMcCVFGgO1oj87b/Sz+hWdgEHeXK6itcbI7vNKoTZhtWTjc=
X-Received: by 2002:aa7:db8d:0:b0:515:3103:631e with SMTP id
 u13-20020aa7db8d000000b005153103631emr11746704edt.25.1687444727512; Thu, 22
 Jun 2023 07:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230622130823.1631719-1-peter.maydell@linaro.org>
 <ZJRcEUPZy2ntkjJN@redhat.com>
In-Reply-To: <ZJRcEUPZy2ntkjJN@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2023 15:38:36 +0100
Message-ID: <CAFEAcA-fVLqPBtOW1sGsHkymURp84rDWX934p4icZScQxm=sUw@mail.gmail.com>
Subject: Re: [PATCH] host-utils: Avoid using __builtin_subcll on buggy
 versions of Apple Clang
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 22 Jun 2023 at 15:35, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Jun 22, 2023 at 02:08:23PM +0100, Peter Maydell wrote:
> > We use __builtin_subcll() to do a 64-bit subtract with borrow-in and
> > borrow-out when the host compiler supports it.  Unfortunately some
> > versions of Apple Clang have a bug in their implementation of this
> > intrinsic which means it returns the wrong value.  The effect is that
> > a QEMU built with the affected compiler will hang when emulating x86
> > float80 division.
> >
> > The upstream LLVM issue is:
> > https://github.com/llvm/llvm-project/issues/55253
> >
> > The commit that introduced the bug apparently never made it into an
> > upstream LLVM release without the subsequent fix
> > https://github.com/llvm/llvm-project/commit/fffb6e6afdbaba563189c1f7150=
58ed401fbc88d
> > but unfortunately it did make it into Apple Clang 14.0, as shipped
> > in Xcode 14.3 (14.2 is reported to be OK). The Apple bug number is
> > FB12210478.
> >
> > Add ifdefs to avoid use of __builtin_subcll() on Apple Clang version
> > 14 or greater.  There is not currently a version of Apple Clang which
> > has the bug fix -- when one appears we should be able to add an upper
> > bound to the ifdef condition so we can start using the builtin again.
> > We make the lower bound a conservative "any Apple clang with major
> > version 14 or greater" because the consequences of incorrectly
> > disabling the builtin when it would work are pretty small and the
> > consequences of not disabling it when we should are pretty bad.
> >
> > Many thanks to those users who both reported this bug and also
> > did a lot of work in identifying the root cause; in particular
> > to Daniel Bertalan and osy.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1631
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1659
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I don't have a setup to test this, so this needs testing by the
> > people who've encountered this compiler bug to confirm it does
> > the right thing...
> > ---
> >  include/qemu/compiler.h   | 13 +++++++++++++
> >  include/qemu/host-utils.h |  2 +-
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> > index c2f49df1f91..a309f90c768 100644
> > --- a/include/qemu/compiler.h
> > +++ b/include/qemu/compiler.h
> > @@ -184,4 +184,17 @@
> >  #define QEMU_DISABLE_CFI
> >  #endif
> >
> > +/*
> > + * Apple clang version 14 has a bug in its __builtin_subcll(); define
> > + * BUILTIN_SUBCLL_BROKEN for the offending versions so we can avoid it=
.
> > + * When a version of Apple clang which has this bug fixed is released
> > + * we can add an upper bound to this check.
> > + * See https://gitlab.com/qemu-project/qemu/-/issues/1631
> > + * and https://gitlab.com/qemu-project/qemu/-/issues/1659 for details.
> > + * The bug never made it into any upstream LLVM releases, only Apple o=
nes.
>
> Perhaps add a reminder:
>
>  * TODO: put a max cap on __clang_major__/__clang_minor once
>  * Apple have released a version with the fix

That was what I intended the "When..." sentence to be. We
can add "TODO:" on the front to make it stand out a bit more I guess.

-- PMM


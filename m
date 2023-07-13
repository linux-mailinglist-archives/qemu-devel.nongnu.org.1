Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A3D752319
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 15:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJw60-0006yZ-4g; Thu, 13 Jul 2023 09:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJw5y-0006yO-2R
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:10:58 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJw5v-00038x-LF
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:10:57 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fbaef9871cso1276267e87.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689253853; x=1691845853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WXWw9+OYttF2TGJ7jaopdPVSSnj5tNLLiv5f1yjXifo=;
 b=HJV81sejuw+UrUOc5B9e/OSEJgJ545IUlmAxteBSpKkWIdTknPSH/j6zjRfXbyfqk2
 SvFjrRuFAsYdbKqswx5KOwSQK9jnY/ExLgwHX30OoYKZLIjzE9cQ/oRmGdNePkgrftSp
 r7HWGM8wlFZDBbqXBdR9XOOP6hX0Aa5gRU/C4ElXmG+zqAvY4dNxQ0WASTKSxMVcPYVV
 BkUe7YkBBoQtVrh8SbMr+AoMJthjAPOpM7Kn7Mgt+o5CzyUsTj4109XuBX6uGReH7WAA
 qmqrB/RAcC4YXgmckyfj2tZbJaB/XAYAkwT9wDHWiahA5w9yu+B4FAzPvKbW3DYaXkTW
 eJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689253853; x=1691845853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WXWw9+OYttF2TGJ7jaopdPVSSnj5tNLLiv5f1yjXifo=;
 b=ZG9R7IncPQvPk/uIG5CBd/r+yj4ZV8mUy2d7hXzneMssyOx7CetrU1OmIW4//STxnY
 DVZGuPdjD/r3LzDCAjZsexWhe9V/oOCTRQtEMOOWUfHhSy6vZu2GsVP+Eyric1L6WQ7Y
 uwoAT1Mvr58d83QeEcW727WIrJKXvqKWh7EPcFCTuMw/xVzbuXIiV9ygToSQyA5l7/Na
 i3WLydB7MTs+OcAbiI3NbhpGw8u3obchZeZSvsFB8VLGdMj/oSG85Xg1re0mTcvMwLOt
 NHfKukyDi/tn+F8cykrAo3VleKNMnbNFBAHKAY8PvAQKinhXS7Lce+BdLd5irqMLRn1M
 RXbA==
X-Gm-Message-State: ABy/qLb73Ke2qmct0HgAVusbx1rz29mZxm9ez6XFQJP+iMP8lq/kkwx9
 /o7Pgb59u+AGp6jlzlsL15E/U0Rry1MnWpo8dmKrDdLArvQ36LAC
X-Google-Smtp-Source: APBJJlF6A9wcJJTLA7S20uIcVy/TfX73ELjyb7dAFppdpSXYkTFrY5oAwy9PI+iTi2lvJy2nzz0tzYryTqqvUl3w+rQ=
X-Received: by 2002:a05:6512:31c9:b0:4f9:5933:8eea with SMTP id
 j9-20020a05651231c900b004f959338eeamr1509971lfe.3.1689253853583; Thu, 13 Jul
 2023 06:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230623144410.1837261-1-peter.maydell@linaro.org>
 <CAFEAcA_mezDNCR0JwsURzZ1gSeAk64H81CVOzWPyur94uEFfKg@mail.gmail.com>
In-Reply-To: <CAFEAcA_mezDNCR0JwsURzZ1gSeAk64H81CVOzWPyur94uEFfKg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2023 14:10:42 +0100
Message-ID: <CAFEAcA8TfpdQgE5c2F5xvGaEqa_xKN1L7dNRxPHrRP8aPNK49w@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Remove pointless NULL check in clock_adjtime
 handling
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

I'll take this via target-arm.next unless there are any
objections...

thanks
-- PMM

On Tue, 4 Jul 2023 at 14:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Laurent, ping? This patch has been reviewed.
>
> thanks
> -- PMM
>
> On Fri, 23 Jun 2023 at 15:44, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > In the code for TARGET_NR_clock_adjtime, we set the pointer phtx to
> > the address of the local variable htx.  This means it can never be
> > NULL, but later in the code we check it for NULL anyway.  Coverity
> > complains about this (CID 1507683) because the NULL check comes after
> > a call to clock_adjtime() that assumes it is non-NULL.
> >
> > Since phtx is always &htx, and is used only in three places, it's not
> > really necessary.  Remove it, bringing the code structure in to line
> > with that for TARGET_NR_clock_adjtime64, which already uses a simple
> > '&htx' when it wants a pointer to 'htx'.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  linux-user/syscall.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index f2cb101d83c..7b2f9f7340e 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -10935,16 +10935,14 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
> >  #if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
> >      case TARGET_NR_clock_adjtime:
> >          {
> > -            struct timex htx, *phtx = &htx;
> > +            struct timex htx;
> >
> > -            if (target_to_host_timex(phtx, arg2) != 0) {
> > +            if (target_to_host_timex(&htx, arg2) != 0) {
> >                  return -TARGET_EFAULT;
> >              }
> > -            ret = get_errno(clock_adjtime(arg1, phtx));
> > -            if (!is_error(ret) && phtx) {
> > -                if (host_to_target_timex(arg2, phtx) != 0) {
> > -                    return -TARGET_EFAULT;
> > -                }
> > +            ret = get_errno(clock_adjtime(arg1, &htx));
> > +            if (!is_error(ret) && host_to_target_timex(arg2, &htx)) {
> > +                return -TARGET_EFAULT;
> >              }
> >          }
> >          return ret;
> > --


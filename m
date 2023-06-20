Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A92A2737135
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:12:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdwP-0004T2-0K; Tue, 20 Jun 2023 12:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBdwM-0004SY-6p
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:10:46 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBdwJ-0001wi-U8
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:10:45 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b45bc83f26so67391051fa.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687277440; x=1689869440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEBN3GeZ0q/lnRHGNlqQesmmMSmKZ/lR81pA/GvGWic=;
 b=jZwueKXO9X/qi99I8NhgWJ6QrUe8NpIbrvDRuUnWatQ7aCkMe28IiajYHKT0pwjiut
 OHAeWVV03bAuWAUEiq6NOGDAINa5XOisa8xGncuZehRtFpu9OGFLOAoragkvaSJc96um
 XQhZxZWVEZhoY8P52l+rSRPyvvYVhR8gN3RrldU5wdplmv0zQNCEEI9i8StRGgDenFA9
 9Hlme5HE6LSfJJZlVeH0vHcI0WonLwpFftb0sN7XpZHcJCS3cIe2R1i5Ooh+wXALOwbQ
 vJIOHHke1bc9m9JFg3IZerEl5EAmP2SKn+MYscM5gOywnHf4bERXzOPyvgukYutU9cvv
 34BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687277440; x=1689869440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEBN3GeZ0q/lnRHGNlqQesmmMSmKZ/lR81pA/GvGWic=;
 b=WXXBoA/2tHdgAKPzq70yuKRGtAFWGG4RnRZ5FNbqn14sFYiaecGMUzeGaWV/rsW2al
 KLbr78KZoSEWxRAgDYifUHJVdXhBbmNNPojt9nh2f3PJHaI5hw72tBxsp8cNmHmwruKR
 QUpuNphKBfE8vZ2rSqgNbcKEjzk32AeBWZprMifmbYJCX1zxFdLj1cIiscAsfaGYQzhC
 1C3tsIpLyMro1PGbzd1UeH1f02C3WHt2gQT6LlgxSfbiKNUaNOY5+R0unZXMAUr3YviQ
 +/Z7f3xA9fXyQR5EUcs4qEJR4nwn2HAjD2hCQxga/ChrWagq4QRKjsPd14kNQsYYzvSd
 0V/w==
X-Gm-Message-State: AC+VfDxKxhsL1OM4CuyD/Vqtq3tQCCu3JQ2QT+rAqTAuOfLiYy7j6baG
 6VPcTU76Qte3y8qV7LREVrfbKU8JSsaSnAtG+OqYPA==
X-Google-Smtp-Source: ACHHUZ7RAcmNlB6CM+oE3zNob6asFCPxK805CwMhSkUjkogqDHIYIVw4xkkqs0XKshpNFro9XshSQk8ilfZiG0xjaZk=
X-Received: by 2002:a2e:8696:0:b0:2b5:68ad:291b with SMTP id
 l22-20020a2e8696000000b002b568ad291bmr1759179lji.39.1687277439830; Tue, 20
 Jun 2023 09:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230620150335.814005-1-alex.bennee@linaro.org>
 <CAFEAcA9jWuxVVb-+rbv4dEF+0_P1+5z7Z6HQajGv5Jg3yje11g@mail.gmail.com>
 <87bkhai1p4.fsf@linaro.org> <bcafa996-128a-d25c-f35a-115b26498710@linaro.org>
In-Reply-To: <bcafa996-128a-d25c-f35a-115b26498710@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 17:10:29 +0100
Message-ID: <CAFEAcA_ViU=Wcwhzj7fsiBP0YHcKEdyuBJ3F0QZh5LxDU8qiLw@mail.gmail.com>
Subject: Re: [RFC PATCH] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Tue, 20 Jun 2023 at 16:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/20/23 17:37, Alex Benn=C3=A9e wrote:
> > ar maybe? it only got flagged in clang-system once fedora was updated (=
I
> > assume with better sanitizers):
> >
> >    [2773/3696] Generating pc-bios/keymaps/ar with a custom command
> >    FAILED: pc-bios/keymaps/ar
> >    /builds/stsquad/qemu/build/qemu-keymap -f pc-bios/keymaps/ar -l ar
> >    ../qemu-keymap.c:223:16: runtime error: shift exponent 4294967295 is=
 too large for 32-bit type 'int'
> >    SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../qemu-keym=
ap.c:223:16 in
> >    [2774/3696] Generating pc-bios/edk2-x86_64-code.fd with a custom com=
mand (wrapped by meson to capture output)
> >    [2775/3696] Generating pc-bios/edk2-x86_64-secure-code.fd with a cus=
tom command (wrapped by meson to capture output)
> >    ninja: build stopped: subcommand failed.
> >    make: *** [Makefile:153: run-ninja] Error 1
> >
> > https://gitlab.com/stsquad/qemu/-/jobs/4500683186#L3957
>
> Related:
>
> https://gitlab.com/qemu-project/qemu/-/issues/1709
> https://gitlab.com/qemu-project/qemu/-/issues/1712
>
> which note that keymaps/ar has changed to keymaps/ara in xkeyboard-config=
 from 2.38 to 2.39.

On Ubuntu I have xkb-data 2.33.1, but that already has
/usr/share/X11/xkb/symbols/ara, not ar.   Asking qemu-keymap
for either 'ar' or 'ara' works. So this is not so much
that the filename has changed in 2.39, but merely that
xkb has stopped accepting a legacy compatibility synonym.
The upstream change is:
https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/commit/4=
70ad2cd8fea84d7210377161d86b31999bb5ea6

So the easy fix I think is to change the line in
pc-bios/keymaps/meson.build from
  'ar': '-l ar',
to
  'ar': '-l ara',

As the commit message notes, 'ara' has been the standard
xkb name upstream for over 15 years, so this won't break
our build on older versions of the xkb data.

(In theory we could also rename the pcbios keymap name,
but that seems like unnecessary effort.)

thanks
-- PMM


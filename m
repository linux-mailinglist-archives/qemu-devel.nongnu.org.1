Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E09E77370BD
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:42:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdV3-0003mb-7F; Tue, 20 Jun 2023 11:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBdV0-0003lp-Lc
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:42:30 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBdUz-0000vq-1r
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:42:30 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51a5eec783cso2634501a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687275747; x=1689867747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmrAoAB4n/tfOJYsQ/EGv+AVvfLm9Pd6EHKnP88m7nw=;
 b=NfTGVKGfPBCRcY3O4GQzDd/FKjok/R2nvGaJYIwgvaXtxBVdF+R6+bhJrDxToy8YES
 b7PBpfSrpgG2G+sICbX+XhRkkuutLLnCXs5mniz+7S8qQfJvSUzIMxf4z/asJAbZhACe
 MnZRFfY1JkNqYAkGYSiC7GXRs3+Je5xALsWJHzF/8MujWNPekfdvcJMoiDK5z65Tol7H
 a7vSPf/UaSKr7JuLYUFLK2dhX2BBdnKsk7J2Ze224h0W4jYRaTI0T8YTOBZ62vGupqzH
 QsPOIIplKSsXVVy7QXyZHQAdLWfC3ibyKH7vJoe1D5xsTQYU5l8vVstF8Atq5JHP+qoE
 OrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687275747; x=1689867747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmrAoAB4n/tfOJYsQ/EGv+AVvfLm9Pd6EHKnP88m7nw=;
 b=ktR3IKUPwLmqdzm0hNDdALJEuROidQIRLXUVhzuil+Pw9cjSpW5SljP8qlpFf+dnXi
 VfLD5kq0byUjekvkFV3w7u9kgcUCfzrAa64fYAMSMJgiOHEELLiPTMpFkhzYDvW8ecSC
 TQ6MFT4X27aoHD9Ybv5/g/dDCBae6NlFNNFhqPDIRCbVyi1EVZ8dXXFY/TwxyAlw+rlo
 vro04kRwSdfhaaq6MMRA2fETQwgLlzihghdEoMfUqeZVSPpwTVFwtrcTB4/Wfh33e0Ti
 Ia5fIDtWAvbT+rAEMPNChwzR9YL13TFXNuJ585SdPLnzkjY1OzpgisubZEXRoNGdMqls
 6IoQ==
X-Gm-Message-State: AC+VfDzU0SbjuO+CU44heFXpOEFmQRA+ykQenYAZ7jNSVD/7hLMlOS2j
 7mL1PO7SzQICpKnQpb8/bwe/ekh4OFaLCQhAqisxdTqgKHyM6QYk
X-Google-Smtp-Source: ACHHUZ51VvV+apGGEZVF/xB1O100QR1VNvgRCJ48VdvarKW6rWHl4AA0qX002EX2hEHmAi979nIp167krMOqm7ulyAA=
X-Received: by 2002:a05:6402:1159:b0:516:a09c:cb42 with SMTP id
 g25-20020a056402115900b00516a09ccb42mr8488485edw.4.1687275747320; Tue, 20 Jun
 2023 08:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230620150335.814005-1-alex.bennee@linaro.org>
 <CAFEAcA9jWuxVVb-+rbv4dEF+0_P1+5z7Z6HQajGv5Jg3yje11g@mail.gmail.com>
 <87bkhai1p4.fsf@linaro.org>
In-Reply-To: <87bkhai1p4.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 16:42:16 +0100
Message-ID: <CAFEAcA_qEcj0m2T5PCJXVkxRaD1CZkb7iueWHTnKknKm8FGTWw@mail.gmail.com>
Subject: Re: [RFC PATCH] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 20 Jun 2023 at 16:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 20 Jun 2023 at 16:04, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >> We can return XKB_MOD_INVALID which rightly gets flagged by sanitisers
> >> as an overly wide shift attempt.
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>  qemu-keymap.c | 24 ++++++++++++++++--------
> >>  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > Looking at the code that works with the mask values
> > we are getting here, I think this ought to work
> > (if there's no AltGr modifier then the 0 mask means
> > the key state will be the same in normal and with the
> > altgr mask supplied, which we already check for).
> > Did you eyeball the output, though?
> >
> > Also, which keymap runs into this? Is it every keymap
> > for some new version of the xkb data (which would imply
> > that the problem is that the AltGr modifier has changed
> > name), or is it only one specific keymap that happens
> > to have no AltGr key?
>
> ar maybe? it only got flagged in clang-system once fedora was updated (I
> assume with better sanitizers):
>
>   [2773/3696] Generating pc-bios/keymaps/ar with a custom command
>   FAILED: pc-bios/keymaps/ar
>   /builds/stsquad/qemu/build/qemu-keymap -f pc-bios/keymaps/ar -l ar
>   ../qemu-keymap.c:223:16: runtime error: shift exponent 4294967295 is to=
o large for 32-bit type 'int'
>   SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../qemu-keymap.=
c:223:16 in
>   [2774/3696] Generating pc-bios/edk2-x86_64-code.fd with a custom comman=
d (wrapped by meson to capture output)
>   [2775/3696] Generating pc-bios/edk2-x86_64-secure-code.fd with a custom=
 command (wrapped by meson to capture output)
>   ninja: build stopped: subcommand failed.
>   make: *** [Makefile:153: run-ninja] Error 1

OK; how does the output look from the new qemu-keymap on
that system ?

thanks
-- PMM


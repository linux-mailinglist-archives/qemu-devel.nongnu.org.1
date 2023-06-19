Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC26F735D17
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 19:37:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBIn3-0006pa-8h; Mon, 19 Jun 2023 13:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBIn1-0006pQ-30
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:35:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBImz-00078p-8R
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:35:42 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f9002a1a39so22199675e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 10:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687196139; x=1689788139;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zEzts6RXKAJ46k9Q5CwNMEezTjRsjw1Gsy5X2hQs7I=;
 b=eXHVvNRG9K6tZAcSPXEUNaj/KDYrhNBRBcQ7FKk1BpESGepl/EE+o6LcaQYJNr2tBU
 7z2omfRbUrmFe1coMKA8VKSjdAtjjEy+AMVEPgRYAz/33Ly3tpjlQnOjzhSnuuz/a5yL
 S1oQlZUP+OtP9GX0yft1RcMTca1NVvZC8Wh/HRhRwjTwzFyf/REofzqPcmyfyhVI/slF
 64354JMiI1gKKBwP7rJGmO37rJRzE/Zqo+JXOaKu1oibr7caud0WOPdpBfvU6nJu/EQh
 RgQoBuFZE7/bLSaWFLtmnLpYrINc8ADnngEl3uitWOqZnqqPby7oG2X/CFm3dQpvJhX/
 tYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687196139; x=1689788139;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9zEzts6RXKAJ46k9Q5CwNMEezTjRsjw1Gsy5X2hQs7I=;
 b=Y65bA7EEaCXR4ocuSGoKcQRUaL+hpmd4S4dIwwOQfmjQX3Ez3FWUA7f7/HmA5Sulzh
 yM178oIcAd9udSnfZGUcqlbQ6y1UotnwTbXPO/s4WCg7BG4fV9MhK9TwJa4SJ7A2hHrP
 QSt2hhliqjVm5dTmk6Jcdx96nUydTjHoM/3W4T7asbT6dq1Kz+CJICT9mQoy65hg4M3g
 BLFtdJrh8rHEUEcolxpcNHqXCMjK44TyU/Ae/Rk3R9lhp/UD5y6HJ1li3KYr3+jt2nGM
 0wHHd3P78Elk4L1FlIbyj4HaiVpZeFdA/UOas+vrd/eLnMnBtA4fyWEcqbLZu6fJRkFz
 EdCA==
X-Gm-Message-State: AC+VfDxYSMmg1nYQEorlffWCOnRxa8znn05cB7uU4a4BtjpltJBCKYj6
 klY9CaTvEX5ugeYKRfgaes9aOl7jHxRv7Onw1ls=
X-Google-Smtp-Source: ACHHUZ4CU5A1wD++zjJYoFgJOf81s4q4+/AY9rMU89eyWnGykejMHNR3mLifT5WVuaSdHmTnnFb0Xg==
X-Received: by 2002:a5d:6ad1:0:b0:311:18ce:152b with SMTP id
 u17-20020a5d6ad1000000b0031118ce152bmr6269936wrw.61.1687196139305; 
 Mon, 19 Jun 2023 10:35:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a5d5651000000b003093a412310sm60683wrw.92.2023.06.19.10.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 10:35:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 442331FFBB;
 Mon, 19 Jun 2023 18:35:38 +0100 (BST)
References: <20230610171959.928544-1-richard.henderson@linaro.org>
 <87ttvee4tf.fsf@linaro.org>
 <ba4c99fc-7b3d-3969-260c-96c7c244cc46@linaro.org>
 <1199d248-8aee-4e93-95cd-ad8847ed2255@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/plugin: Remove duplicate insn log from libinsn.so
Date: Mon, 19 Jun 2023 18:34:03 +0100
In-reply-to: <1199d248-8aee-4e93-95cd-ad8847ed2255@linaro.org>
Message-ID: <87mt0vjqxi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/12/23 04:50, Richard Henderson wrote:
>> On 6/11/23 02:14, Alex Benn=C3=A9e wrote:
>>>
>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>
>>>> This is a perfectly natural occurrence for x86 "rep movb",
>>>> where the "rep" prefix forms a counted loop of the one insn.
>>>>
>>>> During the tests/tcg/multiarch/memory test, this logging is
>>>> triggered over 350000 times.=C2=A0 Within the context of cross-i386-tci
>>>> build, which is already slow by nature, the logging is sufficient
>>>> to push the test into timeout.
>>>
>>> How does this get triggered because I added these:
>>>
>>> # non-inline runs will trigger the duplicate instruction heuristics in =
libinsn.so
>>> run-plugin-%-with-libinsn.so:
>>> =C2=A0=C2=A0=C2=A0=C2=A0$(call run-test, $@, \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(QEMU) -monitor none -display none \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -chardev file$(C=
OMMA)path=3D$@.out$(COMMA)id=3Doutput \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -plugin ../../plugin/libinsn.so$(CO=
MMA)inline=3Don \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 -d plugin -D $*-with-libinsn.so.pout \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(QEMU_OPTS) $*)
>>>
>>> to prevent the callback versions from being called for x86. The original
>>> intent of the check was to detect failures due to cpu_io_recompile, see
>>> e025d799af (tests/plugin: expand insn test to detect duplicate instruct=
ions)
>> I have no idea how, but it's happening.
>>=20
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>> Irritatingly, it doesn't timeout locally, so I used staging to double-=
check:
>>>>
>>>> Fail: https://gitlab.com/qemu-project/qemu/-/jobs/4450754282#L5062
>>>> Pass: https://gitlab.com/qemu-project/qemu/-/jobs/4450927108
>> Note that in the pass case, we don't even log that the test ran.
>
> Any further thoughts on this?  Otherwise I'll merge it to get rid of
> the cross-i386-tci failure...
>
>
> r~

I'm happy to drop the feature from the plugin but the clean-up also
needs to be applied to the run-plugin-%-with-libinsn.so: rules for i386
and x86_64.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4BC738765
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBz47-0007DR-4s; Wed, 21 Jun 2023 10:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBz45-0007D8-HL
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:44:09 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBz43-0000Of-OH
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:44:09 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f865f0e16cso6292780e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687358646; x=1689950646;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fn8u6+hRXpZJ6WlfId+TlzLTyJ6CKlCGV6oiDhwZgmA=;
 b=M+HDkt2FvGL+2gZ7NSaHsjsuThYydyKpFijyF06PowY73qSKN/wEVqpxMacY4wY59C
 DKNcDI7wY3D7CsIvrhe85H+njRrZbUSI/w7kyVo7ACVB744DYo+iTHDmO8piBmRA3JqF
 Gh/W0nSGFQyb6eywoRulKQ7xFnoopONAWHoMINnfNdIXxY/R9fb4IJ+zuMlTMdkKRS3t
 +U31QIB2ngyKtvF+RVCDK2I2s2z/YEL5l/fr34spKs43kVWsH7DX74FuOPDFgELmuuJC
 I2eHSLTGS2gLmNu+mrRAnT7+CV0A+Bty42EdTog68apmqRxc2Skm0zfjhbIurjdhw8qb
 6rIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687358646; x=1689950646;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fn8u6+hRXpZJ6WlfId+TlzLTyJ6CKlCGV6oiDhwZgmA=;
 b=VnD9KEhxK7JwU8KEOkR4lKiVhH9npBD7oWQkqj7A0U53ThpWjl9nnjRD3Jo+oKcUtS
 dzE+fYLKkqgGki8jufrRJU2EOHKtknzhcrrtvU3d61Yj892WgpiAyCNB8f4fUAKgg0UJ
 IeETJOMmtKZZi/qLRz9fnEPiFrGke8NsvfnkgOI0AWWLrX2jXp2Fij36eNs5TvXx+sa4
 qs8j2TgSdcRTgYAU67mukTs3JZNG6wPPjWOviY0cn5H0u83SfY1zH6By/6PT3KFNM0fG
 ydlLI5k6TPAa8Gc3y75TW3uMpIxRPlecvzvzobmcx81wDKcQ5CbD8n1dWQmd3ZZCgUJu
 CSUw==
X-Gm-Message-State: AC+VfDwQBFt/hzhj+ZbAQ+kksikuwCFt7PDqSDKgk05LiWxt73Sw5LcP
 3ZjpCA/oYzIyfWzMwGJ8ntPQhA==
X-Google-Smtp-Source: ACHHUZ58MRPR4UjuK87KcxAGt2dOapeov7E4OFlJyzUTRI/ga/ciAxjyLxIiQrPpW6CklkNOluLFtg==
X-Received: by 2002:a19:5619:0:b0:4f8:6d53:a68f with SMTP id
 k25-20020a195619000000b004f86d53a68fmr5604983lfb.64.1687358645405; 
 Wed, 21 Jun 2023 07:44:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a7bc050000000b003f080b2f9f4sm16285328wmc.27.2023.06.21.07.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 07:44:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5F16C1FFBB;
 Wed, 21 Jun 2023 15:44:04 +0100 (BST)
References: <20230606132743.1386003-1-iii@linux.ibm.com>
 <20230606132743.1386003-9-iii@linux.ibm.com> <87legdglka.fsf@linaro.org>
 <4cf02e6ef71c6f2bff38f06b433e99526ee244d4.camel@linux.ibm.com>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH v3 8/8] tests/tcg: Add a test for info proc mappings
Date: Wed, 21 Jun 2023 15:43:49 +0100
In-reply-to: <4cf02e6ef71c6f2bff38f06b433e99526ee244d4.camel@linux.ibm.com>
Message-ID: <87h6r0ho3w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x130.google.com
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


Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On Wed, 2023-06-21 at 11:21 +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>>=20
>> > Add a small test to prevent regressions.
>> > Since there are issues with how GDB interprets QEMU's target.xml,
>> > enable the test only on aarch64 and s390x for now.
>> >=20
>> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> > ---
>> > =C2=A0tests/tcg/aarch64/Makefile.target=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-
>> > =C2=A0tests/tcg/multiarch/Makefile.target=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++
>> > =C2=A0.../multiarch/gdbstub/test-proc-mappings.py=C2=A0=C2=A0 | 55
>> > +++++++++++++++++++
>> > =C2=A0tests/tcg/s390x/Makefile.target=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> > =C2=A04 files changed, 65 insertions(+), 2 deletions(-)
>> > =C2=A0create mode 100644 tests/tcg/multiarch/gdbstub/test-proc-
>> > mappings.py
>> >=20
>> > diff --git a/tests/tcg/aarch64/Makefile.target
>> > b/tests/tcg/aarch64/Makefile.target
>> > index 03157954871..38402b0ba1f 100644
>> > --- a/tests/tcg/aarch64/Makefile.target
>> > +++ b/tests/tcg/aarch64/Makefile.target
>> > @@ -97,7 +97,8 @@ run-gdbstub-sve-ioctls: sve-ioctls
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-
>> > ioctl.py, \
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0basic gdbstub SVE ZLEN=
 support)
>> > =C2=A0
>> > -EXTRA_RUNS +=3D run-gdbstub-sysregs run-gdbstub-sve-ioctls
>> > +EXTRA_RUNS +=3D run-gdbstub-sysregs run-gdbstub-sve-ioctls \
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 run-gdbstub-proc-mappings
>> > =C2=A0endif
>> > =C2=A0endif
>> > =C2=A0
>> > diff --git a/tests/tcg/multiarch/Makefile.target
>> > b/tests/tcg/multiarch/Makefile.target
>> > index 373db696481..cbc0b75787a 100644
>> > --- a/tests/tcg/multiarch/Makefile.target
>> > +++ b/tests/tcg/multiarch/Makefile.target
>> > @@ -81,6 +81,13 @@ run-gdbstub-qxfer-auxv-read: sha1
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-
>> > qxfer-auxv-read.py, \
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0basic gdbstub qXfer:au=
xv:read support)
>> > =C2=A0
>> > +run-gdbstub-proc-mappings: sha1
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(call run-test, $@, $(GDB_=
SCRIPT) \
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0--gdb $(HAVE_GDB_BIN) \
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-proc-
>> > mappings.py, \
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0proc mappings support)
>> > +
>>=20
>> I wondered if it makes more sense to keep the extra test
>> configuration
>> logic in multiarch:
>>=20
>> =C2=A0 run-gdbstub-proc-mappings: sha1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call run-test, =
$@, $(GDB_SCRIPT) \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --gdb $(HAVE_GDB_BIN) \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --bin $< --test $(MULTIARCH_SRC)/gdbstub/tes=
t-proc-
>> mappings.py, \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proc mappings sup=
port)
>>=20
>> =C2=A0 # only enable for s390x and aarch64 for now
>> =C2=A0 ifneq (,$(findstring aarch64,$(TARGET_NAME)))
>> =C2=A0 EXTRA_RUNS +=3D run-gdbstub-proc-mappings
>> =C2=A0 else ifneq (,$(findstring s390x,$(TARGET_NAME)))
>> =C2=A0 EXTRA_RUNS +=3D run-gdbstub-proc-mappings
>> =C2=A0 endif
>>=20
>> but it still ends up pretty ugly. Is the gdb handling fixed for other
>> arches in other versions. Maybe we could probe gdb for support and
>> wrap
>> the whole stanza in something like:
>>=20
>> =C2=A0 ifeq ($(HOST_GDB_SUPPORTS_PROC_MAPPING),y)
>> =C2=A0 ...
>> =C2=A0 endif
>>=20
>> ?
>
> I think I better add the check to the test itself, because otherwise we
> have to probe GDB against QEMU binary we just built, which sounds
> unnecessarily complicated.
>
> The error message on all arches without this series is:
>
>     warning: unable to open /proc file '/proc/1/maps'
>
> The error message on x86_64 (expected) with this series is:
>
>    Not supported on this target.
>
> So we can simply exit(0) from the test if we see this.

That seems a simpler solution, lets do that.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


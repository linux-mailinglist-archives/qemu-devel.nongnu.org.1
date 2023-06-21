Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C83F3737F88
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:24:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBv0r-0003iZ-DG; Wed, 21 Jun 2023 06:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBv0l-0003iN-UF
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:24:27 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBv0i-0002Gv-VY
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:24:27 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-311099fac92so6679255f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687343062; x=1689935062;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvv0KpU0PteJwRe0zO2obGwXcl2e/ZvVOopeU67U2gk=;
 b=TXcAl0Ec9DGWi3ohdpmgQ+7uZMwimRO/vOaQBkYZKp65ye9DJoW6MWmuKxwQobapRm
 z6Cw+yynJV8VmLGHcErPnoC/R5Uy57gbbiIyARZ6ZUdLMrI1+XjmIAn2JjvpY6RpkXx1
 fkVWwd2lo4bQJPRdpnMjlxe6YyIMvqI52Pa/ZSSeWuJdZPPTHLtqW9V9eIYqiU8uCyzV
 dNuE01Q2CfQlMybKcB56LmSar8doFt+AsUIuO8ucPBywzS71zpUTVI4HQ9mqHxHGiQIy
 2EtwVBJXqw4F7W5N0p4kghDsXGONJ1Ul2qzmySs7Z1c0+PKyJF4SlxwiWvu+GqXxkUdp
 yb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687343062; x=1689935062;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gvv0KpU0PteJwRe0zO2obGwXcl2e/ZvVOopeU67U2gk=;
 b=Ne5BgueOPAVj6PXqor5MMgWII23pXKcIvk6A4LveIN+ERekuD8YR67Ar/Um5TDmMUZ
 Lt773rzz7okCBxRHxjGXM6frLQfQsac8kvxyxgGh0qKxLzVr79c7G9WPpZFN3Q/tXeqi
 vdMrc2Do1BXufOcW4fJrEMQEUpzv7E/dvVDei4C2lsN/DNODA92PaQkc+y8wq8Jn5Csw
 t71A0RhQYfh8pT80dkxutTf2wjZR/LTM+48tIqnmGpWK/xHJWpbKZu+yEfeylE7Gzsjq
 Wwc3G7sH5AsfRFeKUfjSiNUNr5uTbSbTBCK0F5Dj65+RFuHQuSLe2TuqYv/vGCJew/oc
 i5zA==
X-Gm-Message-State: AC+VfDxomt9vkyyC3JWbzYShU2DdElLo/HLBBsWVLuQFN6MuPqN7I+0J
 gg+HjYLJkv9A3kNsT9/0ldngfw==
X-Google-Smtp-Source: ACHHUZ7Zb4AzwvNWg8G9A6ZX4yKuiMxLPqbC+BRVXgsIXxjvZa70TIIgYEtQD2Ml0pV7dughxsRoXg==
X-Received: by 2002:adf:e708:0:b0:311:91c:ddfc with SMTP id
 c8-20020adfe708000000b00311091cddfcmr13533481wrm.10.1687343062156; 
 Wed, 21 Jun 2023 03:24:22 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a5d69ca000000b003047ea78b42sm4065316wrw.43.2023.06.21.03.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 03:24:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5102C1FFBB;
 Wed, 21 Jun 2023 11:24:21 +0100 (BST)
References: <20230606132743.1386003-1-iii@linux.ibm.com>
 <20230606132743.1386003-9-iii@linux.ibm.com>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH v3 8/8] tests/tcg: Add a test for info proc mappings
Date: Wed, 21 Jun 2023 11:21:54 +0100
In-reply-to: <20230606132743.1386003-9-iii@linux.ibm.com>
Message-ID: <87legdglka.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> Add a small test to prevent regressions.
> Since there are issues with how GDB interprets QEMU's target.xml,
> enable the test only on aarch64 and s390x for now.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tests/tcg/aarch64/Makefile.target             |  3 +-
>  tests/tcg/multiarch/Makefile.target           |  7 +++
>  .../multiarch/gdbstub/test-proc-mappings.py   | 55 +++++++++++++++++++
>  tests/tcg/s390x/Makefile.target               |  2 +-
>  4 files changed, 65 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/multiarch/gdbstub/test-proc-mappings.py
>
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index 03157954871..38402b0ba1f 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -97,7 +97,8 @@ run-gdbstub-sve-ioctls: sve-ioctls
>  		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
>  	basic gdbstub SVE ZLEN support)
>=20=20
> -EXTRA_RUNS +=3D run-gdbstub-sysregs run-gdbstub-sve-ioctls
> +EXTRA_RUNS +=3D run-gdbstub-sysregs run-gdbstub-sve-ioctls \
> +              run-gdbstub-proc-mappings
>  endif
>  endif
>=20=20
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Ma=
kefile.target
> index 373db696481..cbc0b75787a 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -81,6 +81,13 @@ run-gdbstub-qxfer-auxv-read: sha1
>  		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-qxfer-auxv-read.py, \
>  	basic gdbstub qXfer:auxv:read support)
>=20=20
> +run-gdbstub-proc-mappings: sha1
> +	$(call run-test, $@, $(GDB_SCRIPT) \
> +		--gdb $(HAVE_GDB_BIN) \
> +		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> +		--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-proc-mappings.py, \
> +	proc mappings support)
> +

I wondered if it makes more sense to keep the extra test configuration
logic in multiarch:

  run-gdbstub-proc-mappings: sha1
          $(call run-test, $@, $(GDB_SCRIPT) \
                  --gdb $(HAVE_GDB_BIN) \
                  --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
                  --bin $< --test $(MULTIARCH_SRC)/gdbstub/test-proc-mappin=
gs.py, \
          proc mappings support)

  # only enable for s390x and aarch64 for now
  ifneq (,$(findstring aarch64,$(TARGET_NAME)))
  EXTRA_RUNS +=3D run-gdbstub-proc-mappings
  else ifneq (,$(findstring s390x,$(TARGET_NAME)))
  EXTRA_RUNS +=3D run-gdbstub-proc-mappings
  endif

but it still ends up pretty ugly. Is the gdb handling fixed for other
arches in other versions. Maybe we could probe gdb for support and wrap
the whole stanza in something like:

  ifeq ($(HOST_GDB_SUPPORTS_PROC_MAPPING),y)
  ...
  endif

?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


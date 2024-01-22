Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784C88368B2
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:44:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwT1-0008Es-2M; Mon, 22 Jan 2024 10:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRwSu-0008DN-EK
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:44:01 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRwSr-0000qf-RZ
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:44:00 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e7065b7bdso39941885e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 07:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705938236; x=1706543036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyCLA8F3Q1HSjzUvwdWJqvmfNabu26vDd2qBZaQgaVc=;
 b=g+FDQOoqZo1uXEq5VKyoZtAhTovo9Xajj4OElBriurQ50D0/r298j7shyK4gFMhc3P
 TD2Ln44fOMzw+4EQUrBEpQFypUMqcJG9H6SaKXVmdHRa7Wcg7Lki3f8eJBJ7jPn1z9j1
 hF+fxX2LD0ZCmQ3iLhoRKmIKSjb6l4V6w/+KOPjKN51ZOULgbTn/Ql4ylYyUSZ2BfujJ
 QbLVE8GK/PPoyFaZLQtKiN6go+3HE5/DITi1dwfsmH09uE+MKM867kHEMYW4J8btq3e5
 UZjYtU/Hi84Oe9mcI8X1pPjN++LYalYKrKB/nf+pDtm8OQq7V/pdPNyVlfn1NhaS38k8
 wcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705938236; x=1706543036;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IyCLA8F3Q1HSjzUvwdWJqvmfNabu26vDd2qBZaQgaVc=;
 b=Cm5kXiMPY3cPPp8QY9o+o5BvKkJXshiI5kkzid4aaSm6uJs10qNP59Yjd5+fFJWxTf
 87ve7xpgwg2zM9bfOweALBh7q2H5oY7GJn+99E7D7xp1a5XBYBDrIZRQzhJOYPSByAuO
 nfmsL8IA6wBYKehlwJFHiS2Rj/HPzrp4vcO2VfkRqVqN1zowfxxe25DRNwcdYNwE9l/P
 366hM6cppu6dZEp2meWSjHt55BT4In/mWijfjSXyBLgXU9qnLyupyY8/AePbTfUW1VE2
 dm1OD316pgDLbXLoTBuNHt8dXbMVkF8pg+N4BujWzJ4zDi57EHSvwVeXLLGZ/NPGufGB
 mH8Q==
X-Gm-Message-State: AOJu0YzjxL3AiE7BBPjBFj+5j+0agbygXGHduADfTRzJwtS2oH1GmJ3W
 PQKVIrIzXAw/ZwOcwYKuNdFwwXYOzdXJI/5f5ILs+Ndre77zd+IEgrHp1eyv0vk=
X-Google-Smtp-Source: AGHT+IFjBG+3wtpU1689XSpwJm//t3uejj9WMEUWN5GwfTLb5El/AWmIlTVYWxl5a0vT78v2jEXTqQ==
X-Received: by 2002:a05:600c:35d6:b0:40e:70f5:a986 with SMTP id
 r22-20020a05600c35d600b0040e70f5a986mr1701122wmq.54.1705938236020; 
 Mon, 22 Jan 2024 07:43:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bh11-20020a05600c3d0b00b0040eabc7cfacsm5209276wmb.16.2024.01.22.07.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 07:43:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 502AC5F7AE;
 Mon, 22 Jan 2024 15:43:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  David Hildenbrand <david@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH v3 3/3] tests/tcg: Add the PROT_NONE gdbstub test
In-Reply-To: <20240116003551.75168-4-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Tue, 16 Jan 2024 01:31:42 +0100")
References: <20240116003551.75168-1-iii@linux.ibm.com>
 <20240116003551.75168-4-iii@linux.ibm.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 22 Jan 2024 15:43:55 +0000
Message-ID: <877ck1nzk4.fsf@draig.linaro.org>
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

> Make sure that qemu gdbstub, like gdbserver, allows reading from and
> writing to PROT_NONE pages.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Hmm I'm seeing the test hang and drop to the interactive python shell:

    TEST    basic gdbstub support on aarch64
  Failed to read a valid object file image from memory.
  qemu-aarch64: QEMU: Terminated via GDBstub
    TEST    basic gdbstub qXfer:auxv:read support on aarch64
  Failed to read a valid object file image from memory.
  qemu-aarch64: QEMU: Terminated via GDBstub
    TEST    proc mappings support on aarch64
  Failed to read a valid object file image from memory.
  qemu-aarch64: QEMU: Terminated via GDBstub
    TEST    hitting a breakpoint on non-main thread on aarch64
  Failed to read a valid object file image from memory.
  qemu-aarch64: QEMU: Terminated via GDBstub
    TEST    checking register enumeration on aarch64
  Failed to read a valid object file image from memory.
  qemu-aarch64: QEMU: Terminated via GDBstub
    TEST    accessing PROT_NONE memory on aarch64
  Failed to read a valid object file image from memory.
  Python 3.11.2 (main, Mar 13 2023, 12:18:29) [GCC 12.2.0] on linux
  Type "help", "copyright", "credits" or "license" for more information.
  (InteractiveConsole)

> ---
>  tests/tcg/multiarch/Makefile.target      |  9 +++++-
>  tests/tcg/multiarch/gdbstub/prot-none.py | 22 +++++++++++++
>  tests/tcg/multiarch/prot-none.c          | 40 ++++++++++++++++++++++++
>  3 files changed, 70 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/multiarch/gdbstub/prot-none.py
>  create mode 100644 tests/tcg/multiarch/prot-none.c
>
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Ma=
kefile.target
> index d31ba8d6ae4..315a2e13588 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -101,13 +101,20 @@ run-gdbstub-registers: sha512
>  		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
>  	checking register enumeration)
>=20=20
> +run-gdbstub-prot-none: prot-none
> +	$(call run-test, $@, env PROT_NONE_PY=3D1 $(GDB_SCRIPT) \
> +		--gdb $(GDB) \
> +		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> +		--bin $< --test $(MULTIARCH_SRC)/gdbstub/prot-none.py, \
> +	accessing PROT_NONE memory)
> +
>  else
>  run-gdbstub-%:
>  	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst =
-%,,$(TARGET_NAME)) support")
>  endif
>  EXTRA_RUNS +=3D run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
>  	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
> -	      run-gdbstub-registers
> +	      run-gdbstub-registers run-gdbstub-prot-none
>=20=20
>  # ARM Compatible Semi Hosting Tests
>  #
> diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiar=
ch/gdbstub/prot-none.py
> new file mode 100644
> index 00000000000..f1f1dd82cbe
> --- /dev/null
> +++ b/tests/tcg/multiarch/gdbstub/prot-none.py
> @@ -0,0 +1,22 @@
> +"""Test that GDB can access PROT_NONE pages.
> +
> +This runs as a sourced script (via -x, via run-test.py).
> +
> +SPDX-License-Identifier: GPL-2.0-or-later
> +"""
> +from test_gdbstub import main, report
> +
> +
> +def run_test():
> +    """Run through the tests one by one"""
> +    gdb.Breakpoint("break_here")
> +    gdb.execute("continue")
> +    val =3D gdb.parse_and_eval("*(char[2] *)q").string()
> +    report(val =3D=3D "42", "{} =3D=3D 42".format(val))
> +    gdb.execute("set *(char[3] *)q =3D \"24\"")
> +    gdb.execute("continue")
> +    exitcode =3D int(gdb.parse_and_eval("$_exitcode"))
> +    report(exitcode =3D=3D 0, "{} =3D=3D 0".format(exitcode))
> +
> +
> +main(run_test)
> diff --git a/tests/tcg/multiarch/prot-none.c b/tests/tcg/multiarch/prot-n=
one.c
> new file mode 100644
> index 00000000000..dc56aadb3c5
> --- /dev/null
> +++ b/tests/tcg/multiarch/prot-none.c
> @@ -0,0 +1,40 @@
> +/*
> + * Test that GDB can access PROT_NONE pages.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <assert.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +void break_here(void *q)
> +{
> +}
> +
> +int main(void)
> +{
> +    long pagesize =3D sysconf(_SC_PAGESIZE);
> +    void *p, *q;
> +    int err;
> +
> +    p =3D mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
> +             MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    assert(p !=3D MAP_FAILED);
> +    q =3D p + pagesize - 1;
> +    strcpy(q, "42");
> +
> +    err =3D mprotect(p, pagesize * 2, PROT_NONE);
> +    assert(err =3D=3D 0);
> +
> +    break_here(q);
> +
> +    err =3D mprotect(p, pagesize * 2, PROT_READ);
> +    assert(err =3D=3D 0);
> +    if (getenv("PROT_NONE_PY")) {
> +        assert(strcmp(q, "24") =3D=3D 0);
> +    }
> +
> +    return EXIT_SUCCESS;
> +}

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA08836936
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:56:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwdD-0003lr-GJ; Mon, 22 Jan 2024 10:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRwdA-0003if-Kj
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:54:36 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rRwd8-0002ms-TO
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:54:36 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-337d05b8942so3828367f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 07:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705938873; x=1706543673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PS+IvZYXeAwJ+6xyPpwBHOW9gWzIRzYYVS99BfSjRBY=;
 b=USxOcaorKhikimXJlkaUW3uSArO7KqdNOHqw0YCC9aBUCLpx/Y3FvgtmLhGHoxPmxl
 fuCD0bu7bX1RyPdO/FRhbcQ3XM6/6gJ3kRErIPR5gFKoM54Z5Z5q5M6snd+6/nvVDjfZ
 UuvGFzCZUq6x2M/LK0UEzVptAuRcg76kbh5FP1UapJeMhLa4h9GDWhlklv3LWpBOl0c4
 clpzsZ/4wl8x0tRsNlJFd4BfLZB7AtUQbIEkhTI40ghSta2Gwx6RZ6LocoNoMCPzexRG
 +cSdD4RRiR+IuWFyF78DK3+MNUJYCXp1lk2u7J3yXPCpjDvPMeANW28MoIZuw9cUV61n
 iQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705938873; x=1706543673;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PS+IvZYXeAwJ+6xyPpwBHOW9gWzIRzYYVS99BfSjRBY=;
 b=WLswOud9LTws+9zUFOsPm7rmDMb9zGFOvRogGTZo0U9bFOp4JdgtIN9abtW2Mmcl/p
 2m7b4y0L0tRNlnC/FijhZxE216LnbEUbSf0Rlwyo8v9VaxrPoqfEAQ9YC41fj0X4uCWo
 8MZU/XlDIuPQcL3pnMyQU8mMXMvapXi1qjW1Ug9XpIbK1YYCleKNAR7m8PqAMyd7ZOEx
 czwrhycnV428+GWMqqwVCXD0ataJzZrJEFVl1eGbBjN+Y/o17ZVkQXazL8gJfrj49M+V
 muBnyy3ZZHrW31cPXyudU1UdsweAVvLLIoD7AC0HOiuphNYltCSDiYx4SVnJ3o0r5WIg
 FW4Q==
X-Gm-Message-State: AOJu0Yz16upFlcObjxg+wtOaPslLYtzzJMiW9Rpxbv2ctchAnxbZuF6q
 MV1G6jLOUlG7E5ODvs5068kGJQUXI7KNF3IbJ2IoLfz4CthpRMr95e2xzvAiiUM=
X-Google-Smtp-Source: AGHT+IHNKqTo+QPajHBnTCQcGWZ0FMwzDJ5qplenU9+eZ1NI2YT8rax3miWd76Ona2iwoJHwP3VuTg==
X-Received: by 2002:a5d:5191:0:b0:336:7d6e:d969 with SMTP id
 k17-20020a5d5191000000b003367d6ed969mr2663803wrv.99.1705938873228; 
 Mon, 22 Jan 2024 07:54:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b17-20020a5d4d91000000b0033935b0a0fdsm3534040wru.44.2024.01.22.07.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 07:54:32 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7F1B25F794;
 Mon, 22 Jan 2024 15:54:32 +0000 (GMT)
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
Date: Mon, 22 Jan 2024 15:54:32 +0000
Message-ID: <871qa9nz2f.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Better traceback:

  Breakpoint 1, break_here (q=3D0x400000802fff) at /home/alex/lsrc/qemu.git=
/tests/tcg/multiarch/prot-none.c:14
  14      }
  GDB Exception:
  Traceback (most recent call last):
    File "/home/alex/lsrc/qemu.git/tests/guest-debug/test_gdbstub.py", line=
 42, in main
      test()
    File "./tests/tcg/multiarch/gdbstub/prot-none.py", line 14, in run_test
      val =3D gdb.parse_and_eval("*(char[2] *)q").string()
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  gdb.MemoryError: Cannot access memory at address 0x400000802fff
  Python 3.11.2 (main, Mar 13 2023, 12:18:29) [GCC 12.2.0] on linux
  Type "help", "copyright", "credits" or "license" for more information.
  (InteractiveConsole)
  >>>=20

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


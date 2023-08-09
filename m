Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FCA776633
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 19:15:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTmle-0001fD-Q8; Wed, 09 Aug 2023 13:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTmlc-0001ec-Cd
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:14:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTmla-0007Uk-4b
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:14:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe24dd8898so60216155e9.2
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 10:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691601276; x=1692206076;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLTSHmkk8mI4muL/EClFJdtEMC9or9lBxn+7FGEh0eg=;
 b=QkueFzXkMLrQWevb7SBWS8DSN2nGzOmqmrLfUfhf0Y1x2b+2m+oiPueJ64Pjbt1XNk
 eJuqP70eStIfQ4SHS7kYNXarWfD0FLdzHMiYbFFlWtthXLwStxQjfduj31Q7bpLoDv+6
 uQKlYI1WF6EmAO3jvbbbR3jTl43W0vs2ir2h5ftjHeeVMv30ThRmzBBCLRJ45sXyiCF2
 RuAdEka0JDV5lLeYGOsHwCeuWod8nJNC1wBhVmehoFIV35Qdo3J6xvQUndsjSIZ84n/+
 u3TI/F4Gfo6twNy1WIbexjQqzQ8zpj7L+eAWlHcOo4uvevdT76R8FvmA6iYPzPzp4ogn
 2CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691601276; x=1692206076;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DLTSHmkk8mI4muL/EClFJdtEMC9or9lBxn+7FGEh0eg=;
 b=ZhdSyZLGxC5XzGL1/qczAtVquUg5K+6TZOJxD9wblA03fTDbFKD1abM0ezg4VcEliX
 Lem/yuhnNLY00BtsPb6o0XHIWrQPms5x3NWqhvnMv2CKi+Ygaqs8iUDwVEdP8rsnWkcR
 7YRaB2yOasQKOIu1VIZrfTXBMz0cqVeQ+pNYvqhVlOedDsEvbzoS81zeyh26usp1cz0+
 Qpm6m5WER16v8mx3Vot3cnRWC9J1bmq9MwqrTJBOuNXrZS5AzQPQ2A5WzDxhf3vxMnSs
 SonLpR0FnRgZaWKMM6vlGtkWfWzzkqqrrhAqJMZzKFj+8O2Pyt1GoPLoB4jh7B08fH4T
 aPbg==
X-Gm-Message-State: AOJu0Yznn/MkJGWtF/Cg1BLcRiDymPawbgaz134zxifaWpRjMw2vfLqk
 BORmOUAY7o4k1iImZXJhZ7xRog==
X-Google-Smtp-Source: AGHT+IGpLWe8B5aFwToZ+zTKXMRA8DO53BcnbxMtr7voQ6yzhnI1AXyeK9ITNhhzkfVnhE/SCydp9A==
X-Received: by 2002:a05:600c:3792:b0:3fb:c9f4:150e with SMTP id
 o18-20020a05600c379200b003fbc9f4150emr2699335wmr.14.1691601276500; 
 Wed, 09 Aug 2023 10:14:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x26-20020a1c7c1a000000b003fe24da493dsm2511057wmc.41.2023.08.09.10.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 10:14:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B55731FFBB;
 Wed,  9 Aug 2023 18:14:35 +0100 (BST)
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-11-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org
Subject: Re: [RFC v4 10/11] tests/tcg/multiarch: Add nativecall.c test
Date: Wed, 09 Aug 2023 18:01:40 +0100
In-reply-to: <20230808141739.3110740-11-fufuyqqqqqq@gmail.com>
Message-ID: <87zg302l50.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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


Yeqi Fu <fufuyqqqqqq@gmail.com> writes:

> Introduce a new test for native calls to ensure their functionality.
> The process involves cross-compiling the test cases, building them
> as dynamically linked binaries, and running these binaries which
> necessitates the addition of the appropriate interpreter prefix.
>
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  tests/tcg/multiarch/Makefile.target     | 17 +++++
>  tests/tcg/multiarch/native/nativecall.c | 98
> +++++++++++++++++++++++++

Another thing I missed is putting the test in a subdir misses out the
common logic:

  # Set search path for all sources
  VPATH 	       +=3D $(MULTIARCH_SRC)
  MULTIARCH_SRCS =3D  $(notdir $(wildcard $(MULTIARCH_SRC)/*.c))
  ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
  VPATH 	       +=3D $(MULTIARCH_SRC)/linux
  MULTIARCH_SRCS +=3D $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))
  endif
  MULTIARCH_TESTS =3D $(MULTIARCH_SRCS:.c=3D)

which as a result means things like:

  make build-tcg

don't automatically build the tests (although it does get picked up at
runtime).

You can either move it out of the subdir or do something similar that
the arm-compat-semi does, expand VPATH and use TESTS:

modified   tests/tcg/multiarch/Makefile.target
@@ -138,13 +138,18 @@ run-plugin-semiconsole-with-%:
 TESTS +=3D semihosting semiconsole
 endif
=20
-nativecall: native/nativecall.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(filter-out -static,$(LDFLAGS))
-
 ifneq ($(LD_PREFIX),)
 ifneq ($(wildcard $(LIBNATIVE)),)
+VPATH +=3D $(MULTIARCH_SRC)/native
+
+nativecall: nativecall.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(filter-out -static,$(LDFLAGS))
+
 run-nativecall: nativecall
-	$(call run-test,$<, $(QEMU) -L $(LD_PREFIX) --native-bypass $(LIBNATIVE) =
$<, "nativecall")
+	$(call run-test,$<, $(QEMU) -L $(LD_PREFIX) --native-bypass
+	$(LIBNATIVE) $<, "nativecall")
+
+TESTS +=3D nativecall
 else
 run-nativecall: nativecall
 	$(call skip-test, $<, "no native library found")
@@ -153,7 +158,6 @@ else
 run-nativecall: nativecall
 	$(call skip-test, $<, "no elf interpreter prefix found")
 endif
-EXTRA_RUNS +=3D run-nativecall


>  2 files changed, 115 insertions(+)
>  create mode 100644 tests/tcg/multiarch/native/nativecall.c
>
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Ma=
kefile.target
> index 43bddeaf21..5231df34ba 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -138,5 +138,22 @@ run-plugin-semiconsole-with-%:
>  TESTS +=3D semihosting semiconsole
>  endif
>=20=20
> +nativecall: native/nativecall.c
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(filter-out -static,$(LDFLAGS=
))
> +
> +ifneq ($(LD_PREFIX),)
> +ifneq ($(wildcard $(LIBNATIVE)),)
> +run-nativecall: nativecall
> +	$(call run-test,$<, $(QEMU) -L $(LD_PREFIX) --native-bypass $(LIBNATIVE=
) $<, "nativecall")
> +else
> +run-nativecall: nativecall
> +	$(call skip-test, $<, "no native library found")
> +endif
> +else
> +run-nativecall: nativecall
> +	$(call skip-test, $<, "no elf interpreter prefix found")
> +endif
> +EXTRA_RUNS +=3D run-nativecall
> +
>  # Update TESTS
>  TESTS +=3D $(MULTIARCH_TESTS)
> diff --git a/tests/tcg/multiarch/native/nativecall.c b/tests/tcg/multiarc=
h/native/nativecall.c
> new file mode 100644
> index 0000000000..d3f6f49ed0
> --- /dev/null
> +++ b/tests/tcg/multiarch/native/nativecall.c
> @@ -0,0 +1,98 @@
> +#include <assert.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +
> +void compare_memory(const void *a, const void *b, size_t n)
> +{
> +    const unsigned char *p1 =3D a;
> +    const unsigned char *p2 =3D b;
> +    for (size_t i =3D 0; i < n; i++) {
> +        assert(p1[i] =3D=3D p2[i]);
> +    }
> +}
> +
> +void test_memcpy()
> +{
> +    char src[] =3D "Hello, world!";
> +    char dest[20];
> +    memcpy(dest, src, 13);
> +    compare_memory(dest, src, 13);
> +}
> +
> +void test_strncpy()
> +{
> +    char src[] =3D "Hello, world!";
> +    char dest[20];
> +    strncpy(dest, src, 13);
> +    compare_memory(dest, src, 13);
> +}
> +
> +void test_strcpy()
> +{
> +    char src[] =3D "Hello, world!";
> +    char dest[20];
> +    strcpy(dest, src);
> +    compare_memory(dest, src, 13);
> +}
> +
> +void test_strcat()
> +{
> +    char src[20] =3D "Hello, ";
> +    char dst[] =3D "world!";
> +    char str[] =3D "Hello, world!";
> +    strcat(src, dest);
> +    compare_memory(src, str, 13);
> +}
> +
> +void test_memcmp()
> +{
> +    char str1[] =3D "abc";
> +    char str2[] =3D "abc";
> +    char str3[] =3D "def";
> +    assert(memcmp(str1, str2, 3) =3D=3D 0);
> +    assert(memcmp(str1, str3, 3) !=3D 0);
> +}
> +
> +void test_strncmp()
> +{
> +    char str1[] =3D "abc";
> +    char str2[] =3D "abc";
> +    char str3[] =3D "def";
> +    assert(strncmp(str1, str2, 2) =3D=3D 0);
> +    assert(strncmp(str1, str3, 2) !=3D 0);
> +}
> +
> +void test_strcmp()
> +{
> +    char str1[] =3D "abc";
> +    char str2[] =3D "abc";
> +    char str3[] =3D "def";
> +    assert(strcmp(str1, str2) =3D=3D 0);
> +    assert(strcmp(str1, str3) !=3D 0);
> +}
> +
> +void test_memset()
> +{
> +    char buffer[10];
> +    memset(buffer, 'A', 10);
> +    int i;
> +    for (i =3D 0; i < 10; i++) {
> +        assert(buffer[i] =3D=3D 'A');
> +    }
> +}
> +
> +int main()
> +{
> +    test_memset();
> +    test_memcpy();
> +    test_strncpy();
> +    test_memcmp();
> +    test_strncmp();
> +    test_strcpy();
> +    test_strcmp();
> +    test_strcat();
> +
> +    return EXIT_SUCCESS;
> +}


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


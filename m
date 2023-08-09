Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B11E7755DF
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 10:49:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTerj-0005sv-Cr; Wed, 09 Aug 2023 04:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTerh-0005sn-Nm
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:48:25 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTerf-0004WE-CM
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:48:25 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3177f520802so361865f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 01:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691570901; x=1692175701;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaMVbz0i3Y+YYXzxpJmTX31eDy2xFYpEI9ahnCQfS8w=;
 b=a5Jaq5/KUvzir7FpRDPeM3dQZAex+B1ac/QU+6AgQy48pAVvtE4AxAoHU8gmnE09Lz
 Ks7401EsUHH6gBWDoA4fnRoltrmRWy3IYKMYldC0J8saXzc9eZUyX+xoPau94ny+do7O
 gDU8ilakYlXMQ0E6ARi8Wq8I0DAmIXzT48A4f9yPLIAYslgnh0Mfp5kX8+YtC36p28dc
 XnkyvgDFIgFXCW1l4HUEFFoojaK1iWQHJ7oghppDCLH+8bfLUa+v2y9WY2nSsIKAKwGA
 t3f8OEm1U9vuNR7MdrY6ETpQd4uMjV1K1iN8XOh/KSUZdtyamCLT7LX0FCsYf1U5OEbW
 uPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691570901; x=1692175701;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CaMVbz0i3Y+YYXzxpJmTX31eDy2xFYpEI9ahnCQfS8w=;
 b=MsoCw8Trc1MXgtNWNh0CoyRy+kgiSupW50uf7YuDu6kWeGpu0pFX72F2Potk+pdtzQ
 cgSXgPE+IHcEXY+8b2YSO3+vXrE4hpjwGHA5cNB2epavuvtXD0CuTw92fEKZBxdEVAFq
 0l3CK5R5LQfH9FzCKtpCOubxq41OFkq0G2n6Q09KeoD83lFo7aLtQK1XgeIc/HWtMTQt
 CLr9qXDbtJEyg0g4qJ12PgtN4ImiEO3IZGwUDAB81O5RYC0TeF/wdj7bbiS32+MpCcEE
 GpGxr6TiJf0l6YqBhqFPSwS4uZE4ZQq3bSRyqM6X3/Ub+YWmvuzpSiD1MTg9h0h6SRtQ
 de/A==
X-Gm-Message-State: AOJu0Yy62ZpXgsw2ph0QjBsRJuc6LBmHso1zKHb/NT00kP5l0RQ7b16C
 Jw6wU98y5t7NbI7898COi9qTuA==
X-Google-Smtp-Source: AGHT+IHhTHhVu+of96duzlcUg2TX8P4iK+YxL5Vz1JdlWy+vLrJogaNCEWG9LaCX2oKRk+PxjaLEhA==
X-Received: by 2002:a5d:4249:0:b0:314:3f1:cebf with SMTP id
 s9-20020a5d4249000000b0031403f1cebfmr10090210wrr.28.1691570901446; 
 Wed, 09 Aug 2023 01:48:21 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y25-20020a05600c365900b003fe1afb99a9sm1286080wmq.11.2023.08.09.01.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 01:48:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A31601FFBB;
 Wed,  9 Aug 2023 09:48:20 +0100 (BST)
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-11-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org
Subject: Re: [RFC v4 10/11] tests/tcg/multiarch: Add nativecall.c test
Date: Wed, 09 Aug 2023 09:42:14 +0100
In-reply-to: <20230808141739.3110740-11-fufuyqqqqqq@gmail.com>
Message-ID: <87msz061pn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
>  tests/tcg/multiarch/native/nativecall.c | 98 +++++++++++++++++++++++++
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

As discussed earlier expanding the range of sizes involved will help get
more coverage especially as routines are usually optimised to handle
various alignments and block sizes.

You can also use a --enable-gcov build and check how much coverage of
your new code is hit by the test cases.

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

copy and paste fail here (dst/dest) means it doesn't compile.

It's always good practice to make sure your tree passes a make check (or
at least check-tcg in the user-mode case) to ensure no silly bugs are
present.

You can also create a gitlab account and take advantage of the CI. See
this run for example:

  https://gitlab.com/stsquad/qemu/-/pipelines/959899240/failures

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


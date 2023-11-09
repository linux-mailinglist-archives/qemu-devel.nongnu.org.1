Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC32F7E6A85
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:24:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r144D-0000hl-FX; Thu, 09 Nov 2023 07:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r144B-0000hI-E9
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:23:23 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r1446-0007AU-Fo
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:23:23 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5098eb6690cso731394e87.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 04:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699532596; x=1700137396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HSOnXP+w+crFJqJxF94h/n8C2tt94YjLXvEYeVkTwis=;
 b=WabQV+Qa4nZ+6LM2bGFKJVIPIz3qjybP9vEA5u1W+LQmO4XaCibovNUsBKFmXPKL82
 17YJ51+PfD1/r2OSe14OifvEYh040mkUWTRcWHc3tFs9pGA7uM14gQyDspafVdSrwZ+J
 LjKFqSHpZBKmipU+MiwvbZPZKR0hYO3AZwPtROLsFuxxqajJF0fKO4iPsu5G/ye7ZWnL
 HhYxw4ozYwqWrQO5PMYBMG7/1Rh7uY1AMQGN66Nq6O54cMYy5gb9JDxIQfsnpIo5dTnW
 p1q+WrvA95Oq4sJ2u608zJLd6u+PHyXn1r3mBDoDkr+pnt2IxtXkr8MlzRyVmc7WDzH6
 C/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699532596; x=1700137396;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HSOnXP+w+crFJqJxF94h/n8C2tt94YjLXvEYeVkTwis=;
 b=ElRTvTDpJBJXdE7ybTyWRN4xOM+P+tsJYL7tvs8nxF7J5fmqS9U0l6nCpMIYP8dcJ9
 WQlaszUlr272jmVl70WcytCMP+VsCZTHm9PTyjJI48rBi40YhyXxnIgbHdkGDsvKLXfO
 9B7eanKzEhwrz2TXjxqTNjB6WgwcsgDwMJVB5zLf3GJlUWDvGOLGmLEMlXkCbtgqRjnT
 elXPzZjIGemQS38UR+4f9Uf8b7XlSDhrT2lCJ1D9/qMvSKoOPmpcFyAxEgE0sCetZKFM
 e/g3QC67xVBvD95URrF0v/h4lP+n7ybVYgV+w+oglQfznQCho59PNrPAg8mfrJoGZdbM
 guVw==
X-Gm-Message-State: AOJu0YwNpPubRasckgFWiz7XuIysTrxoSDeBIpK5/ud8tm4SbvYRl3OM
 TkfpfKCR0Ib9PuM/WxRSep+6PA==
X-Google-Smtp-Source: AGHT+IH31YRHeAHD4iTweoh4MmDt1/JIUgdW+ayett0IUnPOweI+eY+5MeLZVYpmYLem2htWahfCXA==
X-Received: by 2002:a19:f710:0:b0:509:75b8:637b with SMTP id
 z16-20020a19f710000000b0050975b8637bmr1292651lfe.30.1699532595997; 
 Thu, 09 Nov 2023 04:23:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q23-20020a7bce97000000b004094e565e71sm1909953wmj.23.2023.11.09.04.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 04:23:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 291B45F756;
 Thu,  9 Nov 2023 12:23:15 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>, Naresh Kamboju
 <naresh.kamboju@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-stable@nongnu.org,
 Anders Roxell <anders.roxell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] target/arm: Fix SVE STR increment
In-Reply-To: <20231031143215.29764-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Tue, 31 Oct 2023 07:32:15 -0700 (1 week, 1
 day, 21 hours ago)")
References: <20231031143215.29764-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Thu, 09 Nov 2023 12:23:15 +0000
Message-ID: <874jhv86a4.fsf@draig.linaro.org>
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

Richard Henderson <richard.henderson@linaro.org> writes:

> The previous change missed updating one of the increments and
> one of the MemOps.  Add a test case for all vector lengths.
>
> Cc: qemu-stable@nongnu.org
> Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sv=
e_{ld, st}r")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This was Cd'd for stable but didn't make it in. There is a trivial
re-base conflict but I can re-send the patch if that helps.

With this:

   tuxrun --runtime docker \
     --qemu-binary ~/lsrc/qemu.git/builds/bisect/qemu-system-aarch64 \
     --device qemu-arm64 --boot-args rw \
     --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2XmWuG=
CI7saydsrZw4FcWSu6JGQ/Image.gz \
     --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2XmWu=
GCI7saydsrZw4FcWSu6JGQ/modules.tar.xz \
     --rootfs https://storage.tuxboot.com/debian/bookworm/arm64/rootfs.ext4=
.xz \
     --parameters SHARD_INDEX=3D4 --parameters SKIPFILE=3Dskipfile-lkft.yam=
l \
     --parameters SHARD_NUMBER=3D4 \
     --parameters KSELFTEST=3Dhttps://storage.tuxsuite.com/public/linaro/lk=
ft/builds/2XmWuGCI7saydsrZw4FcWSu6JGQ/kselftest.tar.xz \
     --image docker.io/linaro/tuxrun-dispatcher:v0.52.0 --tests kselftest-a=
rm64 --timeouts boot=3D30 kselftest-arm64=3D60

on my branch:

  https://gitlab.com/stsquad/qemu/-/tree/for-8.1-stable?ref_type=3Dheads

the test works.

> ---
>  target/arm/tcg/translate-sve.c    |  5 ++--
>  tests/tcg/aarch64/sve-str.c       | 49 +++++++++++++++++++++++++++++++
>  tests/tcg/aarch64/Makefile.target |  6 +++-
>  3 files changed, 57 insertions(+), 3 deletions(-)
>  create mode 100644 tests/tcg/aarch64/sve-str.c
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sv=
e.c
> index 7b39962f20..296e7d1ce2 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -4294,7 +4294,7 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, in=
t vofs,
>          t0 =3D tcg_temp_new_i64();
>          t1 =3D tcg_temp_new_i64();
>          t16 =3D tcg_temp_new_i128();
> -        for (i =3D 0; i < len_align; i +=3D 8) {
> +        for (i =3D 0; i < len_align; i +=3D 16) {
>              tcg_gen_ld_i64(t0, base, vofs + i);
>              tcg_gen_ld_i64(t1, base, vofs + i + 8);
>              tcg_gen_concat_i64_i128(t16, t0, t1);
> @@ -4320,7 +4320,8 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, in=
t vofs,
>          t16 =3D tcg_temp_new_i128();
>          tcg_gen_concat_i64_i128(t16, t0, t1);
>=20=20
> -        tcg_gen_qemu_st_i128(t16, clean_addr, midx, MO_LEUQ);
> +        tcg_gen_qemu_st_i128(t16, clean_addr, midx,
> +                             MO_LE | MO_128 | MO_ATOM_NONE);
>          tcg_gen_addi_i64(clean_addr, clean_addr, 16);
>=20=20
>          tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
> diff --git a/tests/tcg/aarch64/sve-str.c b/tests/tcg/aarch64/sve-str.c
> new file mode 100644
> index 0000000000..551f0d6f18
> --- /dev/null
> +++ b/tests/tcg/aarch64/sve-str.c
> @@ -0,0 +1,49 @@
> +#include <stdio.h>
> +#include <sys/prctl.h>
> +
> +#define N  (256+16)
> +
> +static int __attribute__((noinline)) test(int vl)
> +{
> +    unsigned char buf[N];
> +    int err =3D 0;
> +
> +    for (int i =3D 0; i < N; ++i) {
> +        buf[i] =3D (unsigned char)i;
> +    }
> +
> +    asm volatile (
> +        "mov z0.b, #255\n\t"
> +        "str z0, %0"
> +        : : "m" (buf) : "z0", "memory");
> +
> +    for (int i =3D 0; i < vl; ++i) {
> +        if (buf[i] !=3D 0xff) {
> +            fprintf(stderr, "vl %d, index %d, expected 255, got %d\n",
> +                    vl, i, buf[i]);
> +            err =3D 1;
> +        }
> +    }
> +
> +    for (int i =3D vl; i < N; ++i) {
> +        if (buf[i] !=3D (unsigned char)i) {
> +            fprintf(stderr, "vl %d, index %d, expected %d, got %d\n",
> +                    vl, i, (unsigned char)i, buf[i]);
> +            err =3D 1;
> +        }
> +    }
> +
> +    return err;
> +}
> +
> +int main()
> +{
> +    int err =3D 0;
> +
> +    for (int i =3D 16; i <=3D 256; i +=3D 16) {
> +        if (prctl(PR_SVE_SET_VL, i, 0, 0, 0, 0) =3D=3D i) {
> +            err |=3D test(i);
> +        }
> +    }
> +    return err;
> +}
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index 62b38c792f..c6542b5f1b 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -103,7 +103,11 @@ sha512-sve: CFLAGS=3D-O3 -march=3Darmv8.1-a+sve
>  sha512-sve: sha512.c
>  	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
>=20=20
> -TESTS +=3D sha512-sve
> +sve-str: CFLAGS=3D-O1 -march=3Darmv8.1-a+sve
> +sve-str: sve-str.c
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
> +
> +TESTS +=3D sha512-sve sve-str
>=20=20
>  ifneq ($(GDB),)
>  GDB_SCRIPT=3D$(SRC_PATH)/tests/guest-debug/run-test.py

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


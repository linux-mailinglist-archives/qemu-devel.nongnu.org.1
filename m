Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0C27763A1
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:24:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTl1Z-0002wA-3J; Wed, 09 Aug 2023 11:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTl1X-0002w2-HL
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:22:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTl1V-0001up-Ip
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:22:59 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31771a876b5so5208463f8f.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691594576; x=1692199376;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9BB30DPJdgu3jckbj1kP8Y5dDNivecGTeXnLgflP9Y=;
 b=NZ5RuvalpLhbkNFeml0hwwnFPTUMMtn3gXoGofxQsd9MRyE+T3DptHPwzU+s6ZiC9s
 5fdoacOt+bxm4FS+DD3FksVCCFxNWjS9nHJL0GshJeCgsFPdLH/yxXlPmq9j5u6ul/cS
 3LSCIldvkGV7mO1VpqFbQ+HCydmVBF9eQkd36D6QsLRSHcni2RP1493hzTUFr8BbiPY+
 YQRw+LdDHN7b+THcEXOhalQKN5aPxrG0Xamuu0218Xu3yRwZIJX9YEMvS749hBP5T4gx
 pmUn9jdngwXmNA2qYCRyALgU0zZwAgeWS90wUA1pDE3/evAZF4FVCSKx+kZenz957hbb
 JarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691594576; x=1692199376;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P9BB30DPJdgu3jckbj1kP8Y5dDNivecGTeXnLgflP9Y=;
 b=Rqs16CqhgJjDJ89VjHKD6XH7UBAdDZvJ1JJxonlfKK9Xy0K1ukkOKd0piZHpuAjYfL
 hyJB05xlXECz46DR6n8NMZX9siQihq9rRjrrDE1UFaAbFscUkMltqitWUm0pmsc4WC1e
 rH4Q/Pw3/DhPAV05fYiPws+/cm0rUHubGXoD84zGM1QMJYOqjK4uWmZHNPuESMsRxi4s
 X28XPLIOyBXxpdBzpoQT9SjmCRecjwa2xt12nDUIQaOVDaQlgpF4Al8B0S8nDSbTXdeu
 /VrkeSG/MzyFX33t7uNXyE+VfY/wgX0ae5M7QK3nd3ZQOot6Y0OI71j2aaOJx7YD8Mkn
 lH1w==
X-Gm-Message-State: AOJu0YwIvptN3yuU8XZ1sSNPVrUjxr+kgfnenaIowHNYKXHrWyDynmB7
 eGRTPqrKaJuCvYP1IeviidvLkg==
X-Google-Smtp-Source: AGHT+IFhkEBmBiaHGfUFhVe8Gl8KnFAesu6lmTyL2AKojApCPuLGE6SYfLOnhLMFIrsGKANHwv514w==
X-Received: by 2002:adf:ffc3:0:b0:315:a91c:1a8c with SMTP id
 x3-20020adfffc3000000b00315a91c1a8cmr2250663wrs.22.1691594575845; 
 Wed, 09 Aug 2023 08:22:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s1-20020adff801000000b00314417f5272sm16976839wrp.64.2023.08.09.08.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 08:22:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 139591FFBB;
 Wed,  9 Aug 2023 16:22:55 +0100 (BST)
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-3-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Riku Voipio
 <riku.voipio@iki.fi>
Subject: Re: [RFC v4 02/11] build: Implement libnative library and the build
 machinery for libnative
Date: Wed, 09 Aug 2023 16:18:47 +0100
In-reply-to: <20230808141739.3110740-3-fufuyqqqqqq@gmail.com>
Message-ID: <87wmy444vk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

> This commit implements a shared library, where native functions are
> rewritten as special instructions. At runtime, user programs load
> the shared library, and special instructions are executed when
> native functions are called.
>
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  Makefile                            |  2 +
>  common-user/native/Makefile.include |  9 ++++
>  common-user/native/Makefile.target  | 22 ++++++++++
>  common-user/native/libnative.c      | 67 +++++++++++++++++++++++++++++
>  configure                           | 39 +++++++++++++++++
>  include/native/libnative.h          |  8 ++++
>  6 files changed, 147 insertions(+)
>  create mode 100644 common-user/native/Makefile.include
>  create mode 100644 common-user/native/Makefile.target
>  create mode 100644 common-user/native/libnative.c
>  create mode 100644 include/native/libnative.h
>
> diff --git a/Makefile b/Makefile
> index 5d48dfac18..6f6147b40f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -182,6 +182,8 @@ SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory --=
quiet)
>=20=20
>  include $(SRC_PATH)/tests/Makefile.include
>=20=20
> +include $(SRC_PATH)/common-user/native/Makefile.include
> +
>  all: recurse-all
>=20=20
>  ROMS_RULES=3D$(foreach t, all clean distclean, $(addsuffix /$(t), $(ROMS=
)))
> diff --git a/common-user/native/Makefile.include b/common-user/native/Mak=
efile.include
> new file mode 100644
> index 0000000000..40d20bcd4c
> --- /dev/null
> +++ b/common-user/native/Makefile.include
> @@ -0,0 +1,9 @@
> +.PHONY: build-native
> +build-native: $(NATIVE_TARGETS:%=3Dbuild-native-library-%)
> +$(NATIVE_TARGETS:%=3Dbuild-native-library-%): build-native-library-%:
> +	$(call quiet-command, \
> +	    $(MAKE) -C common-user/native/$* $(SUBDIR_MAKEFLAGS), \
> +	"BUILD","$* native library")
> +# endif
> +
> +all: build-native
> diff --git a/common-user/native/Makefile.target b/common-user/native/Make=
file.target
> new file mode 100644
> index 0000000000..0c1241b368
> --- /dev/null
> +++ b/common-user/native/Makefile.target
> @@ -0,0 +1,22 @@
> +# -*- Mode: makefile -*-
> +#
> +# Library for native calls
> +#
> +
> +all:
> +-include ../../config-host.mak

This is sensitive to the out of tree build structure the user chooses. For
example:

  =E2=9E=9C  pwd
  /home/alex/lsrc/qemu.git/builds/user/common-user/native/aarch64-linux-user
  =F0=9F=95=9916:20:08 alex@zen:common-user/native/aarch64-linux-user  on =
=EE=82=A0 review/native-lib-calls-v4 [$!?]=20
  =E2=9E=9C  make libnative.so
  make: *** No rule to make target '/common-user/native/libnative.c', neede=
d by 'libnative.so'.  Stop.
  =F0=9F=95=9916:20:13 alex@zen:common-user/native/aarch64-linux-user  on =
=EE=82=A0 review/native-lib-calls-v4 [$!?] [=F0=9F=94=B4 USAGE]=20
  =E2=9C=97=20=20

I think this can be solved the same way as we do for tests/tcg by
symlinking the config-host.mak into place and referring to it directly
or adjusting the include to ../../../config-host.mak because the top of
the build tree has a symlinked copy as well.


> +-include config-target.mak
> +
> +CFLAGS+=3D-O1 -fPIC -shared -fno-stack-protector -I$(SRC_PATH)/include -=
D$(TARGET_NAME)
> +LDFLAGS+=3D
> +
> +SRC =3D $(SRC_PATH)/common-user/native/libnative.c
> +LIBNATIVE =3D libnative.so
> +
> +all: $(LIBNATIVE)
> +
> +$(LIBNATIVE): $(SRC)
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(EXTRA_NATIVE_CALL_FLAGS) $< -o $@ $(L=
DFLAGS)
> +
> +clean:
> +	rm -f $(LIBNATIVE)
> diff --git a/common-user/native/libnative.c b/common-user/native/libnativ=
e.c
> new file mode 100644
> index 0000000000..662ae6fbfe
> --- /dev/null
> +++ b/common-user/native/libnative.c
> @@ -0,0 +1,67 @@
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include "native/libnative.h"
> +
> +#define WRAP_NATIVE()                                 \
> +    do {                                              \
> +        __asm__ volatile(__CALL_EXPR : : : "memory"); \
> +    } while (0)
> +
> +#if defined(i386) || defined(x86_64)
> +/*
> + * An unused instruction is utilized to mark a native call.
> + */
> +#define __CALL_EXPR ".byte 0x0f, 0xff;"
> +#endif
> +
> +#if defined(arm) || defined(aarch64)
> +/*
> + * HLT is an invalid instruction for userspace and usefully has 16
> + * bits of spare immeadiate data which we can stuff data in.
> + */
> +#define __CALL_EXPR "hlt 0xffff;"
> +#endif
> +
> +#if defined(mips) || defined(mips64)
> +/*
> + * The syscall instruction contains 20 unused bits, which are typically
> + * set to 0. These bits can be used to store non-zero data,
> + * distinguishing them from a regular syscall instruction.
> + */
> +#define __CALL_EXPR "syscall 0xffff;"
> +#endif
> +
> +void *memcpy(void *dest, const void *src, size_t n)
> +{
> +    WRAP_NATIVE();
> +}
> +int memcmp(const void *s1, const void *s2, size_t n)
> +{
> +    WRAP_NATIVE();
> +}
> +void *memset(void *s, int c, size_t n)
> +{
> +    WRAP_NATIVE();
> +}
> +char *strncpy(char *dest, const char *src, size_t n)
> +{
> +    WRAP_NATIVE();
> +}
> +int strncmp(const char *s1, const char *s2, size_t n)
> +{
> +    WRAP_NATIVE();
> +}
> +char *strcpy(char *dest, const char *src)
> +{
> +    WRAP_NATIVE();
> +}
> +char *strcat(char *dest, const char *src)
> +{
> +    WRAP_NATIVE();
> +}
> +int strcmp(const char *s1, const char *s2)
> +{
> +    WRAP_NATIVE();
> +}
> diff --git a/configure b/configure
> index a076583141..e02fc2c5c0 100755
> --- a/configure
> +++ b/configure
> @@ -1822,6 +1822,45 @@ if test "$tcg" =3D "enabled"; then
>  fi
>  )
>=20=20
> +# common-user/native configuration
> +(mkdir -p common-user/native
> +
> +native_targets=3D
> +for target in $target_list; do
> +  case $target in
> +    *-softmmu)
> +    continue
> +    ;;
> +  esac
> +
> +  # native call is only supported on these architectures
> +  arch=3D${target%%-*}
> +  config_target_mak=3Dcommon-user/native/$target/config-target.mak
> +  case $arch in
> +    i386|x86_64|arm|aarch64|mips|mips64)
> +      if test -f cross-build/$target/config-target.mak; then
> +        mkdir -p "common-user/native/$target"
> +        ln -srf cross-build/$target/config-target.mak "$config_target_ma=
k"
> +        if test $arch =3D arm; then
> +          echo "EXTRA_NATIVE_CALL_FLAGS=3D-marm" >> "$config_target_mak"
> +        fi
> +        if test $arch =3D $cpu || \
> +          { test $arch =3D i386 && test $cpu =3D x86_64; } || \
> +          { test $arch =3D arm && test $cpu =3D aarch64; } || \
> +          { test $arch =3D mips && test $cpu =3D mips64; }; then
> +          echo "LD_PREFIX=3D/" >> "$config_target_mak"
> +        fi
> +        echo "LIBNATIVE=3D$PWD/common-user/native/$target/libnative.so" =
>> "$config_target_mak"
> +        ln -sf $source_path/common-user/native/Makefile.target common-us=
er/native/$target/Makefile
> +        native_targets=3D"$native_targets $target"
> +      fi
> +    ;;
> +  esac
> +done
> +
> +echo "NATIVE_TARGETS=3D$native_targets" >> config-host.mak
> +)
> +
>  if test "$skip_meson" =3D no; then
>    cross=3D"config-meson.cross.new"
>    meson_quote() {
> diff --git a/include/native/libnative.h b/include/native/libnative.h
> new file mode 100644
> index 0000000000..ec990d8e5f
> --- /dev/null
> +++ b/include/native/libnative.h
> @@ -0,0 +1,8 @@
> +void *memset(void *s, int c, size_t n);
> +void *memcpy(void *dest, const void *src, size_t n);
> +char *strncpy(char *dest, const char *src, size_t n);
> +int memcmp(const void *s1, const void *s2, size_t n);
> +int strncmp(const char *s1, const char *s2, size_t n);
> +char *strcpy(char *dest, const char *src);
> +char *strcat(char *dest, const char *src);
> +int strcmp(const char *s1, const char *s2);


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


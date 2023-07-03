Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A75337460D6
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:39:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGMZ3-0003t4-DY; Mon, 03 Jul 2023 12:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGMZ0-0003sh-U6
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:38:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGMYx-0007VI-0c
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:38:10 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso44976315e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 09:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688402285; x=1690994285;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sP6ADlUwustn3ehmEPv9PG3Cx0frkkjhvUD0JD+u0uw=;
 b=hS177GSX61+RWg0UZ/e63XJsPC75yWslKNnYBfxoIOEwnJQ2UR7Hu//sxRgUjGNF7v
 rFht0TJnYrKCGLnBBfQfBK6Xm2LOznfZ0ASEygikIT2Zz+F7w0SA8bqnRA6L3I2KwdRF
 CYPQbiAuS11fHOAUBxDZKCfeLoRYjl1BfTp/6Cz9Xvx1/3k3X7tio5T4/2SV9PIclJOX
 JpzTed+xSLz07raBbSxyhRDlaEoV62q5WwT7npn8QO/oCpKJejlh7GlbhZVjov/h18QQ
 AS2i5aeBLIh5up0PXJeWycEv4f4iFAA+oOmfqYB8APc823MUcVWa5RYdnmYTZuA1xlWl
 4HNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688402285; x=1690994285;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sP6ADlUwustn3ehmEPv9PG3Cx0frkkjhvUD0JD+u0uw=;
 b=aPDyC5cli+VjKfe04PvI+Y/XsgRxiVg9YxmabGdK0JNt6QeMblA35qMrKv2QHDCbbp
 v6S+FOHYLgIdm9pnpeK272w0mSPHVa92xiTD94TVNadiKZfaoXge00bOuw/kS+XPuJCo
 aEbqjYHH7B8LKfAk5OMonWOyhQxHCz7y4jL8l40hRMYxF3Tt2ROyfvUhyhbrX2xECIoU
 oqSikjH+wqPW6eBP9NxVxG4N6+mi1NsRUdOhW29gxWSHeDZrpz9LQM/1EWWHO7JVmjs8
 EJXBKLxJN9diLtwYcVS1nvFc71OmCV7yDQ64Y4qHU/9s3+mSpOyTW0BGTP7BOzQsXElp
 2Ehg==
X-Gm-Message-State: AC+VfDw0n2GJ1T/GeKIXQhA1OyX1Z8ASMGASYw4mh6NDUAGuQt3MQUsN
 AM2XCqQlEsdGa40VGwkXkQ6MY7GpzeRo+mnGRXw=
X-Google-Smtp-Source: ACHHUZ4LDSaBqulfitfJKeUyT9SFTFcJ38VsaWCZ7HERS8k/dOgdBjgYf88NGmBiUbuVEEzbztD7Dg==
X-Received: by 2002:a05:600c:20a:b0:3fb:9b7e:c5b1 with SMTP id
 10-20020a05600c020a00b003fb9b7ec5b1mr9178502wmi.19.1688402285132; 
 Mon, 03 Jul 2023 09:38:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c024900b003fbb1bf7e0fsm15297707wmj.35.2023.07.03.09.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 09:38:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5E2111FFBB;
 Mon,  3 Jul 2023 17:38:04 +0100 (BST)
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
 <20230625212707.1078951-4-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Riku Voipio
 <riku.voipio@iki.fi>
Subject: Re: [RFC v3 03/10] build: Implement libnative library and configure
 options
Date: Mon, 03 Jul 2023 16:30:22 +0100
In-reply-to: <20230625212707.1078951-4-fufuyqqqqqq@gmail.com>
Message-ID: <87mt0dgdcj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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


Yeqi Fu <fufuyqqqqqq@gmail.com> writes:

> This commit implements a shared library, where native functions are
> rewritten as specialized instructions. At runtime, user programs load
> the shared library, and specialized instructions are executed when
> native functions are called.

This commit breaks the build:

  make -j9 all
  config-host.mak is out-of-date, running configure
  python determined to be '/usr/bin/python3'
  python version: Python 3.11.2
  mkvenv: Creating non-isolated virtual environment at 'pyvenv'
  mkvenv: checking for meson>=3D0.63.0
  The Meson build system
  Version: 1.0.1
  Source dir: /home/alex/lsrc/qemu.git
  Build dir: /home/alex/lsrc/qemu.git/builds/user
  Build type: native build
  Project name: qemu
  Project version: 8.0.50
  C compiler for the host machine: cc -m64 -mcx16 (gcc 12.2.0 "cc (Debian 1=
2.2.0-14) 12.2.0")
  C linker for the host machine: cc -m64 -mcx16 ld.bfd 2.40
  Host machine cpu family: x86_64
  Host machine cpu: x86_64
  Program scripts/symlink-install-tree.py found: YES (/home/alex/lsrc/qemu.=
git/builds/user/pyvenv/bin/python3 /home/alex/lsrc/qemu.git/scripts/symlink=
-install-tree.py)
  Program sh found: YES (/usr/bin/sh)
  C++ compiler for the host machine: c++ -m64 -mcx16 (gcc 12.2.0 "c++ (Debi=
an 12.2.0-14) 12.2.0")
  C++ linker for the host machine: c++ -m64 -mcx16 ld.bfd 2.40

  ../../meson.build:68:0: ERROR: Key TARGET_DIRS is not in the dictionary.

  A full log can be found at /home/alex/lsrc/qemu.git/builds/user/meson-log=
s/meson-log.txt

  ERROR: meson setup failed

  make: *** [Makefile:83: config-host.mak] Error 1

  Compilation exited abnormally with code 2 at Mon Jul  3 16:29:43

I would split this into a number of separate commits.

  - configure logic to move around and share the config.mk
  - add the build machinery for libnative with a default WRAP_NATIVE
    which asserts()
  - merge the per-arch macros with arch enabling patch

>
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  Makefile                            |   2 +
>  common-user/native/Makefile.include |   9 +++
>  common-user/native/Makefile.target  |  26 +++++++
>  common-user/native/libnative.c      | 112 ++++++++++++++++++++++++++++
>  configure                           |  84 ++++++++++++++++-----
>  include/native/libnative.h          |  12 +++
>  include/native/native-defs.h        |  65 ++++++++++++++++
>  7 files changed, 293 insertions(+), 17 deletions(-)
>  create mode 100644 common-user/native/Makefile.include
>  create mode 100644 common-user/native/Makefile.target
>  create mode 100644 common-user/native/libnative.c
>  create mode 100644 include/native/libnative.h
>  create mode 100644 include/native/native-defs.h
>
> diff --git a/Makefile b/Makefile
> index 3c7d67142f..787b8954a6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -185,6 +185,8 @@ SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory --=
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
> index 0000000000..1bb468a2ec
> --- /dev/null
> +++ b/common-user/native/Makefile.target
> @@ -0,0 +1,26 @@
> +# -*- Mode: makefile -*-
> +#
> +# Library for native calls=20
> +#
> +
> +all:
> +-include ../config-host.mak
> +-include config-target.mak
> +
> +CFLAGS+=3D-O1 -fPIC -shared -fno-stack-protector -I$(SRC_PATH)/include -=
D$(TARGET_NAME)=20
> +LDFLAGS+=3D
> +
> +ifeq ($(TARGET_NAME),arm)
> +EXTRA_CFLAGS+=3D-marm
> +endif

I think I mentioned before that this is something that the configure
script should add to config-target.mak.

> +
> +SRC =3D $(SRC_PATH)/common-user/native/libnative.c
> +LIBNATIVE =3D libnative.so
> +
> +all: $(LIBNATIVE)
> +
> +$(LIBNATIVE): $(SRC)
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
> +
> +clean:
> +	rm -f $(LIBNATIVE)
> diff --git a/common-user/native/libnative.c b/common-user/native/libnativ=
e.c
> new file mode 100644
> index 0000000000..26a004e3b4
> --- /dev/null
> +++ b/common-user/native/libnative.c
> @@ -0,0 +1,112 @@
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include "native/libnative.h"
> +#include "native/native-defs.h"
> +
> +#if defined(i386) || defined(x86_64)
> +/* unused opcode */
> +#define WRAP_NATIVE_CALL(func_id, abi_map)                          \
> +    do {                                                            \
> +        __asm__ volatile(".byte 0x0f,0xff\n\t"                      \
> +                         ".word %c[imm1],%c[imm2]\n\t"              \
> +                         : /* no outputs */                         \
> +                         : [imm1] "i"(func_id), [imm2] "i"(abi_map) \
> +                         :);                                        \
> +    } while (0)
> +
> +#endif
> +
> +#if defined(arm) || defined(aarch64)
> +/*
> + * HLT is an invalid instruction for userspace and usefully has 16
> + * bits of spare immeadiate data which we can stuff data in.
> + */
> +#define WRAP_NATIVE_CALL(func_id, abi_map)            \
> +    do {                                              \
> +        __asm__ volatile("hlt  %c0\n\t"               \
> +                         "hlt  %c1\n\t"               \
> +                         : /* no outputs */           \
> +                         : "i"(func_id), "i"(abi_map) \
> +                         : "memory");                 \
> +    } while (0)
> +
> +#endif
> +
> +#if defined(mips) || defined(mips64)
> +/*
> + * There are some unused bytes in the syscall instruction
> + */
> +#define WRAP_NATIVE_CALL(func_id, abi_map)            \
> +    do {                                              \
> +        __asm__ volatile("syscall  %c0\n\t"           \
> +                         "syscall  %c1\n\t"           \
> +                         : /* no outputs */           \
> +                         : "i"(func_id), "i"(abi_map) \
> +                         : "memory");                 \
> +    } while (0)
> +
> +#endif
> +
> +static inline const uint32_t encode_1out_3in(int rtype, int arg1, int ar=
g2,
> +                                             int arg3)
> +{
> +    return (rtype & 0xf) | ((arg1 & 0xf) << 4) | ((arg2 & 0xf) << 8) |
> +           ((arg3 & 0xf) << 12);
> +}
> +
> +static inline const uint32_t encode_0out_3in(int arg1, int arg2, int arg=
3)
> +{
> +    return encode_1out_3in(TYPE_NO_ARG, arg1, arg2, arg3);
> +}
> +
> +static inline const uint32_t encode_1out_2in(int rtype, int arg1, int ar=
g2)
> +{
> +    return encode_1out_3in(rtype, arg1, arg2, TYPE_NO_ARG);
> +}
> +
> +void *memcpy(void *dest, const void *src, size_t n)
> +{
> +    const uint32_t args =3D encode_1out_3in(TYPE_PTR_ARG, TYPE_PTR_ARG_W,
> +                                          TYPE_PTR_ARG_R, TYPE_IPTR_ARG);
> +    WRAP_NATIVE_CALL(NATIVE_MEMCPY, args);
> +}
> +
> +int memcmp(const void *s1, const void *s2, size_t n)
> +{
> +    const uint32_t args =3D encode_1out_3in(TYPE_INT_ARG, TYPE_PTR_ARG_R,
> +                                          TYPE_PTR_ARG_R, TYPE_IPTR_ARG);
> +    WRAP_NATIVE_CALL(NATIVE_MEMCMP, args);
> +}
> +
> +void *memset(void *s, int c, size_t n)
> +{
> +    const uint32_t args =3D encode_1out_3in(TYPE_PTR_ARG, TYPE_PTR_ARG_W,
> +                                          TYPE_INT_ARG, TYPE_IPTR_ARG);
> +    WRAP_NATIVE_CALL(NATIVE_MEMSET, args);
> +}
> +char *strncpy(char *dest, const char *src, size_t n)
> +{
> +    const uint32_t args =3D encode_1out_3in(TYPE_PTR_ARG, TYPE_PTR_ARG_W,
> +                                          TYPE_PTR_ARG_R, TYPE_IPTR_ARG);
> +    WRAP_NATIVE_CALL(NATIVE_STRNCPY, args);
> +}
> +int strncmp(const char *s1, const char *s2, size_t n)
> +{
> +    const uint32_t args =3D encode_1out_3in(TYPE_INT_ARG, TYPE_PTR_ARG_R,
> +                                          TYPE_PTR_ARG_R, TYPE_IPTR_ARG);
> +    WRAP_NATIVE_CALL(NATIVE_STRNCMP, args);
> +}
> +char *strcpy(char *dest, const char *src)
> +{
> +    const uint32_t args =3D
> +        encode_1out_2in(TYPE_PTR_ARG, TYPE_PTR_ARG_W, TYPE_PTR_ARG_R);
> +    WRAP_NATIVE_CALL(NATIVE_STRCPY, args);
> +}
> +int strcmp(const char *s1, const char *s2)
> +{
> +    const uint32_t args =3D
> +        encode_1out_2in(TYPE_INT_ARG, TYPE_PTR_ARG_R, TYPE_PTR_ARG_R);
> +    WRAP_NATIVE_CALL(NATIVE_STRCMP, args);
> +}
> diff --git a/configure b/configure
> index 2a556d14c9..64edbda892 100755
> --- a/configure
> +++ b/configure
> @@ -1838,48 +1838,42 @@ if test "$ccache_cpp2" =3D "yes"; then
>    echo "export CCACHE_CPP2=3Dy" >> $config_host_mak
>  fi
>=20=20
> -# tests/tcg configuration
> -(config_host_mak=3Dtests/tcg/config-host.mak
> -mkdir -p tests/tcg
> -echo "# Automatically generated by configure - do not modify" > $config_=
host_mak
> -echo "SRC_PATH=3D$source_path" >> $config_host_mak
> -echo "HOST_CC=3D$host_cc" >> $config_host_mak
> +# prepare config files for cross build

I think we could expand this comment a little. Something like:

# Prepare the config files for cross building. There are two parts:
#  - cross-build/config-host.mak (common host definitions)
#  - cross-build/<target>/config-target.mak
#
# These files are then symlinked to the directories that need them which
# including the TCG tests (tests/tcg/<target>) and the libnative library
# for linux-user (common/native/<target>/).

> +config_corss_build_host_mak=3Dcross-build/config-host.mak

I'm not sure renaming the config_host_mak variable helps here. Although
now I see the problem because there are two config-host's here:

=E2=9C=97  diff -y config-host.mak ./tests/tcg/config-host.mak
# Automatically generated by configure - do not modify          # Automatic=
ally generated by configure - do not modify
                                                              <
all:                                                          <
CONFIG_POSIX=3Dy                                                <
CONFIG_LINUX=3Dy                                                <
SRC_PATH=3D/home/alex/lsrc/qemu.git                               SRC_PATH=
=3D/home/alex/lsrc/qemu.git
TARGET_DIRS=3Daarch64-linux-user aarch64_be-linux-user alpha-li | HOST_CC=
=3Dcc
CONFIG_PLUGIN=3Dy                                               <
HAVE_GDB_BIN=3D/usr/bin/gdb-multiarch                             HAVE_GDB_=
BIN=3D/usr/bin/gdb-multiarch
ENGINE=3Ddocker                                                 | CONFIG_PL=
UGIN=3Dy
RUNC=3Ddocker                                                   <
ROMS=3D                                                         <
PYTHON=3D/home/alex/lsrc/qemu.git/builds/user/pyvenv/bin/python <
GENISOIMAGE=3D/usr/bin/genisoimage                              <
MESON=3D/home/alex/lsrc/qemu.git/builds/user/pyvenv/bin/meson   <
NINJA=3D/usr/bin/ninja                                          <
PKG_CONFIG=3Dpkg-config                                         <
CC=3Dcc                                                         <
EXESUF=3D                                                       <
CONFIG_DEFAULT_TARGETS=3Dy                                      <
TCG_TESTS_TARGETS=3D aarch64-linux-user alpha-linux-user arm-li <

and the result of this patch squashes two together and looses the extra
information the top config-host.mak needs.

> +mkdir -p cross-build
> +echo "# Automatically generated by configure - do not modify" > $config_=
corss_build_host_mak
> +echo "SRC_PATH=3D$source_path" >> $config_corss_build_host_mak
> +echo "HOST_CC=3D$host_cc" >> $config_corss_build_host_mak

Phillipe has already mentioned the s/corss/cross/

>=20=20
>  # versioned checked in the main config_host.mak above
>  if test -n "$gdb_bin"; then
> -    echo "HAVE_GDB_BIN=3D$gdb_bin" >> $config_host_mak
> +    echo "HAVE_GDB_BIN=3D$gdb_bin" >> $config_corss_build_host_mak
>  fi
>  if test "$plugins" =3D "yes" ; then
> -    echo "CONFIG_PLUGIN=3Dy" >> $config_host_mak
> +    echo "CONFIG_PLUGIN=3Dy" >> $config_corss_build_host_mak
>  fi
>=20=20
> -tcg_tests_targets=3D
>  for target in $target_list; do
>    arch=3D${target%%-*}
> -
>    case $target in
>      xtensa*-linux-user)
> -      # the toolchain is not complete with headers, only build softmmu t=
ests
>        continue
>        ;;
>      *-softmmu)
> -      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || =
continue
>        qemu=3D"qemu-system-$arch"
>        ;;
>      *-linux-user|*-bsd-user)
>        qemu=3D"qemu-$arch"
>        ;;
>    esac
> -
>    if probe_target_compiler $target || test -n "$container_image"; then
>        test -n "$container_image" && build_static=3Dy
> -      mkdir -p "tests/tcg/$target"
> -      config_target_mak=3Dtests/tcg/$target/config-target.mak
> -      ln -sf "$source_path/tests/tcg/Makefile.target" "tests/tcg/$target=
/Makefile"
> +      mkdir -p "cross-build/$target"
> +      config_target_mak=3Dcross-build/$target/config-target.mak
>        echo "# Automatically generated by configure - do not modify" > "$=
config_target_mak"
>        echo "TARGET_NAME=3D$arch" >> "$config_target_mak"
>        echo "TARGET=3D$target" >> "$config_target_mak"
> -      write_target_makefile "build-tcg-tests-$target" >> "$config_target=
_mak"
> +      write_target_makefile "$target" >> "$config_target_mak"
>        echo "BUILD_STATIC=3D$build_static" >> "$config_target_mak"
>        echo "QEMU=3D$PWD/$qemu" >> "$config_target_mak"
>=20=20
> @@ -1887,7 +1881,34 @@ for target in $target_list; do
>        if test "${gdb_arches#*$arch}" !=3D "$gdb_arches"; then
>            echo "HOST_GDB_SUPPORTS_ARCH=3Dy" >> "$config_target_mak"
>        fi
> +  fi
> +done
> +
> +
> +# tests/tcg configuration
> +(mkdir -p tests/tcg
> +ln -srf $config_corss_build_host_mak tests/tcg/config-host.mak
> +
> +tcg_tests_targets=3D
> +for target in $target_list; do
> +  arch=3D${target%%-*}
> +
> +  case $target in
> +    xtensa*-linux-user)
> +      # the toolchain is not complete with headers, only build softmmu t=
ests
> +      continue
> +      ;;
> +    *-softmmu)
> +      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || =
continue
> +      ;;
> +    *-linux-user|*-bsd-user)
> +      ;;
> +  esac
>=20=20
> +  if probe_target_compiler $target || test -n "$container_image"; then
> +      mkdir -p "tests/tcg/$target"
> +      ln -srf cross-build/$target/config-target.mak tests/tcg/$target/co=
nfig-target.mak
> +      ln -sf $source_path/tests/tcg/Makefile.target tests/tcg/$target/Ma=
kefile
>        echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
>        tcg_tests_targets=3D"$tcg_tests_targets $target"
>    fi
> @@ -1898,6 +1919,35 @@ if test "$tcg" =3D "enabled"; then
>  fi
>  )
>=20=20
> +# common-user/native configuration
> +(mkdir -p common-user/native
> +# reuse the same config-host.mak as tests/tcg
> +ln -srf $config_corss_build_host_mak common-user/native/config-host.mak
> +
> +native_targets=3D
> +for target in $target_list; do
> +  arch=3D${target%%-*}
> +  # Skip targets that are not supported
> +  case "$arch" in
> +    i386|x86_64|arm|aarch64|mips|mips64)
> +      case $target in
> +        *-linux-user|*-bsd-user)
> +          if probe_target_compiler $target || test -n
> "$container_image"; then

We are repeating the compiler probe here. We should only need to do it
once for all targets and then if there is a valid cross-build config
detect that when symlinking the tests/tcg and common-user versions.

> +            mkdir -p "common-user/native/$target"
> +            # reuse the same config-target.mak as tests/tcg
> +            ln -srf cross-build/$target/config-target.mak common-user/na=
tive/$target/config-target.mak
> +            ln -sf $source_path/common-user/native/Makefile.target commo=
n-user/native/$target/Makefile
> +            native_targets=3D"$native_targets $target"
> +          fi
> +        ;;
> +      esac
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
> index 0000000000..25a59833db
> --- /dev/null
> +++ b/include/native/libnative.h
> @@ -0,0 +1,12 @@
> +#ifndef __LIBNATIVE_H__
> +#define __LIBNATIVE_H__
> +
> +void *memcpy(void *dest, const void *src, size_t n);
> +int memcmp(const void *s1, const void *s2, size_t n);
> +void *memset(void *s, int c, size_t n);
> +char *strncpy(char *dest, const char *src, size_t n);
> +int strncmp(const char *s1, const char *s2, size_t n);
> +char *strcpy(char *dest, const char *src);
> +int strcmp(const char *s1, const char *s2);
> +
> +#endif /* __LIBNATIVE_H__ */
> diff --git a/include/native/native-defs.h b/include/native/native-defs.h
> new file mode 100644
> index 0000000000..37ed479408
> --- /dev/null
> +++ b/include/native/native-defs.h
> @@ -0,0 +1,65 @@
> +#ifndef __NATIVE_FUNC_H__
> +#define __NATIVE_FUNC_H__
> +
> +/*
> + * Native function IDs. These are used to identify the native function
> + */
> +#define NATIVE_MEMCPY 0x1001
> +#define NATIVE_MEMCMP 0x1002
> +#define NATIVE_MEMSET 0x1003
> +#define NATIVE_STRNCPY 0x1004
> +#define NATIVE_STRNCMP 0x1005
> +#define NATIVE_STRCPY 0x2001
> +#define NATIVE_STRCMP 0x2002
> +
> +/*
> + * Argument encoding. We only really care about 3 types. The two base
> + * register sizes (32 and 64) and if the value is a pointer (in which
> + * case we need to adjust it g2h before passing to the native
> + * function).
> + */
> +#define TYPE_NO_ARG 0x0
> +#define TYPE_I32_ARG 0x1 /* uint32_t */
> +#define TYPE_I64_ARG 0x2 /* uint64_t */
> +#define TYPE_INT_ARG 0x3 /* int */
> +#define TYPE_PTR_ARG 0x4 /* void* */
> +#define TYPE_PTR_ARG_R 0x5
> +#define TYPE_PTR_ARG_W 0x6
> +
> +/*
> + * Add an alias for the natural register size, it might be easier to
> + * pass this in.
> + */
> +#if UINTPTR_MAX =3D=3D 0xFFFFFFFF
> +#define TYPE_IPTR_ARG TYPE_I32_ARG
> +#elif UINTPTR_MAX =3D=3D 0xFFFFFFFFFFFFFFFFu
> +#define TYPE_IPTR_ARG TYPE_I64_ARG
> +#else
> +#error TBD pointer size
> +#endif
> +
> +#define GET_RVALUE(types) ((types)&0xf)
> +#define GET_ARG1(types) (((types) >> 4) & 0xf)
> +#define GET_ARG2(types) (((types) >> 8) & 0xf)
> +#define GET_ARG3(types) (((types) >> 12) & 0xf)
> +
> +#define IS_PTR_RVALUE(types) (GET_RVALUE(types) >=3D TYPE_PTR_ARG)
> +#define IS_PTR_ARG1(types) (GET_ARG1(types) >=3D TYPE_PTR_ARG)
> +#define IS_PTR_ARG2(types) (GET_ARG2(types) >=3D TYPE_PTR_ARG)
> +#define IS_PTR_ARG3(types) (GET_ARG3(types) >=3D TYPE_PTR_ARG)
> +
> +#define IS_ARG_PTR(type) (type >=3D TYPE_PTR_ARG)
> +#define IS_ARG_READ(type) (type =3D=3D TYPE_PTR_ARG_R)
> +#define IS_ARG_WRITE(type) (type =3D=3D TYPE_PTR_ARG_W)
> +
> +/*
> + * Check if the native bypass feature is enabled.
> + */
> +#if defined(CONFIG_USER_ONLY) && defined(CONFIG_NATIVE_CALL)
> +extern bool native_bypass_enabled;
> +#define native_call_enabled() (native_bypass_enabled)
> +#else
> +#define native_call_enabled() 0
> +#endif
> +
> +#endif /* __NATIVE_FUNC_H__ */


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


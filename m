Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD77717921
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 09:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4GgC-0004QA-KP; Wed, 31 May 2023 03:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4Gg7-0004O7-0L
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:55:31 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4Gg0-0003Qm-Eh
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:55:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30a1fdde3d6so5459711f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 00:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685519722; x=1688111722;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7LUHYK8pBIlV9aYlzMBa1MxqMNPULZTWytdS72H75k=;
 b=zzXN1/iVNYoFmsM3ke5NMlqtX4WlXVTJU0stscfulGGp4XRaIKmjSTYVZ1WiH08YyC
 E9XyRGE0/dK7NWIk4WB/YkT0khpVPgemIgJGq6NYDDwNiPZwaRA/9Bro1UvEg3rlCXbm
 jDBZaxhKEWpqEOOgidBVieprJv9fcPDFo3B3DuHxcF3jlrNNQ/LPMi15Hk920gQv+vQm
 Yg2SuAhmVUYc3uDTQ1JyIO4dhWNfxspIzzIrczibQZHIWvd8BXJYWa5xMXBEppZGnynL
 2re3pLCDdo03URpxP9zB1Ujrklxx6MoLuO0XTJdkTz29Gtv1vwWDhiUgP1zeDTDNSTYy
 aOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685519722; x=1688111722;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D7LUHYK8pBIlV9aYlzMBa1MxqMNPULZTWytdS72H75k=;
 b=FP54JRP/QsGt/J7/SzQNTKcsCh2bT3Qof90aoFxP0UrqwK5vlYJrNGfwl9VdghUGfA
 xxilD9rjiNSCtPr5gGBfpSG8Dfdx/BvvVF/98eUcYJ3yHbEfvyq/0sdGb290HzLueymN
 4vlDzs+D/23/OLMloAdb/Jx0v3bitc9sotLUDUBN0d/FN3hqv5PisJAss0Wvcjuwikg5
 GxLq8agmU3g1z+WTUFs9Wr7LHr4h6y0Gqcm5RcT4+J5G0Yo6q3ntIH0pYOpPF3/3JpJu
 K1JxhqV8SFGu04ZK/C2NJHL9WJVlyxMC7bbWBbW+rY28gM0k3iVJ7JZmKryByHKlgQ9f
 109A==
X-Gm-Message-State: AC+VfDz+hXRKhvpe/+mkqU/FHKPcDP0Ve3M7EnkPaixRr2xozQO325lh
 pVaozHM0QmSID8aTaBAZ92Hmtg==
X-Google-Smtp-Source: ACHHUZ4lz/3mOK0jQYmbv75kdHWIZf07DIrk5FwJCld31cuHbqlTzVEeJKG2aM8lDvfJ9BgiZszT6Q==
X-Received: by 2002:adf:dd92:0:b0:30a:b46a:a443 with SMTP id
 x18-20020adfdd92000000b0030ab46aa443mr3094926wrl.51.1685519722387; 
 Wed, 31 May 2023 00:55:22 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a5d5344000000b00307acec258esm5833566wrv.3.2023.05.31.00.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 00:55:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6FD9A1FFBB;
 Wed, 31 May 2023 08:55:21 +0100 (BST)
References: <20230530142430.45834-1-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [RFC] Native Library Calls
Date: Wed, 31 May 2023 08:24:12 +0100
In-reply-to: <20230530142430.45834-1-fufuyqqqqqq@gmail.com>
Message-ID: <87v8g9c4uu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

> This patch introduces a set of feature instructions for native calls
> and provides helpers to translate these instructions to corresponding
> native functions. A shared library is also implemented, where native
> functions are rewritten as feature instructions. At runtime, user
> programs load the shared library, and feature instructions are
> executed when native functions are called. This patch is applicable
> to user programs with architectures x86, x86_64, arm, aarch64, mips,
> and mips64. To build, compile libnative.c into a shared library for
> the user program's architecture and run the
> '../configure --enable-user-native-call && make' command.
>
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  include/exec/user/native-func.h      |  8 +++
>  libnative.c                          | 76 ++++++++++++++++++++++++++++
>  meson.build                          |  8 +++
>  meson_options.txt                    |  2 +
>  scripts/make-config-poison.sh        |  4 +-
>  scripts/meson-buildoptions.sh        |  4 ++
>  target/arm/helper.c                  | 47 +++++++++++++++++
>  target/arm/helper.h                  |  6 +++
>  target/arm/tcg/translate-a64.c       | 32 ++++++++++++
>  target/arm/tcg/translate.c           | 30 ++++++++++-
>  target/arm/tcg/translate.h           |  8 +++
>  target/i386/helper.h                 |  6 +++
>  target/i386/tcg/translate.c          | 20 ++++++++
>  target/i386/tcg/user/meson.build     |  1 +
>  target/i386/tcg/user/native_helper.c | 63 +++++++++++++++++++++++
>  target/mips/helper.h                 |  6 +++
>  target/mips/tcg/meson.build          |  1 +
>  target/mips/tcg/native_helper.c      | 55 ++++++++++++++++++++
>  target/mips/tcg/translate.c          | 22 +++++++-
>  19 files changed, 396 insertions(+), 3 deletions(-)
>  create mode 100644 include/exec/user/native-func.h
>  create mode 100644 libnative.c
>  create mode 100644 target/i386/tcg/user/native_helper.c
>  create mode 100644 target/mips/tcg/native_helper.c

I think this patch can certainly be split up. I think a good approach
would be:

  - introduce the build machinery (meson/configure)
  - add the libnative library
  - separate patch for each enabled architecture

there are also some additional patches needed:

  - one for linux-user and bsd-user to enable libnative
  - documentation patch
  - tests/tcg/multiarch tests

adding a test case might be a bit tricky as all tests are currently
statically linked. We will need something to create a temporary runtime
environment that we can populate with the libraries from either docker
or the installed cross compilers.

>
> diff --git a/include/exec/user/native-func.h b/include/exec/user/native-f=
unc.h
> new file mode 100644
> index 0000000000..8eaac03299
> --- /dev/null
> +++ b/include/exec/user/native-func.h
> @@ -0,0 +1,8 @@
> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
> +#define NATIVE_MEMCPY 0x1001
> +#define NATIVE_MEMCMP 0x1002
> +#define NATIVE_MEMSET 0x1003
> +#define NATIVE_STRCPY 0x1004
> +#define NATIVE_STRCMP 0x1005
> +#define NATIVE_STRCAT 0x1006
> +#endif /* CONFIG_USER_NATIVE_CALL */
> diff --git a/libnative.c b/libnative.c
> new file mode 100644
> index 0000000000..cc65c8270c
> --- /dev/null
> +++ b/libnative.c

This shouldn't be in the top level. Maybe common-user/native/libnative.c?

> @@ -0,0 +1,76 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#define NATIVE_MEMCPY 0x1001
> +#define NATIVE_MEMCMP 0x1002
> +#define NATIVE_MEMSET 0x1003
> +#define NATIVE_STRCPY 0x1004
> +#define NATIVE_STRCMP 0x1005
> +#define NATIVE_STRCAT 0x1006

We are duplicating information here and would need to keep things in
sync. I think we need a shared header where these defines can be kept.
But perhaps we could encode the function name in the "fake" instructions
to avoid hardcoding these?

QEMU could check the symbols resolve on translation (although probably
cached so we don't do it every time).

> +
> +void *memcpy(void *dest, const void *src, size_t n);
> +int memcmp(const void *s1, const void *s2, size_t n);
> +void *memset(void *s, int c, size_t n);
> +char *strcpy(char *dest, const char *src);
> +int strcmp(const char *s1, const char *s2);
> +char *strcat(char *dest, const char *src);
> +
> +#define STR_MACRO(str) #str
> +#define STR(num) STR_MACRO(num)
> +
> +#if defined(TARGET_X86_64) || defined(TARGET_I386)
> +
> +/* unused opcode */
> +#define __PREFIX_INSTR \
> +    ".byte 0x0f,0xff;"
> +
> +#define NATIVE_CALL_EXPR(func) \
> +    __PREFIX_INSTR             \
> +    ".word " STR(func) ";" : : :
> +#endif
> +
> +#if defined(TARGET_ARM) || defined(TARGET_AARCH64)
> +
> +/* unused syscall number */
> +#define __PREFIX_INSTR \
> +    "svc 0xff;"
> +
> +#define NATIVE_CALL_EXPR(func) \
> +    __PREFIX_INSTR             \
> +    ".word " STR(func) ";" : : :
> +
> +#endif
> +
> +#if defined(TARGET_MIPS) || defined(TARGET_MIPS64)
> +
> +/* unused bytes in syscall instructions */
> +#define NATIVE_CALL_EXPR(func) \
> +    ".long " STR((0x1 << 24) + (func << 8) + 0xC) ";" : : :
> +
> +#endif

I think the magic instruction encoding helpers belong in an include so
that others can build bindings for their own libraries. Given we also
have qemu-plugin.h perhaps a new directory under include/ where exported
interfaces can go.

> +
> +void *memcpy(void *dest, const void *src, size_t n)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCPY));
> +}
> +
> +int memcmp(const void *s1, const void *s2, size_t n)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCMP));
> +}
> +void *memset(void *s, int c, size_t n)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMSET));
> +}
> +char *strcpy(char *dest, const char *src)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCPY));
> +}
> +int strcmp(const char *s1, const char *s2)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCMP));
> +}
> +char *strcat(char *dest, const char *src)
> +{
> +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCAT));
> +}
> diff --git a/meson.build b/meson.build
> index 0a5cdefd4d..04e99a4f25 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2012,6 +2012,11 @@ have_virtfs_proxy_helper =3D get_option('virtfs_pr=
oxy_helper') \
>      .require(libcap_ng.found(), error_message: 'the virtfs proxy helper =
requires libcap-ng') \
>      .allowed()
>=20=20
> +have_user_native_call =3D get_option('user_native_call') \
> +    .require(have_user, error_message: 'user_native_call requires user')=
 \
> +    .require(targetos =3D=3D 'linux', error_message: 'user_native_call r=
equires Linux') \
> +    .allowed()
> +

This would probably be usable on bsd-user as well.

Warner,

What do you think?


>  if get_option('block_drv_ro_whitelist') =3D=3D ''
>    config_host_data.set('CONFIG_BDRV_RO_WHITELIST', '')
>  else
> @@ -2853,6 +2858,9 @@ foreach target : target_dirs
>        error('Target @0@ is only available on a Linux host'.format(target=
))
>      endif
>      config_target +=3D { 'CONFIG_LINUX_USER': 'y' }
> +    if have_user_native_call
> +      config_target +=3D { 'CONFIG_USER_NATIVE_CALL': 'y' }
> +    endif
>    elif target.endswith('bsd-user')
>      if 'CONFIG_BSD' not in config_host
>        if default_targets
> diff --git a/meson_options.txt b/meson_options.txt
> index 90237389e2..148dfc99d8 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -352,3 +352,5 @@ option('slirp_smbd', type : 'feature', value : 'auto',
>=20=20
>  option('hexagon_idef_parser', type : 'boolean', value : true,
>         description: 'use idef-parser to automatically generate TCG code =
for the Hexagon frontend')
> +option('user_native_call', type : 'feature', value : 'auto',
> +       description: 'use native code for user mode emulation')
> diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
> index 1892854261..cf2ba69949 100755
> --- a/scripts/make-config-poison.sh
> +++ b/scripts/make-config-poison.sh
> @@ -5,10 +5,12 @@ if test $# =3D 0; then
>  fi
>=20=20
>  # Create list of config switches that should be poisoned in common code.=
..
> -# but filter out CONFIG_TCG and CONFIG_USER_ONLY which are special.
> +# but filter out CONFIG_TCG, CONFIG_USER_ONLY and CONFIG_USER_NATIVE_CALL
> +# which are special.
>  exec sed -n \
>    -e' /CONFIG_TCG/d' \
>    -e '/CONFIG_USER_ONLY/d' \
> +  -e '/CONFIG_USER_NATIVE_CALL/d' \

Why do we want to filter out the poisoning of CONFIG_USER_NATIVE_CALL?

The poisoning of #defines is there to prevent accidentally polluting
common code with target specific stuff.=20

>    -e '/^#define / {' \
>    -e    's///' \
>    -e    's/ .*//' \
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 5714fd93d9..9e98db9eb7 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -173,6 +173,8 @@ meson_options_help() {
>    printf "%s\n" '  tpm             TPM support'
>    printf "%s\n" '  u2f             U2F emulation support'
>    printf "%s\n" '  usb-redir       libusbredir support'
> +  printf "%s\n" '  user-native-call'
> +  printf "%s\n" '                  use native code for user mode emulati=
on'
>    printf "%s\n" '  vde             vde network backend support'
>    printf "%s\n" '  vdi             vdi image format support'
>    printf "%s\n" '  vduse-blk-export'
> @@ -472,6 +474,8 @@ _meson_option_parse() {
>      --disable-u2f) printf "%s" -Du2f=3Ddisabled ;;
>      --enable-usb-redir) printf "%s" -Dusb_redir=3Denabled ;;
>      --disable-usb-redir) printf "%s" -Dusb_redir=3Ddisabled ;;
> +    --enable-user-native-call) printf "%s" -Duser_native_call=3Denabled =
;;
> +    --disable-user-native-call) printf "%s" -Duser_native_call=3Ddisable=
d ;;
>      --enable-vde) printf "%s" -Dvde=3Denabled ;;
>      --disable-vde) printf "%s" -Dvde=3Ddisabled ;;
>      --enable-vdi) printf "%s" -Dvdi=3Denabled ;;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0b7fd2e7e6..03fbc3724b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -25,6 +25,7 @@
>  #include "sysemu/tcg.h"
>  #include "qapi/error.h"
>  #include "qemu/guest-random.h"
> +#include "exec/cpu_ldst.h"
>  #ifdef CONFIG_TCG
>  #include "semihosting/common-semi.h"
>  #endif
> @@ -12045,3 +12046,49 @@ void aarch64_sve_change_el(CPUARMState *env, int=
 old_el,
>      }
>  }
>  #endif
> +
> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
> +
> +#define NATIVE_FN_W_3W()           \
> +    target_ulong arg0, arg1, arg2; \
> +    arg0 =3D env->regs[0];           \
> +    arg1 =3D env->regs[1];           \
> +    arg2 =3D env->regs[2];
> +
> +void helper_native_memcpy(CPUARMState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +    NATIVE_FN_W_3W();
> +    void *ret;
> +    void *dest =3D g2h(cs, arg0);
> +    void *src =3D g2h(cs, arg1);
> +    size_t n =3D (size_t)arg2;
> +    ret =3D memcpy(dest, src, n);
> +    env->regs[0] =3D (target_ulong)h2g(ret);
> +}

This is the easiest approach but not the most efficient. As all the
information is known at translation time we should be able to do an
equivalent operation to g2h in TCG ops and call memcpy directly and
fixup the result.

> +
> +void helper_native_memcmp(CPUARMState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +    NATIVE_FN_W_3W();
> +    int ret;
> +    void *s1 =3D g2h(cs, arg0);
> +    void *s2 =3D g2h(cs, arg1);
> +    size_t n =3D (size_t)arg2;
> +    ret =3D memcmp(s1, s2, n);
> +    env->regs[0] =3D ret;
> +}
> +
> +void helper_native_memset(CPUARMState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +    NATIVE_FN_W_3W();
> +    void *ret;
> +    void *s =3D g2h(cs, arg0);
> +    int c =3D (int)arg1;
> +    size_t n =3D (size_t)arg2;
> +    ret =3D memset(s, c, n);
> +    env->regs[0] =3D (target_ulong)h2g(ret);
> +}
> +
> +#endif
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 3335c2b10b..57144bf6fb 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -1038,6 +1038,12 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_s, TCG_CALL_NO_RWG,
>  DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, i32)
>=20=20
> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
> +DEF_HELPER_1(native_memcpy, void, env)
> +DEF_HELPER_1(native_memcmp, void, env)
> +DEF_HELPER_1(native_memset, void, env)
> +#endif
> +
>  #ifdef TARGET_AARCH64
>  #include "tcg/helper-a64.h"
>  #include "tcg/helper-sve.h"
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a6=
4.c
> index 741a608739..a0ae96a2fd 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -35,6 +35,7 @@
>  #include "cpregs.h"
>  #include "translate-a64.h"
>  #include "qemu/atomic128.h"
> +#include "exec/user/native-func.h"
>=20=20
>  static TCGv_i64 cpu_X[32];
>  static TCGv_i64 cpu_pc;
> @@ -42,6 +43,11 @@ static TCGv_i64 cpu_pc;
>  /* Load/store exclusive handling */
>  static TCGv_i64 cpu_exclusive_high;
>=20=20
> +#if defined(CONFIG_USER_ONLY) && defined(TARGET_AARCH64) && \
> +    defined(CONFIG_USER_NATIVE_CALL)
> +bool native_call_status;
> +#endif

DisasContext is the best place to store these values rather than a file
local global. The translator can be multi-threaded so you might race on
this variable.

> +
>  static const char *regnames[] =3D {
>      "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7",
>      "x8", "x9", "x10", "x11", "x12", "x13", "x14", "x15",
> @@ -2292,6 +2298,12 @@ static void disas_exc(DisasContext *s, uint32_t in=
sn)
>                  gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
>                  break;
>              }
> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
> +            else if (imm16 =3D=3D 0xff) {
> +                native_call_status =3D true;
> +                break;
> +            }
> +#endif

We need this to be explicitly opt in so if the user hasn't enabled this
the illegal operations still fault. With a helper we could avoid too
much #ifdef uglyness, something like:

            } else if (native_bypass() && imm16 =3D 0xff) {
                s->native_call_status =3D true;
                break;
            }

see semihosting_enabled() for an example.

>              gen_ss_advance(s);
>              gen_exception_insn(s, 4, EXCP_SWI, syndrome);
>              break;
> @@ -14203,6 +14215,26 @@ static void aarch64_tr_translate_insn(DisasConte=
xtBase *dcbase, CPUState *cpu)
>      s->fp_access_checked =3D false;
>      s->sve_access_checked =3D false;
>=20=20
> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
> +    if (native_call_status) {
> +        switch (insn) {
> +        case NATIVE_MEMCPY:
> +            gen_helper_native_memcpy(cpu_env);
> +            break;
> +        case NATIVE_MEMCMP:
> +            gen_helper_native_memcmp(cpu_env);
> +            break;
> +        case NATIVE_MEMSET:
> +            gen_helper_native_memset(cpu_env);
> +            break;
> +        default:
> +            unallocated_encoding(s);
> +        }
> +        native_call_status =3D false;
> +        return;
> +    }
> +#endif
> +

Also why defer the helper handling here rather than do it in place?

<snip>

Similar comments for the other frontends.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


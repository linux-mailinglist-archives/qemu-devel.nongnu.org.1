Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB92A718B17
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:24:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SMJ-0006Cp-6d; Wed, 31 May 2023 16:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1q4SMG-0005zv-Iw
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:23:48 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1q4SMC-0000pi-Jv
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:23:48 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-96fbe7fbdd4so1082207766b.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1685564622; x=1688156622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TweYoSamxNY5W+qOMsCg3Lsvzokgps9in6e47cVfMak=;
 b=HHUdqo5pczap2bAscQJbgTlRGbt6oJA3UpihuO+dPjOKowXBupXtN8FJoq5v18VQX+
 amhIysolW5sbHS+CDrhHU1GTNCAR5KM1gswJdRI9Z2E9XcJpirHTvVP7hKxDvbIQsKel
 /ed8Izu3g4dglh/ZVdGulRfzUPqCkALqrpQO4nY1eo557hrhbaAaAqaIkggdUH1k/wCJ
 km3u0OhC+ZA8HjGtHijVaI9Xtc65EPKoi3EAL80vSs9/uYd8+i+Nmtg4kV2QSqmneyuy
 PbwML/lm3r5CqSHisHiNSI2puy4qIGkJVqAXoFjNHpzYg7jqMz/HaSv//V4xy4VQCVbR
 TzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685564622; x=1688156622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TweYoSamxNY5W+qOMsCg3Lsvzokgps9in6e47cVfMak=;
 b=OOE8aH9zUQXBueYsjgOkDIASJU8tg66fqKIOmH6IAEA+5g7siupkeHVszFyUhYNQ+k
 qftbb5corhYTO/aRF8xRZ2qXAhK2eOwwheCNJM48I/xsJ+kKyBYYMKdMciyvoYBogUQO
 r81Q6GdaGdpAp8Hp3XNU1Nu7/JLNEhs8Rzszcb1Ge3fq2WhVeiFDxurxjQA8fVfPgdLM
 +TV30yhBH6KxxOtLH2oLvhV6b1MGDNh9JrX6Tb0xipltTVnpwWzaZXku8nKD5Od4M/6/
 lvdqS5pf1DwC0SOcXZL13ceaxaNYWBQ4yVqqqxV1pDLkKhJcBg7zSqP4r++pdwqZveol
 GIpQ==
X-Gm-Message-State: AC+VfDwq8QYlQgb6eX4BxmJd0dH5Xqm7oBUNShftcnFONDRbshyo44h8
 uDHv16ft2ndNpdlZ/BaOcn+OL4oGm2F1jd8gF+1qhA==
X-Google-Smtp-Source: ACHHUZ6KypmCOIxc9WUozp3cqEOZIsHzYR67Cr2KshRyzyooOK9BxYiDxdx8Tn4Zhah3BUti/hFYi1eYgtcG1KuF81A=
X-Received: by 2002:a17:907:1b09:b0:961:a67:29c with SMTP id
 mp9-20020a1709071b0900b009610a67029cmr5513404ejc.70.1685564621995; Wed, 31
 May 2023 13:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230530142430.45834-1-fufuyqqqqqq@gmail.com>
 <87v8g9c4uu.fsf@linaro.org>
In-Reply-To: <87v8g9c4uu.fsf@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 31 May 2023 14:23:30 -0600
Message-ID: <CANCZdfpNGXh+c3mnDPtTuPdZ+oDTH=-7FSXrmqUGx2fWfsobRA@mail.gmail.com>
Subject: Re: [RFC] Native Library Calls
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Yeqi Fu <fufuyqqqqqq@gmail.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008a559c05fd03187a"
Received-SPF: none client-ip=2a00:1450:4864:20::634;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--0000000000008a559c05fd03187a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 1:55=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

>
> Yeqi Fu <fufuyqqqqqq@gmail.com> writes:
>
> > This patch introduces a set of feature instructions for native calls
> > and provides helpers to translate these instructions to corresponding
> > native functions. A shared library is also implemented, where native
> > functions are rewritten as feature instructions. At runtime, user
> > programs load the shared library, and feature instructions are
> > executed when native functions are called. This patch is applicable
> > to user programs with architectures x86, x86_64, arm, aarch64, mips,
> > and mips64. To build, compile libnative.c into a shared library for
> > the user program's architecture and run the
> > '../configure --enable-user-native-call && make' command.
> >
> > Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> > ---
> >  include/exec/user/native-func.h      |  8 +++
> >  libnative.c                          | 76 ++++++++++++++++++++++++++++
> >  meson.build                          |  8 +++
> >  meson_options.txt                    |  2 +
> >  scripts/make-config-poison.sh        |  4 +-
> >  scripts/meson-buildoptions.sh        |  4 ++
> >  target/arm/helper.c                  | 47 +++++++++++++++++
> >  target/arm/helper.h                  |  6 +++
> >  target/arm/tcg/translate-a64.c       | 32 ++++++++++++
> >  target/arm/tcg/translate.c           | 30 ++++++++++-
> >  target/arm/tcg/translate.h           |  8 +++
> >  target/i386/helper.h                 |  6 +++
> >  target/i386/tcg/translate.c          | 20 ++++++++
> >  target/i386/tcg/user/meson.build     |  1 +
> >  target/i386/tcg/user/native_helper.c | 63 +++++++++++++++++++++++
> >  target/mips/helper.h                 |  6 +++
> >  target/mips/tcg/meson.build          |  1 +
> >  target/mips/tcg/native_helper.c      | 55 ++++++++++++++++++++
> >  target/mips/tcg/translate.c          | 22 +++++++-
> >  19 files changed, 396 insertions(+), 3 deletions(-)
> >  create mode 100644 include/exec/user/native-func.h
> >  create mode 100644 libnative.c
> >  create mode 100644 target/i386/tcg/user/native_helper.c
> >  create mode 100644 target/mips/tcg/native_helper.c
>
> I think this patch can certainly be split up. I think a good approach
> would be:
>
>   - introduce the build machinery (meson/configure)
>   - add the libnative library
>   - separate patch for each enabled architecture
>
> there are also some additional patches needed:
>
>   - one for linux-user and bsd-user to enable libnative
>   - documentation patch
>   - tests/tcg/multiarch tests
>
> adding a test case might be a bit tricky as all tests are currently
> statically linked. We will need something to create a temporary runtime
> environment that we can populate with the libraries from either docker
> or the installed cross compilers.
>
> >
> > diff --git a/include/exec/user/native-func.h
> b/include/exec/user/native-func.h
> > new file mode 100644
> > index 0000000000..8eaac03299
> > --- /dev/null
> > +++ b/include/exec/user/native-func.h
> > @@ -0,0 +1,8 @@
> > +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
> > +#define NATIVE_MEMCPY 0x1001
> > +#define NATIVE_MEMCMP 0x1002
> > +#define NATIVE_MEMSET 0x1003
> > +#define NATIVE_STRCPY 0x1004
> > +#define NATIVE_STRCMP 0x1005
> > +#define NATIVE_STRCAT 0x1006
> > +#endif /* CONFIG_USER_NATIVE_CALL */
> > diff --git a/libnative.c b/libnative.c
> > new file mode 100644
> > index 0000000000..cc65c8270c
> > --- /dev/null
> > +++ b/libnative.c
>
> This shouldn't be in the top level. Maybe common-user/native/libnative.c?
>
> > @@ -0,0 +1,76 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> > +#define NATIVE_MEMCPY 0x1001
> > +#define NATIVE_MEMCMP 0x1002
> > +#define NATIVE_MEMSET 0x1003
> > +#define NATIVE_STRCPY 0x1004
> > +#define NATIVE_STRCMP 0x1005
> > +#define NATIVE_STRCAT 0x1006
>
> We are duplicating information here and would need to keep things in
> sync. I think we need a shared header where these defines can be kept.
> But perhaps we could encode the function name in the "fake" instructions
> to avoid hardcoding these?
>
> QEMU could check the symbols resolve on translation (although probably
> cached so we don't do it every time).
>
> > +
> > +void *memcpy(void *dest, const void *src, size_t n);
> > +int memcmp(const void *s1, const void *s2, size_t n);
> > +void *memset(void *s, int c, size_t n);
> > +char *strcpy(char *dest, const char *src);
> > +int strcmp(const char *s1, const char *s2);
> > +char *strcat(char *dest, const char *src);
> > +
> > +#define STR_MACRO(str) #str
> > +#define STR(num) STR_MACRO(num)
> > +
> > +#if defined(TARGET_X86_64) || defined(TARGET_I386)
> > +
> > +/* unused opcode */
> > +#define __PREFIX_INSTR \
> > +    ".byte 0x0f,0xff;"
> > +
> > +#define NATIVE_CALL_EXPR(func) \
> > +    __PREFIX_INSTR             \
> > +    ".word " STR(func) ";" : : :
> > +#endif
> > +
> > +#if defined(TARGET_ARM) || defined(TARGET_AARCH64)
> > +
> > +/* unused syscall number */
> > +#define __PREFIX_INSTR \
> > +    "svc 0xff;"
> > +
> > +#define NATIVE_CALL_EXPR(func) \
> > +    __PREFIX_INSTR             \
> > +    ".word " STR(func) ";" : : :
> > +
> > +#endif
> > +
> > +#if defined(TARGET_MIPS) || defined(TARGET_MIPS64)
> > +
> > +/* unused bytes in syscall instructions */
> > +#define NATIVE_CALL_EXPR(func) \
> > +    ".long " STR((0x1 << 24) + (func << 8) + 0xC) ";" : : :
> > +
> > +#endif
>
> I think the magic instruction encoding helpers belong in an include so
> that others can build bindings for their own libraries. Given we also
> have qemu-plugin.h perhaps a new directory under include/ where exported
> interfaces can go.
>
> > +
> > +void *memcpy(void *dest, const void *src, size_t n)
> > +{
> > +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCPY));
> > +}
> > +
> > +int memcmp(const void *s1, const void *s2, size_t n)
> > +{
> > +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCMP));
> > +}
> > +void *memset(void *s, int c, size_t n)
> > +{
> > +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMSET));
> > +}
> > +char *strcpy(char *dest, const char *src)
> > +{
> > +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCPY));
> > +}
> > +int strcmp(const char *s1, const char *s2)
> > +{
> > +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCMP));
> > +}
> > +char *strcat(char *dest, const char *src)
> > +{
> > +    __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCAT));
> > +}
> > diff --git a/meson.build b/meson.build
> > index 0a5cdefd4d..04e99a4f25 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2012,6 +2012,11 @@ have_virtfs_proxy_helper =3D
> get_option('virtfs_proxy_helper') \
> >      .require(libcap_ng.found(), error_message: 'the virtfs proxy helpe=
r
> requires libcap-ng') \
> >      .allowed()
> >
> > +have_user_native_call =3D get_option('user_native_call') \
> > +    .require(have_user, error_message: 'user_native_call requires
> user') \
> > +    .require(targetos =3D=3D 'linux', error_message: 'user_native_call
> requires Linux') \
> > +    .allowed()
> > +
>
> This would probably be usable on bsd-user as well.
>
> Warner,
>
> What do you think?
>

I think it would be interesting, especially if we can see good speed
improvements from
these bulk operations. I'd be willing to give it a try, though I'm unsure
how tuned to the
Linux code this detection actually is...

Warner


> >  if get_option('block_drv_ro_whitelist') =3D=3D ''
> >    config_host_data.set('CONFIG_BDRV_RO_WHITELIST', '')
> >  else
> > @@ -2853,6 +2858,9 @@ foreach target : target_dirs
> >        error('Target @0@ is only available on a Linux
> host'.format(target))
> >      endif
> >      config_target +=3D { 'CONFIG_LINUX_USER': 'y' }
> > +    if have_user_native_call
> > +      config_target +=3D { 'CONFIG_USER_NATIVE_CALL': 'y' }
> > +    endif
> >    elif target.endswith('bsd-user')
> >      if 'CONFIG_BSD' not in config_host
> >        if default_targets
> > diff --git a/meson_options.txt b/meson_options.txt
> > index 90237389e2..148dfc99d8 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -352,3 +352,5 @@ option('slirp_smbd', type : 'feature', value :
> 'auto',
> >
> >  option('hexagon_idef_parser', type : 'boolean', value : true,
> >         description: 'use idef-parser to automatically generate TCG cod=
e
> for the Hexagon frontend')
> > +option('user_native_call', type : 'feature', value : 'auto',
> > +       description: 'use native code for user mode emulation')
> > diff --git a/scripts/make-config-poison.sh
> b/scripts/make-config-poison.sh
> > index 1892854261..cf2ba69949 100755
> > --- a/scripts/make-config-poison.sh
> > +++ b/scripts/make-config-poison.sh
> > @@ -5,10 +5,12 @@ if test $# =3D 0; then
> >  fi
> >
> >  # Create list of config switches that should be poisoned in common
> code...
> > -# but filter out CONFIG_TCG and CONFIG_USER_ONLY which are special.
> > +# but filter out CONFIG_TCG, CONFIG_USER_ONLY and
> CONFIG_USER_NATIVE_CALL
> > +# which are special.
> >  exec sed -n \
> >    -e' /CONFIG_TCG/d' \
> >    -e '/CONFIG_USER_ONLY/d' \
> > +  -e '/CONFIG_USER_NATIVE_CALL/d' \
>
> Why do we want to filter out the poisoning of CONFIG_USER_NATIVE_CALL?
>
> The poisoning of #defines is there to prevent accidentally polluting
> common code with target specific stuff.
>
> >    -e '/^#define / {' \
> >    -e    's///' \
> >    -e    's/ .*//' \
> > diff --git a/scripts/meson-buildoptions.sh
> b/scripts/meson-buildoptions.sh
> > index 5714fd93d9..9e98db9eb7 100644
> > --- a/scripts/meson-buildoptions.sh
> > +++ b/scripts/meson-buildoptions.sh
> > @@ -173,6 +173,8 @@ meson_options_help() {
> >    printf "%s\n" '  tpm             TPM support'
> >    printf "%s\n" '  u2f             U2F emulation support'
> >    printf "%s\n" '  usb-redir       libusbredir support'
> > +  printf "%s\n" '  user-native-call'
> > +  printf "%s\n" '                  use native code for user mode
> emulation'
> >    printf "%s\n" '  vde             vde network backend support'
> >    printf "%s\n" '  vdi             vdi image format support'
> >    printf "%s\n" '  vduse-blk-export'
> > @@ -472,6 +474,8 @@ _meson_option_parse() {
> >      --disable-u2f) printf "%s" -Du2f=3Ddisabled ;;
> >      --enable-usb-redir) printf "%s" -Dusb_redir=3Denabled ;;
> >      --disable-usb-redir) printf "%s" -Dusb_redir=3Ddisabled ;;
> > +    --enable-user-native-call) printf "%s" -Duser_native_call=3Denable=
d ;;
> > +    --disable-user-native-call) printf "%s" -Duser_native_call=3Ddisab=
led
> ;;
> >      --enable-vde) printf "%s" -Dvde=3Denabled ;;
> >      --disable-vde) printf "%s" -Dvde=3Ddisabled ;;
> >      --enable-vdi) printf "%s" -Dvdi=3Denabled ;;
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 0b7fd2e7e6..03fbc3724b 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -25,6 +25,7 @@
> >  #include "sysemu/tcg.h"
> >  #include "qapi/error.h"
> >  #include "qemu/guest-random.h"
> > +#include "exec/cpu_ldst.h"
> >  #ifdef CONFIG_TCG
> >  #include "semihosting/common-semi.h"
> >  #endif
> > @@ -12045,3 +12046,49 @@ void aarch64_sve_change_el(CPUARMState *env,
> int old_el,
> >      }
> >  }
> >  #endif
> > +
> > +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
> > +
> > +#define NATIVE_FN_W_3W()           \
> > +    target_ulong arg0, arg1, arg2; \
> > +    arg0 =3D env->regs[0];           \
> > +    arg1 =3D env->regs[1];           \
> > +    arg2 =3D env->regs[2];
> > +
> > +void helper_native_memcpy(CPUARMState *env)
> > +{
> > +    CPUState *cs =3D env_cpu(env);
> > +    NATIVE_FN_W_3W();
> > +    void *ret;
> > +    void *dest =3D g2h(cs, arg0);
> > +    void *src =3D g2h(cs, arg1);
> > +    size_t n =3D (size_t)arg2;
> > +    ret =3D memcpy(dest, src, n);
> > +    env->regs[0] =3D (target_ulong)h2g(ret);
> > +}
>
> This is the easiest approach but not the most efficient. As all the
> information is known at translation time we should be able to do an
> equivalent operation to g2h in TCG ops and call memcpy directly and
> fixup the result.
>
> > +
> > +void helper_native_memcmp(CPUARMState *env)
> > +{
> > +    CPUState *cs =3D env_cpu(env);
> > +    NATIVE_FN_W_3W();
> > +    int ret;
> > +    void *s1 =3D g2h(cs, arg0);
> > +    void *s2 =3D g2h(cs, arg1);
> > +    size_t n =3D (size_t)arg2;
> > +    ret =3D memcmp(s1, s2, n);
> > +    env->regs[0] =3D ret;
> > +}
> > +
> > +void helper_native_memset(CPUARMState *env)
> > +{
> > +    CPUState *cs =3D env_cpu(env);
> > +    NATIVE_FN_W_3W();
> > +    void *ret;
> > +    void *s =3D g2h(cs, arg0);
> > +    int c =3D (int)arg1;
> > +    size_t n =3D (size_t)arg2;
> > +    ret =3D memset(s, c, n);
> > +    env->regs[0] =3D (target_ulong)h2g(ret);
> > +}
> > +
> > +#endif
> > diff --git a/target/arm/helper.h b/target/arm/helper.h
> > index 3335c2b10b..57144bf6fb 100644
> > --- a/target/arm/helper.h
> > +++ b/target/arm/helper.h
> > @@ -1038,6 +1038,12 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_s, TCG_CALL_NO_RW=
G,
> >  DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
> >                     void, ptr, ptr, ptr, ptr, i32)
> >
> > +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
> > +DEF_HELPER_1(native_memcpy, void, env)
> > +DEF_HELPER_1(native_memcmp, void, env)
> > +DEF_HELPER_1(native_memset, void, env)
> > +#endif
> > +
> >  #ifdef TARGET_AARCH64
> >  #include "tcg/helper-a64.h"
> >  #include "tcg/helper-sve.h"
> > diff --git a/target/arm/tcg/translate-a64.c
> b/target/arm/tcg/translate-a64.c
> > index 741a608739..a0ae96a2fd 100644
> > --- a/target/arm/tcg/translate-a64.c
> > +++ b/target/arm/tcg/translate-a64.c
> > @@ -35,6 +35,7 @@
> >  #include "cpregs.h"
> >  #include "translate-a64.h"
> >  #include "qemu/atomic128.h"
> > +#include "exec/user/native-func.h"
> >
> >  static TCGv_i64 cpu_X[32];
> >  static TCGv_i64 cpu_pc;
> > @@ -42,6 +43,11 @@ static TCGv_i64 cpu_pc;
> >  /* Load/store exclusive handling */
> >  static TCGv_i64 cpu_exclusive_high;
> >
> > +#if defined(CONFIG_USER_ONLY) && defined(TARGET_AARCH64) && \
> > +    defined(CONFIG_USER_NATIVE_CALL)
> > +bool native_call_status;
> > +#endif
>
> DisasContext is the best place to store these values rather than a file
> local global. The translator can be multi-threaded so you might race on
> this variable.
>
> > +
> >  static const char *regnames[] =3D {
> >      "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7",
> >      "x8", "x9", "x10", "x11", "x12", "x13", "x14", "x15",
> > @@ -2292,6 +2298,12 @@ static void disas_exc(DisasContext *s, uint32_t
> insn)
> >                  gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
> >                  break;
> >              }
> > +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
> > +            else if (imm16 =3D=3D 0xff) {
> > +                native_call_status =3D true;
> > +                break;
> > +            }
> > +#endif
>
> We need this to be explicitly opt in so if the user hasn't enabled this
> the illegal operations still fault. With a helper we could avoid too
> much #ifdef uglyness, something like:
>
>             } else if (native_bypass() && imm16 =3D 0xff) {
>                 s->native_call_status =3D true;
>                 break;
>             }
>
> see semihosting_enabled() for an example.
>
> >              gen_ss_advance(s);
> >              gen_exception_insn(s, 4, EXCP_SWI, syndrome);
> >              break;
> > @@ -14203,6 +14215,26 @@ static void
> aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
> >      s->fp_access_checked =3D false;
> >      s->sve_access_checked =3D false;
> >
> > +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
> > +    if (native_call_status) {
> > +        switch (insn) {
> > +        case NATIVE_MEMCPY:
> > +            gen_helper_native_memcpy(cpu_env);
> > +            break;
> > +        case NATIVE_MEMCMP:
> > +            gen_helper_native_memcmp(cpu_env);
> > +            break;
> > +        case NATIVE_MEMSET:
> > +            gen_helper_native_memset(cpu_env);
> > +            break;
> > +        default:
> > +            unallocated_encoding(s);
> > +        }
> > +        native_call_status =3D false;
> > +        return;
> > +    }
> > +#endif
> > +
>
> Also why defer the helper handling here rather than do it in place?
>
> <snip>
>
> Similar comments for the other frontends.
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000008a559c05fd03187a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 31, 2023 at 1:55=E2=80=AF=
AM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.benn=
ee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><br>
Yeqi Fu &lt;<a href=3D"mailto:fufuyqqqqqq@gmail.com" target=3D"_blank">fufu=
yqqqqqq@gmail.com</a>&gt; writes:<br>
<br>
&gt; This patch introduces a set of feature instructions for native calls<b=
r>
&gt; and provides helpers to translate these instructions to corresponding<=
br>
&gt; native functions. A shared library is also implemented, where native<b=
r>
&gt; functions are rewritten as feature instructions. At runtime, user<br>
&gt; programs load the shared library, and feature instructions are<br>
&gt; executed when native functions are called. This patch is applicable<br=
>
&gt; to user programs with architectures x86, x86_64, arm, aarch64, mips,<b=
r>
&gt; and mips64. To build, compile libnative.c into a shared library for<br=
>
&gt; the user program&#39;s architecture and run the<br>
&gt; &#39;../configure --enable-user-native-call &amp;&amp; make&#39; comma=
nd.<br>
&gt;<br>
&gt; Signed-off-by: Yeqi Fu &lt;<a href=3D"mailto:fufuyqqqqqq@gmail.com" ta=
rget=3D"_blank">fufuyqqqqqq@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/exec/user/native-func.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++=
+<br>
&gt;=C2=A0 libnative.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 76 ++++++++++++++++++++++++++++<br=
>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +++<br>
&gt;=C2=A0 meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +<br>
&gt;=C2=A0 scripts/make-config-poison.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 4 +-<br>
&gt;=C2=A0 scripts/meson-buildoptions.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 4 ++<br>
&gt;=C2=A0 target/arm/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 47 +++++++++++++++++<br>
&gt;=C2=A0 target/arm/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 6 +++<br>
&gt;=C2=A0 target/arm/tcg/translate-a64.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 32 ++=
++++++++++<br>
&gt;=C2=A0 target/arm/tcg/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 30 ++++++++++-<br>
&gt;=C2=A0 target/arm/tcg/translate.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 8 +++<br>
&gt;=C2=A0 target/i386/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++<br>
&gt;=C2=A0 target/i386/tcg/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
20 ++++++++<br>
&gt;=C2=A0 target/i386/tcg/user/meson.build=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<=
br>
&gt;=C2=A0 target/i386/tcg/user/native_helper.c | 63 ++++++++++++++++++++++=
+<br>
&gt;=C2=A0 target/mips/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++<br>
&gt;=C2=A0 target/mips/tcg/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
&gt;=C2=A0 target/mips/tcg/native_helper.c=C2=A0 =C2=A0 =C2=A0 | 55 +++++++=
+++++++++++++<br>
&gt;=C2=A0 target/mips/tcg/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
22 +++++++-<br>
&gt;=C2=A0 19 files changed, 396 insertions(+), 3 deletions(-)<br>
&gt;=C2=A0 create mode 100644 include/exec/user/native-func.h<br>
&gt;=C2=A0 create mode 100644 libnative.c<br>
&gt;=C2=A0 create mode 100644 target/i386/tcg/user/native_helper.c<br>
&gt;=C2=A0 create mode 100644 target/mips/tcg/native_helper.c<br>
<br>
I think this patch can certainly be split up. I think a good approach<br>
would be:<br>
<br>
=C2=A0 - introduce the build machinery (meson/configure)<br>
=C2=A0 - add the libnative library<br>
=C2=A0 - separate patch for each enabled architecture<br>
<br>
there are also some additional patches needed:<br>
<br>
=C2=A0 - one for linux-user and bsd-user to enable libnative<br>
=C2=A0 - documentation patch<br>
=C2=A0 - tests/tcg/multiarch tests<br>
<br>
adding a test case might be a bit tricky as all tests are currently<br>
statically linked. We will need something to create a temporary runtime<br>
environment that we can populate with the libraries from either docker<br>
or the installed cross compilers.<br>
<br>
&gt;<br>
&gt; diff --git a/include/exec/user/native-func.h b/include/exec/user/nativ=
e-func.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..8eaac03299<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/exec/user/native-func.h<br>
&gt; @@ -0,0 +1,8 @@<br>
&gt; +#if defined(CONFIG_USER_ONLY)=C2=A0 &amp;&amp; defined(CONFIG_USER_NA=
TIVE_CALL)<br>
&gt; +#define NATIVE_MEMCPY 0x1001<br>
&gt; +#define NATIVE_MEMCMP 0x1002<br>
&gt; +#define NATIVE_MEMSET 0x1003<br>
&gt; +#define NATIVE_STRCPY 0x1004<br>
&gt; +#define NATIVE_STRCMP 0x1005<br>
&gt; +#define NATIVE_STRCAT 0x1006<br>
&gt; +#endif /* CONFIG_USER_NATIVE_CALL */<br>
&gt; diff --git a/libnative.c b/libnative.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..cc65c8270c<br>
&gt; --- /dev/null<br>
&gt; +++ b/libnative.c<br>
<br>
This shouldn&#39;t be in the top level. Maybe common-user/native/libnative.=
c?<br>
<br>
&gt; @@ -0,0 +1,76 @@<br>
&gt; +#include &lt;stdio.h&gt;<br>
&gt; +#include &lt;stdlib.h&gt;<br>
&gt; +<br>
&gt; +#define NATIVE_MEMCPY 0x1001<br>
&gt; +#define NATIVE_MEMCMP 0x1002<br>
&gt; +#define NATIVE_MEMSET 0x1003<br>
&gt; +#define NATIVE_STRCPY 0x1004<br>
&gt; +#define NATIVE_STRCMP 0x1005<br>
&gt; +#define NATIVE_STRCAT 0x1006<br>
<br>
We are duplicating information here and would need to keep things in<br>
sync. I think we need a shared header where these defines can be kept.<br>
But perhaps we could encode the function name in the &quot;fake&quot; instr=
uctions<br>
to avoid hardcoding these?<br>
<br>
QEMU could check the symbols resolve on translation (although probably<br>
cached so we don&#39;t do it every time).<br>
<br>
&gt; +<br>
&gt; +void *memcpy(void *dest, const void *src, size_t n);<br>
&gt; +int memcmp(const void *s1, const void *s2, size_t n);<br>
&gt; +void *memset(void *s, int c, size_t n);<br>
&gt; +char *strcpy(char *dest, const char *src);<br>
&gt; +int strcmp(const char *s1, const char *s2);<br>
&gt; +char *strcat(char *dest, const char *src);<br>
&gt; +<br>
&gt; +#define STR_MACRO(str) #str<br>
&gt; +#define STR(num) STR_MACRO(num)<br>
&gt; +<br>
&gt; +#if defined(TARGET_X86_64) || defined(TARGET_I386)<br>
&gt; +<br>
&gt; +/* unused opcode */<br>
&gt; +#define __PREFIX_INSTR \<br>
&gt; +=C2=A0 =C2=A0 &quot;.byte 0x0f,0xff;&quot;<br>
&gt; +<br>
&gt; +#define NATIVE_CALL_EXPR(func) \<br>
&gt; +=C2=A0 =C2=A0 __PREFIX_INSTR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 &quot;.word &quot; STR(func) &quot;;&quot; : : :<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +#if defined(TARGET_ARM) || defined(TARGET_AARCH64)<br>
&gt; +<br>
&gt; +/* unused syscall number */<br>
&gt; +#define __PREFIX_INSTR \<br>
&gt; +=C2=A0 =C2=A0 &quot;svc 0xff;&quot;<br>
&gt; +<br>
&gt; +#define NATIVE_CALL_EXPR(func) \<br>
&gt; +=C2=A0 =C2=A0 __PREFIX_INSTR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 &quot;.word &quot; STR(func) &quot;;&quot; : : :<br>
&gt; +<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +#if defined(TARGET_MIPS) || defined(TARGET_MIPS64)<br>
&gt; +<br>
&gt; +/* unused bytes in syscall instructions */<br>
&gt; +#define NATIVE_CALL_EXPR(func) \<br>
&gt; +=C2=A0 =C2=A0 &quot;.long &quot; STR((0x1 &lt;&lt; 24) + (func &lt;&l=
t; 8) + 0xC) &quot;;&quot; : : :<br>
&gt; +<br>
&gt; +#endif<br>
<br>
I think the magic instruction encoding helpers belong in an include so<br>
that others can build bindings for their own libraries. Given we also<br>
have qemu-plugin.h perhaps a new directory under include/ where exported<br=
>
interfaces can go.<br>
<br>
&gt; +<br>
&gt; +void *memcpy(void *dest, const void *src, size_t n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCPY));<br>
&gt; +}<br>
&gt; +<br>
&gt; +int memcmp(const void *s1, const void *s2, size_t n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMCMP));<br>
&gt; +}<br>
&gt; +void *memset(void *s, int c, size_t n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_MEMSET));<br>
&gt; +}<br>
&gt; +char *strcpy(char *dest, const char *src)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCPY));<br>
&gt; +}<br>
&gt; +int strcmp(const char *s1, const char *s2)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCMP));<br>
&gt; +}<br>
&gt; +char *strcat(char *dest, const char *src)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 __asm__ volatile(NATIVE_CALL_EXPR(NATIVE_STRCAT));<br>
&gt; +}<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index 0a5cdefd4d..04e99a4f25 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -2012,6 +2012,11 @@ have_virtfs_proxy_helper =3D get_option(&#39;vi=
rtfs_proxy_helper&#39;) \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .require(libcap_ng.found(), error_message: &#39;th=
e virtfs proxy helper requires libcap-ng&#39;) \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .allowed()<br>
&gt;=C2=A0 <br>
&gt; +have_user_native_call =3D get_option(&#39;user_native_call&#39;) \<br=
>
&gt; +=C2=A0 =C2=A0 .require(have_user, error_message: &#39;user_native_cal=
l requires user&#39;) \<br>
&gt; +=C2=A0 =C2=A0 .require(targetos =3D=3D &#39;linux&#39;, error_message=
: &#39;user_native_call requires Linux&#39;) \<br>
&gt; +=C2=A0 =C2=A0 .allowed()<br>
&gt; +<br>
<br>
This would probably be usable on bsd-user as well.<br>
<br>
Warner,<br>
<br>
What do you think?<br></blockquote><div><br></div><div>I think it would be =
interesting, especially if we can see good speed improvements from</div><di=
v>these bulk operations. I&#39;d be willing to give it a try, though I&#39;=
m unsure how tuned to the</div><div>Linux code this detection actually is..=
.</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt;=C2=A0 if get_option(&#39;block_drv_ro_whitelist&#39;) =3D=3D &#39;&#39=
;<br>
&gt;=C2=A0 =C2=A0 config_host_data.set(&#39;CONFIG_BDRV_RO_WHITELIST&#39;, =
&#39;&#39;)<br>
&gt;=C2=A0 else<br>
&gt; @@ -2853,6 +2858,9 @@ foreach target : target_dirs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 error(&#39;Target @0@ is only available on =
a Linux host&#39;.format(target))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 config_target +=3D { &#39;CONFIG_LINUX_USER&#39;: =
&#39;y&#39; }<br>
&gt; +=C2=A0 =C2=A0 if have_user_native_call<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 config_target +=3D { &#39;CONFIG_USER_NATIVE_CAL=
L&#39;: &#39;y&#39; }<br>
&gt; +=C2=A0 =C2=A0 endif<br>
&gt;=C2=A0 =C2=A0 elif target.endswith(&#39;bsd-user&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if &#39;CONFIG_BSD&#39; not in config_host<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 if default_targets<br>
&gt; diff --git a/meson_options.txt b/meson_options.txt<br>
&gt; index 90237389e2..148dfc99d8 100644<br>
&gt; --- a/meson_options.txt<br>
&gt; +++ b/meson_options.txt<br>
&gt; @@ -352,3 +352,5 @@ option(&#39;slirp_smbd&#39;, type : &#39;feature&#=
39;, value : &#39;auto&#39;,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 option(&#39;hexagon_idef_parser&#39;, type : &#39;boolean&#39;, =
value : true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;use idef-parser to =
automatically generate TCG code for the Hexagon frontend&#39;)<br>
&gt; +option(&#39;user_native_call&#39;, type : &#39;feature&#39;, value : =
&#39;auto&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;use native code for user=
 mode emulation&#39;)<br>
&gt; diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poiso=
n.sh<br>
&gt; index 1892854261..cf2ba69949 100755<br>
&gt; --- a/scripts/make-config-poison.sh<br>
&gt; +++ b/scripts/make-config-poison.sh<br>
&gt; @@ -5,10 +5,12 @@ if test $# =3D 0; then<br>
&gt;=C2=A0 fi<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Create list of config switches that should be poisoned in comm=
on code...<br>
&gt; -# but filter out CONFIG_TCG and CONFIG_USER_ONLY which are special.<b=
r>
&gt; +# but filter out CONFIG_TCG, CONFIG_USER_ONLY and CONFIG_USER_NATIVE_=
CALL<br>
&gt; +# which are special.<br>
&gt;=C2=A0 exec sed -n \<br>
&gt;=C2=A0 =C2=A0 -e&#39; /CONFIG_TCG/d&#39; \<br>
&gt;=C2=A0 =C2=A0 -e &#39;/CONFIG_USER_ONLY/d&#39; \<br>
&gt; +=C2=A0 -e &#39;/CONFIG_USER_NATIVE_CALL/d&#39; \<br>
<br>
Why do we want to filter out the poisoning of CONFIG_USER_NATIVE_CALL?<br>
<br>
The poisoning of #defines is there to prevent accidentally polluting<br>
common code with target specific stuff. <br>
<br>
&gt;=C2=A0 =C2=A0 -e &#39;/^#define / {&#39; \<br>
&gt;=C2=A0 =C2=A0 -e=C2=A0 =C2=A0 &#39;s///&#39; \<br>
&gt;=C2=A0 =C2=A0 -e=C2=A0 =C2=A0 &#39;s/ .*//&#39; \<br>
&gt; diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoption=
s.sh<br>
&gt; index 5714fd93d9..9e98db9eb7 100644<br>
&gt; --- a/scripts/meson-buildoptions.sh<br>
&gt; +++ b/scripts/meson-buildoptions.sh<br>
&gt; @@ -173,6 +173,8 @@ meson_options_help() {<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 tpm=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TPM support&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 u2f=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0U2F emulation support&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 usb-redir=C2=A0 =C2=
=A0 =C2=A0 =C2=A0libusbredir support&#39;<br>
&gt; +=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 user-native-call&#39;<br>
&gt; +=C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 use native code for user mode emulation&#39=
;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 vde=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vde network backend support&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 vdi=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdi image format support&#39;<br>
&gt;=C2=A0 =C2=A0 printf &quot;%s\n&quot; &#39;=C2=A0 vduse-blk-export&#39;=
<br>
&gt; @@ -472,6 +474,8 @@ _meson_option_parse() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --disable-u2f) printf &quot;%s&quot; -Du2f=3Ddisab=
led ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --enable-usb-redir) printf &quot;%s&quot; -Dusb_re=
dir=3Denabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --disable-usb-redir) printf &quot;%s&quot; -Dusb_r=
edir=3Ddisabled ;;<br>
&gt; +=C2=A0 =C2=A0 --enable-user-native-call) printf &quot;%s&quot; -Duser=
_native_call=3Denabled ;;<br>
&gt; +=C2=A0 =C2=A0 --disable-user-native-call) printf &quot;%s&quot; -Duse=
r_native_call=3Ddisabled ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --enable-vde) printf &quot;%s&quot; -Dvde=3Denable=
d ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --disable-vde) printf &quot;%s&quot; -Dvde=3Ddisab=
led ;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --enable-vdi) printf &quot;%s&quot; -Dvdi=3Denable=
d ;;<br>
&gt; diff --git a/target/arm/helper.c b/target/arm/helper.c<br>
&gt; index 0b7fd2e7e6..03fbc3724b 100644<br>
&gt; --- a/target/arm/helper.c<br>
&gt; +++ b/target/arm/helper.c<br>
&gt; @@ -25,6 +25,7 @@<br>
&gt;=C2=A0 #include &quot;sysemu/tcg.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/guest-random.h&quot;<br>
&gt; +#include &quot;exec/cpu_ldst.h&quot;<br>
&gt;=C2=A0 #ifdef CONFIG_TCG<br>
&gt;=C2=A0 #include &quot;semihosting/common-semi.h&quot;<br>
&gt;=C2=A0 #endif<br>
&gt; @@ -12045,3 +12046,49 @@ void aarch64_sve_change_el(CPUARMState *env, =
int old_el,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 #endif<br>
&gt; +<br>
&gt; +#if defined(CONFIG_USER_ONLY)=C2=A0 &amp;&amp; defined(CONFIG_USER_NA=
TIVE_CALL)<br>
&gt; +<br>
&gt; +#define NATIVE_FN_W_3W()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br=
>
&gt; +=C2=A0 =C2=A0 target_ulong arg0, arg1, arg2; \<br>
&gt; +=C2=A0 =C2=A0 arg0 =3D env-&gt;regs[0];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 arg1 =3D env-&gt;regs[1];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 arg2 =3D env-&gt;regs[2];<br>
&gt; +<br>
&gt; +void helper_native_memcpy(CPUARMState *env)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);<br>
&gt; +=C2=A0 =C2=A0 NATIVE_FN_W_3W();<br>
&gt; +=C2=A0 =C2=A0 void *ret;<br>
&gt; +=C2=A0 =C2=A0 void *dest =3D g2h(cs, arg0);<br>
&gt; +=C2=A0 =C2=A0 void *src =3D g2h(cs, arg1);<br>
&gt; +=C2=A0 =C2=A0 size_t n =3D (size_t)arg2;<br>
&gt; +=C2=A0 =C2=A0 ret =3D memcpy(dest, src, n);<br>
&gt; +=C2=A0 =C2=A0 env-&gt;regs[0] =3D (target_ulong)h2g(ret);<br>
&gt; +}<br>
<br>
This is the easiest approach but not the most efficient. As all the<br>
information is known at translation time we should be able to do an<br>
equivalent operation to g2h in TCG ops and call memcpy directly and<br>
fixup the result.<br>
<br>
&gt; +<br>
&gt; +void helper_native_memcmp(CPUARMState *env)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);<br>
&gt; +=C2=A0 =C2=A0 NATIVE_FN_W_3W();<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +=C2=A0 =C2=A0 void *s1 =3D g2h(cs, arg0);<br>
&gt; +=C2=A0 =C2=A0 void *s2 =3D g2h(cs, arg1);<br>
&gt; +=C2=A0 =C2=A0 size_t n =3D (size_t)arg2;<br>
&gt; +=C2=A0 =C2=A0 ret =3D memcmp(s1, s2, n);<br>
&gt; +=C2=A0 =C2=A0 env-&gt;regs[0] =3D ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void helper_native_memset(CPUARMState *env)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);<br>
&gt; +=C2=A0 =C2=A0 NATIVE_FN_W_3W();<br>
&gt; +=C2=A0 =C2=A0 void *ret;<br>
&gt; +=C2=A0 =C2=A0 void *s =3D g2h(cs, arg0);<br>
&gt; +=C2=A0 =C2=A0 int c =3D (int)arg1;<br>
&gt; +=C2=A0 =C2=A0 size_t n =3D (size_t)arg2;<br>
&gt; +=C2=A0 =C2=A0 ret =3D memset(s, c, n);<br>
&gt; +=C2=A0 =C2=A0 env-&gt;regs[0] =3D (target_ulong)h2g(ret);<br>
&gt; +}<br>
&gt; +<br>
&gt; +#endif<br>
&gt; diff --git a/target/arm/helper.h b/target/arm/helper.h<br>
&gt; index 3335c2b10b..57144bf6fb 100644<br>
&gt; --- a/target/arm/helper.h<br>
&gt; +++ b/target/arm/helper.h<br>
&gt; @@ -1038,6 +1038,12 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_s, TCG_CALL_NO_R=
WG,<br>
&gt;=C2=A0 DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0void, ptr, ptr, ptr, ptr, i32)<br>
&gt;=C2=A0 <br>
&gt; +#if defined(CONFIG_USER_ONLY)=C2=A0 &amp;&amp; defined(CONFIG_USER_NA=
TIVE_CALL)<br>
&gt; +DEF_HELPER_1(native_memcpy, void, env)<br>
&gt; +DEF_HELPER_1(native_memcmp, void, env)<br>
&gt; +DEF_HELPER_1(native_memset, void, env)<br>
&gt; +#endif<br>
&gt; +<br>
&gt;=C2=A0 #ifdef TARGET_AARCH64<br>
&gt;=C2=A0 #include &quot;tcg/helper-a64.h&quot;<br>
&gt;=C2=A0 #include &quot;tcg/helper-sve.h&quot;<br>
&gt; diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate=
-a64.c<br>
&gt; index 741a608739..a0ae96a2fd 100644<br>
&gt; --- a/target/arm/tcg/translate-a64.c<br>
&gt; +++ b/target/arm/tcg/translate-a64.c<br>
&gt; @@ -35,6 +35,7 @@<br>
&gt;=C2=A0 #include &quot;cpregs.h&quot;<br>
&gt;=C2=A0 #include &quot;translate-a64.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/atomic128.h&quot;<br>
&gt; +#include &quot;exec/user/native-func.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static TCGv_i64 cpu_X[32];<br>
&gt;=C2=A0 static TCGv_i64 cpu_pc;<br>
&gt; @@ -42,6 +43,11 @@ static TCGv_i64 cpu_pc;<br>
&gt;=C2=A0 /* Load/store exclusive handling */<br>
&gt;=C2=A0 static TCGv_i64 cpu_exclusive_high;<br>
&gt;=C2=A0 <br>
&gt; +#if defined(CONFIG_USER_ONLY) &amp;&amp; defined(TARGET_AARCH64) &amp=
;&amp; \<br>
&gt; +=C2=A0 =C2=A0 defined(CONFIG_USER_NATIVE_CALL)<br>
&gt; +bool native_call_status;<br>
&gt; +#endif<br>
<br>
DisasContext is the best place to store these values rather than a file<br>
local global. The translator can be multi-threaded so you might race on<br>
this variable.<br>
<br>
&gt; +<br>
&gt;=C2=A0 static const char *regnames[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;x0&quot;, &quot;x1&quot;, &quot;x2&quot;, &q=
uot;x3&quot;, &quot;x4&quot;, &quot;x5&quot;, &quot;x6&quot;, &quot;x7&quot=
;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;x8&quot;, &quot;x9&quot;, &quot;x10&quot;, &=
quot;x11&quot;, &quot;x12&quot;, &quot;x13&quot;, &quot;x14&quot;, &quot;x1=
5&quot;,<br>
&gt; @@ -2292,6 +2298,12 @@ static void disas_exc(DisasContext *s, uint32_t=
 insn)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_exce=
ption_insn_el(s, 0, EXCP_UDEF, syndrome, 2);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +#if defined(CONFIG_USER_ONLY)=C2=A0 &amp;&amp; defined(CONFIG_USER_NA=
TIVE_CALL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (imm16 =3D=3D 0xff)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 native_call_s=
tatus =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
<br>
We need this to be explicitly opt in so if the user hasn&#39;t enabled this=
<br>
the illegal operations still fault. With a helper we could avoid too<br>
much #ifdef uglyness, something like:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (native_bypass() &amp;&=
amp; imm16 =3D 0xff) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;native_call_s=
tatus =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
see semihosting_enabled() for an example.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_ss_advance(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_exception_insn(s, =
4, EXCP_SWI, syndrome);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; @@ -14203,6 +14215,26 @@ static void aarch64_tr_translate_insn(DisasCo=
ntextBase *dcbase, CPUState *cpu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 s-&gt;fp_access_checked =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 s-&gt;sve_access_checked =3D false;<br>
&gt;=C2=A0 <br>
&gt; +#if defined(CONFIG_USER_ONLY)=C2=A0 &amp;&amp; defined(CONFIG_USER_NA=
TIVE_CALL)<br>
&gt; +=C2=A0 =C2=A0 if (native_call_status) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (insn) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NATIVE_MEMCPY:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_native_memcpy(cp=
u_env);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NATIVE_MEMCMP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_native_memcmp(cp=
u_env);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case NATIVE_MEMSET:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_native_memset(cp=
u_env);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unallocated_encoding(s);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 native_call_status =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
&gt; +<br>
<br>
Also why defer the helper handling here rather than do it in place?<br>
<br>
&lt;snip&gt;<br>
<br>
Similar comments for the other frontends.<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div></div>

--0000000000008a559c05fd03187a--


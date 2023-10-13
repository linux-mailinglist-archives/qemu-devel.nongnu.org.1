Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9C67C85CC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:30:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHHh-0001XH-Lz; Fri, 13 Oct 2023 08:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrHHV-0001WP-EJ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrHHS-0004j2-G1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697200117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lSIXdsq6eV16f57MLlMRLKRp3WDXQgg9+bE/l50RnGs=;
 b=hMKRIrEqy+RYd//PYN99eFXcS0Wt4WI7nLrTc0rfHDOdcdGIrhQcHgLWGXbMRjqorvtEKu
 8OUcrVIxx7qDknWKsH99DVgmPP0SHxfxbCmZTN6Gc1HFIdJxuxjnj2cTjriWN7ZOSJVPd4
 pnqJgwviMOFaq5fByJ2TZHe5ECRkA5U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-HRmeNOmRMGyqAcpJwL73eQ-1; Fri, 13 Oct 2023 08:28:34 -0400
X-MC-Unique: HRmeNOmRMGyqAcpJwL73eQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 842DF85A5BA;
 Fri, 13 Oct 2023 12:28:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E05311C060DF;
 Fri, 13 Oct 2023 12:28:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E6DE821E6A21; Fri, 13 Oct 2023 14:28:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-block@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Eric Auger <eric.auger@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH 01/78] include/qemu/compiler.h: replace
 QEMU_FALLTHROUGH with fallthrough
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
 <2e08cff874b2f9fc4143bdcde87ebba9b70b356c.1697183082.git.manos.pitsidianakis@linaro.org>
Date: Fri, 13 Oct 2023 14:28:31 +0200
In-Reply-To: <2e08cff874b2f9fc4143bdcde87ebba9b70b356c.1697183082.git.manos.pitsidianakis@linaro.org>
 (Emmanouil Pitsidianakis's message of "Fri, 13 Oct 2023 10:47:05
 +0300")
Message-ID: <874jiuiu4w.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The commit message needs to explain why.

Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  audio/pwaudio.c              |  8 ++++----
>  hw/arm/smmuv3.c              |  2 +-
>  include/qemu/compiler.h      | 30 +++++++++++++++++++++++-------
>  include/qemu/osdep.h         |  4 ++--
>  target/loongarch/cpu.c       |  4 ++--
>  target/loongarch/translate.c |  2 +-
>  tcg/optimize.c               |  8 ++++----
>  7 files changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index 3ce5f6507b..bf26fadb06 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -1,29 +1,29 @@
>  /*
>   * QEMU PipeWire audio driver
>   *
>   * Copyright (c) 2023 Red Hat Inc.
>   *
>   * Author: Dorinda Bassey       <dbassey@redhat.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
> +#include <spa/param/audio/format-utils.h>
> +#include <spa/utils/ringbuffer.h>
> +#include <spa/utils/result.h>
> +#include <spa/param/props.h>
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
>  #include "audio.h"
>  #include <errno.h>
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> -#include <spa/param/audio/format-utils.h>
> -#include <spa/utils/ringbuffer.h>
> -#include <spa/utils/result.h>
> -#include <spa/param/props.h>
>  
>  #include <pipewire/pipewire.h>
>  #include "trace.h"
>  
>  #define AUDIO_CAP "pipewire"
>  #define RINGBUFFER_SIZE    (1u << 22)
>  #define RINGBUFFER_MASK    (RINGBUFFER_SIZE - 1)
>  
>  #include "audio_int.h"

This is wrong.  docs/devel/style.rst:

    Include directives
    ------------------

    Order include directives as follows:

    .. code-block:: c

        #include "qemu/osdep.h"  /* Always first... */
        #include <...>           /* then system headers... */
        #include "..."           /* and finally QEMU headers. */

Separate patch, please.

[...]

> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 1109482a00..959982805d 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -1,215 +1,231 @@

[...]

>  #define QEMU_ALWAYS_INLINE
>  #endif
>  
> -/**
> - * In most cases, normal "fallthrough" comments are good enough for
> - * switch-case statements, but sometimes the compiler has problems
> - * with those. In that case you can use QEMU_FALLTHROUGH instead.
> +/*
> + * Add the pseudo keyword 'fallthrough' so case statement blocks

Pseudo-keyword?  It's a macro.

> + * must end with any of these keywords:
> + *   break;
> + *   fallthrough;
> + *   continue;
> + *   goto <label>;
> + *   return [expression];

These are statements, not keywords.

> + *
> + *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes

Not sure we need to point to the docs here.  We have hundreds of
__attribute__ uses in the tree.

>   */
> -#if __has_attribute(fallthrough)
> -# define QEMU_FALLTHROUGH __attribute__((fallthrough))
> +
> +/*
> + * glib_macros.h contains its own definition of fallthrough, so if we define
> + * the pseudokeyword here it will expand when the glib header checks for the
> + * attribute. glib headers must be #included after this header.
> + */
> +#ifdef fallthrough
> +#undef fallthrough
> +#endif

Why do we need to roll our own macro then?

> +
> +#if __has_attribute(__fallthrough__)
> +# define fallthrough                    __attribute__((__fallthrough__))
>  #else
> -# define QEMU_FALLTHROUGH do {} while (0) /* fallthrough */
> +# define fallthrough                    do {} while (0)  /* fallthrough */
>  #endif
>  
>  #ifdef CONFIG_CFI
>  /*

[...]

> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 475a1c62ff..8f790f0deb 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -1,171 +1,171 @@
>  /*
>   * OS includes and handling of OS dependencies
>   *
>   * This header exists to pull in some common system headers that
>   * most code in QEMU will want, and to fix up some possible issues with
>   * it (missing defines, Windows weirdness, and so on).
>   *
>   * To avoid getting into possible circular include dependencies, this
>   * file should not include any other QEMU headers, with the exceptions
>   * of config-host.h, config-target.h, qemu/compiler.h,
>   * sysemu/os-posix.h, sysemu/os-win32.h, glib-compat.h and
>   * qemu/typedefs.h, all of which are doing a similar job to this file
>   * and are under similar constraints.
>   *
>   * This header also contains prototypes for functions defined in
>   * os-*.c and util/oslib-*.c; those would probably be better split
>   * out into separate header files.
>   *
>   * In an ideal world this header would contain only:
>   *  (1) things which everybody needs
>   *  (2) things without which code would work on most platforms but
>   *      fail to compile or misbehave on a minority of host OSes
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
>   */
>  #ifndef QEMU_OSDEP_H
>  #define QEMU_OSDEP_H
>  
>  #if !defined _FORTIFY_SOURCE && defined __OPTIMIZE__ && __OPTIMIZE__ && defined __linux__
>  # define _FORTIFY_SOURCE 2
>  #endif
>  
>  #include "config-host.h"
>  #ifdef NEED_CPU_H
>  #include CONFIG_TARGET
>  #else
>  #include "exec/poison.h"
>  #endif
>  
>  /*
>   * HOST_WORDS_BIGENDIAN was replaced with HOST_BIG_ENDIAN. Prevent it from
>   * creeping back in.
>   */
>  #pragma GCC poison HOST_WORDS_BIGENDIAN
>  
>  /*
>   * TARGET_WORDS_BIGENDIAN was replaced with TARGET_BIG_ENDIAN. Prevent it from
>   * creeping back in.
>   */
>  #pragma GCC poison TARGET_WORDS_BIGENDIAN
>  
> -#include "qemu/compiler.h"
> -
>  /* Older versions of C++ don't get definitions of various macros from
>   * stdlib.h unless we define these macros before first inclusion of
>   * that system header.
>   */
>  #ifndef __STDC_CONSTANT_MACROS
>  #define __STDC_CONSTANT_MACROS
>  #endif
>  #ifndef __STDC_LIMIT_MACROS
>  #define __STDC_LIMIT_MACROS
>  #endif
>  #ifndef __STDC_FORMAT_MACROS
>  #define __STDC_FORMAT_MACROS
>  #endif
>  
>  /* The following block of code temporarily renames the daemon() function so the
>   * compiler does not see the warning associated with it in stdlib.h on OSX
>   */
>  #ifdef __APPLE__
>  #define daemon qemu_fake_daemon_function
>  #include <stdlib.h>
>  #undef daemon
>  QEMU_EXTERN_C int daemon(int, int);
>  #endif
>  
>  #ifdef _WIN32
>  /* as defined in sdkddkver.h */
>  #ifndef _WIN32_WINNT
>  #define _WIN32_WINNT 0x0602 /* Windows 8 API (should be >= the one from glib) */
>  #endif
>  /* reduces the number of implicitly included headers */
>  #ifndef WIN32_LEAN_AND_MEAN
>  #define WIN32_LEAN_AND_MEAN
>  #endif
>  #endif
>  
>  /* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
>  #ifdef __MINGW32__
>  #define __USE_MINGW_ANSI_STDIO 1
>  #endif
>  
>  /*
>   * We need the FreeBSD "legacy" definitions. Rust needs the FreeBSD 11 system
>   * calls since it doesn't use libc at all, so we have to emulate that despite
>   * FreeBSD 11 being EOL'd.
>   */
>  #ifdef __FreeBSD__
>  #define _WANT_FREEBSD11_STAT
>  #define _WANT_FREEBSD11_STATFS
>  #define _WANT_FREEBSD11_DIRENT
>  #define _WANT_KERNEL_ERRNO
>  #define _WANT_SEMUN
>  #endif
>  
>  #include <stdarg.h>
>  #include <stddef.h>
>  #include <stdbool.h>
>  #include <stdint.h>
>  #include <sys/types.h>
>  #include <stdlib.h>
>  #include <stdio.h>
>  
>  #include <string.h>
>  #include <strings.h>
>  #include <inttypes.h>
>  #include <limits.h>
>  /* Put unistd.h before time.h as that triggers localtime_r/gmtime_r
>   * function availability on recentish Mingw-w64 platforms. */
>  #include <unistd.h>
>  #include <time.h>
>  #include <ctype.h>
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <getopt.h>
>  #include <sys/stat.h>
>  #include <sys/time.h>
>  #include <assert.h>
>  /* setjmp must be declared before sysemu/os-win32.h
>   * because it is redefined there. */
>  #include <setjmp.h>
>  #include <signal.h>
>  
>  #ifdef CONFIG_IOVEC
>  #include <sys/uio.h>
>  #endif
>  
>  #if defined(__linux__) && defined(__sparc__)
>  /* The SPARC definition of QEMU_VMALLOC_ALIGN needs SHMLBA */
>  #include <sys/shm.h>
>  #endif
>  
>  #ifndef _WIN32
>  #include <sys/wait.h>
>  #else
>  #define WIFEXITED(x)   1
>  #define WEXITSTATUS(x) (x)
>  #endif
>  
>  #ifdef __APPLE__
>  #include <AvailabilityMacros.h>
>  #endif
>  
>  /*
>   * This is somewhat like a system header; it must be outside any extern "C"
>   * block because it includes system headers itself, including glib.h,
>   * which will not compile if inside an extern "C" block.
>   */
>  #include "glib-compat.h"
>  
> +#include "qemu/compiler.h"
> +
>  #ifdef _WIN32
>  #include "sysemu/os-win32.h"
>  #endif
>  
>  #ifdef CONFIG_POSIX
>  #include "sysemu/os-posix.h"
>  #endif
>  
>  #ifdef __cplusplus
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 2bea7ca5d5..e01d626b15 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -142,145 +142,145 @@ static inline bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
>  static void loongarch_cpu_do_interrupt(CPUState *cs)
>  {
>      LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>      CPULoongArchState *env = &cpu->env;
>      bool update_badinstr = 1;
>      int cause = -1;
>      const char *name;
>      bool tlbfill = FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
>      uint32_t vec_size = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
>  
>      if (cs->exception_index != EXCCODE_INT) {
>          if (cs->exception_index < 0 ||
>              cs->exception_index >= ARRAY_SIZE(excp_names)) {
>              name = "unknown";
>          } else {
>              name = excp_names[cs->exception_index];
>          }
>  
>          qemu_log_mask(CPU_LOG_INT,
>                       "%s enter: pc " TARGET_FMT_lx " ERA " TARGET_FMT_lx
>                       " TLBRERA " TARGET_FMT_lx " %s exception\n", __func__,
>                       env->pc, env->CSR_ERA, env->CSR_TLBRERA, name);
>      }
>  
>      switch (cs->exception_index) {
>      case EXCCODE_DBP:
>          env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DCL, 1);
>          env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, ECODE, 0xC);
>          goto set_DERA;
>      set_DERA:
>          env->CSR_DERA = env->pc;
>          env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DST, 1);
>          set_pc(env, env->CSR_EENTRY + 0x480);
>          break;
>      case EXCCODE_INT:
>          if (FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
>              env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DEI, 1);
>              goto set_DERA;
>          }
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>      case EXCCODE_PIF:
>      case EXCCODE_ADEF:
>          cause = cs->exception_index;
>          update_badinstr = 0;
>          break;
>      case EXCCODE_SYS:
>      case EXCCODE_BRK:
>      case EXCCODE_INE:
>      case EXCCODE_IPE:
>      case EXCCODE_FPD:
>      case EXCCODE_FPE:
>      case EXCCODE_SXD:
>      case EXCCODE_ASXD:
>          env->CSR_BADV = env->pc;
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>      case EXCCODE_BCE:
>      case EXCCODE_ADEM:
>      case EXCCODE_PIL:
>      case EXCCODE_PIS:
>      case EXCCODE_PME:
>      case EXCCODE_PNR:
>      case EXCCODE_PNX:
>      case EXCCODE_PPI:
>          cause = cs->exception_index;
>          break;
>      default:
>          qemu_log("Error: exception(%d) has not been supported\n",
>                   cs->exception_index);
>          abort();
>      }
>  
>      if (update_badinstr) {
>          env->CSR_BADI = cpu_ldl_code(env, env->pc);
>      }
>  
>      /* Save PLV and IE */
>      if (tlbfill) {
>          env->CSR_TLBRPRMD = FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV,
>                                         FIELD_EX64(env->CSR_CRMD,
>                                         CSR_CRMD, PLV));
>          env->CSR_TLBRPRMD = FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PIE,
>                                         FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE));
>          /* set the DA mode */
>          env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 1);
>          env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 0);
>          env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA,
>                                        PC, (env->pc >> 2));
>      } else {
>          env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ECODE,
>                                      EXCODE_MCODE(cause));
>          env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ESUBCODE,
>                                      EXCODE_SUBCODE(cause));
>          env->CSR_PRMD = FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PPLV,
>                                     FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV));
>          env->CSR_PRMD = FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PIE,
>                                     FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE));
>          env->CSR_ERA = env->pc;
>      }
>  
>      env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, 0);
>      env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, 0);
>  
>      if (vec_size) {
>          vec_size = (1 << vec_size) * 4;
>      }
>  
>      if  (cs->exception_index == EXCCODE_INT) {
>          /* Interrupt */
>          uint32_t vector = 0;
>          uint32_t pending = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
>          pending &= FIELD_EX64(env->CSR_ECFG, CSR_ECFG, LIE);
>  
>          /* Find the highest-priority interrupt. */
>          vector = 31 - clz32(pending);
>          set_pc(env, env->CSR_EENTRY + \
>                 (EXCCODE_EXTERNAL_INT + vector) * vec_size);
>          qemu_log_mask(CPU_LOG_INT,
>                        "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
>                        " cause %d\n" "    A " TARGET_FMT_lx " D "
>                        TARGET_FMT_lx " vector = %d ExC " TARGET_FMT_lx "ExS"
>                        TARGET_FMT_lx "\n",
>                        __func__, env->pc, env->CSR_ERA,
>                        cause, env->CSR_BADV, env->CSR_DERA, vector,
>                        env->CSR_ECFG, env->CSR_ESTAT);
>      } else {
>          if (tlbfill) {
>              set_pc(env, env->CSR_TLBRENTRY);
>          } else {
>              set_pc(env, env->CSR_EENTRY + EXCODE_MCODE(cause) * vec_size);
>          }
>          qemu_log_mask(CPU_LOG_INT,
>                        "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
>                        " cause %d%s\n, ESTAT " TARGET_FMT_lx
>                        " EXCFG " TARGET_FMT_lx " BADVA " TARGET_FMT_lx
>                        "BADI " TARGET_FMT_lx " SYS_NUM " TARGET_FMT_lu
>                        " cpu %d asid " TARGET_FMT_lx "\n", __func__, env->pc,
>                        tlbfill ? env->CSR_TLBRERA : env->CSR_ERA,
>                        cause, tlbfill ? "(refill)" : "", env->CSR_ESTAT,
>                        env->CSR_ECFG,
>                        tlbfill ? env->CSR_TLBRBADV : env->CSR_BADV,
>                        env->CSR_BADI, env->gpr[11], cs->cpu_index,
>                        env->CSR_ASID);
>      }
>      cs->exception_index = -1;
>  }
> diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
> index 21f4db6fbd..36fceb1beb 100644
> --- a/target/loongarch/translate.c
> +++ b/target/loongarch/translate.c
> @@ -304,24 +304,24 @@ static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>  static void loongarch_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>  {
>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
>  
>      switch (ctx->base.is_jmp) {
>      case DISAS_STOP:
>          tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
>          tcg_gen_lookup_and_goto_ptr();
>          break;
>      case DISAS_TOO_MANY:
>          gen_goto_tb(ctx, 0, ctx->base.pc_next);
>          break;
>      case DISAS_NORETURN:
>          break;
>      case DISAS_EXIT_UPDATE:
>          tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>      case DISAS_EXIT:
>          tcg_gen_exit_tb(NULL, 0);
>          break;
>      default:
>          g_assert_not_reached();
>      }
>  }
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 3013eb04e6..3da135a353 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1062,81 +1062,81 @@ static bool fold_brcond(OptContext *ctx, TCGOp *op)
>  static bool fold_brcond2(OptContext *ctx, TCGOp *op)
>  {
>      TCGCond cond = op->args[4];
>      TCGArg label = op->args[5];
>      int i, inv = 0;
>  
>      if (swap_commutative2(&op->args[0], &op->args[2])) {
>          op->args[4] = cond = tcg_swap_cond(cond);
>      }
>  
>      i = do_constant_folding_cond2(&op->args[0], &op->args[2], cond);
>      if (i >= 0) {
>          goto do_brcond_const;
>      }
>  
>      switch (cond) {
>      case TCG_COND_LT:
>      case TCG_COND_GE:
>          /*
>           * Simplify LT/GE comparisons vs zero to a single compare
>           * vs the high word of the input.
>           */
>          if (arg_is_const(op->args[2]) && arg_info(op->args[2])->val == 0 &&
>              arg_is_const(op->args[3]) && arg_info(op->args[3])->val == 0) {
>              goto do_brcond_high;
>          }
>          break;
>  
>      case TCG_COND_NE:
>          inv = 1;
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>      case TCG_COND_EQ:
>          /*
>           * Simplify EQ/NE comparisons where one of the pairs
>           * can be simplified.
>           */
>          i = do_constant_folding_cond(TCG_TYPE_I32, op->args[0],
>                                       op->args[2], cond);
>          switch (i ^ inv) {
>          case 0:
>              goto do_brcond_const;
>          case 1:
>              goto do_brcond_high;
>          }
>  
>          i = do_constant_folding_cond(TCG_TYPE_I32, op->args[1],
>                                       op->args[3], cond);
>          switch (i ^ inv) {
>          case 0:
>              goto do_brcond_const;
>          case 1:
>              op->opc = INDEX_op_brcond_i32;
>              op->args[1] = op->args[2];
>              op->args[2] = cond;
>              op->args[3] = label;
>              break;
>          }
>          break;
>  
>      default:
>          break;
>  
>      do_brcond_high:
>          op->opc = INDEX_op_brcond_i32;
>          op->args[0] = op->args[1];
>          op->args[1] = op->args[3];
>          op->args[2] = cond;
>          op->args[3] = label;
>          break;
>  
>      do_brcond_const:
>          if (i == 0) {
>              tcg_op_remove(ctx->tcg, op);
>              return true;
>          }
>          op->opc = INDEX_op_br;
>          op->args[0] = label;
>          break;
>      }
>      return false;
>  }
> @@ -1424,46 +1424,46 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
>  static bool fold_exts(OptContext *ctx, TCGOp *op)
>  {
>      uint64_t s_mask_old, s_mask, z_mask, sign;
>      bool type_change = false;
>  
>      if (fold_const1(ctx, op)) {
>          return true;
>      }
>  
>      z_mask = arg_info(op->args[1])->z_mask;
>      s_mask = arg_info(op->args[1])->s_mask;
>      s_mask_old = s_mask;
>  
>      switch (op->opc) {
>      CASE_OP_32_64(ext8s):
>          sign = INT8_MIN;
>          z_mask = (uint8_t)z_mask;
>          break;
>      CASE_OP_32_64(ext16s):
>          sign = INT16_MIN;
>          z_mask = (uint16_t)z_mask;
>          break;
>      case INDEX_op_ext_i32_i64:
>          type_change = true;
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>      case INDEX_op_ext32s_i64:
>          sign = INT32_MIN;
>          z_mask = (uint32_t)z_mask;
>          break;
>      default:
>          g_assert_not_reached();
>      }
>  
>      if (z_mask & sign) {
>          z_mask |= sign;
>      }
>      s_mask |= sign << 1;
>  
>      ctx->z_mask = z_mask;
>      ctx->s_mask = s_mask;
>      if (!type_change) {
>          ctx->a_mask = s_mask & ~s_mask_old;
>      }
>  
>      return fold_masks(ctx, op);
>  }
> @@ -1471,40 +1471,40 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
>  static bool fold_extu(OptContext *ctx, TCGOp *op)
>  {
>      uint64_t z_mask_old, z_mask;
>      bool type_change = false;
>  
>      if (fold_const1(ctx, op)) {
>          return true;
>      }
>  
>      z_mask_old = z_mask = arg_info(op->args[1])->z_mask;
>  
>      switch (op->opc) {
>      CASE_OP_32_64(ext8u):
>          z_mask = (uint8_t)z_mask;
>          break;
>      CASE_OP_32_64(ext16u):
>          z_mask = (uint16_t)z_mask;
>          break;
>      case INDEX_op_extrl_i64_i32:
>      case INDEX_op_extu_i32_i64:
>          type_change = true;
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>      case INDEX_op_ext32u_i64:
>          z_mask = (uint32_t)z_mask;
>          break;
>      case INDEX_op_extrh_i64_i32:
>          type_change = true;
>          z_mask >>= 32;
>          break;
>      default:
>          g_assert_not_reached();
>      }
>  
>      ctx->z_mask = z_mask;
>      ctx->s_mask = smask_from_zmask(z_mask);
>      if (!type_change) {
>          ctx->a_mask = z_mask_old ^ z_mask;
>      }
>      return fold_masks(ctx, op);
>  }
> @@ -1835,75 +1835,75 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
>  static bool fold_setcond2(OptContext *ctx, TCGOp *op)
>  {
>      TCGCond cond = op->args[5];
>      int i, inv = 0;
>  
>      if (swap_commutative2(&op->args[1], &op->args[3])) {
>          op->args[5] = cond = tcg_swap_cond(cond);
>      }
>  
>      i = do_constant_folding_cond2(&op->args[1], &op->args[3], cond);
>      if (i >= 0) {
>          goto do_setcond_const;
>      }
>  
>      switch (cond) {
>      case TCG_COND_LT:
>      case TCG_COND_GE:
>          /*
>           * Simplify LT/GE comparisons vs zero to a single compare
>           * vs the high word of the input.
>           */
>          if (arg_is_const(op->args[3]) && arg_info(op->args[3])->val == 0 &&
>              arg_is_const(op->args[4]) && arg_info(op->args[4])->val == 0) {
>              goto do_setcond_high;
>          }
>          break;
>  
>      case TCG_COND_NE:
>          inv = 1;
> -        QEMU_FALLTHROUGH;
> +        fallthrough;
>      case TCG_COND_EQ:
>          /*
>           * Simplify EQ/NE comparisons where one of the pairs
>           * can be simplified.
>           */
>          i = do_constant_folding_cond(TCG_TYPE_I32, op->args[1],
>                                       op->args[3], cond);
>          switch (i ^ inv) {
>          case 0:
>              goto do_setcond_const;
>          case 1:
>              goto do_setcond_high;
>          }
>  
>          i = do_constant_folding_cond(TCG_TYPE_I32, op->args[2],
>                                       op->args[4], cond);
>          switch (i ^ inv) {
>          case 0:
>              goto do_setcond_const;
>          case 1:
>              op->args[2] = op->args[3];
>              op->args[3] = cond;
>              op->opc = INDEX_op_setcond_i32;
>              break;
>          }
>          break;
>  
>      default:
>          break;
>  
>      do_setcond_high:
>          op->args[1] = op->args[2];
>          op->args[2] = op->args[4];
>          op->args[3] = cond;
>          op->opc = INDEX_op_setcond_i32;
>          break;
>      }
>  
>      ctx->z_mask = 1;
>      ctx->s_mask = smask_from_zmask(1);
>      return false;
>  
>   do_setcond_const:
>      return tcg_opt_gen_movi(ctx, op, op->args[0], i);
>  }



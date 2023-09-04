Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC84791A46
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 17:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdB8L-0003qp-AJ; Mon, 04 Sep 2023 11:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdB8F-0003qE-3D
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 11:04:51 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdB8C-0000Dd-5O
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 11:04:50 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401187f8071so10163465e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 08:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693839886; x=1694444686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGNIKVWU8OfJA9+q1a2A5k4HTgvXEwHwlQfi52D0zp4=;
 b=F2x6q9S9LrV2ONxARGoXBLsq4JEHV8gcAjBILFN8rddozhj634xpw3D7NreeEWgtS2
 +Z/Hr+KOkGH2uZh4Y1ju2Yhg1gAjqKdJR7ZbRGpkCcCdNWypY4Lvcj7lriJxT/vi7Cu4
 0BsIlhB5v0WpyyIPnKviGJIMT+49PF38vdwwij2BS/41y6RwtWtlFR1hvEgg7QCmW7Mm
 Ul4fhOo20iPM9MVJI4BpGBHidoDlcJxqBKlm+p+fptqghgc79OcCcMti2L7aLIQJxxWf
 FrDFkqr93kTMZljMJ+lTj+wVErB/zVzCAb9bv3xyhkZ+gxOwGONsUoQ+cr6HfOLk3aTF
 Hghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693839886; x=1694444686;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wGNIKVWU8OfJA9+q1a2A5k4HTgvXEwHwlQfi52D0zp4=;
 b=eOxfSBbEnwCBTREjoSPSyYhQVJRhiYjviybSBcACUvwH3pM1yZDIeFmyHCDpDO5ad/
 tXtmGgw8KS+mahYmVGUVj3rVxLMUs2xP3UcO1YUMo1LTID/X6eFFZl8vHvSE+gwhwVD/
 tt/ig10mbGv+1YrhMa79phRfPtKH43XySnY0cjI7HM8i3GL3F23a0SrSlwXPOYUpfncX
 GnUOo/66k+SQ/mYKDWV+ouDebghCLncrIgeeE/lM8oi5slFW0zh68vj67CyBA3w5Oekb
 s0t69XAl/BgD+Ltsp2WSw5WTPtl6B3CPfoVYUuusobgl+Vk21myBvlU65Noo/fHn/s78
 YBBg==
X-Gm-Message-State: AOJu0Yyf+fQR2Nm2Q0eOOm7nK36lhSV4f2IVes3Ok9Eo85UzPVSsNvy2
 HvMGZE4vxq/pZl6vEXtZyhAQTA==
X-Google-Smtp-Source: AGHT+IGGTCG1UWsx5bPkdxUhixwrsWbjF8r0SgHub+onM76y16rj24SBgOWcvSzfjfbFqPVVsjbi/Q==
X-Received: by 2002:a05:600c:1d83:b0:402:b8:d022 with SMTP id
 p3-20020a05600c1d8300b0040200b8d022mr10388186wms.16.1693839886411; 
 Mon, 04 Sep 2023 08:04:46 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a7bce8d000000b003fe4548188bsm17496647wmj.48.2023.09.04.08.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 08:04:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A218D1FFBB;
 Mon,  4 Sep 2023 16:04:45 +0100 (BST)
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-21-richard.henderson@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Subject: Re: [PATCH v5 20/20] linux-user/s390x: Add vdso
Date: Mon, 04 Sep 2023 16:00:31 +0100
In-reply-to: <20230829220228.928506-21-richard.henderson@linaro.org>
Message-ID: <87fs3uhtde.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/s390x/vdso-asmoffset.h |   2 +
>  linux-user/elfload.c              |   3 ++
>  linux-user/s390x/signal.c         |   4 +-
>  linux-user/s390x/meson.build      |  24 +++++++++++
>  linux-user/s390x/vdso.S           |  61 ++++++++++++++++++++++++++
>  linux-user/s390x/vdso.ld          |  69 ++++++++++++++++++++++++++++++
>  linux-user/s390x/vdso.so          | Bin 0 -> 3464 bytes
>  7 files changed, 160 insertions(+), 3 deletions(-)
>  create mode 100644 linux-user/s390x/vdso-asmoffset.h
>  create mode 100644 linux-user/s390x/vdso.S
>  create mode 100644 linux-user/s390x/vdso.ld
>  create mode 100755 linux-user/s390x/vdso.so
>
<snip>
> diff --git a/linux-user/s390x/meson.build b/linux-user/s390x/meson.build
> index 0781ccea1d..09afd98deb 100644
> --- a/linux-user/s390x/meson.build
> +++ b/linux-user/s390x/meson.build
> @@ -3,3 +3,27 @@ syscall_nr_generators +=3D {
>                       arguments: [ meson.current_source_dir() / 'syscallh=
dr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
>                       output: '@BASENAME@_nr.h')
>  }
> +
> +vdso_so =3D custom_target(output: 'vdso.so',
> +                        input: files('vdso.S', 'vdso.ld'),
> +                        depend_files: files('vdso-asmoffset.h'),
> +                        command: [
> +                            build_vdso_cmd,
> +                            '-B', meson.project_build_root(),
> +                            '-C', meson.current_source_dir(),
> +                            '-T', 's390x-linux-user',
> +                            '-o', '@OUTPUT@',
> +                            '--', '-nostdlib', '-shared',
> +                            '-Wl,-h,linux-vdso64.so.1',
> +                            '-Wl,--build-id=3Dsha1',
> +                            '-Wl,--hash-style=3Dboth',
> +                            '-Wl,-T,@INPUT1@',
> +                            '@INPUT0@'
> +                        ])
> +
> +vdso_inc =3D gen_vdso.process('vdso.so', extra_args: [
> +                                '-s', '__kernel_sigreturn',
> +                                '-r', '__kernel_rt_sigreturn'
> +                            ])
> +

Due to the b4 dropping the vdso.so in the patch this fails:

  Program build-vdso.sh found: YES (/home/alex/lsrc/qemu.git/linux-user/bui=
ld-vdso.sh)
  ../../linux-user/s390x/meson.build:24:0: ERROR: File vdso.so does not exi=
st.
  A full log can be found at /home/alex/lsrc/qemu.git/builds/all/meson-logs=
/meson-log.txt
  FAILED: build.ninja
  /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/meson --internal regenerat=
e /home/alex/lsrc/qemu.git /home/alex/lsrc/qemu.git/builds/all
  ninja: error: rebuilding 'build.ninja': subcommand failed
    BUILD   aarch64-softmmu guest-tests
  tests/tcg/aarch64-softmmu: -march=3Darmv8.3-a detected

which makes me think the dependencies are broken anyway because I have a
working s390x compiler:

  =E2=9E=9C  cat tests/tcg/s390x-linux-user/config-target.mak=20
  # Automatically generated by configure - do not modify
  TARGET_NAME=3Ds390x
  TARGET=3Ds390x-linux-user
  EXTRA_CFLAGS=3D
  CC=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex=
/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-g=
nu-gcc -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
  CCAS=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/al=
ex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux=
-gnu-gcc -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
  AR=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex=
/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-g=
nu-ar -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
  AS=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex=
/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-g=
nu-as -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
  LD=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex=
/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-g=
nu-ld -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
  NM=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex=
/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-g=
nu-nm -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
  OBJCOPY=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home=
/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-li=
nux-gnu-objcopy -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
  RANLIB=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/=
alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-lin=
ux-gnu-ranlib -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
  STRIP=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/a=
lex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linu=
x-gnu-strip -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
  BUILD_STATIC=3Dy
  QEMU=3D/home/alex/lsrc/qemu.git/builds/all/qemu-s390x
  HOST_GDB_SUPPORTS_ARCH=3Dy

We really need to express the dependency on
docker-image-debian-s390x-cross (when using containers) to ensure we can
build the vdso.so and not rely on the copy we have.

> +linux_user_ss.add(when: 'TARGET_S390X', if_true: vdso_inc)
> diff --git a/linux-user/s390x/vdso.S b/linux-user/s390x/vdso.S
> new file mode 100644
> index 0000000000..3332492477
> --- /dev/null
> +++ b/linux-user/s390x/vdso.S
> @@ -0,0 +1,61 @@
> +/*
> + * s390x linux replacement vdso.
> + *
> + * Copyright 2023 Linaro, Ltd.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <asm/unistd.h>
> +#include "vdso-asmoffset.h"
> +
> +.macro endf name
> +	.globl	\name
> +	.type	\name, @function
> +	.size	\name, . - \name
> +.endm
> +
> +.macro raw_syscall n
> +        .ifne	\n < 0x100
> +	svc	\n
> +	.else
> +	lghi	%r1, \n
> +	svc	0
> +        .endif
> +.endm
> +
> +.macro vdso_syscall name, nr
> +\name:
> +	.cfi_startproc
> +	aghi	%r15, -(STACK_FRAME_OVERHEAD + 16)
> +	.cfi_adjust_cfa_offset STACK_FRAME_OVERHEAD + 16
> +	stg	%r14, STACK_FRAME_OVERHEAD(%r15)
> +	.cfi_rel_offset %r14, STACK_FRAME_OVERHEAD
> +	raw_syscall \nr
> +	lg	%r14, STACK_FRAME_OVERHEAD(%r15)
> +	aghi	%r15, STACK_FRAME_OVERHEAD + 16
> +	.cfi_restore %r14
> +	.cfi_adjust_cfa_offset -(STACK_FRAME_OVERHEAD + 16)
> +	br	%r14
> +	.cfi_endproc
> +endf	\name
> +.endm
> +
> +vdso_syscall __kernel_gettimeofday, __NR_gettimeofday
> +vdso_syscall __kernel_clock_gettime, __NR_clock_gettime
> +vdso_syscall __kernel_clock_getres, __NR_clock_getres
> +vdso_syscall __kernel_getcpu, __NR_getcpu
> +
> +/*
> + * TODO unwind info, though we're ok without it.
> + * The kernel supplies bogus empty unwind info, and it is likely ignored
> + * by all users.  Without it we get the fallback signal frame handling.
> + */
> +
> +__kernel_sigreturn:
> +	raw_syscall __NR_sigreturn
> +endf	__kernel_sigreturn
> +
> +__kernel_rt_sigreturn:
> +	raw_syscall __NR_rt_sigreturn
> +endf	__kernel_rt_sigreturn
> diff --git a/linux-user/s390x/vdso.ld b/linux-user/s390x/vdso.ld
> new file mode 100644
> index 0000000000..2a30ff382a
> --- /dev/null
> +++ b/linux-user/s390x/vdso.ld
> @@ -0,0 +1,69 @@
> +/*
> + * Linker script for linux x86-64 replacement vdso.
> + *
> + * Copyright 2023 Linaro, Ltd.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +VERSION {
> +        LINUX_2.6.29 {
> +        global:
> +                __kernel_gettimeofday;
> +                __kernel_clock_gettime;
> +                __kernel_clock_getres;
> +                __kernel_getcpu;
> +                __kernel_restart_syscall;
> +                __kernel_rt_sigreturn;
> +                __kernel_sigreturn;
> +        local: *;
> +        };
> +}
> +
> +
> +PHDRS {
> +        phdr            PT_PHDR         FLAGS(4) PHDRS;
> +        load            PT_LOAD         FLAGS(7) FILEHDR PHDRS; /* FLAGS=
=3DRWX */
> +        dynamic         PT_DYNAMIC      FLAGS(4);
> +        eh_frame_hdr    PT_GNU_EH_FRAME;
> +        note            PT_NOTE         FLAGS(4);
> +}
> +
> +SECTIONS {
> +        . =3D SIZEOF_HEADERS;
> +
> +        /*
> +         * The following, including the FILEHDRS and PHDRS, are modified
> +         * when we relocate the binary.  We want them to be initially
> +         * writable for the relocation; we'll force them read-only after.
> +         */
> +        .note           : { *(.note*) }         :load :note
> +        .dynamic        : { *(.dynamic) }       :load :dynamic
> +        .dynsym         : { *(.dynsym) }        :load
> +        .data           : {
> +                /*
> +                 * There ought not be any real read-write data.
> +                 * But since we manipulated the segment layout,
> +                 * we have to put these sections somewhere.
> +                 */
> +                *(.data*)
> +                *(.sdata*)
> +                *(.got.plt) *(.got)
> +                *(.gnu.linkonce.d.*)
> +                *(.bss*)
> +                *(.dynbss*)
> +                *(.gnu.linkonce.b.*)
> +        }
> +
> +        .rodata         : { *(.rodata*) }
> +        .hash           : { *(.hash) }
> +        .gnu.hash       : { *(.gnu.hash) }
> +        .dynstr         : { *(.dynstr) }
> +        .gnu.version    : { *(.gnu.version) }
> +        .gnu.version_d  : { *(.gnu.version_d) }
> +        .gnu.version_r  : { *(.gnu.version_r) }
> +        .eh_frame_hdr   : { *(.eh_frame_hdr) }  :load :eh_frame_hdr
> +        .eh_frame       : { *(.eh_frame) }      :load
> +
> +        .text           : { *(.text*) }         :load
> +}
> diff --git a/linux-user/s390x/vdso.so b/linux-user/s390x/vdso.so
> new file mode 100755
> index 0000000000000000000000000000000000000000..64130f6f335269b03291653d0=
06225b365be9cd9
> GIT binary patch
> literal 3464
> zcmcguUuaup6hAlrn#R#}B6HHJ6^h8v3s#wtDI{HzWs-HJcB~u1U2JZX*fw`0w>2I9
> z>4SqkSsXs>VMq|PDvEm&1Rwf1RK!O?(CHKhzDz`4)-9g%edpXip_vbYU-<6tJHK<z
> zcW%!8&bjyXe5nwL7~qX4?8S9}P@0U^51wZ!4ROf8FziM-fitG{$m!98#y(98LK0<)
> zF`)T=3D*Tk6C2o94N!O8KAbs})9bp<|Z(f=3DFCiu>y{lI$0|t_^w-9%V;CvX_ZVV@~UP
> z5ysh1P<-w|K6-fSIDGtl`ke<)|Mc0}bJcWb@yj2!fBy7s_8}PJ^{b5Jk0Yw$Io;cT
> zvAm@bv#$o5>1TjUWL@)+V!Xt77o&O(PPe<Q<=3DACHly9+~a!c|JEyu*4)&DD)cLVIw
> z5#zsb<Wa;~pHGlXgYG*Q;1!7%(pLlg1FRr>!{_5F56Dq|HugaG54H=3D!y#f0xtl;=3D^
> z{(|Oe9c6~jI}MdzM5-AY|8oAd5niPp<$=3Dq-bPi}udYXw&GFgmg;C+@!7ys^{eeuHj
> z*T4PgtbX)Xd*k=3D9hda69Q>Wkk@x$ybu&hP9*|3+as_nY<W!qV(l-GQAe#x0%6x|MV
> z({A}JZZUsm#g|+4YSVUCnhl?7x|Yu_)f+4A$5tyX=3DfIO@%P}8^(vhj-bJm1;z?^s*
> zZyoa${1Id5U*x4{=3D^0Ud(KFC>Lm7yGF<^c5IqMK$gD%EM^dJJ&HRX_=3DUlHe3oHd-=3D
> zIM1UMJ^v4I(xAP;I6DJId&n5swY$R)f#T6@<J<?ip>HFFH}{sl84Bv3LERZ;$NK58
> z{sq)6-9i5f>gc{kWq<MCyxE<;cJ)RF##2)YW1BbO^1yAM-@MO=3DrJ%1aeh1xCVO{Fw
> z)F*fkeFq*cPKoqGZHhdf^Ke}tPv;Sb*Qb<(B%kYOMiG2Lp8K5cgQ7#8>nFM;93k>t
> zPf{jYi+obAVwW^}{2=3DpE|4KxA?w|60@a(yd##JBHtcojrD!7kfczq<42ikk5{qOhf
> zLwR_@?>o{q)cHH)^P&ED(&rPwe&_gnsNbFI)9)_$_Mtxep3ldxa1KVn%AK6b9zAjh
> zOC8^LR=3D#KzX0k`~RxvjN*5T5z$!y6wRwz85pS5PQlcl`n_k`ZI;q{zQa|v~hox4`3
> zdw3>(zwsz90(Cq9v$eMDmS044n;L7fYB;V9W@W8WUarrp1=3D=3DE(-7=3DWf#)?@hw`!Vq
> zo0?g*o2|Oj2nkjNOuJ?+G|S7jRjZ(-NMO2l+m)mAUvLDS<$WUcH>WrB>T|p&K(J6A
> zLY*8iECCvFZapMYV$hoF3cmya_T!ZA42~~#E(lv_L;l=3D1Jb$XEi2%>>r49tu`x(u=3D
> zA@PZzo*QQk$Cth#sCp{ztt`c#Fpb|mfA{!rX*tRW8I*VOC$q_bj^j&u1tHXb&|dOD
> z{?B3jE-i3~KihkKi}D<d&vwfGMDKSTwpH#&f{;dk%D?!@|3?ZIaLWBi{OhE^eHgv(
> zV@-Q~TZwdtd;FzO3c^KkWDLfCE#RNfdg)Vw>YW<g!b>ds%Kr-5;5sp;iO3^}^sP;K
> oq#^O?{L#B0m|N2GNEUhVg)ofre@WbfvycCv+~*tYC*b-21AbI{0ssI2
>
> literal 0
> HcmV?d00001


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


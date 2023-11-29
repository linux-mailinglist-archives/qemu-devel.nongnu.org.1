Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD247FDD0C
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 17:32:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8NTB-0001jN-CP; Wed, 29 Nov 2023 11:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8NT9-0001iw-CG
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:31:23 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8NT6-00020X-T7
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:31:23 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40b3e7f2fd9so39008725e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 08:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701275479; x=1701880279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1fOb6juAQjKi//IgLnj99cs/uKKChu+2L5r1kRpmHs=;
 b=urbVXYFcKdsWkivCKGa4dGO5M5L+47uN7h5Y9xwlP3Q+9QgSINeJYzHSWoi0S4seBT
 OnoH1uptssoO77VeHhNHAz4A29eK8Ag881mwqYpv4Ah+H0dDJBIloHDH/JOVH8J45nWa
 w5OGulFs8EAk08EPGksdTDfY1H1j86Jy5vV0pmx1/iR804VHPN6vEATC2caWkRnNJNNk
 mvvRURdhZ94Fd/HIiblomvXxtMtiIA26WVUF+a3uBDn02w+v/xB9fTbHnoaPUSBbSF36
 1tKfWf8E6YLG1WsWfQkJ2D93MseBsmlTm+O4o3V/ErmczHokrPx67pYYyE0jifPg6t5M
 6yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701275479; x=1701880279;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B1fOb6juAQjKi//IgLnj99cs/uKKChu+2L5r1kRpmHs=;
 b=TY8Y2esb/gj7bfjxrHfTaDipzyYYiwIftCTnatO1GczyQ71eUts2xuS++DXOOsg4MK
 UAju6gFf1HQpSxgDHzd+4WkN/fhxxXTNTpq0sjCPDyxtSJQtDrYBHJvA8pUoMhpH049p
 0SUbizZYGh7m+bmH6e1BU4kAS6KfP1nwBpH7CMbtrtS2l/rFiRqtfjLsNecsi1lsJRSV
 Ci44hGjY8KyXTP8ohtzBEacsLpBZ6hoSCSs5b+dF6LbNMHRsWa8vumPjmPvODeSDQOiE
 bgGW0zQg0YUvMKnyKcWaznRm3QsBz9RL+aBE2U1r07SFb5XLFVS+T0gQKaAoexYLAzRQ
 316g==
X-Gm-Message-State: AOJu0YyQb61gpi88zpmqficsr7l0kFOvNWsJ0Hy8TsdJ0t1vykqyH1H7
 WD9tFK/xZOsPZXld8euVL4HwXA==
X-Google-Smtp-Source: AGHT+IFZQ/ljJkP8uY+DqWbdgqBnK/h7yCiCBRsIN5TaHDLLEMjujvif+GZ5g5s6pYpY0gvjgF7VuA==
X-Received: by 2002:a05:600c:5486:b0:40b:4aee:ea9e with SMTP id
 iv6-20020a05600c548600b0040b4aeeea9emr3648966wmb.17.1701275478647; 
 Wed, 29 Nov 2023 08:31:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t17-20020a05600c451100b00407460234f9sm2742498wmo.21.2023.11.29.08.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:31:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D54B05F7AF;
 Wed, 29 Nov 2023 16:31:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: Re: [PATCH v3 20/20] mcdstub: updated MAINTAINERS file and fully
 activated the mcdstub in the meson build system
In-Reply-To: <20231107130323.4126-21-nicolas.eder@lauterbach.com> (Nicolas
 Eder's message of "Tue, 7 Nov 2023 14:03:23 +0100")
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
 <20231107130323.4126-21-nicolas.eder@lauterbach.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Wed, 29 Nov 2023 16:31:17 +0000
Message-ID: <87r0k88qsq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> ---
>  MAINTAINERS            | 11 +++++++++++
>  mcdstub/meson.build    | 15 +++++++++++++++
>  meson.build            |  1 +
>  target/arm/meson.build |  1 +
>  4 files changed, 28 insertions(+)
>  create mode 100644 mcdstub/meson.build
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd8d6b140f..58decd218c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2908,6 +2908,17 @@ F: tests/tcg/multiarch/gdbstub/
>  F: scripts/feature_to_c.py
>  F: scripts/probe-gdb-support.py
>=20=20
> +MCD stub
> +M: Nicolas Eder <nicolas.eder@lauterbach.com>
> +R: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +S: Maintained
> +F: mcdstub/*
> +F: include/mcdstub/*
> +F: include/qemu/debug.h
> +F: debug/debug-common.c
> +F: debug/debug-mcd.c
> +F: target/arm/mcdstub.c
> +
>  Memory API
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  M: Peter Xu <peterx@redhat.com>
> diff --git a/mcdstub/meson.build b/mcdstub/meson.build
> new file mode 100644
> index 0000000000..1f9315f9f5
> --- /dev/null
> +++ b/mcdstub/meson.build
> @@ -0,0 +1,15 @@
> +# only system emulation is supported over mcd
> +mcd_system_ss =3D ss.source_set()
> +mcd_system_ss.add(files('mcdstub.c', '../debug/debug-mcd.c'))
> +mcd_system_ss =3D mcd_system_ss.apply(config_host, strict: false)
> +
> +libmcd_system =3D static_library('mcd_system',
> +                                mcd_system_ss.sources() + genh,
> +                                name_suffix: 'fa',
> +                                build_by_default: have_system)
> +
> +mcd_system =3D declare_dependency(link_whole: libmcd_system)
> +system_ss.add(mcd_system)
> +
> +# used for gdb (user/system) and mcd:
> +common_ss.add(files('../debug/debug-common.c'))
> diff --git a/meson.build b/meson.build
> index dcef8b1e79..6dfa49160c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3348,6 +3348,7 @@ subdir('crypto')
>  subdir('ui')
>  subdir('hw')
>  subdir('gdbstub')
> +subdir('mcdstub')

OK this is fine *if* you haven't already got code attempting to link to
bits of your stub. You can either deal with this by declaring stub
functions where the real symbol doesn't exist or having empty inlines
when the feature isn't enabled.

That said even here the build fails for me:

  FAILED: mcdstub/libmcd_system.fa.p/mcdstub.c.o=20
  cc -m64 -mcx16 -Imcdstub/libmcd_system.fa.p -Imcdstub -I../../mcdstub -I.=
 -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/glib-2.0 -I/usr/lib/x86_64-=
linux-gnu/glib-2.0/include -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -=
Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wundef -Wwrite-strings=
 -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -Wold-style-dec=
laration -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2=
k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-la=
bels -Wexpansion-to-defined -Wimplicit-fallthrough=3D2 -Wmissing-format-att=
ribute -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi -Wsha=
dow=3Dlocal -isystem /home/alex/lsrc/qemu.git/linux-headers -isystem linux-=
headers -iquote . -iquote /home/alex/lsrc/qemu.git -iquote /home/alex/lsrc/=
qemu.git/include -iquote /home/alex/lsrc/qemu.git/host/include/x86_64 -iquo=
te /home/alex/lsrc/qemu.git/host/include/generic -iquote /home/alex/lsrc/qe=
mu.git/tcg/i386 -pthread -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFIL=
E_SOURCE -fno-strict-aliasing -fno-common -fwrapv -fPIE -MD -MQ mcdstub/lib=
mcd_system.fa.p/mcdstub.c.o -MF mcdstub/libmcd_system.fa.p/mcdstub.c.o.d -o=
 mcdstub/libmcd_system.fa.p/mcdstub.c.o -c ../../mcdstub/mcdstub.c
  ../../mcdstub/mcdstub.c: In function =E2=80=98mcdserver_start=E2=80=99:
  ../../mcdstub/mcdstub.c:286:25: error: =E2=80=98,wait=3Doff,nodelay=3Don,=
server=3Don=E2=80=99 directive output may be truncated writing 30 bytes int=
o a region of size between 1 and 128 [-Werror=3Dformat-truncation=3D]
    286 |                      "%s,wait=3Doff,nodelay=3Don,server=3Don", de=
vice);
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In file included from /usr/include/stdio.h:906,
                   from /home/alex/lsrc/qemu.git/include/qemu/osdep.h:114,
                   from ../../mcdstub/mcdstub.c:5:
  In function =E2=80=98snprintf=E2=80=99,
      inlined from =E2=80=98mcdserver_start=E2=80=99 at ../../mcdstub/mcdst=
ub.c:285:13:
  /usr/include/x86_64-linux-gnu/bits/stdio2.h:54:10: note: =E2=80=98__built=
in___snprintf_chk=E2=80=99 output between 31 and 158 bytes into a destinati=
on of size 128
     54 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL =
- 1,
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
     55 |                                    __glibc_objsize (__s), __fmt,
        |                                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     56 |                                    __va_arg_pack ());
        |                                    ~~~~~~~~~~~~~~~~~
  ../../mcdstub/mcdstub.c: In function =E2=80=98cmd_parse_params=E2=80=99:
  ../../mcdstub/mcdstub.c:716:13: error: =E2=80=98__builtin___strncpy_chk=
=E2=80=99 output truncated before terminating nul copying as many bytes fro=
m a string as its length [-Werror=3Dstringop-truncation]
    716 |             strncpy(data_buffer, remaining_data, strlen(remaining=
_data));
        |             ^
  ../../mcdstub/mcdstub.c:716:13: note: length computed here
    716 |             strncpy(data_buffer, remaining_data, strlen(remaining=
_data));
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
  In file included from /usr/include/glib-2.0/glib.h:33,
                   from /home/alex/lsrc/qemu.git/include/glib-compat.h:32,
                   from /home/alex/lsrc/qemu.git/include/qemu/osdep.h:161:
  /usr/include/glib-2.0/glib/garray.h: In function =E2=80=98parse_reg_xml=
=E2=80=99:
  /usr/include/glib-2.0/glib/garray.h:69:54: error: =E2=80=98reg_data=E2=80=
=99 may be used uninitialized [-Werror=3Dmaybe-uninitialized]
     69 | #define g_array_index(a,t,i)      (((t*) (void *) (a)->data) [(i)=
])
        |                                                      ^~
  ../../mcdstub/mcdstub.c:1081:13: note: =E2=80=98reg_data=E2=80=99 was dec=
lared here
   1081 |     GArray *reg_data;
        |             ^~~~~~~~
  ../../mcdstub/mcdstub.c:1136:28: error: =E2=80=98internal_id=E2=80=99 may=
 be used uninitialized [-Werror=3Dmaybe-uninitialized]
   1136 |                 internal_id++;
        |                 ~~~~~~~~~~~^~
  ../../mcdstub/mcdstub.c:1074:14: note: =E2=80=98internal_id=E2=80=99 was =
declared here
   1074 |     uint32_t internal_id;
        |              ^~~~~~~~~~~
  cc1: all warnings being treated as errors


See also:

  https://gitlab.com/stsquad/qemu/-/pipelines/1089441465/failures

Please ensure next post that you can at least pass a "make all" of a
normally configured build and that each intermediate stage also builds.

>=20=20
>  if enable_modules
>    libmodulecommon =3D static_library('module-common', files('module-comm=
on.c') + genh, pic: true, c_args: '-DBUILD_DSO')
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 5d04a8e94f..84fedbc6e1 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -3,6 +3,7 @@ arm_ss.add(files(
>    'cpu.c',
>    'debug_helper.c',
>    'gdbstub.c',
> +  'mcdstub.c',
>    'helper.c',
>    'vfp_helper.c',
>  ))

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


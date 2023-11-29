Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 132287FDDC6
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 17:58:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Nri-0003nh-Dl; Wed, 29 Nov 2023 11:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8Nrf-0003n1-1i
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:56:43 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8Nrc-0000aB-VV
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 11:56:42 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40b2fa4ec5eso53761625e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 08:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701276999; x=1701881799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlUMKlMaZlQAEHdQt1y0xvOH5rM/iAl9hRenTp4hjLA=;
 b=aCeGSBiIZeHGSqrWq1D21QUygfFRp4MtLzeCn8fHAMq+J7ForDdkaUxbD5mAK4zMuM
 agQuzmOFawR0xSMcmIGz5w4BXuxd+IecH4VZOI85F0Yv3VNql0XFQvC3hYC+i/wWova4
 ezhi3ceUqxqgQWZAm3ArACDK2AvEzzSjkF19NyUihdTjeS9Px1MHYx1sXjRmfsJlV5eI
 zr84lXjiTFc22uJkk1KSN1Vb1DjU53+oxm2kckRHEkrsfrZ+tl18Xfi1wpXtiuE45l/1
 wBw59KAnfN7d19j/du5AalvvqcjyQ2M2MInyYedeqMsahkfY22CfIcdlDgCRBQL1biCQ
 ceNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701276999; x=1701881799;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mlUMKlMaZlQAEHdQt1y0xvOH5rM/iAl9hRenTp4hjLA=;
 b=wIZJ3P2kbc8fNSSvvEzpK6CoyuqO7HVDYSZRXOcfEMgh7stmmTbPcjQsRthcKsuica
 PP4SFT1prY+NGqaAeBhXOmsjokVdQAlsMkLBcvIc9rfvKExDlhWoCxkZhcAAGAZEkshg
 J+gMsRVjxtMvuB1df56vyRQzvMhdAH7OXtWslYl3AI6AI36vPMiQX4P+ttUFijI/eL0B
 Ss19RJ+kwEmDOBmOpty0Ybg00xdSNORPC0fQTJhUz2Vo8IjCOvtKA+8WDcXgUHRbmHwX
 MPkwIaWZoBzdy/SNg7dGTOX27+jLjTkRU4Es7HuhBY3NN9Y+ztzfwE3MAZVJw+GMzIqT
 AOrg==
X-Gm-Message-State: AOJu0YwzbOcobAxx0sB0IclxrfV5Hs6O7vc+RjGnhKxImhYVqwKEM+di
 6LqkO4dTWzqfij287pZanefDQg==
X-Google-Smtp-Source: AGHT+IGViT6AH+QV3b7j4Sun94SsNLqtBuc/B4QpbkrL2/WYJvcZySuEnucsl2C2t3FaF1i1JxttXA==
X-Received: by 2002:a05:600c:4f50:b0:40b:4193:2469 with SMTP id
 m16-20020a05600c4f5000b0040b41932469mr10888399wmq.3.1701276998855; 
 Wed, 29 Nov 2023 08:56:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g7-20020a05600c4ec700b0040b34409d43sm2786267wmq.11.2023.11.29.08.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:56:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 32FA45F7AF;
 Wed, 29 Nov 2023 16:56:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: <peter.maydell@linaro.org>,  <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>,  <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>,  <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>,  <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: Re: [RFC/PATCH v0 03/12] gunyah: Basic support
In-Reply-To: <20231011165234.1323725-4-quic_svaddagi@quicinc.com> (Srivatsa
 Vaddagiri's message of "Wed, 11 Oct 2023 16:52:25 +0000")
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-4-quic_svaddagi@quicinc.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Wed, 29 Nov 2023 16:56:38 +0000
Message-ID: <87cyvs8pmh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Srivatsa Vaddagiri <quic_svaddagi@quicinc.com> writes:

> Add a new accelerator, gunyah, with basic functionality of creating a
> VM. Subsequent patches will add support for other functions required to
> run a VM.
>
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>

Hmm this failed to build:

  FAILED: libqemu-aarch64-softmmu.fa.p/accel_gunyah_gunyah-all.c.o=20
  cc -m64 -mcx16 -Ilibqemu-aarch64-softmmu.fa.p -I. -I../.. -Itarget/arm -I=
../../target/arm -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/pixman-1 -I=
/usr/include/capstone -I/usr/include/spice-server -I/usr/include/spice-1 -I=
/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fdiagno=
stics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-=
protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes -Wstrict-prot=
otypes -Wredundant-decls -Wold-style-declaration -Wold-style-definition -Wt=
ype-limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers =
-Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wimpli=
cit-fallthrough=3D2 -Wmissing-format-attribute -Wno-missing-include-dirs -W=
no-shift-negative-value -Wno-psabi -Wshadow=3Dlocal -isystem /home/alex/lsr=
c/qemu.git/linux-headers -isystem linux-headers -iquote . -iquote /home/ale=
x/lsrc/qemu.git -iquote /home/alex/lsrc/qemu.git/include -iquote /home/alex=
/lsrc/qemu.git/host/include/x86_64 -iquote /home/alex/lsrc/qemu.git/host/in=
clude/generic -iquote /home/alex/lsrc/qemu.git/tcg/i386 -pthread -D_GNU_SOU=
RCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-=
common -fwrapv -fPIE -isystem../../linux-headers -isystemlinux-headers -DNE=
ED_CPU_H '-DCONFIG_TARGET=3D"aarch64-softmmu-config-target.h"' '-DCONFIG_DE=
VICES=3D"aarch64-softmmu-config-devices.h"' -MD -MQ libqemu-aarch64-softmmu=
.fa.p/accel_gunyah_gunyah-all.c.o -MF libqemu-aarch64-softmmu.fa.p/accel_gu=
nyah_gunyah-all.c.o.d -o libqemu-aarch64-softmmu.fa.p/accel_gunyah_gunyah-a=
ll.c.o -c ../../accel/gunyah/gunyah-all.c
  ../../accel/gunyah/gunyah-all.c:21:10: fatal error: linux-headers/linux/g=
unyah.h: No such file or directory
     21 | #include "linux-headers/linux/gunyah.h"
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  compilation terminated.

Easiest solution:

  add PATCH after 02 importing headers

I usually add a !MERGE to the summary just to remind myself that we'll
need to properly update the headers before we merge. e.g: linux-headers: up=
date to v6.6-with-gunyah (!MERGE)

There are some other merge failures bellow so perhaps its time to do a
re-base and send v1?

Whats the current state of the kernel merge?

<snip>
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 9da3fe299b..0c95f79645 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -112,6 +112,7 @@ meson_options_help() {
>    printf "%s\n" '  guest-agent-msi Build MSI package for the QEMU Guest =
Agent'
>    printf "%s\n" '  hax             HAX acceleration support'
>    printf "%s\n" '  hvf             HVF acceleration support'
> +  printf "%s\n" '  gunyah          Gunyah acceleration support'

need rebasing due to hax drop

>    printf "%s\n" '  iconv           Font glyph conversion support'
>    printf "%s\n" '  jack            JACK sound support'
>    printf "%s\n" '  keyring         Linux keyring support'
> @@ -312,6 +313,8 @@ _meson_option_parse() {
>      --disable-guest-agent) printf "%s" -Dguest_agent=3Ddisabled ;;
>      --enable-guest-agent-msi) printf "%s" -Dguest_agent_msi=3Denabled ;;
>      --disable-guest-agent-msi) printf "%s" -Dguest_agent_msi=3Ddisabled =
;;
> +    --enable-gunyah) printf "%s" -Dgunyah=3Denabled ;;
> +    --disable-gunyah) printf "%s" -Dgunyah=3Ddisabled ;;

ditto.

>      --enable-hax) printf "%s" -Dhax=3Denabled ;;
>      --disable-hax) printf "%s" -Dhax=3Ddisabled ;;
>      --enable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=3Dtr=
ue ;;
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 96158093cc..a712f1a3b3 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -33,6 +33,7 @@
>  #include "hw/qdev-properties.h"
>  #include "internals.h"
>  #include "cpregs.h"
> +#include "sysemu/gunyah.h"

This should be moved up next to the other accelerator includes.

>=20=20
>  void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>  {
> @@ -686,7 +687,7 @@ static void aarch64_host_initfn(Object *obj)
>=20=20
>  static void aarch64_max_initfn(Object *obj)
>  {
> -    if (kvm_enabled() || hvf_enabled()) {
> +    if (kvm_enabled() || hvf_enabled() || gunyah_enabled()) {
>          /* With KVM or HVF, '-cpu max' is identical to '-cpu host' */
>          aarch64_host_initfn(obj);
>          return;
> @@ -706,7 +707,7 @@ static const ARMCPUInfo aarch64_cpus[] =3D {
>      { .name =3D "cortex-a57",         .initfn =3D aarch64_a57_initfn },
>      { .name =3D "cortex-a53",         .initfn =3D aarch64_a53_initfn },
>      { .name =3D "max",                .initfn =3D aarch64_max_initfn },
> -#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
> +#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_GUNYAH)
>      { .name =3D "host",               .initfn =3D aarch64_host_initfn },
>  #endif
>  };

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


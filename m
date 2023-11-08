Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC947E5668
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 13:38:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0hnf-0004A3-6h; Wed, 08 Nov 2023 07:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0hnc-00049k-TP
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 07:36:48 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0hna-0007Ei-VD
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 07:36:48 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6ce2ea3a944so4070832a34.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 04:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699447005; x=1700051805; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4bo8b2wUFyf73l5iWW8VUnux5zZ9rzp0eCSEuVcZiQw=;
 b=GgDOYS2CbGpUTCuWBiLhFlvyi5s0GqxM1cKbg5FD2C5it3ly7Oj/BxqW8/Z7QR1Nc9
 kh0AOGimCHgTORxAZnjFBuPIxSE5VrnRUGv5TvVW+0+HHkXWimgdb8wBL4wEjVt7HpfH
 EZ18XVjWOWozndolAjnOo8x8t5rTwi8dFvjcL9IDYvXIRHuiWfhFN1YyUz76ysdOku0T
 zEXuC5+OXdIfJHaqmQGG1DHOwzXaheBLRi/TiiDz3KRWPn1NrdzOjzib2mSqquoZxtSR
 xEdFfZdQU63ap6J05aOhHc0TjTD7diF5qYD7pNKUqzyK+AOERIauO3OihcJfmRBOyLWx
 uNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699447005; x=1700051805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bo8b2wUFyf73l5iWW8VUnux5zZ9rzp0eCSEuVcZiQw=;
 b=UzGdUYUppJuPaT2mB8yla/GmYLRFZanI9a2ELlGC4FYYFj2qnc86b3XLj6wrXKBrqj
 y0/A43FadGyaoTgodYKsslcX//f8X6HeZ9gSaq6ta8+8vXxCZGt/o3/PCdCrykZxFFNt
 Lb5prMCyl/Zi8gTZO9W3Te/eEPc0AXjaSA+QaDv7AwvsvSToVn6PqeUnVHn5RYy8RY7e
 Gq8eiDhpnBHPdtF3oeeQRktFfqtL4ZSaxHG2rWw1LRVYdmZI5aJo88Z2Uekl5zBo68V3
 HfhEE/+Q8ci+GNFcL8fTDGgIOPDp+VYztIrHpBotJvXLAKXJQGLBF+Kpqymwzqq45lJE
 bHaw==
X-Gm-Message-State: AOJu0Ywq6jr+gfqu5J4/iyE+khWajQ7O8MoxhVN99ae6I9G29eBKzgSV
 Q+7ET+1xjlFXAndBJhVHBuvPHcyjO9XHEMspBtM=
X-Google-Smtp-Source: AGHT+IES57Y6drx+cGcEtezFTp1iiTZz2Ncn2mIwm/t55SFwxRhrb9aDd5cCFoBxuYDEF4EybT5IDEdIQZRRQdFbhoY=
X-Received: by 2002:a05:6830:16d9:b0:6b9:2e88:79cc with SMTP id
 l25-20020a05683016d900b006b92e8879ccmr1565681otr.19.1699447005292; Wed, 08
 Nov 2023 04:36:45 -0800 (PST)
MIME-Version: 1.0
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 8 Nov 2023 20:36:33 +0800
Message-ID: <CAJSP0QU5eNAVBskQDNq7eSHvhdVcaunAMWUxYEWWkF0gOjp-CQ@mail.gmail.com>
Subject: Re: [PULL 00/23] Final test, gdbstub, plugin and gitdm updates for 8.2
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 7 Nov 2023 at 22:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit 462ad017ed76889d46696a3581e1b52343f9b6=
83:
>
>   Merge tag 'pixman-pull-request' of https://gitlab.com/marcandre.lureau/=
qemu into staging (2023-11-07 19:00:03 +0800)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-halloween-omnibus-071123-=
1
>
> for you to fetch changes up to 00da668de6856d912cd75474ba759927e29d0e49:
>
>   Revert "tests/tcg/nios2: Re-enable linux-user tests" (2023-11-07 14:18:=
29 +0000)
>
> ----------------------------------------------------------------
> Final test, gdbstub, plugin and gitdm updates for 8.2
>
>   - fix duplicate register in arm xml
>   - hide various duplicate system registers from gdbstub
>   - add new gdb register test to the CI (skipping s390x/ppc64 for now)
>   - introduce GDBFeatureBuilder
>   - move plugin initialisation to after vCPU init completes
>   - enable building TCG plugins on Windows platform

Hi Alex,
Please take a look at the following CI failure:

i686-w64-mingw32-gcc -m32 -o tests/plugin/libempty.dll
plugins/qemu_plugin_api.lib tests/plugin/libempty.dll.p/empty.c.obj
tests/plugin/libempty.dll.p/.._.._contrib_plugins_win32_linker.c.obj
-Wl,--allow-shlib-undefined -shared -Wl,--start-group
-Wl,--out-implib=3Dtests/plugin/libempty.dll.a -fstack-protector-strong
-Wl,--no-seh -Wl,--nxcompat -Wl,--dynamicbase -Wl,--warn-common
/usr/i686-w64-mingw32/sys-root/mingw/lib/libglib-2.0.dll.a
/usr/i686-w64-mingw32/sys-root/mingw/lib/libintl.dll.a
/usr/i686-w64-mingw32/sys-root/mingw/lib/libgmodule-2.0.dll.a
-lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -loleaut32
-luuid -lcomdlg32 -ladvapi32 -Wl,--end-group
/usr/lib/gcc/i686-w64-mingw32/12.2.1/../../../../i686-w64-mingw32/bin/ld:
tests/plugin/libempty.dll.p/empty.c.obj: in function
`qemu_plugin_install':
/builds/qemu-project/qemu/build/../tests/plugin/empty.c:30: undefined
reference to `_imp__qemu_plugin_register_vcpu_tb_trans_cb'
collect2: error: ld returned 1 exit status

https://gitlab.com/qemu-project/qemu/-/jobs/5487689202

Thanks,
Stefan

>   - various gitdm updates
>   - some mailmap fixes
>   - disable testing for nios2 signals which have regressed
>
> ----------------------------------------------------------------
> Akihiko Odaki (5):
>       default-configs: Add TARGET_XML_FILES definition
>       gdbstub: Add num_regs member to GDBFeature
>       gdbstub: Introduce gdb_find_static_feature()
>       gdbstub: Introduce GDBFeatureBuilder
>       cpu: Call plugin hooks only when ready
>
> Alex Benn=C3=A9e (13):
>       gdb-xml: fix duplicate register in arm-neon.xml
>       target/arm: mark the 32bit alias of PAR when LPAE enabled
>       target/arm: hide all versions of DBGD[RS]AR from gdbstub
>       target/arm: hide aliased MIDR from gdbstub
>       tests/tcg: add an explicit gdbstub register tester
>       tests/avocado: update the tcg_plugins test
>       configure: tell meson and contrib_plugins about DLLTOOL
>       gitlab: add dlltool to Windows CI
>       contrib/gitdm: Add Rivos Inc to the domain map
>       contrib/gitdm: map HiSilicon to Huawei
>       contrib/gitdm: add Daynix to domain-map
>       mailmap: fixup some more corrupted author fields
>       Revert "tests/tcg/nios2: Re-enable linux-user tests"
>
> Greg Manning (4):
>       plugins: add dllexport and dllimport to api funcs
>       plugins: make test/example plugins work on windows
>       plugins: disable lockstep plugin on windows
>       plugins: allow plugins to be enabled on windows
>
> luzhipeng (1):
>       contrib/gitdm: add domain-map for Cestc
>
>  MAINTAINERS                                        |   2 +-
>  configure                                          |  13 +-
>  configs/targets/loongarch64-linux-user.mak         |   1 +
>  meson.build                                        |   5 +
>  include/exec/gdbstub.h                             |  59 ++++++
>  include/qemu/qemu-plugin.h                         |  50 +++++-
>  contrib/plugins/win32_linker.c                     |  34 ++++
>  cpu-target.c                                       |  11 --
>  gdbstub/gdbstub.c                                  |  78 ++++++++
>  hw/core/cpu-common.c                               |  10 ++
>  target/arm/debug_helper.c                          |  10 +-
>  target/arm/helper.c                                |  37 ++--
>  .gitlab-ci.d/windows.yml                           |   1 +
>  .mailmap                                           |   2 +
>  contrib/gitdm/domain-map                           |   4 +
>  contrib/plugins/Makefile                           |  26 ++-
>  gdb-xml/arm-neon.xml                               |   2 +-
>  plugins/meson.build                                |  19 ++
>  scripts/feature_to_c.py                            |  46 ++++-
>  tests/avocado/tcg_plugins.py                       |  28 +--
>  tests/plugin/meson.build                           |  14 +-
>  tests/tcg/multiarch/Makefile.target                |  11 +-
>  tests/tcg/multiarch/gdbstub/registers.py           | 197 +++++++++++++++=
++++++
>  tests/tcg/multiarch/system/Makefile.softmmu-target |  13 +-
>  tests/tcg/nios2/Makefile.target                    |  11 ++
>  tests/tcg/ppc64/Makefile.target                    |   7 +
>  tests/tcg/s390x/Makefile.target                    |   4 +
>  27 files changed, 637 insertions(+), 58 deletions(-)
>  create mode 100644 contrib/plugins/win32_linker.c
>  create mode 100644 tests/tcg/multiarch/gdbstub/registers.py
>  create mode 100644 tests/tcg/nios2/Makefile.target
>
> --
> 2.39.2
>
>


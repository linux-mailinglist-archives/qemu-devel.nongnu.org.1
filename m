Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B79FC7E598B
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 15:57:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0jyh-0003tc-V7; Wed, 08 Nov 2023 09:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0jye-0003tT-UZ
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:56:20 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0jyb-0003Hd-Ko
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:56:20 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507b96095abso8878826e87.3
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 06:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699455375; x=1700060175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPFcutYYkSZkoYp1OhEyni/mSIgK1DkelOSW38ENUq4=;
 b=nkLbvaVJB1r4t7mTXQoE6cgDO8I3oTBXNYR4inrb0HZhBRlSkI2mrLcp5FnjXNxAp+
 zm3G8wv0UP84HleXzvytdlKKtWlhNhDX48m54u5B+WHkiF3NuBGWLNjQguVm0e9jv3ls
 mmvB+rO0HkOPyy92DKEJiCsQf2JQQa9McgWPce6TzstsbnnDZ4JCIyf2P8VSimGsx77C
 SN4lmkXmwPI3K4mh+p2tzHondBE03EZQey5kpAjcdpgzHKIMWdcb6EBdCRnblOk/3O8T
 HQUDHqk2chpd6P/tKIzGBWD0MKG86KQXznnSY7I/FOpFUiKwWtkoIQTBuO00xFwID0u8
 6CPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699455375; x=1700060175;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qPFcutYYkSZkoYp1OhEyni/mSIgK1DkelOSW38ENUq4=;
 b=dk85uGmDswc2Tjfu0oRkeb51ewydzgrcvjARC3WCKBvb6Hz0RuGnh4hsMY5KWNwR9I
 tV6RATG0K6hS3GrwJ4fAxXHacrymSCPqGZ3arCELbSW+zUDfN8TTxD/HbRmAf++N8nSc
 6IXhB6RqJC2MFEm9EJmD1N2HVjqXMvPJFLxLz0MkJNTXIpo5/xqxtVm7o5UHqSuMXx6P
 L3zt83Ha4Urm5ObiRSgCIyNlyzCGpBi9sbeeswaqXQFFbKfD3pqgyOsdh+PaRzrUGOf7
 Cwb91qcA9ihNrIIcom2QnFS8BZQCHZDTSXShTeG72xhh5ElKYfPXXSBOlNgIqn8bcCnF
 xjyQ==
X-Gm-Message-State: AOJu0Yzt8BbpSmB4KYJSOE8oh5+Twe62l0YXrpvuPfrJXj31ONUm9ad+
 Dji1wPyLzTsCK2rzZjC2eARvjQ==
X-Google-Smtp-Source: AGHT+IFIgkg64/HwsYGKTmcOXp+iaqhFXLPa0m+H81BJiL+LHqSCgfuvUWkod8aD8tbaaBaQxgGMwA==
X-Received: by 2002:a05:6512:210b:b0:509:dd0:9414 with SMTP id
 q11-20020a056512210b00b005090dd09414mr1447609lfr.24.1699455374908; 
 Wed, 08 Nov 2023 06:56:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4bd2000000b0032fb46812c2sm5160226wrt.12.2023.11.08.06.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 06:56:14 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0DC6F5F751;
 Wed,  8 Nov 2023 14:56:14 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Greg Manning <gmanning@rapitasystems.com>
Subject: Re: [PULL 00/23] Final test, gdbstub, plugin and gitdm updates for 8.2
In-Reply-To: <CAJSP0QU5eNAVBskQDNq7eSHvhdVcaunAMWUxYEWWkF0gOjp-CQ@mail.gmail.com>
 (Stefan Hajnoczi's message of "Wed, 8 Nov 2023 20:36:33 +0800 (2
 hours, 16 minutes, 10 seconds ago)")
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
 <CAJSP0QU5eNAVBskQDNq7eSHvhdVcaunAMWUxYEWWkF0gOjp-CQ@mail.gmail.com>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Wed, 08 Nov 2023 14:56:14 +0000
Message-ID: <87edh09tv5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, 7 Nov 2023 at 22:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> The following changes since commit 462ad017ed76889d46696a3581e1b52343f9b=
683:
>>
>>   Merge tag 'pixman-pull-request' of https://gitlab.com/marcandre.lureau=
/qemu into staging (2023-11-07 19:00:03 +0800)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/stsquad/qemu.git tags/pull-halloween-omnibus-071123=
-1
>>
>> for you to fetch changes up to 00da668de6856d912cd75474ba759927e29d0e49:
>>
>>   Revert "tests/tcg/nios2: Re-enable linux-user tests" (2023-11-07 14:18=
:29 +0000)
>>
>> ----------------------------------------------------------------
>> Final test, gdbstub, plugin and gitdm updates for 8.2
>>
>>   - fix duplicate register in arm xml
>>   - hide various duplicate system registers from gdbstub
>>   - add new gdb register test to the CI (skipping s390x/ppc64 for now)
>>   - introduce GDBFeatureBuilder
>>   - move plugin initialisation to after vCPU init completes
>>   - enable building TCG plugins on Windows platform
>
> Hi Alex,
> Please take a look at the following CI failure:
>
> i686-w64-mingw32-gcc -m32 -o tests/plugin/libempty.dll
> plugins/qemu_plugin_api.lib tests/plugin/libempty.dll.p/empty.c.obj
> tests/plugin/libempty.dll.p/.._.._contrib_plugins_win32_linker.c.obj
> -Wl,--allow-shlib-undefined -shared -Wl,--start-group
> -Wl,--out-implib=3Dtests/plugin/libempty.dll.a -fstack-protector-strong
> -Wl,--no-seh -Wl,--nxcompat -Wl,--dynamicbase -Wl,--warn-common
> /usr/i686-w64-mingw32/sys-root/mingw/lib/libglib-2.0.dll.a
> /usr/i686-w64-mingw32/sys-root/mingw/lib/libintl.dll.a
> /usr/i686-w64-mingw32/sys-root/mingw/lib/libgmodule-2.0.dll.a
> -lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -loleaut32
> -luuid -lcomdlg32 -ladvapi32 -Wl,--end-group
> /usr/lib/gcc/i686-w64-mingw32/12.2.1/../../../../i686-w64-mingw32/bin/ld:
> tests/plugin/libempty.dll.p/empty.c.obj: in function
> `qemu_plugin_install':
> /builds/qemu-project/qemu/build/../tests/plugin/empty.c:30: undefined
> reference to `_imp__qemu_plugin_register_vcpu_tb_trans_cb'
> collect2: error: ld returned 1 exit status

Sorry I missed that. While the native msys2-win32bit/msys2-win64bit
builds work the mingw cross builds fail despite having dlltool
installed.

For now I shall --disable-plugins on those builds and raise a bug to
make sure we don't forget.

Greg,

Do you have a Linux/WSL2 system as well that you could look at the
difference? It seems weird its only complaining about some of the
symbols.

To do a local mingw cross build in Linux:

  make docker-test-build@fedora-win64-cross J=3D30 V=3D1 EXTRA_CONFIGURE_OP=
TS=3D"--enable-fdt=3Dinternal" NETWORK=3D1 DEBUG=3D1

The NETWORK is important to ensure git can fetch stuff. DEBUG will drop
you into a shell inside the container so you can poke around the build.

>
> https://gitlab.com/qemu-project/qemu/-/jobs/5487689202
>
> Thanks,
> Stefan
>
>>   - various gitdm updates
>>   - some mailmap fixes
>>   - disable testing for nios2 signals which have regressed
>>
>> ----------------------------------------------------------------
>> Akihiko Odaki (5):
>>       default-configs: Add TARGET_XML_FILES definition
>>       gdbstub: Add num_regs member to GDBFeature
>>       gdbstub: Introduce gdb_find_static_feature()
>>       gdbstub: Introduce GDBFeatureBuilder
>>       cpu: Call plugin hooks only when ready
>>
>> Alex Benn=C3=A9e (13):
>>       gdb-xml: fix duplicate register in arm-neon.xml
>>       target/arm: mark the 32bit alias of PAR when LPAE enabled
>>       target/arm: hide all versions of DBGD[RS]AR from gdbstub
>>       target/arm: hide aliased MIDR from gdbstub
>>       tests/tcg: add an explicit gdbstub register tester
>>       tests/avocado: update the tcg_plugins test
>>       configure: tell meson and contrib_plugins about DLLTOOL
>>       gitlab: add dlltool to Windows CI
>>       contrib/gitdm: Add Rivos Inc to the domain map
>>       contrib/gitdm: map HiSilicon to Huawei
>>       contrib/gitdm: add Daynix to domain-map
>>       mailmap: fixup some more corrupted author fields
>>       Revert "tests/tcg/nios2: Re-enable linux-user tests"
>>
>> Greg Manning (4):
>>       plugins: add dllexport and dllimport to api funcs
>>       plugins: make test/example plugins work on windows
>>       plugins: disable lockstep plugin on windows
>>       plugins: allow plugins to be enabled on windows
>>
>> luzhipeng (1):
>>       contrib/gitdm: add domain-map for Cestc
>>
>>  MAINTAINERS                                        |   2 +-
>>  configure                                          |  13 +-
>>  configs/targets/loongarch64-linux-user.mak         |   1 +
>>  meson.build                                        |   5 +
>>  include/exec/gdbstub.h                             |  59 ++++++
>>  include/qemu/qemu-plugin.h                         |  50 +++++-
>>  contrib/plugins/win32_linker.c                     |  34 ++++
>>  cpu-target.c                                       |  11 --
>>  gdbstub/gdbstub.c                                  |  78 ++++++++
>>  hw/core/cpu-common.c                               |  10 ++
>>  target/arm/debug_helper.c                          |  10 +-
>>  target/arm/helper.c                                |  37 ++--
>>  .gitlab-ci.d/windows.yml                           |   1 +
>>  .mailmap                                           |   2 +
>>  contrib/gitdm/domain-map                           |   4 +
>>  contrib/plugins/Makefile                           |  26 ++-
>>  gdb-xml/arm-neon.xml                               |   2 +-
>>  plugins/meson.build                                |  19 ++
>>  scripts/feature_to_c.py                            |  46 ++++-
>>  tests/avocado/tcg_plugins.py                       |  28 +--
>>  tests/plugin/meson.build                           |  14 +-
>>  tests/tcg/multiarch/Makefile.target                |  11 +-
>>  tests/tcg/multiarch/gdbstub/registers.py           | 197 ++++++++++++++=
+++++++
>>  tests/tcg/multiarch/system/Makefile.softmmu-target |  13 +-
>>  tests/tcg/nios2/Makefile.target                    |  11 ++
>>  tests/tcg/ppc64/Makefile.target                    |   7 +
>>  tests/tcg/s390x/Makefile.target                    |   4 +
>>  27 files changed, 637 insertions(+), 58 deletions(-)
>>  create mode 100644 contrib/plugins/win32_linker.c
>>  create mode 100644 tests/tcg/multiarch/gdbstub/registers.py
>>  create mode 100644 tests/tcg/nios2/Makefile.target
>>
>> --
>> 2.39.2
>>
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


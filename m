Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E15257E91EC
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 19:07:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Eqh-0006dl-WB; Sun, 12 Nov 2023 13:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r2Eqe-0006Zk-UK
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 13:06:17 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r2Eqd-0002Tr-8W
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 13:06:16 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-58441865ffaso2297136eaf.1
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699812373; x=1700417173; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgM1ef5iYsHSZAGhHL/+J8RcX2j082SQkcMyzcx7HsM=;
 b=ZLSgVzGmk2pWG0Y4vTrbv77POFCHhCTSmbfTq3vy4OvX1biA0Qz3Va/bAsUCJWWLsT
 qQgd2QPzpuX4TO0JN7c+5FPGws5Hoq9rExZD7KyNuptP3T1uDZr3OZKTXhLkw4/Kd/WS
 GF8y7827xqUS9oTjJ9dEnuhuEzST7MeySBuEX160Klzqn3U30coF69DklkguyHnuXiux
 WXAYdk0FM35G8xwtzrLrQDgWOm28va7HhZbTPuQkVrnpi1J/YFLe4bt18xxsYhaXojZI
 +kSvSePJt0SJR0p/NSQQNJT+PLOfOxjNEAuXSivrzqMqgrPZ7yNF4EQUDLuG6iCf/CE2
 Qnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699812373; x=1700417173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgM1ef5iYsHSZAGhHL/+J8RcX2j082SQkcMyzcx7HsM=;
 b=FOXZ4lNFux3G605xvDmliAOUZjuo/ZBBY/rPu0r+LRsahvOdvL263Kq0wUdN/squVf
 ialORqUEt1+f+Ijs6QWYdj+p2Wph44oQX1BG1BqQ9ajnqOmAA5YJZpk9/AawNO0TR4iG
 B+9Y6MVHQYaI5TbdYfx6iOZ4/2HrS4w+SlDVuoiS/V38Ftsi0ygML6nICwtWTnMtFYbe
 I4Mz76EIqsdFk2V5JejIgtllQpHwQjb2rpK2PxR2fyDevh4/PjOQmQlnH+MpnSMFm4BZ
 PlAml9Zz7M7Uy3RLKqvdzl58Q3wnzQxxHnjHsu/jSfSDAZwDiCJ/2WsSceBuGLXcPlQA
 17dQ==
X-Gm-Message-State: AOJu0YwcbAXmcI0xpTr7lEViCBB4J2s16+LO8PWUU2PHZ2ymPeheDle7
 8RkQTDOD9HAOER6yUwm/lDXtTOuaKts0n4uIjOA=
X-Google-Smtp-Source: AGHT+IHyQFIMAmxK1iGprsg7vcV/pfacLmmk9gNuxzQCbvPRIFNU3SbpBxiWFFQGENOdGUVE4zP58SLpVFSY67ZevFA=
X-Received: by 2002:a05:6820:29b:b0:584:1457:a52a with SMTP id
 q27-20020a056820029b00b005841457a52amr5543027ood.3.1699812373657; Sun, 12 Nov
 2023 10:06:13 -0800 (PST)
MIME-Version: 1.0
References: <20231111152923.966998-1-pbonzini@redhat.com>
In-Reply-To: <20231111152923.966998-1-pbonzini@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 12 Nov 2023 13:06:01 -0500
Message-ID: <CAJSP0QX52-a4ECrAm=+5ho3W-Eo7o8vfx5T0JX+h+j_9HDVRRw@mail.gmail.com>
Subject: Re: [PULL 0/6] Biuld system and CI changes for 2023-11-10
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2d.google.com
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

On Sat, 11 Nov 2023 at 23:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit ad6ef0a42e314a8c6ac6c96d5f6e607a1e5644=
b5:
>
>   Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging =
(2023-11-09 08:26:01 +0800)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 1d802d050caeff83add1054bee1fc9f98e59a3f2:
>
>   .gitlab-ci.d/cirrus: Add manual testing of macOS 14 (Sonoma) (2023-11-1=
0 10:39:05 +0100)
>
> ----------------------------------------------------------------
> * document what configure does with virtual environments
> * Bump known good meson version to v1.2.3
> * Upgrade macOS to 13 (Ventura) and Add manual testing of macOS 14 (Sonom=
a)
> * use simple assertions instead of Coverity models

I'm not sure which commit causes this, but there is an msys failure:

"gcc" "-m64" "-mcx16" -o tests/plugin/libbb.dll
plugins/qemu_plugin_api.lib tests/plugin/libbb.dll.p/bb.c.obj
tests/plugin/libbb.dll.p/.._.._contrib_plugins_win32_linker.c.obj
"-Wl,--allow-shlib-undefined" "-shared" "-Wl,--start-group"
"-Wl,--out-implib=3Dtests/plugin/libbb.dll.a" "-fstack-protector-strong"
"-Wl,--no-seh" "-Wl,--nxcompat" "-Wl,--dynamicbase"
"-Wl,--high-entropy-va" "-Wl,--warn-common"
"C:/GitLab-Runner/builds/qemu-project/qemu/msys64/mingw64/lib/libglib-2.0.d=
ll.a"
"C:/GitLab-Runner/builds/qemu-project/qemu/msys64/mingw64/lib/libintl.dll.a=
"
"C:/GitLab-Runner/builds/qemu-project/qemu/msys64/mingw64/lib/libgmodule-2.=
0.dll.a"
"-lkernel32" "-luser32" "-lgdi32" "-lwinspool" "-lshell32" "-lole32"
"-loleaut32" "-luuid" "-lcomdlg32" "-ladvapi32" "-Wl,--end-group"
C:/GitLab-Runner/builds/qemu-project/qemu/msys64/mingw64/bin/../lib/gcc/x86=
_64-w64-mingw32/13.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
tests/plugin/libbb.dll.p/bb.c.obj:bb.c:(.text+0x219): undefined
reference to `__imp_qemu_plugin_outs'

Here is the failing output with this PR applied:
https://gitlab.com/qemu-project/qemu/-/jobs/5516759417

Here is the master branch's passing output:
https://gitlab.com/qemu-project/qemu/-/jobs/5513282154

Please take a look. Thanks!

Stefan

>
> ----------------------------------------------------------------
> Paolo Bonzini (2):
>       tests: respect --enable/--disable-download for Avocado
>       docs: document what configure does with virtual environments
>
> Philippe Mathieu-Daud=C3=A9 (3):
>       buildsys: Bump known good meson version to v1.2.3
>       .gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ventura)
>       .gitlab-ci.d/cirrus: Add manual testing of macOS 14 (Sonoma)
>
> Vladimir Sementsov-Ogievskiy (1):
>       coverity: physmem: use simple assertions instead of modelling
>
>  .gitlab-ci.d/cirrus.yml                            |  22 +++++-
>  .../cirrus/{macos-12.vars =3D> macos-13.vars}        |   2 +-
>  .gitlab-ci.d/cirrus/macos-14.vars                  |  16 ++++
>  configure                                          |   9 ++-
>  docs/devel/build-system.rst                        |  88 +++++++++++++++=
+++++-
>  python/scripts/vendor.py                           |   4 +-
>  python/wheels/meson-0.63.3-py3-none-any.whl        | Bin 926526 -> 0 byt=
es
>  python/wheels/meson-1.2.3-py3-none-any.whl         | Bin 0 -> 964928 byt=
es
>  pythondeps.toml                                    |   5 +-
>  scripts/coverity-scan/model.c                      |  88 ---------------=
------
>  system/physmem.c                                   |  22 ++++++
>  tests/Makefile.include                             |   2 +-
>  tests/lcitool/libvirt-ci                           |   2 +-
>  tests/lcitool/refresh                              |   3 +-
>  14 files changed, 157 insertions(+), 106 deletions(-)
>  rename .gitlab-ci.d/cirrus/{macos-12.vars =3D> macos-13.vars} (95%)
>  create mode 100644 .gitlab-ci.d/cirrus/macos-14.vars
>  delete mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl
>  create mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl
> --
> 2.41.0
>
>


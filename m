Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7285D7E2C5A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:51:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04gy-0005rC-Vs; Mon, 06 Nov 2023 13:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04gv-0005p2-PB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:17 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04gt-0000wm-M0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:17 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507bd19eac8so6202138e87.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296673; x=1699901473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fmAJRquXSLfX1V5YUDVcF9VsrpAc3HBppI7Vo84NElg=;
 b=lSW7/S4r6obZKwUYB8zICdeIissQqac5xUnkp+ADl8OkL+DP/UTKfjYSj6JgFgem32
 cOju5/AFCKYxGWkgV6LgeU3D25bJ1qejtZb6MAsINrwPcrkyJ3ZIl6VuUYTPjV+hhl/T
 u8yK8ZXsgjCZOy3Qom/kN3mM14MaWW7/UN2rODRHLdqeem0jWYIjH1oe5KpqOsKxKVBW
 YaTmZJmwuCDHu4nWDwaZwp7/o1M6pGfCK5iHJHJrPPQ7smfBCKCLMpKLtC75jBKQB+rW
 w5z+ZUx7RAb866fEBmwCt9qTMkW5ATHz3pvAJxbrxoXgBEp/krS/LXQmW0fK+k/M8pa0
 ZgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296673; x=1699901473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fmAJRquXSLfX1V5YUDVcF9VsrpAc3HBppI7Vo84NElg=;
 b=d+HGYRa+j4PuWCZV5sUE3SLi+ilWSayWhJ+zeEjeiRuFBVrXevPTrLFFbKJ+YOE8oI
 Ru97z3Ki8WS9wt/JLXGiN4IxysZbJzoaD34yWLy+mgcEHaMI67PcLve5LUrGqRlzQYYb
 vAgv1tEAPXSDYgKYXN2BXSkT7/AK5UY624x28WGJc7V0w94V/A7BhWM7nWo/pFBPnGak
 MgpXL4G+tl8fBR5qY13dHojU8fLARz8mc2D/IkZcOblDsC9ploZoPCTmWkVX8IMa6Fb6
 kigOkjp4kruwmAtElbNwMhqYxhIjWWZjkraIDneo1Djs3VN/DYvIZ3jFA7O1JoSS1HWK
 CZHA==
X-Gm-Message-State: AOJu0Yz6lFQWgpegxE0GuDpK1SmP95mefxWPQbG4rfOeY3qWFDZ+uhQB
 ILZfn2QEm9GkWpcwLkq+aCVPSA==
X-Google-Smtp-Source: AGHT+IHVPHOyVLC9VhpjT9/pGhOFixl+LGkwxc1wVZVMMXgL0Q2RWIBFKGVTIKaKkzk2a98jZYYrSQ==
X-Received: by 2002:ac2:43a6:0:b0:507:9745:8629 with SMTP id
 t6-20020ac243a6000000b0050797458629mr22137398lfl.55.1699296673262; 
 Mon, 06 Nov 2023 10:51:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e14-20020a5d530e000000b0032daf848f68sm312642wrv.59.2023.11.06.10.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:51:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8064965565;
 Mon,  6 Nov 2023 18:51:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 00/22] Maintainer updates for 8.2 (gdbstub, tests,
 plugins) pre-PR
Date: Mon,  6 Nov 2023 18:50:50 +0000
Message-Id: <20231106185112.2755262-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12c.google.com
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

I ran into various issues getting the register API ready in time so
those have been dropped although I've included a bunch of the
pre-requisites. There has been more tweaking of the registers test
which keeps finding kinks in our gdbstub report. I've also rolled up
the acked gitdm changes. There has been a bit of juggling to the
configure and meson bits for the Windows plugin support. Finally I
noticed nios2 signal handling is broken again so I've disabled testing
again and we shouldn't re-enable it until we can defend in CI (if we
ever want to, the architecture is currently orphaned).

I'll be rolling the PR tomorrow for soft-freeze so this is your last
chance to complain ;-)

The following still need review:

  Revert "tests/tcg/nios2: Re-enable linux-user tests"
  configure: tell meson and contrib_plugins about DLLTOOL
  tests/avocado: update the tcg_plugins test
  tests/tcg: add an explicit gdbstub register tester
  target/arm: hide aliased MIDR from gdbstub
  target/arm: hide all versions of DBGD[RS]AR from gdbstub
  target/arm: hide the 32bit version of PAR from gdbstub

Akihiko Odaki (5):
  default-configs: Add TARGET_XML_FILES definition
  gdbstub: Add num_regs member to GDBFeature
  gdbstub: Introduce gdb_find_static_feature()
  gdbstub: Introduce GDBFeatureBuilder
  cpu: Call plugin hooks only when ready

Alex Bennée (12):
  gdb-xml: fix duplicate register in arm-neon.xml
  target/arm: hide the 32bit version of PAR from gdbstub
  target/arm: hide all versions of DBGD[RS]AR from gdbstub
  target/arm: hide aliased MIDR from gdbstub
  tests/tcg: add an explicit gdbstub register tester
  tests/avocado: update the tcg_plugins test
  configure: tell meson and contrib_plugins about DLLTOOL
  contrib/gitdm: Add Rivos Inc to the domain map
  contrib/gitdm: map HiSilicon to Huawei
  contrib/gitdm: add Daynix to domain-map
  mailmap: fixup some more corrupted author fields
  Revert "tests/tcg/nios2: Re-enable linux-user tests"

Greg Manning (4):
  plugins: add dllexport and dllimport to api funcs
  plugins: make test/example plugins work on windows
  plugins: disable lockstep plugin on windows
  plugins: allow plugins to be enabled on windows

luzhipeng (1):
  contrib/gitdm: add domain-map for Cestc

 configure                                     |  13 +-
 configs/targets/loongarch64-linux-user.mak    |   1 +
 meson.build                                   |   5 +
 include/exec/gdbstub.h                        |  59 ++++++
 include/qemu/qemu-plugin.h                    |  50 ++++-
 contrib/plugins/win32_linker.c                |  34 +++
 cpu-target.c                                  |  11 -
 gdbstub/gdbstub.c                             |  78 +++++++
 hw/core/cpu-common.c                          |  10 +
 target/arm/debug_helper.c                     |   8 +-
 target/arm/helper.c                           |   4 +-
 .mailmap                                      |   2 +
 contrib/gitdm/domain-map                      |   4 +
 contrib/plugins/Makefile                      |  26 ++-
 gdb-xml/arm-neon.xml                          |   2 +-
 plugins/meson.build                           |  19 ++
 scripts/feature_to_c.py                       |  46 +++-
 tests/avocado/tcg_plugins.py                  |  28 ++-
 tests/plugin/meson.build                      |  14 +-
 tests/tcg/multiarch/Makefile.target           |  11 +-
 tests/tcg/multiarch/gdbstub/registers.py      | 196 ++++++++++++++++++
 .../multiarch/system/Makefile.softmmu-target  |  13 +-
 tests/tcg/nios2/Makefile.target               |  11 +
 23 files changed, 601 insertions(+), 44 deletions(-)
 create mode 100644 contrib/plugins/win32_linker.c
 create mode 100644 tests/tcg/multiarch/gdbstub/registers.py
 create mode 100644 tests/tcg/nios2/Makefile.target

-- 
2.39.2



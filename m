Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2097E41C5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:25:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0C-0004Fg-Eg; Tue, 07 Nov 2023 09:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzr-0004CB-P4
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:04 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzm-0007Xl-11
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:03 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507a0907896so7231166e87.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367035; x=1699971835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h/mpRhK4dT7+Sn+pVmk/wvvnJudW7L453hTa8KeS450=;
 b=AzzEduVGayhZi89O79Z8crE+ueMYB6hcAhbHMQkf0hsViwVyAHINtVEsnePwAADdeu
 0HFhlwRY7a5kAQjPsPoBbU2qtbTfJvyHDuAj75oNewN5JE4cyJGrdRHF+eoqEz1NzQzl
 /NB8JV1n+WE3wyLhuJWQUKmib8NiaLSi4Fg6ZIrALnXfnBfHNEEthgugZDX4hcpZydmf
 ms0QmKu1PiDdp4PgsJhbYG+vt8SjlA/JEMVdcFqIPwQo75hMWg8O92YXxHRgT5aJyhEB
 2CoQp3gd6+pcaKRCPqGpdjMsb4CYK1hdVBPKWR7PdSvIXrFpQpuLaTVN+rgtvUZI6Fxm
 7i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367035; x=1699971835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h/mpRhK4dT7+Sn+pVmk/wvvnJudW7L453hTa8KeS450=;
 b=pZI1binDozM9J2PJ3a8nWBtVMC3H0II/vT03tCQulT3RjBs6uOhnWPQ4XSc+U/X6xg
 7RG6UAdGBNKb7FLoS/QCDMDLvmVEbB8JZzguwpuxIhTojQ1IIFRzcCy75kvnKmbfNjtr
 9CStL5wjuHRKKac39X0vrBKqylYOWG6fadUbs3+1XZBnXEpEpubEmnv7qUUlARLlVIj2
 5PjDtPW7HE7Js3aaiUN1eLxRCr3oRA6fcWvGpvxs7Hz2DlzhnAbK2CWk//Vye0bVXk4H
 3ouKu+fg676DtkvNNXud74gxyJcOpdz0V/VV9g7xzu9SXYi+GVaWVY+57XzAa5/r19Yx
 0mfA==
X-Gm-Message-State: AOJu0YwRbz+/nMm+uN+5eAcRr8Xf5OQ/hXGOhCcu08OyYv1PrMpNZMIa
 q2pO2Eau6LFyob4+7hSreNZN3bfj48qfKNc0anqL6A==
X-Google-Smtp-Source: AGHT+IFPknlnxcJFhmlawsS0DWxKS2FcTVnWSRf2Bhlj50it+OojL07MJZk2SSk3cnt3HXk9mvOryg==
X-Received: by 2002:a19:f007:0:b0:504:7ff8:3430 with SMTP id
 p7-20020a19f007000000b005047ff83430mr22306500lfc.10.1699367035480; 
 Tue, 07 Nov 2023 06:23:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m17-20020a056000181100b0032da6f17ffdsm2505031wrh.38.2023.11.07.06.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:23:55 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A05895F790;
 Tue,  7 Nov 2023 14:23:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/23] Final test, gdbstub, plugin and gitdm updates for 8.2
Date: Tue,  7 Nov 2023 14:23:31 +0000
Message-Id: <20231107142354.3151266-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following changes since commit 462ad017ed76889d46696a3581e1b52343f9b683:

  Merge tag 'pixman-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-11-07 19:00:03 +0800)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-halloween-omnibus-071123-1

for you to fetch changes up to 00da668de6856d912cd75474ba759927e29d0e49:

  Revert "tests/tcg/nios2: Re-enable linux-user tests" (2023-11-07 14:18:29 +0000)

----------------------------------------------------------------
Final test, gdbstub, plugin and gitdm updates for 8.2

  - fix duplicate register in arm xml
  - hide various duplicate system registers from gdbstub
  - add new gdb register test to the CI (skipping s390x/ppc64 for now)
  - introduce GDBFeatureBuilder
  - move plugin initialisation to after vCPU init completes
  - enable building TCG plugins on Windows platform
  - various gitdm updates
  - some mailmap fixes
  - disable testing for nios2 signals which have regressed

----------------------------------------------------------------
Akihiko Odaki (5):
      default-configs: Add TARGET_XML_FILES definition
      gdbstub: Add num_regs member to GDBFeature
      gdbstub: Introduce gdb_find_static_feature()
      gdbstub: Introduce GDBFeatureBuilder
      cpu: Call plugin hooks only when ready

Alex Bennée (13):
      gdb-xml: fix duplicate register in arm-neon.xml
      target/arm: mark the 32bit alias of PAR when LPAE enabled
      target/arm: hide all versions of DBGD[RS]AR from gdbstub
      target/arm: hide aliased MIDR from gdbstub
      tests/tcg: add an explicit gdbstub register tester
      tests/avocado: update the tcg_plugins test
      configure: tell meson and contrib_plugins about DLLTOOL
      gitlab: add dlltool to Windows CI
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

 MAINTAINERS                                        |   2 +-
 configure                                          |  13 +-
 configs/targets/loongarch64-linux-user.mak         |   1 +
 meson.build                                        |   5 +
 include/exec/gdbstub.h                             |  59 ++++++
 include/qemu/qemu-plugin.h                         |  50 +++++-
 contrib/plugins/win32_linker.c                     |  34 ++++
 cpu-target.c                                       |  11 --
 gdbstub/gdbstub.c                                  |  78 ++++++++
 hw/core/cpu-common.c                               |  10 ++
 target/arm/debug_helper.c                          |  10 +-
 target/arm/helper.c                                |  37 ++--
 .gitlab-ci.d/windows.yml                           |   1 +
 .mailmap                                           |   2 +
 contrib/gitdm/domain-map                           |   4 +
 contrib/plugins/Makefile                           |  26 ++-
 gdb-xml/arm-neon.xml                               |   2 +-
 plugins/meson.build                                |  19 ++
 scripts/feature_to_c.py                            |  46 ++++-
 tests/avocado/tcg_plugins.py                       |  28 +--
 tests/plugin/meson.build                           |  14 +-
 tests/tcg/multiarch/Makefile.target                |  11 +-
 tests/tcg/multiarch/gdbstub/registers.py           | 197 +++++++++++++++++++++
 tests/tcg/multiarch/system/Makefile.softmmu-target |  13 +-
 tests/tcg/nios2/Makefile.target                    |  11 ++
 tests/tcg/ppc64/Makefile.target                    |   7 +
 tests/tcg/s390x/Makefile.target                    |   4 +
 27 files changed, 637 insertions(+), 58 deletions(-)
 create mode 100644 contrib/plugins/win32_linker.c
 create mode 100644 tests/tcg/multiarch/gdbstub/registers.py
 create mode 100644 tests/tcg/nios2/Makefile.target

-- 
2.39.2



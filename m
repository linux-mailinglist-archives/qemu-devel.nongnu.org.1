Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 787B382B096
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:25:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvyP-0004KS-MG; Thu, 11 Jan 2024 09:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyJ-0004Jp-Hr
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:23:52 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyC-0002De-KN
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:23:46 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3374eb61cbcso4836698f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983021; x=1705587821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sDV3W7eJ+Rxsp/aZLTKCJLHW7ZMvivlt0zxNEezUe7w=;
 b=XshATUOSJ8iJIGLAPbxWBrePnWZimZsbQppRL316oDobm23WfeDu8lIzpUI/TpYvSI
 ES/rLbl9xL9Ek7xtATGvzsnN5QLj4LEZewOFN/TM6UOealrjKm9+ul7hkA5Q/3kan1Di
 8jxlm3yZ4lWy8ktxIdihOpmMFqOdskhMnncI5kEtWtOMnWfKIXfJRbZ44/lEJpG+Ad3m
 iVADlsujitWdr8w2h6Qf5ctd1N3SIWTsZL1MkayQfH7D3pZfMhiLOpBaVpbEYsVkmobr
 uNn+jLEtlMwCHXqqFuwLbzttrqTQrGYDy/hOkqf3xK/MWxOrMTKCQ9wLlLCtuYu46pBt
 FdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983021; x=1705587821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDV3W7eJ+Rxsp/aZLTKCJLHW7ZMvivlt0zxNEezUe7w=;
 b=Ky7f7lERp6WQT61vFOZDjRegg3KG9HulNl/DX92/9VLi1k0hN7d/OgwyL+mX2OnDtQ
 kxDV+IrSMeCMCVdh2GHKlwHhw3gFtZOqFJhR4NGkP0Sh5/iZVjuHHZG1r9wI1UTksmsp
 4JZeD5ExQOmCnCDy7e65zJNr85bUJny58W1I3G1spCzVwCw5wjE7ayHp+77vlUC4FoLv
 ksW5fy6YeN3Hlua/8bi9TCQs2hZKZpkSz1sBrtNooF6AlX0IBuUvkgqC/fwd4sLTcOZA
 Z+xuYXq3G0KxVdqXCmOpfJOjBRhNpIazCwFSXLjtaS2RkE3dy7Z+dqZmFTBUvgHXYdNT
 Dzbw==
X-Gm-Message-State: AOJu0YwFXQEGDlG220SgwBxGo4aF752KbYrUBXEuDQ/2hgZioIC3+1d7
 u77j+acEpFEB3s4UD3X1yCf3ugvWBHDOIqyp5O6UKQ0QvBLZTA==
X-Google-Smtp-Source: AGHT+IHf4NPMUyhuHKplnCe/Qp4Ib79wVQ2Cs10qXVgfCypnSNDdiSJzZJaIs+JfSOSdrnRqLG35qQ==
X-Received: by 2002:adf:f212:0:b0:336:71c9:52a5 with SMTP id
 p18-20020adff212000000b0033671c952a5mr713158wro.52.1704983021417; 
 Thu, 11 Jan 2024 06:23:41 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 h7-20020adff4c7000000b0033677aae2e2sm1349000wrp.107.2024.01.11.06.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:23:40 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 00/12] TCG Plugin inline operation enhancement
Date: Thu, 11 Jan 2024 18:23:13 +0400
Message-ID: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42f.google.com
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

This series adds a new thread-safe API to declare inline operation
inside plugins. As well, it removes the existing non thread-safe API,
and migrates all existing plugins to use it.

Tested on Linux (user, system) for i386, x86_64 and aarch64.

To give some context, this a long term series of work around plugins,
with the goal to be able to do basic operations in a more performant and
accurate way. This will mean to add more inline operations and
conditional callbacks.

One final target of this work is to implement a plugin that implements
the icount=auto feature, and allow QEMU to run at a given "frequency"
based on number of instructions executed, without QEMU needing to keep
track of this.

Another final target is to be able to detect control flow changes in an
efficient and elegant way, by combining inline operation and conditional
callbacks.

 Pierrick Bouvier (12):
       plugins: implement inline operation with cpu_index offset
       plugins: add inline operation per vcpu
       tests/plugin: add test plugin for inline operations
       tests/plugin/inline: migrate to new per_vcpu API
       tests/plugin/mem: fix race condition with callbacks
       tests/plugin/mem: migrate to new per_vcpu API
       tests/plugin/insn: migrate to new per_vcpu API
       tests/plugin/bb: migrate to new per_vcpu API
       contrib/plugins/hotblocks: migrate to new per_vcpu API
       contrib/plugins/howvec: migrate to new per_vcpu API
       plugins: remove non per_vcpu inline operation from API
       MAINTAINERS: Add myself as reviewer for TCG Plugins

  MAINTAINERS                  |   1 +
  accel/tcg/plugin-gen.c       |  60 +++++++++++++---
  contrib/plugins/hotblocks.c  |  25 +++++--
  contrib/plugins/howvec.c     |  33 ++++++---
  include/qemu/plugin.h        |   1 +
  include/qemu/qemu-plugin.h   |  65 +++++++++--------
  plugins/api.c                |  35 +++++----
  plugins/core.c               |  11 +--
  plugins/plugin.h             |   5 +-
  plugins/qemu-plugins.symbols |   3 +
  tests/plugin/bb.c            |  54 +++++++-------
  tests/plugin/inline.c        | 166 +++++++++++++++++++++++++++++++++++++++++++
  tests/plugin/insn.c          |  14 ++--
  tests/plugin/mem.c           |  21 ++++--
  tests/plugin/meson.build     |   2 +-
  15 files changed, 383 insertions(+), 113 deletions(-)

Pierrick Bouvier (12):
  plugins: implement inline operation with cpu_index offset
  plugins: add inline operation per vcpu
  tests/plugin: add test plugin for inline operations
  tests/plugin/inline: migrate to new per_vcpu API
  tests/plugin/mem: fix race condition with callbacks
  tests/plugin/mem: migrate to new per_vcpu API
  tests/plugin/insn: migrate to new per_vcpu API
  tests/plugin/bb: migrate to new per_vcpu API
  contrib/plugins/hotblocks: migrate to new per_vcpu API
  contrib/plugins/howvec: migrate to new per_vcpu API
  plugins: remove non per_vcpu inline operation from API
  MAINTAINERS: Add myself as reviewer for TCG Plugins

 MAINTAINERS                  |   1 +
 accel/tcg/plugin-gen.c       |  60 ++++++++++---
 contrib/plugins/hotblocks.c  |  25 ++++--
 contrib/plugins/howvec.c     |  33 ++++---
 include/qemu/plugin.h        |   1 +
 include/qemu/qemu-plugin.h   |  65 ++++++++------
 plugins/api.c                |  35 +++++---
 plugins/core.c               |  11 ++-
 plugins/plugin.h             |   5 +-
 plugins/qemu-plugins.symbols |   3 +
 tests/plugin/bb.c            |  54 ++++++------
 tests/plugin/inline.c        | 166 +++++++++++++++++++++++++++++++++++
 tests/plugin/insn.c          |  14 ++-
 tests/plugin/mem.c           |  21 +++--
 tests/plugin/meson.build     |   2 +-
 15 files changed, 383 insertions(+), 113 deletions(-)
 create mode 100644 tests/plugin/inline.c

-- 
2.43.0



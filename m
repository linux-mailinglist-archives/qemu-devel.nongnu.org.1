Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C4E79DC04
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:42:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgC4R-0002Ns-N7; Tue, 12 Sep 2023 18:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4Q-0002NN-EV
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:22 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4J-00016C-1a
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:22 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-53482b44007so4366198a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694558473; x=1695163273;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d6uMNey5witV9gBGN2Ca/8BOOVeXwvVhVa4lwuWxcsA=;
 b=Uks7wXABOCTYZEDhIYXdV6i5eIjCiFPlTSFh3Y2qWn15gii5Tikv92D4Gm8mOVFeqs
 k6Bj6A6LtCFDetS0EeSA1J0IjuA7Xksm97oyoaKcWYq0m6nVq0F8pBpTR2PzTLrlAM0r
 uuz6bvuxDsFwUatcDaUmc0NNkbPnyt+PCnPY7N3Zh0GUQZG/f63NiS1JhCqqA6AU39BV
 fGJQS9cFf8nOPP/+DYZPS7fEB8hIPxEKdRDyjSeQCPxfMZzvtj/RjEflEH+mDtSWhYuM
 xailpc4vrH9tXFS8vLdt4QW4dDDBbYelHQkisIQL7napJ2drEhvC7dcMsGRtDQZy293n
 34dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694558473; x=1695163273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d6uMNey5witV9gBGN2Ca/8BOOVeXwvVhVa4lwuWxcsA=;
 b=gt/HEG7t3bwc3sStO+1sDcOgcSTtrjgKX9OdbBdeHkPNqgAcaXdtMHOeu5WCcZQpzA
 F//P43EG3yL1pcv3kGKNVrD/UkVlg5LxTf+uLJRkdT77cODU8NScxKlHKOkbOzbtQ4LX
 Ni2vuYZNN5YdKj2nKOq2UI8IPaZ2wARAQmK2L7mPBN5RaFEj3+BMxmyz12l/v3e+pSLy
 WYT4oIIYNGHifap/As1K80OkYML40HisJUluLP/6WIwWnpFJuBeuVBHkrhdclpKGezzA
 /A+t0ESCleZ73LzH0g7oxc5xl1kjz85M3YJLsmfZJheBie3hpmnUYz5y5n6pB/yKLRdW
 yJbQ==
X-Gm-Message-State: AOJu0YwAK3GouZTXX75cEirFAhqHf9Z/i2X5MZQPhxWK28e6L2KZY7Ox
 lyHE3x7V9Nn3S7Q70MrKkVG8VA==
X-Google-Smtp-Source: AGHT+IHtU3EwT2MzJh2ABzz6sBoMgq+bRPCd+84YWLxqV0F5OlTQbKIecjG4mjGfXBsWAH7a95dNeg==
X-Received: by 2002:a05:6a20:9388:b0:155:6e4f:8c1a with SMTP id
 x8-20020a056a20938800b001556e4f8c1amr936096pzh.25.1694558473117; 
 Tue, 12 Sep 2023 15:41:13 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001bbbc655ca1sm8996977plk.219.2023.09.12.15.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:41:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 00/12] gdbstub and TCG plugin improvements
Date: Wed, 13 Sep 2023 07:40:49 +0900
Message-ID: <20230912224107.29669-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This series extracts fixes and refactorings that can be applied
independently from "[PATCH RESEND v5 00/26] plugins: Allow to read
registers" as suggested by Nicholas Piggin.

Patch "target/ppc: Remove references to gdb_has_xml" is also updated to
remove some dead code I missed earlier and thus the Reviewed-by tag is
dropped.

V2 -> V3:
  Added patch "plugins: Check if vCPU is realized".

V1 -> V2:
  Rebased.
  Added patch "gdbstub: Fix target_xml initialization".
  Added patch "gdbstub: Fix target.xml response".
  Added patch "gdbstub: Replace gdb_regs with an array".

Akihiko Odaki (12):
  gdbstub: Fix target_xml initialization
  gdbstub: Fix target.xml response
  plugins: Check if vCPU is realized
  contrib/plugins: Use GRWLock in execlog
  gdbstub: Introduce GDBFeature structure
  target/arm: Move the reference to arm-core.xml
  hw/core/cpu: Return static value with gdb_arch_name()
  gdbstub: Use g_markup_printf_escaped()
  target/arm: Remove references to gdb_has_xml
  target/ppc: Remove references to gdb_has_xml
  gdbstub: Remove gdb_has_xml variable
  gdbstub: Replace gdb_regs with an array

 MAINTAINERS               |  2 +-
 meson.build               |  2 +-
 gdbstub/internals.h       |  2 -
 include/exec/gdbstub.h    | 17 +++----
 include/hw/core/cpu.h     |  4 +-
 target/ppc/internal.h     |  2 +-
 contrib/plugins/execlog.c | 16 ++++---
 gdbstub/gdbstub.c         | 94 +++++++++++++++++++--------------------
 gdbstub/softmmu.c         |  2 +-
 plugins/core.c            |  2 +-
 stubs/gdbstub.c           |  6 +--
 target/arm/cpu.c          |  9 ++--
 target/arm/cpu64.c        |  4 +-
 target/arm/gdbstub.c      | 32 +------------
 target/i386/cpu.c         |  6 +--
 target/loongarch/cpu.c    |  8 ++--
 target/ppc/gdbstub.c      | 24 ++--------
 target/riscv/cpu.c        |  6 +--
 target/s390x/cpu.c        |  4 +-
 target/tricore/cpu.c      |  4 +-
 scripts/feature_to_c.py   | 48 ++++++++++++++++++++
 scripts/feature_to_c.sh   | 69 ----------------------------
 22 files changed, 146 insertions(+), 217 deletions(-)
 create mode 100755 scripts/feature_to_c.py
 delete mode 100644 scripts/feature_to_c.sh

-- 
2.42.0



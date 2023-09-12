Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C9579C75D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 08:59:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxLu-0000K3-KS; Tue, 12 Sep 2023 02:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxLr-0000JR-7L
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:23 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxLo-0007RE-NX
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:22 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-26f7f71b9a7so4267458a91.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694501898; x=1695106698;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XRBrU0goRgb7M0G3yImQVD/2ahAcqhXPC+6jCjLC0YU=;
 b=rkpAYsIilIgN5oOigVVGCM8CXlYHezbsOuph351cmVVWXSl78VchC9cl7hP1DJTJNS
 PkfmxF3BROfM71cQZHJHtHg7zVSnutzGRIQMBEbkj4PzuK5rYFHyfc0JCMrzD5OVliWH
 rhipYPzym2ECegh+2Nlf+23Wda7NZNP09JunceEKAfo8gxLUlWnD9PpU0x5CqM1Y9+vT
 9kpYqlBeyca2jQzUTnHjXNhIvzWACha0KThUOG0F4grMaS489cDzEkVuqV2SlQFaPuui
 lSo8ZUK8uIjAODUaU9Uv7qZ4/mzbFBE3SapRcWfQw9QG+Jo88tgwiOGxdt8/w2DIpJfl
 Qscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694501898; x=1695106698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XRBrU0goRgb7M0G3yImQVD/2ahAcqhXPC+6jCjLC0YU=;
 b=iD/z1FiX8ptpLPlWAdueHR69K94rKdPIIxITV6nNLcabYbxVc9JQazWz2eEZzTIPUL
 KxgWY+8YB7koeF91UDEvTuMGzBM9WTwYYlgV2DnopMcCNIsDVUOeF8GQoafVu4mGygk1
 Xv0UNVYMx8h10sc6wWI12y0wD1tF1bDOIDP+Scf69c3hV5eC13s5ou7Zz2z5Ex/rHCcX
 nugBkp3pYdOdvCx0lcPBJ7dFXlJeHS1TXcKSFzIgwFOVr8TmXFI3iidSK1gQ4bZ7pv42
 WWa/aspqwye7xfrG3z8oxg/Cvv7C1bDbF6qqwb/lBWb9cnWvUnsnCAPBqBkv6ltTTvHH
 HzIQ==
X-Gm-Message-State: AOJu0Yx8WWge0m25+LhkZSs6zQxw8J1Md+4etSR1p2fX72ScFA2kC+uq
 h0W5MAsThMK3UHdUliECa5tnIA==
X-Google-Smtp-Source: AGHT+IGZlI5N+PZr77ouZatudBeLx1WKSfZgPMeLFbGEQOSGuRa38otGoSIUnjQqPtUrwxQbXCtX0w==
X-Received: by 2002:a17:90b:4c4b:b0:268:13c4:b800 with SMTP id
 np11-20020a17090b4c4b00b0026813c4b800mr11331340pjb.21.1694501897640; 
 Mon, 11 Sep 2023 23:58:17 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a17090a2ac800b002696aeb72e5sm9315058pjg.2.2023.09.11.23.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:58:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 00/11] gdbstub and TCG plugin improvements
Date: Tue, 12 Sep 2023 15:57:55 +0900
Message-ID: <20230912065811.27796-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

V1 -> V2:
  Rebased.
  Added patch "gdbstub: Fix target_xml initialization".
  Added patch "gdbstub: Fix target.xml response".
  Added patch "gdbstub: Replace gdb_regs with an array".

Akihiko Odaki (11):
  gdbstub: Fix target_xml initialization
  gdbstub: Fix target.xml response
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
 21 files changed, 145 insertions(+), 216 deletions(-)
 create mode 100755 scripts/feature_to_c.py
 delete mode 100644 scripts/feature_to_c.sh

-- 
2.42.0



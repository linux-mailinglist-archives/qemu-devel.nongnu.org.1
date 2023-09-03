Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C86790ACD
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 06:33:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcelj-0002BB-KR; Sun, 03 Sep 2023 00:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcelf-0002Ai-1n
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 00:31:23 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcelb-0006nQ-2z
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 00:31:22 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bdc27e00a1so397318a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 21:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693715476; x=1694320276;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6aTtmwLiWgbKCta84peA8gXFlKpC9PbTjiIeR527lmo=;
 b=3fgkFEMIMu6rqQhrD6JsbT4A+pU3dB8qucNH2DNM/J7P7D3EStxoGa4DoWQI4+UoxB
 ehwzfdlAkeQ60/AQhPXZsqGEDN9MPvzAgTUKU6kkkItgM9Q4/nV12FaU6Ec5k/hPWVgj
 MFlO5Oe6SR8E9BaW3PIbH94Si80QvBvq84zRZxxyvydfOQzbiPeOUeEGqHnT/jXR1ocr
 01hzUSiU9WrnD6yRc5Kgak1Mdi3f/rElFEv2a1azsxL59Smw5J2xY7+DDxP3uEcF9Zqk
 a6mTBUqmLakUWm1Wh32f4Hn6RJ531K9mxUpN6wTcwflkrC22tsKkQ2EQDgQOzRZzkYz0
 7xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693715476; x=1694320276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6aTtmwLiWgbKCta84peA8gXFlKpC9PbTjiIeR527lmo=;
 b=FjeX93BfRV/m3RslugycsZ7akyAuRYOWIurWqfC1U18BGv1cUmxDLLRRokEelb8NTi
 JXJyhkwKlKF9KWNBCFIlKbNcLXPcc0YQXAS4c+5gQX65VzTvX9chtssPyG8V6KjesVpg
 Ju/p40XmZUQC+sQRLaVyriVpWgKmbRE/p5r5suUKYGC9RXaCwiGevHEK3D3qzTQuAJ9I
 kI5F+kiCCcgKUiTlXZrM1ZCooXURNm1Oh77SCZga1PxNAbcCh9DSz0cF8ikJnnX6PA4E
 kH08DHxc4RGJ9JFGoZB0EDEBAdLjh4doKF0GzUM29T0jRLyWH4HqrU+OBkuDsJS98/Gu
 QjwQ==
X-Gm-Message-State: AOJu0Yy0SjAm+ruo+HB+tEyCoaVUwDdUyrd6AeWAcDASyB6H+X8r96vF
 Kjt/MkwazIXJlu5onsexSkZG3g==
X-Google-Smtp-Source: AGHT+IHcz2t9dr9u2e0+Mmds0BbubgzYcLNeyRtjqS9PMEeOLVxcJhiVoRaBS59mUP9rpb5XWsxNVA==
X-Received: by 2002:a05:6830:1645:b0:6b9:e412:b02b with SMTP id
 h5-20020a056830164500b006b9e412b02bmr7058262otr.2.1693715476098; 
 Sat, 02 Sep 2023 21:31:16 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 iz2-20020a170902ef8200b001bb9f104328sm5295792plb.146.2023.09.02.21.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 21:31:15 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/8] gdbstub and TCG plugin improvements
Date: Sun,  3 Sep 2023 13:30:10 +0900
Message-ID: <20230903043030.20708-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x336.google.com
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

Akihiko Odaki (8):
  contrib/plugins: Use GRWLock in execlog
  gdbstub: Introduce GDBFeature structure
  target/arm: Move the reference to arm-core.xml
  hw/core/cpu: Return static value with gdb_arch_name()
  gdbstub: Dynamically allocate target.xml buffer
  target/arm: Remove references to gdb_has_xml
  target/ppc: Remove references to gdb_has_xml
  gdbstub: Remove gdb_has_xml variable

 MAINTAINERS               |  2 +-
 meson.build               |  2 +-
 gdbstub/internals.h       |  2 +-
 include/exec/gdbstub.h    | 17 ++++------
 include/hw/core/cpu.h     |  2 +-
 target/ppc/internal.h     |  2 +-
 contrib/plugins/execlog.c | 16 +++++----
 gdbstub/gdbstub.c         | 63 +++++++++++++++--------------------
 gdbstub/softmmu.c         |  3 +-
 gdbstub/user.c            |  1 -
 stubs/gdbstub.c           |  6 ++--
 target/arm/cpu.c          |  9 ++---
 target/arm/cpu64.c        |  4 +--
 target/arm/gdbstub.c      | 32 ++----------------
 target/i386/cpu.c         |  6 ++--
 target/loongarch/cpu.c    |  4 +--
 target/ppc/gdbstub.c      | 24 ++------------
 target/riscv/cpu.c        |  6 ++--
 target/s390x/cpu.c        |  4 +--
 target/tricore/cpu.c      |  4 +--
 scripts/feature_to_c.py   | 48 +++++++++++++++++++++++++++
 scripts/feature_to_c.sh   | 69 ---------------------------------------
 22 files changed, 124 insertions(+), 202 deletions(-)
 create mode 100755 scripts/feature_to_c.py
 delete mode 100644 scripts/feature_to_c.sh

-- 
2.42.0



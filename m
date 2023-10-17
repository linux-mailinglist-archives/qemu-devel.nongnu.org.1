Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6E47CC196
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:13:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qshzy-0000w3-Jq; Tue, 17 Oct 2023 07:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qshzw-0000oV-70
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:12:28 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qshzq-0004ct-BV
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:12:27 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-581e5a9413bso79109eaf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 04:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697541139; x=1698145939;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZFiN3N/75AOwH+FjIE39K+r3lO/8BhE0uEMMS3FDijo=;
 b=PU1Z9N+jk+2VPYj4KmYwUdirD1yD1hAccVd7WJPVOC4dTp/kSq6K7uH1P/PzrxPyrD
 CWzmA/jbdny481kLsarTFZ3Gnm3g6mHxCLPnqdixpl/U6Wb8wVz+BhQElBvZRHOAmvWM
 /DcfqFx4G6OuMmdxI9ymTUJvEwtQHNraMfbsPxHeP5MCo+NjBFxvvWJ8yECCMwoeJJiz
 FG3MbI/uKIVKFF/QP7Ok4/fCMpSUdBdnTdPAGsFXMfUD+OiNXSBPYuaAke+DcTwZlamu
 Xn+xIR6SRf0VDSRs+zkjRRZCuWJHgwsMTrRLcEnnAM9fOjDrnemAU2k6nd2/FlSc1dmA
 Hbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697541139; x=1698145939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZFiN3N/75AOwH+FjIE39K+r3lO/8BhE0uEMMS3FDijo=;
 b=VlhWGJ4HdwzBvMc+fkiEkhQIfWVt2jx63pxPFyyntRiNzvyjUxLsRfxv8Hn0tMmixZ
 KUsQW1Sx4q5i9uC0ABglXXYkkcnpSOGS03hwOqvb7djGfLLx9I4AWykjv4Hd5mLQfOjS
 P+MIXLjvbSePVn9bzYs9pn8ObK+KGUPzUTTGdlTO8u1Tfzo8Koe/D3wQJTqmsmxeHwTO
 RoxCK+S+YVZyWjZQXkgE+uGkBk5NFyvJwv4lFM25OgOPjU3LA895Eih6xj4U9N9/jZ7M
 hAQXE8daawWwzFvPXVVRZj74WWU/2AW4ac7UQ6GCTzSVanFXnRdR5FapFE2L/BKqFNa7
 MSBw==
X-Gm-Message-State: AOJu0Yy4FkjOkhKgZVjsPWzuu+KsAqVjBEpEyIvVGJ7Gmv4IU1x1Opw+
 iOt6BqaED/+IuycRZgU9qvyRJQ==
X-Google-Smtp-Source: AGHT+IH4CRa09WTFIbym4OGkHazJJW4UmDipbCmUfJafU8ia4mmuItk7TfmxEzWQkng+eAYAOanZzQ==
X-Received: by 2002:a05:6358:3a17:b0:166:e6e1:7ea3 with SMTP id
 g23-20020a0563583a1700b00166e6e17ea3mr95069rwe.22.1697541139583; 
 Tue, 17 Oct 2023 04:12:19 -0700 (PDT)
Received: from localhost ([157.82.206.156])
 by smtp.gmail.com with UTF8SMTPSA id
 z21-20020aa79f95000000b0069323619f69sm1195112pfr.143.2023.10.17.04.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 04:12:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/4] gdbstub and TCG plugin improvements
Date: Tue, 17 Oct 2023 20:12:09 +0900
Message-ID: <20231017111215.42209-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2e.google.com
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
independently from "[PATCH v9 00/23] plugins: Allow to read registers".

The patch "target/riscv: Move MISA limits to class" was replaced with
patch "target/riscv: Move misa_mxl_max to class" since I found instances
may have different misa_ext_mask.

V2 -> V3:
  Restored patch sets from the previous version.
  Rebased to commit 800485762e6564e04e2ab315132d477069562d91.

V1 -> V2:
  Added patch "target/riscv: Do not allow MXL_RV32 for TARGET_RISCV64".
  Added patch "target/riscv: Initialize gdb_core_xml_file only once".
  Dropped patch "target/riscv: Remove misa_mxl validation".
  Dropped patch "target/riscv: Move misa_mxl_max to class".
  Dropped patch "target/riscv: Validate misa_mxl_max only once".

Akihiko Odaki (4):
  target/riscv: Remove misa_mxl validation
  target/riscv: Move misa_mxl_max to class
  target/riscv: Validate misa_mxl_max only once
  plugins: Remove an extra parameter

 target/riscv/cpu-qom.h     |   1 +
 target/riscv/cpu.h         |   3 +-
 accel/tcg/plugin-gen.c     |   9 +--
 hw/riscv/boot.c            |   2 +-
 target/riscv/cpu.c         | 139 ++++++++++++++++++++++---------------
 target/riscv/gdbstub.c     |  12 ++--
 target/riscv/kvm/kvm-cpu.c |  10 +--
 target/riscv/machine.c     |   7 +-
 target/riscv/tcg/tcg-cpu.c |  42 ++---------
 target/riscv/translate.c   |   3 +-
 10 files changed, 111 insertions(+), 117 deletions(-)

-- 
2.42.0



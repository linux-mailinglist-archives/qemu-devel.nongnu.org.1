Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 226A073FD7F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 16:13:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE9Qg-0007NL-6W; Tue, 27 Jun 2023 10:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1qE9Qe-0007Mq-L7
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:12:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1qE9Qb-0007QQ-On
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:12:24 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b51488ad67so23972725ad.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 07:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1687875140; x=1690467140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kli0/Lkm16c0rkWo2x67k9BNkE6PIAQDk2lO7/WA3d8=;
 b=CbIrGq4afD7PHD7dcr/9asa9Q0jOxa5nVcVv+TTJC0xpZFUXPJwl8zFqPx7hi3Dmqm
 qZfROlP7P3OwBTVE0sLC4lmKvjn+xE8UB//x+BPyyK0+VCgDJjQPyzRuOl1DICS2LXpY
 bLVACQQIMN960xVS7Fb6TDuuIFBrHYCSIB5NI5eK/G7ozvDYnOZmBB5gQ8e8vSmTXo9W
 hrfienXUFDt45soCztrx/dcix7QSHI3t6F7oQH0IuK2voy+Fql36T7aZo2FO1AaHf7Ls
 ADSJXamGSNtF+kUxOZbNqmiitoCffy/TBoNCnqEWsUn41c40i0ZYPyA6Bnz00DiLsHHd
 9v7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687875140; x=1690467140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kli0/Lkm16c0rkWo2x67k9BNkE6PIAQDk2lO7/WA3d8=;
 b=GRuDypEhtAys3wwgLid4k1TuHBCg5nk+SjfU9iM29PDAFU9LqdaOqvopKcaryDNvWg
 u+tModVxO/P0Ncdaf6eNvdph4z5wLVLTA/gJCO/VSebUS6lgSwYt2yB+ilTG+DPPG98o
 uXu6rVQkT/jFcO+2dE1q5wTS7VTFWkyMV4ZBTncpDoHouH6Cs7KrGPU+Hai/YOYtNXac
 TJr/vuGwEj5yogd89wtqi+IHu3nipvhxF7sgFUqfsRGh9qTsLXlgL7+brH/SFG9NnB9F
 JUe/CanT0C049h3dgXnU9HK9+apR6dqY/mE14lfnl8l+UoPF7W81yvg+I0o4NNl+jB+l
 aoBA==
X-Gm-Message-State: AC+VfDx88U9hIYe+X+9mwYuJnDju4dfRY9o7UiiF31ctDLmfVNdVtFjI
 j4mmWUs4TW4E7LrNMTBPU1GxLnk/HMVM+I2RsSbRSiJvJgPrpvd3gMKO42ZPT8Lneip0e79VOYx
 aufcUn72fmZjkgUx13el28Q8t9vRkwXCqOzXCgMJBe/FRBpxsxFw647rAXiBjECAls/9PQFMpgg
 ==
X-Google-Smtp-Source: ACHHUZ7nQQIYZe2lZX50FyRPF0fCes5OL7vdxtw+WAJjaz3GeXKMeMst6lOOkjjkpZg5DVemJ8iToQ==
X-Received: by 2002:a17:902:e744:b0:1b5:edd:e3c7 with SMTP id
 p4-20020a170902e74400b001b50edde3c7mr9069777plf.16.1687875139599; 
 Tue, 27 Jun 2023 07:12:19 -0700 (PDT)
Received: from sw05.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001b69303db65sm6080441plh.26.2023.06.27.07.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 07:12:19 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 jim.shu@sifive.com, frank.chang@sifive.com, liweiwei@iscas.ac.cn,
 philmd@linaro.org, Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v6 0/3] Implement the watchdog timer of HiFive 1 rev b.
Date: Tue, 27 Jun 2023 07:12:13 -0700
Message-Id: <20230627141216.3962299-1-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=tommy.wu@sifive.com; helo=mail-pl1-x630.google.com
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

The HiFive 1 rev b includes a watchdog module based on a 32-bit
counter. The watchdog timer is in the always-on domain device of
HiFive 1 rev b, so this patch added the AON device to the sifive_e
machine. This patch only implemented the functionality of the
watchdog timer, not all the functionality of the AON device.

You can test the patchset by the QTest tests/qtest/sifive-e-aon-watchdog-test.c

Changes since v1 ( Thank Alistair for the feedback ):
- Use the register field macro.
- Delete the public create function. The board creates the aon device itself.
- Keep all variable declarations at the top of the code block.

Changes since v2 ( Thank Alistair for the feedback ):
- Delete the declaration and definition of the create function.

Changes since v3 ( Thank Alistair and Thomas for the feedback ):
- Use `device_class_set_props()` for the properties in sifive_e_aon device.
- Add SPDX identifier in QTEST.
- Use libqtest.h in QTEST.
- Let the statements on one line as long as they still fit into 80 columns.

Changes since v4 ( Thank Phil for the feedback ):
- Improve code style consistency.
- Move the timer create function to the sifive_e_aon_init.
- Allocate the sifive_e_aon device state in the SoC.

Changes since v5 ( Thank Alistair for the feedback ):
- Rebase to the riscv-to-apply.next branch.

Tommy Wu (3):
  hw/misc: sifive_e_aon: Support the watchdog timer of HiFive 1 rev b.
  hw/riscv: sifive_e: Support the watchdog timer of HiFive 1 rev b.
  tests/qtest: sifive-e-aon-watchdog-test.c: Add QTest of watchdog of
    sifive_e

 hw/misc/Kconfig                          |   3 +
 hw/misc/meson.build                      |   1 +
 hw/misc/sifive_e_aon.c                   | 319 ++++++++++++++++
 hw/riscv/Kconfig                         |   1 +
 hw/riscv/sifive_e.c                      |  17 +-
 include/hw/misc/sifive_e_aon.h           |  60 +++
 include/hw/riscv/sifive_e.h              |   9 +-
 tests/qtest/meson.build                  |   3 +
 tests/qtest/sifive-e-aon-watchdog-test.c | 450 +++++++++++++++++++++++
 9 files changed, 858 insertions(+), 5 deletions(-)
 create mode 100644 hw/misc/sifive_e_aon.c
 create mode 100644 include/hw/misc/sifive_e_aon.h
 create mode 100644 tests/qtest/sifive-e-aon-watchdog-test.c

-- 
2.31.1



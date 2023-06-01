Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAEB71970F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:36:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eiJ-0007iJ-A9; Thu, 01 Jun 2023 05:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4ei1-0007f1-Im
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:35:05 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4ehw-0008RY-VW
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:35:04 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f4c264f6c6so681013e87.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685612095; x=1688204095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Zwvv7hRmZE3KagMMUek3a8BemDtxYZcXS3YbhElKH8=;
 b=UZP6BAwmLY10EpomH4dV6egqcE0OD95bP3Jw4lNbeZNHcjkwzZG0637F26+P19yfgP
 xDrT7rRt4PVV2dCqA1v7bpSZVsYA74yWDoKCtrobgIT2jxLRjUTQO++8nReoiiQRtYL5
 3lzBm8J8vPrf4FvUYrRx9KTk1odNA7tiCHbYevFUpN4bFzmqwYiHA4x+FpllWJagdXpO
 pNjUwfelXpi+0qw8x3kvY2hN1Y5IZ/4Uy9Lqi1fFF+57ElvOSuyKyOBp/OEr5NUVA+yJ
 DS7uJVKe+CHhha7Uvg2hD3NPp53OfPZG+otVAi2P2z98XAbIbR7J/RQFC6FL9mjQNld9
 LmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685612095; x=1688204095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Zwvv7hRmZE3KagMMUek3a8BemDtxYZcXS3YbhElKH8=;
 b=LoSsWVHWv/9riaTXiu7jn7f40n2CIjZ71Yl92dPm6n4mP2eszVB+G1iTq3szW+uEDc
 aCDwrfJO7GPQKQGp3mUEM4ahkqgjk6gxTyE6uxKkD8Sk9hKd8500/D9yA4JwCIICKgWk
 cE2DuHrDg7Pe3NnjJzOMxasXCxpbK5e+cIgVYJgsshImpt5mKgrDoVDyqEKq5h5m1J/T
 GX+wnupZoGhxfnxCLeKnyKPReD97kdr3MghtVpCbXve6CCXxpm0uQ+o3RP8pYxOv1lpy
 dp8vhTHuE56qW0hZe070SubYKGqLwmp82TxI+yXORmt8G0udktDrGo4Dldla/NNQbEwf
 4SDA==
X-Gm-Message-State: AC+VfDxhPX+nBFTfrcoVTkgKzKsTMow8duk2RZmnkL0X0/mP1wuQZuNe
 Q12uGdeAfC5g+/P7Z9+QrAmR6BE4F4MBxNejsEE=
X-Google-Smtp-Source: ACHHUZ5kxHSdw51damig2A4JyOXkjpWHjUbfb6Bl3e7q3uN7h37Rdizqb8FmhjeBb8oMrdlpV/il7A==
X-Received: by 2002:ac2:5223:0:b0:4f3:b9b1:5683 with SMTP id
 i3-20020ac25223000000b004f3b9b15683mr897808lfl.62.1685612094720; 
 Thu, 01 Jun 2023 02:34:54 -0700 (PDT)
Received: from localhost.localdomain ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 q25-20020a7bce99000000b003eddc6aa5fasm1637449wmj.39.2023.06.01.02.34.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Jun 2023 02:34:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] bulk: Remove pointless QOM casts
Date: Thu,  1 Jun 2023 11:34:50 +0200
Message-Id: <20230601093452.38972-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

As per Markus suggestion in [*], use Coccinelle to remove
pointless QOM cast macro uses. Since we have more than 1000
QOM types, add a script to generate the semantic patch.

[*] https://lore.kernel.org/qemu-devel/87mt1jafjt.fsf@pond.sub.org/

Philippe Mathieu-Daudé (2):
  scripts: Add qom-cast-macro-clean-cocci-gen.py
  bulk: Remove pointless QOM casts

 MAINTAINERS                               |  1 +
 block/nbd.c                               |  4 +-
 chardev/char-pty.c                        |  2 +-
 hw/arm/musicpal.c                         |  2 +-
 hw/arm/xlnx-versal.c                      |  2 +-
 hw/display/vhost-user-gpu.c               |  4 +-
 hw/intc/loongarch_extioi.c                |  6 +--
 hw/m68k/q800.c                            |  2 +-
 hw/pci-host/bonito.c                      |  2 +-
 hw/ppc/pnv_lpc.c                          |  2 +-
 hw/ppc/pnv_occ.c                          |  2 +-
 hw/ppc/pnv_sbe.c                          |  2 +-
 hw/riscv/virt.c                           | 10 ++---
 hw/rx/rx62n.c                             |  2 +-
 hw/scsi/esp-pci.c                         | 18 ++++-----
 hw/sparc/sun4m.c                          |  4 +-
 hw/virtio/virtio-mem-pci.c                |  6 +--
 hw/virtio/virtio-pmem-pci.c               |  6 +--
 migration/fd.c                            |  4 +-
 migration/multifd.c                       |  2 +-
 migration/yank_functions.c                |  4 +-
 nbd/client-connection.c                   |  2 +-
 nbd/server.c                              |  2 +-
 softmmu/qdev-monitor.c                    |  2 +-
 ui/vnc-ws.c                               |  6 +--
 scripts/qom-cast-macro-clean-cocci-gen.py | 49 +++++++++++++++++++++++
 26 files changed, 99 insertions(+), 49 deletions(-)
 create mode 100644 scripts/qom-cast-macro-clean-cocci-gen.py

-- 
2.38.1



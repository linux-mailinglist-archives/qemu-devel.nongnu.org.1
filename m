Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CD67B6258
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 09:15:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZcB-0007RS-3Y; Tue, 03 Oct 2023 03:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qnZc8-0007QO-Gf
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:14:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qnZc6-0001g1-Su
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:14:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-406618d0992so5582165e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 00:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1696317277; x=1696922077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xAz3Q9xwqF0zjF/LWQXdtUbACVaAgxLIdX99onEbpT0=;
 b=XKUTglMqlMDTNx53bTBwobMzKRltzACwz2EeOhN+OG1tad2SswtxVfcT/RyB4xmn+N
 rwBi570abwrqJNvTZW9tmqQRxLGfvbtYRbUV4OwNQICpb+rCE0yof8VMEo8iaY8/aZB5
 ERoP+R0BmKfyPDZArSFLIY9oq1vmw3bcmGXaCQxqtR8YsHm0nhxQfh6z3BRkra9afZaG
 xGgCiG7j0wn3WLDEekMy34dKED5BEdHjjLQxKX8uBeyyid54AkNfMLieCmDTSqNU89Y2
 LJUgryZZep9K0KmvsFKoG5mlXtAR1G4no37cbLK/RacASDC/V1x1HK5M3RjDsswMzbS3
 QgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696317277; x=1696922077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xAz3Q9xwqF0zjF/LWQXdtUbACVaAgxLIdX99onEbpT0=;
 b=hMeDktKbpMftVZzPS4joH+hInxtQ4McFvBwO0wD68VyQeH23xPKcIwxSRtbFD8lPnD
 7P1OPN9HBXAvgMcDagTwfXU1E0yONXCYGqmMcFT0qOChs+DfSMK4PCLd3D9UMQmpHqyZ
 rJZaSaP6GTdbY5uMWNIcFQ9hRO2aG8i+MgSw/y6lxMbFhCR3for5m/bmcCuvw2EJu8pq
 N8SjICaB8DjhoGvmKmmFDQo9hsx01u/eh3+kFoiKJBhBcFDkG1UbX6wy2a3llRrLmw3x
 XVpZSgWEnoUNF2FliooQJSPCca8qg7CAMM3dFfwWPf1Sn3mZ/kYRxTQGHhbwZ5NoMScv
 omtg==
X-Gm-Message-State: AOJu0Yz3Vs8FYj/OmVEoF2M5GzmRks/0bt7zHUB0iOAbSYKRcOxoT3XO
 uuD95hcjAGaKCAB3x1l6Y6bG/sCTpSC5CnHDzl8=
X-Google-Smtp-Source: AGHT+IHLMWvWpSF47JJSD7pOWvf+cSgjEwKjh7v/xVFj2g6tHlGSfjpn0uAKkL04FCJr6a4Zs//LFw==
X-Received: by 2002:a7b:c419:0:b0:405:4002:825a with SMTP id
 k25-20020a7bc419000000b004054002825amr11667188wmi.13.1696317276881; 
 Tue, 03 Oct 2023 00:14:36 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a5d4710000000b003179d5aee67sm832196wrq.94.2023.10.03.00.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 00:14:36 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, peter.maydell@linaro.org, alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v4 0/5] Risc-V/gdb: replace exit calls with proper shutdown
Date: Tue,  3 Oct 2023 09:14:22 +0200
Message-Id: <20231003071427.188697-1-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series replaces some of the call to exit in hardware used by
Risc-V boards. Otherwise, the gdb connection can be abruptly
disconnected resulting in the last gdb packet "Wxx" being not sent.

For the gdbstub modification, gdb_exit calls ensure that the "Wxx"
packet is sent before exiting. However, some features (see
net/vhost-vdpa.c: vhost_vdpa_cleanup for example) are expecting
that a cleanup is being made before exiting. This, it's probably
safer to follow the same logic here as well.

Difference with v3:
 - Rebase on riscv-to-apply

Clément Chigot (5):
  softmmu: add means to pass an exit code when requesting a shutdown
  softmmu: pass the main loop status to gdb "Wxx" packet
  hw/misc/sifive_test.c: replace exit calls with proper shutdown
  hw/char: riscv_htif: replace exit calls with proper shutdown
  gdbstub: replace exit calls with proper shutdown for softmmu

 gdbstub/gdbstub.c          |  5 +++--
 gdbstub/softmmu.c          |  6 ++++++
 gdbstub/user.c             |  6 ++++++
 hw/char/riscv_htif.c       |  5 ++++-
 hw/misc/sifive_test.c      |  9 +++++++--
 include/gdbstub/syscalls.h |  9 +++++++++
 include/sysemu/runstate.h  |  2 ++
 include/sysemu/sysemu.h    |  2 +-
 softmmu/main.c             |  2 +-
 softmmu/runstate.c         | 16 +++++++++++++---
 10 files changed, 52 insertions(+), 10 deletions(-)

-- 
2.25.1



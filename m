Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F5075E0F9
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 11:35:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNVU7-0005GM-NJ; Sun, 23 Jul 2023 05:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qNVU5-0005Fy-9H
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:34:37 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qNVU3-0003Lf-RU
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:34:37 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1bb575a6ed3so308167fac.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690104874; x=1690709674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbS+mDv2rQgCbAJdkRQhhFil4mhfQwAqCKHTDyG+nCg=;
 b=YUkpoFsoWxSTamK9ZIt/4PGYW1QCraGu+q1Iq3OtgExVNMTYlPHHRRr+wHhzlYcy7z
 sSTEYFfc4uXs+s9f9kLAqyJErl+a1zZ7XWe6QEfjsYPTRFXAPbTYLQJLoYkBOu2Bv15+
 AP3pDonX7AjEtbfZoXnl2PKWb2BKQLPTGIuwPTSw1b2UyqCyxkwsF0fvb0nA9fMysKv2
 bedNPNxSdgRI3kaNhWP+tGsjzjTUr2i2Vlh9MhsOqRDSsKA/rLq5WH3mMalB5WZowGhl
 vezJKA1UdeG0xIZizJ0Y8OAZl2bEuqAWraEdMIND9X0KNg8xFDfZl9mciktzP/3j+gR1
 YHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690104874; x=1690709674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbS+mDv2rQgCbAJdkRQhhFil4mhfQwAqCKHTDyG+nCg=;
 b=YKKe1Gbj8dk3XhXC9NULLJjkXcH5vHIX98KAIRahCBqFvJhupRnJKyP2Q2fiQ9Vjmp
 JDew9p1S0Jp0a3pYJenXsS59PNrwgs3sdYKQtHtg4JKY9vpdA1n3vrsEAUd2VgC/Cknl
 DYMciF8WT/p29UMObCYKNOSfMDzLBpYjomtYn13NfgzpeQbaV/hssdSNicYGA8dAiO+F
 IzpZa92BRGwMdnjZX6ikiJuOrEeA7VU+y20+8Y7+IPROxB0E5KGWo6UUHTzLssvrXAsC
 ynKY6+G9DqqVTNsRA9DE/UmtTGi4DpDktD4RUv/bq7uzJ2h7sZ/sIDc+brrLzHogmA2N
 xPDg==
X-Gm-Message-State: ABy/qLZ7Eo9Ag1c6/y8krgka+HUZA9PjqAugp/G52BVIANcBlbqnHV/g
 tcFFqS5GVMUb7tamlJO3nUOSd4HWaupZqA==
X-Google-Smtp-Source: APBJJlE2Rx6iSmS8DWtts+lYS0m4eb9sbGM9YHsE+FbmfpnqJuhLzC7S+0k5vsxCGzLCuAoA+nZ8xg==
X-Received: by 2002:a05:6871:299:b0:19f:9495:95ff with SMTP id
 i25-20020a056871029900b0019f949595ffmr7927781oae.27.1690104874086; 
 Sun, 23 Jul 2023 02:34:34 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a5-20020aa78645000000b0064f76992905sm5647475pfo.202.2023.07.23.02.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 02:34:33 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Bin Meng <bmeng@tinylab.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PULL 1/1] roms/opensbi: Upgrade from v1.3 to v1.3.1
Date: Sun, 23 Jul 2023 19:34:14 +1000
Message-Id: <20230723093414.859532-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230723093414.859532-1-alistair.francis@wdc.com>
References: <20230723093414.859532-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Bin Meng <bmeng@tinylab.org>

Upgrade OpenSBI from v1.3 to v1.3.1 and the pre-built bios images
which fixes the boot failure seen when using QEMU to do a direct
kernel boot with Microchip Icicle Kit board machine.

The v1.3.1 release includes the following commits:

0907de3 lib: sbi: fix comment indent
eb736a5 lib: sbi_pmu: Avoid out of bounds access
7828eeb gpio/desginware: add Synopsys DesignWare APB GPIO support
c6a3573 lib: utils: Fix sbi_hartid_to_scratch() usage in ACLINT drivers
057eb10 lib: utils/gpio: Fix RV32 compile error for designware GPIO driver

Signed-off-by: Bin Meng <bmeng@tinylab.org>
Message-Id: <20230719165817.889465-1-bmeng@tinylab.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 135344 -> 135376 bytes
 .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 138304 -> 138368 bytes
 roms/opensbi                                  |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
index 7b6c67e0ae..9a2ba3f2a4 100644
Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
index 1b831b412c..5d4e812819 100644
Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
diff --git a/roms/opensbi b/roms/opensbi
index 2552799a1d..057eb10b6d 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit 2552799a1df30a3dcd2321a8b75d61d06f5fb9fc
+Subproject commit 057eb10b6d523540012e6947d5c9f63e95244e94
-- 
2.40.1



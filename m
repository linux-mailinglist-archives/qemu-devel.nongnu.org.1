Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F33877F5075
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 20:17:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5sCL-0007f5-Vk; Wed, 22 Nov 2023 13:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5sCJ-0007ev-Hj
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:43:39 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5sCH-00071B-TM
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:43:39 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4083f613272so396105e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700678616; x=1701283416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jwHo/tGYbjQnZzolItAUZKsD/hW+gqW7av2VFd5Fxgg=;
 b=QfzpgDqA9D+CPllu0RC9GXGSypTadv58sEBHbglGznbh2FmLLepxVtSPDXcg76IGnD
 K5GL0ErR1k4UvbRkgzIOZG6jP4RHKl2R8apST40RW1cIodwY0J0SJVJhdDYNgok91mxm
 C1mzWm6wrBm1TiX1XkW36rmJHIwXIueao4stzHGT7lul0V0ni/JOFOBP0ncR16UPkpdQ
 c7xgGMcpHfss18Zv5gFd+pGnTum5YQ+lUOjROW2jbG/b0t6fzv6HHgImYuRhJzRWTaDZ
 /uAVAKWtz/upsUyWEEUVdiwkSNRfIFQTjW1ux8Acav5dBIT2ziAR4B3BL7KLLZsLAVAC
 jIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700678616; x=1701283416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jwHo/tGYbjQnZzolItAUZKsD/hW+gqW7av2VFd5Fxgg=;
 b=KxMtdSmeG1uQ8IjTyS2BTTxGzsoMm6iOanJv3TpMSWzWFoHPxgbY4u9jpINgTAT+Vx
 G64OhbEjM1eLqYdn5TeIj/gWxk9Ha/HDfWdmVNW3Hg5ajma3cLGIaisygrMNbpXtZ6RU
 Z2a3hUMBnBLBbgBuu0H4yYSFjhAme+zeMvNk0hDwfm981wHDDo8XJzWuqRwmgyuEzpp/
 dkuOedOZpmyshIZ6qEo9d2kd4lRfeYEpRUutlQmSz1fai/Og0+mPgdBTNemf+ypjLuIl
 Zv7NEsJqR5GQVsQ31mLZN6Mc4sKoHKFMJUO+RJIp4VVjnmB7+hCG+p67gZ4h/hILO1OQ
 TTQg==
X-Gm-Message-State: AOJu0YzsFx16EnXw6QYHcBjO6QGIXdQn9kwuEkUplTlqok4//nmx5N8k
 JnVR8kEJiFB2AjMSm2jZV38O3Qk8YSs4utTKoyU=
X-Google-Smtp-Source: AGHT+IGYjg7n6/IYdvXUrexFdzkqJdi59FdNHDQg/fXyP2Z7yIOf7gZc+FNX5ja/8KPSvma7Qbzypw==
X-Received: by 2002:adf:d1c7:0:b0:32f:8024:64f1 with SMTP id
 b7-20020adfd1c7000000b0032f802464f1mr2720288wrd.2.1700678616151; 
 Wed, 22 Nov 2023 10:43:36 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 n2-20020a5d4202000000b0032db8cccd3asm58359wrq.114.2023.11.22.10.43.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:43:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0] hw/mips: Inline 'bios.h' definitions
Date: Wed, 22 Nov 2023 19:43:34 +0100
Message-ID: <20231122184334.18201-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

There is no universal BIOS, each machine needs a specific one.

Move the machine-specific definitions to each machine code and
remove this bogus header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/bios.h | 14 --------------
 hw/mips/jazz.c         | 10 +++++++++-
 hw/mips/malta.c        |  9 ++++++++-
 hw/mips/mipssim.c      | 10 +++++++++-
 4 files changed, 26 insertions(+), 17 deletions(-)
 delete mode 100644 include/hw/mips/bios.h

diff --git a/include/hw/mips/bios.h b/include/hw/mips/bios.h
deleted file mode 100644
index 44acb6815b..0000000000
--- a/include/hw/mips/bios.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef HW_MIPS_BIOS_H
-#define HW_MIPS_BIOS_H
-
-#include "qemu/units.h"
-#include "cpu.h"
-
-#define BIOS_SIZE (4 * MiB)
-#if TARGET_BIG_ENDIAN
-#define BIOS_FILENAME "mips_bios.bin"
-#else
-#define BIOS_FILENAME "mipsel_bios.bin"
-#endif
-
-#endif
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index d33a76ad4d..0d2348aa5a 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -36,7 +36,6 @@
 #include "hw/boards.h"
 #include "net/net.h"
 #include "hw/scsi/esp.h"
-#include "hw/mips/bios.h"
 #include "hw/loader.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/timer/i8254.h"
@@ -53,12 +52,19 @@
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 #endif /* CONFIG_TCG */
+#include "cpu.h"
 
 enum jazz_model_e {
     JAZZ_MAGNUM,
     JAZZ_PICA61,
 };
 
+#if TARGET_BIG_ENDIAN
+#define BIOS_FILENAME "mips_bios.bin"
+#else
+#define BIOS_FILENAME "mipsel_bios.bin"
+#endif
+
 static void main_cpu_reset(void *opaque)
 {
     MIPSCPU *cpu = opaque;
@@ -147,6 +153,8 @@ static void mips_jazz_init_net(NICInfo *nd, IOMMUMemoryRegion *rc4030_dma_mr,
     prom[7] = 0xff - checksum;
 }
 
+#define BIOS_SIZE (4 * MiB)
+
 #define MAGNUM_BIOS_SIZE_MAX 0x7e000
 #define MAGNUM_BIOS_SIZE                                                       \
         (BIOS_SIZE < MAGNUM_BIOS_SIZE_MAX ? BIOS_SIZE : MAGNUM_BIOS_SIZE_MAX)
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 049de46a9e..d22bb1edef 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -40,7 +40,6 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "qemu/log.h"
-#include "hw/mips/bios.h"
 #include "hw/ide/pci.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
@@ -59,6 +58,7 @@
 #include "hw/qdev-clock.h"
 #include "target/mips/internal.h"
 #include "trace.h"
+#include "cpu.h"
 
 #define ENVP_PADDR          0x2000
 #define ENVP_VADDR          cpu_mips_phys_to_kseg0(NULL, ENVP_PADDR)
@@ -71,6 +71,7 @@
 #define RESET_ADDRESS       0x1fc00000ULL
 
 #define FLASH_SIZE          0x400000
+#define BIOS_SIZE           (4 * MiB)
 
 #define PIIX4_PCI_DEVFN     PCI_DEVFN(10, 0)
 
@@ -91,6 +92,12 @@ typedef struct {
     bool display_inited;
 } MaltaFPGAState;
 
+#if TARGET_BIG_ENDIAN
+#define BIOS_FILENAME "mips_bios.bin"
+#else
+#define BIOS_FILENAME "mipsel_bios.bin"
+#endif
+
 #define TYPE_MIPS_MALTA "mips-malta"
 OBJECT_DECLARE_SIMPLE_TYPE(MaltaState, MIPS_MALTA)
 
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 4f743f37eb..01e323904d 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -35,7 +35,6 @@
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
-#include "hw/mips/bios.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/sysbus.h"
@@ -43,6 +42,15 @@
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
+#include "cpu.h"
+
+#define BIOS_SIZE (4 * MiB)
+
+#if TARGET_BIG_ENDIAN
+#define BIOS_FILENAME "mips_bios.bin"
+#else
+#define BIOS_FILENAME "mipsel_bios.bin"
+#endif
 
 static struct _loaderparams {
     int ram_size;
-- 
2.41.0



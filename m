Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 319F97DA6F5
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 14:26:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwiMq-0006PT-82; Sat, 28 Oct 2023 08:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qwiMo-0006OW-Vg; Sat, 28 Oct 2023 08:24:38 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qwiMn-0006ma-6v; Sat, 28 Oct 2023 08:24:38 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53e08e439c7so4972035a12.0; 
 Sat, 28 Oct 2023 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698495874; x=1699100674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjgdUkcWnddjAoJazRvwcvImmvBOY1raY1kEKMOKf0U=;
 b=kLlozT/wxisgJdu9nNPJ2Doc10Dlgu+5O/FsYU54yO/l+8bd1PCJaKaRAd6/68BTRu
 dC2/IVL3muAlXZ5CKqkqSFSwgi06cDxrc88TxfnE9Dw6Wt1VzijkFBmWuJG5jBVzx296
 h1Bn+ygTpCN3f5aIrFDZwzjZ8/FcS5cDoQ5m9Ev4AGm6lzE2qwfU6fq8h9ZBF1RUL6N+
 GoSNBauJRKyP106U1PHQt8thOVVaa7zOxoPfEytVckIbr8xh6qNG9LaJUiumnJ0zA+s3
 ZCr9w+lGBAV7j2kywTKJIx6ybVkqNeTdZsIVz6Km+Vg0r+XFVt+UIAaR7o1litvnkBXw
 T67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698495874; x=1699100674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fjgdUkcWnddjAoJazRvwcvImmvBOY1raY1kEKMOKf0U=;
 b=drvM+RN+6mkbBFkI1YBwoMSr+Nbyy202YyHMq2EyONVOrN522rz0Ht/P7uSXN2No38
 nDHnGb4c2pgy1Qf+3J6DNdSdjfvN+qXTicBQpQd1XwKCeoeaUmkVgLgEy6wpJACufe/n
 erkNSwZ2sil7tdnRif/Y+pNgehCrZLzSUCtzrMEO/XB6V3lKeO3A8D7jmNuA8elHlSAm
 Sprh4Y7XyfFig0RjFuD/Oq87Gzutcn1y5FbLykR9J59AfvD2jedu2TDY+dlrOL1oe0q7
 M/Kj8eVx8U7akGtvf5M5Dkak3MrrBMHDymahO1X6IXnbkw9GFc0iJEUq1/K5J+shEgd3
 iSQg==
X-Gm-Message-State: AOJu0YxE5D/+Ij4VcJrNBl+4dvxsLDmu55ktPLOeAxLG6XWaVrwZAi2z
 tPeNV9Cw7e8OnTycuu3tji8W9b7Jy6A=
X-Google-Smtp-Source: AGHT+IGOSUYtIgWsA3aFhpnqbGAIgU9Hq/uj5HdoxIXee0RFUX3nzS4IbTyvCi7cbMOImsLF/RAteQ==
X-Received: by 2002:a17:907:3603:b0:9be:40ba:5f1 with SMTP id
 bk3-20020a170907360300b009be40ba05f1mr4436765ejc.60.1698495874201; 
 Sat, 28 Oct 2023 05:24:34 -0700 (PDT)
Received: from archlinux.. (dynamic-089-012-044-170.89.12.pool.telefonica.de.
 [89.12.44.170]) by smtp.gmail.com with ESMTPSA id
 a13-20020a170906190d00b009ae3d711fd9sm2706687eje.69.2023.10.28.05.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 05:24:33 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 5/6] hw/i2c/pm_smbus: Convert DPRINTF to trace events
Date: Sat, 28 Oct 2023 14:24:14 +0200
Message-ID: <20231028122415.14869-6-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231028122415.14869-1-shentey@gmail.com>
References: <20231028122415.14869-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Let the trace messages slightly deviate from the function names
("smb" -> "smbus") being traced in order to avoid conflights with the SMB
protocol.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i2c/pm_smbus.c   | 18 ++++--------------
 hw/i2c/trace-events |  6 ++++++
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 4e1b8a5182..78e7c229a8 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -23,6 +23,7 @@
 #include "hw/i2c/pm_smbus.h"
 #include "hw/i2c/smbus_master.h"
 #include "migration/vmstate.h"
+#include "trace.h"
 
 #define SMBHSTSTS       0x00
 #define SMBHSTCNT       0x02
@@ -64,15 +65,6 @@
 #define AUX_BLK       (1 << 1)
 #define AUX_MASK      0x3
 
-/*#define DEBUG*/
-
-#ifdef DEBUG
-# define SMBUS_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
-#else
-# define SMBUS_DPRINTF(format, ...)     do { } while (0)
-#endif
-
-
 static void smb_transaction(PMSMBus *s)
 {
     uint8_t prot = (s->smb_ctl >> 2) & 0x07;
@@ -82,7 +74,7 @@ static void smb_transaction(PMSMBus *s)
     I2CBus *bus = s->smbus;
     int ret;
 
-    SMBUS_DPRINTF("SMBus trans addr=0x%02x prot=0x%02x\n", addr, prot);
+    trace_smbus_transaction(addr, prot);
     /* Transaction isn't exec if STS_DEV_ERR bit set */
     if ((s->smb_stat & STS_DEV_ERR) != 0)  {
         goto error;
@@ -258,8 +250,7 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
     PMSMBus *s = opaque;
     uint8_t clear_byte_done;
 
-    SMBUS_DPRINTF("SMB writeb port=0x%04" HWADDR_PRIx
-                  " val=0x%02" PRIx64 "\n", addr, val);
+    trace_smbus_ioport_writeb(addr, val);
     switch(addr) {
     case SMBHSTSTS:
         clear_byte_done = s->smb_stat & val & STS_BYTE_DONE;
@@ -429,8 +420,7 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
         val = 0;
         break;
     }
-    SMBUS_DPRINTF("SMB readb port=0x%04" HWADDR_PRIx " val=0x%02x\n",
-                  addr, val);
+    trace_smbus_ioport_readb(addr, val);
 
     if (s->set_irq) {
         s->set_irq(s, smb_irq_value(s));
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index d7b1e25858..6900e06eda 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -15,6 +15,12 @@ i2c_send_async(uint8_t address, uint8_t data) "send_async(addr:0x%02x) data:0x%0
 i2c_recv(uint8_t address, uint8_t data) "recv(addr:0x%02x) data:0x%02x"
 i2c_ack(void) ""
 
+# pm_smbus.c
+
+smbus_ioport_readb(uint16_t addr, uint8_t data) "[0x%04" PRIx16 "] -> val=0x%02x"
+smbus_ioport_writeb(uint16_t addr, uint8_t data) "[0x%04" PRIx16 "] <- val=0x%02x"
+smbus_transaction(uint8_t addr, uint8_t prot) "addr=0x%02x prot=0x%02x"
+
 # allwinner_i2c.c
 
 allwinner_i2c_read(const char* reg_name, uint64_t offset, uint64_t value) "read %s [0x%" PRIx64 "]: -> 0x%" PRIx64
-- 
2.42.0



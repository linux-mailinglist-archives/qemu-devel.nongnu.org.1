Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4917DF8F2
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:41:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybg2-000474-QO; Thu, 02 Nov 2023 13:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeh-0003H6-LE
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybec-0002mB-LB
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32f737deedfso699164f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946729; x=1699551529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+OgurXglUm5DGvPAaUaiEGoa0h4kT2MTfg7/wu2rdFc=;
 b=aPM6WyqxyAB3A2/cX1OZIXu8YhIrzjUqluc/331q+8mp+3aQBUFRi0PqeYrXySMEMJ
 6/uCrp3WFy/4aueQq1PLSFOfk3GtBC1Go1pQHffjeDz5o8oCIbYjhvaG7eRbja3QB108
 26ZlTSkf6a/OaxhgWjVsypsWhTHP+ag7MVG4FPxvtfCBOccFaJWTLfgGhqfcivaaI3P8
 c4GoF2GPNzmr+uckS9Rpyy2cbnDUb2rt9umWucNtuNqFcuNyXbA9FVShWfcjN/M6XJ+H
 +1Cij6bTcuETK05yCQcDm1gVHKNemgvzXxcqA4looWdNhYjF6TIsWxIgs4My9MhPchwj
 I2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946729; x=1699551529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+OgurXglUm5DGvPAaUaiEGoa0h4kT2MTfg7/wu2rdFc=;
 b=A3epxJ8gMSc0qeslYGj0FveFUWVGDOgM/JyquDZVbnqDj9v13PQ1AnPhKbsrHvCwPQ
 3slYMB3uf7Z9fOHV14I/KOCMx8ylscD3Wav/0h+/age0AakBXZsL0+KetT3YOCT1E8lw
 BEt1ym9Z/YgM4QHxdaOROKbmm44F2APkYhMhit1ADLKWB0IbvfNMSQaGQHuDMks99GVr
 y18u18IoidQUhyzkFiAMGh/BxGESfLJmaEtFydTExgNe0VQi1WPfSKqFWEmIi7g7dA0J
 7/zivF8NsyxuWQpSjBqS9UpDWrlSXwspKneRWCo0vM4sIBoUNYWhz0ExiSgd7YgFSDnq
 eYaQ==
X-Gm-Message-State: AOJu0Yw5WzAbCHGBGca/0davQsTk/+UsBBCYE4nskZ9iU7qSEVesm0G2
 ajsQ+yh7WtqLV9ofv118LOTi0AcS/DR5Ig51S2Y=
X-Google-Smtp-Source: AGHT+IG9r8k7UjdoZWz5im2ee2sZxpHSPWHU4Ge9eSc2ndEvgkiBGWd0wsPsfZ8cJMgk/sF4qVkRmQ==
X-Received: by 2002:a05:6000:154a:b0:32f:7bd7:9f1d with SMTP id
 10-20020a056000154a00b0032f7bd79f1dmr13127798wry.48.1698946728947; 
 Thu, 02 Nov 2023 10:38:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/33] hw/i2c/pm_smbus: Convert DPRINTF to trace events
Date: Thu,  2 Nov 2023 17:38:24 +0000
Message-Id: <20231102173835.609985-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Let the trace messages slightly deviate from the function names
("smb" -> "smbus") being traced in order to avoid conflights with the SMB
protocol.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
Message-id: 20231028122415.14869-6-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/pm_smbus.c   | 18 ++++--------------
 hw/i2c/trace-events |  6 ++++++
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 4e1b8a5182d..78e7c229a85 100644
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
index d7b1e25858b..6900e06edad 100644
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
2.34.1



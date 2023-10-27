Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C15CE7D9BCB
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:43:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0v-0000rH-Ag; Fri, 27 Oct 2023 10:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0Q-0007P4-25
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:12 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0N-0008MD-S4
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:09 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5079f6efd64so2961397e87.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417604; x=1699022404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WfE82QtE9gjoYOqSmNGDI1DCesGIgDo1tOKozFv/i0w=;
 b=TcOg4yTD2cQ08ij6PwTDmk5bWcmxS8rXLewDthIPMDW8hGWjn6RYEKKLrngdWsxa+x
 rcnFwH2Ljk1Xqyod1NLpzmkAnflyKJpvqCqxMQ90TwiqvbVtBd8O9hx5q7kqWFE49Dnu
 2lo8LxLicuLy93OOPkhU7eus9GsiOEde3DrlWXAJKRbt7B8OIKpKfp52YAv+lK/xUUXZ
 cCIP9HozGKcGNo6VMubCNLZRfQjY8Mzm4WXlh3MjArsGKXpeiZ4qMmXj9fjlzcjr7RZz
 /E5BF8wQHjA7oUQhBLdSSw2ILLjfas9SVJE0TUgiPCAMs7kJowCYkDXXIVHeij86lmjF
 uDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417604; x=1699022404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WfE82QtE9gjoYOqSmNGDI1DCesGIgDo1tOKozFv/i0w=;
 b=k6vd0CwTWIYm/t+CFpAjHraAb2nX1eANxbY4AiCb8ANyoIWLFsWKzxTMIRClzuAc2x
 lAmee7mKPIQAbvypTpuOM6ZWR6Ltb8RFT4fIVgIWt2YTVr7iLIBp1gmKvtgP9snI22Zf
 RE8RFB/SrkkgDXlqDfkxu1BdvqO07E9FDHTvxpNaXTRT0peFh8MCsI20kSL5wBPgq8KT
 nnjL3j7W6K6pQzK4vwVJt/Ezq4rtsnoG3yk5E6RlaLj02hjvhC4apREz5uNB84+KYcPd
 8+UnOfgMyaeCJ6wC3zYg8+McbZMM9IGF4d9GnkJqsW9QRRJ+LnQLobTUH3YUwv4JDW/z
 gkVg==
X-Gm-Message-State: AOJu0YzOqZcTds+Qe2aXOMjNv+BxlS2nxitX/j2RzwlNWstrIAQEyvRO
 DiHZ2LZRiLdNWcitAB9dfJFIQcG3qs91xfoa5ck=
X-Google-Smtp-Source: AGHT+IHpJL3GXlzNt/P3ChLyNn+VK7lRJ1E28r22tSscvvrIrKsKJk6rqkqWLzKyW6RduKP3tY7Fkg==
X-Received: by 2002:ac2:4c93:0:b0:503:1b83:e352 with SMTP id
 d19-20020ac24c93000000b005031b83e352mr1994710lfl.52.1698417604084; 
 Fri, 27 Oct 2023 07:40:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.40.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:40:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/41] hw/net/cadence_gem: perform PHY access on write only
Date: Fri, 27 Oct 2023 15:39:41 +0100
Message-Id: <20231027143942.3413881-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

From: Luc Michel <luc.michel@amd.com>

The MDIO access is done only on a write to the PHYMNTNC register. A
subsequent read is used to retrieve the result but does not trigger an
MDIO access by itself.

Refactor the PHY access logic to perform all accesses (MDIO reads and
writes) at PHYMNTNC write time.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: sai.pavan.boddu@amd.com
Message-id: 20231017194422.4124691-11-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 56 ++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 373d3ee0712..06a101bfcd4 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1521,6 +1521,38 @@ static void gem_phy_write(CadenceGEMState *s, unsigned reg_num, uint16_t val)
     s->phy_regs[reg_num] = val;
 }
 
+static void gem_handle_phy_access(CadenceGEMState *s)
+{
+    uint32_t val = s->regs[R_PHYMNTNC];
+    uint32_t phy_addr, reg_num;
+
+    phy_addr = FIELD_EX32(val, PHYMNTNC, PHY_ADDR);
+
+    if (phy_addr != s->phy_addr) {
+        /* no phy at this address */
+        if (FIELD_EX32(val, PHYMNTNC, OP) == MDIO_OP_READ) {
+            s->regs[R_PHYMNTNC] = FIELD_DP32(val, PHYMNTNC, DATA, 0xffff);
+        }
+        return;
+    }
+
+    reg_num = FIELD_EX32(val, PHYMNTNC, REG_ADDR);
+
+    switch (FIELD_EX32(val, PHYMNTNC, OP)) {
+    case MDIO_OP_READ:
+        s->regs[R_PHYMNTNC] = FIELD_DP32(val, PHYMNTNC, DATA,
+                                         gem_phy_read(s, reg_num));
+        break;
+
+    case MDIO_OP_WRITE:
+        gem_phy_write(s, reg_num, val);
+        break;
+
+    default:
+        break; /* only clause 22 operations are supported */
+    }
+}
+
 /*
  * gem_read32:
  * Read a GEM register.
@@ -1541,20 +1573,6 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
         DB_PRINT("lowering irqs on ISR read\n");
         /* The interrupts get updated at the end of the function. */
         break;
-    case R_PHYMNTNC:
-        if (FIELD_EX32(retval, PHYMNTNC, OP) == MDIO_OP_READ) {
-            uint32_t phy_addr, reg_num;
-
-            phy_addr = FIELD_EX32(retval, PHYMNTNC, PHY_ADDR);
-            if (phy_addr == s->phy_addr) {
-                reg_num = FIELD_EX32(retval, PHYMNTNC, REG_ADDR);
-                retval &= 0xFFFF0000;
-                retval |= gem_phy_read(s, reg_num);
-            } else {
-                retval |= 0xFFFF; /* No device at this address */
-            }
-        }
-        break;
     }
 
     /* Squash read to clear bits */
@@ -1665,15 +1683,7 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         s->sar_active[(offset - R_SPADDR1HI) / 2] = true;
         break;
     case R_PHYMNTNC:
-        if (FIELD_EX32(val, PHYMNTNC, OP) == MDIO_OP_WRITE) {
-            uint32_t phy_addr, reg_num;
-
-            phy_addr = FIELD_EX32(val, PHYMNTNC, PHY_ADDR);
-            if (phy_addr == s->phy_addr) {
-                reg_num = FIELD_EX32(val, PHYMNTNC, REG_ADDR);
-                gem_phy_write(s, reg_num, val);
-            }
-        }
+        gem_handle_phy_access(s);
         break;
     }
 
-- 
2.34.1



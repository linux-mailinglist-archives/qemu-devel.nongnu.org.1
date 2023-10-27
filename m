Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE347D9C15
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:48:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0t-0000Z4-TP; Fri, 27 Oct 2023 10:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0P-0007P1-KM
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:12 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0L-0008Gt-KD
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:09 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32dc9ff4a8fso1387645f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417603; x=1699022403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C/6VeNVqAYw8mGQFBhg791eUfLvyqSXTXHYdCSjH8yk=;
 b=vZEtMhPzKekhXh76WmTClQQ8SjmGWPldSizovVdp9dniFOHODLpWlAxsRqhFWdfMjD
 VB3OUo8oMxzpasmL2OCEUVzZHoEVNu43GvBreoRyi5erbvcnRkPPNC2BdSPDAHh6rnmQ
 mLv+bnSlU8sh2wYjhHBS6bAHMww4+Wm/gHjpCUNALcjPFOYBcu4t/ojjIBgED/qARn6H
 JT04unsR9JaAoS9UBKvFXx9rbZZxKlu73v6K0AJwhs1ElWyPncA/fHfB4HCN7LsiyZk6
 GoLUFE1G3bIx8OTHK1U16Jq9X77UWmexDfuY9orqCIcehyNS2Fb8RWTvRd24pcvHtgOY
 /WKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417603; x=1699022403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/6VeNVqAYw8mGQFBhg791eUfLvyqSXTXHYdCSjH8yk=;
 b=J/NbrYIory/RiyhpJVICTJpDMel3RGsPA2kWEwgg8RVdEAhxuQ4EeN0d9keGOOQi+E
 VbSMNUFrzsylURqloW/w81wEXd974brqv0HqoRL5NVow/WkMx0dk93wOrczGSOK9RdnE
 8FEmegttrY9ed/JEqXxw2QBVKPHVAk0/joSBGJN8JLsHoBYB16yby1C7w1108GOYXvH+
 39rLqCHXiGGPKDr2T/uh089M6ND6218be4p+anZDaA9fx7/Sudl5+X7wCYf51M57ZxCu
 lIzovw/pPf9u9OKVKX5oOVEl0HOTzOQddCdPkxud7LbsjwGIO42Gbxhu8C5pqSXKaq0z
 qq4Q==
X-Gm-Message-State: AOJu0Yyby4r1dSPUuRAKZiiIWaRb/cw1Pe7gS222+EjnqPJ2rkNaBmxq
 I06oN7+UrNmX0sTZ/Z69yEm8G7O/8WewPsKsYII=
X-Google-Smtp-Source: AGHT+IFYULLe289uqZsSsu7lSewBrYb8QneHffZF34djgKrdapc7Aqy/dc1jkJaw00QMqSHbhL1Kvw==
X-Received: by 2002:a5d:4fc9:0:b0:31f:9b4f:1910 with SMTP id
 h9-20020a5d4fc9000000b0031f9b4f1910mr2335234wrw.63.1698417603370; 
 Fri, 27 Oct 2023 07:40:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.40.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:40:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/41] hw/net/cadence_gem: use FIELD to describe PHYMNTNC
 register fields
Date: Fri, 27 Oct 2023 15:39:40 +0100
Message-Id: <20231027143942.3413881-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Use the FIELD macro to describe the PHYMNTNC register fields.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: sai.pavan.boddu@amd.com
Message-id: 20231017194422.4124691-10-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index dffcc64df25..373d3ee0712 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -194,6 +194,14 @@ REG32(IDR, 0x2c) /* Interrupt Disable reg */
 REG32(IMR, 0x30) /* Interrupt Mask reg */
 
 REG32(PHYMNTNC, 0x34) /* Phy Maintenance reg */
+    FIELD(PHYMNTNC, DATA, 0, 16)
+    FIELD(PHYMNTNC, REG_ADDR, 18, 5)
+    FIELD(PHYMNTNC, PHY_ADDR, 23, 5)
+    FIELD(PHYMNTNC, OP, 28, 2)
+    FIELD(PHYMNTNC, ST, 30, 2)
+#define MDIO_OP_READ    0x3
+#define MDIO_OP_WRITE   0x2
+
 REG32(RXPAUSE, 0x38) /* RX Pause Time reg */
 REG32(TXPAUSE, 0x3c) /* TX Pause Time reg */
 REG32(TXPARTIALSF, 0x40) /* TX Partial Store and Forward */
@@ -342,13 +350,6 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
 
 
 
-#define GEM_PHYMNTNC_OP_R      0x20000000 /* read operation */
-#define GEM_PHYMNTNC_OP_W      0x10000000 /* write operation */
-#define GEM_PHYMNTNC_ADDR      0x0F800000 /* Address bits */
-#define GEM_PHYMNTNC_ADDR_SHFT 23
-#define GEM_PHYMNTNC_REG       0x007C0000 /* register bits */
-#define GEM_PHYMNTNC_REG_SHIFT 18
-
 /* Marvell PHY definitions */
 #define BOARD_PHY_ADDRESS    0 /* PHY address we will emulate a device at */
 
@@ -1541,12 +1542,12 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
         /* The interrupts get updated at the end of the function. */
         break;
     case R_PHYMNTNC:
-        if (retval & GEM_PHYMNTNC_OP_R) {
+        if (FIELD_EX32(retval, PHYMNTNC, OP) == MDIO_OP_READ) {
             uint32_t phy_addr, reg_num;
 
-            phy_addr = (retval & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
+            phy_addr = FIELD_EX32(retval, PHYMNTNC, PHY_ADDR);
             if (phy_addr == s->phy_addr) {
-                reg_num = (retval & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
+                reg_num = FIELD_EX32(retval, PHYMNTNC, REG_ADDR);
                 retval &= 0xFFFF0000;
                 retval |= gem_phy_read(s, reg_num);
             } else {
@@ -1664,12 +1665,12 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         s->sar_active[(offset - R_SPADDR1HI) / 2] = true;
         break;
     case R_PHYMNTNC:
-        if (val & GEM_PHYMNTNC_OP_W) {
+        if (FIELD_EX32(val, PHYMNTNC, OP) == MDIO_OP_WRITE) {
             uint32_t phy_addr, reg_num;
 
-            phy_addr = (val & GEM_PHYMNTNC_ADDR) >> GEM_PHYMNTNC_ADDR_SHFT;
+            phy_addr = FIELD_EX32(val, PHYMNTNC, PHY_ADDR);
             if (phy_addr == s->phy_addr) {
-                reg_num = (val & GEM_PHYMNTNC_REG) >> GEM_PHYMNTNC_REG_SHIFT;
+                reg_num = FIELD_EX32(val, PHYMNTNC, REG_ADDR);
                 gem_phy_write(s, reg_num, val);
             }
         }
-- 
2.34.1



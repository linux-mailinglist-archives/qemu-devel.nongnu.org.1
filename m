Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D877D9BB4
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:41:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0h-0007lD-RB; Fri, 27 Oct 2023 10:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0M-0007Nf-HO
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0I-0008Bm-KI
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:06 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32f760cbff3so215292f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417600; x=1699022400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=51fi7MWk5kopwCoLjbMUmeiyXLaENty65AuGPZ0oGcs=;
 b=fuH0Juq/WTBnyTnUST578h+wiNZu8TP6b7atb2v28RyUVI3gavG2RoH2haWsfdHAuG
 8749eG/eiTe0JxG7QfvKk2SHUHeMA+YwH7Mxj4bBz93jYr+85e3zHHBzTKofG28LxpzQ
 h3D3Xc/i/IlbrF0997onKOxe5OPngUscvEAbbhOOjr08ULeoNyA+BiIVr3sxxb2kpUcs
 JbuADztOEMIySZcg6DN2UHqxaFvY9ZlI7KTOjTgQ4GQR2rGcA//LM/gEf8KNYS4NUTt5
 0ON1NdA8PzKB7SX+DkY4UDALrCPiWqXI3SJAdsqdKPofpcJR4TGSjlNrHNTRfRQtDNib
 7jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417600; x=1699022400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=51fi7MWk5kopwCoLjbMUmeiyXLaENty65AuGPZ0oGcs=;
 b=n+WaVZnyC+YduWdBi5SxNPYS0Qn+qUFOfJSP6yhV6TJfcxN7WMpfC14nABV/wGfKF0
 8lz088y+dshZXoGDvfN3GO9oySI1uW20A3LGI1nn6hABBYQ1fTIO6Frnj6ioZWtR79Fm
 9xlrNLfsC6VwrGZyGyS+hmbfa+s0SA3LLFip/fuZiGawDQ4f0uuK6RZOGM4FCY2+vmnw
 rgcpgxgE0v+u4z3UnIsXzHgdLaJJgL4aR+5QJcafpZu/49I5IEVFjmpVu7FzMJyNcPVR
 u9DIjPaGiylytnZhHDxISu+WSRL5t1A8IEeBpBR+c/+viOOWnyjzjZR6cdqGClFjXVKy
 IhzA==
X-Gm-Message-State: AOJu0Yw/UYfhubD12QL4xPFiWKlT/DQUoSJ8g9xhdvUVeUqTLj1+00Y1
 usyrSAP8i7RBiE29/1Dl9LjffK2HKiztF8mNOY0=
X-Google-Smtp-Source: AGHT+IEl1SQsdwhkeLVEYEJPZWhwqWwtwOUc/g5JXhj703kDGnj3o111YGtdFNQ7yya1WsOfPkRmHA==
X-Received: by 2002:adf:f98d:0:b0:32d:87c9:1181 with SMTP id
 f13-20020adff98d000000b0032d87c91181mr1850790wrr.48.1698417599903; 
 Fri, 27 Oct 2023 07:39:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/41] hw/net/cadence_gem: use FIELD for screening registers
Date: Fri, 27 Oct 2023 15:39:33 +0100
Message-Id: <20231027143942.3413881-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Describe screening registers fields using the FIELD macros.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: sai.pavan.boddu@amd.com
Message-id: 20231017194422.4124691-3-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 94 ++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 46 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index bea2224dd8d..dd005562329 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -170,35 +170,38 @@ REG32(INT_Q1_DISABLE, 0x620)
 REG32(INT_Q7_DISABLE, 0x638)
 
 REG32(SCREENING_TYPE1_REG0, 0x500)
-
-#define GEM_ST1R_UDP_PORT_MATCH_ENABLE  (1 << 29)
-#define GEM_ST1R_DSTC_ENABLE            (1 << 28)
-#define GEM_ST1R_UDP_PORT_MATCH_SHIFT   (12)
-#define GEM_ST1R_UDP_PORT_MATCH_WIDTH   (27 - GEM_ST1R_UDP_PORT_MATCH_SHIFT + 1)
-#define GEM_ST1R_DSTC_MATCH_SHIFT       (4)
-#define GEM_ST1R_DSTC_MATCH_WIDTH       (11 - GEM_ST1R_DSTC_MATCH_SHIFT + 1)
-#define GEM_ST1R_QUEUE_SHIFT            (0)
-#define GEM_ST1R_QUEUE_WIDTH            (3 - GEM_ST1R_QUEUE_SHIFT + 1)
+    FIELD(SCREENING_TYPE1_REG0, QUEUE_NUM, 0, 4)
+    FIELD(SCREENING_TYPE1_REG0, DSTC_MATCH, 4, 8)
+    FIELD(SCREENING_TYPE1_REG0, UDP_PORT_MATCH, 12, 16)
+    FIELD(SCREENING_TYPE1_REG0, DSTC_ENABLE, 28, 1)
+    FIELD(SCREENING_TYPE1_REG0, UDP_PORT_MATCH_EN, 29, 1)
+    FIELD(SCREENING_TYPE1_REG0, DROP_ON_MATCH, 30, 1)
 
 REG32(SCREENING_TYPE2_REG0, 0x540)
-
-#define GEM_ST2R_COMPARE_A_ENABLE       (1 << 18)
-#define GEM_ST2R_COMPARE_A_SHIFT        (13)
-#define GEM_ST2R_COMPARE_WIDTH          (17 - GEM_ST2R_COMPARE_A_SHIFT + 1)
-#define GEM_ST2R_ETHERTYPE_ENABLE       (1 << 12)
-#define GEM_ST2R_ETHERTYPE_INDEX_SHIFT  (9)
-#define GEM_ST2R_ETHERTYPE_INDEX_WIDTH  (11 - GEM_ST2R_ETHERTYPE_INDEX_SHIFT \
-                                            + 1)
-#define GEM_ST2R_QUEUE_SHIFT            (0)
-#define GEM_ST2R_QUEUE_WIDTH            (3 - GEM_ST2R_QUEUE_SHIFT + 1)
+    FIELD(SCREENING_TYPE2_REG0, QUEUE_NUM, 0, 4)
+    FIELD(SCREENING_TYPE2_REG0, VLAN_PRIORITY, 4, 3)
+    FIELD(SCREENING_TYPE2_REG0, VLAN_ENABLE, 8, 1)
+    FIELD(SCREENING_TYPE2_REG0, ETHERTYPE_REG_INDEX, 9, 3)
+    FIELD(SCREENING_TYPE2_REG0, ETHERTYPE_ENABLE, 12, 1)
+    FIELD(SCREENING_TYPE2_REG0, COMPARE_A, 13, 5)
+    FIELD(SCREENING_TYPE2_REG0, COMPARE_A_ENABLE, 18, 1)
+    FIELD(SCREENING_TYPE2_REG0, COMPARE_B, 19, 5)
+    FIELD(SCREENING_TYPE2_REG0, COMPARE_B_ENABLE, 24, 1)
+    FIELD(SCREENING_TYPE2_REG0, COMPARE_C, 25, 5)
+    FIELD(SCREENING_TYPE2_REG0, COMPARE_C_ENABLE, 30, 1)
+    FIELD(SCREENING_TYPE2_REG0, DROP_ON_MATCH, 31, 1)
 
 REG32(SCREENING_TYPE2_ETHERTYPE_REG0, 0x6e0)
-REG32(TYPE2_COMPARE_0_WORD_0, 0x700)
 
-#define GEM_T2CW1_COMPARE_OFFSET_SHIFT  (7)
-#define GEM_T2CW1_COMPARE_OFFSET_WIDTH  (8 - GEM_T2CW1_COMPARE_OFFSET_SHIFT + 1)
-#define GEM_T2CW1_OFFSET_VALUE_SHIFT    (0)
-#define GEM_T2CW1_OFFSET_VALUE_WIDTH    (6 - GEM_T2CW1_OFFSET_VALUE_SHIFT + 1)
+REG32(TYPE2_COMPARE_0_WORD_0, 0x700)
+    FIELD(TYPE2_COMPARE_0_WORD_0, MASK_VALUE, 0, 16)
+    FIELD(TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE, 16, 16)
+
+REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
+    FIELD(TYPE2_COMPARE_0_WORD_1, OFFSET_VALUE, 0, 7)
+    FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_OFFSET, 7, 2)
+    FIELD(TYPE2_COMPARE_0_WORD_1, DISABLE_MASK, 9, 1)
+    FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
 
 /*****************************************/
 #define GEM_NWCTRL_TXSTART     0x00000200 /* Transmit Enable */
@@ -755,10 +758,9 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
         mismatched = false;
 
         /* Screening is based on UDP Port */
-        if (reg & GEM_ST1R_UDP_PORT_MATCH_ENABLE) {
+        if (FIELD_EX32(reg, SCREENING_TYPE1_REG0, UDP_PORT_MATCH_EN)) {
             uint16_t udp_port = rxbuf_ptr[14 + 22] << 8 | rxbuf_ptr[14 + 23];
-            if (udp_port == extract32(reg, GEM_ST1R_UDP_PORT_MATCH_SHIFT,
-                                           GEM_ST1R_UDP_PORT_MATCH_WIDTH)) {
+            if (udp_port == FIELD_EX32(reg, SCREENING_TYPE1_REG0, UDP_PORT_MATCH)) {
                 matched = true;
             } else {
                 mismatched = true;
@@ -766,10 +768,9 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
         }
 
         /* Screening is based on DS/TC */
-        if (reg & GEM_ST1R_DSTC_ENABLE) {
+        if (FIELD_EX32(reg, SCREENING_TYPE1_REG0, DSTC_ENABLE)) {
             uint8_t dscp = rxbuf_ptr[14 + 1];
-            if (dscp == extract32(reg, GEM_ST1R_DSTC_MATCH_SHIFT,
-                                       GEM_ST1R_DSTC_MATCH_WIDTH)) {
+            if (dscp == FIELD_EX32(reg, SCREENING_TYPE1_REG0, DSTC_MATCH)) {
                 matched = true;
             } else {
                 mismatched = true;
@@ -777,7 +778,7 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
         }
 
         if (matched && !mismatched) {
-            return extract32(reg, GEM_ST1R_QUEUE_SHIFT, GEM_ST1R_QUEUE_WIDTH);
+            return FIELD_EX32(reg, SCREENING_TYPE1_REG0, QUEUE_NUM);
         }
     }
 
@@ -786,10 +787,10 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
         matched = false;
         mismatched = false;
 
-        if (reg & GEM_ST2R_ETHERTYPE_ENABLE) {
+        if (FIELD_EX32(reg, SCREENING_TYPE2_REG0, ETHERTYPE_ENABLE)) {
             uint16_t type = rxbuf_ptr[12] << 8 | rxbuf_ptr[13];
-            int et_idx = extract32(reg, GEM_ST2R_ETHERTYPE_INDEX_SHIFT,
-                                        GEM_ST2R_ETHERTYPE_INDEX_WIDTH);
+            int et_idx = FIELD_EX32(reg, SCREENING_TYPE2_REG0,
+                                    ETHERTYPE_REG_INDEX);
 
             if (et_idx > s->num_type2_screeners) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Out of range ethertype "
@@ -805,27 +806,27 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
 
         /* Compare A, B, C */
         for (j = 0; j < 3; j++) {
-            uint32_t cr0, cr1, mask;
+            uint32_t cr0, cr1, mask, compare;
             uint16_t rx_cmp;
             int offset;
-            int cr_idx = extract32(reg, GEM_ST2R_COMPARE_A_SHIFT + j * 6,
-                                        GEM_ST2R_COMPARE_WIDTH);
+            int cr_idx = extract32(reg, R_SCREENING_TYPE2_REG0_COMPARE_A_SHIFT + j * 6,
+                                   R_SCREENING_TYPE2_REG0_COMPARE_A_LENGTH);
 
-            if (!(reg & (GEM_ST2R_COMPARE_A_ENABLE << (j * 6)))) {
+            if (!extract32(reg, R_SCREENING_TYPE2_REG0_COMPARE_A_ENABLE_SHIFT + j * 6,
+                           R_SCREENING_TYPE2_REG0_COMPARE_A_ENABLE_LENGTH)) {
                 continue;
             }
+
             if (cr_idx > s->num_type2_screeners) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Out of range compare "
                               "register index: %d\n", cr_idx);
             }
 
             cr0 = s->regs[R_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2];
-            cr1 = s->regs[R_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2 + 1];
-            offset = extract32(cr1, GEM_T2CW1_OFFSET_VALUE_SHIFT,
-                                    GEM_T2CW1_OFFSET_VALUE_WIDTH);
+            cr1 = s->regs[R_TYPE2_COMPARE_0_WORD_1 + cr_idx * 2];
+            offset = FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, OFFSET_VALUE);
 
-            switch (extract32(cr1, GEM_T2CW1_COMPARE_OFFSET_SHIFT,
-                                   GEM_T2CW1_COMPARE_OFFSET_WIDTH)) {
+            switch (FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, COMPARE_OFFSET)) {
             case 3: /* Skip UDP header */
                 qemu_log_mask(LOG_UNIMP, "TCP compare offsets"
                               "unimplemented - assuming UDP\n");
@@ -843,9 +844,10 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
             }
 
             rx_cmp = rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
-            mask = extract32(cr0, 0, 16);
+            mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
+            compare = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
 
-            if ((rx_cmp & mask) == (extract32(cr0, 16, 16) & mask)) {
+            if ((rx_cmp & mask) == (compare & mask)) {
                 matched = true;
             } else {
                 mismatched = true;
@@ -853,7 +855,7 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
         }
 
         if (matched && !mismatched) {
-            return extract32(reg, GEM_ST2R_QUEUE_SHIFT, GEM_ST2R_QUEUE_WIDTH);
+            return FIELD_EX32(reg, SCREENING_TYPE2_REG0, QUEUE_NUM);
         }
     }
 
-- 
2.34.1



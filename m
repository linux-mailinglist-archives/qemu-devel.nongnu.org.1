Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D3172ABB4
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:33:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhB-0004Pt-E5; Sat, 10 Jun 2023 09:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yh9-0004P0-Kb; Sat, 10 Jun 2023 09:31:55 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yh7-0007Zq-9k; Sat, 10 Jun 2023 09:31:55 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3942c6584f0so970058b6e.3; 
 Sat, 10 Jun 2023 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403911; x=1688995911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Wv2lJl9XQMjK/lPdzQ4H7KJOOhr+EUzvQOo1A9aJdM=;
 b=nAfUAv474jh520DSlV31qK90QlqezaKv1cA5aZfiUT18BlNvrkDk7R7qEkGOzYJUan
 sk1uIHO6gNYSMBJrVLou9TJhYqjo22MAAP2V16HmJQFKklMOEfImwpGK831yRT67FYKQ
 13629Z4eR50j9SLEI0j6Qfw6lzxRSCZIEqMu4l+OntT8mvmIlpq1aCZL1OzZQnWp/39U
 gH6luqN5s6y1w9zPXdlUV+w74lphWjjYbBllF5XB9uZXtuwkv3MbhrE8sNubx0CnF8oo
 LSSYABk1Fe09C9lrwZiVvpOOm49ANF0PEgai9p+Vdwi6aarzgz0UbgXEtmc18FkACbto
 mtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403911; x=1688995911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Wv2lJl9XQMjK/lPdzQ4H7KJOOhr+EUzvQOo1A9aJdM=;
 b=CGPM5IlWNAoM5vRVo/w1r7gTt/t5qoQ+0OmFrkRNVYLwYgY3rg6Qbn+f0GZHnvd1wU
 zdsLEMNpqy4DOG+ITWweBZTK7FKJXkbK0EmVBrBbMYVwhe3h6jV84ixwyxKYI7fEhK8X
 chKcMA5piJPgVnDjahOXpY+A0OWHU7r/xN4viLadIE0J7yrbyon/C9bpFm2JxJjmA/bJ
 dhtsnEULiw56Rg0dmdxILhhP8KWemXIZBEEUUssOpqpoqRXNS3WnDPM1jt/vTcNLL8xO
 AnJ73/4KsoH9e2u5Lh/W9+HrHlt4aVjrVNCLi1wxIBEVgdNLilxQ4Bo9HsWdBIq6nwNY
 WzTw==
X-Gm-Message-State: AC+VfDzAJ5cyTXU4Lq4NUGxI4KfNnP0gYxR8eneq4a/e+X3g71RpIjDN
 ImU/8kBRDGAxUPVNB0wrpDXT4GIma9I=
X-Google-Smtp-Source: ACHHUZ6L6Ef2NRaVUz+QMykOfIr9Zff76LbP7Z26rYYSGMk9xooQC8mEtuhB7MbenDwlfq4GqMogPw==
X-Received: by 2002:a05:6808:211d:b0:394:24a6:baab with SMTP id
 r29-20020a056808211d00b0039424a6baabmr1087949oiw.8.1686403911287; 
 Sat, 10 Jun 2023 06:31:51 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:31:51 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 04/29] pnv/xive2: Introduce macros to manipulate TIMA addresses
Date: Sat, 10 Jun 2023 10:31:07 -0300
Message-Id: <20230610133132.290703-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22c.google.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

TIMA addresses are somewhat special and are split in several bit
fields with different meanings. This patch describes it and introduce
macros to more easily access the various fields.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20230601121331.487207-5-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/xive.c             | 14 +++++++-------
 include/hw/ppc/xive_regs.h | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a986b96843..ebe399bc09 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -249,7 +249,7 @@ static const uint8_t *xive_tm_views[] = {
 static uint64_t xive_tm_mask(hwaddr offset, unsigned size, bool write)
 {
     uint8_t page_offset = (offset >> TM_SHIFT) & 0x3;
-    uint8_t reg_offset = offset & 0x3F;
+    uint8_t reg_offset = offset & TM_REG_OFFSET;
     uint8_t reg_mask = write ? 0x1 : 0x2;
     uint64_t mask = 0x0;
     int i;
@@ -266,8 +266,8 @@ static uint64_t xive_tm_mask(hwaddr offset, unsigned size, bool write)
 static void xive_tm_raw_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
                               unsigned size)
 {
-    uint8_t ring_offset = offset & 0x30;
-    uint8_t reg_offset = offset & 0x3F;
+    uint8_t ring_offset = offset & TM_RING_OFFSET;
+    uint8_t reg_offset = offset & TM_REG_OFFSET;
     uint64_t mask = xive_tm_mask(offset, size, true);
     int i;
 
@@ -296,8 +296,8 @@ static void xive_tm_raw_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
 
 static uint64_t xive_tm_raw_read(XiveTCTX *tctx, hwaddr offset, unsigned size)
 {
-    uint8_t ring_offset = offset & 0x30;
-    uint8_t reg_offset = offset & 0x3F;
+    uint8_t ring_offset = offset & TM_RING_OFFSET;
+    uint8_t reg_offset = offset & TM_REG_OFFSET;
     uint64_t mask = xive_tm_mask(offset, size, false);
     uint64_t ret;
     int i;
@@ -534,7 +534,7 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     /*
      * First, check for special operations in the 2K region
      */
-    if (offset & 0x800) {
+    if (offset & TM_SPECIAL_OP) {
         xto = xive_tm_find_op(offset, size, true);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA "
@@ -573,7 +573,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     /*
      * First, check for special operations in the 2K region
      */
-    if (offset & 0x800) {
+    if (offset & TM_SPECIAL_OP) {
         xto = xive_tm_find_op(offset, size, false);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access to TIMA"
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index b7fde2354e..4a3c9badd3 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -48,6 +48,22 @@
 
 #define TM_SHIFT                16
 
+/*
+ * TIMA addresses are 12-bits (4k page).
+ * The MSB indicates a special op with side effect, which can be
+ * refined with bit 10 (see below).
+ * The registers, logically grouped in 4 rings (a quad-word each), are
+ * defined on the 6 LSBs (offset below 0x40)
+ * In between, we can add a cache line index from 0...3 (ie, 0, 0x80,
+ * 0x100, 0x180) to select a specific snooper. Those 'snoop port
+ * address' bits should be dropped when processing the operations as
+ * they are all equivalent.
+ */
+#define TM_ADDRESS_MASK         0xC3F
+#define TM_SPECIAL_OP           0x800
+#define TM_RING_OFFSET          0x30
+#define TM_REG_OFFSET           0x3F
+
 /* TM register offsets */
 #define TM_QW0_USER             0x000 /* All rings */
 #define TM_QW1_OS               0x010 /* Ring 0..2 */
-- 
2.40.1



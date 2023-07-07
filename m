Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AFA74B000
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhT-0002k7-MD; Fri, 07 Jul 2023 07:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhQ-0002hU-Uq; Fri, 07 Jul 2023 07:32:32 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhP-0006jZ-BP; Fri, 07 Jul 2023 07:32:32 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b711c3ad1fso1691838a34.0; 
 Fri, 07 Jul 2023 04:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729549; x=1691321549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UKuQq6bCnzWJVGOZZ5Bb92fLfgxDNPFFdwGrFOGWaeg=;
 b=AjKPArX5f2XyQ+A5v7mTq3LsWPio+C7jQMmsBGL7XbSuoAzSTth0VB9pRtP21aCxXD
 9qEyYWJaEkF4IAPph5QKOkBM8dPYami6YoxgKbuvj58ePIPsPtroIHhulV9nQrWCVKCo
 4UnHWGHb8NxmnipZVi9ZhsBkZ3XTmS2yx21/LfekBb7dqILY1W9gSN0Wz46ogWFPyGKv
 V9CtTPiwqZxZPnINupWeNT1MU+M02W+yzw4lavOCnJNQfNmdp1YwO1CiIDK4crm3aEgW
 u5UyPXAI3KAP1U8I850vIZB8tPHI5q67xiftTD9zzBlMRPyfvsINafxWBAb6j25gQqzN
 4jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729549; x=1691321549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UKuQq6bCnzWJVGOZZ5Bb92fLfgxDNPFFdwGrFOGWaeg=;
 b=VxOKsfRboexDZc1DUJzCgcLe1fj6EAfaETgj30I+wy0gb+MMlph7gsUj5gOlpW61qW
 5V1HwyiUSyc2+k6k5hMKA6vcp/ilvI4dvh23w4rhecZReNQbEnxcPgWEx14pVtJjnCKd
 KfdoPT7Q+AcQk7fhhv+tnqxUrOnOye++INnXjPWL6uINtq+WwUr9WHoNBKt++lVenMK3
 WTF8GxlYrk1+qnVIT4Bd6fWLf3c5I0QFxL2lWjTmCRMsi1zaIwJKgIPJfTbsizxUEvnp
 BJSf6A2biXtamZf29KZ1vGGD0ZY4WXkqjsA/7khAvmm/wt5t6/EKci3uJ+8PHjxGs+Bq
 a2QA==
X-Gm-Message-State: ABy/qLY2+54eLYo7lLiuJGv9cnvL2pvmkHJqkkI3M4Q0jSebODH8BdLw
 zeRN/M9zpeU14tQ3u/OdRZEGUtzFU+M=
X-Google-Smtp-Source: APBJJlE8irgbg9iul7A31VjxQXF7nfVJhmdz6Qb4ycbZuB4xz1VLI87jCYlQUs6Ov9s1eFDOLd0hDw==
X-Received: by 2002:a05:6830:e88:b0:6b7:507a:e13 with SMTP id
 dp8-20020a0568300e8800b006b7507a0e13mr4610892otb.19.1688729549674; 
 Fri, 07 Jul 2023 04:32:29 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:29 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [PULL 26/60] ppc/pnv: Return zero for core thread state xscom
Date: Fri,  7 Jul 2023 08:30:34 -0300
Message-ID: <20230707113108.7145-27-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32b.google.com
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

From: Joel Stanley <joel@jms.id.au>

Firmware now warns if booting in LPAR per core mode (PPC bit 62). So
this warning doesn't trigger, report the core thread state is 0.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <20230704054204.168547-6-joel@jms.id.au>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 1eec28c88c..b7223bb445 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -116,6 +116,8 @@ static const MemoryRegionOps pnv_core_power8_xscom_ops = {
 #define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP 0xf010d
 #define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR 0xf010a
 
+#define PNV9_XSCOM_EC_CORE_THREAD_STATE    0x10ab3
+
 static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
                                            unsigned int width)
 {
@@ -134,6 +136,9 @@ static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
     case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
         val = 0x0;
         break;
+    case PNV9_XSCOM_EC_CORE_THREAD_STATE:
+        val = 0;
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
                   addr);
@@ -171,6 +176,8 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
  * POWER10 core controls
  */
 
+#define PNV10_XSCOM_EC_CORE_THREAD_STATE    0x412
+
 static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
                                            unsigned int width)
 {
@@ -178,6 +185,9 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
     uint64_t val = 0;
 
     switch (offset) {
+    case PNV10_XSCOM_EC_CORE_THREAD_STATE:
+        val = 0;
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
                   addr);
-- 
2.41.0



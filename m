Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E94F7493D9
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 04:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHF07-0007RK-0E; Wed, 05 Jul 2023 22:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qHF03-0007Qs-Tx; Wed, 05 Jul 2023 22:45:44 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qHF01-0006Rj-JN; Wed, 05 Jul 2023 22:45:43 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-55b66ca1c80so149150a12.0; 
 Wed, 05 Jul 2023 19:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688611540; x=1691203540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=zamhrUE7QKq/C1YwfHmgJpaWDsCNbyB14Zijx2Rbk5U=;
 b=EwkgihQgcK0kyA1fxrCib925C23ifg5vsYFJuCoIQtYtJoA4PKAJmHXaYzo8/b3gAf
 aU5KspVmCdhD9Gkw4U+nxU73KWkBGiLKCpKWmRGpgunw/Eyq8nX7h9HeSVlRklKE0JXz
 5cZbhEctebiktGnv74SLU8qX/9qcTC8TjtxWEmHmtF21MYKwyMUGoxvX+DDb/5dKMcYO
 ZPbS6jP2hf/QYzAG/q3UWukZp59lxbqVVdjOgHwfsyf96p75LHpHLt3GMvo/opTYPROl
 VaZk9SJ9jyWRNVB6EYJBSDRBDSeLcqN+eI9FyC0kDSftLVGyXuoiLIqSQHs7eeQQanCF
 7QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688611540; x=1691203540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zamhrUE7QKq/C1YwfHmgJpaWDsCNbyB14Zijx2Rbk5U=;
 b=CP8WHW04TRlr/dGIGepyXBOJ1qjP4ux5q2Rs9lP0XVG4Axigiu/YPZ/m0XPZMk3fEk
 04jSPyBv0ZrZSqMf5k6PGfbE+VBcuYYF59Jjb0HJIrbLHbsp5tGrfVXDBpO6NsT9pUo7
 8M/5vXnA7lx2bbH0oKQDxkMH3IA7L9gGA8MnEVqTtKSnNNPt+BBWqa/ykl1i3I7DKwbw
 Urm9nwqad/tiUTRtdMzD3f9Pi3to8p/Mk/LdHDn986G8CxnfIjTmD4ihm6x2g/N+jQOA
 qhfhtiur8pb/PoxAoCx+p7dJ1d2+utB/8ojsiVLggg2GO9mARAm389VbdcjkvCNe4Zer
 wgjA==
X-Gm-Message-State: ABy/qLZ3tgevepxMpnqEy74RW8mAne9eBLohZx5v+OXroT1BAWjX9CLv
 zxybbPseWLn/kEuhxWhiF3E=
X-Google-Smtp-Source: APBJJlEXdvXaG6vibxOhJNRSloKCtR1NtWGnfIT0p0l0PiU7QmQXL48Koh2i5cHtR6Lyf7c5sbFNxg==
X-Received: by 2002:a05:6a20:6a98:b0:126:8b8a:f8c7 with SMTP id
 bi24-20020a056a206a9800b001268b8af8c7mr413282pzb.37.1688611539499; 
 Wed, 05 Jul 2023 19:45:39 -0700 (PDT)
Received: from localhost.localdomain
 (2403-5808-8af8-0-7926-51ea-3ff2-71dd.ip6.aussiebb.net.
 [2403:5808:8af8:0:7926:51ea:3ff2:71dd])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a1709026acc00b001b8b26fa6c1sm169470plt.115.2023.07.05.19.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 19:45:38 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH] ppc/pnv: Log all unimp warnings with similar message
Date: Thu,  6 Jul 2023 12:15:28 +0930
Message-Id: <20230706024528.40065-1-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Add the function name so there's an indication as to where the message
is coming from. Change all prints to use the offset instead of the
address.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
Happy to use the address instead of the offset (or print both), but I
like the idea of being consistent.
---
 hw/ppc/pnv_core.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index ffbc29cbf4f9..3eb95670d6a3 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -85,8 +85,8 @@ static uint64_t pnv_core_power8_xscom_read(void *opaque, hwaddr addr,
         val = 0x24f000000000000ull;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
-                  addr);
+        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
+                      offset);
     }
 
     return val;
@@ -95,8 +95,10 @@ static uint64_t pnv_core_power8_xscom_read(void *opaque, hwaddr addr,
 static void pnv_core_power8_xscom_write(void *opaque, hwaddr addr, uint64_t val,
                                         unsigned int width)
 {
-    qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
-                  addr);
+    uint32_t offset = addr >> 3;
+
+    qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
+                  offset);
 }
 
 static const MemoryRegionOps pnv_core_power8_xscom_ops = {
@@ -140,8 +142,8 @@ static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
         val = 0;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
-                  addr);
+        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
+                      offset);
     }
 
     return val;
@@ -157,8 +159,8 @@ static void pnv_core_power9_xscom_write(void *opaque, hwaddr addr, uint64_t val,
     case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
-                      addr);
+        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
+                      offset);
     }
 }
 
@@ -189,8 +191,8 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
         val = 0;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
-                  addr);
+        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
+                      offset);
     }
 
     return val;
@@ -203,8 +205,8 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
 
     switch (offset) {
     default:
-        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
-                      addr);
+        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
+                      offset);
     }
 }
 
@@ -421,7 +423,7 @@ static uint64_t pnv_quad_power9_xscom_read(void *opaque, hwaddr addr,
         val = 0;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
+        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
     }
 
@@ -438,7 +440,7 @@ static void pnv_quad_power9_xscom_write(void *opaque, hwaddr addr, uint64_t val,
     case P9X_EX_NCU_SPEC_BAR + 0x400: /* Second EX */
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
+        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                   offset);
     }
 }
@@ -465,7 +467,7 @@ static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
 
     switch (offset) {
     default:
-        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
+        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
     }
 
@@ -479,7 +481,7 @@ static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
 
     switch (offset) {
     default:
-        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
+        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
     }
 }
-- 
2.40.1



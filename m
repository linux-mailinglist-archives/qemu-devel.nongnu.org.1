Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60589746916
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 07:43:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGYoG-0003W9-UF; Tue, 04 Jul 2023 01:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGYo8-0003U7-WF; Tue, 04 Jul 2023 01:42:37 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGYo6-0004DR-4k; Tue, 04 Jul 2023 01:42:35 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b8033987baso31215065ad.0; 
 Mon, 03 Jul 2023 22:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688449352; x=1691041352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mb1g58UHfH5R1KjeTnU8nIlKmYBN2xuz7JIA9+P33R0=;
 b=cl4PF2sRSSdUvNIZtJ5IWhh+ziiuX5ZrdP53KIAFjvh/0i32DoH5iGJ8Sutv7L5Vy/
 NgHYBJRHNWE5ThjD/gR9aEUkG/4I2pJe1DZKXmQy7rHu3lz2m4JysT8ecmnf+GY8XRwS
 EdiripQCVRU6ELwPua5eMzwlCcnDdJgSrYbqHVH9QMaZXG71iQJ7E1Gpd+MU+BBTIh9w
 XYpcawoPyc8fExQ+BBurJR2QZP0lFMuyMISOJ+DE5a7czNUeH78PxRmTaY1bL3ukiUzN
 NOa0IGUD6WdSkvql9JAbL0vGdr+/78HDNVW/3eldlI5ChH68QyTshGt7qYXaG8YoU1nr
 YJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688449352; x=1691041352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mb1g58UHfH5R1KjeTnU8nIlKmYBN2xuz7JIA9+P33R0=;
 b=CZj+sd5LtfV6Lzj6UzGxBSqlOweEpSc/iICdyEpqKUxbnAYfqZQKEE0JvILFUUJooY
 S2j16mW+WiAhFEoxekQZ9667FSCyHZ3InvWfReuHDqYJGNdZ0Cm3c8CcmdOCKNqBpPJC
 HJ/QGsrQ+8a3MOK5MnfMlclGxomDJDMIQQ9qYASA4Fe0o0w7qUczwzuTjz3uII2dBl4p
 04y7Rs4bn5ELYsABW0/F1rzWaNhGriiPl3nXlJ3iihEPD9W0Vca+EVp0IMhxhNFor10I
 zQ5+kNqvfXnTIlMvM6xx202A9jojNZOh5tr3YpHdPyb4WWJSh6ieAbo9XddD3br4IMGN
 bksA==
X-Gm-Message-State: ABy/qLb4rRUjDhFBtJqfGFZM5FZcAxnlDZNXgu9lIVR0728Tc8tNbn9A
 ViJ6YAdplsvpjBmBk8CH2z8=
X-Google-Smtp-Source: APBJJlEeEaiGKQGThIb3ewD1abrBFIlclIpSHNOVZhCbjnunAKuV8Fk5xHeNqs8NVAH9fH9e4k6dDQ==
X-Received: by 2002:a17:903:22c6:b0:1b8:a39e:ff4b with SMTP id
 y6-20020a17090322c600b001b8a39eff4bmr2834903plg.32.1688449352140; 
 Mon, 03 Jul 2023 22:42:32 -0700 (PDT)
Received: from localhost.localdomain
 (2403-5808-8af8-0-7926-51ea-3ff2-71dd.ip6.aussiebb.net.
 [2403:5808:8af8:0:7926:51ea:3ff2:71dd])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a17090311c900b001ae59169f05sm16261879plh.182.2023.07.03.22.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 22:42:31 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 5/5] ppc/pnv: Return zero for core thread state xscom
Date: Tue,  4 Jul 2023 15:12:04 +0930
Message-Id: <20230704054204.168547-6-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704054204.168547-1-joel@jms.id.au>
References: <20230704054204.168547-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

Firmware now warns if booting in LPAR per core mode (PPC bit 62). So
this warning doesn't trigger, report the core thread state is 0.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/ppc/pnv_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 1eec28c88c41..b7223bb44597 100644
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
2.40.1



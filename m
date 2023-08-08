Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59398773916
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 10:35:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTIBc-0004Hn-Rq; Tue, 08 Aug 2023 04:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qTIBa-0004Gt-Ed; Tue, 08 Aug 2023 04:35:26 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qTIBY-0004OW-Gm; Tue, 08 Aug 2023 04:35:26 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bc63ef9959so21429825ad.2; 
 Tue, 08 Aug 2023 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691483723; x=1692088523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1Q3AW38/jlyIYsf1v5VwYdbz/llnbPCbq6k0gn8DVI=;
 b=K4Xl43cnrur2Qa1cIDK0WFZhemvllhcK+8T06QdJl9IT0eiQnqgCHbXn9yzz9d0VmR
 1srxKAYzOSQwSgpCuh+ZyJ5MCQ0qE++jdlpKFHvRddxwY98PTO1vkXCJN4CMPzMVAKz7
 OXsIsPsZxshM1VtfVmXOwLBSNoiDfcfRZuFhmRA0y/zCNSyUMjX7tvtl9wdZYQFR5ifH
 KMn+ZiWnIocTCOjsRhLwttRbNqUIXzPExXSahskQlq1whpA9RJiZXQ5ZNoY3q9CrvfC7
 yoYAZYkdmP4azAgsOMdoVW/lAiyhsk8fkeFLVAOGeELwzp62QLvVD3ID6aUaeFbfzk3O
 QQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691483723; x=1692088523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t1Q3AW38/jlyIYsf1v5VwYdbz/llnbPCbq6k0gn8DVI=;
 b=KWfrSQFAiKr7hgYtXjPIt8sEWsrAYSB/B/hdXPTpJK3CIjTAxN5mR5RJG0uKuPmraV
 kyuVnJ1amsldovzSBhMO7ZOLrDLdqWka8U3+HHxbrXVvyDirDQwKeeGjHJTfcW8cocHQ
 Dq2aRRZpIWzuPL9SFc2QUoVXuKkEkmxiqjoR/jqOo9hrNfOqP1eOxdGhRkE4vWynSEc9
 soqukAQplOxgnbaVQepP0I9OunaXsu3d7iV43AbDS8MMmwNsYgugk5kw2cvJTqb9UdYt
 Y3lmIUhbbuaDavH/Ycy1C2F6My2fFSPAa9pz4Fi5rrkVpwGlWxnSN7QLPoIcpWnIQiU4
 Lazg==
X-Gm-Message-State: AOJu0Yzrh35vKVGri6l+W4mxGyQy7FMz59QVIjOe2+KU1UR54WAd2KmR
 Qo3bUjrf/Gv32ABWSkQdGxzyMV33IZY=
X-Google-Smtp-Source: AGHT+IFH52jXWjJPp7HA+AWRI81wGI9pTdC8Z+lJmbmV90axhxCQhH2SWFwpVi0t+Wb0sNMOEVpVUg==
X-Received: by 2002:a17:903:124f:b0:1b6:9fec:8134 with SMTP id
 u15-20020a170903124f00b001b69fec8134mr15096947plh.46.1691483722705; 
 Tue, 08 Aug 2023 01:35:22 -0700 (PDT)
Received: from voyager.lan ([45.124.203.19]) by smtp.gmail.com with ESMTPSA id
 n9-20020a170902e54900b001b8062c1db3sm8368112plf.82.2023.08.08.01.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 01:35:22 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-8.2 2/3] pnv/lpc: Hook up xscom region for P9/P10
Date: Tue,  8 Aug 2023 18:04:44 +0930
Message-Id: <20230808083445.4613-3-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808083445.4613-1-joel@jms.id.au>
References: <20230808083445.4613-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From P9 on the LPC bus is memory mapped. However the xscom access still
is possible, so add it too.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/ppc/pnv_xscom.h | 6 ++++++
 hw/ppc/pnv.c               | 4 ++++
 hw/ppc/pnv_lpc.c           | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 9bc64635471e..42601bdf419d 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -96,6 +96,9 @@ struct PnvXScomInterfaceClass {
 #define PNV9_XSCOM_SBE_CTRL_BASE  0x00050008
 #define PNV9_XSCOM_SBE_CTRL_SIZE  0x1
 
+#define PNV9_XSCOM_LPC_BASE       0x00090040
+#define PNV9_XSCOM_LPC_SIZE       PNV_XSCOM_LPC_SIZE
+
 #define PNV9_XSCOM_SBE_MBOX_BASE  0x000D0050
 #define PNV9_XSCOM_SBE_MBOX_SIZE  0x16
 
@@ -155,6 +158,9 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_SBE_CTRL_BASE  PNV9_XSCOM_SBE_CTRL_BASE
 #define PNV10_XSCOM_SBE_CTRL_SIZE  PNV9_XSCOM_SBE_CTRL_SIZE
 
+#define PNV10_XSCOM_LPC_BASE       PNV9_XSCOM_LPC_BASE
+#define PNV10_XSCOM_LPC_SIZE       PNV9_XSCOM_LPC_SIZE
+
 #define PNV10_XSCOM_SBE_MBOX_BASE  PNV9_XSCOM_SBE_MBOX_BASE
 #define PNV10_XSCOM_SBE_MBOX_SIZE  PNV9_XSCOM_SBE_MBOX_SIZE
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index afdaa25c2b26..a5db655b41b6 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1566,6 +1566,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     }
     memory_region_add_subregion(get_system_memory(), PNV9_LPCM_BASE(chip),
                                 &chip9->lpc.mmio_regs);
+    pnv_xscom_add_subregion(chip, PNV9_XSCOM_LPC_BASE,
+                            &chip9->lpc.xscom_regs);
 
     chip->fw_mr = &chip9->lpc.isa_fw;
     chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
@@ -1785,6 +1787,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     }
     memory_region_add_subregion(get_system_memory(), PNV10_LPCM_BASE(chip),
                                 &chip10->lpc.mmio_regs);
+    pnv_xscom_add_subregion(chip, PNV10_XSCOM_LPC_BASE,
+                            &chip10->lpc.xscom_regs);
 
     chip->fw_mr = &chip10->lpc.isa_fw;
     chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index caf5e10a5f96..6c6a3134087f 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -666,6 +666,12 @@ static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
     /* P9 uses a MMIO region */
     memory_region_init_io(&lpc->mmio_regs, OBJECT(lpc), &pnv_lpc_mmio_ops,
                           lpc, "lpcm", PNV9_LPCM_SIZE);
+
+    /* but the XSCOM region still exists */
+    pnv_xscom_region_init(&lpc->xscom_regs, OBJECT(lpc),
+                          &pnv_lpc_xscom_ops, lpc, "xscom-lpc",
+                          PNV_XSCOM_LPC_SIZE);
+
 }
 
 static void pnv_lpc_power9_class_init(ObjectClass *klass, void *data)
-- 
2.40.1



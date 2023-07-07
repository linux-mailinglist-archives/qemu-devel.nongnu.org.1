Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE0B74B029
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:45:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhR-0002hZ-KO; Fri, 07 Jul 2023 07:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhP-0002gZ-BI; Fri, 07 Jul 2023 07:32:31 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhM-0006in-L1; Fri, 07 Jul 2023 07:32:30 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b74791c948so1606359a34.3; 
 Fri, 07 Jul 2023 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729547; x=1691321547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6ODJ7ibGt/kKlxPnmobX7LyZmwNxrb4XqcToA7Ww9U=;
 b=GzewKOmlHtVPO4GveFdd9UxZmnl2yTw65yGPTkLhl7BAsvOMMcujmcACyQxxGPhBCW
 6e1mB0UQNhVjhOKrwTt3d4fjZopwbVBtvzDVIJsXAMRo32QxrktjBQcQRJOUkDzqo/Ts
 HjlZk9VVTrs2mzrJhTB4y+5Fil2Vii2ktiian5IVZ3Ly4WBj/aD1q6uQw33/hEjYJ2Jo
 nNFDDX1YUgARJ13NyF4WP8XmpM0m2Ej2z5FFXJ8lMYgAfxTlwlyYV4jqVBzegin55jG7
 cELg7jTCUceW2IyA13sJoPzElpxsaH8ijPfXdrPqQRYjFI9GRdW791gCEaUrepoYry5l
 ZfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729547; x=1691321547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6ODJ7ibGt/kKlxPnmobX7LyZmwNxrb4XqcToA7Ww9U=;
 b=j3pRvssve+0UH+ZFBFTBRAReL2KeQSiZYX2P14+LhupOi7AcPpMeU8rTJjQw7IEeRK
 5RR/4NRqXgo+ydrWFvkt5fKS2IQmLAmxiEbDXiv3gqP8YgRowxMzo/XI4DA0SSzXIXdB
 /qwsOW/q2RJskhPW8VsYmBz+Eo6kzVLChZUKcX1Xnizxzi1dR+8ADrKw26ugJ6QkgER4
 LByvrqhM7epw9hHcTarmKb8kAn7MEXIrjJZhjZqp0QJhhqTXbgNlSnMUmx7TVb05I8l7
 sMTq9o5xgTLOQIze7aM3M9y0k1DMf8p0zS1YTFCGO9iyqhgljiizaXVY6hWQkKlf//E5
 gcgg==
X-Gm-Message-State: ABy/qLZmv/TBtTdUet0TkH1WBlY7t/t7j2+9d199zwBvdB/rBie056Eo
 KzbcRFxaqh6KaSra8fH8aZNzyP6UfQw=
X-Google-Smtp-Source: APBJJlG6WJvtaqzrnsrN/LzDbsn7DsiUeMxRS6wFUk6TJ7J23qhS0/qMyQbSrDG8Jq3bkBRLFIjrtg==
X-Received: by 2002:a9d:744b:0:b0:6b8:8269:aa3e with SMTP id
 p11-20020a9d744b000000b006b88269aa3emr5047848otk.14.1688729547139; 
 Fri, 07 Jul 2023 04:32:27 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:26 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [PULL 25/60] ppc/pnv: Add P10 core xscom model
Date: Fri,  7 Jul 2023 08:30:33 -0300
Message-ID: <20230707113108.7145-26-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32a.google.com
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

Like the quad xscoms, add a core model for P10 to allow future
differentiation from P9.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <20230704054204.168547-5-joel@jms.id.au>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv_core.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index e4df435b15..1eec28c88c 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -167,6 +167,47 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+/*
+ * POWER10 core controls
+ */
+
+static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
+                                           unsigned int width)
+{
+    uint32_t offset = addr >> 3;
+    uint64_t val = 0;
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
+                  addr);
+    }
+
+    return val;
+}
+
+static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
+                                         uint64_t val, unsigned int width)
+{
+    uint32_t offset = addr >> 3;
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
+                      addr);
+    }
+}
+
+static const MemoryRegionOps pnv_core_power10_xscom_ops = {
+    .read = pnv_core_power10_xscom_read,
+    .write = pnv_core_power10_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp)
 {
     CPUPPCState *env = &cpu->env;
@@ -315,8 +356,7 @@ static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
 {
     PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
 
-    /* TODO: Use the P9 XSCOMs for now on P10 */
-    pcc->xscom_ops = &pnv_core_power9_xscom_ops;
+    pcc->xscom_ops = &pnv_core_power10_xscom_ops;
 }
 
 static void pnv_core_class_init(ObjectClass *oc, void *data)
-- 
2.41.0



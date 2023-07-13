Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8062E7516EF
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 05:54:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJnO9-0005Q3-Sq; Wed, 12 Jul 2023 23:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnNx-0005OI-0g
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:52:57 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qJnNm-0004bn-Oe
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 23:52:56 -0400
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-553a1f13d9fso297110a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 20:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689220364; x=1691812364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8kOcm3wrlgJsbpKCWY0P1lddUJEV50Q+/536oJKe/Y=;
 b=PkibbCqCDn1RZjiliBCUTy88rHykdUS70antgkc7mCmZs43PeqcqnG8u6HscdVvjKw
 JOsfks3uyBdG9bqJlUR1lXgy/CY8uWj05MYY97ZpsEaDF7HmotQlU52zoNukLxqLA6nN
 s25iYHNB7oib8k2dCFdcLiHIfA36rLMdKEZ3NcYxxbuEFtXJxUqs4qCmntmPnSG3rBUy
 XMpoF1DTYerRrvzZ5/D6oGBIxWNpmXnTQBW5V0L+5qQcwAOkUOiic7JkigoBWPEvKHEE
 JxojXIYhtBAVwRk75vc/Gs7CDdfmPLDXFI8G6kymlyO+08/NkHckStXqdUPNlXXCoO8a
 GzDw==
X-Gm-Message-State: ABy/qLbuP8nb6qKQZCO2DAjygRRm7XdA32kxkC2prPvaxemjw0Dx8qG5
 9gADUAIu++7PC5klUjWnnTZuaNUnU4NcXg==
X-Google-Smtp-Source: APBJJlFPLNJOaRYLv2X4NHjUrT0772AJ782esguenJWQBRVgRWBHd4giaDUtLEc5mVvYC6U/Xwlnhg==
X-Received: by 2002:a17:902:b286:b0:1b6:9fec:8134 with SMTP id
 u6-20020a170902b28600b001b69fec8134mr516784plr.46.1689220364426; 
 Wed, 12 Jul 2023 20:52:44 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:8b82:587c:b800:84d:31b7:313d])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a1709027c0600b001b8a37ffb5asm4756199pll.4.2023.07.12.20.52.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Jul 2023 20:52:44 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 03/11] tpm_ppi: refactor memory space initialization
Date: Wed, 12 Jul 2023 20:51:08 -0700
Message-ID: <20230713035232.48406-4-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713035232.48406-1-j@getutm.app>
References: <20230713035232.48406-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.169; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f169.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Instead of calling `memory_region_add_subregion` directly, we defer to
the caller to do it. This allows us to re-use the code for a SysBus
device.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/tpm/tpm_ppi.h        | 10 +++-------
 hw/tpm/tpm_crb.c        |  4 ++--
 hw/tpm/tpm_crb_common.c |  3 +++
 hw/tpm/tpm_ppi.c        |  5 +----
 hw/tpm/tpm_tis_isa.c    |  5 +++--
 5 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
index bf5d4a300f..30863c6438 100644
--- a/hw/tpm/tpm_ppi.h
+++ b/hw/tpm/tpm_ppi.h
@@ -20,17 +20,13 @@ typedef struct TPMPPI {
 } TPMPPI;
 
 /**
- * tpm_ppi_init:
+ * tpm_ppi_init_memory:
  * @tpmppi: a TPMPPI
- * @m: the address-space / MemoryRegion to use
- * @addr: the address of the PPI region
  * @obj: the owner object
  *
- * Register the TPM PPI memory region at @addr on the given address
- * space for the object @obj.
+ * Creates the TPM PPI memory region.
  **/
-void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
-                  hwaddr addr, Object *obj);
+void tpm_ppi_init_memory(TPMPPI *tpmppi, Object *obj);
 
 /**
  * tpm_ppi_reset:
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 3ef4977fb5..598c3e0161 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -107,8 +107,8 @@ static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
         TPM_CRB_ADDR_BASE + sizeof(s->state.regs), &s->state.cmdmem);
 
     if (s->state.ppi_enabled) {
-        tpm_ppi_init(&s->state.ppi, get_system_memory(),
-                     TPM_PPI_ADDR_BASE, OBJECT(s));
+        memory_region_add_subregion(get_system_memory(),
+            TPM_PPI_ADDR_BASE, &s->state.ppi.ram);
     }
 
     if (xen_enabled()) {
diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
index 228e2d0faf..e56e910670 100644
--- a/hw/tpm/tpm_crb_common.c
+++ b/hw/tpm/tpm_crb_common.c
@@ -216,4 +216,7 @@ void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp)
         "tpm-crb-mmio", sizeof(s->regs));
     memory_region_init_ram(&s->cmdmem, obj,
         "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
+    if (s->ppi_enabled) {
+        tpm_ppi_init_memory(&s->ppi, obj);
+    }
 }
diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index 7f74e26ec6..40cab59afa 100644
--- a/hw/tpm/tpm_ppi.c
+++ b/hw/tpm/tpm_ppi.c
@@ -44,14 +44,11 @@ void tpm_ppi_reset(TPMPPI *tpmppi)
     }
 }
 
-void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
-                  hwaddr addr, Object *obj)
+void tpm_ppi_init_memory(TPMPPI *tpmppi, Object *obj)
 {
     tpmppi->buf = qemu_memalign(qemu_real_host_page_size(),
                                 HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
     memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
                                       TPM_PPI_ADDR_SIZE, tpmppi->buf);
     vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
-
-    memory_region_add_subregion(m, addr, &tpmppi->ram);
 }
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 91e3792248..7cd7415f30 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -134,8 +134,9 @@ static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
                                 TPM_TIS_ADDR_BASE, &s->mmio);
 
     if (s->ppi_enabled) {
-        tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
-                     TPM_PPI_ADDR_BASE, OBJECT(dev));
+        tpm_ppi_init_memory(&s->ppi, OBJECT(dev));
+        memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
+                                    TPM_PPI_ADDR_BASE, &s->ppi.ram);
     }
 }
 
-- 
2.39.2 (Apple Git-143)



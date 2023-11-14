Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBC67EA89B
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 03:12:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2is2-0001Gl-Gm; Mon, 13 Nov 2023 21:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2is0-0001Fy-CC
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:40 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2iry-0007ZV-QU
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:40 -0500
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-5bda105206fso3541585a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 18:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699927777; x=1700532577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnroBZ0wk45t3A1wwABp8NCUEpsFnTDAcOrQjgGFhUQ=;
 b=o10T4ZkUFLF0nF1PE1RnjmV2s+sHjkbSjeDsR9/9/uNJWjEdIY/6F/kAaYd4j+GQ9U
 LxhU0UbC1yRLvpnsD6GlQKw61WbEVrPK19yePNiAhde0KSE5O90XfWY6kp9ET3qVQzMs
 u5ZwVUeoxE4psNCf/O7XUSjTBWej+tajIDlOP/9U1eJ+IGC4GWIYgu4X7sYDKlCnscJh
 h+sSH1mUryT7aGmM9u/lUywwKRDKakG9QdBmH08G2HiCqoz6ecByeOoBZ9m43qHI+yg6
 9qcZJ74G5qGN5iaGw5aIdaIq86G+/XdRCaRlp4DL8BseKYCV/GKrwWyv3zkneFhIEx5O
 1liA==
X-Gm-Message-State: AOJu0YzOw8mFm0J/ObSvbFvWPzTNQK//x+C+5dZXsoO/Wl1RvFhyraVX
 Bs8LH+nI4dqt6mzmRub66gmXgnLhpGrgBg==
X-Google-Smtp-Source: AGHT+IFpRUUcItGcC4QvPuybbErAnVk+qouZvZ2hE4h73sJHfR4G3TOTH3uifD9fIbxVfTQzUZOLlA==
X-Received: by 2002:a05:6a20:daa9:b0:172:83b8:67f8 with SMTP id
 iy41-20020a056a20daa900b0017283b867f8mr6962118pzb.29.1699927777310; 
 Mon, 13 Nov 2023 18:09:37 -0800 (PST)
Received: from localhost.localdomain ([2601:642:4c01:2f7:5d09:c219:9099:a639])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a17090ae58d00b0027d12b1e29dsm6175362pjz.25.2023.11.13.18.09.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 18:09:36 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v5 03/14] tpm_ppi: refactor memory space initialization
Date: Mon, 13 Nov 2023 18:09:13 -0800
Message-ID: <20231114020927.62315-4-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114020927.62315-1-j@getutm.app>
References: <20231114020927.62315-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.176; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f176.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
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
index 01b35808f6..bee0b71fee 100644
--- a/hw/tpm/tpm_crb_common.c
+++ b/hw/tpm/tpm_crb_common.c
@@ -214,4 +214,7 @@ void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp)
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
index 0367401586..d596f38c0f 100644
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
2.41.0



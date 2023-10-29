Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD89D7DAB01
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 07:05:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwyuI-0002C1-Eg; Sun, 29 Oct 2023 02:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuG-0002Bo-LV
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:16 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuF-0001mU-3E
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:16 -0400
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso30708425ad.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 23:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698559453; x=1699164253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnroBZ0wk45t3A1wwABp8NCUEpsFnTDAcOrQjgGFhUQ=;
 b=HQr4Vl+y8vw8JhZ3yO/nDwHNmSnniM5xT1P2sB7VDLSVqeM9SY0allC9dCJXy5+k8W
 b5u3AoI0jfl/z3/b8eqh9U9LrtJh8OkhHThHJ47wIf6GJEVldTdWiHVJV42GYc4WBuED
 oYmijkkSyvwH5VsNM0eqPOzJPCk0MF2diT0sWp2OERA7T53ljvnFeCQN6eLW/QW0HB+e
 RNuFtQaJKBwsoLok5wtg3H5uZnKp5q7ER5uxIxlZL22l/gAEvkjSBzZAaQfrFDGxOWSv
 ho3yglvMunFS1eH0jTY//IY3eWKGTd1RuLgTsR+zSeOmBSfXMqTZ9+7/D52YFf3Ykz/s
 MF/Q==
X-Gm-Message-State: AOJu0YwSZ0Qg1rCKozAkQmyyxE3CI9itvJupftzECC28I3nWVwkgL7VE
 tovULsClswoUUydgXE1WZB0uX75GbJxjyA==
X-Google-Smtp-Source: AGHT+IFqXwVaSF9TU1FoG91Dm9QnfwIjbWEY8u6VQQthoj7e8L2HPruIZndycU3xt7vBhRoIK6kh1A==
X-Received: by 2002:a17:903:40c4:b0:1c9:d0a0:ee73 with SMTP id
 t4-20020a17090340c400b001c9d0a0ee73mr8285816pld.5.1698559453437; 
 Sat, 28 Oct 2023 23:04:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:6ead:344e:2b1:f5a5:58c6])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a17090341cc00b001b8943b37a5sm4019518ple.24.2023.10.28.23.04.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Oct 2023 23:04:11 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v3 03/14] tpm_ppi: refactor memory space initialization
Date: Sat, 28 Oct 2023 23:03:16 -0700
Message-ID: <20231029060404.71196-4-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231029060404.71196-1-j@getutm.app>
References: <20231029060404.71196-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.172; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f172.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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



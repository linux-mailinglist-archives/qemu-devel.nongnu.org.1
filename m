Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2203575329D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:11:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCwB-0006MB-4m; Fri, 14 Jul 2023 03:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKCw9-0006LK-9T
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:09:57 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKCw7-00058n-Hd
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:09:57 -0400
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-6687096c6ddso1093056b3a.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 00:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689318594; x=1691910594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kuAZpHhwe7PuuCVtO9OSfCaCL3WOTLfPuhKNU5WiGs8=;
 b=bdnhOWUCRgUV3ZToEKfvOM8elR2lK3SF+oKO46fKZLImj0ykLrQOgGbunUYeH5T3UM
 5891hXlu1KDNYs3Kbu/fZUEPmBSjEghZVr/Qxnz6GSefaNiIV7o7UAP98y6YB34bPFft
 VMSw8v8b4Ff1Xn9AN8CGPpY5n+KYhyRkModSJo+L32VAS/lwOwx/FUmMaxBAbUl6DjVN
 IJMoJaYDPlEyQcNAR/hIRPXwynCU2bqIxo8BHkK3oz7ebxAJj96Nmxpsne3R9WNKuvGA
 rUzwQZ0ngaqwK8DnRHQGbVyU3Pbss6vO5hrjUMv4H1ggmAmdP7jI9Mj0Z1QQaEpW2Jb2
 5IEA==
X-Gm-Message-State: ABy/qLbmdc8yPufArFPOzssp3w4cMac2vDQ9JDEaw4INQNTE5MXXDwZg
 FA1YW4O/IbFcq+MR/D3CWlGtl780V7ot+w==
X-Google-Smtp-Source: APBJJlES0UP7OPYOKknmnBZkV8YHSSbLxur8tjmIAxa2q80psdFPILzUuByaI9xLd2oHHMuI7iO7kw==
X-Received: by 2002:a05:6a20:914f:b0:119:5af7:7cef with SMTP id
 x15-20020a056a20914f00b001195af77cefmr3022271pzc.56.1689318593869; 
 Fri, 14 Jul 2023 00:09:53 -0700 (PDT)
Received: from localhost.localdomain
 ([2607:fb90:dd17:8dad:e558:8948:1ff6:c8c1])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a170902b20800b001b89466a5f4sm7041513plr.105.2023.07.14.00.09.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Jul 2023 00:09:53 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 03/11] tpm_ppi: refactor memory space initialization
Date: Fri, 14 Jul 2023 00:09:19 -0700
Message-ID: <20230714070931.23476-4-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714070931.23476-1-j@getutm.app>
References: <20230714070931.23476-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.172; envelope-from=osy86dev@gmail.com;
 helo=mail-pf1-f172.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



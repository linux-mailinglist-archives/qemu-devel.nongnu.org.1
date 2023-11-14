Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9577EA891
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 03:10:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2is7-0001LI-Uz; Mon, 13 Nov 2023 21:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2is6-0001JD-9S
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:46 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2is4-0007ae-Mj
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:09:46 -0500
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2809b4d648bso4289364a91.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 18:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699927783; x=1700532583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=thzx3xuZnRgtiRpHIay8GaaQihSYfRbbl9Vnnhg5FOU=;
 b=Gw6yOoEq55lPcsowylXso0RCpprtGJ59TDOf9tsw06vZ4njs1Qcy/sabrFaQAWz/kG
 WzKxpCPl0qIxpw6q3cMZv6zZvxdaNw7nFWDgnRm/NbZmu0he4qLj7ztZ2HNvYXRPAQg/
 1tix4OqvzxPO9CZVh0DAFCnvMP1GOWFJj6Jv73KGchHIgB4YagnhtVnBTtFAs6XVJYcS
 sRoNgg9gxVAx0jcsjloncShga/2JgzL/Kw6N04XKkgKVa68F9aNkEM5LwGkUyPdTBsxv
 PtrsEB8sO7tds1ISY143sYlnWQKka5QOSRdzz5GitQYwcqVAKuPzwcloKI7sNyNsUApu
 Uspw==
X-Gm-Message-State: AOJu0YzIZGpeJZLIQrdoTvVe6Nz2eniMTdLkJPFag9K96FqtOItGJZzh
 bC0D9Uf1AN3Gxn982CZw8NIpk8MZETsMkg==
X-Google-Smtp-Source: AGHT+IHNfi332UN67iCwIQQU2iK6wS2HMJmTdwGw4/4QX5e7cTyYIjALrgAtLpnRgPVqhsgb9bMZzQ==
X-Received: by 2002:a17:90b:3b8b:b0:283:27e0:652c with SMTP id
 pc11-20020a17090b3b8b00b0028327e0652cmr5564057pjb.43.1699927783084; 
 Mon, 13 Nov 2023 18:09:43 -0800 (PST)
Received: from localhost.localdomain ([2601:642:4c01:2f7:5d09:c219:9099:a639])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a17090ae58d00b0027d12b1e29dsm6175362pjz.25.2023.11.13.18.09.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 18:09:42 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v5 06/14] tpm-sysbus: add plug handler for TPM on SysBus
Date: Mon, 13 Nov 2023 18:09:16 -0800
Message-ID: <20231114020927.62315-7-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114020927.62315-1-j@getutm.app>
References: <20231114020927.62315-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.44; envelope-from=osy86dev@gmail.com;
 helo=mail-pj1-f44.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

TPM needs to know its own base address in order to generate its DSDT
device entry.

Signed-off-by: Joelle van Dyne <j@getutm.app>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/sysemu/tpm.h |  4 ++++
 hw/tpm/tpm-sysbus.c  | 47 ++++++++++++++++++++++++++++++++++++++++++++
 hw/tpm/meson.build   |  1 +
 3 files changed, 52 insertions(+)
 create mode 100644 hw/tpm/tpm-sysbus.c

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 1ee568b3b6..ffd300e607 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -12,6 +12,8 @@
 #ifndef QEMU_TPM_H
 #define QEMU_TPM_H
 
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
 #include "qapi/qapi-types-tpm.h"
 #include "qom/object.h"
 
@@ -78,6 +80,8 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
     return TPM_IF_GET_CLASS(ti)->get_version(ti);
 }
 
+void tpm_sysbus_plug(TPMIf *tpmif, Object *pbus, hwaddr pbus_base);
+
 #else /* CONFIG_TPM */
 
 #define tpm_init()  (0)
diff --git a/hw/tpm/tpm-sysbus.c b/hw/tpm/tpm-sysbus.c
new file mode 100644
index 0000000000..732ce34c73
--- /dev/null
+++ b/hw/tpm/tpm-sysbus.c
@@ -0,0 +1,47 @@
+/*
+ * tpm-sysbus.c - Support functions for SysBus TPM devices
+ *
+ * Copyright (c) 2023 QEMU contributors
+ *
+ * Authors:
+ *   Joelle van Dyne <j@getutm.app>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "sysemu/tpm.h"
+#include "hw/platform-bus.h"
+#include "hw/sysbus.h"
+#include "qapi/error.h"
+
+/**
+ * Called from a machine's pre_plug handler to set the device's physical addr.
+ */
+void tpm_sysbus_plug(TPMIf *tpmif, Object *pbus, hwaddr pbus_base)
+{
+    PlatformBusDevice *pbusdev = PLATFORM_BUS_DEVICE(pbus);
+    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpmif);
+    MemoryRegion *sbdev_mr;
+    hwaddr tpm_base;
+    uint64_t tpm_size;
+
+    /* exit early if TPM is not a sysbus device */
+    if (!object_dynamic_cast(OBJECT(tpmif), TYPE_SYS_BUS_DEVICE)) {
+        return;
+    }
+
+    assert(object_dynamic_cast(pbus, TYPE_PLATFORM_BUS_DEVICE));
+
+    tpm_base = platform_bus_get_mmio_addr(pbusdev, sbdev, 0);
+    assert(tpm_base != -1);
+
+    tpm_base += pbus_base;
+
+    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
+    tpm_size = memory_region_size(sbdev_mr);
+
+    object_property_set_uint(OBJECT(sbdev), "x-baseaddr",
+                             tpm_base, &error_abort);
+    object_property_set_uint(OBJECT(sbdev), "x-size",
+                             tpm_size, &error_abort);
+}
diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
index cb8204d5bc..3060ac05e8 100644
--- a/hw/tpm/meson.build
+++ b/hw/tpm/meson.build
@@ -1,6 +1,7 @@
 system_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_tis_common.c'))
 system_ss.add(when: 'CONFIG_TPM_TIS_ISA', if_true: files('tpm_tis_isa.c'))
 system_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm_tis_sysbus.c'))
+system_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm-sysbus.c'))
 system_ss.add(when: 'CONFIG_TPM_TIS_I2C', if_true: files('tpm_tis_i2c.c'))
 system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
 system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb_common.c'))
-- 
2.41.0



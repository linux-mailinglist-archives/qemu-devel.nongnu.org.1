Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE5F7DAB02
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 07:05:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwyuS-0002F4-FS; Sun, 29 Oct 2023 02:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuO-0002Ea-Ll
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:24 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuN-0001oP-4n
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:24 -0400
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-5b92b670f2aso2563794a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 23:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698559462; x=1699164262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6fxEL9owYAYM003zodBDA/EXPeMdJlioZ5/vlN4E1wg=;
 b=qSJph2MglAgUUCNjClKcP/2/O7AtkUFdzkPmoHLufetpRnV8e1yCjqn0gK4NF3jPWd
 S29/6po33aIETWr3+/PhSPWxVnJgqlVxu292TYilazX3S3UrNk8vffqT2TRhaU7wngcQ
 g+y0XKZdSOO53tGM5WGd+jwroLJMNT4PwNQ/GkVfARp66W9loyca3hSG9L/YdtPjTdRb
 lcoDB60ITWdnl1MumHnQ2juK8OZBvwGcYVfIdgsWNJoomBpGiWFcYOHAjTLzj/EYkK/d
 +cB/ltZ1aFpfK1TJLV4cPhMoS8iTKw14Q/1f6Y0wkRi7tsFRoSPR2PEVSF78sk8tPz8+
 f4GQ==
X-Gm-Message-State: AOJu0Yww6r8F1qW7PQHYZF5t5cBM5L9ovI0dxNc/MB8sfoZeu/sWUqxB
 mXaUe425Lgn2IkMaq+JXsRerDgLUJuKRQQ==
X-Google-Smtp-Source: AGHT+IH/u2LVEkq+CnBAiQ0YGn4mu4xvV6OFq8lHtxFk/C9dk9dC7AUmc/jm2mUhvuNAWEmXz8JEww==
X-Received: by 2002:a17:902:e5d1:b0:1cc:42b9:110 with SMTP id
 u17-20020a170902e5d100b001cc42b90110mr1011044plf.12.1698559461811; 
 Sat, 28 Oct 2023 23:04:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:6ead:344e:2b1:f5a5:58c6])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a17090341cc00b001b8943b37a5sm4019518ple.24.2023.10.28.23.04.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Oct 2023 23:04:20 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v3 06/14] tpm-sysbus: add plug handler for TPM on SysBus
Date: Sat, 28 Oct 2023 23:03:19 -0700
Message-ID: <20231029060404.71196-7-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231029060404.71196-1-j@getutm.app>
References: <20231029060404.71196-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.174; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f174.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

TPM needs to know its own base address in order to generate its DSDT
device entry.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/sysemu/tpm.h |  4 ++++
 hw/tpm/tpm-sysbus.c  | 33 +++++++++++++++++++++++++++++++++
 hw/tpm/meson.build   |  1 +
 3 files changed, 38 insertions(+)
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
index 0000000000..ef0592b837
--- /dev/null
+++ b/hw/tpm/tpm-sysbus.c
@@ -0,0 +1,33 @@
+#include "sysemu/tpm.h"
+#include "hw/platform-bus.h"
+#include "hw/sysbus.h"
+#include "qapi/error.h"
+
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC9575790E
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:12:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLhfm-0001EU-7N; Tue, 18 Jul 2023 06:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLhfe-0001E7-Rp
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:11:06 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLhfZ-00017K-8y
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:11:06 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so5482299f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689675059; x=1692267059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wn3orCfYiQNlOzy4aMUvAr7V1MDijNIj9bBoFb5Tw0g=;
 b=jH+owpc2YtTKxsdZrpxlld9/j0cWvCD8PVS+FFQdQ3LDYNzgkyOxqTMP3Y8NwaS48e
 fvOywByhqy7VwUxjvKl6533lGp2xURfFRoI45o4r613Wy67foldvTzts1tL7KJaO/EGW
 Zi8NUiQFPtKd/EPyG1xKxGHs41FDDLqYapzV5IzTcy69gNz4HtGJFdYmEevBpJRwpJeR
 S+U8i5eRMEcZkjnudpbBckbvUx4GV+3HA1ZQ/nTApVMP8HaC6USuI9gAV8lJjQJN6KTz
 1IAcSOuv6veFjPcJ2/xQgDsd4MznyUTUwaNgKl6pr7m+fzfaMw6VUxWPUZFmfKEjiVp7
 HgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689675059; x=1692267059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wn3orCfYiQNlOzy4aMUvAr7V1MDijNIj9bBoFb5Tw0g=;
 b=AAEu2N2CGHIL9k9pwT8lCZZC91FXA+G+u2FSSr3eKJGsAUZXaFtJH2jnBcBvzxzmk5
 YisQtlxHYNjsKYYBzOYbaujW3+6DWmSoD64Q3VlpD8SnQnczE7ON4+nQfLJkwXsn6EE3
 78bT4jEFeEEFPWHatVEJNJEnI6oMRzTBDUnwdICP2iueh47tVHM6Ub4C8XqGBmHGil4V
 Lo+6h4mkUVlEJfOncmD7Vmc7DPgjmu1NFN6pBCpFuEhATrN4+Su3egVbIO2MOKF5g2mm
 s0k+pMtuK1/Zu5/ofTkJCKoG/Mtun0OmxwM36tG20/Qw8t5wQ7k8wkhakyFsMKO05Gtd
 RLPA==
X-Gm-Message-State: ABy/qLbYH36TGgqKKwVTphplJXZHWAugHzBEnF2sZq39qrL0GutsVZHs
 jkb9CRxFMAuWIB0GUg0DS98Bai61PtMglSMoI/w=
X-Google-Smtp-Source: APBJJlFbD+yW8hNBRAKwt42PEnU+DBzn8GtCLLlEJPYE8sgQebIoEhdXvNC7MZ9FXCO1QXJjHlvMXA==
X-Received: by 2002:a05:6000:90e:b0:314:37ac:c896 with SMTP id
 cw14-20020a056000090e00b0031437acc896mr15494938wrb.44.1689675059420; 
 Tue, 18 Jul 2023 03:10:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adffc50000000b0031432c2fb95sm1936122wrs.88.2023.07.18.03.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 03:10:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH for-8.1] xen: Don't pass MemoryListener around by value
Date: Tue, 18 Jul 2023 11:10:57 +0100
Message-Id: <20230718101057.1110979-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Coverity points out (CID 1513106, 1513107) that MemoryListener is a
192 byte struct which we are passing around by value.  Switch to
passing a const pointer into xen_register_ioreq() and then to
xen_do_ioreq_register().  We can also make the file-scope
MemoryListener variables const, since nothing changes them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Disclaimer: I have not tested this beyond any testing you
get from 'make check' and 'make check-avocado', which is likely
not much.
---
 include/hw/xen/xen-hvm-common.h | 2 +-
 hw/arm/xen_arm.c                | 4 ++--
 hw/i386/xen/xen-hvm.c           | 4 ++--
 hw/xen/xen-hvm-common.c         | 8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index f9559e2885b..4e9904f1a65 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -93,7 +93,7 @@ void xen_device_unrealize(DeviceListener *listener, DeviceState *dev);
 
 void xen_hvm_change_state_handler(void *opaque, bool running, RunState rstate);
 void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
-                        MemoryListener xen_memory_listener);
+                        const MemoryListener *xen_memory_listener);
 
 void cpu_ioreq_pio(ioreq_t *req);
 #endif /* HW_XEN_HVM_COMMON_H */
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 044093fec75..1d3e6d481a2 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -37,7 +37,7 @@
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 OBJECT_DECLARE_SIMPLE_TYPE(XenArmState, XEN_ARM)
 
-static MemoryListener xen_memory_listener = {
+static const MemoryListener xen_memory_listener = {
     .region_add = xen_region_add,
     .region_del = xen_region_del,
     .log_start = NULL,
@@ -108,7 +108,7 @@ static void xen_arm_init(MachineState *machine)
 
     xam->state =  g_new0(XenIOState, 1);
 
-    xen_register_ioreq(xam->state, machine->smp.cpus, xen_memory_listener);
+    xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
 
 #ifdef CONFIG_TPM
     if (xam->cfg.tpm_base_addr) {
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 3da5a2b23f7..f42621e6742 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -458,7 +458,7 @@ static void xen_log_global_stop(MemoryListener *listener)
     xen_in_migration = false;
 }
 
-static MemoryListener xen_memory_listener = {
+static const MemoryListener xen_memory_listener = {
     .name = "xen-memory",
     .region_add = xen_region_add,
     .region_del = xen_region_del,
@@ -582,7 +582,7 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 
     state = g_new0(XenIOState, 1);
 
-    xen_register_ioreq(state, max_cpus, xen_memory_listener);
+    xen_register_ioreq(state, max_cpus, &xen_memory_listener);
 
     QLIST_INIT(&xen_physmap);
     xen_read_physmap(state);
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 886c3ee944d..565dc39c8f6 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -765,8 +765,8 @@ void xen_shutdown_fatal_error(const char *fmt, ...)
 }
 
 static void xen_do_ioreq_register(XenIOState *state,
-                                           unsigned int max_cpus,
-                                           MemoryListener xen_memory_listener)
+                                  unsigned int max_cpus,
+                                  const MemoryListener *xen_memory_listener)
 {
     int i, rc;
 
@@ -824,7 +824,7 @@ static void xen_do_ioreq_register(XenIOState *state,
 
     qemu_add_vm_change_state_handler(xen_hvm_change_state_handler, state);
 
-    state->memory_listener = xen_memory_listener;
+    state->memory_listener = *xen_memory_listener;
     memory_listener_register(&state->memory_listener, &address_space_memory);
 
     state->io_listener = xen_io_listener;
@@ -842,7 +842,7 @@ err:
 }
 
 void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
-                        MemoryListener xen_memory_listener)
+                        const MemoryListener *xen_memory_listener)
 {
     int rc;
 
-- 
2.34.1



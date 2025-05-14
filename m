Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6F5AB6C6D
	for <lists+qemu-devel@lfdr.de>; Wed, 14 May 2025 15:16:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBmA-0002Fx-Aw; Wed, 14 May 2025 09:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBiy-0007VH-2G; Wed, 14 May 2025 09:00:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBit-0008BU-Fb; Wed, 14 May 2025 09:00:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1E5D7121AF3;
 Wed, 14 May 2025 15:57:50 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BBDAF20B861;
 Wed, 14 May 2025 15:57:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 21/34] hw/core: Get default_cpu_type calling
 machine_class_default_cpu_type()
Date: Wed, 14 May 2025 15:57:43 +0300
Message-Id: <20250514125758.92030-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit 62b4a227a33 the default cpu type can come from the
valid_cpu_types[] array. Call the machine_class_default_cpu_type()
instead of accessing MachineClass::default_cpu_type field.

Cc: qemu-stable@nongnu.org
Fixes: 62b4a227a33 ("hw/core: Add machine_class_default_cpu_type()")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250422084114.39499-1-philmd@linaro.org>
(cherry picked from commit d5f241834be1b323ea697a469ff0f1335a1823fe)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 130217da8f..ea59acb224 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -72,6 +72,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
 
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
+        const char *default_cpu_type = machine_class_default_cpu_type(mc);
         MachineInfo *info;
 
         info = g_malloc0(sizeof(*info));
@@ -90,8 +91,8 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         info->numa_mem_supported = mc->numa_mem_supported;
         info->deprecated = !!mc->deprecation_reason;
         info->acpi = !!object_class_property_find(OBJECT_CLASS(mc), "acpi");
-        if (mc->default_cpu_type) {
-            info->default_cpu_type = g_strdup(mc->default_cpu_type);
+        if (default_cpu_type) {
+            info->default_cpu_type = g_strdup(default_cpu_type);
         }
         if (mc->default_ram_id) {
             info->default_ram_id = g_strdup(mc->default_ram_id);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b68a9cb9b4..ca9cf56aa4 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7034,7 +7034,7 @@ ObjectClass *ppc_cpu_class_by_name(const char *name)
     if (strcmp(name, "max") == 0) {
         MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
         if (mc) {
-            return object_class_by_name(mc->default_cpu_type);
+            return object_class_by_name(machine_class_default_cpu_type(mc));
         }
     }
 #endif
-- 
2.39.5



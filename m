Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2228256FF
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:48:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmPf-0004i5-MM; Fri, 05 Jan 2024 10:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmOh-0001qc-9s
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:46:12 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmOa-0003o3-VF
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:46:11 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d3352b525so16183265e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469561; x=1705074361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1uFhaGSAXCVtK5H8w3hTtFzEkQOw8kna05bCiblS/M=;
 b=f+PT+rUvYR9fqDBm8gjVu32P9inyKy7hXUYxxSF8Nm5iMU6IIL/QaayarcXkX86jN0
 ddqtdXG29N9ymQdvb/Q4DIkDf7qtkmW5KtkNRv8wBMVR/dqD8yCg8HuVmZiooWz8kYW+
 T4EVbq3y1P8OdhUnDoWCgionN9RQoFVQ/lxWP14p5UwHRKDzgO4AT9HWSOip9AeOXb7g
 MwAZsFozCxcCk0Qf/kqrZ07wOE7Kyy6RyBgfXUaqTyzdQkv8dVOpjegVm8iHvXDVuRNp
 3AL5ocMUl6zbxkiD/5bqwyJXiLtsffKsBzSFPyoPVcYbZeMBYduoLC7oF93QCrbRwaWg
 F1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469561; x=1705074361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1uFhaGSAXCVtK5H8w3hTtFzEkQOw8kna05bCiblS/M=;
 b=iE3TpbrS9g8FgKI32rop5BZrQVEyCMieh3jDo1mZpAJy3aQlNHjplcVV8YGskPPYIX
 zCOGNIeMGACBnQpbEWEMancefvpTbFVataGRuNAzB23ReGqKSpOhjui08A/8RVF37zvQ
 EurPL+fIiKtyq8T5CBAlEAWSO3wx+m8m95PxHQpEi5v/Rb65oVeiOUW7FsLTCPOlPQQu
 S0f0pYO9EMVciArSD1QK9GMhrH9PBXK4pXnwQtbeIVdG+HY/WPSnc3+NFZN6Uw11E03M
 6Dc1xuNkF5lBNq15Ykb6jIViuvWlmd646XrROZBIuYIY/fkNFGAdxh1ddCPih5A+HFGh
 BcdQ==
X-Gm-Message-State: AOJu0YzGs24T5DA+x2nK1RLLVWdmtDaezcNk3OhnJh1o4K9sjxuBvnwd
 9IuTxPheSDXRd2nrQbB6BKGJigwwSC04IC89SIZuhpUX/zk=
X-Google-Smtp-Source: AGHT+IGNIP2qF+lk734+mVjuRLP7zjtWDlqmba3PqBdgJ+gZ58KdYl5CKMtUGzmbo0p3bP/yZnjyKQ==
X-Received: by 2002:a05:600c:3b95:b0:40e:3532:2f6f with SMTP id
 n21-20020a05600c3b9500b0040e35322f6fmr1208080wms.182.1704469560809; 
 Fri, 05 Jan 2024 07:46:00 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 f13-20020a05600c154d00b0040e3635ca65sm1945854wmg.2.2024.01.05.07.45.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:46:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 25/71] machine: Introduce helper is_cpu_type_supported()
Date: Fri,  5 Jan 2024 16:42:18 +0100
Message-ID: <20240105154307.21385-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Gavin Shan <gshan@redhat.com>

The logic, to check if the specified CPU type is supported in
machine_run_board_init(), is independent enough. Factor it out into
helper is_cpu_type_supported(). machine_run_board_init() looks a bit
clean with this. Since we're here, @machine_class is renamed to @mc to
avoid multiple line spanning of code. The comments are tweaked a bit
either.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231204004726.483558-3-gshan@redhat.com>
[PMD: Only call new helper if machine->cpu_type is not NULL]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine.c | 84 ++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1898d1d1d7..0119b11fc8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1399,12 +1399,53 @@ const char *machine_class_default_cpu_type(MachineClass *mc)
     return mc->default_cpu_type;
 }
 
+static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    ObjectClass *oc = object_class_by_name(machine->cpu_type);
+    CPUClass *cc;
+    int i;
+
+    /*
+     * Check if the user specified CPU type is supported when the valid
+     * CPU types have been determined. Note that the user specified CPU
+     * type is provided through '-cpu' option.
+     */
+    if (mc->valid_cpu_types) {
+        for (i = 0; mc->valid_cpu_types[i]; i++) {
+            if (object_class_dynamic_cast(oc, mc->valid_cpu_types[i])) {
+                break;
+            }
+        }
+
+        /* The user specified CPU type isn't valid */
+        if (!mc->valid_cpu_types[i]) {
+            error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
+            error_append_hint(errp, "The valid types are: %s",
+                              mc->valid_cpu_types[0]);
+            for (i = 1; mc->valid_cpu_types[i]; i++) {
+                error_append_hint(errp, ", %s", mc->valid_cpu_types[i]);
+            }
+
+            error_append_hint(errp, "\n");
+            return false;
+        }
+    }
+
+    /* Check if CPU type is deprecated and warn if so */
+    cc = CPU_CLASS(oc);
+    if (cc && cc->deprecation_note) {
+        warn_report("CPU model %s is deprecated -- %s",
+                    machine->cpu_type, cc->deprecation_note);
+    }
+
+    return true;
+}
+
 void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp)
 {
     ERRP_GUARD();
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
-    ObjectClass *oc = object_class_by_name(machine->cpu_type);
-    CPUClass *cc;
 
     /* This checkpoint is required by replay to separate prior clock
        reading from the other reads, because timer polling functions query
@@ -1459,42 +1500,9 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
         machine->ram = machine_consume_memdev(machine, machine->memdev);
     }
 
-    /* If the machine supports the valid_cpu_types check and the user
-     * specified a CPU with -cpu check here that the user CPU is supported.
-     */
-    if (machine_class->valid_cpu_types && machine->cpu_type) {
-        int i;
-
-        for (i = 0; machine_class->valid_cpu_types[i]; i++) {
-            if (object_class_dynamic_cast(oc,
-                                          machine_class->valid_cpu_types[i])) {
-                /* The user specified CPU is in the valid field, we are
-                 * good to go.
-                 */
-                break;
-            }
-        }
-
-        if (!machine_class->valid_cpu_types[i]) {
-            /* The user specified CPU is not valid */
-            error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
-            error_append_hint(errp, "The valid types are: %s",
-                              machine_class->valid_cpu_types[0]);
-            for (i = 1; machine_class->valid_cpu_types[i]; i++) {
-                error_append_hint(errp, ", %s",
-                                  machine_class->valid_cpu_types[i]);
-            }
-
-            error_append_hint(errp, "\n");
-            return;
-        }
-    }
-
-    /* Check if CPU type is deprecated and warn if so */
-    cc = CPU_CLASS(oc);
-    if (cc && cc->deprecation_note) {
-        warn_report("CPU model %s is deprecated -- %s", machine->cpu_type,
-                    cc->deprecation_note);
+    /* Check if the CPU type is supported */
+    if (machine->cpu_type && !is_cpu_type_supported(machine, errp)) {
+        return;
     }
 
     if (machine->cgs) {
-- 
2.41.0



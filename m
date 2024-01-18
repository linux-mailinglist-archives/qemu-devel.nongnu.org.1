Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAEE831B75
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:36:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTUG-0000i7-PO; Thu, 18 Jan 2024 09:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTUE-0000f0-Lu; Thu, 18 Jan 2024 09:35:18 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTU9-0002gS-Rz; Thu, 18 Jan 2024 09:35:18 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d6efe27c1dso11271985ad.0; 
 Thu, 18 Jan 2024 06:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705588511; x=1706193311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyegRE89BCdZ65rmU2oEmpSG5mQnQdAuvHj+XZQ0w4g=;
 b=E5meCBdXYiUYMFWRed2VEogjgqi9g7RL73DAjwBVpKA0sW/wHicFLWdNxCAeZ6XmeB
 FMKlJ8cbIhKW7Jzd4UxBF7KA1gS8Yb2jE0BtYZ8U0Cu2gNH2qzg1vrdb8B28f8BcJi/0
 Hi9kd9jP0sIsFIf1bhysYa8eo0wgMc7kCn0kszJyOg0wXRjSpY/X+Gp53/hyHQPxP6SJ
 Pr8nih1Z3Zd569mwe1XVk6xUZ7zwou0PM7F+1Av2dgrMeDcv/vljvYZXClA4RPetSqHH
 HyMmzSCt5SKTvfBneT5eO7DoM1AOpyVJzArc3X+UDmpNLIwwp8cAnTsC96MjJdalzwE1
 FZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705588511; x=1706193311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tyegRE89BCdZ65rmU2oEmpSG5mQnQdAuvHj+XZQ0w4g=;
 b=qErI6zUioP0l5hudjsenCCc6iwpAZAyoChWpYYVC6aZQBrwjZfXGwfG+FICNjmYKZp
 n8KAU2ABE0YCU/qf0Hog+fmbgDqs2JzhYliJoFe1i2UVQonR7ayKo37WlrISfcf4pGel
 0Mpf1luIsqyOjUkUGIQgnwbJtTdU0S74OfRSh6pnLQHDgKXSVZ5ZWvZOGpOVuhqs9PJQ
 numcedAKRRMKFN+bV7e6QkllS0lwZmEQNjVZCVEvxz9Dt7zTUaDs2/0IdU68cO+5cAlV
 Yq2wqArXcBXttK4D6cAaLLD7vG9i8n5Ga63wt2cgK39qX7qip7M5dY8BkML68yYsuBP7
 r24w==
X-Gm-Message-State: AOJu0YxqTae/AQN2VBF7kzlYxk61+WqqZTaY+NpTaKc9ptP/P5Hbl6HE
 f8Hxp0fjywhp9xZGkk6YQ0CZJfKCbbWXsiSFOyJckrswTIFCb/QNHqYIM83M
X-Google-Smtp-Source: AGHT+IFMLknYq40yQYU4u6PSqoeNnj/P4sbIBrvwAjy1UnlTQx9ycK0sK1lH8qS9oSCRQgufNWWykQ==
X-Received: by 2002:a17:903:2446:b0:1d5:5a4f:a49e with SMTP id
 l6-20020a170903244600b001d55a4fa49emr1186310pls.81.1705588511580; 
 Thu, 18 Jan 2024 06:35:11 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 la11-20020a170902fa0b00b001d4ac461a6fsm1484371plb.86.2024.01.18.06.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:35:11 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/4] nmi: add MCE class for implementing machine check
 injection commands
Date: Fri, 19 Jan 2024 00:34:56 +1000
Message-ID: <20240118143459.166994-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118143459.166994-1-npiggin@gmail.com>
References: <20240118143459.166994-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Like commit 9cb805fd26 ("cpus: Define callback for QEMU "nmi" command")
this implements a machine check injection command framework and defines
a monitor command for ppc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/nmi.h             | 20 ++++++++++++
 include/monitor/hmp-target.h |  1 -
 include/monitor/hmp.h        |  1 +
 hw/core/nmi.c                | 61 ++++++++++++++++++++++++++++++++++++
 monitor/hmp-cmds.c           |  1 +
 target/ppc/ppc-qmp-cmds.c    | 10 ++++++
 hmp-commands.hx              | 20 +++++++++++-
 7 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/include/hw/nmi.h b/include/hw/nmi.h
index fff41bebc6..09f9ca122a 100644
--- a/include/hw/nmi.h
+++ b/include/hw/nmi.h
@@ -42,4 +42,24 @@ struct NMIClass {
 
 void nmi_monitor_handle(int cpu_index, Error **errp);
 
+
+#define TYPE_MCE "mce"
+
+#define MCE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(MCEClass, (klass), TYPE_MCE)
+#define MCE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(MCEClass, (obj), TYPE_MCE)
+#define MCE(obj) \
+     INTERFACE_CHECK(MCEState, (obj), TYPE_MCE)
+
+typedef struct MCEState MCEState;
+
+typedef struct MCEClass {
+    InterfaceClass parent_class;
+
+    void (*mce_monitor_handler)(MCEState *n, const QDict *qdict, Error **errp);
+} MCEClass;
+
+void mce_monitor_handle(const QDict *qdict, Error **errp);
+
 #endif /* NMI_H */
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index d78e979f05..dec6dba8e5 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -46,7 +46,6 @@ CPUState *mon_get_cpu(Monitor *mon);
 
 void hmp_info_mem(Monitor *mon, const QDict *qdict);
 void hmp_info_tlb(Monitor *mon, const QDict *qdict);
-void hmp_mce(Monitor *mon, const QDict *qdict);
 void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_sgx(Monitor *mon, const QDict *qdict);
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 13f9a2dedb..fe14a855a0 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -56,6 +56,7 @@ void hmp_ringbuf_read(Monitor *mon, const QDict *qdict);
 void hmp_cont(Monitor *mon, const QDict *qdict);
 void hmp_system_wakeup(Monitor *mon, const QDict *qdict);
 void hmp_nmi(Monitor *mon, const QDict *qdict);
+void hmp_mce(Monitor *mon, const QDict *qdict);
 void hmp_info_network(Monitor *mon, const QDict *qdict);
 void hmp_set_link(Monitor *mon, const QDict *qdict);
 void hmp_balloon(Monitor *mon, const QDict *qdict);
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index a7bce8a04a..d653f054eb 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -85,3 +85,64 @@ static void nmi_register_types(void)
 }
 
 type_init(nmi_register_types)
+
+struct do_mce_s {
+    const QDict *qdict;
+    Error *err;
+    bool handled;
+};
+
+static void mce_children(Object *o, struct do_mce_s *ns);
+
+static int do_mce(Object *o, void *opaque)
+{
+    struct do_mce_s *ms = opaque;
+    MCEState *m = (MCEState *) object_dynamic_cast(o, TYPE_MCE);
+
+    if (m) {
+        MCEClass *mc = MCE_GET_CLASS(m);
+
+        ms->handled = true;
+        mc->mce_monitor_handler(m, ms->qdict, &ms->err);
+        if (ms->err) {
+            return -1;
+        }
+    }
+    mce_children(o, ms);
+
+    return 0;
+}
+
+static void mce_children(Object *o, struct do_mce_s *ms)
+{
+    object_child_foreach(o, do_mce, ms);
+}
+
+void mce_monitor_handle(const QDict *qdict, Error **errp)
+{
+    struct do_mce_s ms = {
+        .qdict = qdict,
+        .err = NULL,
+        .handled = false
+    };
+
+    mce_children(object_get_root(), &ms);
+    if (ms.handled) {
+        error_propagate(errp, ms.err);
+    } else {
+        error_setg(errp, "machine does not provide MCEs");
+    }
+}
+
+static const TypeInfo mce_info = {
+    .name          = TYPE_MCE,
+    .parent        = TYPE_INTERFACE,
+    .class_size    = sizeof(MCEClass),
+};
+
+static void mce_register_types(void)
+{
+    type_register_static(&mce_info);
+}
+
+type_init(mce_register_types)
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 871898ac46..0e46c107b6 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -28,6 +28,7 @@
 #include "hw/intc/intc.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
+#include "hw/nmi.h"
 
 bool hmp_handle_error(Monitor *mon, Error *err)
 {
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index ee0b99fce7..43fa5980d2 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -31,6 +31,7 @@
 #include "qapi/qapi-commands-machine-target.h"
 #include "cpu-models.h"
 #include "cpu-qom.h"
+#include "hw/nmi.h"
 
 static target_long monitor_get_ccr(Monitor *mon, const struct MonitorDef *md,
                                    int val)
@@ -91,6 +92,15 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     dump_mmu(env1);
 }
 
+void hmp_mce(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+
+    mce_monitor_handle(qdict, &err);
+
+    hmp_handle_error(mon, err);
+}
+
 const MonitorDef monitor_defs[] = {
     { "fpscr", offsetof(CPUPPCState, fpscr) },
     /* Next instruction pointer */
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 765349ed14..384cf5d0c4 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1509,12 +1509,30 @@ ERST
         .cmd        = hmp_mce,
     },
 
-#endif
 SRST
 ``mce`` *cpu* *bank* *status* *mcgstatus* *addr* *misc*
   Inject an MCE on the given CPU (x86 only).
 ERST
 
+#endif
+
+#if defined(TARGET_PPC)
+
+    {
+        .name       = "mce",
+        .args_type  = "cpu_index:i,srr1_mask:l,dsisr:i,dar:l,recovered:i",
+        .params     = "cpu srr1_mask dsisr dar recovered",
+        .help       = "inject a MCE on the given CPU",
+        .cmd        = hmp_mce,
+    },
+
+SRST
+``mce`` *cpu* *srr1_mask* *dsisr* *dar* *recovered*
+  Inject a low-level MCE on the given CPU (PPC only).
+ERST
+
+#endif
+
 #ifdef CONFIG_POSIX
     {
         .name       = "getfd",
-- 
2.42.0



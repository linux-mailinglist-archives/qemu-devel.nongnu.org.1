Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D0B730AA9
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 00:31:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Z06-00044I-2g; Wed, 14 Jun 2023 18:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1q9Z03-00043U-VK
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 18:29:59 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1q9Z01-0001Id-VU
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 18:29:59 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f766777605so1903492e87.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 15:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1686781795; x=1689373795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cL2rCd5bn5Vn/mbBGD7fLP06e34FnUV4Sj246qRcww=;
 b=mjdntGTnRSO4dsXKIwKvBPlhV8sKUKSOaxEZ6IiIVThAiHiux/L/4L0VZIId3rg+VH
 KzI1R2BRq0pLtuVctjuuyMQY6mxXCd0K3rlX4rkz8cf8ytZeO5BbJITttQLN0a5ara+m
 7+Sg3qMEvdH3/znCBcKSz0G4YzUcOJZqsB7lmCUhjPqfk+KVuCAemktikF9ikI/5MO8l
 x9y7chXnKszmZ1V43C/DKQTDUrZ36kkJfYlkBZlGmqc8CQYjgGlx0bhGM0kahy7GHPJS
 2RgZn+f3GOGBJ79Wt+UwRzS6L3iBAgvnMYQoUdI/ermZaw9w8+HeuvINZThqcpmWKYP/
 bYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686781795; x=1689373795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+cL2rCd5bn5Vn/mbBGD7fLP06e34FnUV4Sj246qRcww=;
 b=Gm1hwxbPHGxVkXoEcWxZjzMyaBUmAyap/y+NpUuhRxg/hU5McSomUhmE7l5kFmJVJf
 FNDRyvIby1ghrf8/jJ6Ic+ye7SmkVXyLdntj6ugurTQ4NuHfTpJyoFjcv3RHG8Qm9s86
 5Mwd3HhwamEZkwZ2rasKhoeFDdL92NiraORntvIwfM+h5BBiVmWkQb9xqMJFcVMp94aq
 37rvj9fX0CiEKYe+G5tFTRiIVV/56tv1iqL39qSAAYWaYaYs5kaLhitBhOguqopsjWMr
 fR8a9hUnp9E6nmfe8kUIaRBp8N13/2I6chy4B1THRfFwdodvo3/tVj4+LvyAnUTNEv8/
 C/oA==
X-Gm-Message-State: AC+VfDx5GK8TdnnJeIYbJRDsnNMjGutgoNEf4fXJCsiFL0X0iUvImhz8
 /ayK3FHAkH7YEScux7Y7u/PUcQ==
X-Google-Smtp-Source: ACHHUZ6KbwA4b1TczvGebNWSWb6FXpsggFLIyvqDDw3JTCa/fjaTFILc+9F/Cj2sbOiQTP47OoaEgQ==
X-Received: by 2002:a19:e049:0:b0:4f7:618d:1e74 with SMTP id
 g9-20020a19e049000000b004f7618d1e74mr3442751lfj.12.1686781795133; 
 Wed, 14 Jun 2023 15:29:55 -0700 (PDT)
Received: from localhost.localdomain ([46.98.110.34])
 by smtp.gmail.com with ESMTPSA id
 x8-20020ac24888000000b004f39837204fsm2279483lfc.85.2023.06.14.15.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 15:29:54 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v3 4/6] ebpf: Added declaration/initialization routines.
Date: Thu, 15 Jun 2023 01:10:24 +0300
Message-Id: <20230614221026.56950-5-andrew@daynix.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230614221026.56950-1-andrew@daynix.com>
References: <20230614221026.56950-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::133;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now, the binary objects may be retrieved by id.
It would require for future qmp commands that may require specific
eBPF blob.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 ebpf/ebpf.c      | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
 ebpf/ebpf.h      | 31 +++++++++++++++++++++
 ebpf/ebpf_rss.c  |  6 +++++
 ebpf/meson.build |  2 +-
 4 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h

diff --git a/ebpf/ebpf.c b/ebpf/ebpf.c
new file mode 100644
index 00000000000..ea97c0403ee
--- /dev/null
+++ b/ebpf/ebpf.c
@@ -0,0 +1,70 @@
+/*
+ * QEMU eBPF binary declaration routine.
+ *
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ *  Andrew Melnychenko <andrew@daynix.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/queue.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-ebpf.h"
+#include "ebpf/ebpf.h"
+
+struct ElfBinaryDataEntry {
+    int id;
+    const void *data;
+    size_t datalen;
+
+    QSLIST_ENTRY(ElfBinaryDataEntry) node;
+};
+
+static QSLIST_HEAD(, ElfBinaryDataEntry) ebpf_elf_obj_list =
+                                            QSLIST_HEAD_INITIALIZER();
+
+void ebpf_register_binary_data(int id, const void *data, size_t datalen)
+{
+    struct ElfBinaryDataEntry *dataentry = NULL;
+
+    dataentry = g_new0(struct ElfBinaryDataEntry, 1);
+    dataentry->data = data;
+    dataentry->datalen = datalen;
+    dataentry->id = id;
+
+    QSLIST_INSERT_HEAD(&ebpf_elf_obj_list, dataentry, node);
+}
+
+const void *ebpf_find_binary_by_id(int id, size_t *sz, Error **errp)
+{
+    struct ElfBinaryDataEntry *it = NULL;
+    QSLIST_FOREACH(it, &ebpf_elf_obj_list, node) {
+        if (id == it->id) {
+            *sz = it->datalen;
+            return it->data;
+        }
+    }
+
+    error_setg(errp, "can't find eBPF object with id: %d", id);
+
+    return NULL;
+}
+
+EbpfObject *qmp_request_ebpf(EbpfProgramID id, Error **errp)
+{
+    EbpfObject *ret = NULL;
+    size_t size = 0;
+    const void *data = ebpf_find_binary_by_id(id, &size, errp);
+    if (!data) {
+        return NULL;
+    }
+
+    ret = g_new0(EbpfObject, 1);
+    ret->object = g_base64_encode(data, size);
+
+    return ret;
+}
diff --git a/ebpf/ebpf.h b/ebpf/ebpf.h
new file mode 100644
index 00000000000..b6266b28b8c
--- /dev/null
+++ b/ebpf/ebpf.h
@@ -0,0 +1,31 @@
+/*
+ * QEMU eBPF binary declaration routine.
+ *
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ *  Andrew Melnychenko <andrew@daynix.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef EBPF_H
+#define EBPF_H
+
+struct Error;
+
+void ebpf_register_binary_data(int id, const void *data,
+                               size_t datalen);
+const void *ebpf_find_binary_by_id(int id, size_t *sz,
+                                   struct Error **errp);
+
+#define ebpf_binary_init(id, fn)                                           \
+static void __attribute__((constructor)) ebpf_binary_init_ ## fn(void)     \
+{                                                                          \
+    size_t datalen = 0;                                                    \
+    const void *data = fn(&datalen);                                       \
+    ebpf_register_binary_data(id, data, datalen);                          \
+}
+
+#endif /* EBPF_H */
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 24bc6cc409e..8679dc452df 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -13,6 +13,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-commands-ebpf.h"
 
 #include <bpf/libbpf.h>
 #include <bpf/bpf.h>
@@ -21,6 +23,8 @@
 
 #include "ebpf/ebpf_rss.h"
 #include "ebpf/rss.bpf.skeleton.h"
+#include "ebpf/ebpf.h"
+
 #include "trace.h"
 
 void ebpf_rss_init(struct EBPFRSSContext *ctx)
@@ -261,3 +265,5 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
     ctx->map_toeplitz_key = -1;
     ctx->map_indirections_table = -1;
 }
+
+ebpf_binary_init(EBPF_PROGRAMID_RSS, rss_bpf__elf_bytes)
diff --git a/ebpf/meson.build b/ebpf/meson.build
index 2dd0fd89480..272ec2d5311 100644
--- a/ebpf/meson.build
+++ b/ebpf/meson.build
@@ -1 +1 @@
-softmmu_ss.add(when: libbpf, if_true: files('ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
+softmmu_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
-- 
2.39.1



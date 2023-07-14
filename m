Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3639B752F59
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 04:25:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK8Te-0005Uq-F7; Thu, 13 Jul 2023 22:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qK8Tc-0005Tm-8c
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 22:24:12 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qK8Ta-0000Db-Bf
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 22:24:12 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fcd615d7d6so1661107e87.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 19:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689301449; x=1691893449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMSSXJSjhqgoBUqDsDOpDqtdoUXm9qaM0tEZmL6qq74=;
 b=4CsaV69x1DEfagsZZdaiPIB/vmFvUd3OqdkewygnhplTc6iC9Ixw87rEofghjS1v+y
 +/s1xDOsqhrdJCEu7nBA2TXf9tfVK9UJ8LBl9EP+aC/iKcUyjgIZYYNvCiWkcLw9giiN
 4gW5uHti0oeHdD/yFyxUtPrap4qky0/Y69YV935zq08HqFwUsUhklRwGKgVir6lQOpzy
 RWCAlcb31dsDVvewzbV0O3Qwr/aJORHRnpELG/MVUmBzE5egJyP5mRYdWDEw28hqmU60
 dOiRFi56eOxNE2ybpcEv8dgijq+hX0LFkrPEQjREOvz05+1OVZljMkirv8kG2E6P30ad
 JRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689301449; x=1691893449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMSSXJSjhqgoBUqDsDOpDqtdoUXm9qaM0tEZmL6qq74=;
 b=FCuwLqzt6ZLCROf96WulgKagQR08ygJc+plkEQ/eO9TLGjaWNk/V1OkDp0TE63BggY
 kDlYGNAl99VFYzbLsCfOpsxtJEGTpLQ8tlFjIf1QX0QhHUNDxlN1b7dDs/iRMNzf2s5G
 awvFnBZhBSjaXSrgU0xvrUXXoGi3jlnhINY05O7IFxSDt1DDrSC+gpOULlgY+67Qcp17
 tfUg8EY1dyH0/YClhNjQoqNbprIIX5NQtj8EywHmeXkbpBiVDRI6LsculpfGl8/P70CP
 NaPLVrO5EUUcoZPVdhYKvzEZorYJdMoce/nSxz5WNC/6Ho9S7ws+Z4QPRZktnstkcJPO
 qGLw==
X-Gm-Message-State: ABy/qLaskPOse5BLnUut/a9hYbsZwCuyCYyLL93sKjteCBwpJ4rhgjYZ
 TFkTB26cYvhgENqlr9pBxc+PUA==
X-Google-Smtp-Source: APBJJlEb3xEFLSiPxlHE8rzJ5MNBse7CsfvEVtiZlJvqktY2vlEBnRTw6roDbRcKDXp6IDPmcTWtZw==
X-Received: by 2002:ac2:43c7:0:b0:4f9:6528:fb1e with SMTP id
 u7-20020ac243c7000000b004f96528fb1emr2996547lfl.51.1689301448655; 
 Thu, 13 Jul 2023 19:24:08 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 r24-20020ac24d18000000b004fbe2172f7csm1294765lfi.49.2023.07.13.19.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 19:24:08 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v4 4/6] ebpf: Added declaration/initialization routines.
Date: Fri, 14 Jul 2023 05:23:56 +0300
Message-Id: <20230714022358.2438995-5-andrew@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714022358.2438995-1-andrew@daynix.com>
References: <20230714022358.2438995-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::12d;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x12d.google.com
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
index 0000000000..ea97c0403e
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
index 0000000000..b6266b28b8
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
index 24bc6cc409..8679dc452d 100644
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
index 2f627d6c7d..c9bbaa7c90 100644
--- a/ebpf/meson.build
+++ b/ebpf/meson.build
@@ -1 +1 @@
-system_ss.add(when: libbpf, if_true: files('ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
+common_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
\ No newline at end of file
-- 
2.40.1



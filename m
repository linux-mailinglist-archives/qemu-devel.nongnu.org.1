Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3284178E6CE
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 08:52:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbbXJ-0004SI-Hl; Thu, 31 Aug 2023 02:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qbbXH-0004Rk-Di
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 02:52:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qbbXD-0005Wi-CJ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 02:52:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401d6f6b2e0so10192235e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 23:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693464725; x=1694069525;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAyEm6CdSVBdSqaQxCAsuRWLQ65IZ36lkz/yNmNXfek=;
 b=WdVTEcoOdxtw2Zt+tXw7pQ52fgFWeDT3oDObnNNNR02zJIB1LQBzUTcEvkt8hBl7tq
 R8k2v7+LaDzOYum+dQlOOfwThuboBJQBtuQfHcC07oCC+2Sepe5y4NkFVrzKFty7ikk5
 VeJh1//IA+Ux9wzppiRWbfPSzlW4LitimKEVp0V3ZQWIpQY7aNA7kIvvhtXZ9g5WzyX0
 3wd6QyZh8eowcYwFapz5Euo3AI/t30THQtG1q4nLsVow543reJyqZJmrnxIkP/KLQEPu
 0lqQomNjMMmEOWpTN5BoAyiqadXQu2Cyjr8h5ZnujT4VTexZPVzOSwYKBDgnJHyLD498
 umlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693464725; x=1694069525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uAyEm6CdSVBdSqaQxCAsuRWLQ65IZ36lkz/yNmNXfek=;
 b=imHnhfdFAk/pnBgRKAoFVZ85ETJtPSP0EcCCm46lllXT1zIa8oFDm6KB54nkTGrRzx
 JzWHLyBL0Qw2dCn5mcK4X2C5Oa5tOG44mwqSzbtjuaXEXEuBhD3bXKWRUA8+/YgKCQ23
 odbliusGu4ndJZ3n10liLJULqnFLOy712Lo8JBPEI5LlabCAKrbS69KKWH8Sq/Fbs7FQ
 duRBzy+NAwx9F90zDF5ZiWxx9otJKw5v5G0DUqUablqZAWWbbeo6s4EfyGGypo392RkR
 rone3gpsG49m1wWma4gbjW7FYurHiIXZR08ydb/hvLmDBWBHsA1UOU8ozgxYZ3JvFFtK
 DVCg==
X-Gm-Message-State: AOJu0YwUUVYtpuKsvXNXChTC21RUTgedVZiQ+sOCMnP9K7h6kDM2z78K
 C5KnyXHmPHa0WetmOV47Ol4eXg==
X-Google-Smtp-Source: AGHT+IEX/lD568cGjlScexG6GpKJTzBmXqojBNxX7ln9/Aubqyr/CxBhIYZkbVnUtj1LiJ1vJgmqSw==
X-Received: by 2002:a05:600c:1c89:b0:3ff:786:e811 with SMTP id
 k9-20020a05600c1c8900b003ff0786e811mr1249813wms.3.1693464725668; 
 Wed, 30 Aug 2023 23:52:05 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 hn8-20020a05600ca38800b003fee6e170f9sm969010wmb.45.2023.08.30.23.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 23:52:05 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v7 4/5] qmp: Added new command to retrieve eBPF blob.
Date: Thu, 31 Aug 2023 09:51:39 +0300
Message-Id: <20230831065140.496485-5-andrew@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230831065140.496485-1-andrew@daynix.com>
References: <20230831065140.496485-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::336;
 envelope-from=andrew@daynix.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Added command "request-ebpf". This command returns
eBPF program encoded base64. The program taken from the
skeleton and essentially is an ELF object that can be
loaded in the future with libbpf.

The reason to use the command to provide the eBPF object
instead of a separate artifact was to avoid issues related
to finding the eBPF itself. eBPF object is an ELF binary
that contains the eBPF program and eBPF map description(BTF).
Overall, eBPF object should contain the program and enough
metadata to create/load eBPF with libbpf. As the eBPF
maps/program should correspond to QEMU, the eBPF can't
be used from different QEMU build.

The first solution was a helper that comes with QEMU
and loads appropriate eBPF objects. And the issue is
to find a proper helper if the system has several
different QEMUs installed and/or built from the source,
which helpers may not be compatible.

Another issue is QEMU updating while there is a running
QEMU instance. With an updated helper, it may not be
possible to hotplug virtio-net device to the already
running QEMU. Overall, requesting the eBPF object from
QEMU itself solves possible failures with acceptable effort.

Links:
[PATCH 3/5] qmp: Added the helper stamp check.
https://lore.kernel.org/all/20230219162100.174318-4-andrew@daynix.com/

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 ebpf/ebpf.c           | 70 +++++++++++++++++++++++++++++++++++++++++++
 ebpf/ebpf.h           | 31 +++++++++++++++++++
 ebpf/ebpf_rss.c       |  6 ++++
 ebpf/meson.build      |  2 +-
 qapi/ebpf.json        | 66 ++++++++++++++++++++++++++++++++++++++++
 qapi/meson.build      |  1 +
 qapi/qapi-schema.json |  1 +
 7 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 create mode 100644 qapi/ebpf.json

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
index 2f627d6c7d..c5bf9295a2 100644
--- a/ebpf/meson.build
+++ b/ebpf/meson.build
@@ -1 +1 @@
-system_ss.add(when: libbpf, if_true: files('ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
+common_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
diff --git a/qapi/ebpf.json b/qapi/ebpf.json
new file mode 100644
index 0000000000..ba78407148
--- /dev/null
+++ b/qapi/ebpf.json
@@ -0,0 +1,66 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+##
+# = eBPF Objects
+#
+# eBPF object is an ELF binary that contains the eBPF
+# program and eBPF map description(BTF). Overall, eBPF
+# object should contain the program and enough metadata
+# to create/load eBPF with libbpf. As the eBPF maps/program
+# should correspond to QEMU, the eBPF can't be used from
+# different QEMU build.
+#
+# Currently, there is a possible eBPF for receive-side scaling (RSS).
+#
+##
+
+##
+# @EbpfObject:
+#
+# An eBPF ELF object.
+#
+# @object: the eBPF object encoded in base64
+#
+# Since: 8.2
+##
+{ 'struct': 'EbpfObject',
+  'data': {'object': 'str'},
+  'if': 'CONFIG_EBPF' }
+
+##
+# @EbpfProgramID:
+#
+# The eBPF programs that can be gotten with request-ebpf.
+#
+# @rss: Receive side scaling, technology that allows steering traffic
+#     between queues by calculation hash.  Users may set up
+#     indirection table and hash/packet types configurations.  Used
+#     with virtio-net.
+#
+# Since: 8.2
+##
+{ 'enum': 'EbpfProgramID',
+  'if': 'CONFIG_EBPF',
+  'data': [ { 'name': 'rss' } ] }
+
+##
+# @request-ebpf:
+#
+# Retrieve an eBPF object that can be loaded with libbpf.  Management
+# applications (g.e. libvirt) may load it and pass file descriptors to
+# QEMU, so they can run running QEMU without BPF capabilities.
+#
+# @id: The ID of the program to return.
+#
+# Returns: eBPF object encoded in base64.
+#
+# Since: 8.2
+##
+{ 'command': 'request-ebpf',
+  'data': { 'id': 'EbpfProgramID' },
+  'returns': 'EbpfObject',
+  'if': 'CONFIG_EBPF' }
diff --git a/qapi/meson.build b/qapi/meson.build
index 60a668b343..90047dae1c 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -33,6 +33,7 @@ qapi_all_modules = [
   'crypto',
   'cxl',
   'dump',
+  'ebpf',
   'error',
   'introspect',
   'job',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 6594afba31..2c82a49bae 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -53,6 +53,7 @@
 { 'include': 'char.json' }
 { 'include': 'dump.json' }
 { 'include': 'net.json' }
+{ 'include': 'ebpf.json' }
 { 'include': 'rdma.json' }
 { 'include': 'rocker.json' }
 { 'include': 'tpm.json' }
-- 
2.40.1



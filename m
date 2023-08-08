Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D313D774F52
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 01:32:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTWA7-0002lk-OU; Tue, 08 Aug 2023 19:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qTW9x-0002jp-O5
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:30:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qTW9n-0005QX-R7
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:30:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e5747so2022805e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 16:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691537430; x=1692142230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvn6UpvgCgStw+Oo5ADY88fbekJcejWFkWkrCRzkymA=;
 b=U7xNWWXQM6g3mLnQOUgh3kvxJDqcfFQp/mCoYTTVBnpKXVXWQ0AF3Xcbgi768ZOsHJ
 SJEDLoYp0RZyalRYoWplCfzv4LKGjch5EHGvFvtLdVxxv7kSDObJIU2Fx+TSMvbeXPhr
 4Nq4mqJhfgKGDxj2ccPVzA6TrHdEYf0LvETZOdZRs9vrtyVQibboOiyQ9tqwB2rK2y+w
 cGbrFTRTw+XB1HSixDZR35j128x44hBLC63Z8WHwMUQsGUZxKS6s/qyOqgwsdPvXE2/y
 HRz1FkiRy2onfibsAIorb4/kA5rl5BntHGv5qhx4pH3Syx6xxNv3KufLjULVu82eOUq7
 lbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691537430; x=1692142230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvn6UpvgCgStw+Oo5ADY88fbekJcejWFkWkrCRzkymA=;
 b=BGKcVd+YbpB6WV3j4D1TBGuDwMsZWZgPViWxS8NRIGbDIn4hQ6cBbNDAUfwGRUf00u
 cfPGaoXbaD5aq1ynT3/wUu8n3VERuRsgBeK6G3e8uTgLtgQZaOZwYkNsgD/c+Bbh5cEH
 Ogg/HTBH5MSP5soF3zBHU+ol4LonVQTKE+i+AtU1UcU2jJspoxkBDX8TW/5PpQ0NvgKq
 mOf53a9it/dCKVMLetyuW0JKuQfNbK/abCJMMpnFo7uUYShyKUs4c/i5iGgkr1PCIHxi
 Ek3A6T199dNrAOdJ49bTXBJkZuHA92lEy1B4u74DhWduk0UHZ3G0iRQgh6fCzbX7u0Ln
 H2Lg==
X-Gm-Message-State: AOJu0Yz7iDgM+MwYLRi+rONdpUBaHPMlKCiIf18c8/IKMwLYfpvhS50L
 1+j7YyRbQ/P+kEE98vT2BHXpeg==
X-Google-Smtp-Source: AGHT+IFfkXliGps6E1JmUkel2TRlPliJpShlYVDQGFNspIPMO9cLyJ/z1AEoarHjlUwKl2V2v7FJYg==
X-Received: by 2002:a05:600c:43d5:b0:3fe:1f70:9e54 with SMTP id
 f21-20020a05600c43d500b003fe1f709e54mr9146137wmn.4.1691537430006; 
 Tue, 08 Aug 2023 16:30:30 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a056000118600b00314398e4dd4sm14776795wrx.54.2023.08.08.16.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 16:30:29 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v6 4/5] qmp: Added new command to retrieve eBPF blob.
Date: Wed,  9 Aug 2023 02:30:14 +0300
Message-Id: <20230808233015.2295947-5-andrew@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808233015.2295947-1-andrew@daynix.com>
References: <20230808233015.2295947-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::32f;
 envelope-from=andrew@daynix.com; helo=mail-wm1-x32f.google.com
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
 qapi/ebpf.json        | 56 ++++++++++++++++++++++++++++++++++
 qapi/meson.build      |  1 +
 qapi/qapi-schema.json |  1 +
 7 files changed, 166 insertions(+), 1 deletion(-)
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
index 0000000000..bde8d2c1e8
--- /dev/null
+++ b/qapi/ebpf.json
@@ -0,0 +1,56 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+##
+# = eBPF Objects
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEED76D923
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:03:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRIyn-0003P9-US; Wed, 02 Aug 2023 17:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qRIyl-0003Op-KN
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:01:59 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qRIyj-00068F-Fk
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:01:59 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b9e6cc93d8so3851431fa.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691010116; x=1691614916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWoFVGp93/Gq2GZ+0tBsL28D9FENfKvfEY4nYz5G3Lo=;
 b=mVL3ayY/zkjt1zEs9v2pIvluuMRzc5b3811I3Ufg9NUCTpiJTXRCrzBlNN/dLUWhwt
 eFmnB2rgJpQlKptoP4qO9CDk98svguig6dwiNkScOrMYwgSC0k3J2WH6lwAC0oVV7xcg
 qVqzZYPeAvlPjYp88Vinzt8prlGJI0xZ7v2sJMQX0/p2qt+CrJRTmUJPo8FGCatiXAoP
 19H7EnxMnFvMcTSd8ObGh92WOi/pkmOKNfFKLSpXkh4sP4XcVdeLiC15Z8CWjWhOD02E
 AnMlbfyMsKQ/w6COENXPYNCSJ4m8s8QGXO3vfu6bu88xo71vhFhnsnGVxlEYqxcY5K8y
 xLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691010116; x=1691614916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWoFVGp93/Gq2GZ+0tBsL28D9FENfKvfEY4nYz5G3Lo=;
 b=eC3r49q/UdzdFcfQ8H/QJVFdScQTaMpkk98GH/emQRTb1M0sIHtIRQtZLREg40Pwzw
 QYxvMAEIQib/5+Y8TQm16+I57dtBgU/ciA+GlhfCs+kEk7mBAJkE7U2r5pN1RpUM+l33
 YtOcNn1LkNGFRECUuSMcxgU1M1/R464ngkEE0peMehQO+eq6OkLuPWJlozGVfHmwRV5f
 akThh4gv+gBA+1mSCOjyKR1cWmKEkWFTk/QA/vEplFM72+ajli5I1h4p63ak6iWdtZEq
 UbzBbC3hJ6kKfHCvQ8n/irsH0oRzjuDsqK1yDVTEoVWVp8rMFUnkFgHAizjYwznz9cF5
 rcQA==
X-Gm-Message-State: ABy/qLa8DzFOcY3NKFN83qClptsUc4nSvgwJ1jpXwoqGkasketmrWz2A
 cb40KTcbUde54kzFrW/PGLLd6w==
X-Google-Smtp-Source: APBJJlGj/WRx9tbtOsq4bzWfNiZYwFhauzwfk1jy+IXP65xQTOOGLkiZmzCARleUCd34nTaqQ0dACw==
X-Received: by 2002:a2e:964e:0:b0:2b9:ea6b:64f with SMTP id
 z14-20020a2e964e000000b002b9ea6b064fmr5310426ljh.37.1691010116070; 
 Wed, 02 Aug 2023 14:01:56 -0700 (PDT)
Received: from localhost.localdomain ([194.126.180.172])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05651c00c800b002ba045496d0sm391880ljr.125.2023.08.02.14.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 14:01:55 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, qemu-devel@nongnu.org
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v5 4/5] qmp: Added new command to retrieve eBPF blob.
Date: Wed,  2 Aug 2023 23:41:22 +0300
Message-ID: <20230802204125.33688-5-andrew@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802204125.33688-1-andrew@daynix.com>
References: <20230802204125.33688-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::229;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x229.google.com
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
 qapi/ebpf.json        | 57 +++++++++++++++++++++++++++++++++++
 qapi/meson.build      |  1 +
 qapi/qapi-schema.json |  1 +
 7 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 create mode 100644 qapi/ebpf.json

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
index 2f627d6c7d0..c5bf9295a20 100644
--- a/ebpf/meson.build
+++ b/ebpf/meson.build
@@ -1 +1 @@
-system_ss.add(when: libbpf, if_true: files('ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
+common_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
diff --git a/qapi/ebpf.json b/qapi/ebpf.json
new file mode 100644
index 00000000000..40851f8c177
--- /dev/null
+++ b/qapi/ebpf.json
@@ -0,0 +1,57 @@
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
+{ 'include': 'common.json' }
+
+##
+# @EbpfObject:
+#
+# Structure that holds eBPF ELF object encoded in base64.
+#
+# Since: 8.3
+#
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
+# between queues by calculation hash. Users may set up indirection table
+# and hash/packet types configurations. Used with virtio-net.
+#
+# Since: 8.3
+##
+{ 'enum': 'EbpfProgramID',
+  'if': 'CONFIG_EBPF',
+  'data': [ { 'name': 'rss' } ] }
+
+##
+# @request-ebpf:
+#
+# Returns eBPF object that can be loaded with libbpf.
+# Management applications (g.e. libvirt) may load it and pass file
+# descriptors to QEMU. Which allows running QEMU without BPF capabilities.
+# It's crucial that eBPF program/map is compatible with QEMU, so it's
+# provided through QMP.
+#
+# Returns: RSS eBPF object encoded in base64.
+#
+# Since: 8.3
+#
+##
+{ 'command': 'request-ebpf',
+  'data': { 'id': 'EbpfProgramID' },
+  'returns': 'EbpfObject',
+  'if': 'CONFIG_EBPF' }
diff --git a/qapi/meson.build b/qapi/meson.build
index 60a668b3432..90047dae1c8 100644
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
index 6594afba312..2c82a49baec 100644
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
2.41.0



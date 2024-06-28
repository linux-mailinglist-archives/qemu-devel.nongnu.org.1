Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5A091BCAF
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 12:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN8sV-0002zN-UD; Fri, 28 Jun 2024 06:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1sN8sC-0002v5-Tr
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 06:30:44 -0400
Received: from smtpnm6-11.21cn.com ([182.42.117.141] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1sN8sA-0007r3-1K
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 06:30:32 -0400
HMM_SOURCE_IP: 192.168.138.117:0.1711007340
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.138.117])
 by chinatelecom.cn (HERMES) with SMTP id 0E80FE010B47;
 Fri, 28 Jun 2024 18:22:50 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([36.111.64.85])
 by gateway-ssl-dep-67bdc54df-qz2qs with ESMTP id
 5a3f1502136d484ba9f43cb2e8a5217f for dave@treblig.org; 
 Fri, 28 Jun 2024 18:22:57 CST
X-Transaction-ID: 5a3f1502136d484ba9f43cb2e8a5217f
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Message-ID: <0370576b-0660-4fb0-ac70-5b31ad6e3dbf@chinatelecom.cn>
Date: Fri, 28 Jun 2024 18:22:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, qemu-devel@nongnu.org, dengpc12@chinatelecom.cn,
 zhangl161@chinatelecom.cn
Content-Language: en-US
From: Guoyi Tu <tugy@chinatelecom.cn>
To: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH] misc: introduce strim-memory qapi to support free memory
 trimming
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=182.42.117.141; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the test environment, we conducted IO stress tests on all storage disks
within a virtual machine that had five storage devices mounted.During 
testing,
we found that the qemu process allocated a large amount of memory (~800MB)
to handle these IO operations.

When the test ended, although qemu called free() to release the allocated
memory, the memory was not actually returned to the operating system, as
observed via the top command.

Upon researching the glibc memory management mechanism, we found that when
small chunks of memory are allocated in user space and then released with
free(),  the glibc memory management mechanism does not necessarily return
this memory to the operating system. Instead, it retains the memory until
certain conditions are met for release.

For virtual machines that only have business operations during specific
periods,  they remain idle most of the time. However, the qemu process
still occupies a large amount of memory resources, leading to significant
memory resource waste.

To address this issue, this patch introduces an API to actively reclaim
idle memory within the qemu process. This API effectively calls 
malloc_trim()
to notify glibc to trim free memory. With this api, the management tool
can monitor the virtual machine's state and call this API during idle times
to free up the memory occupied by the virtual machine, thereby allowing more
virtual machines to be provisioned.

Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
Signed-off-by: dengpengcheng <dengpc12@chinatelecom.cn>
---
  hmp-commands.hx       | 13 +++++++++++++
  include/monitor/hmp.h |  1 +
  monitor/hmp-cmds.c    | 14 ++++++++++++++
  monitor/qmp-cmds.c    | 18 ++++++++++++++++++
  qapi/misc.json        | 13 +++++++++++++
  5 files changed, 59 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 06746f0afc..0fde22fc71 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1858,4 +1858,17 @@ SRST
  ``xen-event-list``
    List event channels in the guest
  ERST
+
+    {
+        .name       = "trim-memory",
+        .args_type  = "reserved:l?",
+        .params     = "[reserved]",
+        .help       = "trim momory",
+        .cmd        = hmp_trim_memory,
+    },
+
+SRST
+``trim-memory`` *reserved*
+  try to release free memory and keep reserved bytes of free memory 
untrimmed
+ERST
  #endif
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 954f3c83ad..547cde0056 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -181,5 +181,6 @@ void hmp_boot_set(Monitor *mon, const QDict *qdict);
  void hmp_info_mtree(Monitor *mon, const QDict *qdict);
  void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
  void hmp_dumpdtb(Monitor *mon, const QDict *qdict);
+void hmp_trim_memory(Monitor *mon, const QDict *qdict);

  #endif
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index ea79148ee8..f842e43315 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -460,3 +460,17 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
      monitor_printf(mon, "dtb dumped to %s", filename);
  }
  #endif
+
+void hmp_trim_memory(Monitor *mon, const QDict *qdict)
+{
+    int64_t reserved;
+    bool has_reserved = qdict_haskey(qdict, "reserved");
+    Error *err = NULL;
+
+    if (has_reserved) {
+        reserved = qdict_get_int(qdict, "reserved");
+    }
+
+    qmp_trim_memory(has_reserved, reserved, &err);
+    hmp_handle_error(mon, err);
+}
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index f84a0dc523..878a7a646a 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -31,6 +31,7 @@
  #include "qapi/type-helpers.h"
  #include "hw/mem/memory-device.h"
  #include "hw/intc/intc.h"
+#include <malloc.h>

  NameInfo *qmp_query_name(Error **errp)
  {
@@ -161,6 +162,23 @@ void qmp_add_client(const char *protocol, const 
char *fdname,
      }
  }

+void qmp_trim_memory(bool has_reserved, int64_t reserved, Error **errp)
+{
+#if defined(CONFIG_MALLOC_TRIM)
+    if (!has_reserved) {
+        reserved = 1024 * 1024;
+    }
+    if (reserved < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "reserved", "a >0 reserved");
+        return;
+    }
+    malloc_trim(reserved);
+#else
+    error_setg(errp, "malloc_trim feature not configured");
+#endif
+}
+
  char *qmp_human_monitor_command(const char *command_line, bool 
has_cpu_index,
                                  int64_t cpu_index, Error **errp)
  {
diff --git a/qapi/misc.json b/qapi/misc.json
index ec30e5c570..00e6f2f650 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -605,3 +605,16 @@
  { 'event': 'VFU_CLIENT_HANGUP',
    'data': { 'vfu-id': 'str', 'vfu-qom-path': 'str',
              'dev-id': 'str', 'dev-qom-path': 'str' } }
+
+##
+# @trim-memory:
+#
+# try to release free memory
+#
+# @reserved: specifies the amount of free space to leave untrimmed.
+#            default to 1MB if not specified.
+#
+# Since: 9.0
+##
+{'command': 'trim-memory',
+ 'data': {'*reserved': 'int'} }
-- 
2.17.1

----
Guoyi


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C83C8804354
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 01:25:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAJEg-0006mZ-Ty; Mon, 04 Dec 2023 19:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJEZ-0006lz-Gc
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:24:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAJEP-0007HF-D7
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 19:24:13 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B508OlM009063; Tue, 5 Dec 2023 00:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=xLlWCVQdyKvoGB1k6nc+Rv5KTykEMJd608sRbj4o7CQ=;
 b=dShQTg5u4s+KHNUF/l7FwsZhLLux7S/uPuyXgv2ALj5lr0M7pjNC3qtsiWU47xwN1q5Y
 m05jTHub4hj4D0SargE2f/e74c01KKGXVns5LL2v7vtY+zeQt0onu95rStIGr/Gj5oZm
 B2mr4LhC1FnyiVzLDF1p8vKuMp0RMCTQf3nkomCnUcvtmtlwzAzZ41f4fkd4WdQ3BQX7
 bKEGQf0pL/eJyB0K5c/OKmDiEwrxI7GszQ5l6wsvsT9rHiu1YpcAPA4kU24r9XKBIcS8
 3Kf8thyL6gpTfMc48BnDyA7DxF4+gLhhCtHtBkw0Y8sUgT7b1aAqYgTDaMqAgIZQmq80 iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uss2cg0w0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:24:04 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B4MIq9r018471; Tue, 5 Dec 2023 00:24:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu16kkya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 00:24:03 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B50O2YV020972;
 Tue, 5 Dec 2023 00:24:03 GMT
Received: from localhost.localdomain (dhcp-10-191-8-104.vpn.oracle.com
 [10.191.8.104])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3uqu16kkx1-1; Tue, 05 Dec 2023 00:24:02 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, imammedo@redhat.com
Cc: annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC PATCH 01/11] acpi: hmp/qmp: Add hmp/qmp support for system_sleep
Date: Tue,  5 Dec 2023 00:23:56 +0000
Message-Id: <20231205002356.1239-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.30.1.windows.1
In-Reply-To: <20231205002143.562-1-annie.li@oracle.com>
References: <20231205002143.562-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_23,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050002
X-Proofpoint-GUID: Y2ii5i4XvBv6FPEHrpl1WqVG3jimkxWG
X-Proofpoint-ORIG-GUID: Y2ii5i4XvBv6FPEHrpl1WqVG3jimkxWG
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Following hmp/qmp commands are implemented for pressing virtual
sleep button,

hmp: system_sleep
qmp: { "execute": "system_sleep" }

These commands put the guest into suspend or other power states
depending on the power settings inside the guest.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hmp-commands.hx            | 14 ++++++++++++++
 hw/core/machine-hmp-cmds.c |  5 +++++
 hw/core/machine-qmp-cmds.c |  9 +++++++++
 include/monitor/hmp.h      |  1 +
 qapi/machine.json          | 18 ++++++++++++++++++
 qapi/pragma.json           |  1 +
 6 files changed, 48 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 765349ed14..bd01e49ec5 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -652,6 +652,20 @@ SRST
   whether profiling is on or off.
 ERST
 
+    {
+        .name       = "system_sleep",
+        .args_type  = "",
+        .params     = "",
+        .help       = "send ACPI sleep event",
+        .cmd = hmp_system_sleep,
+    },
+
+SRST
+``system_sleep``
+  Push the virtual sleep button; if supported the system will enter
+  an ACPI sleep state.
+ERST
+
     {
         .name       = "system_reset",
         .args_type  = "",
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index a6ff6a4875..641a365e3e 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -185,6 +185,11 @@ void hmp_system_reset(Monitor *mon, const QDict *qdict)
     qmp_system_reset(NULL);
 }
 
+void hmp_system_sleep(Monitor *mon, const QDict *qdict)
+{
+    qmp_system_sleep(NULL);
+}
+
 void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
 {
     qmp_system_powerdown(NULL);
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3860a50c3b..9f1e636c90 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -257,6 +257,15 @@ void qmp_system_reset(Error **errp)
     qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
 }
 
+void qmp_system_sleep(Error **errp)
+{
+    if (!qemu_wakeup_suspend_enabled()) {
+        error_setg(errp,
+                   "suspend from running is not supported by this guest");
+        return;
+    }
+}
+
 void qmp_system_powerdown(Error **errp)
 {
     qemu_system_powerdown_request();
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 13f9a2dedb..d72a3b775c 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -45,6 +45,7 @@ void hmp_quit(Monitor *mon, const QDict *qdict);
 void hmp_stop(Monitor *mon, const QDict *qdict);
 void hmp_sync_profile(Monitor *mon, const QDict *qdict);
 void hmp_system_reset(Monitor *mon, const QDict *qdict);
+void hmp_system_sleep(Monitor *mon, const QDict *qdict);
 void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
 void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
 void hmp_announce_self(Monitor *mon, const QDict *qdict);
diff --git a/qapi/machine.json b/qapi/machine.json
index b6d634b30d..3ac69df92f 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -297,6 +297,24 @@
 ##
 { 'command': 'system_reset' }
 
+##
+# @system_sleep:
+#
+# Requests that a guest perform a ACPI sleep transition by pushing a virtual
+# sleep button.
+#
+# Notes: A guest may or may not respond to this command. This command
+#        returning does not indicate that a guest has accepted the request
+#        or that it has gone to sleep.
+#
+# Example:
+#
+# -> { "execute": "system_sleep" }
+# <- { "return": {} }
+#
+##
+{ 'command': 'system_sleep' }
+
 ##
 # @system_powerdown:
 #
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 0aa4eeddd3..ef15229854 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -23,6 +23,7 @@
         'set_password',
         'system_powerdown',
         'system_reset',
+        'system_sleep',
         'system_wakeup' ],
     # Commands allowed to return a non-dictionary
     'command-returns-exceptions': [
-- 
2.34.3



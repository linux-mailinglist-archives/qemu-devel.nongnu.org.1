Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 150729A2650
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Oct 2024 17:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SD6-0007AS-BZ; Thu, 17 Oct 2024 11:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SD4-0007AH-OC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SD3-00015l-21
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:42 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBwjk017947;
 Thu, 17 Oct 2024 15:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=Zzn2twQrUlynteH7OoQpeppESF01QeVIW+EvY+2YPK8=; b=
 lX7ESpAoYvVUw3UB4qhlPg4xeQ4Q+kA/OVVidMx2h8zBJtIL17Eo8SXnqBNvRnpk
 QtgIK6zzsd379Gea2NBijWcqONE3WQopJpJ7NC6QpsoFZ7mS3U4rpe0oxys5NEMW
 ujisjM/zXdnL2WlHnHquFzvrKIu+rPxyrK2bNkVtQVnpXxTOPnpDRl2KOAc/LBVK
 uaY73iHW2MOb2Ey+gPEVat/WCVYX5hX2ZbkTotfRzAdVpRev2ELlcUYhR/yLKbF4
 kLsdMp+X94+oMhG9s0PreEtzrQkESYJgfw20mV381xk06DPG9QbRkFxJHu30LiXU
 pYugBUDity+GFR1AeLqLmQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntepyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HElkJL027278; Thu, 17 Oct 2024 15:14:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy668-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:22 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgX017147;
 Thu, 17 Oct 2024 15:14:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-4; Thu, 17 Oct 2024 15:14:21 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 03/14] accel: split configure_accelerators
Date: Thu, 17 Oct 2024 08:14:04 -0700
Message-Id: <1729178055-207271-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170105
X-Proofpoint-ORIG-GUID: 3ihe3eCcVZdPjkS-UjYCgM3KeDQ7bArn
X-Proofpoint-GUID: 3ihe3eCcVZdPjkS-UjYCgM3KeDQ7bArn
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Split configure_accelerators into a first function (still named
configure_accelerators) that loops and chooses the first accelerator
for which preinit succeeds, and a second function create_accelerator
which calls machine_init on the chosen accelerator.

configure_accelerators can be called without knowing any machine
properties.  create_accelerator cannot be called until the machine
properties are defined.  For now call them at the same place, so
no functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 accel/accel-system.c |  6 ------
 system/vl.c          | 27 +++++++++++++++++++++------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index fef6625..f6c947d 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -36,14 +36,8 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
     int ret;
     ms->accelerator = accel;
     *(acc->allowed) = true;
-    ret = acc->preinit(accel);
-    if (ret < 0) {
-        goto fail;
-    }
-
     ret = acc->init_machine(ms);
     if (ret < 0) {
-fail:
         ms->accelerator = NULL;
         *(acc->allowed) = false;
         object_unref(OBJECT(accel));
diff --git a/system/vl.c b/system/vl.c
index 8b345dd..b94a6b9 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -182,6 +182,7 @@ static const char *log_file;
 static bool list_data_dirs;
 static const char *qtest_chrdev;
 static const char *qtest_log;
+static AccelState *accel;
 
 static int has_defaults = 1;
 static int default_audio = 1;
@@ -2337,7 +2338,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
                      accel,
                      &error_fatal);
 
-    ret = accel_init_machine(accel, current_machine);
+    ret = ac->preinit ? ac->preinit(accel) : 0;
     if (ret < 0) {
         if (!qtest_with_kvm || ret != -ENOENT) {
             error_report("failed to initialize %s: %s", acc, strerror(-ret));
@@ -2353,13 +2354,10 @@ bad:
     return 0;
 }
 
-static void configure_accelerators(const char *progname)
+static AccelState *configure_accelerators(const char *progname)
 {
     AccelSearch acs = {0};
 
-    qemu_opts_foreach(qemu_find_opts("icount"),
-                      do_configure_icount, NULL, &error_fatal);
-
     if (QTAILQ_EMPTY(&qemu_accel_opts.head)) {
         char **accel_list, **tmp;
 
@@ -2418,6 +2416,22 @@ static void configure_accelerators(const char *progname)
     if (acs.init_failed && !qtest_chrdev) {
         error_report("falling back to %s", ACCEL_GET_CLASS(acs.accel)->name);
     }
+    return acs.accel;
+}
+
+static void create_accelerator(AccelState *accel)
+{
+    int ret;
+
+    qemu_opts_foreach(qemu_find_opts("icount"),
+                      do_configure_icount, NULL, &error_fatal);
+
+    ret = accel_init_machine(accel, current_machine);
+    if (ret < 0) {
+        error_report("failed to initialize %s: %s",
+                      ACCEL_GET_CLASS(accel)->name, strerror(-ret));
+        exit(1);
+    }
 
     if (icount_enabled() && !tcg_enabled()) {
         error_report("-icount is not allowed with hardware virtualization");
@@ -3731,7 +3745,8 @@ void qemu_init(int argc, char **argv)
      * Note: uses machine properties such as kernel-irqchip, must run
      * after qemu_apply_machine_options.
      */
-    configure_accelerators(argv[0]);
+    accel = configure_accelerators(argv[0]);
+    create_accelerator(accel);
     phase_advance(PHASE_ACCEL_CREATED);
 
     /*
-- 
1.8.3.1



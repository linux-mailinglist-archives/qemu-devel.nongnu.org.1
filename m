Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B24180762C
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 18:13:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAvSO-0006v6-FH; Wed, 06 Dec 2023 12:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvSL-0006uO-Nm
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:13:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvSK-0001Op-2G
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:13:05 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B6EYBtH023015; Wed, 6 Dec 2023 17:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=GnVeRbOAl6rLN2jYjXl8d0jSztnXvyn1ynEEBiEsVjk=;
 b=S0QaJsEk4h5W3Qf4yYQJ3xDul+3gS62zkHQuoSJ7vaP21XsrkXPf+s1/ykyqBn2KHpU8
 U4t2dYsGExcywcPy5vVr7s38ZTNef1pBUsPWSZyVweTzz2FnvBsCVhQzYqzIlCKTJOZu
 vMDFdNk+D6UtXs+AYVYScVFlFNOrxqfzFyrkKeTGY6j2ePTYWorkvj5I3uqFxPc4CqJq
 Ntf76oK5i0oEdrHz3PtzDvc98QESLfBo22De7iDGDu+dV8zkgGvKExrVH4LF86+aOsc4
 NmQsHc1iOAbVe6l8HXZaos5f0L7CLmB3q5HhifR38F9fLpNkE1qDljywXjBLMpwviKLp cQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0mhyqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:13:02 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B6GvgNh032299; Wed, 6 Dec 2023 17:13:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan9ex5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:13:01 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B6HCrV1024168;
 Wed, 6 Dec 2023 17:13:00 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3utan9ewxa-6; Wed, 06 Dec 2023 17:13:00 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 03/12] cpus: check running not RUN_STATE_RUNNING
Date: Wed,  6 Dec 2023 09:12:31 -0800
Message-Id: <1701882772-356078-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701882772-356078-1-git-send-email-steven.sistare@oracle.com>
References: <1701882772-356078-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_15,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060140
X-Proofpoint-GUID: 62LFhn78p3-5pwXeIHG2KT0yavy4ocbJ
X-Proofpoint-ORIG-GUID: 62LFhn78p3-5pwXeIHG2KT0yavy4ocbJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

When a vm transitions from running to suspended, runstate notifiers are
not called, so the notifiers still think the vm is running.  Hence, when
we call vm_start to restore the suspended state, we call vm_state_notify
with running=1.  However, some notifiers check for RUN_STATE_RUNNING.
They must check the running boolean instead.

No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 backends/tpm/tpm_emulator.c | 2 +-
 hw/usb/hcd-ehci.c           | 2 +-
 hw/usb/redirect.c           | 2 +-
 hw/xen/xen-hvm-common.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index f7f1b4a..254fce7 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -904,7 +904,7 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
 
     trace_tpm_emulator_vm_state_change(running, state);
 
-    if (!running || state != RUN_STATE_RUNNING || !tpm_emu->relock_storage) {
+    if (!running || !tpm_emu->relock_storage) {
         return;
     }
 
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 19b4534..10c82ce 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2451,7 +2451,7 @@ static void usb_ehci_vm_state_change(void *opaque, bool running, RunState state)
      * USB-devices which have async handled packages have a packet in the
      * ep queue to match the completion with.
      */
-    if (state == RUN_STATE_RUNNING) {
+    if (running) {
         ehci_advance_async_state(ehci);
     }
 
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index c9893df..3785bb0 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1403,7 +1403,7 @@ static void usbredir_vm_state_change(void *priv, bool running, RunState state)
 {
     USBRedirDevice *dev = priv;
 
-    if (state == RUN_STATE_RUNNING && dev->parser != NULL) {
+    if (running && dev->parser != NULL) {
         usbredirparser_do_write(dev->parser); /* Flush any pending writes */
     }
 }
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 565dc39..47e6cb1 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -623,7 +623,7 @@ void xen_hvm_change_state_handler(void *opaque, bool running,
 
     xen_set_ioreq_server_state(xen_domid,
                                state->ioservid,
-                               (rstate == RUN_STATE_RUNNING));
+                               running);
 }
 
 void xen_exit_notifier(Notifier *n, void *data)
-- 
1.8.3.1



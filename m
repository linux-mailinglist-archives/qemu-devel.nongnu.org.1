Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3690D78D05B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mw-0000jO-8A; Tue, 29 Aug 2023 19:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3I8-0002aa-8x
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3I5-0003XS-G0
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:16 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37THii1f023429; Tue, 29 Aug 2023 18:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=5zEChsrDoYLFxW2jtgLbAXkBvJiujNDhlgKylYUaDbs=;
 b=WTxyjawOkUHUT73UMiUL+HlJx/OHQOcswmBDofo8zfUUT2oIotvXA2Gt68Qvwx2n7RHX
 omtUZvQ9zTCuZikCOPh/2whPeIg19HgJPNYc4IqD3BH+62jmKg/Gvkhxr1W5a08Q3ShQ
 ghBhkldkKEfX+R69dWI10er4f3KDHOUlhYQAri4GjRMfeAN3Hpu8/do5Lgu85LmHXoEC
 MJxyrn0e0Ft+eah/g5SWLPva1Fsio8sjD9oJnxfv3FxKwsE2l1zN+ZGDOwXBkIntjed2
 IWe0g/Ig8BKupme/CwWponoc/9rKUlRc//vBENM6UbcWXm5LCSqztIsx8/cHOrnEvlEx gA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gdwmqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:11 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37THBApm024778; Tue, 29 Aug 2023 18:18:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6dnfwm1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:10 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TII6m2011911;
 Tue, 29 Aug 2023 18:18:10 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3sr6dnfwgx-7; Tue, 29 Aug 2023 18:18:10 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 06/11] migration: preserve cpu ticks if suspended
Date: Tue, 29 Aug 2023 11:18:01 -0700
Message-Id: <1693333086-392798-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290158
X-Proofpoint-ORIG-GUID: knGy5YIXjvuqUVnJwdn-AB89aMPQW3Kn
X-Proofpoint-GUID: knGy5YIXjvuqUVnJwdn-AB89aMPQW3Kn
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

During RUN_STATE_SUSPENDED, the cpu clock remains enabled, so the
timers_state saved to the migration stream is stale, causing time errors
in the guest when it wakes from suspend.

To fix, maintain a shadow copy of timers_state, and update the shadow in a
pre_save handler that uses the same logic found in cpu_disable_ticks.  Copy
the shadow to timers_state in post_load.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 softmmu/cpu-timers.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/softmmu/cpu-timers.c b/softmmu/cpu-timers.c
index 117408c..d5af317 100644
--- a/softmmu/cpu-timers.c
+++ b/softmmu/cpu-timers.c
@@ -157,6 +157,36 @@ static bool icount_shift_state_needed(void *opaque)
     return icount_enabled() == 2;
 }
 
+static int cpu_pre_save_ticks(void *opaque)
+{
+    TimersState *t = &timers_state;
+    TimersState *snap = opaque;
+
+    seqlock_write_lock(&t->vm_clock_seqlock, &t->vm_clock_lock);
+
+    if (t->cpu_ticks_enabled) {
+        snap->cpu_ticks_offset = t->cpu_ticks_offset + cpu_get_host_ticks();
+        snap->cpu_clock_offset = cpu_get_clock_locked();
+    } else {
+        snap->cpu_ticks_offset = t->cpu_ticks_offset;
+        snap->cpu_clock_offset = t->cpu_clock_offset;
+    }
+    seqlock_write_unlock(&t->vm_clock_seqlock, &t->vm_clock_lock);
+    return 0;
+}
+
+static int cpu_post_load_ticks(void *opaque, int version_id)
+{
+    TimersState *t = &timers_state;
+    TimersState *snap = opaque;
+
+    seqlock_write_lock(&t->vm_clock_seqlock, &t->vm_clock_lock);
+    t->cpu_ticks_offset = snap->cpu_ticks_offset;
+    t->cpu_clock_offset = snap->cpu_clock_offset;
+    seqlock_write_unlock(&t->vm_clock_seqlock, &t->vm_clock_lock);
+    return 0;
+}
+
 /*
  * Subsection for warp timer migration is optional, because may not be created
  */
@@ -221,6 +251,8 @@ static const VMStateDescription vmstate_timers = {
     .name = "timer",
     .version_id = 2,
     .minimum_version_id = 1,
+    .pre_save = cpu_pre_save_ticks,
+    .post_load = cpu_post_load_ticks,
     .fields = (VMStateField[]) {
         VMSTATE_INT64(cpu_ticks_offset, TimersState),
         VMSTATE_UNUSED(8),
@@ -269,9 +301,11 @@ TimersState timers_state;
 /* initialize timers state and the cpu throttle for convenience */
 void cpu_timers_init(void)
 {
+    static TimersState timers_snapshot;
+
     seqlock_init(&timers_state.vm_clock_seqlock);
     qemu_spin_init(&timers_state.vm_clock_lock);
-    vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
+    vmstate_register(NULL, 0, &vmstate_timers, &timers_snapshot);
 
     cpu_throttle_init();
 }
-- 
1.8.3.1



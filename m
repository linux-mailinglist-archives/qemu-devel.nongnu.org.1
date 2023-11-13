Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 539097EA4BB
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 21:25:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2dTO-0001So-2g; Mon, 13 Nov 2023 15:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2dTL-0001Sd-Vc
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 15:23:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2dTJ-0005O9-Fz
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 15:23:51 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHi8oS014699; Mon, 13 Nov 2023 20:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=RmI6P4Zl/l8QttyhJt9OPysTiUr2d8Tn4wxDq+zqmHE=;
 b=eeaHfItjXq+rATnS904lhg/vfj7fVl2g37/Ovek8kzIyPYzLcx9wfb1SQ0QqBM9RAOZJ
 NXg4Pzg8hVMrFs1whwUR3S/mqipY1depD9WS4eImNv37+m5p997280bA/m/gLeHN/zRI
 plGrQjWIG5h4TXOPPVeDNzXg9wLvfoDBo+BrAc9Nn5obzoAdv2nuCAiEcT03ZJPx9w5b
 5wQc+6MIzXUs8T6S8Iv6oEKHCwC/98c4joMubCAKM9dv6QF/BBCdyg1s/CpPk8hBwyVk
 OeQAFRXVOsH6NIA6DeTcjnAr+Zf/fMRQPJPz7M5408Rxw8XM1sMSZRzC1QYNChwDAcLJ 1A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qjkqhc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 20:23:47 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADIwTVj014989; Mon, 13 Nov 2023 20:23:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxpuxwj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 20:23:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ADKNjsB034163;
 Mon, 13 Nov 2023 20:23:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3uaxpuxwhd-1; Mon, 13 Nov 2023 20:23:45 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Claudio Fontana <cfontana@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] migration: fix coverity migrate_mode finding
Date: Mon, 13 Nov 2023 12:23:45 -0800
Message-Id: <1699907025-215450-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_11,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130161
X-Proofpoint-GUID: sXQx9Pqnkdy86e6t-qfrfABHTGnlS_gq
X-Proofpoint-ORIG-GUID: sXQx9Pqnkdy86e6t-qfrfABHTGnlS_gq
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Coverity diagnoses a possible out-of-range array index here ...

    static GSList *migration_blockers[MIG_MODE__MAX];

    fill_source_migration_info() {
        GSList *cur_blocker = migration_blockers[migrate_mode()];

... because it does not know that MIG_MODE__MAX will never be returned as
a migration mode.  To fix, assert so in migrate_mode().

Fixes: fa3673e497a1 ("migration: per-mode blockers")

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/options.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/options.c b/migration/options.c
index 8d8ec73..3e3e0b9 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -833,8 +833,10 @@ uint64_t migrate_max_postcopy_bandwidth(void)
 MigMode migrate_mode(void)
 {
     MigrationState *s = migrate_get_current();
+    MigMode mode = s->parameters.mode;
 
-    return s->parameters.mode;
+    assert(mode >= 0 && mode < MIG_MODE__MAX);
+    return mode;
 }
 
 int migrate_multifd_channels(void)
-- 
1.8.3.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59290A36010
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Feb 2025 15:17:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwSo-0004M1-Ot; Fri, 14 Feb 2025 09:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSl-0004K5-E4
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSj-0004Qw-Jz
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:39 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECu2MM018730;
 Fri, 14 Feb 2025 14:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=1oM7G1hEz2luvuleMT7bb9H1E+mKvfumKezqrbdtfqc=; b=
 kLgXisjQT5DsvAie+WtY2EMJCyytCb3swAbunCuRQ5IX3uz/yie/036q/mkoXnpa
 ejiV/FVDjhKaxkYzuSN0kdy6EGaIm+5PQk+JcRgq0b08l6u9XULKQ5wp9Cke3EJh
 TcPUXsObSN5eT33hTpojBcp+HGbXDeXPnvtLVY8PFs/ooCEaUCU+Kb7iu1sFbH4P
 jt7PSYRzUTkfr77LzFt3kScCJK8rdm3BjOLMw7qcs6QdNgPquS684nbSUI4zt+/c
 uLzn5hddACbVOueGmVLJ5kV20XxmB+G8q1DFW4qtVDRlvTvHl70GvfmE8V1cbgAp
 NpItPetFsE1I8Z/dJvyMlQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tgbtvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:35 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EDSoBA025143; Fri, 14 Feb 2025 14:14:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksg4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:33 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETPJ006920;
 Fri, 14 Feb 2025 14:14:33 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-4; Fri, 14 Feb 2025 14:14:33 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 03/45] migration: lower handler priority
Date: Fri, 14 Feb 2025 06:13:45 -0800
Message-Id: <1739542467-226739-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140104
X-Proofpoint-GUID: TJVbJn3ViBuJ2eksh1wFmteaUrIilX_a
X-Proofpoint-ORIG-GUID: TJVbJn3ViBuJ2eksh1wFmteaUrIilX_a
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Define a vmstate priority that is lower than the default, so its handlers
run after all default priority handlers.  Since 0 is no longer the default
priority, translate an uninitialized priority of 0 to MIG_PRI_DEFAULT.

CPR for vfio will use this to install handlers for containers that run
after handlers for the devices that they contain.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h | 6 +++++-
 migration/savevm.c          | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index a1dfab4..1ff7bd9 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -155,7 +155,11 @@ enum VMStateFlags {
 };
 
 typedef enum {
-    MIG_PRI_DEFAULT = 0,
+    MIG_PRI_UNINITIALIZED = 0,  /* An uninitialized priority field maps to */
+                                /* MIG_PRI_DEFAULT in save_state_priority */
+
+    MIG_PRI_LOW,                /* Must happen after default */
+    MIG_PRI_DEFAULT,
     MIG_PRI_IOMMU,              /* Must happen before PCI devices */
     MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
     MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
diff --git a/migration/savevm.c b/migration/savevm.c
index 85a3559..7eee90d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -232,7 +232,7 @@ typedef struct SaveState {
 
 static SaveState savevm_state = {
     .handlers = QTAILQ_HEAD_INITIALIZER(savevm_state.handlers),
-    .handler_pri_head = { [MIG_PRI_DEFAULT ... MIG_PRI_MAX] = NULL },
+    .handler_pri_head = { [0 ... MIG_PRI_MAX] = NULL },
     .global_section_id = 0,
 };
 
@@ -704,7 +704,7 @@ static int calculate_compat_instance_id(const char *idstr)
 
 static inline MigrationPriority save_state_priority(SaveStateEntry *se)
 {
-    if (se->vmsd) {
+    if (se->vmsd && se->vmsd->priority) {
         return se->vmsd->priority;
     }
     return MIG_PRI_DEFAULT;
-- 
1.8.3.1



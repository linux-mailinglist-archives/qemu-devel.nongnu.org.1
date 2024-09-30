Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1E698AD1C
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Sep 2024 21:43:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMGc-00076k-3P; Mon, 30 Sep 2024 15:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGZ-000721-Aw
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGX-00021o-KG
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:07 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UIuexw009763;
 Mon, 30 Sep 2024 19:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=HysP4omggtE9KxPL3xp4ARnkMhOUVKL4mnkBqxR1eZM=; b=
 gyhXRnfWIHCFLcXgeC7Qg723kCJf0+hahZ6HZJyhI9s3CCD+ncYVKxTlSO9eM59q
 4pTswX5nWlu7c9vskHlIO6RGfFQqIFg0KiKyclmBMLhItVwI7/fN9pIf2aCefyf8
 M18FzTp1QaOho+I96ngwm5kKFLaTGtVDabOdFULyqOv3OR1NbCjSGHjo4eccyt5z
 E+/ndGy9jdnbv6FJD1vGjFkgWpdtuoaQnDpTRQNlywmrGlY8fkhgtqJ94nJ8Gc8X
 5P8klhix5Lfl67MhAykffQpr0zN2kxT21kskHssuXV5J2RSn+AbOdW4KZE5KA95J
 99Gp9usHF0vXx8w/S6R+Pg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qb4k5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:41:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48UIo442012508; Mon, 30 Sep 2024 19:41:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41x8868twm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:41:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48UJepUu028204;
 Mon, 30 Sep 2024 19:40:59 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 41x8868thj-7; Mon, 30 Sep 2024 19:40:59 +0000
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
Subject: [PATCH V2 06/13] hostmem-memfd: preserve for cpr
Date: Mon, 30 Sep 2024 12:40:37 -0700
Message-Id: <1727725244-105198-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_19,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300142
X-Proofpoint-GUID: 9X6affZTBclpERycrCJucrNHw4gNSHds
X-Proofpoint-ORIG-GUID: 9X6affZTBclpERycrCJucrNHw4gNSHds
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

Preserve memory-backend-memfd memory objects during cpr-transfer.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/hostmem-memfd.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 6a3c89a..2740222 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -17,6 +17,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qom/object.h"
+#include "migration/cpr.h"
 
 #define TYPE_MEMORY_BACKEND_MEMFD "memory-backend-memfd"
 
@@ -35,15 +36,19 @@ static bool
 memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
     HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(backend);
-    g_autofree char *name = NULL;
+    g_autofree char *name = host_memory_backend_get_name(backend);
+    int fd = cpr_find_fd(name, 0);
     uint32_t ram_flags;
-    int fd;
 
     if (!backend->size) {
         error_setg(errp, "can't create backend with size 0");
         return false;
     }
 
+    if (fd >= 0) {
+        goto have_fd;
+    }
+
     fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
                            m->hugetlb, m->hugetlbsize, m->seal ?
                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
@@ -51,9 +56,10 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     if (fd == -1) {
         return false;
     }
+    cpr_save_fd(name, 0, fd);
 
+have_fd:
     backend->aligned = true;
-    name = host_memory_backend_get_name(backend);
     ram_flags = backend->share ? RAM_SHARED : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
-- 
1.8.3.1



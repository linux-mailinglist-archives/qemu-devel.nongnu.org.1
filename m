Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 380DA79AB67
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 22:55:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfnub-0008BN-P4; Mon, 11 Sep 2023 16:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1qfnuS-00087B-J8; Mon, 11 Sep 2023 16:53:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1qfnuI-00018A-DL; Mon, 11 Sep 2023 16:53:26 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BKphjL008658; Mon, 11 Sep 2023 20:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=S91ot1z7V3Ra872ELd0JhMeLsv7MWzB6cFaAw9G5eHk=;
 b=iQCRJlVUvTNWJrDzh2CcfJNnXQFUDX239unCaszNfxt0MaO7pO16+8IBqDikgwlVkV0j
 Dy5osYbqr8xU88eXcuhDfrAawVE68HWqpAATShuEzTUqgXrsL0eFvWLFSDt8WvDuMvHF
 KxwRPPT8RdxqLCXLViiY6TXQfD0jZcakclw7APix8fbz+TsgStZV1fxGspM0oqtVKLu9
 VWy1TaxnxZDpq0em6lcHhJ7N0zs2NFBavselNkBdzENNATFhMNe7ixwFdjJFgVlgkIUc
 VkDUmtBYC4435eLrFqdDkxCCsiMeohVBuqrD2BJBfGQ+ZyWJXZuJmu5wlOKgtPCctGVI lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2aa6014g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 20:52:54 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38BKpfjj008573;
 Mon, 11 Sep 2023 20:52:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2aa60143-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 20:52:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BIu6GG012169; Mon, 11 Sep 2023 20:52:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dydukt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 20:52:53 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38BKqqfU12911204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 20:52:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3568358059;
 Mon, 11 Sep 2023 20:52:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 054E258058;
 Mon, 11 Sep 2023 20:52:51 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.ibm.com.com (unknown
 [9.67.49.93]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 Sep 2023 20:52:50 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, eblake@redhat.com, armbru@redhat.com,
 david@redhat.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 thuth@redhat.com
Subject: [PATCH v1 1/2] target/s390x: introduce "host-recommended" option for
 model expansion
Date: Mon, 11 Sep 2023 16:52:31 -0400
Message-ID: <20230911205232.71735-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0ntsUAKg1jPiDgleZ-p0AcBAsQfaDCKd
X-Proofpoint-ORIG-GUID: VMls6kYBoHYWRLjVvLQcQvR8dMETJuZl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=980 bulkscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110189
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Newer S390 machines may drop support for features completely, rendering
guests operating with older CPU models incapable of running on said
machines. A manual effort to disable certain CPU features would be
required.

To alleviate this issue, a list of "deprecated" features are now
retained within QEMU, and a new "static-recommended" CPU model expansion
type has been created to allow a query of the host-model with deprecated
features explicitly disabled.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 qapi/machine-target.json         |  8 +++++++-
 target/s390x/cpu_features.c      | 14 ++++++++++++++
 target/s390x/cpu_features.h      |  1 +
 target/s390x/cpu_models_sysemu.c | 26 +++++++++++++++++++++-----
 4 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index f0a6b72414..4dc891809d 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -42,6 +42,12 @@
 #     to be migration-safe, but allows tooling to get an insight and
 #     work with model details.
 #
+# @static-recommended: Expand to a static CPU model with property
+#     changes suggested by the architecture. This is useful for
+#     expanding a CPU model expected to operate in mixed
+#     CPU-generation environments. The @static-recommended CPU
+#     models are migration-safe.
+#
 # Note: When a non-migration-safe CPU model is expanded in static
 #     mode, some features enabled by the CPU model may be omitted,
 #     because they can't be implemented by a static CPU model
@@ -55,7 +61,7 @@
 # Since: 2.8
 ##
 { 'enum': 'CpuModelExpansionType',
-  'data': [ 'static', 'full' ] }
+  'data': [ 'static', 'full', 'static-recommended' ] }
 
 ##
 # @CpuModelCompareResult:
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index d28eb65845..efafc9711c 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -212,6 +212,20 @@ void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
     };
 }
 
+void s390_get_deprecated_features(S390FeatBitmap features)
+{
+    static const int feats[] = {
+         /* CSSKE is deprecated on newer generations */
+         S390_FEAT_CONDITIONAL_SSKE,
+         S390_FEAT_BPB,
+    };
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(feats); i++) {
+        set_bit(feats[i], features);
+    }
+}
+
 #define FEAT_GROUP_INIT(_name, _group, _desc)        \
     {                                                \
         .name = _name,                               \
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 87463f064d..5421762db5 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -68,6 +68,7 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
                           uint8_t *data);
 void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
                                void (*fn)(const char *name, void *opaque));
+void s390_get_deprecated_features(S390FeatBitmap features);
 
 /* Definition of a CPU feature group */
 typedef struct {
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index 63981bf36b..1aa3d076b4 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -176,7 +176,7 @@ static void qdict_add_enabled_feat(const char *name, void *opaque)
 
 /* convert S390CPUDef into a static CpuModelInfo */
 static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
-                                bool delta_changes)
+                                bool delta_changes, bool disable_dep_feats)
 {
     QDict *qdict = qdict_new();
     S390FeatBitmap bitmap;
@@ -198,6 +198,13 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
         if (!bitmap_empty(bitmap, S390_FEAT_MAX)) {
             s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_enabled_feat);
         }
+
+        /* features flagged as deprecated */
+        if (disable_dep_feats) {
+            bitmap_zero(bitmap, S390_FEAT_MAX);
+            s390_get_deprecated_features(bitmap);
+            s390_feat_bitmap_to_ascii(bitmap, qdict, qdict_add_disabled_feat);
+        }
     } else {
         /* expand all features */
         s390_feat_bitmap_to_ascii(model->features, qdict,
@@ -221,6 +228,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     CpuModelExpansionInfo *expansion_info = NULL;
     S390CPUModel s390_model;
     bool delta_changes = false;
+    bool disable_dep_feats = false;
 
     /* convert it to our internal representation */
     cpu_model_from_info(&s390_model, model, &err);
@@ -229,9 +237,16 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         return NULL;
     }
 
-    if (type == CPU_MODEL_EXPANSION_TYPE_STATIC) {
+    switch (type) {
+    case CPU_MODEL_EXPANSION_TYPE_STATIC_RECOMMENDED:
+        disable_dep_feats = true;
+        /* fall through */
+    case CPU_MODEL_EXPANSION_TYPE_STATIC:
         delta_changes = true;
-    } else if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
+        break;
+    case CPU_MODEL_EXPANSION_TYPE_FULL:
+        break;
+    default:
         error_setg(errp, "The requested expansion type is not supported.");
         return NULL;
     }
@@ -239,7 +254,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     /* convert it back to a static representation */
     expansion_info = g_new0(CpuModelExpansionInfo, 1);
     expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
-    cpu_info_from_model(expansion_info->model, &s390_model, delta_changes);
+    cpu_info_from_model(expansion_info->model, &s390_model,
+                        delta_changes, disable_dep_feats);
     return expansion_info;
 }
 
@@ -388,7 +404,7 @@ CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *infoa,
 
     baseline_info = g_new0(CpuModelBaselineInfo, 1);
     baseline_info->model = g_malloc0(sizeof(*baseline_info->model));
-    cpu_info_from_model(baseline_info->model, &model, true);
+    cpu_info_from_model(baseline_info->model, &model, true, false);
     return baseline_info;
 }
 
-- 
2.41.0



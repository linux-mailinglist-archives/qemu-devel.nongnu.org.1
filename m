Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A63048282AD
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 10:03:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7zC-0007ra-G7; Tue, 09 Jan 2024 04:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7z6-0007qB-6S; Tue, 09 Jan 2024 04:01:21 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1rN7yy-0003SZ-LP; Tue, 09 Jan 2024 04:01:17 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4093aCwW024213; Tue, 9 Jan 2024 09:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=4LLPJmcwNDYE6zAIgfTw5xPBLw1+IKRY6ytH61cWc0M=; b=UE
 C99BKAHOLV3FTxN9UgHQDJpWjbBxRPPK9NbrrfyDe2RmkGeBeblJ7TD2HYPYsk4C
 OE2y7KRipdXXuEeccUnXtdCuwuduhCNPrIIXBu+G1RsOQU2VH/43e7E5xW0alqks
 5PfH7wkViHtOlslAjKZ1XRxtozRJNkFjKu/+RrkhqGCP1mXHN5iP6Pr6pf5u/reQ
 C8kGH5lXdKYvR5Xupv0al1EHIRsDHlG7r75P8UgQ3rY2YBUEJetUbrbTV7Pbp/yw
 6uTtWFErxcBkfkxPhd9ihxoq46x6mdf1Z+JTDEHFslNJrVPcb61/99HLwbqTADr6
 gaBfCl6kSBy6FHEOcOvw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgwhs8myu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 09:01:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409916xp026295
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 9 Jan 2024 09:01:06 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 01:01:02 -0800
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <philmd@linaro.org>, <alex.bennee@linaro.org>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v1 03/11] gunyah: Add VM properties
Date: Tue, 9 Jan 2024 09:00:31 +0000
Message-ID: <20240109090039.1636383-4-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
References: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: MmiqAHrQ_umje1y47YZ-kNygh9osnzl5
X-Proofpoint-GUID: MmiqAHrQ_umje1y47YZ-kNygh9osnzl5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=966
 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401090070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add 'protected-vm' and 'preshmem-size' properties that can be specified
for a VM.

Protected VMs are those that have 'protected-vm' property set. Their
memory cannot be accessed by their (potentially untrusted) host. They
are useful to run secure applications whose data should remain private
to the VM.

Since a protected VM may need some memory shared with its host, for
exchange of information, 'preshmem-size' specifies what portion of a
protected VM's memory should be shared with its host, with the remaining
portion being private to it.

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 accel/gunyah/gunyah-accel-ops.c | 65 +++++++++++++++++++++++++++++++++
 include/sysemu/gunyah_int.h     |  2 +
 2 files changed, 67 insertions(+)

diff --git a/accel/gunyah/gunyah-accel-ops.c b/accel/gunyah/gunyah-accel-ops.c
index 1419de57e8..fe732a1d47 100644
--- a/accel/gunyah/gunyah-accel-ops.c
+++ b/accel/gunyah/gunyah-accel-ops.c
@@ -37,6 +37,60 @@ static void gunyah_accel_instance_init(Object *obj)
     s->vmfd = -1;
 }
 
+static void gunyah_get_preshmem_size(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    GUNYAHState *s = GUNYAH_STATE(obj);
+    uint32_t value = s->preshmem_size;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void gunyah_set_preshmem_size(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    GUNYAHState *s = GUNYAH_STATE(obj);
+    uint32_t value;
+
+    if (s->fd != -1) {
+        error_setg(errp, "Cannot set properties after VM is created");
+        return;
+    }
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        error_setg(errp, "preshmem-size must be an unsigned integer");
+        return;
+    }
+
+    if (value & (value - 1)) {
+        error_setg(errp, "preshmem-size must be a power of two");
+        return;
+    }
+
+    if (!s->is_protected_vm) {
+        error_setg(errp, "preshmem-size is applicable only for protected VMs");
+        return;
+    }
+
+    s->preshmem_size = value;
+}
+
+static bool gunyah_get_protected_vm(Object *obj, Error **errp)
+{
+    GUNYAHState *s = GUNYAH_STATE(obj);
+
+    return s->is_protected_vm;
+}
+
+static void gunyah_set_protected_vm(Object *obj, bool value, Error **errp)
+{
+    GUNYAHState *s = GUNYAH_STATE(obj);
+
+    s->is_protected_vm = value;
+}
+
 static void gunyah_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -44,6 +98,17 @@ static void gunyah_accel_class_init(ObjectClass *oc, void *data)
     ac->name = "GUNYAH";
     ac->init_machine = gunyah_init;
     ac->allowed = &gunyah_allowed;
+
+    object_class_property_add_bool(oc, "protected-vm",
+                    gunyah_get_protected_vm, gunyah_set_protected_vm);
+    object_class_property_set_description(oc, "protected-vm",
+            "Launch a VM of protected type");
+
+    object_class_property_add(oc, "preshmem-size", "uint32",
+                gunyah_get_preshmem_size, gunyah_set_preshmem_size, NULL, NULL);
+    object_class_property_set_description(oc, "preshmem-size",
+        "This property is applicable for protected VMs and indicates "
+        "the portion of VM's memory that should be shared with its host");
 }
 
 static const TypeInfo gunyah_accel_type = {
diff --git a/include/sysemu/gunyah_int.h b/include/sysemu/gunyah_int.h
index 37de628b37..b1fd7f9ea2 100644
--- a/include/sysemu/gunyah_int.h
+++ b/include/sysemu/gunyah_int.h
@@ -19,6 +19,8 @@ struct GUNYAHState {
 
     int fd;
     int vmfd;
+    bool is_protected_vm;
+    uint32_t preshmem_size;
 };
 
 int gunyah_create_vm(void);
-- 
2.25.1



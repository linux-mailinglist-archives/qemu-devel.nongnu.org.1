Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 603DC7653EF
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 14:30:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP03s-00011k-NR; Thu, 27 Jul 2023 08:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qP03P-0000yG-CJ; Thu, 27 Jul 2023 08:25:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qP03M-00019w-FZ; Thu, 27 Jul 2023 08:25:14 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36RCF26l004198; Thu, 27 Jul 2023 12:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BbwLORcfAUBPqJsYQK4Qm5SGuif8s7Qz81E3J+S5XLY=;
 b=jrmLS/f851AMuag6gl7io6n4ER9XgAyiTRBrpD7fHoCgLl6ukXSjhVOmZEkckLbiyqwn
 qnHmCTVyh794As1zajpBJb9RcXNUeRaJ8poTgRIC6rbqPyvJ+Ngi3w8N/o8gh8EqSlJZ
 ocQultG7TWAq9zw1Oe4sESdWWvQ1nwUnXzkfmJ1q8Hppz0HtHA87PEL/6EtnfSX9zBdY
 9Nl6oLvhDSFrGtDz0kGdOMgZKJJbMbF+rQQ0d3RrNf8pMDeJB6vLVgLP+YUbBP4nYQ69
 Hp9c+CY4qW0f78MDSnFebgRrnxO+Y+Tcr29XKBDM0zFnPbjIzk7NoDsbUw8JoobBeiv2 cg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3rdpga8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 12:25:08 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36RCI6YQ014487;
 Thu, 27 Jul 2023 12:25:07 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3rdpga80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 12:25:07 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36RCBDot026217; Thu, 27 Jul 2023 12:25:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0sesdw0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 12:25:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36RCP45o60686750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Jul 2023 12:25:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51C2A20040;
 Thu, 27 Jul 2023 12:25:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FBB32004B;
 Thu, 27 Jul 2023 12:25:04 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Jul 2023 12:25:04 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 1/3] linux-headers: update asm-s390/kvm.h
Date: Thu, 27 Jul 2023 14:25:01 +0200
Message-Id: <20230727122503.775084-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230727122503.775084-1-seiden@linux.ibm.com>
References: <20230727122503.775084-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: veQS5hNCCN1q6jRgr0DMlFeO0csbStCu
X-Proofpoint-ORIG-GUID: 53kHzzzyxYSScA3EKW3TrE87UlKjlUsy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 phishscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270108
Received-SPF: pass client-ip=148.163.158.5; envelope-from=seiden@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 linux-headers/asm-s390/kvm.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index e2afd95420..178edb959e 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -159,6 +159,27 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 reserved[1728];
 };
 
+#define KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST	6
+#define KVM_S390_VM_CPU_MACHINE_UV_FEAT_GUEST	7
+
+#define KVM_S390_VM_CPU_UV_FEAT_NR_BITS	64
+struct kvm_s390_vm_cpu_uv_feat {
+	union {
+		struct {
+			__u64 res0 : 4;
+			__u64 ap : 1;		/* bit 4 */
+			__u64 ap_intr : 1;	/* bit 5 */
+		};
+		__u64 feat;
+	};
+};
+
+#define KVM_S390_VM_CPU_UV_FEAT_GUEST_MASK \
+(((struct kvm_s390_vm_cpu_uv_feat) {	\
+	.ap = 1,		\
+	.ap_intr = 1,		\
+}).feat)
+
 /* kvm attributes for crypto */
 #define KVM_S390_VM_CRYPTO_ENABLE_AES_KW	0
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
-- 
2.40.1



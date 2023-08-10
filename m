Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 890357778C9
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 14:48:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU54e-0006Ei-CU; Thu, 10 Aug 2023 08:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qU54b-0006Dc-Lx; Thu, 10 Aug 2023 08:47:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qU54Z-0005tn-Ep; Thu, 10 Aug 2023 08:47:29 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37ACW72M019638; Thu, 10 Aug 2023 12:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Gg3vQAjITAm0TENK3RTjwG4xOyv2ytPXdhsrYr3B/Fo=;
 b=VvMbHSRDy4C48XqUMq0X66ZS5aSGG8l6rMLlyfFluHQvvMwrR9puN4DYq3u2qu1OXgWe
 hOVISPIXN66kQ9RAp+p2nNCnj/sZcfWmJBGAhci4oNvSpemDULMr4gQrKTtdxB/47MUQ
 +ZwHWumTnoz0aVPQLZZxLHDqkPjBeYPXVpY6Hxd8/vCB33pg5bLZJc+fvKBi5exhHqYJ
 wACIa4sfSahuyPCWD7q3qpuClRWUmyyz6TwJXJbisWb28+bS8laMXN1rYJYeMiudsj70
 DftrAKmE02JWf6PrPUKfAOvUUeYbfx+SLYU35ocObUss2Mle7n5/k8DGA9bzLgMECJyF fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scyyy8gyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 12:47:24 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37AClNK0019041;
 Thu, 10 Aug 2023 12:47:23 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scyyy8gxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 12:47:23 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37AB7wm2006656; Thu, 10 Aug 2023 12:47:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa0rthydu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 12:47:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37AClJP6393912
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Aug 2023 12:47:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C714320040;
 Thu, 10 Aug 2023 12:47:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C76A2004F;
 Thu, 10 Aug 2023 12:47:19 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Aug 2023 12:47:19 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 1/3] linux-headers: update asm-s390/kvm.h
Date: Thu, 10 Aug 2023 14:47:17 +0200
Message-Id: <20230810124719.2167260-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810124719.2167260-1-seiden@linux.ibm.com>
References: <20230810124719.2167260-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tSz1H6dJYdO_EaYnBgvN80oHQbZvXtOH
X-Proofpoint-ORIG-GUID: khAbxkAEYmIw9ZS4BqvJVIjOygSJ8pU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100106
Received-SPF: pass client-ip=148.163.156.1; envelope-from=seiden@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 linux-headers/asm-s390/kvm.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index e2afd95420..023a2763a9 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -159,6 +159,22 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 reserved[1728];
 };
 
+#define KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST	6
+#define KVM_S390_VM_CPU_MACHINE_UV_FEAT_GUEST	7
+
+#define KVM_S390_VM_CPU_UV_FEAT_NR_BITS	64
+struct kvm_s390_vm_cpu_uv_feat {
+	union {
+		struct {
+			__u64 : 4;
+			__u64 ap : 1;		/* bit 4 */
+			__u64 ap_intr : 1;	/* bit 5 */
+			__u64 : 58;
+		};
+		__u64 feat;
+	};
+};
+
 /* kvm attributes for crypto */
 #define KVM_S390_VM_CRYPTO_ENABLE_AES_KW	0
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
-- 
2.40.1



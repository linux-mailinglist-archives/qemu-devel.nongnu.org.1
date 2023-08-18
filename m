Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00486780D79
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:06:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05q-0004zu-60; Fri, 18 Aug 2023 10:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qWxS3-0001WC-Dr; Fri, 18 Aug 2023 07:15:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qWxRx-0000MB-J3; Fri, 18 Aug 2023 07:15:33 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37IAwth4007763; Fri, 18 Aug 2023 11:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BW+/dmQ93TZtSpYnvU9mqfiNp++z63Q+0a9Ft9mz0iM=;
 b=AHn0ZYfM7wH6cStGLJqQ12kNXbin3CcCb8tQxErOlokzuy5coR1hn1CabrBFRmNm4vTj
 lDqyHFs0OqfkB2ePNLt0P7cuspmhXDdtEW5MnWMhM+Yd7mSzqnxEhLpFHpwGrsgvPZEJ
 XO796dO2JiOUZxZT6UWHy4rTeCoWSXfWUcXP0LJoqTFE9OwgliK9svHb3CgpczhQibh+
 uS2JKxbfOH8nhCo3AFgiERWEFHVtT2z9w8e0Wcus6RpvyD7WXPc2WSCM1JDzWN09bivz
 cuKTdikQIgBOhjv70+krN/gi9C8tkSJBjetEG0BlSMIV/JKaXtpedyyyDD1hxHQrceql gg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sj7c38bm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Aug 2023 11:15:26 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IB07E9011240;
 Fri, 18 Aug 2023 11:15:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sj7c38bkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Aug 2023 11:15:26 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37IAmEI7002421; Fri, 18 Aug 2023 11:15:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendnxg3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Aug 2023 11:15:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37IBFLT045744862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Aug 2023 11:15:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6E6620071;
 Fri, 18 Aug 2023 11:15:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F13820075;
 Fri, 18 Aug 2023 11:15:21 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Aug 2023 11:15:21 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v3 3/5] NOTFORMERGE update linux-headers/asm-s390/kvm.h
Date: Fri, 18 Aug 2023 13:15:18 +0200
Message-ID: <20230818111520.698615-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818111520.698615-1-seiden@linux.ibm.com>
References: <20230818111520.698615-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5ejVD_EVV5NveEzggP9HkakYHSP-x94T
X-Proofpoint-GUID: Yt5dSyXZzmxk16NFXB0OJF6yHAsyec3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_12,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=996 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308180102
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

Likely to be included in Linux 6.{6,7}

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
2.41.0



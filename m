Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB23A91C84
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 14:40:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5OWZ-0001eh-10; Thu, 17 Apr 2025 08:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u5OVJ-0001K5-1V; Thu, 17 Apr 2025 08:38:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u5OVH-00038t-AA; Thu, 17 Apr 2025 08:38:04 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HAeaaL015631;
 Thu, 17 Apr 2025 12:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Q9dWrfpPOxjk1cec4
 q+kp6SXOsX3cigOBnJZC2HCBmk=; b=cArnTipgaQrNYzfOrARCB8sKDK5uVHVGT
 1vrl6WFgkDzJUHIIh4MwL/+MHMLcWhBo2l6b0GpNXbfsQ+hMsMZ7Hm4Pw2oKreOx
 Za3Z5BotNd54rS/t1L6MFpOaX3DKlpHzQq4UBT8EAzQnO+UYn7cqLuNmipiozzm4
 mTrRe6ClyvqeuMSElVHS71YrdY02ipNcjtjBYt3qkq8VHE6JMTbMkElIg70yQ/Bq
 zwlBBDdxEfyvnynFJr4aJc6pk0FvuLcl0M0xf76C8eNYWuc0+1jLm4Vv0KsBqbBG
 aS2NvpwPOHCQTtKsvFSe874jVbdRW8VQeqsAaiLkIugN4Ml9VujHA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46303rrfuu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 12:38:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBcGmm010432;
 Thu, 17 Apr 2025 12:38:01 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qkdcjy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 12:38:01 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53HCbvau22479550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 12:37:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B15A58062;
 Thu, 17 Apr 2025 12:37:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 420EC58056;
 Thu, 17 Apr 2025 12:37:58 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.152.108.100])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Apr 2025 12:37:58 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v4 1/3] target/s390x: Introduce constant when checking if PV
 header couldn't be decrypted
Date: Thu, 17 Apr 2025 14:37:54 +0200
Message-ID: <20250417123756.729132-2-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417123756.729132-1-ggala@linux.ibm.com>
References: <20250417123756.729132-1-ggala@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/bpyRP+ c=1 sm=1 tr=0 ts=6800f62a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=dlrBAAIIzbR3EyIgmhgA:9
X-Proofpoint-ORIG-GUID: DZf6ngK61617oIUNeK1Kd_p-KJUdyRVS
X-Proofpoint-GUID: DZf6ngK61617oIUNeK1Kd_p-KJUdyRVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=829 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170094
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ggala@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce a named constant when checking the Set Secure Configuration parameters
UV call return code for the case where no valid host key was found and therefore
the PV header couldn't be decrypted (0x108).

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
---
 target/s390x/kvm/pv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index b191a4a68a..3a0a971f0b 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -147,6 +147,7 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
     return true;
 }
 
+#define DIAG_308_UV_RC_INVAL_HOSTKEY    0x0108
 int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp)
 {
     int ret, pvrc;
@@ -158,7 +159,7 @@ int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp)
     ret = s390_pv_cmd_pvrc(KVM_PV_SET_SEC_PARMS, &args, &pvrc);
     if (ret) {
         error_setg(errp, "Failed to set secure execution parameters");
-        if (pvrc == 0x108) {
+        if (pvrc == DIAG_308_UV_RC_INVAL_HOSTKEY) {
             error_append_hint(errp, "Please check whether the image is "
                                     "correctly encrypted for this host\n");
         }
-- 
2.49.0



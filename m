Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E221179AB66
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 22:55:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfnub-0008D1-6G; Mon, 11 Sep 2023 16:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1qfnuT-000883-JD; Mon, 11 Sep 2023 16:53:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1qfnuC-00018E-Pm; Mon, 11 Sep 2023 16:53:28 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BKcojX021780; Mon, 11 Sep 2023 20:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MDsDLchGGP+i5dp13CIsBRIDrVUhe0NzerVTfJkxGkA=;
 b=pCB++BSy0DGbEBsmObykm3aQ7y2/i1OvKOclrMrc8/t71cBc0+j/qj72cicxNt5AU2xe
 DUnleKW6dTUu9nvA4VmPDypbXH7AD5g0rcE4gkiyPZCajmQpqFLMw7yTuEpA+cOtSVFL
 hvX2IZV40Ko5UDYhc6j21gakCXJ75Otd66hz86sJTIXTWSNB8mB86sIzFzHFiYBqZsM4
 J4cg22IGPSciN5y927NY7kQXSnXupE5lVcr6W/s+5/VbgOFovSnfG/NTdHwBUjhpCCoy
 xdTPJxvcs3s6TJCWy+GVHu2OKTV1awJdn4QJ0/Ld1EsZGYm4zUpImI2oM+FLczC3sLKw Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t29xe0f53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 20:52:55 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38BKdW3o024353;
 Mon, 11 Sep 2023 20:52:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t29xe0f4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 20:52:55 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BJcnis023152; Mon, 11 Sep 2023 20:52:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t141ndmvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 20:52:54 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38BKqrC44981500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 20:52:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 948FD58059;
 Mon, 11 Sep 2023 20:52:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CDAD58058;
 Mon, 11 Sep 2023 20:52:52 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.ibm.com.com (unknown
 [9.67.49.93]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 Sep 2023 20:52:52 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, eblake@redhat.com, armbru@redhat.com,
 david@redhat.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 thuth@redhat.com
Subject: [PATCH v1 2/2] target/s390x: flag te and cte as deprecated
Date: Mon, 11 Sep 2023 16:52:32 -0400
Message-ID: <20230911205232.71735-2-walling@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911205232.71735-1-walling@linux.ibm.com>
References: <20230911205232.71735-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HUeTI2_4bDr1NJyK5LUxh9scS2zdeEMt
X-Proofpoint-GUID: n0KZYB804lp__X8C-NP9h0FVCCKxccEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=809 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110189
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add the CONSTRAINT_TRANSACTIONAL_EXE (cte) and TRANSACTIONAL_EXE (te)
under the list of deprecated features.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 target/s390x/cpu_features.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index efafc9711c..cb4e2b8920 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -218,6 +218,9 @@ void s390_get_deprecated_features(S390FeatBitmap features)
          /* CSSKE is deprecated on newer generations */
          S390_FEAT_CONDITIONAL_SSKE,
          S390_FEAT_BPB,
+         /* Deprecated on z16 */
+         S390_FEAT_CONSTRAINT_TRANSACTIONAL_EXE,
+         S390_FEAT_TRANSACTIONAL_EXE
     };
     int i;
 
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F61C7D9E1E
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 18:38:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPpd-0001uO-H7; Fri, 27 Oct 2023 12:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qwPpZ-0001ty-Iq; Fri, 27 Oct 2023 12:37:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qwPpX-0004w0-2B; Fri, 27 Oct 2023 12:37:05 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39RGTFcQ007139; Fri, 27 Oct 2023 16:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=o2J7xGFDUY8K6DA7PJU01Jnkkodp3XEaGQveANyx2DY=;
 b=R6bQpTa8VHw3X1+sn3JQNHW79vwoHDZrTQ5+3ITRSDZjdXi53T/ZIlebGpjRx9ZGTacs
 FTUieWbsOYp5xr8h3tSQSVmICnagRB3oSOVP/yylwTXYKHQX8H7OvdW1Vmf9ghfZIYaF
 DczwHhdbUcgslgKF8N57w/VdHkQe0pF4xjRa8yKxxbc/CJXzLLxhtbmGdEiKCZTyJ4kl
 DMz+04S9h4JK+X1Ik7Qxb7QYl3Sris55B5Q+gHEWfehRxMFM0mNMTuJajqdNiaG0uc7f
 bMyTloNZYgCcJBEwlF2KXnEsnfghBqch7ZY+Y0/bkGH2PTx/FzQZPDqguvke+WP/NlHu aw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0fp4t7un-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Oct 2023 16:36:45 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39RGTObK007604;
 Fri, 27 Oct 2023 16:36:44 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u0fp4t7u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Oct 2023 16:36:44 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39RGDRNQ008520; Fri, 27 Oct 2023 16:36:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tywqq6a1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Oct 2023 16:36:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39RGaeZu16056950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Oct 2023 16:36:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A85E820043;
 Fri, 27 Oct 2023 16:36:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C2DA20040;
 Fri, 27 Oct 2023 16:36:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Oct 2023 16:36:40 +0000 (GMT)
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH] target/s390x/cpu topology: Fix ordering and creation of TLEs
Date: Fri, 27 Oct 2023 18:36:37 +0200
Message-Id: <20231027163637.3060537-1-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6ICJienw2IWmxpoK3lRgmuR8O7Z9DaWu
X-Proofpoint-ORIG-GUID: laS-c-seP6wkt9__yDLicQoj3vMarGKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_15,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1011 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270143
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
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

In case of horizontal polarization entitlement has no effect on
ordering.
Moreover, since the comparison is used to insert CPUs at the correct
position in the TLE list, this affects the creation of TLEs and now
correctly collapses horizontally polarized CPUs into one TLE.

Fixes: f4f54b582f ("target/s390x/cpu topology: handle STSI(15) and build the SYSIB")
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---

Unfortunately this wasn't caught by the kvm-unit-test because that also
had a bug :(

 target/s390x/kvm/stsi-topology.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-topology.c
index efd2aa71f1..c8d6389cd8 100644
--- a/target/s390x/kvm/stsi-topology.c
+++ b/target/s390x/kvm/stsi-topology.c
@@ -210,6 +210,9 @@ static S390TopologyId s390_topology_from_cpu(S390CPU *cpu)
 static int s390_topology_id_cmp(const S390TopologyId *l,
                                 const S390TopologyId *r)
 {
+    int l_polarization = l->vertical ? l->entitlement : 0;
+    int r_polarization = r->vertical ? r->entitlement : 0;
+
     /*
      * lexical order, compare less significant values only if more significant
      * ones are equal
@@ -219,9 +222,8 @@ static int s390_topology_id_cmp(const S390TopologyId *l,
            l->book - r->book ?:
            l->socket - r->socket ?:
            l->type - r->type ?:
-           /* logic is inverted for the next three */
-           r->vertical - l->vertical ?:
-           r->entitlement - l->entitlement ?:
+           /* logic is inverted for the next two */
+           r_polarization - l_polarization ?:
            r->dedicated - l->dedicated ?:
            l->origin - r->origin;
 }

base-commit: c60be6e3e38cb36dc66129e757ec4b34152232be
-- 
2.39.2



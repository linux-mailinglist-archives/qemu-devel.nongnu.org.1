Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAEA78FCA6
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 13:50:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc2eJ-0003EU-NX; Fri, 01 Sep 2023 07:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1qc2eD-0003Ai-99; Fri, 01 Sep 2023 07:49:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1qc2e8-0007hG-LA; Fri, 01 Sep 2023 07:49:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 381BeXRk007076; Fri, 1 Sep 2023 11:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aSIHArLEnmUztU3tbBn1hhACoycsdwN6EGOGSu3FKxo=;
 b=fJ7MX2C3AGhOA17upft2hlfAQN9ORNDW9Ebtsa7/7wvamVDJ5flB1S5sMiLmW71jrG02
 f9AAYx9jkBooSS+gd0WbjNYD99b73L+/IadivwLgIhHjsPFoRVmU8iaBgZe2L747WyAC
 Sex4KD8zd/37CsWrKRXKae5CceFc3lUut9g5/A/DNPakS0tOSbjY3WfBF0Et4u6OHF7/
 4aaFcdcHam5RMUThqYjRN9bDmzEWQX6e7kWInkC1xN8yNWR3y9p8RzKNiin2aT/Yr0le
 E7x8tlSoTnAFjjCvx0naQu6+nidU4exlMepItbweKyxx3kRjRgmXb4b/3plWjykSw4v+ Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sudqt25jh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 11:49:02 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381Bf150008478;
 Fri, 1 Sep 2023 11:49:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sudqt25j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 11:49:01 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 381AoO03009897; Fri, 1 Sep 2023 11:49:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7m493s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 11:49:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 381BmvTs37355950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Sep 2023 11:48:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47B6420043;
 Fri,  1 Sep 2023 11:48:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1716920040;
 Fri,  1 Sep 2023 11:48:57 +0000 (GMT)
Received: from a46lp67.. (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 Sep 2023 11:48:57 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, seiden@linux.ibm.com, mhartmay@linux.ibm.com,
 thuth@redhat.com, david@redhat.com, mimu@linux.ibm.com,
 borntraeger@linux.ibm.com
Subject: [PATCH] s390x: do a subsystem reset before the unprotect on reboot
Date: Fri,  1 Sep 2023 11:48:51 +0000
Message-Id: <20230901114851.154357-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <80b007e8-91d7-8298-f628-77c30616f0f4@linux.ibm.com>
References: <80b007e8-91d7-8298-f628-77c30616f0f4@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EBITEUgsvKDM5BkDSXVkJbuwS7fgn_nZ
X-Proofpoint-ORIG-GUID: tFQJ2DS9OIQ7pYLW5TJfyKvMtqvphOrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010108
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Bound APQNs have to be reset before tearing down the secure config via
s390_machine_unprotect(). Otherwise the Ultravisor will return a error
code.

So let's do a subsystem_reset() which includes a AP reset before the
unprotect call. We'll do a full device_reset() afterwards which will
reset some devices twice. That's ok since we can't move the
device_reset() before the unprotect as it includes a CPU clear reset
which the Ultravisor does not expect at that point in time.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---

I'm not able to test this for the PV AP case right new, that has to
wait to early next week. However Marc told me that the non-AP PV test
works fine now.

---
 hw/s390x/s390-virtio-ccw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3dd0b2372d..2d75f2131f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -438,10 +438,20 @@ static void s390_machine_reset(MachineState *machine, ShutdownCause reason)
     switch (reset_type) {
     case S390_RESET_EXTERNAL:
     case S390_RESET_REIPL:
+        /*
+         * Reset the subsystem which includes a AP reset. If a PV
+         * guest had APQNs attached the AP reset is a prerequisite to
+         * unprotecting since the UV checks if all APQNs are reset.
+         */
+        subsystem_reset();
         if (s390_is_pv()) {
             s390_machine_unprotect(ms);
         }
 
+        /*
+         * Device reset includes CPU clear resets so this has to be
+         * done AFTER the unprotect call above.
+         */
         qemu_devices_reset(reason);
         s390_crypto_reset();
 
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8108F831F54
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 19:53:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQXUj-0005I8-Sz; Thu, 18 Jan 2024 13:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQXUh-0005HZ-9c; Thu, 18 Jan 2024 13:52:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQXUf-0004yC-Ai; Thu, 18 Jan 2024 13:52:02 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40II3KA8003336; Thu, 18 Jan 2024 18:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=l29KxeR6qGwLXBTtmrlseGfiH8JnVeOj912tm/G4D0o=;
 b=cuS/Ot9LX6qSv5RbxaJB5feUKYXVcfLkP7WX3pylSG+j3aC/Zq/iVSOOnJ6dQW4mVVh8
 XvZsn6+c7791g3ypIDBZvwIxIeQYXw4jxtbAUm97QgfBTRZPu9ephBcFiWKgkFD0rdsC
 w/w9k2TagkKnzO8y80ll9xZLLM75GExbpLtBVk6n4idlrTbZwZRbap8sr8OfRLbKp6Xa
 LjKGeA58A5zrLmoJtgQeYA8HdgBpRMm4mFpp60VmRpz1XxzpKkxN3HKonP9gAE/Gcj0+
 tM2PX4Cp7GSlxsqN7euQfGhWveiJNaEbzcMzkQ1/E17zJBKjl6wcmBE3+k/B+zp7Kvd5 Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq8x09ds2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 18:51:58 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40IIOSSM024501;
 Thu, 18 Jan 2024 18:51:58 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq8x09drq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 18:51:58 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40IHRsuP030438; Thu, 18 Jan 2024 18:51:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72kcsa9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 18:51:57 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40IIpu6M52626102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 18:51:56 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9267058050;
 Thu, 18 Jan 2024 18:51:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BF4B58045;
 Thu, 18 Jan 2024 18:51:55 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.163.245]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jan 2024 18:51:54 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, clg@redhat.com,
 frankja@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH v2 2/3] s390x/pci: refresh fh before disabling aif
Date: Thu, 18 Jan 2024 13:51:50 -0500
Message-ID: <20240118185151.265329-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118185151.265329-1-mjrosato@linux.ibm.com>
References: <20240118185151.265329-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KuvDaGrm6YddWro-Inl2vEiNioMX63df
X-Proofpoint-ORIG-GUID: LqK8qt5NTSAItfUURv1vIDGaSnQEEXba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=876 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180137
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

Typically we refresh the host fh during CLP enable, however it's possible
that the device goes through multiple reset events before the guest
performs another CLP enable.  Let's handle this for now by refreshing the
host handle from vfio before disabling aif.

Fixes: 03451953c7 ("s390x/pci: reset ISM passthrough devices on shutdown and system reset")
Reported-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-kvm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/s390x/s390-pci-kvm.c b/hw/s390x/s390-pci-kvm.c
index 1ee510436c..9eef4fc3ec 100644
--- a/hw/s390x/s390-pci-kvm.c
+++ b/hw/s390x/s390-pci-kvm.c
@@ -18,6 +18,7 @@
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/s390-pci-kvm.h"
 #include "hw/s390x/s390-pci-inst.h"
+#include "hw/s390x/s390-pci-vfio.h"
 #include "cpu_models.h"
 
 bool s390_pci_kvm_interp_allowed(void)
@@ -64,6 +65,14 @@ int s390_pci_kvm_aif_disable(S390PCIBusDevice *pbdev)
         return -EINVAL;
     }
 
+    /*
+     * The device may have already been reset but we still want to relinquish
+     * the guest ISC, so always be sure to use an up-to-date host fh.
+     */
+    if (!s390_pci_get_host_fh(pbdev, &args.fh)) {
+        return -EPERM;
+    }
+
     rc = kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
     if (rc == 0) {
         pbdev->aif = false;
-- 
2.43.0



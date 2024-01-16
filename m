Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4030A82FCFE
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 23:36:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPs2L-00085H-BS; Tue, 16 Jan 2024 17:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rPs2E-00082W-LO; Tue, 16 Jan 2024 17:35:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rPs2B-0008FK-VV; Tue, 16 Jan 2024 17:35:53 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GMMNI0021322; Tue, 16 Jan 2024 22:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=t1XetSv/hej4tnhiheHsCWGo41BkGLeGT88kIHEhVAU=;
 b=GYjrwZQHYdRAEcof85tzO631OiuDAUJuoEgAkWw7rdnrs5RcMPQjemT5fZvhf2uJOKLl
 kIHCL07jrQuTj8L3bcDlTHsv4CS8nuOQfWm5TKR7uNtazzccLupfGHTtPMAAwAHlxxvh
 urtoCRMaxsAtco3S7NwcjIx14TGEoWEwSw0kIQ/9G3ik22ybib6eIwaXkI+DuIPwPjB+
 EylHYZ1BRsiog0li1PV+KKEq6trkHJo6O98ju/8a17yTW+dTQBpAuvhCO+/OnvRGaZX4
 6+ACpLIxH3Jhzjl6IZ8D0R0c5sGjnhnOEJGUYcMXHiAcyLqS044DENx/JBjHJIUNdc/h Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp26bgvsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 22:35:45 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GMZgwx025231;
 Tue, 16 Jan 2024 22:35:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp26bgvff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 22:35:45 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GMC9vV023364; Tue, 16 Jan 2024 22:32:03 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bkhcgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 22:32:03 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40GMW2CV27263620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 22:32:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6EAD58072;
 Tue, 16 Jan 2024 22:32:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4701C58079;
 Tue, 16 Jan 2024 22:32:01 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.163.245]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jan 2024 22:32:01 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, clg@redhat.com,
 frankja@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
Subject: [PATCH 2/3] s390x/pci: refresh fh before disabling aif
Date: Tue, 16 Jan 2024 17:31:56 -0500
Message-ID: <20240116223157.73752-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116223157.73752-1-mjrosato@linux.ibm.com>
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qVl_7EO2u-slSwwjlaSPiCj9SFG057-N
X-Proofpoint-ORIG-GUID: ld8mhIUONVcSVB9lJNiWi-uSBfYUirOD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=847 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160178
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-kvm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-kvm.c b/hw/s390x/s390-pci-kvm.c
index f7e10cfa72..9eef4fc3ec 100644
--- a/hw/s390x/s390-pci-kvm.c
+++ b/hw/s390x/s390-pci-kvm.c
@@ -18,6 +18,7 @@
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/s390-pci-kvm.h"
 #include "hw/s390x/s390-pci-inst.h"
+#include "hw/s390x/s390-pci-vfio.h"
 #include "cpu_models.h"
 
 bool s390_pci_kvm_interp_allowed(void)
@@ -64,9 +65,17 @@ int s390_pci_kvm_aif_disable(S390PCIBusDevice *pbdev)
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
-        pbev->aif = false;
+        pbdev->aif = false;
     }
 
     return rc;
-- 
2.43.0



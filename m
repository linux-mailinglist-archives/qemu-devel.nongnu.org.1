Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 429117E7F4F
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 18:52:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1VfN-0000Ij-E0; Fri, 10 Nov 2023 12:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1r1Vf7-0000I7-Sx; Fri, 10 Nov 2023 12:51:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1r1Vf5-0007A5-6Y; Fri, 10 Nov 2023 12:51:20 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAHp1wW026985; Fri, 10 Nov 2023 17:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6Er94xcoDADG6CtCKehHejLme9iebGmo5HgkyCkUAsk=;
 b=q5IsUoibm7f/UBUJv1L3r8NakTpNbN24r0u+nKFPLAp7F8uwa2pyRDduVrRevQjazj8s
 3HAlu/RIJWNx7t7lAM0Aj6mW9B59ZTu2kqp0e4VOsFyCjKGrwqqTs+P7p0hw9Y4xOWAa
 73MjYyprUi0fh7SwrxrRQdDrnFzzcNGzzWoXmxDTnIRv7WzxSRu7G8UUKVAAhlC6e5bY
 eKc6EJ3vL66Of12XKdjW7aODbOhJioUFmTB93QW029R+F68w8HhpEOhiijNotumafJOG
 N31QtYJUmUL8Vw8E1KvUZTF9rPEWgtHzrBHLnUhKLheXURBiEgDwlnYO+GoqFsgJEJyk hg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9s97r058-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:51:16 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAHpGjh027259;
 Fri, 10 Nov 2023 17:51:16 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9s97r054-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:51:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAGQpBV019248; Fri, 10 Nov 2023 17:51:15 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w24cffp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:51:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AAHpEaf56951158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Nov 2023 17:51:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DB3A58059;
 Fri, 10 Nov 2023 17:51:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A10755805B;
 Fri, 10 Nov 2023 17:51:12 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.66.47]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Nov 2023 17:51:12 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, clg@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] s390x/pci: only limit DMA aperture if vfio DMA limit
 reported
Date: Fri, 10 Nov 2023 12:51:08 -0500
Message-ID: <20231110175108.465851-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110175108.465851-1-mjrosato@linux.ibm.com>
References: <20231110175108.465851-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KL3c1XKLIxGbf6ahZwIm4Gq0Ec6seWr0
X-Proofpoint-ORIG-GUID: YWFyMQYBuHyKXIuLr7egAQc1hzf4iOkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_15,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=848 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100148
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

If the host kernel lacks vfio DMA limit reporting, do not attempt
to shrink the guest DMA aperture.

Fixes: df202e3ff3 ("s390x/pci: shrink DMA aperture to be bound by vfio DMA limit")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-vfio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index e28573b593..7dbbc76823 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -136,7 +136,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
      * to the guest based upon the vfio DMA limit.
      */
     vfio_size = pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
-    if (vfio_size < (cap->end_dma - cap->start_dma + 1)) {
+    if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
         pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
     }
 }
-- 
2.41.0



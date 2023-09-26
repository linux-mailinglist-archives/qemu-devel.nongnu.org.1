Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FB07AEC79
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:21:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql70f-0002EI-0j; Tue, 26 Sep 2023 08:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6zS-0000fm-Vx; Tue, 26 Sep 2023 08:16:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1ql6zR-0001Tv-Dh; Tue, 26 Sep 2023 08:16:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QCBTC1011108; Tue, 26 Sep 2023 12:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eftG2L7HdhlMofi030g3oXGuHxNmPQgqScncE/IsHSo=;
 b=TsYF7v02qRC/QRmLkbwQRCtnJoMARE3OOGXQSht06NEUOucFd0q+StkvUYI4VzAnv9uI
 uj3UI8hmyq1MnkHX/4zcBqry9qt4vxdw2SAOwUOdXsDNPSKtrIFn4Z2Gm1gcWMxdt7aP
 GZxcbz4mp6N2sYuBcab/X9x4IE0wGaLjq1yjnVBFa4V2J4nDCHQ4067SvYQv9TYqekVw
 G2JggcUcyuJVkdIUjiPPhkMynOkVrCt0+Jj7BzNeTJ7hVd+YjiI3xJppP18jEEtGxIOX
 3JiD3RWDIK9xdWFZkd5vCSi2us6j8caSPZouUxA+Qb4g9IgDiJXbbWePQ6nabTZeuNBR JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbpfrmubk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:16:01 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QBkuDb000909;
 Tue, 26 Sep 2023 12:16:00 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbpfrmub4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:16:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QAp0Vg030466; Tue, 26 Sep 2023 12:15:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tad21js7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 12:15:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38QCFump44040696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 12:15:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3F632004B;
 Tue, 26 Sep 2023 12:15:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5917420043;
 Tue, 26 Sep 2023 12:15:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Sep 2023 12:15:56 +0000 (GMT)
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v24 18/21] tests/avocado: s390x cpu topology test dedicated CPU
Date: Tue, 26 Sep 2023 14:15:31 +0200
Message-Id: <20230926121534.406035-19-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926121534.406035-1-nsg@linux.ibm.com>
References: <20230926121534.406035-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WIeT03UX5kT1-y8yMyOUiGEs2DUSTzSF
X-Proofpoint-ORIG-GUID: 13_NkidB9II2Vgi6QByOpmbo2dATk_8s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_08,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=942 adultscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309260104
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

From: Pierre Morel <pmorel@linux.ibm.com>

A dedicated CPU in vertical polarization can only have
a high entitlement.
Let's check this from both host and guest point of view.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 tests/avocado/s390_topology.py | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
index 24fac9a54d..3661048f4c 100644
--- a/tests/avocado/s390_topology.py
+++ b/tests/avocado/s390_topology.py
@@ -305,3 +305,36 @@ def test_entitlement(self):
         self.guest_set_dispatching('0');
         self.check_polarization("horizontal")
         self.check_topology(0, 0, 0, 0, 'high', False)
+
+
+    def test_dedicated(self):
+        """
+        This test verifies that QEMU adjusts the entitlement correctly when a
+        CPU is made dedicated.
+        QEMU retains the entitlement value when horizontal polarization is in effect.
+        For the guest, the field shows the effective value of the entitlement.
+
+        :avocado: tags=arch:s390x
+        :avocado: tags=machine:s390-ccw-virtio
+        """
+        self.kernel_init()
+        self.vm.launch()
+        self.wait_until_booted()
+
+        self.system_init()
+
+        self.check_polarization("horizontal")
+
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 0, 'dedicated': True})
+        self.assertEqual(res['return'], {})
+        self.check_topology(0, 0, 0, 0, 'high', True)
+        self.check_polarization("horizontal")
+
+        self.guest_set_dispatching('1');
+        self.check_topology(0, 0, 0, 0, 'high', True)
+        self.check_polarization("vertical:high")
+
+        self.guest_set_dispatching('0');
+        self.check_topology(0, 0, 0, 0, 'high', True)
+        self.check_polarization("horizontal")
-- 
2.39.2



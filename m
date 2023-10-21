Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8EC7D1FD0
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 23:23:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quJR1-0007xF-SJ; Sat, 21 Oct 2023 17:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quJQz-0007ug-3m; Sat, 21 Oct 2023 17:23:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quJQt-0006PC-Hg; Sat, 21 Oct 2023 17:23:00 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LLEeVs025145; Sat, 21 Oct 2023 21:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=DLg3x7nUZtM/n5hj57h/ikKtd/YP4/mXwH4Ni5F0eIw=;
 b=tRUk0+iflhYd0s1n75tmorRyImJmzwV1QWgZdoAl6ZiAVrBjjeAFse7FKgb3F0NyvzAy
 4owQnMlBKSRuGtChZCsUZWZmxmM1kXbSgDSTiwUd4nZ0zTFlY4NoSKkwm7XxqLloNyvX
 GKKJxxntMMOZEfmX6nmElTW/S4k0bDGWP4mJMZ1ZZ4MPtK2O9jIcqZ1EOd4Eb7HBxi0i
 oNgDaX1eYK2yOQOfm9LkcD3u3krPyW0gl/c9xQKXI7Y7TbxPL5Kn8L6shpADlXANs6ox
 u88noEwcxU20ZznitOj6ASQG5lu8xcwpcJBbquFHTo4qLF+m6iLZqtcr6UjFHqvKQVXU sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvpcq81s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:29 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39LLFH2w027854;
 Sat, 21 Oct 2023 21:17:28 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvpcq81rr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LKPVmw007095; Sat, 21 Oct 2023 21:17:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc27wcat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:27 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39LLHRmg58982718
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Oct 2023 21:17:27 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 584D358052;
 Sat, 21 Oct 2023 21:17:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE06B58065;
 Sat, 21 Oct 2023 21:17:26 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Oct 2023 21:17:26 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v6 10/10] hw/fsi: Update MAINTAINER list
Date: Sat, 21 Oct 2023 16:17:19 -0500
Message-Id: <20231021211720.3571082-11-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021211720.3571082-1-ninad@linux.ibm.com>
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lRpdtGZ8DLDJm4ul_aktClCFGIxujuCq
X-Proofpoint-GUID: d8IEImrCumNC9_8BU8rLUUgJYmw_7tCh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_13,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 mlxlogscore=918 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310210195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
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

Added maintainer for IBM FSI model

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
V4:
  - Added separate commit for MAINTAINER change.

V5:
  - Use * instead of listing all files in dir
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f9912baa0..381923c937 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3476,6 +3476,14 @@ F: tests/qtest/adm1272-test.c
 F: tests/qtest/max34451-test.c
 F: tests/qtest/isl_pmbus_vr-test.c
 
+FSI
+M: Ninad Palsule <ninad@linux.ibm.com>
+S: Maintained
+F: hw/fsi/*
+F: include/hw/fsi/*
+F: docs/specs/fsi.rst
+F: tests/qtest/fsi-test.c
+
 Firmware schema specifications
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Daniel P. Berrange <berrange@redhat.com>
-- 
2.39.2



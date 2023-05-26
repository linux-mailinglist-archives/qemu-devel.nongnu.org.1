Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F40827125F8
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:51:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2VyP-000226-QH; Fri, 26 May 2023 07:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q2VyN-00021b-1q
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:51:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q2VyJ-00089x-QP
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:51:06 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QBNHLF027774; Fri, 26 May 2023 11:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=QSslRd3bhx7Jukzkgn8/3M/h2QNk4OZQIUN5UZnhlNg=;
 b=qbdy+lEvecZ2LmcLIGaRKzX3V+9KklJQkHCbhYxib6aEoDII5rAZyVK0Xihus2W8QmAU
 LSjfuixQxrD9mS4c/JjpjKQu2MJsiN1lRMq3NPxPnQ4EO+m8ByV/IeHCiK0o3GPwl1lQ
 EEzCjSnUdeUxk/jua58OsXyijiwB4mK6KntbiFirKB1Mpz+/aYgZfQR75+IFkRAEmIBf
 5tT/kun8HHM1lORu/sPoz0/fJEmx2OvgsyZznczk/DiMMbGQ48vNsqI13UBbRr9JJOiv
 UrsmflfSC3MyP6rMEeZAF/w6laSeV6FKbWBzkWJYIKoORbIOvswUF1Hp6qpknhslwvS4 xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtuus0jpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:51:02 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QBc4gM004971;
 Fri, 26 May 2023 11:51:01 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtuus0jp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:51:01 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34QAg8FM022312;
 Fri, 26 May 2023 11:50:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qppdk2wmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:50:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34QBouJC42730028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 May 2023 11:50:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17FA920049;
 Fri, 26 May 2023 11:50:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70ED020040;
 Fri, 26 May 2023 11:50:55 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.55.92])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 May 2023 11:50:55 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: "Dominik 'Disconnect3d' Czarnota" <dominik.b.czarnota@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Andreas Arnez <arnez@linux.ibm.com>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 5/6] docs: Document security implications of debugging
Date: Fri, 26 May 2023 13:50:40 +0200
Message-Id: <20230526115041.1362009-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526115041.1362009-1-iii@linux.ibm.com>
References: <20230526115041.1362009-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gNDx3g2T8fuxY8xfawPzfVjJzXjYX1kV
X-Proofpoint-ORIG-GUID: ZASjWOAxtwcQNCpxAeFmgDHTafs8EHpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260099
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Now that the GDB stub explicitly implements reading host files (note
that it was already possible by changing the emulated code to open and
read those files), concerns may arise that it undermines security.

Document the status quo, which is that the users are already
responsible for securing the GDB connection themselves.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 docs/system/gdb.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index 7d3718deefb..9906991b841 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -214,3 +214,18 @@ The memory mode can be checked by sending the following command:
 
 ``maintenance packet Qqemu.PhyMemMode:0``
     This will change it back to normal memory mode.
+
+Security considerations
+=======================
+
+Connecting to the GDB socket allows running arbitrary code inside the guest;
+in case of the TCG emulation, which is not considered a security boundary, this
+also means running arbitrary code on the host. Additionally, when debugging
+qemu-user, it allows directly downloading any file readable by QEMU from the
+host.
+
+The GDB socket is not protected by authentication, authorization or encryption.
+It is therefore a responsibility of the user to make sure that only authorized
+clients can connect to it, e.g., by using a unix socket with proper
+permissions, or by opening a TCP socket only on interfaces that are not
+reachable by potential attackers.
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D098B82E1C9
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 21:24:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPTUg-0002gr-D0; Mon, 15 Jan 2024 15:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rPTUR-0002gK-QB; Mon, 15 Jan 2024 15:23:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rPTUP-0000aI-Lp; Mon, 15 Jan 2024 15:23:23 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40FJjfOI027496; Mon, 15 Jan 2024 20:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=NZeoTCYS6+LdbTI7U80Hv5FzO8i5wJ05zwguOWNB2aA=;
 b=qnJcf/30hhzRRl/U0Q2vQCaX+vFj6ZmspG6dfxSt1YW/SK2W144z0OvO71zTtxKoChRP
 YX4NksRwcFsG3IQtsXbsQlB9QhtwmRcFCMQ3pK07xBs05/O94ysaOld9CtvcS1o4/8BU
 0VzALuCdibkkb6UtU3FdFYR6Jfvi2BUKCVZEe34hejXc7i3Dw8dk9qe6NUswJ5xTRam0
 Y5HneYAPI6A3N+dbnXxDwb4GjfpA/fouCvbfpWgZntstsS1AdhIskn9t1MqkQyICQN+J
 zp2vH1QGwlWvW2RhgaBnKK11SYpXyZj7/3BTpEcewuP9nSyCNt4Pd+L6l7hyW0ijalfe wg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vmr4fscs3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 20:23:15 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40FJulgM018435;
 Mon, 15 Jan 2024 20:23:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vmr4fscrh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 20:23:14 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40FHoTgp018768; Mon, 15 Jan 2024 20:23:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm5unadck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 20:23:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40FKNBt248300362
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jan 2024 20:23:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60F6720049;
 Mon, 15 Jan 2024 20:23:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAE9220040;
 Mon, 15 Jan 2024 20:23:10 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.75.248])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jan 2024 20:23:10 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] target/s390x: Emulate CVDG
Date: Mon, 15 Jan 2024 21:21:02 +0100
Message-ID: <20240115202308.1930675-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5-qba45mmoU3mLFu4BAFfVzXZhKeAo_N
X-Proofpoint-ORIG-GUID: KmN1F5jnNe0icWYs-wi4aZOu3AiMdFrJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_13,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=397 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401150150
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hi,

Ido reported that we are missing the CVDG emulation (which is very
similar to the existing CVD emulation). This series adds it along with
a test.

Best regards,
Ilya


Ilya Leoshkevich (2):
  target/s390x: Emulate CVDG
  tests/tcg/s390x: Test CONVERT TO DECIMAL

 target/s390x/helper.h            |  1 +
 target/s390x/tcg/insn-data.h.inc |  1 +
 target/s390x/tcg/int_helper.c    | 11 ++++++---
 target/s390x/tcg/translate.c     |  8 ++++++
 tests/tcg/s390x/Makefile.target  |  1 +
 tests/tcg/s390x/cvd.c            | 42 ++++++++++++++++++++++++++++++++
 6 files changed, 61 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/s390x/cvd.c

-- 
2.43.0



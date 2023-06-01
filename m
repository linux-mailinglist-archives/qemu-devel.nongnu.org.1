Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A5E719BBC
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:14:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hBm-0005qv-Hb; Thu, 01 Jun 2023 08:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q4hBi-0005kK-Qm; Thu, 01 Jun 2023 08:13:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q4hBd-0006B9-BG; Thu, 01 Jun 2023 08:13:53 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351CCWeD019392; Thu, 1 Jun 2023 12:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=Ti4CLC8hpsu7LqHuh84b9oW4as6ffMLn+LJhsedLbec=;
 b=o1NdDByrjN7taZ+4wkyqBBSa8eDX3IwWwuMi/V6WELb4tcbGWq/VpYEAvDm0Lv6c3/yM
 zTNMAa0tN9/X/lsQfgilJ3WzvIyb+W+RJ+HSENgerMXi+NI2m/ia+XS07RMVALwHQhm/
 nOZyNaCmycL/YHjJSjBcyhnI7uOph7R9aiQUnWeEFKqk1V7GnxRwSkhnDiSk9dBK6xPf
 MKxez2aU9B5puucqauuTXztUncpIO1Ibgpx9UOhom+Aq855QmYwjGcqSR3rFDnQLDQp7
 2peqTPuBqwf6d2gnw6Cx3A33reOy6fWEUV2rgGoP9nagQtWiWGiNhXG61b+EN6QswWjt fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxu4pg0rh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:38 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351CCnVM019687;
 Thu, 1 Jun 2023 12:13:37 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxu4pg0qk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:37 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3516vd4A031862;
 Thu, 1 Jun 2023 12:13:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3qu94ea3b1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 351CDWxK58917132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jun 2023 12:13:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5D582004F;
 Thu,  1 Jun 2023 12:13:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 747292004B;
 Thu,  1 Jun 2023 12:13:31 +0000 (GMT)
Received: from borneo.tlslab.ibm.com (unknown [9.101.4.34])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jun 2023 12:13:31 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] Various xive fixes
Date: Thu,  1 Jun 2023 14:13:26 +0200
Message-Id: <20230601121331.487207-1-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gN40YlRUjlK5oM6fOmz-X1296I-ID9EH
X-Proofpoint-ORIG-GUID: Cvy9Ufmtgs4Q3u2au4Ybbdy8wLx6C8Oi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=518 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

A set of small fixes for the interrupt controller (xive2) on P10.

Change log:
v2:
  split last patch to do a bit of cleanup first
  add Cedric's reviewed-by on the first 3 patches

Frederic Barrat (5):
  pnv/xive2: Add definition for TCTXT Config register
  pnv/xive2: Add definition for the ESB cache configuration register
  pnv/xive2: Allow writes to the Physical Thread Enable registers
  pnv/xive2: Introduce macros to manipulate TIMA addresses
  pnv/xive2: Handle TIMA access through all ports

 hw/intc/pnv_xive2.c        | 20 +++++++++++++++++++-
 hw/intc/pnv_xive2_regs.h   |  8 ++++++++
 hw/intc/xive.c             | 16 ++++++++--------
 include/hw/ppc/xive_regs.h | 16 ++++++++++++++++
 4 files changed, 51 insertions(+), 9 deletions(-)

-- 
2.40.1



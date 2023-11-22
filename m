Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C38967F4186
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 10:25:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5jSr-0008Uh-VA; Wed, 22 Nov 2023 04:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r5jSp-0008Tq-0e; Wed, 22 Nov 2023 04:24:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r5jSn-0005d8-8t; Wed, 22 Nov 2023 04:24:06 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AM8NHrQ005702; Wed, 22 Nov 2023 09:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8eimXwgnNHVm8PjEPv5VFJEuCgQcMOXMe5b5z3AKoMI=;
 b=ULA6A4Up8mCQ8BSGNkO52P0/e4pbJndXYS2PSwNRqbxeCxUIdM0xRsazICuGTPd43Dwl
 TLj1gBDDtBx+S1iBaTyjXkWGFX0CUmYdx2i+uwIgjrWIecQGgqur6hCI9y27ZLmXFTc8
 dDBX8IPzDhNu5EwpKEk2Cp9MEwE7Kh5IaaHwsBP+0XFSkk+9OfDvQ2StRJT6FaWG0NPt
 eOxeHyQgqk9t5SZqz5pdi005YL+vkgjVFr4UGULQS9iaSzgm+9RCramGPWQZYk1Fgv9S
 +37bl/iwpVVW/WQdFbKgoNkZiFwv+03cW5wl935gziWOj0MnV2d8DfXMg+nNggx7Tc9t Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhe371xqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Nov 2023 09:23:46 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AM8P4Y2010421;
 Wed, 22 Nov 2023 09:23:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhe371x4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Nov 2023 09:23:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AM7FjNt029421; Wed, 22 Nov 2023 09:21:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yyq1bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Nov 2023 09:21:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AM9Lco644237548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Nov 2023 09:21:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80D4820043;
 Wed, 22 Nov 2023 09:21:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECD2E20040;
 Wed, 22 Nov 2023 09:21:35 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.43.17.116]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Nov 2023 09:21:35 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org, harshpb@linux.ibm.com
Subject: [PATCH v2 0/2] Introduce SPAPR_NR_IPIS and fix max-cpus
Date: Wed, 22 Nov 2023 14:51:27 +0530
Message-Id: <20231122092129.973712-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z0Mh4zhn3G9wsXWWT-IEmbZ5v_f5s_z6
X-Proofpoint-ORIG-GUID: erpDYoAjpnAdkuGBqF3HygdmgSgl8os1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=617 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220065
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On spapr, the max number of CPU IPIs are 4096 which is accounted during
spapr_irq_init but currently existing macro SPAPR_XIRQ_BASE is being
used to refer to that. Introducing SPAPR_NR_IPIS to refer to the range
of CPU IPIS which is being further used to initialize mc->max_cpus during
spapr_machine_class_init().

Harsh Prateek Bora (2):
  ppc/spapr: Introduce SPAPR_NR_IPIS to refer IRQ range for CPU IPIs.
  ppc/spapr: Initialize max_cpus limit to SPAPR_NR_IPIS.

 hw/ppc/spapr.c             | 9 +++------
 hw/ppc/spapr_irq.c         | 4 ++--
 include/hw/ppc/spapr_irq.h | 1 +
 3 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.39.3



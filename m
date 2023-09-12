Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE92B79D980
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 21:24:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8yP-0005ON-Ev; Tue, 12 Sep 2023 15:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qg8yN-0005MS-5P
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 15:22:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qg8yK-00013E-D7
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 15:22:54 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38CJKifV003442
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 19:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=BOHMt4FiuVixzcbrWXpVpTPWBtUFGQhQK9TqjE+jcz8=;
 b=bUolmG562Yt7GCiEyTE/a6zoxCSWcW2PY3UCX0ptYR+DkND1A+CuX5tgqJ0kkWkt66Jg
 WRYW8+YsvKizna0Qkx/m92ThEYuzx/RNF1jUmxhiHIOyTKLnQhFSt87PXnFcHPfz60SG
 e9DeRy+DKUr/vNElvYmFHzXZHxviXFcfe1KEJd+P9mACH9Ki/zT7t+cDyG9SyovmCgIs
 hGk9jaZ5nFjTMu59IVPQb2Gvp3u1qR+w9mvPk8yHbtJ0SM4lqIzFPzboMWOCrUpgmVRR
 SEwyQS0Oj55KNXZLOgj9FGgyddYUxNoiuUR11I4/LOpB9xeBhFHb631i9okqG/EP8TRf qA== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2x2j01de-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 19:22:50 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38CGxfEQ011974
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 19:22:15 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r1w1yt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 19:22:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38CJMFGp18481826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Sep 2023 19:22:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 374FB58066;
 Tue, 12 Sep 2023 19:22:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FE355804B;
 Tue, 12 Sep 2023 19:22:15 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 12 Sep 2023 19:22:15 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id 3EC8616A07B2;
 Tue, 12 Sep 2023 14:22:14 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 38CJMEsl3330232;
 Tue, 12 Sep 2023 14:22:14 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 0/4] Add BHRB Facility Support
Date: Tue, 12 Sep 2023 14:21:44 -0500
Message-Id: <20230912192144.3330174-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Du_G2lliWL01czyFC0ZtWxN_Y0RFCnwe
X-Proofpoint-ORIG-GUID: Du_G2lliWL01czyFC0ZtWxN_Y0RFCnwe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_18,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=446
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120160
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=mglenn@mamboa4.aus.stglabs.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This is a series of patches for adding support for the Branch History
Rolling Buffer (BHRB) facility.  This was added to the Power ISA
starting with version 2.07.  Changes were subsequently made in version
3.1 to limit BHRB recording to instructions run in problem state only
and to add a control bit to disable recording (MMCRA[BHRBRD]).


Glenn Miles (4):
  target/ppc: Add new hflags to support BHRB
  target/ppc: Add recording of taken branches to BHRB
  target/ppc: Add clrbhrb and mfbhrbe instructions
  target/ppc: Add migration support for BHRB

 target/ppc/cpu.h                       |  24 +++++
 target/ppc/cpu_init.c                  |  45 ++++++++-
 target/ppc/helper.h                    |   5 +
 target/ppc/helper_regs.c               |  44 ++++++++
 target/ppc/helper_regs.h               |   1 +
 target/ppc/machine.c                   |  25 ++++-
 target/ppc/misc_helper.c               |  43 ++++++++
 target/ppc/power8-pmu-regs.c.inc       |   5 +
 target/ppc/power8-pmu.c                |  17 +++-
 target/ppc/power8-pmu.h                |  11 +-
 target/ppc/spr_common.h                |   1 +
 target/ppc/translate.c                 | 133 +++++++++++++++++++++++--
 target/ppc/translate/branch-impl.c.inc |   2 +-
 13 files changed, 337 insertions(+), 19 deletions(-)

-- 
2.31.1



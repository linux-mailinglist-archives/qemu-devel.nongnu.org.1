Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D896BA95D0A
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Apr 2025 06:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u75QA-0004il-Lj; Tue, 22 Apr 2025 00:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u75Q5-0004hq-GX; Tue, 22 Apr 2025 00:39:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u75Q3-0002jk-Mg; Tue, 22 Apr 2025 00:39:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M3bmq1010818;
 Tue, 22 Apr 2025 04:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=UmClCp5AGqpcTU32WoW0ryR32Jjy
 xcbmNVPl6ZEnYws=; b=UWzHUM360bBBreTl44yvYi+ctRspy+yHa075Xs7iu1l7
 CuCiSiz9vXw4jLrL5q4n4nqyLPUXEq1sLsq6hRXx5MNcuZvbNWQVgWawfFnS7T/W
 oOw9bg5n149te8Djs5MXixxJivKRnCfWBJZc7UqbUQZdPGf6e5+ezHUgbG60bpQP
 tedILhOF55x7fidz2FQNfyOHXZ92Qw3cmbnvw7MXDZk79YWNPircTwEGSvT58Wk1
 sc3RSFFVlLOehhs33gcla3F5oYMOnfzmRQTHDlTksvTfT/yu0IRguj++E3A00EEq
 k0rZIOkvGQns0R0AWw+dleikNY1Ei/RrdZo1jjLC2A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4663c40707-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 04:39:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53M4cC3c008766;
 Tue, 22 Apr 2025 04:39:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4663c40704-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 04:39:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M18QIM032530;
 Tue, 22 Apr 2025 04:39:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464phyhf0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 04:39:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53M4dLaC33751760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 04:39:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A074820043;
 Tue, 22 Apr 2025 04:39:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6631820040;
 Tue, 22 Apr 2025 04:39:18 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.215.117])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Apr 2025 04:39:18 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: [PATCH v5 0/2] Deprecate Power8E and Power8NVL
Date: Tue, 22 Apr 2025 10:09:14 +0530
Message-ID: <20250422043916.26321-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 62uZ5esK6JTGHEM24P4QnEt220ZG6zC-
X-Proofpoint-ORIG-GUID: Smtjdf7nBnyYBcb55ER8ThBH3Ek3k-Tm
X-Authority-Analysis: v=2.4 cv=HeEUTjE8 c=1 sm=1 tr=0 ts=68071d7f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=31Clpgyuveq3k6-D5LcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_02,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220033
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Power8E and Power8NVL are not maintained, and not useful to qemu, and
upstream skiboot also has removed support till Power8 DD1.
Power8NVL CPU doesn't boot since skiboot v7.0, or following skiboot commit
to be exact:

    commit c5424f683ee3 ("Remove support for POWER8 DD1")

No direct way to deprecate the pnv chips, a field like deprecation_note
could be added, but felt not needed as the chip will only get used if
the user requests corresponding 8E / 8NVL CPU, which will print
deprecation warning.

Also, no separate pnv machine for 8E and 8NVL, user has to pass --cpu,
which will throw the deprecation warning. So just deprecating CPUs should
be enough.

Changelog
=========
v5:
  + split into 2 patches, defining macro, and deprecating 8e & 8nvl
v4 (https://lore.kernel.org/qemu-devel/20250330211012.2932258-1-adityag@linux.ibm.com/):
  + remove unnecessary 'if'
v3:
  + add 'deprecation_note' argument to the POWERPC_DEPRECATED_CPU macro
v2:
  + add mention to docs/about/deprecated.rst
  + add '(deprecated)' in output of qemu-system-ppc64 --cpu help

Base Commit: a9cd5bc6399a80fcf233ed0fffe6067b731227d8

Aditya Gupta (2):
  target/ppc: Introduce macro for deprecating PowerPC CPUs
  target/ppc: Deprecate Power8E and Power8NVL

 docs/about/deprecated.rst |  9 +++++++++
 target/ppc/cpu-models.c   | 20 +++++++++++++++-----
 target/ppc/cpu_init.c     |  7 ++++++-
 3 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.49.0



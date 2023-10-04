Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4C37B8AEF
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 20:43:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo6pU-0000yv-IR; Wed, 04 Oct 2023 14:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1qo6pR-0000uv-26
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:42:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jejb@linux.ibm.com>)
 id 1qo6pP-0002z8-74
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:42:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 394Id0Xo022740
 for <qemu-devel@nongnu.org>; Wed, 4 Oct 2023 18:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=giddAj9O2eHVUKb4zoWUIMw4B94N9jBosCucbreFlx4=;
 b=jTLaudeATLct9KPI4YWN2LPVOHMcIpJMwGLDiGPky2f7AOIp6gKFe9o6WUV1pbTmtYOS
 ahQN8GpSg5nrVr74Rcna7yPyFWnJUntzGG3z2uBAHLLA7jLjAq+b5JZI4LRoPSzDIHDW
 /FOCO2PcGPWjyNrd2pizq2A+JOwI7uXrjDQZMyk0ksAqG6sXSq6+en8JYgSqFVkVAvtF
 IO/tBdq+WU0w3TKs/20y0APKVvBK3EsLgOCRFdl1YM0yHFRXTJZi1ggrNgi3nryf3vCN
 apxOAnEtwuN/jZ9HldonqJD6RTJdhKcGeuOogQKPCh0cqLuwtNhQ/LgM+Yo/lM1TdBpA XA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thdbhg5xh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 18:42:30 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 394If5Jh028391
 for <qemu-devel@nongnu.org>; Wed, 4 Oct 2023 18:42:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thdbhg5x1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 18:42:29 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 394IVkT3025047; Wed, 4 Oct 2023 18:42:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3texcyjfhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 18:42:28 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 394IgRIW34472568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Oct 2023 18:42:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B11F58065;
 Wed,  4 Oct 2023 18:42:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7678958062;
 Wed,  4 Oct 2023 18:42:26 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.80.55])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Oct 2023 18:42:26 +0000 (GMT)
From: James Bottomley <jejb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 0/2] tpm: add mssim backend
Date: Wed,  4 Oct 2023 14:42:17 -0400
Message-Id: <20231004184219.6594-1-jejb@linux.ibm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oiMv-_CLf6eA7dGsB36Mf2yBlPEjl4Ha
X-Proofpoint-ORIG-GUID: 6Y9i8ySfM5pJpHLrwTxxKZ093teetVos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1
 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=1 spamscore=1
 clxscore=1015 adultscore=0 mlxlogscore=192 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jejb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: James Bottomley <James.Bottomley@HansenPartnership.com>

The requested feedback was to convert the tpmdev handler to being json
based, which requires rethreading all the backends.  The good news is
this reduced quite a bit of code (especially as I converted it to
error_fatal handling as well, which removes the return status
threading).  The bad news is I can't test any of the conversions.
swtpm still isn't building on opensuse and, apparently, passthrough
doesn't like my native TPM because it doesn't allow cancellation.

v3 pulls out more unneeded code in the visitor conversion, makes
migration work on external state preservation of the simulator and
adds documentation

v4 puts back the wrapper options (but doesn't add any for mssim since
it post dates the necessity)

v5 rebases to the latest master branch and adjusts for removed use_FOO ptrs

v5 updates help to exit zero; does some checkpatch tidying

v7 merge review feedback and add acks.

v8 adds better error handling, more code tidies and adds command
   socket disconnection/reconnection (instead of trying to keep the
   socket open the whole time).  This adds overhead, but makes
   debugging guest kernel TPM issues much easier.

James

---

James Bottomley (2):
  tpm: convert tpmdev options processing to new visitor format
  tpm: add backend for mssim

 MAINTAINERS                    |   6 +
 backends/tpm/Kconfig           |   5 +
 backends/tpm/meson.build       |   1 +
 backends/tpm/tpm_emulator.c    |  25 ++-
 backends/tpm/tpm_mssim.c       | 319 +++++++++++++++++++++++++++++++++
 backends/tpm/tpm_mssim.h       |  44 +++++
 backends/tpm/tpm_passthrough.c |  23 +--
 docs/specs/tpm.rst             |  39 ++++
 include/sysemu/tpm.h           |   4 +-
 include/sysemu/tpm_backend.h   |   2 +-
 qapi/tpm.json                  |  49 ++++-
 softmmu/tpm-hmp-cmds.c         |   9 +
 softmmu/tpm.c                  |  91 ++++------
 softmmu/vl.c                   |  19 +-
 14 files changed, 528 insertions(+), 108 deletions(-)
 create mode 100644 backends/tpm/tpm_mssim.c
 create mode 100644 backends/tpm/tpm_mssim.h

-- 
2.35.3



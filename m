Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E95D79E861
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPMR-0000GT-Vm; Wed, 13 Sep 2023 08:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qgPMP-0000Fw-50
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:52:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qgPMM-0002gC-Mj
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:52:48 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38DCiRWL020050; Wed, 13 Sep 2023 12:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=jVCscq/lyrjDydjl3zogHwCbvEwETxgGWRfqOQ+/pbM=;
 b=ZMu9vBihH4pSg4F/LdhpXOTEmhltOCykkNp+alUxb4CT72YdOhdsV0JR3Z77IZxIwugu
 RUil0os8xzY/llQ0TTm3qbUUKOeZ2BfHduHsEo9za4qJS4QNhafb6f+Zszb+aWo5Yi8M
 H+egG5FMjp2g+Ma96osKc6ZCD/QuU/RU8LdFuU9KcUaliqz3YUT9u7fIwbWfFqXxWgC4
 /vHJVUNzw2TQghuRcFwXuLx3zCnirHD8OnCm9KG/Hy+sckaYaxS4NXWrFY2XDc9jrGsP
 DVrpZzWRy+bv79jqjs8t0DCBBYDDEDAa4GiUZGgFXTK+jj8IdlsU7EUDPtPCW9DWsbH/ jA== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3dbq8bm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Sep 2023 12:52:41 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38DCA5BZ011942; Wed, 13 Sep 2023 12:52:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r22kmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Sep 2023 12:52:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38DCqdAI58523964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Sep 2023 12:52:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1096E58068;
 Wed, 13 Sep 2023 12:52:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BE6F58059;
 Wed, 13 Sep 2023 12:52:38 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 13 Sep 2023 12:52:38 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v3 0/1] Merge tpm 2023/09/12 v3
Date: Wed, 13 Sep 2023 08:52:26 -0400
Message-ID: <20230913125227.504709-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ub_-Jrb68UguAJISS-tGhAjBzI7aDvZa
X-Proofpoint-GUID: Ub_-Jrb68UguAJISS-tGhAjBzI7aDvZa
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_06,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=637
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130101
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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

Hello!

  This PR contains a fix for the case where the TPM file descriptor is >= 1024
and the select() call cannot be used. It also avoids unnecessary errors due to
EINTR being returned from the syscall.

Regards,
   Stefan


The following changes since commit 9ef497755afc252fb8e060c9ea6b0987abfd20b6:

  Merge tag 'pull-vfio-20230911' of https://github.com/legoater/qemu into staging (2023-09-11 09:13:08 -0400)

are available in the Git repository at:

  https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2023-09-12-3

for you to fetch changes up to 8e32ddff69b6b4547cc00592ad816484e160817a:

  tpm: fix crash when FD >= 1024 and unnecessary errors due to EINTR (2023-09-13 08:42:57 -0400)

----------------------------------------------------------------

Marc-André Lureau (1):
  tpm: fix crash when FD >= 1024 and unnecessary errors due to EINTR

 backends/tpm/tpm_util.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

-- 
2.41.0



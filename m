Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DAC7E6A50
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:05:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13mf-0004rm-FL; Thu, 09 Nov 2023 07:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r13mO-0004WR-E8; Thu, 09 Nov 2023 07:05:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r13mM-0002WA-6K; Thu, 09 Nov 2023 07:05:00 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9C09CF012126; Thu, 9 Nov 2023 12:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=EdONry6mKOlcDT2qfQjdNBgfxcffoS+ptHGCYZDsBj8=;
 b=PKQ7WJEx7EA3nqiTmztlJ5Xw6aGX6IYhPo897faDP2IVwnHYUKXF17kOwPGnjiViAjVy
 y8ScSaNDQF+8u4hhNUIelgMOcjceHg98L5WeJ6bRc6kTsdECvKBpnNOxR0PM1JWlDdkI
 ND2XRCjlfZ9EKh8uYX2xV21C+tmEext2eLR5Bfd1HCpMEu4A1qBs2P3zeQ+k878dIXA3
 +e+EP67AKX/vSX7uvWZ7iNpg8EjaW5hEc7dxSGCDqpjnm7tfbkm8duKDsOCY5ZVNoqJX
 vfyoaWIi94/hz2pmlUyDloR++WqYHpBY7r2Hywayx3OtNgSHOdNa7izHEnixPrfTD5xU 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8y1x05bs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:04:53 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A9C0fVQ016408;
 Thu, 9 Nov 2023 12:04:53 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8y1x05bg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:04:52 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9BB16J004176; Thu, 9 Nov 2023 12:04:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w213jq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:04:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A9C4opU46989606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Nov 2023 12:04:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86D3C2004B;
 Thu,  9 Nov 2023 12:04:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5852720049;
 Thu,  9 Nov 2023 12:04:50 +0000 (GMT)
Received: from a46lp67.. (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Nov 2023 12:04:50 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 imbrenda@linux.ibm.com
Subject: [PATCH v2 0/3] dump: Arch info function pointer addition and cleanup
Date: Thu,  9 Nov 2023 12:04:40 +0000
Message-Id: <20231109120443.185979-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aIpBwUxr2NTsNFo_7FesmkKnxy1GPg2J
X-Proofpoint-ORIG-GUID: hft1yhuZyKhnlf1ZElpQZkEBFdx1iuwE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=247 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090089
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
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

Small cleanups/fixes to the dump info function pointer assignments as
well as a new function pointer for cleanup of residual state.

This has come up because test managed to dump a s390 PV vm onto a disk
that was too small for the dump. After the dump failed, the vm wasn't
able to resume running since KVM was still in dump mode which blocks
vcpu entry.

The new function pointer allows cleanup of such a situation.

v2:
	- Usage of g_autofree
	- Dropped explicit NULLing of function pointers

Janosch Frank (3):
  target/s390x/dump: Remove unneeded dump info function pointer init
  dump: Add arch cleanup function
  target/s390x/arch_dump: Add arch cleanup function for PV dumps

 dump/dump.c                |  4 ++++
 include/sysemu/dump-arch.h |  1 +
 target/s390x/arch_dump.c   | 21 +++++++++++++++++----
 3 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.34.1



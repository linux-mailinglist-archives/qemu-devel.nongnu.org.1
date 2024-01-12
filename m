Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 337DF82C76A
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:50:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQL9-0001gT-RV; Fri, 12 Jan 2024 17:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOQL7-0001gB-Lm
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:49:25 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOQL5-0006TQ-A5
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:49:25 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CKo55g020392; Fri, 12 Jan 2024 22:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=lfRfFQqd/aIwdOCbmhnMVWHpKX6K35EXCvE4j4LNs5A=;
 b=YPkkYi/0K6QroPdKJc855CUQSZcO5fNRMnOn/nI5TWoMRG5FqDSlvIw+FzwECmdPLx6+
 /XnBaR1ZLLbSSo9dFe78rBWrP7zBZfpmYfadbSTAkCV8Lt/uZlpT6Q596DD+a3mbwmgX
 fz3S4374DTlg5fbNReGTguqT2R9O5BxF72msOjIkaaNGW1G/xFXgSwK4s76X7QWybAEU
 eg01hyMuHEVoq1/4thmH+Mk88WRkk11X798yptT6/XmiSoD4JViezaafCQYMKX9eKTUe
 hQ3pG4esLiPp8yWGOnwUlwt2xQIUCOfhEaWDV0uGmtyuzA4E+BVAd1Zke/mLQsvPDc6b cQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk7gg8sr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 22:49:19 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CLRcGO008835; Fri, 12 Jan 2024 22:49:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfuuqay6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 22:49:19 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CMnIrq004223;
 Fri, 12 Jan 2024 22:49:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfuuqay5t-1; Fri, 12 Jan 2024 22:49:18 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 0/5] string list functions
Date: Fri, 12 Jan 2024 14:49:13 -0800
Message-Id: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_12,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=882
 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120178
X-Proofpoint-GUID: 7yd9TmYFeCVIX7LjwWY_GngacgcmNTVe
X-Proofpoint-ORIG-GUID: 7yd9TmYFeCVIX7LjwWY_GngacgcmNTVe
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add some handy string list functions for general use, and use them in
live migration functions.  These will also be needed for cpr exec mode.

Changes in V4:
  * added exec migration patch

Steve Sistare (5):
  util: strList_from_string
  qapi: QAPI_LIST_LENGTH
  util: strv_from_strList
  util: strList unit tests
  migration: simplify exec migration functions

 include/monitor/hmp.h     |  1 -
 include/qapi/util.h       | 13 ++++++++
 include/qemu/strList.h    | 30 ++++++++++++++++++
 migration/exec.c          | 58 +++++-----------------------------
 monitor/hmp-cmds.c        | 19 -----------
 net/net-hmp-cmds.c        |  3 +-
 stats/stats-hmp-cmds.c    |  3 +-
 tests/unit/meson.build    |  1 +
 tests/unit/test-strList.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++
 util/meson.build          |  1 +
 util/strList.c            | 38 ++++++++++++++++++++++
 11 files changed, 175 insertions(+), 72 deletions(-)
 create mode 100644 include/qemu/strList.h
 create mode 100644 tests/unit/test-strList.c
 create mode 100644 util/strList.c

-- 
1.8.3.1



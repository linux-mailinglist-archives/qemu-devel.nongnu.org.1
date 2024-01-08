Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96787827263
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:12:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrIB-0002nJ-8y; Mon, 08 Jan 2024 10:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rMrI9-0002cp-7C
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:11:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rMrI7-0008Fb-Dw
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:11:52 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 408F5lF7025348; Mon, 8 Jan 2024 15:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=ssNkE2jwL1n+Oc8S03amv9deLHH3x/TAijwSrUwjmak=;
 b=oKYRq0UyfwewU+DbspSmdwkQ/lWjWsGdYgM9exMkgtv+IY1z8QzYxkl3hTNt4910Y+GC
 DRqr8pv5cY1e8ec6uEj7nt1/wb4INu2zdYz+mQ2lfbx+Fm/zFC7bDenKo8WzUFXNx+VE
 hf8YFixndalYj8mjYmpSs4y4JjNOK3RqSrSUJDjVXRca5jWbmB70XXrZ+Wy5PTps/cC2
 Cd2vwOWBuvRoH5vd7r1ah6lY243hvyPOdg1UF30DSqE6iuoYw3MDnM6SNlQP8V6jW9/S
 8Xs9KWI4xBj0ptOAH3fatG8C74Da5CGr496g4izRTYzYnGQMEKssmmMzDwiXnBNdDyVc yQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vgkcx80gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jan 2024 15:11:49 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 408EXZ0p035025; Mon, 8 Jan 2024 15:10:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfuu316dg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jan 2024 15:10:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408FAX6K024665;
 Mon, 8 Jan 2024 15:10:33 GMT
Received: from linux-3.us.oracle.com (dhcp-10-154-155-225.vpn.oracle.com
 [10.154.155.225])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3vfuu316bm-1; Mon, 08 Jan 2024 15:10:33 +0000
From: Mark Kanda <mark.kanda@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, pbonzini@redhat.com, mark.kanda@oracle.com
Subject: [PATCH v1 0/2] Initialize backend memory objects in parallel
Date: Mon,  8 Jan 2024 09:10:39 -0600
Message-Id: <20240108151041.529716-1-mark.kanda@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_06,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=872 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401080130
X-Proofpoint-GUID: 5mtgZUPh-BGxxoNC2imsgYX0gaHKkaEE
X-Proofpoint-ORIG-GUID: 5mtgZUPh-BGxxoNC2imsgYX0gaHKkaEE
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

QEMU initializes preallocated backend memory when parsing the corresponding
objects from the command line. In certain scenarios, such as memory being
preallocated across multiple numa nodes, this approach is not optimal due to
the unnecessary serialization.

This series addresses this issue by initializing the backend memory objects in
parallel.

Mark Kanda (2):
  oslib-posix: refactor memory prealloc threads
  oslib-posix: initialize backend memory objects in parallel

 include/qemu/osdep.h |   6 ++
 system/vl.c          |   2 +
 util/oslib-posix.c   | 150 +++++++++++++++++++++++++++++--------------
 util/oslib-win32.c   |   5 ++
 4 files changed, 116 insertions(+), 47 deletions(-)

-- 
2.39.3



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A36A836856
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:33:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRwHa-0000zR-R2; Mon, 22 Jan 2024 10:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rRwHZ-0000yv-6j
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:32:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rRwHW-0006sK-LR
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 10:32:16 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MAZIhY008784; Mon, 22 Jan 2024 15:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=CtogZbW/Yv3SPXV83lAv8gqCK+w6WrablDx3NebXTs8=;
 b=cgd0usJCxwBoO7tQtN19DAmbgaHeDhPsGeEwyyhLrB2p98Ozfta5GNW8t5tQre323t6D
 wdg0i/Ifwq0w5XuVuwNUf5QYMakn0UDu24eN+9BYiyOtp2LNrCF+xdpPuozYYYuYJ7qu
 uM4ZbnUww6ffIwTLZzPZ2BeFyhdPLA8iCHnBLyvuCP3dL/KjRvHPtt4VEW9jpxLmqSrv
 Z9jHPUy9gyD0czFb5/gBljlaybEV0yHkI84WMvmlFP+m5fkB1uy2Jn3nd+O2/29V9hi3
 +FuUDDOY8guE7QYdICW1QyFrUEEzKFY79BBnThulf6vmT1MBFGh4m3Qh7bWaUdtumUEW 3Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7abuvkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 15:32:08 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40MFVZ51003944; Mon, 22 Jan 2024 15:32:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vs32payqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 15:32:07 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MFRHlL010298;
 Mon, 22 Jan 2024 15:32:06 GMT
Received: from linux-3.us.oracle.com (dhcp-10-154-125-89.vpn.oracle.com
 [10.154.125.89])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3vs32payn2-1; Mon, 22 Jan 2024 15:32:06 +0000
From: Mark Kanda <mark.kanda@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, pbonzini@redhat.com, mark.kanda@oracle.com,
 berrange@redhat.com
Subject: [PATCH v2 0/2] Initialize backend memory objects in parallel
Date: Mon, 22 Jan 2024 09:32:17 -0600
Message-Id: <20240122153219.2885749-1-mark.kanda@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220106
X-Proofpoint-GUID: q2MJ9Ixik72l2unlETelgAxpsTe4M7h_
X-Proofpoint-ORIG-GUID: q2MJ9Ixik72l2unlETelgAxpsTe4M7h_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0a-00069f02.pphosted.com
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

v2:
- require MADV_POPULATE_WRITE (simplify the implementation)
- require prealloc context threads to ensure optimal thread placement
- use machine phase 'initialized' to detremine when to allow parallel init

QEMU initializes preallocated backend memory when parsing the corresponding
objects from the command line. In certain scenarios, such as memory being
preallocated across multiple numa nodes, this approach is not optimal due to
the unnecessary serialization.

This series addresses this issue by initializing the backend memory objects in
parallel.

Mark Kanda (2):
  oslib-posix: refactor memory prealloc threads
  oslib-posix: initialize backend memory objects in parallel

 backends/hostmem.c     |   8 +++-
 hw/virtio/virtio-mem.c |   4 +-
 include/qemu/osdep.h   |  14 +++++-
 system/vl.c            |   6 +++
 util/oslib-posix.c     | 103 ++++++++++++++++++++++++++++-------------
 util/oslib-win32.c     |   8 +++-
 6 files changed, 103 insertions(+), 40 deletions(-)

-- 
2.39.3



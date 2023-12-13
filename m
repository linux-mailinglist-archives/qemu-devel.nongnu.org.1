Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF3E811C05
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 19:12:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDTi0-0000TE-2O; Wed, 13 Dec 2023 13:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDThv-0000N0-D8
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 13:11:43 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDThp-0001eN-QZ
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 13:11:43 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BDEQqV0015965; Wed, 13 Dec 2023 18:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=W4jdaYv1PeFMHXTHswxn6l4oaK6BODUMku8HR6Y2Gr8=;
 b=MNYWdu14rTpeJfAHUaz0soe1/NlHxutD1e/irXkTVtlxK85vCdYnBuryBntqFXPh11M3
 jy59T7dCHK1i20mmBoN5BOWZmA58nSIO0xmjIi//8cRjxdaKKcY7ZWlDux93Fv/XXYop
 UrTlGXM3lIMH9HIaZGNV/gjXazVbDGy1e7ejf4VhV51ZoJrXhu31J84+wBNr2iT3FmIz
 +m3UOafaEv4FOCdTn0Pl8Ia4j6072+tKg6RLkody2OplYVzeRTGF9ROJRZhTQg3Dy8Cs
 4kA0tG3KUViYGuAMIioFNvGIWZRLk3+yosbQ48lM0ZY7mzwUIVv3PFWkF6cE5Pwy0dQZ 1g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwfrrqat2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 18:11:35 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BDI0kbO008345; Wed, 13 Dec 2023 18:11:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uvep8p73s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 18:11:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDIAvtn019890;
 Wed, 13 Dec 2023 18:11:34 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3uvep8p732-1; Wed, 13 Dec 2023 18:11:34 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 0/3] allow cpr-reboot for vfio
Date: Wed, 13 Dec 2023 10:11:30 -0800
Message-Id: <1702491093-383782-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_12,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=790 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130130
X-Proofpoint-GUID: W1EX1xWz6xotJSyssmNH4DKhYldg0ZLm
X-Proofpoint-ORIG-GUID: W1EX1xWz6xotJSyssmNH4DKhYldg0ZLm
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
guest drivers' suspend methods flush outstanding requests and re-initialize
the devices, and thus there is no device state to save and restore.  The
user is responsible for suspending the guest before initiating cpr, such as
by issuing guest-suspend-ram to the qemu guest agent.

This series depends on the series
  [PATCH V8 00/12] fix migration of suspended runstate

Steve Sistare (3):
  migration: check mode in notifiers
  migration: notifier error reporting
  vfio: allow cpr-reboot migration if suspended

 hw/net/virtio-net.c           |  4 ++++
 hw/vfio/common.c              |  2 +-
 hw/vfio/container.c           | 11 ++++++++++-
 hw/vfio/cpr.c                 | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/meson.build           |  1 +
 hw/vfio/migration.c           |  5 ++++-
 include/hw/vfio/vfio-common.h |  4 ++++
 include/migration/misc.h      |  3 ++-
 migration/migration.c         | 31 +++++++++++++++++++++++++++----
 migration/ram.c               |  9 +++++----
 net/vhost-vdpa.c              |  4 ++++
 ui/spice-core.c               |  2 +-
 12 files changed, 105 insertions(+), 13 deletions(-)
 create mode 100644 hw/vfio/cpr.c

-- 
1.8.3.1



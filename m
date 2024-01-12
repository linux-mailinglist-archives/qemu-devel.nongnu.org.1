Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 530EF82C292
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:11:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJB6-0002qr-W8; Fri, 12 Jan 2024 10:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJAv-0002f7-J5
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:10:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJAm-0006dD-Lf
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:10:19 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CEXrYV024855; Fri, 12 Jan 2024 15:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=Lk+on/K22LrNPJ/blBMASNbIsn1D6LneOFg6OuH7yho=;
 b=RgyHfRAi4TzwPDlKBUGzAoqoY84Jn063KOLwJZOSmWSHFv9aRByemwZY2tyKSip7Miwx
 oodShSQY0W7eoOn6zUtI0qmkyK4tAJ3FvgWzARuBCphEzyeVciJVAxp8wyU4grybYKpi
 leZs4DZmgoRkHEmO8wuA2dRSKd5j5RFCt1Uw0CRQvIujT6Oj8l2BLN+j8dOppmcG7Vym
 IXx/yEYTpK5wsQDL7y/I1JgsdpnximJftHNVUbSoE3WyypBOABnLlLirjYTM7KmWtIMX
 3kQKYGPAvKRkSLDVqml5oBEtTgrWX/Opr0hE/jUqujuaRKLbRhAqBb6qE99MyQ4TSIUU 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk68306r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:10:13 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CEob2r013671; Fri, 12 Jan 2024 15:05:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfurgd8ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:11 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CF5Bo6017833;
 Fri, 12 Jan 2024 15:05:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfurgd8k6-1; Fri, 12 Jan 2024 15:05:11 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 00/11] allow cpr-reboot for vfio
Date: Fri, 12 Jan 2024 07:04:59 -0800
Message-Id: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_06,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=806 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120117
X-Proofpoint-GUID: tldYC3_OxhNC27tc7nVIk6y_cTanSgu_
X-Proofpoint-ORIG-GUID: tldYC3_OxhNC27tc7nVIk6y_cTanSgu_
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
guest drivers' suspend methods flush outstanding requests and re-initialize
the devices, and thus there is no device state to save and restore.  The
user is responsible for suspending the guest before initiating cpr, such as
by issuing guest-suspend-ram to the qemu guest agent.

Most of the patches in this series enhance migration notifiers so they can
return an error status and message.  The last two patches register a notifier
for vfio that returns an error if the guest is not suspended.

Steve Sistare (11):
  notify: pass error to notifier with return
  migration: remove error from notifier data
  migration: convert to NotifierWithReturn
  migration: remove migration_in_postcopy parameter
  migration: MigrationEvent for notifiers
  migration: MigrationNotifyFunc
  migration: per-mode notifiers
  migration: refactor migrate_fd_connect failures
  migration: notifier error checking
  vfio: register container for cpr
  vfio: allow cpr-reboot migration if suspended

 hw/net/virtio-net.c            |  14 ++---
 hw/vfio/common.c               |   2 +-
 hw/vfio/container.c            |  11 +++-
 hw/vfio/cpr.c                  |  39 ++++++++++++++
 hw/vfio/meson.build            |   1 +
 hw/vfio/migration.c            |  13 +++--
 hw/virtio/vhost-user.c         |  10 ++--
 hw/virtio/virtio-balloon.c     |   3 +-
 include/hw/vfio/vfio-common.h  |   6 ++-
 include/hw/virtio/virtio-net.h |   2 +-
 include/migration/misc.h       |  21 +++++---
 include/qemu/notify.h          |   7 ++-
 migration/migration.c          | 117 +++++++++++++++++++++++++++--------------
 migration/postcopy-ram.c       |   3 +-
 migration/postcopy-ram.h       |   1 -
 migration/ram.c                |  12 ++---
 net/vhost-vdpa.c               |  15 +++---
 ui/spice-core.c                |  19 +++----
 util/notify.c                  |   5 +-
 19 files changed, 206 insertions(+), 95 deletions(-)
 create mode 100644 hw/vfio/cpr.c

-- 
1.8.3.1



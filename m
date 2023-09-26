Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C91C7AF66A
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 00:42:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlGk6-0005x1-Pt; Tue, 26 Sep 2023 18:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qlGk4-0005vw-FA
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 18:41:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qlGk2-0005TB-Kp
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 18:41:20 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QLTUus020286; Tue, 26 Sep 2023 22:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=bLr9RoR/GNe5Thg/TPYMj7EcQNrsEq88LzExDfkBby4=;
 b=4AIbn2rsd9tSGmMFbCZ0JIQC9pkGKZnbCqwu37a6bOSVZCITbTsFuUvjRgUl01cXciLB
 kjFkT0DsgPdQakz/UldnZAbiLkqdMo8Kbz8DHx1uQECrCQBNJQwc8iSblqCqdjKVvaP3
 N2g2+KXBqUf1J4lXzszfAXcNxEV/ompPnxVuuWTlmpZ0eiBz2/+O57zI0T6zYj7PB3AN
 EWCaeX7QZZr0QhE0E5HmtxCPbFqPss6WnM72CKwryHvRXNxyfZLqeEXRCqZBBGE6v/6v
 BADgLWzv3j/0380TJ2nGMMS+ZeZMnZMbwP+AqUDbfUz2/qbwcxo8TcP8QVDWkLemEkid SQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmug28c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 22:41:13 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38QKvGu8003238; Tue, 26 Sep 2023 22:41:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t9pf74c7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 22:41:12 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QMfBNl022981;
 Tue, 26 Sep 2023 22:41:11 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-186-167.vpn.oracle.com
 [10.65.186.167])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3t9pf74c6n-1; Tue, 26 Sep 2023 22:41:11 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, jonah.palmer@oracle.com
Subject: [PATCH RESEND v5 0/3] qmp,
 vhost-user: Remove virtio_list & update virtio introspection
Date: Tue, 26 Sep 2023 18:41:04 -0400
Message-Id: <20230926224107.2951144-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_15,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260194
X-Proofpoint-GUID: IDszks0sJsUvqsJaXRgsJ59t18mC1hqc
X-Proofpoint-ORIG-GUID: IDszks0sJsUvqsJaXRgsJ59t18mC1hqc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These patches update a few things related to virtio introspection via.
QMP/HMP commands.

1. Remove 'virtio_list' and instead query the QOM composition tree to
find any active & realized virtio devices.

The 'virtio_list' was duplicating information about virtio devices that
was already available in the QOM composition tree, so there was no need
to keep this list.

2. Add new transport, protocol, and device features as well as support
to introspect vhost-user-gpio devices.

Vhost-user-gpio previously had no support for introspection. Support for
introspecting its vhost-user device is now available in these patches.

3. Move VhostUserProtocolFeature definition to its corresponding header
file (vhost-user.h). Cleanup previous definitions in other files.

VhostUserProtocolFeature was being defined in 3 separate files. Instead
of 3 separate definitions, use one instead and add it to the
vhost-user.h header file.

New vhost-user protocol feature:
--------------------------------
 - VHOST_USER_PROTOCOL_F_STATUS

New virtio device features:
---------------------------
virtio-blk:
 - VIRTIO_BLK_F_SECURE_ERASE

virtio-net:
 - VIRTIO_NET_F_NOTF_COAL
 - VIRTIO_NET_F_GUEST_USO4
 - VIRTIO_NET_F_GUEST_USO6
 - VIRTIO_NET_F_HOST_USO

virtio/vhost-user-gpio:
 - VIRTIO_GPIO_F_IRQ
 - VHOST_USER_F_PROTOCOL_FEATURES

v5: call object_get_canonical_path to avoid duplicating & freeing
    intermediate 'path' variable
    Add missing Reviewed-by's to patches

v4: use 'g_autofree char *' instead of 'gchar *'
    remove unneeded object unreferences ('object_unref')
    remove 'VHOST_F_LOG_ALL' in virtio-gpio feature map
    remove 'VIRTIO_F_RING_RESET' in transport feature map (already
    exists)

v3: use recursion and type casting to find realized virtio devices
    remove virtio scmi & bluetooth feature mappings
    revert virtio scmi & bluetooth case changes in qmp_decode_features
    change config define for VIRTIO_GPIO to CONFIG_VHOST_USER_GPIO
    move VhostUserProtocolFeature definition to header file

v2: verify virtio devices via. 'TYPE_VIRTIO_DEVICES'
    verify path is a virtio device before checking if it's realized
    remove 'VIRTIO_BLK_F_ZONED' update (already exists)
    add cover letter

Jonah Palmer (3):
  qmp: remove virtio_list, search QOM tree instead
  qmp: update virtio feature maps, vhost-user-gpio introspection
  vhost-user: move VhostUserProtocolFeature definition to header file

 hw/scsi/vhost-user-scsi.c      |   4 -
 hw/virtio/vhost-user-gpio.c    |   7 ++
 hw/virtio/vhost-user.c         |  21 -----
 hw/virtio/virtio-qmp.c         | 139 +++++++++++++++------------------
 hw/virtio/virtio-qmp.h         |   7 --
 hw/virtio/virtio.c             |   6 --
 include/hw/virtio/vhost-user.h |  21 +++++
 7 files changed, 90 insertions(+), 115 deletions(-)

-- 
2.39.3



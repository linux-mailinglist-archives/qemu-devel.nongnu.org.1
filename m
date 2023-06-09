Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E09729EFC
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:46:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7c32-00070z-96; Fri, 09 Jun 2023 09:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1q7c2x-00070G-Uh
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:20:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1q7c2w-0000T8-80
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:20:55 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3598jalJ014650; Fri, 9 Jun 2023 13:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=PIYJzpAbTw6K1GskF9tYWRP/tqTOnBRveWiKpM6ilQY=;
 b=NZoh2rL6fcaNRTnjsKMjxFB8F2IGwb4Z1xDFzHCwl1ecPsVPeHK6g4tRS2e/d3ptl6J7
 rOnovhXyTj1jtbGnsJiMg1SQ5ule8oS0v7A7azUnv5y6A+kRFLvD5pD0tcHVO/CNJb3l
 tJPWiLq8/BaW7HmaRvZjX9zZd4Y9qacDxNMbMQMjIfGaiO/dPjMEDxZCCM8ViyXAFRaZ
 Gx2uUDe+J7/PPrc6RnWEgUsyCS1PVrIaXJzMzeo3zkZHOfD86hXv5m7uZqPbuW/Cx260
 nNPP+R+skm51LsJmSEHjZq96an6RNsHVJzIakHebmw2Nf9Z4s6GyPKEFJ11T7CQ38KBz Ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u6esy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 Jun 2023 13:20:46 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 359Bd1n9015759; Fri, 9 Jun 2023 13:20:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6pdh89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 Jun 2023 13:20:45 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359DK5Y7035303;
 Fri, 9 Jun 2023 13:20:44 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-219-26.vpn.oracle.com
 [10.39.219.26])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3r2a6pdh62-1; Fri, 09 Jun 2023 13:20:44 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: [PATCH v2 0/2] qmp: Remove virtio_list & update virtio introspection
Date: Fri,  9 Jun 2023 09:20:38 -0400
Message-Id: <20230609132040.2180710-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_09,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=967 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090113
X-Proofpoint-GUID: i4mDd7eH5VX25oULxxPqgCxT1yu66X2_
X-Proofpoint-ORIG-GUID: i4mDd7eH5VX25oULxxPqgCxT1yu66X2_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

New virtio transport feature:
-----------------------------
 - VIRTIO_F_RING_RESET

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
 - VHOST_F_LOG_ALL
 - VHOST_USER_F_PROTOCOL_FEATURES

virtio-bt:
 - VIRTIO_BT_F_VND_HCI
 - VIRTIO_BT_F_MSFT_EXT
 - VIRTIO_BT_F_AOSP_EXT
 - VIRTIO_BT_F_CONFIG_V2

virtio-scmi:
 - VIRTIO_SCMI_F_P2A_CHANNELS
 - VIRTIO_SCMI_F_SHARED_MEMORY

v2: verify virtio devices via. 'TYPE_VIRTIO_DEVICES'
    verify path is a virtio device before checking if it's realized
    remove 'VIRTIO_BLK_F_ZONED' update (already exists)
    add cover letter

Jonah Palmer (2):
  qmp: remove virtio_list, search QOM tree instead
  qmp: update virtio feature maps, vhost-user-gpio instrospection

 hw/virtio/vhost-user-gpio.c |   7 ++
 hw/virtio/virtio-qmp.c      | 207 +++++++++++++++++++++++++++---------
 hw/virtio/virtio-qmp.h      |   8 +-
 hw/virtio/virtio.c          |   6 --
 4 files changed, 165 insertions(+), 63 deletions(-)

-- 
2.39.3



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9FD78C3CC
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 14:08:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaxVO-00044k-JG; Tue, 29 Aug 2023 08:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qaxVG-0003uE-92
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 08:07:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qaxV8-0004DH-Mt
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 08:07:25 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37T6hstE012647; Tue, 29 Aug 2023 12:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=xm8Bcc74iEyINkHmoN1x+YVBZ5gBovd2PwvUsLJ2Wc4=;
 b=Vqi9uj7qUCnUN3TnCipMkQagKzleSuIvMUa3cXaX+fF5arth8A3f2H07ni4LOcnHrR9E
 sH7NazkasH5BIM6MX2+9FKdll9dapBeKgLbJYQ8kVmUhYVlHGwC2KjZGrnkJiqvFneaV
 Gf4teHBubSvX2m5zCmxX8+l+YOApm1EB2rsvQihnf9o9ySpuHRZAYcsnPJCvRnhuCdAL
 JDxZXA+T+5Msw5ueEkuulTMVFeRpcytl9vzHnHG6B3O3XBm6JZ/s9Ppsl+opzA97Xn84
 DZDZNagz3lTvdn57cBkpS7+BZuHQTbOlRdZpJUyjvolHM9bFw2LUjXKC7hs7fvEWY8QF vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcmsp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 12:07:12 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37TB3r7Y023529; Tue, 29 Aug 2023 12:07:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6hn009w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 12:07:11 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TC7AIl030216;
 Tue, 29 Aug 2023 12:07:10 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-179-243.vpn.oracle.com
 [10.65.179.243])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3sr6hn008y-1; Tue, 29 Aug 2023 12:07:10 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: [PATCH v5 0/3] qmp,
 vhost-user: Remove virtio_list & update virtio introspection
Date: Tue, 29 Aug 2023 08:07:04 -0400
Message-Id: <20230829120707.1809548-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_09,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290105
X-Proofpoint-ORIG-GUID: QXfYXY-uj8jdIlWEg2tKN_YINUDZXryW
X-Proofpoint-GUID: QXfYXY-uj8jdIlWEg2tKN_YINUDZXryW
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



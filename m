Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5626B809092
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 19:51:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJRz-0003Tb-T0; Thu, 07 Dec 2023 13:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJRy-0003TG-21
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:18 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rBJRv-0006D3-VL
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 13:50:17 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7IhZje029893; Thu, 7 Dec 2023 18:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=MKOWlhm6UqHOt197xD6ijGx3oIecLjP2I8lyiv4gMpc=;
 b=JfGgf31lycpp6uovfiMEbsg4QdIsnt47GG1cl+sOjjNdDfv6vEd2kb6c9ToVKYfhwKjj
 PkS21+Fo4MuCdpLmNuanIkWApumMXezKmJuKxvajnf+iWKP1C1HwFOPEYR+L8TapotN6
 aeC+BRZd4ZK3pYi05Ogo5p6DR5TXvABdXg0M1SkC4k85VBgGKWiMGVuM31t1B6IlmtJD
 4id+za2rj4VKOFNs6fCKn4wpWp0D89cKfKqsAQXffdb8ej7XlGKVFc6i4t6ZV/+QD379
 n4nq8Ys7bz4667JGA57uKkcvwVApFfR0jp/K3UAAZDDpG8kTudqZvWeZ3OXEGhadwbuA yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd1gcshb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:11 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B7HPF5R039562; Thu, 7 Dec 2023 18:50:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan7vh3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Dec 2023 18:50:10 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7Io9xq008067;
 Thu, 7 Dec 2023 18:50:09 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3utan7vh2k-1; Thu, 07 Dec 2023 18:50:09 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, yin31149@gmail.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 00/40] vdpa-net: improve migration downtime through descriptor
 ASID and persistent IOTLB
Date: Thu,  7 Dec 2023 09:39:13 -0800
Message-Id: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070156
X-Proofpoint-ORIG-GUID: B_l6WqMD2XV7fEOIsYFnXArSJSCOTLOZ
X-Proofpoint-GUID: B_l6WqMD2XV7fEOIsYFnXArSJSCOTLOZ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
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

This patch series contain several enhancements to SVQ live migration downtime
for vDPA-net hardware device, specifically on mlx5_vdpa. Currently it is based
off of Eugenio's RFC v2 .load_setup series [1] to utilize the shared facility
and reduce frictions in merging or duplicating code if at all possible.

It's stacked up in particular order as below, as the optimization for one on
the top has to depend on others on the bottom. Here's a breakdown for what
each part does respectively:

Patch #  |          Feature / optimization
---------V-------------------------------------------------------------------
35 - 40  | trace events
34       | migrate_cancel bug fix
21 - 33  | (Un)map batching at stop-n-copy to further optimize LM down time
11 - 20  | persistent IOTLB [3] to improve LM down time
02 - 10  | SVQ descriptor ASID [2] to optimize SVQ switching
01       | dependent linux headers
         V 

Let's first define 2 sources of downtime that this work is concerned with:

* SVQ switching downtime (Downtime #1): downtime at the start of migration.
  Time spent on teardown and setup for SVQ mode switching, and this downtime
  is regarded as the maxium time for an individual vdpa-net device.
  No memory transfer is involved during SVQ switching, hence no .

* LM downtime (Downtime #2): aggregated downtime for all vdpa-net devices on
  resource teardown and setup in the last stop-n-copy phase on source host.

With each part of the optimizations applied bottom up, the effective outcome
in terms of down time (in seconds) performance can be observed in this table:


                    |    Downtime #1    |    Downtime #2
--------------------+-------------------+-------------------
Baseline QEMU       |     20s ~ 30s     |        20s
                    |                   |
Iterative map       |                   |
at destination[1]   |        5s         |        20s
                    |                   |
SVQ descriptor      |                   |
    ASID [2]        |        2s         |         5s
                    |                   |
                    |                   |
persistent IOTLB    |        2s         |         2s
      [3]           |                   |
                    |                   |
(Un)map batching    |                   |
at stop-n-copy      |      1.7s         |       1.5s 
before switchover   |                   |

(VM config: 128GB mem, 2 mlx5_vdpa devices, each w/ 4 data vqs)

Please find the details regarding each enhancement on the commit log.

Thanks,
-Siwei


[1] [RFC PATCH v2 00/10] Map memory at destination .load_setup in vDPA-net migration
https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg05711.html
[2] VHOST_BACKEND_F_DESC_ASID
https://lore.kernel.org/virtualization/20231018171456.1624030-2-dtatulea@nvidia.com/
[3] VHOST_BACKEND_F_IOTLB_PERSIST
https://lore.kernel.org/virtualization/1698304480-18463-1-git-send-email-si-wei.liu@oracle.com/

---

Si-Wei Liu (40):
  linux-headers: add vhost_types.h and vhost.h
  vdpa: add vhost_vdpa_get_vring_desc_group
  vdpa: probe descriptor group index for data vqs
  vdpa: piggyback desc_group index when probing isolated cvq
  vdpa: populate desc_group from net_vhost_vdpa_init
  vhost: make svq work with gpa without iova translation
  vdpa: move around vhost_vdpa_set_address_space_id
  vdpa: add back vhost_vdpa_net_first_nc_vdpa
  vdpa: no repeat setting shadow_data
  vdpa: assign svq descriptors a separate ASID when possible
  vdpa: factor out vhost_vdpa_last_dev
  vdpa: check map_thread_enabled before join maps thread
  vdpa: ref counting VhostVDPAShared
  vdpa: convert iova_tree to ref count based
  vdpa: add svq_switching and flush_map to header
  vdpa: indicate SVQ switching via flag
  vdpa: judge if map can be kept across reset
  vdpa: unregister listener on last dev cleanup
  vdpa: should avoid map flushing with persistent iotlb
  vdpa: avoid mapping flush across reset
  vdpa: vhost_vdpa_dma_batch_end_once rename
  vdpa: factor out vhost_vdpa_map_batch_begin
  vdpa: vhost_vdpa_dma_batch_begin_once rename
  vdpa: factor out vhost_vdpa_dma_batch_end
  vdpa: add asid to dma_batch_once API
  vdpa: return int for dma_batch_once API
  vdpa: add asid to all dma_batch call sites
  vdpa: support iotlb_batch_asid
  vdpa: expose API vhost_vdpa_dma_batch_once
  vdpa: batch map/unmap op per svq pair basis
  vdpa: batch map and unmap around cvq svq start/stop
  vdpa: factor out vhost_vdpa_net_get_nc_vdpa
  vdpa: batch multiple dma_unmap to a single call for vm stop
  vdpa: fix network breakage after cancelling migration
  vdpa: add vhost_vdpa_set_address_space_id trace
  vdpa: add vhost_vdpa_get_vring_base trace for svq mode
  vdpa: add vhost_vdpa_set_dev_vring_base trace for svq mode
  vdpa: add trace events for eval_flush
  vdpa: add trace events for vhost_vdpa_net_load_cmd
  vdpa: add trace event for vhost_vdpa_net_load_mq

 hw/virtio/trace-events                       |   9 +-
 hw/virtio/vhost-shadow-virtqueue.c           |  35 ++-
 hw/virtio/vhost-vdpa.c                       | 156 +++++++---
 include/hw/virtio/vhost-vdpa.h               |  16 +
 include/standard-headers/linux/vhost_types.h |  13 +
 linux-headers/linux/vhost.h                  |   9 +
 net/trace-events                             |   8 +
 net/vhost-vdpa.c                             | 434 ++++++++++++++++++++++-----
 8 files changed, 558 insertions(+), 122 deletions(-)

-- 
1.8.3.1



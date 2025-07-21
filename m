Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E8BB0C99E
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Jul 2025 19:24:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uduE9-0006KL-PC; Mon, 21 Jul 2025 13:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1uduE3-00069t-9o
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 13:22:55 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1uduDz-0001K4-OF
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 13:22:54 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bm6cr4XCcz6D9Bg;
 Tue, 22 Jul 2025 01:21:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 52D9214033C;
 Tue, 22 Jul 2025 01:22:39 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.155.20) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Jul 2025 19:22:38 +0200
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <jonathan.cameron@huawei.com>, <fan.ni@samsung.com>, <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH qemu v4 0/7] hw/cxl: Update CXL events to rev3.2 and add
 maintenance support for memory repair features 
Date: Mon, 21 Jul 2025 18:22:21 +0100
Message-ID: <20250721172228.2118-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.155.20]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500007.china.huawei.com (7.182.85.172)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  <shiju.jose@huawei.com>
From: shiju.jose--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

Add updates for the CXL spec rev3.2 changes, in the CXL events reporting
and QMP command to inject CXL events.

Add maintenance support and emulation support for memory Post Package
Repair(PPR) and memory sparing control features.

Add support for reporting the memory sparing event record.

Changes
=======
v3 -> v4:
1. Took patches applied by Jonathan to recent tag 'cxl-2025-07-03'.
2. Add few more improvements to maintenance PPR[ patch 6] and sparing
   [patch 7] feature patches.

v2 -> v3:
1. Changes for the feedback from Jonathan on v2.
   https://lore.kernel.org/all/20250619151619.1695-1-shiju.jose@huawei.com/
  1.1. https://lore.kernel.org/all/20250620150342.000055aa@huawei.com/
    - Wrap this is sub 70 and should aim for about 75 for commit descriptions.
    - hdr->ld_id = ld_id; to stw_le_p(&hdr->ld_id, ld_id); in cxl_assign_event_header()
    - Make maint_class, maint_subclass, ld_id and head_id as optional parameters in QMP for
      relevant events
    - In QMP rename maint-class to maint-op-class, maint_subclass to maint-op-subclass
      In functions, rename parameters, class to maint_op_class, subclass to maint_op_subclass etc.  
  1.2. https://lore.kernel.org/all/20250620151314.0000535c@huawei.com/ 
    - Make cme-ev-flags and cme-count for general media events as optional parameters in the QMP.
    - Make cme-ev-flags and cvme-count for DRAM event as optional parameters in the QMP.
  1.3. https://lore.kernel.org/all/20250620151655.00001cea@huawei.com/
    - Add variable declarations at start of the local scope.
  1.4. https://lore.kernel.org/all/20250620154052.00002a17@huawei.com/
    - Adjust indent style  in few places.
    - Add support for produce a Memory Sparing Event Record and enabled for
      ppr maintenance request.
    - Replaced hard coded values in few switch-cases with macro definition in few places.
    - Replaced CXL_MBOX_UNSUPPORTED with CXL_MBOX_INVALID_INPUT.
  1.5. https://lore.kernel.org/all/20250620154813.00002bbd@huawei.com/
    - Add support for memory sparing resource availability.
    - LOG_UNIMP logs for sparing maint op removed.
    - Replaced CXL_MBOX_UNSUPPORTED with CXL_MBOX_INVALID_INPUT.
               
v1 -> v2:
1. QMP CXL event injection code has updated for the following
   change in CXL spec r3.2 Table 8-55. Common Event Record Format,
   field: Event Record Flags. Length of this field has changed
   from 2 bytes to 3 bytes. 
2. Rebase to recent tag 'cxl-2025-06-10'.

Davidlohr Bueso (1):
  hw/cxl: Add Maintenance support

Shiju Jose (6):
  hw/cxl/events: Update for rev3.2 common event record format
  hw/cxl/events: Updates for rev3.2 general media event record
  hw/cxl/events: Updates for rev3.2 DRAM event record
  hw/cxl/events: Updates for rev3.2 memory module event record
  hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
    attributes in cmd_features_set_feature()
  hw/cxl: Add emulation for memory sparing control feature

 hw/cxl/cxl-events.c         |   3 +-
 hw/cxl/cxl-mailbox-utils.c  | 579 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 266 ++++++++++++++++-
 hw/mem/cxl_type3_stubs.c    |  41 ++-
 include/hw/cxl/cxl_device.h | 142 ++++++++-
 include/hw/cxl/cxl_events.h |  85 +++++-
 qapi/cxl.json               | 106 ++++++-
 7 files changed, 1180 insertions(+), 42 deletions(-)

-- 
2.43.0



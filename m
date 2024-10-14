Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B51E999C9F0
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Oct 2024 14:20:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0K2a-0003Hd-92; Mon, 14 Oct 2024 08:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t0K2X-0003HB-1p
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:19:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t0K2V-0001Qx-2k
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:19:08 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRx4D3H6gz6LDTn;
 Mon, 14 Oct 2024 20:14:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id C1CA6140445;
 Mon, 14 Oct 2024 20:19:03 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 14:19:03 +0200
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dmitry Frolov <frolov@swemel.ru>, Ajay Joshi <ajay.opensrc@micron.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Fan Ni <fan.ni@samsung.com>, Shiju Jose
 <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH 0/7] hw/cxl: Round up of fixes.
Date: Mon, 14 Oct 2024 13:18:55 +0100
Message-ID: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

A mixed bag of fixes that have all been on the list already with the
exception of:
"hw/pci-bridge: Make pxb_dev_realize_common() return if it succeeded"
(so that's the one that needs more eyes).

I've tweaked the others to fix typos and correct Fixes tags (adding
them where missing and fixing formatting), but they are fundamentally
the same that has been reviewed on list.

Ajay Joshi (1):
  hw/cxl: Fix background completion percentage calculation

Dmitry Frolov (1):
  hw/cxl: Fix uint32 overflow cxl-mailbox-utils.c

Fan Ni (1):
  hw/mem/cxl_type3: Fix More flag setting for dynamic capacity event
    records

Jonathan Cameron (2):
  hw/cxl: Fix indent of structure member
  hw/pci-bridge: Make pxb_dev_realize_common() return if it succeeded

Shiju Jose (1):
  hw/cxl/cxl-mailbox-utils: Fix for device DDR5 ECS control feature
    tables

Yao Xingtao (1):
  mem/cxl_type3: Fix overlapping region validation error

 include/hw/cxl/cxl_device.h         | 36 ++++++++++++++++++-----------
 hw/cxl/cxl-mailbox-utils.c          | 31 +++++++++++--------------
 hw/mem/cxl_type3.c                  | 15 +++++-------
 hw/pci-bridge/pci_expander_bridge.c | 13 +++++++----
 4 files changed, 49 insertions(+), 46 deletions(-)

-- 
2.43.0



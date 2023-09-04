Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6110791BC4
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:48:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCjL-0006d8-CR; Mon, 04 Sep 2023 12:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qdCjI-0006cU-9R
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:47:12 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qdCjE-0007mh-WC
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:47:12 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfZKw4V4fz6K6ms;
 Tue,  5 Sep 2023 00:47:00 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 17:47:04 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <linuxarm@huawei.com>
Subject: [PATCH 0/2] hw/cxl: Support emulating 4 HDM decoders throughout
 topology
Date: Mon, 4 Sep 2023 17:47:02 +0100
Message-ID: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

For initial CXL emulation / kernel driver bring up a single Host-managed
Device Memory (HDM) decoder instance was sufficient as it let us test the
basic region creation code etc. More complex testing appropriate today
requires a more realistic configuration with multiple decoders.

The Linux kernel will use separate decoders for each memory type (and
shortly per DCD region) and for each interleave set within a memory type
or DCD region. 4 decoders are sufficient for most test cases today but
we may need to grow these further in future.

This patch set already allowed us to identify one kernel bug which is
now fixed.
https://lore.kernel.org/linux-cxl/168696507968.3590522.14484000711718573626.stgit@dwillia2-xfh.jf.intel.com/

Note that, whilst I'm proposing this series for upstream (based on
priorities of what we have out of tree) it hasn't previously been posted
so needs review. (I failed to send it out previously)

Based on: [PATCH 0/4] hw/cxl: Minor CXL emulation fixes and cleanup
Based on: [PATCH v2 0/3] hw/cxl: Add dummy ACPI QTG DSM

Based on: Message ID: 20230904132806.6094-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230904161847.18468-1-Jonathan.Cameron@huawei.com

Jonathan Cameron (2):
  hw/cxl: Add utility functions decoder interleave ways and target
    count.
  hw/cxl: Support 4 HDM decoders at all levels of topology

 include/hw/cxl/cxl_component.h | 21 ++++++++
 hw/cxl/cxl-component-utils.c   | 43 +++++++++++----
 hw/cxl/cxl-host.c              | 65 +++++++++++++++--------
 hw/mem/cxl_type3.c             | 97 +++++++++++++++++++++++-----------
 4 files changed, 164 insertions(+), 62 deletions(-)

-- 
2.39.2



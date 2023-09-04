Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E188791B62
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:19:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCI8-0003ls-FT; Mon, 04 Sep 2023 12:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qdCHw-0003kC-TX
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:19:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qdCHr-0000Qu-WB
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:18:56 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfYgt6jXfz67Nsw;
 Tue,  5 Sep 2023 00:17:30 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 17:18:47 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <linuxarm@huawei.com>
Subject: [PATCH v2 0/3] hw/cxl: Add dummy ACPI QTG DSM
Date: Mon, 4 Sep 2023 17:18:44 +0100
Message-ID: <20230904161847.18468-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

v2 updates:
- Edit of patch description to not confuse matters by mentioning
  switches.
- Associated ACPI test updates.

CXL platforms may support the concept of QoS Thottling groups (QTG).

Typically you want to associate devices with similar performance
with the same QTG. As there is no standard way of understanding the
relationship between expected performance and appropriate QTG
the platform firmware provides a query mechanism via ACPI Device
Specific Method (DSM) with parameters of the performance numbers
that returns the appropriate QTG ID.

This support is basically stubbing out that function so that it always
returns 0. For now that is sufficient for current CXL emulation usecases.

Based on: [PATCH 0/4] hw/cxl: Minor CXL emulation fixes and cleanup
Based on: Message ID: 20230904132806.6094-1-Jonathan.Cameron@huawei.com

Dave Jiang (1):
  hw/cxl: Add QTG _DSM support for ACPI0017 device

Jonathan Cameron (2):
  tests/acpi: Allow update of DSDT.cxl
  tests/acpi: Update DSDT.cxl with QTG DSM

 include/hw/acpi/cxl.h        |   1 +
 hw/acpi/cxl.c                |  57 +++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c         |   1 +
 tests/data/acpi/q35/DSDT.cxl | Bin 9655 -> 9723 bytes
 4 files changed, 59 insertions(+)

-- 
2.39.2



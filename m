Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 982597A5E0B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:35:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiX83-0002nu-Vd; Tue, 19 Sep 2023 05:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiX80-0002nR-UY
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:34:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiX7y-0004Aj-DL
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:34:44 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rqc135d8tz6K5q8;
 Tue, 19 Sep 2023 17:33:43 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 19 Sep 2023 10:34:34 +0100
To: Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH v3 0/4] hw/cxl: Line length reduction and related
Date: Tue, 19 Sep 2023 10:34:30 +0100
Message-ID: <20230919093434.1194-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

v3:
- Fix an odd spacing change that Fan Ni noticed in review.
- Picked up tags.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>

Michael observed that the CXL code regularly went above the 80 character
recommendation and in many cases this was not necessary for readability.

This series is focused on tidying this up for the existing code so that
we can maintain the preferred formatting going forwards.

Based on: [PATCH 0/4] hw/cxl: Minor CXL emulation fixes and cleanup
Based on: [PATCH v2 0/3] hw/cxl: Add dummy ACPI QTG DSM
Based-on: [PATCH V2] hw/pci-bridge/cxl-upstream: Add serial number extended capability support


Based on: Message ID: 20230904132806.6094-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230904161847.18468-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230913133615.29876-1-Jonathan.Cameron@huawei.com


Jonathan Cameron (4):
  hw/cxl: Use a switch to explicitly check size in caps_reg_read()
  hw/cxl: Use switch statements for read and write of cachemem registers
  hw/cxl: CXLDVSECPortExtensions renamed to CXLDVSECPortExt
  hw/cxl: Line length reductions

 include/hw/cxl/cxl_component.h |   3 +-
 include/hw/cxl/cxl_device.h    |   5 +-
 include/hw/cxl/cxl_events.h    |   3 +-
 include/hw/cxl/cxl_pci.h       |   6 +-
 hw/cxl/cxl-cdat.c              |   3 +-
 hw/cxl/cxl-component-utils.c   | 128 ++++++++++++++++++++-------------
 hw/cxl/cxl-device-utils.c      |  11 +--
 hw/cxl/cxl-events.c            |   9 ++-
 hw/cxl/cxl-mailbox-utils.c     |  21 ++++--
 hw/mem/cxl_type3.c             |  31 ++++----
 hw/mem/cxl_type3_stubs.c       |   5 +-
 hw/pci-bridge/cxl_downstream.c |   2 +-
 hw/pci-bridge/cxl_root_port.c  |   2 +-
 hw/pci-bridge/cxl_upstream.c   |   2 +-
 14 files changed, 143 insertions(+), 88 deletions(-)

-- 
2.39.2



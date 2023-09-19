Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D387A5F58
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:21:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXpR-0008Qo-Ql; Tue, 19 Sep 2023 06:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiXpP-0008QA-6k
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:19:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiXpM-0007FY-Bg
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:19:34 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RqcwH6hSKz6J7fk;
 Tue, 19 Sep 2023 18:14:39 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 19 Sep 2023 11:19:27 +0100
To: Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <linuxarm@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, Yuquan
 Wang <wangyuquan1236@phytium.com.cn>, Dave Jiang <dave.jiang@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 0/3] hw/cxl: Misc small fixes
Date: Tue, 19 Sep 2023 11:19:24 +0100
Message-ID: <20230919101927.1470-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

v2:
 - Tag collection.
 - Patch 2 discussion on appropriate license concluded that this should
   have originally only been accepted on GPL-v2 and later. However, I've
   left it as GPL-v2-only as that is what was used for other CXL files and
   for the license to be usefully relaxed we need to do them all - which
   is a job for another day.
 - Added SPDX
 - Added similar header to cxl_type3_stubs.c
 
Misc set of trivial fixes.  No conflicts with other sets outstanding
so can go with main CXL patches or perhaps via the trivial tree.

Dmitry Frolov (1):
  hw/cxl: Fix out of bound array access

Jonathan Cameron (2):
  hw/mem/cxl_type3: Add missing copyright and license notice
  docs/cxl: Cleanout some more aarch64 examples.

 docs/system/devices/cxl.rst |  4 ++--
 include/hw/cxl/cxl.h        |  2 +-
 hw/mem/cxl_type3.c          | 11 +++++++++++
 hw/mem/cxl_type3_stubs.c    | 10 ++++++++++
 4 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.39.2



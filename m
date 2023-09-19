Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C877A5F5C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:21:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXqu-0003Ll-N8; Tue, 19 Sep 2023 06:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiXqr-00034o-1q
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:21:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiXqp-0007tP-9l
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:21:04 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rqcy371QWz67nNy;
 Tue, 19 Sep 2023 18:16:11 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 19 Sep 2023 11:20:59 +0100
To: Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <linuxarm@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, Yuquan
 Wang <wangyuquan1236@phytium.com.cn>, Dave Jiang <dave.jiang@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 3/3] docs/cxl: Cleanout some more aarch64 examples.
Date: Tue, 19 Sep 2023 11:19:27 +0100
Message-ID: <20230919101927.1470-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230919101927.1470-1-Jonathan.Cameron@huawei.com>
References: <20230919101927.1470-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

These crossed with the previous fix to get rid of examples
using aarch64 for which support is not yet upstream.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1892
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 docs/system/devices/cxl.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index b742120657..6ab5f72473 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -313,7 +313,7 @@ A very simple setup with just one directly attached CXL Type 3 Persistent Memory
 
 A very simple setup with just one directly attached CXL Type 3 Volatile Memory device::
 
-  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
   ...
   -object memory-backend-ram,id=vmem0,share=on,size=256M \
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
@@ -323,7 +323,7 @@ A very simple setup with just one directly attached CXL Type 3 Volatile Memory d
 
 The same volatile setup may optionally include an LSA region::
 
-  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
   ...
   -object memory-backend-ram,id=vmem0,share=on,size=256M \
   -object memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa.raw,size=256M \
-- 
2.39.2



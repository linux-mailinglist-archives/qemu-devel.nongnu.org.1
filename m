Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2AE791821
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:30:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9eO-000824-P6; Mon, 04 Sep 2023 09:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qd9eE-0007mK-Dh
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:29:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qd9e9-000162-4i
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:29:45 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfTwk01p5z67ydC;
 Mon,  4 Sep 2023 21:28:21 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 14:29:38 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC: Li Zhijian <lizhijian@cn.fujitsu.com>, Dave Jiang <dave.jiang@intel.com>, 
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <linuxarm@huawei.com>
Subject: [PATCH 3/4] hw/cxl/cxl_device: Replace magic number in CXLError
 definition
Date: Mon, 4 Sep 2023 14:28:05 +0100
Message-ID: <20230904132806.6094-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

From: Fan Ni <fan.ni@samsung.com>

Replace the magic number 32 with CXL_RAS_ERR_HEADER_NUM for better code
readability and maintainability.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1978730fba..fe8b46d9f7 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -300,7 +300,7 @@ REG64(CXL_MEM_DEV_STS, 0)
 typedef struct CXLError {
     QTAILQ_ENTRY(CXLError) node;
     int type; /* Error code as per FE definition */
-    uint32_t header[32];
+    uint32_t header[CXL_RAS_ERR_HEADER_NUM];
 } CXLError;
 
 typedef QTAILQ_HEAD(, CXLError) CXLErrorList;
-- 
2.39.2



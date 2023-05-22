Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC5A70C179
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 16:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q16se-0005AO-IV; Mon, 22 May 2023 10:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q16sK-00057D-Uv
 for qemu-devel@nongnu.org; Mon, 22 May 2023 10:51:07 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q16sI-0000Sk-Gs
 for qemu-devel@nongnu.org; Mon, 22 May 2023 10:51:04 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QQ0dK5tXPz6J66j;
 Mon, 22 May 2023 22:46:29 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 15:50:59 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ira Weiny
 <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Dave Jiang
 <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric
 Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas
 Huth <thuth@redhat.com>
Subject: [PATCH v7 1/4] bswap: Add the ability to store to an unaligned 24 bit
 field
Date: Mon, 22 May 2023 15:50:26 +0100
Message-ID: <20230522145029.6370-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522145029.6370-1-Jonathan.Cameron@huawei.com>
References: <20230522145029.6370-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Ira Weiny <ira.weiny@intel.com>

CXL has 24 bit unaligned fields which need to be stored to.  CXL is
specified as little endian.

Define st24_le_p() and the supporting functions to store such a field
from a 32 bit host native value.

The use of b, w, l, q as the size specifier is limiting.  So "24" was
used for the size part of the function name.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v7:
 - Added regexp to docs.
 - Dropped assert when top byte of u32 set
---
 docs/devel/loads-stores.rst |  2 ++
 include/qemu/bswap.h        | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index d2cefc77a2..dab6dfa0ac 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
 ``size``
  - ``b`` : 8 bits
  - ``w`` : 16 bits
+ - ``24`` : 24 bits
  - ``l`` : 32 bits
  - ``q`` : 64 bits
 
@@ -65,6 +66,7 @@ of size ``sz`` bytes.
 Regexes for git grep
  - ``\<ld[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
  - ``\<st[bwlq]\(_[hbl]e\)\?_p\>``
+ - ``\<st24\(_[hbl]e\)\?_p\>``
  - ``\<ldn_\([hbl]e\)?_p\>``
  - ``\<stn_\([hbl]e\)?_p\>``
 
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 15a78c0db5..933a66ee87 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -8,11 +8,23 @@
 #undef  bswap64
 #define bswap64(_x) __builtin_bswap64(_x)
 
+static inline uint32_t bswap24(uint32_t x)
+{
+    return (((x & 0x000000ffU) << 16) |
+            ((x & 0x0000ff00U) <<  0) |
+            ((x & 0x00ff0000U) >> 16));
+}
+
 static inline void bswap16s(uint16_t *s)
 {
     *s = __builtin_bswap16(*s);
 }
 
+static inline void bswap24s(uint32_t *s)
+{
+    *s = bswap24(*s & 0x00ffffffU);
+}
+
 static inline void bswap32s(uint32_t *s)
 {
     *s = __builtin_bswap32(*s);
@@ -26,11 +38,13 @@ static inline void bswap64s(uint64_t *s)
 #if HOST_BIG_ENDIAN
 #define be_bswap(v, size) (v)
 #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
+#define le_bswap24(v) bswap24(v)
 #define be_bswaps(v, size)
 #define le_bswaps(p, size) \
             do { *p = glue(__builtin_bswap, size)(*p); } while (0)
 #else
 #define le_bswap(v, size) (v)
+#define le_bswap24(v) (v)
 #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
 #define le_bswaps(v, size)
 #define be_bswaps(p, size) \
@@ -176,6 +190,7 @@ CPU_CONVERT(le, 64, uint64_t)
  * size is:
  *   b: 8 bits
  *   w: 16 bits
+ *   24: 24 bits
  *   l: 32 bits
  *   q: 64 bits
  *
@@ -248,6 +263,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
     __builtin_memcpy(ptr, &v, sizeof(v));
 }
 
+static inline void st24_he_p(void *ptr, uint32_t v)
+{
+    __builtin_memcpy(ptr, &v, 3);
+}
+
 static inline int ldl_he_p(const void *ptr)
 {
     int32_t r;
@@ -297,6 +317,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
     stw_he_p(ptr, le_bswap(v, 16));
 }
 
+static inline void st24_le_p(void *ptr, uint32_t v)
+{
+    st24_he_p(ptr, le_bswap24(v));
+}
+
 static inline void stl_le_p(void *ptr, uint32_t v)
 {
     stl_he_p(ptr, le_bswap(v, 32));
-- 
2.39.2



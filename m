Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D119005BC
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jun 2024 15:55:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFa3I-0004w5-1L; Fri, 07 Jun 2024 09:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sFa3F-0004ts-R5
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:54:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sFa3C-0008AT-W3
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:54:41 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwjJ50rQvz6JB86;
 Fri,  7 Jun 2024 21:50:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 51901140CB9;
 Fri,  7 Jun 2024 21:54:37 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 14:54:29 +0100
To: <qemu-devel@nongnu.org>, <peterx@redhat.com>, <farosas@suse.de>
CC: <yuan1.liu@intel.com>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <marcandre.lureau@redhat.com>, <thuth@redhat.com>, <armbru@redhat.com>,
 <lvivier@redhat.com>, <linuxarm@huawei.com>, <linwenkai6@hisilicon.com>,
 <zhangfei.gao@linaro.org>, <huangchenghai2@huawei.com>
Subject: [PATCH v2 4/7] migration/multifd: Add UADK initialization
Date: Fri, 7 Jun 2024 14:53:07 +0100
Message-ID: <20240607135310.46320-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
References: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.28]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Initialize UADK session and allocate buffers required. The actual
compression/decompression will only be done in a subsequent patch.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 migration/multifd-uadk.c | 209 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 208 insertions(+), 1 deletion(-)

diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index c2bb07535b..535411a405 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -12,9 +12,216 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
+#include "migration.h"
+#include "multifd.h"
+#include "options.h"
+#include "uadk/wd_comp.h"
+#include "uadk/wd_sched.h"
+
+struct wd_data {
+    handle_t handle;
+    uint8_t *buf;
+    uint32_t *buf_hdr;
+};
+
+static bool uadk_hw_init(void)
+{
+    char alg[] = "zlib";
+    int ret;
+
+    ret = wd_comp_init2(alg, SCHED_POLICY_RR, TASK_HW);
+    if (ret && ret != -WD_EEXIST) {
+        return false;
+    } else {
+        return true;
+    }
+}
+
+static struct wd_data *multifd_uadk_init_sess(uint32_t count,
+                                              uint32_t page_size,
+                                              bool compress, Error **errp)
+{
+    struct wd_comp_sess_setup ss = {0};
+    struct sched_params param = {0};
+    uint32_t size = count * page_size;
+    struct wd_data *wd;
+
+    if (!uadk_hw_init()) {
+        error_setg(errp, "multifd: UADK hardware not available");
+        return NULL;
+    }
+
+    wd = g_new0(struct wd_data, 1);
+    ss.alg_type = WD_ZLIB;
+    if (compress) {
+        ss.op_type = WD_DIR_COMPRESS;
+        /* Add an additional page for handling output > input */
+        size += page_size;
+    } else {
+        ss.op_type = WD_DIR_DECOMPRESS;
+    }
+
+    /* We use default level 1 compression and 4K window size */
+    param.type = ss.op_type;
+    ss.sched_param = &param;
+
+    wd->handle = wd_comp_alloc_sess(&ss);
+    if (!wd->handle) {
+        error_setg(errp, "multifd: failed wd_comp_alloc_sess");
+        goto out;
+    }
+
+    wd->buf = g_try_malloc(size);
+    if (!wd->buf) {
+        error_setg(errp, "multifd: out of mem for uadk buf");
+        goto out_free_sess;
+    }
+    wd->buf_hdr = g_new0(uint32_t, count);
+    return wd;
+
+out_free_sess:
+    wd_comp_free_sess(wd->handle);
+out:
+    wd_comp_uninit2();
+    g_free(wd);
+    return NULL;
+}
+
+static void multifd_uadk_uninit_sess(struct wd_data *wd)
+{
+    wd_comp_free_sess(wd->handle);
+    wd_comp_uninit2();
+    g_free(wd->buf);
+    g_free(wd->buf_hdr);
+    g_free(wd);
+}
+
+/**
+ * multifd_uadk_send_setup: setup send side
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int multifd_uadk_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    struct wd_data *wd;
+
+    wd = multifd_uadk_init_sess(p->page_count, p->page_size, true, errp);
+    if (!wd) {
+        return -1;
+    }
+
+    p->compress_data = wd;
+    assert(p->iov == NULL);
+    /*
+     * Each page will be compressed independently and sent using an IOV. The
+     * additional two IOVs are used to store packet header and compressed data
+     * length
+     */
+
+    p->iov = g_new0(struct iovec, p->page_count + 2);
+    return 0;
+}
+
+/**
+ * multifd_uadk_send_cleanup: cleanup send side
+ *
+ * Close the channel and return memory.
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static void multifd_uadk_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    struct wd_data *wd = p->compress_data;
+
+    multifd_uadk_uninit_sess(wd);
+    p->compress_data = NULL;
+}
+
+/**
+ * multifd_uadk_send_prepare: prepare data to be able to send
+ *
+ * Create a compressed buffer with all the pages that we are going to
+ * send.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    return -1;
+}
+
+/**
+ * multifd_uadk_recv_setup: setup receive side
+ *
+ * Create the compressed channel and buffer.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int multifd_uadk_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    struct wd_data *wd;
+
+    wd = multifd_uadk_init_sess(p->page_count, p->page_size, false, errp);
+    if (!wd) {
+        return -1;
+    }
+    p->compress_data = wd;
+    return 0;
+}
+
+/**
+ * multifd_uadk_recv_cleanup: cleanup receive side
+ *
+ * Close the channel and return memory.
+ *
+ * @p: Params for the channel that we are using
+ */
+static void multifd_uadk_recv_cleanup(MultiFDRecvParams *p)
+{
+    struct wd_data *wd = p->compress_data;
+
+    multifd_uadk_uninit_sess(wd);
+    p->compress_data = NULL;
+}
+
+/**
+ * multifd_uadk_recv: read the data from the channel into actual pages
+ *
+ * Read the compressed buffer, and uncompress it into the actual
+ * pages.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
+{
+    return -1;
+}
+
+static MultiFDMethods multifd_uadk_ops = {
+    .send_setup = multifd_uadk_send_setup,
+    .send_cleanup = multifd_uadk_send_cleanup,
+    .send_prepare = multifd_uadk_send_prepare,
+    .recv_setup = multifd_uadk_recv_setup,
+    .recv_cleanup = multifd_uadk_recv_cleanup,
+    .recv = multifd_uadk_recv,
+};
 
 static void multifd_uadk_register(void)
 {
-    /* noop for now */
+    multifd_register_ops(MULTIFD_COMPRESSION_UADK, &multifd_uadk_ops);
 }
 migration_init(multifd_uadk_register);
-- 
2.34.1



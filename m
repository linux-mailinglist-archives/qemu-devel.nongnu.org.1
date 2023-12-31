Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8323D820E9D
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 22:23:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rK3GD-0001Ih-MQ; Sun, 31 Dec 2023 16:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rK2ux-00078n-1H
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 16:00:20 -0500
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rK2uu-0007QM-SO
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 16:00:18 -0500
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-781b9922f44so67229085a.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 13:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704056415; x=1704661215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfKrdv08TX0rJ6x8vnK6oFLE9GkUtVpHlgcxnHxsOPE=;
 b=SGu24BRZLNAI4c7zUB1c6vjVpk1aAJtHdh6637v/8NJH5BWnjufXRydaf1r6sJJZ/j
 E4zn/KCB1kmXWT3IkIILzRReKRcQ7/tqAFoCa7ykzpBT5TNV8cHM/BmZUX6oDFFSAj8Y
 Ag+nXK7412nfXpEwrd5QhARL3UNqrdjuGH7eN9InnSVhesu/JCYl3x9tDB9qxF6e4zbo
 O0nlWKtbpCmZiKv+addga/g4wW/gugVJnsT/SyYPgvGmlAIRFhh9SPCFcdLcMNGsPX8X
 txhOdf73xjH02tCgVlVXc/jkHjs7bUUyd2h9HHDrandD0l3X7tgiLJ8aO2Czebl0g7MO
 0CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704056415; x=1704661215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfKrdv08TX0rJ6x8vnK6oFLE9GkUtVpHlgcxnHxsOPE=;
 b=CzsjenjrINnD5bBoWzUoCfQv+nYNy5AoldB8wz25TYiHW9p+778pMnPer4hN3OQNRa
 5JTeJlDh4x6EbMRC1GLi/kS/Kel8+BiD+QWXQjMfK5yVJG0ev4ssHujxH6qs99ID2H21
 x8H1j0UJcu7in/Ku6NePGD3JmA7cDq60NokyYMJxuVTGxhum6tjNrEkP+p8j1oHioct2
 WkJ/jFzfC21aaKTrx2leWo9946tOiLswMdpm0xvYEMgDYVI519oOsf/CrfDc/giR0akE
 j/L/m1azAVd/BzVXoLYf7HFljDQzXtgwpaQ9KLbJxYyDGos99nb3hFqwpI0jzdbeR9GK
 WOnQ==
X-Gm-Message-State: AOJu0YxIdk4F8kNaAcYxf7WyG3M8qmGCwnHYZXvMinotdC57+Ih/tTRk
 PLuUleIew/cXZWf583mQHcNtHjyEQ34Eu52158aZiRwd6PA=
X-Google-Smtp-Source: AGHT+IH+sh1HJmKRIlFWbluEJY8n63jrcvOjUO1TOhn9YClUNXLf6Mi4B9Opqd//pPVlbpbGpS6EGQ==
X-Received: by 2002:a05:620a:22ef:b0:781:7ac2:630f with SMTP id
 p15-20020a05620a22ef00b007817ac2630fmr6706290qki.98.1704056415338; 
 Sun, 31 Dec 2023 13:00:15 -0800 (PST)
Received: from n36-186-108.byted.org. ([147.160.184.90])
 by smtp.gmail.com with ESMTPSA id
 pb21-20020a05620a839500b007811da87cefsm8111750qkn.127.2023.12.31.13.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 13:00:15 -0800 (PST)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org, farosas@suse.de, marcandre.lureau@redhat.com,
 peterx@redhat.com, quintela@redhat.com, peter.maydell@linaro.org,
 hao.xiang@bytedance.com
Cc: bryan.zhang@bytedance.com
Subject: [PATCH 4/5] migration: Implement 'qatzip' methods using QAT
Date: Sun, 31 Dec 2023 20:58:03 +0000
Message-Id: <20231231205804.2366509-5-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
References: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 31 Dec 2023 16:22:09 -0500
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Uses QAT to offload deflate compression in the 'qatzip' compression
method for multifd migration.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/multifd-qatzip.c | 314 +++++++++++++++++++++++++++++++++++--
 1 file changed, 301 insertions(+), 13 deletions(-)

diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
index 1733bbddb7..3fb0bb5b27 100644
--- a/migration/multifd-qatzip.c
+++ b/migration/multifd-qatzip.c
@@ -18,50 +18,338 @@
 #include "migration.h"
 #include "options.h"
 #include "multifd.h"
+#include <qatzip.h>
 
+struct qatzip_data {
+    /*
+     * Unique session for use with QATzip API
+     */
+    QzSession_T sess;
+
+    /*
+     * For compression: Buffer for pages to compress
+     * For decompression: Buffer for data to decompress
+     */
+    uint8_t *in_buf;
+    uint32_t in_len;
+
+    /*
+     * For compression: Output buffer of compressed data
+     * For decompression: Output buffer of decompressed data
+     */
+    uint8_t *out_buf;
+    uint32_t out_len;
+};
+
+/**
+ * qatzip_send_setup: Set up QATzip session and private buffers.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
 static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
 {
+    struct qatzip_data *q;
+    QzSessionParamsDeflate_T params;
+    const char *err_msg;
+    int ret;
+
+    q = g_new0(struct qatzip_data, 1);
+    p->data = q;
+
+    ret = qzInit(&q->sess, 0);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzInit failed";
+        goto err_free_q;
+    }
+
+    ret = qzGetDefaultsDeflate(&params);
+    if (ret != QZ_OK) {
+        err_msg = "qzGetDefaultsDeflate failed";
+        goto err_close;
+    }
+
+    /* Use maximum hardware buffer size to improve batching. */
+    params.common_params.hw_buff_sz = QZ_HW_BUFF_MAX_SZ;
+
+    /* Make sure to use configured QATzip compression level. */
+    params.common_params.comp_lvl = migrate_multifd_qatzip_level();
+
+    ret = qzSetupSessionDeflate(&q->sess, &params);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzSetupSessionDeflate failed";
+        goto err_close;
+    }
+
+    /* TODO Add support for larger packets. */
+    if (MULTIFD_PACKET_SIZE > UINT32_MAX) {
+        err_msg = "packet size too large for QAT";
+        goto err_close;
+    }
+
+    q->in_len = MULTIFD_PACKET_SIZE;
+    q->in_buf = g_try_malloc(q->in_len);
+    if (!q->in_buf) {
+        err_msg = "malloc failed";
+        goto err_close;
+    }
+
+    q->out_len = qzMaxCompressedLength(MULTIFD_PACKET_SIZE, &q->sess);
+    q->out_buf = g_try_malloc(q->out_len);
+    if (!q->out_buf) {
+        err_msg = "malloc failed";
+        goto err_free_inbuf;
+    }
+
     return 0;
+
+err_free_inbuf:
+    g_free(q->in_buf);
+err_close:
+    qzClose(&q->sess);
+err_free_q:
+    g_free(q);
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
+    return -1;
 }
 
-static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp) {};
+/**
+ * qatzip_send_cleanup: Tear down QATzip session and release private buffers.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     None
+ */
+static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    struct qatzip_data *q = p->data;
+    const char *err_msg;
+    int ret;
+
+    ret = qzTeardownSession(&q->sess);
+    if (ret != QZ_OK) {
+        err_msg = "qzTeardownSession failed";
+        goto err;
+    }
+
+    ret = qzClose(&q->sess);
+    if (ret != QZ_OK) {
+        err_msg = "qzClose failed";
+        goto err;
+    }
+
+    g_free(q->in_buf);
+    q->in_buf = NULL;
+    g_free(q->out_buf);
+    q->out_buf = NULL;
+    g_free(p->data);
+    p->data = NULL;
+    return;
+
+err:
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
+}
 
+/**
+ * qatzip_send_prepare: Compress pages and update IO channel info.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
 static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    MultiFDPages_t *pages = p->pages;
+    struct qatzip_data *q = p->data;
+    int ret;
+    unsigned int in_len, out_len;
 
+    /* memcpy all the pages into one buffer. */
     for (int i = 0; i < p->normal_num; i++) {
-        p->iov[p->iovs_num].iov_base = pages->block->host + p->normal[i];
-        p->iov[p->iovs_num].iov_len = p->page_size;
-        p->iovs_num++;
+        memcpy(q->in_buf + (i * p->page_size),
+               p->pages->block->host + p->normal[i],
+               p->page_size);
+    }
+
+    in_len = p->normal_num * p->page_size;
+    if (in_len > q->in_len) {
+        error_setg(errp, "multifd %u: unexpectedly large input", p->id);
+        return -1;
+    }
+    out_len = q->out_len;
+
+    /*
+     * Unlike other multifd compression implementations, we use a non-streaming
+     * API and place all the data into one buffer, rather than sending each page
+     * to the compression API at a time. Based on initial benchmarks, the
+     * non-streaming API outperforms the streaming API. Plus, the logic in QEMU
+     * is friendly to using the non-streaming API anyway. If either of these
+     * statements becomes no longer true, we can revisit adding a streaming
+     * implementation.
+     */
+    ret = qzCompress(&q->sess, q->in_buf, &in_len, q->out_buf, &out_len, 1);
+    if (ret != QZ_OK) {
+        error_setg(errp, "multifd %u: QATzip returned %d instead of QZ_OK",
+                   p->id, ret);
+        return -1;
+    }
+    if (in_len != p->normal_num * p->page_size) {
+        error_setg(errp, "multifd %u: QATzip failed to compress all input",
+                   p->id);
+        return -1;
     }
 
-    p->next_packet_size = p->normal_num * p->page_size;
-    p->flags |= MULTIFD_FLAG_NOCOMP;
+    p->iov[p->iovs_num].iov_base = q->out_buf;
+    p->iov[p->iovs_num].iov_len = out_len;
+    p->iovs_num++;
+    p->next_packet_size = out_len;
+    p->flags |= MULTIFD_FLAG_QATZIP;
     return 0;
 }
 
+/**
+ * qatzip_recv_setup: Set up QATzip session and allocate private buffers.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
 static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    struct qatzip_data *q;
+    QzSessionParamsDeflate_T params;
+    const char *err_msg;
+    int ret;
+
+    q = g_new0(struct qatzip_data, 1);
+    p->data = q;
+
+    ret = qzInit(&q->sess, 0);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzInit failed";
+        goto err_free_q;
+    }
+
+    ret = qzGetDefaultsDeflate(&params);
+    if (ret != QZ_OK) {
+        err_msg = "qzGetDefaultsDeflate failed";
+        goto err_close;
+    }
+
+    /* Set maximum hardware buffer size for improved batching. */
+    params.common_params.hw_buff_sz = QZ_HW_BUFF_MAX_SZ;
+
+    /* Make sure to use configured QATzip compression level. */
+    params.common_params.comp_lvl = migrate_multifd_qatzip_level();
+
+    ret = qzSetupSessionDeflate(&q->sess, &params);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzSetupSessionDeflate failed";
+        goto err_close;
+    }
+
+    /*
+     * Mimic multifd-zlib, which reserves extra space for the incoming packet.
+     */
+    q->in_len = MULTIFD_PACKET_SIZE * 2;
+    q->in_buf = g_try_malloc(q->in_len);
+    if (!q->in_buf) {
+        err_msg = "malloc failed";
+        goto err_close;
+    }
+
+    q->out_len = MULTIFD_PACKET_SIZE;
+    q->out_buf = g_try_malloc(q->out_len);
+    if (!q->out_buf) {
+        err_msg = "malloc failed";
+        goto err_free_inbuf;
+    }
+
     return 0;
+
+err_free_inbuf:
+    g_free(q->in_buf);
+err_close:
+    qzClose(&q->sess);
+err_free_q:
+    g_free(q);
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
+    return -1;
 }
 
-static void qatzip_recv_cleanup(MultiFDRecvParams *p) {};
+/**
+ * qatzip_recv_cleanup: Tear down QATzip session and release private buffers.
+ *
+ * @param p    Multifd channel params
+ * @return     None
+ */
+static void qatzip_recv_cleanup(MultiFDRecvParams *p)
+{
+    struct qatzip_data *q = p->data;
+
+    /* Ignoring return values here due to function signature. */
+    qzTeardownSession(&q->sess);
+    qzClose(&q->sess);
+    g_free(q->in_buf);
+    g_free(q->out_buf);
+    g_free(p->data);
+}
 
+
+/**
+ * qatzip_recv_pages: Decompress pages and copy them to the appropriate
+ * locations.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
 static int qatzip_recv_pages(MultiFDRecvParams *p, Error **errp)
 {
+    struct qatzip_data *q = p->data;
+    int ret;
+    unsigned int in_len, out_len;
+    uint32_t in_size = p->next_packet_size;
+    uint32_t expected_size = p->normal_num * p->page_size;
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
 
-    if (flags != MULTIFD_FLAG_NOCOMP) {
+    if (in_size > q->in_len) {
+        error_setg(errp, "multifd %u: received unexpectedly large packet",
+                   p->id);
+        return -1;
+    }
+
+    if (flags != MULTIFD_FLAG_QATZIP) {
         error_setg(errp, "multifd %u: flags received %x flags expected %x",
-                   p->id, flags, MULTIFD_FLAG_NOCOMP);
+                   p->id, flags, MULTIFD_FLAG_QATZIP);
+        return -1;
+    }
+
+    ret = qio_channel_read_all(p->c, (void *)q->in_buf, in_size, errp);
+    if (ret != 0) {
+        return ret;
+    }
+
+    in_len = in_size;
+    out_len = q->out_len;
+    ret = qzDecompress(&q->sess, q->in_buf, &in_len, q->out_buf, &out_len);
+    if (ret != QZ_OK) {
+        error_setg(errp, "multifd %u: qzDecompress failed", p->id);
+        return -1;
+    }
+    if (out_len != expected_size) {
+        error_setg(errp, "multifd %u: packet size received %u size expected %u",
+                   p->id, out_len, expected_size);
         return -1;
     }
+
+    /* Copy each page to its appropriate location. */
     for (int i = 0; i < p->normal_num; i++) {
-        p->iov[i].iov_base = p->host + p->normal[i];
-        p->iov[i].iov_len = p->page_size;
+        memcpy(p->host + p->normal[i],
+               q->out_buf + p->page_size * i,
+               p->page_size);
     }
-    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
+    return 0;
 }
 
 static MultiFDMethods multifd_qatzip_ops = {
-- 
2.30.2



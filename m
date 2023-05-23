Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1F170DA5E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:23:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P8e-00006g-LC; Tue, 23 May 2023 06:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P8a-0008Ku-82; Tue, 23 May 2023 06:21:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P8Y-0003TK-Eg; Tue, 23 May 2023 06:21:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9A5A37D44;
 Tue, 23 May 2023 13:20:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E8EBC72AB;
 Tue, 23 May 2023 13:20:16 +0300 (MSK)
Received: (nullmailer pid 86103 invoked by uid 1000);
 Tue, 23 May 2023 10:20:14 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 Yiming Tao <taoym@zju.edu.cn>, Gonglei <arei.gonglei@huawei.com>,
 zhenwei pi <pizhenwei@bytedance.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.3 45/45] virtio-crypto: fix NULL pointer dereference in
 virtio_crypto_free_request
Date: Tue, 23 May 2023 13:17:22 +0300
Message-Id: <20230523102014.85954-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.3-20230523131604@cover.tls.msk.ru>
References: <qemu-stable-7.2.3-20230523131604@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Mauro Matteo Cascella <mcascell@redhat.com>

Ensure op_info is not NULL in case of QCRYPTODEV_BACKEND_ALG_SYM algtype.

Fixes: 0e660a6f90a ("crypto: Introduce RSA algorithm")
Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
Reported-by: Yiming Tao <taoym@zju.edu.cn>
Message-Id: <20230509075317.1132301-1-mcascell@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: zhenwei pi<pizhenwei@bytedance.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 3e69908907f8d3dd20d5753b0777a6e3824ba824)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context tweak after 999c789f00 cryptodev: Introduce cryptodev alg type in QAPI)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 97da74e719..a6dbdd32da 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -476,15 +476,17 @@ static void virtio_crypto_free_request(VirtIOCryptoReq *req)
         size_t max_len;
         CryptoDevBackendSymOpInfo *op_info = req->op_info.u.sym_op_info;
 
-        max_len = op_info->iv_len +
-                  op_info->aad_len +
-                  op_info->src_len +
-                  op_info->dst_len +
-                  op_info->digest_result_len;
-
-        /* Zeroize and free request data structure */
-        memset(op_info, 0, sizeof(*op_info) + max_len);
-        g_free(op_info);
+        if (op_info) {
+            max_len = op_info->iv_len +
+                      op_info->aad_len +
+                      op_info->src_len +
+                      op_info->dst_len +
+                      op_info->digest_result_len;
+
+            /* Zeroize and free request data structure */
+            memset(op_info, 0, sizeof(*op_info) + max_len);
+            g_free(op_info);
+        }
     } else if (req->flags == CRYPTODEV_BACKEND_ALG_ASYM) {
         CryptoDevBackendAsymOpInfo *op_info = req->op_info.u.asym_op_info;
         if (op_info) {
-- 
2.39.2



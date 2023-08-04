Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F9A7708E0
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0K9-0004yE-GO; Fri, 04 Aug 2023 15:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0K7-0004rX-2b; Fri, 04 Aug 2023 15:18:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0K5-00079d-GH; Fri, 04 Aug 2023 15:18:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D354718469;
 Fri,  4 Aug 2023 22:17:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 68FB81B8AC;
 Fri,  4 Aug 2023 22:16:54 +0300 (MSK)
Received: (nullmailer pid 1875756 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, zhenwei pi <pizhenwei@bytedance.com>,
 Gonglei <arei.gonglei@huawei.com>, Mauro Matteo Cascella <mcascell@redhat.com>,
 Xiao Lei <nop.leixiao@gmail.com>, Yongkang Jia <kangel@zju.edu.cn>,
 Yiming Tao <taoym@zju.edu.cn>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 55/63] cryptodev: Handle unexpected request to avoid
 crash
Date: Fri,  4 Aug 2023 22:16:38 +0300
Message-Id: <20230804191647.1875608-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: zhenwei pi <pizhenwei@bytedance.com>

Generally guest side should discover which services the device is
able to offer, then do requests on device.

However it's also possible to break this rule in a guest. Handle
unexpected request here to avoid NULL pointer dereference.

Fixes: e7a775fd ('cryptodev: Account statistics')
Cc: Gonglei <arei.gonglei@huawei.com>
Cc: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: Xiao Lei <nop.leixiao@gmail.com>
Cc: Yongkang Jia <kangel@zju.edu.cn>
Reported-by: Yiming Tao <taoym@zju.edu.cn>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20230803024314.29962-3-pizhenwei@bytedance.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 15b11a1da6a4b7c6b8bb37883f52b544dee2b8fd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 94ca393cee..d3fe92d8c0 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -191,6 +191,11 @@ static int cryptodev_backend_account(CryptoDevBackend *backend,
     if (algtype == QCRYPTODEV_BACKEND_ALG_ASYM) {
         CryptoDevBackendAsymOpInfo *asym_op_info = op_info->u.asym_op_info;
         len = asym_op_info->src_len;
+
+        if (unlikely(!backend->asym_stat)) {
+            error_report("cryptodev: Unexpected asym operation");
+            return -VIRTIO_CRYPTO_NOTSUPP;
+        }
         switch (op_info->op_code) {
         case VIRTIO_CRYPTO_AKCIPHER_ENCRYPT:
             CryptodevAsymStatIncEncrypt(backend, len);
@@ -210,6 +215,11 @@ static int cryptodev_backend_account(CryptoDevBackend *backend,
     } else if (algtype == QCRYPTODEV_BACKEND_ALG_SYM) {
         CryptoDevBackendSymOpInfo *sym_op_info = op_info->u.sym_op_info;
         len = sym_op_info->src_len;
+
+        if (unlikely(!backend->sym_stat)) {
+            error_report("cryptodev: Unexpected sym operation");
+            return -VIRTIO_CRYPTO_NOTSUPP;
+        }
         switch (op_info->op_code) {
         case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
             CryptodevSymStatIncEncrypt(backend, len);
-- 
2.39.2



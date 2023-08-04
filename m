Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B89770847
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 20:56:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRzwt-0002fe-K0; Fri, 04 Aug 2023 14:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzwk-0002Py-FH; Fri, 04 Aug 2023 14:54:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzwj-0008DR-0c; Fri, 04 Aug 2023 14:54:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1D0D618412;
 Fri,  4 Aug 2023 21:54:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AC44E1B889;
 Fri,  4 Aug 2023 21:53:59 +0300 (MSK)
Received: (nullmailer pid 1874236 invoked by uid 1000);
 Fri, 04 Aug 2023 18:53:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, zhenwei pi <pizhenwei@bytedance.com>,
 Gonglei <arei.gonglei@huawei.com>, Mauro Matteo Cascella <mcascell@redhat.com>,
 Yiming Tao <taoym@zju.edu.cn>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 28/36] virtio-crypto: verify src&dst buffer length for
 sym request
Date: Fri,  4 Aug 2023 21:53:41 +0300
Message-Id: <20230804185350.1874133-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
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

For symmetric algorithms, the length of ciphertext must be as same
as the plaintext.
The missing verification of the src_len and the dst_len in
virtio_crypto_sym_op_helper() may lead buffer overflow/divulged.

This patch is originally written by Yiming Tao for QEMU-SECURITY,
resend it(a few changes of error message) in qemu-devel.

Fixes: CVE-2023-3180
Fixes: 04b9b37edda("virtio-crypto: add data queue processing handler")
Cc: Gonglei <arei.gonglei@huawei.com>
Cc: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: Yiming Tao <taoym@zju.edu.cn>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20230803024314.29962-2-pizhenwei@bytedance.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 9d38a8434721a6479fe03fb5afb150ca793d3980)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index a6dbdd32da..406b4e5fd0 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -635,6 +635,11 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
         return NULL;
     }
 
+    if (unlikely(src_len != dst_len)) {
+        virtio_error(vdev, "sym request src len is different from dst len");
+        return NULL;
+    }
+
     max_len = (uint64_t)iv_len + aad_len + src_len + dst_len + hash_result_len;
     if (unlikely(max_len > vcrypto->conf.max_size)) {
         virtio_error(vdev, "virtio-crypto too big length");
-- 
2.39.2



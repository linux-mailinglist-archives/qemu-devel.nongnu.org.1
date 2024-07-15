Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68993114F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jul 2024 11:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTI75-0003sF-O0; Mon, 15 Jul 2024 05:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTI6X-0002yV-GV; Mon, 15 Jul 2024 05:34:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTI6V-0003wk-0R; Mon, 15 Jul 2024 05:34:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 86B8B7A590;
 Mon, 15 Jul 2024 12:34:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C399E108CFA;
 Mon, 15 Jul 2024 12:34:35 +0300 (MSK)
Received: (nullmailer pid 571752 invoked by uid 1000);
 Mon, 15 Jul 2024 09:34:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 jasowang@redhat.com, Xoykie <xoykie@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.2 24/27] virtio: remove virtio_tswap16s() call in
 vring_packed_event_read()
Date: Mon, 15 Jul 2024 12:34:31 +0300
Message-Id: <20240715093435.571721-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.2-20240715075000@cover.tls.msk.ru>
References: <qemu-stable-9.0.2-20240715075000@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Stefano Garzarella <sgarzare@redhat.com>

Commit d152cdd6f6 ("virtio: use virtio accessor to access packed event")
switched using of address_space_read_cached() to virito_lduw_phys_cached()
to access packed descriptor event.

When we used address_space_read_cached(), we needed to call
virtio_tswap16s() to handle the endianess of the field, but
virito_lduw_phys_cached() already handles it internally, so we no longer
need to call virtio_tswap16s() (as the commit had done for `off_wrap`,
but forgot for `flags`).

Fixes: d152cdd6f6 ("virtio: use virtio accessor to access packed event")
Cc: jasowang@redhat.com
Cc: qemu-stable@nongnu.org
Reported-by: Xoykie <xoykie@gmail.com>
Link: https://lore.kernel.org/qemu-devel/CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--Tjr49F_eX32ZBc5o2zQ@mail.gmail.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240701075208.19634-1-sgarzare@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 7aa6492401e95fb296dec7cda81e67d91f6037d7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 871674f9be..fd2dfe3a6b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -322,7 +322,6 @@ static void vring_packed_event_read(VirtIODevice *vdev,
     /* Make sure flags is seen before off_wrap */
     smp_rmb();
     e->off_wrap = virtio_lduw_phys_cached(vdev, cache, off_off);
-    virtio_tswap16s(vdev, &e->flags);
 }
 
 static void vring_packed_off_wrap_write(VirtIODevice *vdev,
-- 
2.39.2



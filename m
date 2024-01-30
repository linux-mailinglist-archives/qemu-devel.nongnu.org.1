Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7CA842F28
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Jan 2024 22:53:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUw1Y-0002Py-10; Tue, 30 Jan 2024 16:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUw1H-0002CR-OR
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:51:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUw1F-0005nd-Il
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706651507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDUgZHDlvWeA7rh+OjrSJr8WhdVme2HVQIvgJAMUWGU=;
 b=FqCx2UJZf9LBemxJmAtm733DjieYq70pfkVifZ/BX2Vezdzsy26NBK39k1DrtfIXEJjalb
 MqAx60SlsPl9NVfEI4uQtS1pu59ntesi0Bpajik4NPCZ4jKha0v+Rn7qZXyNXkLzme874b
 mt7HFAa4Wtxl2HDpdUBNWaJqnxtTEag=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-wHgEU0fUNviTw7PSIP1T_w-1; Tue,
 30 Jan 2024 16:51:45 -0500
X-MC-Unique: wHgEU0fUNviTw7PSIP1T_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FF523869143;
 Tue, 30 Jan 2024 21:51:44 +0000 (UTC)
Received: from localhost (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B7E040C9444;
 Tue, 30 Jan 2024 21:51:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Xiang Zheng <zhengxiang9@huawei.com>
Subject: [PULL 3/5] pflash: fix sectors vs bytes confusion in
 blk_pread_nonzeroes()
Date: Tue, 30 Jan 2024 16:51:32 -0500
Message-ID: <20240130215134.346557-4-stefanha@redhat.com>
In-Reply-To: <20240130215134.346557-1-stefanha@redhat.com>
References: <20240130215134.346557-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following expression is incorrect because blk_pread_nonzeroes()
deals in units of bytes, not sectors:

  bytes = MIN(size - offset, BDRV_REQUEST_MAX_SECTORS)
                                              ^^^^^^^

BDRV_REQUEST_MAX_BYTES is the appropriate constant.

Fixes: a4b15a8b9ef2 ("pflash: Only read non-zero parts of backend image")
Cc: Xiang Zheng <zhengxiang9@huawei.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240130002712.257815-1-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index 9f52ee6e72..ff503002aa 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -30,7 +30,7 @@ static int blk_pread_nonzeroes(BlockBackend *blk, hwaddr size, void *buf)
     BlockDriverState *bs = blk_bs(blk);
 
     for (;;) {
-        bytes = MIN(size - offset, BDRV_REQUEST_MAX_SECTORS);
+        bytes = MIN(size - offset, BDRV_REQUEST_MAX_BYTES);
         if (bytes <= 0) {
             return 0;
         }
-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28D716BDE
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:04:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43hQ-0001Ib-0g; Tue, 30 May 2023 14:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q43hE-0001G4-Ae
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q43hC-0003HG-Nn
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685469825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YMgiIJalCgNKB2p0U8/fbnwsAl/E2NVyw4mUK1kCvLY=;
 b=HElj417oBhcFeGAOp9DHtCNymTbestuMTLGjGZ4PKNFgX9EtotUWfe7OQSmjiHENg4+ScL
 IXGs+MwfYmMcxRp0f8jNNGCEs+KwXu58wQj325D4RmlNmbHDKHtLan8eV6iSCxEy7g5w3F
 BB2pfXSfeomxc9PxW18U9UOjXqulTsI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-cZ4VDh5KPCeIQr2BDZ0BOA-1; Tue, 30 May 2023 14:03:38 -0400
X-MC-Unique: cZ4VDh5KPCeIQr2BDZ0BOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC29D811E85;
 Tue, 30 May 2023 18:03:37 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F7A140C6EC4;
 Tue, 30 May 2023 18:03:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/avocado/virtio-gpu: Cancel test if drm rendering is not
 available
Date: Tue, 30 May 2023 20:03:30 +0200
Message-Id: <20230530180330.48722-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The test_vhost_user_vga_virgl test currently fails on some CI
machines with:

 qemu-system-x86_64: egl: no drm render node available
 qemu-system-x86_64: egl: render node init failed

The other test in this file already checks whether there is
an error while starting QEMU - we should do the same for the
test_vhost_user_vga_virgl test, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/virtio-gpu.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/virtio-gpu.py b/tests/avocado/virtio-gpu.py
index e3b58fe799..89bfecc715 100644
--- a/tests/avocado/virtio-gpu.py
+++ b/tests/avocado/virtio-gpu.py
@@ -143,7 +143,11 @@ def test_vhost_user_vga_virgl(self):
             "-append",
             self.KERNEL_COMMAND_LINE,
         )
-        self.vm.launch()
+        try:
+            self.vm.launch()
+        except:
+            # TODO: probably fails because we are missing the VirGL features
+            self.cancel("VirGL not enabled?")
         self.wait_for_console_pattern("as init process")
         exec_command_and_wait_for_pattern(
             self, "/usr/sbin/modprobe virtio_gpu", ""
-- 
2.31.1



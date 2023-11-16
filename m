Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F197EE661
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 19:07:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gkR-0002Pc-CZ; Thu, 16 Nov 2023 13:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkK-0002Mo-NQ
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkJ-00041T-6Y
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700157942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyE20AWaD3XR0qppfEGr4Tjw942ZKZylMdYoR15iWOQ=;
 b=IEI0nW8F/uQ++NZT2gzkojqiXezxqWJAlkFJ3MRtI7NEwMbBkRYXDNsotKdQPQ6AXi83kY
 DuITRLUDbKY7S9aB5DwoAAQuGH5jwLUiwx+jpfbqB1kHOsa4tFpXfSp5pOOJGhMYzQMSsG
 0S9xvJUkd0xTsJ/t+bB+IyJF4DFAnGw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-mX9xJeMdMui89D2Rd14RRg-1; Thu,
 16 Nov 2023 13:05:40 -0500
X-MC-Unique: mX9xJeMdMui89D2Rd14RRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 686F33C11C68;
 Thu, 16 Nov 2023 18:05:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EF051121306;
 Thu, 16 Nov 2023 18:05:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Antonio Caggiano <quic_acaggian@quicinc.com>
Subject: [PULL 03/10] tests/avocado/virtio-gpu: Fix test_vhost_user_vga_virgl
 for edid support
Date: Thu, 16 Nov 2023 19:05:27 +0100
Message-ID: <20231116180534.566469-4-thuth@redhat.com>
In-Reply-To: <20231116180534.566469-1-thuth@redhat.com>
References: <20231116180534.566469-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The "edid" feature has been added to vhost-user-gpu in commit
c06444261e20 ("contrib/vhost-user-gpu: implement get_edid feature"),
so waiting for "features: +virgl -edid" in the test does not work
anymore, it's "+edid" instead of "-edid" now!

While we're at it, move the expected string to the preceeding
exec_command_and_wait_for_pattern() instead (since waiting for
empty string here does not make too much sense).

Message-ID: <20231114203456.319093-1-thuth@redhat.com>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/virtio-gpu.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/avocado/virtio-gpu.py b/tests/avocado/virtio-gpu.py
index 89bfecc715..6091f614a4 100644
--- a/tests/avocado/virtio-gpu.py
+++ b/tests/avocado/virtio-gpu.py
@@ -149,10 +149,8 @@ def test_vhost_user_vga_virgl(self):
             # TODO: probably fails because we are missing the VirGL features
             self.cancel("VirGL not enabled?")
         self.wait_for_console_pattern("as init process")
-        exec_command_and_wait_for_pattern(
-            self, "/usr/sbin/modprobe virtio_gpu", ""
-        )
-        self.wait_for_console_pattern("features: +virgl -edid")
+        exec_command_and_wait_for_pattern(self, "/usr/sbin/modprobe virtio_gpu",
+                                          "features: +virgl +edid")
         self.vm.shutdown()
         qemu_sock.close()
         vugp.terminate()
-- 
2.41.0



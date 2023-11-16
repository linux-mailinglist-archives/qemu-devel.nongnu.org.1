Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 581317EE65E
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 19:06:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gkd-0002UF-OU; Thu, 16 Nov 2023 13:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkU-0002Sk-48
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkS-00043v-Gg
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700157951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OI6jInKvfEQ2SeOWQTOmL2JfEqfOfTs6vwhO3MUj/QM=;
 b=MlKsCN+plIaXje4mUIYDmCXD1VPPQRcTXasX42UmgIkMcfFbRjKF0apTXIt0SF71V/QKrS
 BY5Gm3z2laB9I3TxreTCe/8afHZttct4uuB62sIPbXJgd8NYf7p5yLXwwGgR7rfLmYhlsP
 U7vHsaS2LHHtALwtLPT+BgIwV7DdrXw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-gBKeyG35NTaMJ6B3NDsfyg-1; Thu,
 16 Nov 2023 13:05:49 -0500
X-MC-Unique: gBKeyG35NTaMJ6B3NDsfyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D7302808FC7;
 Thu, 16 Nov 2023 18:05:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46E131121306;
 Thu, 16 Nov 2023 18:05:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 09/10] tests/avocado: reverse_debugging drain console to
 prevent hang
Date: Thu, 16 Nov 2023 19:05:33 +0100
Message-ID: <20231116180534.566469-10-thuth@redhat.com>
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

From: Nicholas Piggin <npiggin@gmail.com>

Like replay_linux.py, reverse_debugging.py starts the vm with console
set but does not interact with it (e.g., with wait_for_console_pattern).
In this situation, the console should have a drainer attached so the
socket does not fill. replay_linux.py has a drainer, but it is missing
from reverse_debugging.py.

Per analysis in Link: this can cause the console socket/pipe to fill and
QEMU get stuck in qemu_chr_write_buffer, leading to strange test case
failures (ppc64 fails because it prints a lot to console in early bios).
Attaching a drainer prevents this.

Note, this commit does not fix bugs introduced by the commits referenced
in the first two Fixes: tags, but together those commits conspire to
irritate the problem and cause test case failure, which this commit
fixes.

Link: https://lore.kernel.org/qemu-devel/ZVT-bY9YOr69QTPX@redhat.com/
Fixes: 1d4796cd0083 ("python/machine: use socketpair() for console connections")
Fixes: 761a13b23946 ("tests/avocado: ppc64 reverse debugging tests for pseries and powernv")
Fixes: be52eca30978 ("tests/acceptance: add reverse debugging test")
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20231116115354.228678-1-npiggin@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/reverse_debugging.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index fc47874eda..128d85bc0e 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -12,6 +12,7 @@
 
 from avocado import skipIf
 from avocado_qemu import BUILD_DIR
+from avocado.utils import datadrainer
 from avocado.utils import gdb
 from avocado.utils import process
 from avocado.utils.network.ports import find_free_port
@@ -52,6 +53,10 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
         if args:
             vm.add_args(*args)
         vm.launch()
+        console_drainer = datadrainer.LineLogger(vm.console_socket.fileno(),
+                                    logger=self.log.getChild('console'),
+                                    stop_check=(lambda : not vm.is_running()))
+        console_drainer.start()
         return vm
 
     @staticmethod
-- 
2.41.0



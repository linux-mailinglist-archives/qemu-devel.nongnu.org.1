Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD3743F8A
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 18:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFGnT-0000b9-Gp; Fri, 30 Jun 2023 12:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qFGnR-0000a8-0B
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 12:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qFGnP-0004eO-Hf
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 12:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688141790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=88ziSUOH3fhB2B9VSYwbbPI8etDK2i5FDhZHt32/sNY=;
 b=fo37+tZel5cuIDDA/V/SxIBAm8lHii+44a/lElIeSEKGlWBfhyEpDP/n8A5a3bytu5sdZD
 MDu8eBUZ2JxRttgO6IKw2Uu2cWnA7fT1JWYjOixsbmyzMszV8ppaW3Hxi5LqZYUhltkcHe
 6xpUCI3dT85BXmn3s48dr/SvNDSi/jE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-gjv_3xQGOp2R6SdZTulJNA-1; Fri, 30 Jun 2023 12:16:24 -0400
X-MC-Unique: gjv_3xQGOp2R6SdZTulJNA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 649F13849522;
 Fri, 30 Jun 2023 16:16:22 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AC76492B02;
 Fri, 30 Jun 2023 16:16:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	qianfan <qianfanguijin@163.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/avocado: Make the test_arm_bpim2u_gmac test more
 reliable
Date: Fri, 30 Jun 2023 18:16:04 +0200
Message-Id: <20230630161604.446394-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The test_arm_bpim2u_gmac test sometimes fails (ca. 1 out of 20 runs
here) since the disk shows up as /dev/mmcblk1 instead of /dev/mmcblk0
in some runs. No matter of the name in /dev, the major:minor encoding
seems always to be the same, so we can fix this issue by using the
correct major:minor hex number in the "root=" parameter instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/boot_linux_console.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 6ed660611f..6eab515718 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -869,7 +869,7 @@ def test_arm_bpim2u_gmac(self):
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyS0,115200 '
-                               'root=/dev/mmcblk0 rootwait rw '
+                               'root=b300 rootwait rw '
                                'panic=-1 noreboot')
         self.vm.add_args('-kernel', kernel_path,
                          '-dtb', dtb_path,
@@ -885,7 +885,7 @@ def test_arm_bpim2u_gmac(self):
         exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
                                                 'Allwinner sun8i Family')
         exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
-                                                'mmcblk0')
+                                                'mmcblk')
         exec_command_and_wait_for_pattern(self, 'ifconfig eth0 up',
                                                  'eth0: Link is Up')
         exec_command_and_wait_for_pattern(self, 'udhcpc eth0',
-- 
2.39.3



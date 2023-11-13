Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5799D7E9E30
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 15:09:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Xc0-0005Yq-RF; Mon, 13 Nov 2023 09:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2Xby-0005YL-3g
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 09:08:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2Xbw-0003iE-Ln
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 09:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699884498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=unHoRcIL/K4sNSKP73B1gtN1VXQ4ft/WlDOJahDd5sA=;
 b=WHWOWhrNp8e8vfK5ZAjR6y4wjzYVTtHKhU04Cddfjek9zeyYzGH2BVWTR6+L4/DZacWgJF
 kQzQdo+ou6MTfNb1zhKUHUwKlm2uiplr2TziBb5xFb4vUR0B039/EZtRtmIFVn6abRHX6q
 uCYKda2BMk2GD/vTmmsfoa2tNyKIW4s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-RuD-cgzvPniISBRSQBmhRQ-1; Mon,
 13 Nov 2023 09:07:59 -0500
X-MC-Unique: RuD-cgzvPniISBRSQBmhRQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5BC71C0755A;
 Mon, 13 Nov 2023 14:07:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74752492BE0;
 Mon, 13 Nov 2023 14:07:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH] tests/avocado/machine_s390_ccw_virtio.py: Fix SyntaxWarnings
 from python 3.12
Date: Mon, 13 Nov 2023 15:07:21 +0100
Message-ID: <20231113140721.46903-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Python 3.12 now warns about backslashes in strings that aren't used
for escaping a special character from Python. Silence the warning
by using raw strings here instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/machine_s390_ccw_virtio.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/avocado/machine_s390_ccw_virtio.py b/tests/avocado/machine_s390_ccw_virtio.py
index e1f493bc44..ffd914ded9 100644
--- a/tests/avocado/machine_s390_ccw_virtio.py
+++ b/tests/avocado/machine_s390_ccw_virtio.py
@@ -36,8 +36,8 @@ def wait_for_crw_reports(self):
     dmesg_clear_count = 1
     def clear_guest_dmesg(self):
         exec_command_and_wait_for_pattern(self, 'dmesg -c > /dev/null; '
-                    'echo dm_clear\ ' + str(self.dmesg_clear_count),
-                    'dm_clear ' + str(self.dmesg_clear_count))
+                    r'echo dm_clear\ ' + str(self.dmesg_clear_count),
+                    r'dm_clear ' + str(self.dmesg_clear_count))
         self.dmesg_clear_count += 1
 
     def test_s390x_devices(self):
@@ -121,15 +121,15 @@ def test_s390x_devices(self):
                                     'cat /sys/bus/ccw/devices/0.1.1111/cutype',
                                     '3832/01')
         exec_command_and_wait_for_pattern(self,
-                    'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_vendor',
-                    '0x1af4')
+                    r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_vendor',
+                    r'0x1af4')
         exec_command_and_wait_for_pattern(self,
-                    'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_device',
-                    '0x0001')
+                    r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_device',
+                    r'0x0001')
         # check fid propagation
         exec_command_and_wait_for_pattern(self,
-                        'cat /sys/bus/pci/devices/000a\:00\:00.0/function_id',
-                        '0x0000000c')
+                    r'cat /sys/bus/pci/devices/000a\:00\:00.0/function_id',
+                    r'0x0000000c')
         # add another device
         self.clear_guest_dmesg()
         self.vm.cmd('device_add', driver='virtio-net-ccw',
@@ -235,7 +235,7 @@ def test_s390x_fedora(self):
                         'while ! (dmesg | grep gpudrmfb) ; do sleep 1 ; done',
                         'virtio_gpudrmfb frame buffer device')
             exec_command_and_wait_for_pattern(self,
-                'echo -e "\e[?25l" > /dev/tty0', ':/#')
+                r'echo -e "\e[?25l" > /dev/tty0', ':/#')
             exec_command_and_wait_for_pattern(self, 'for ((i=0;i<250;i++)); do '
                 'echo " The  qu ick  fo x j ump s o ver  a  laz y d og" >> fox.txt;'
                 'done',
-- 
2.41.0



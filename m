Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ED97EE0FC
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 14:02:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3bzP-0000PO-3Q; Thu, 16 Nov 2023 08:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r3bzA-0000Lp-C6
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:00:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r3bz7-0007e3-2y
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700139629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AQuFmj0jMzEFdih45oeivi5MMVVyGrfsPJwS4X2kEZE=;
 b=SmCnUnSCvLh/uMqgjwSTDjoBix0BYK9WISlHJIMuIM4YN0bcMn7NV8wP/TwIR26lTdH1Gt
 RbL8t+IWgoiyBzNSVm04VREUVoY2g0ge+JjZVNZ0nCx46EWmp4ZwEw7VQqvzvDu76in14r
 TDzuSRS82lO0Y29sYGKiSvZUhoILp64=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-KahXGICiPE2IETxMsjWKmg-1; Thu,
 16 Nov 2023 08:00:26 -0500
X-MC-Unique: KahXGICiPE2IETxMsjWKmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89FC4381AE57;
 Thu, 16 Nov 2023 13:00:25 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C51AD2026D68;
 Thu, 16 Nov 2023 13:00:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 Virtio-ccw)
Subject: [PATCH] avocado: fix Python invalid escape sequence
Date: Thu, 16 Nov 2023 17:00:22 +0400
Message-ID: <20231116130022.1270356-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This is an error in Python 3.12; fix it by using a raw string literal.

Cc: qemu-stable@nongnu.org
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/avocado/machine_s390_ccw_virtio.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/avocado/machine_s390_ccw_virtio.py b/tests/avocado/machine_s390_ccw_virtio.py
index e1f493bc44..74a52c506d 100644
--- a/tests/avocado/machine_s390_ccw_virtio.py
+++ b/tests/avocado/machine_s390_ccw_virtio.py
@@ -36,7 +36,7 @@ def wait_for_crw_reports(self):
     dmesg_clear_count = 1
     def clear_guest_dmesg(self):
         exec_command_and_wait_for_pattern(self, 'dmesg -c > /dev/null; '
-                    'echo dm_clear\ ' + str(self.dmesg_clear_count),
+                    r'echo dm_clear\ ' + str(self.dmesg_clear_count),
                     'dm_clear ' + str(self.dmesg_clear_count))
         self.dmesg_clear_count += 1
 
@@ -121,14 +121,14 @@ def test_s390x_devices(self):
                                     'cat /sys/bus/ccw/devices/0.1.1111/cutype',
                                     '3832/01')
         exec_command_and_wait_for_pattern(self,
-                    'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_vendor',
+                    r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_vendor',
                     '0x1af4')
         exec_command_and_wait_for_pattern(self,
-                    'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_device',
+                    r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_device',
                     '0x0001')
         # check fid propagation
         exec_command_and_wait_for_pattern(self,
-                        'cat /sys/bus/pci/devices/000a\:00\:00.0/function_id',
+                        r'cat /sys/bus/pci/devices/000a\:00\:00.0/function_id',
                         '0x0000000c')
         # add another device
         self.clear_guest_dmesg()
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



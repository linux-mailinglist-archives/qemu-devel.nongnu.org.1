Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FFCA9814A
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Apr 2025 09:40:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Ufe-0003nk-5y; Wed, 23 Apr 2025 03:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Ufc-0003gQ-0v
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UfZ-0003LG-4J
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1UNzmj4bAkwrOZaRDYriBwbMjAFqLpskQ9wXIXBclec=;
 b=hJ9d4MhtLs6NzttUnzTeyujxOEg4wsZsb9Aa9stDrsak2LMgJNsdiJ2EaCH5076x28AlX9
 o/lGXrdQUsJVL01PI1IDESYDsPEPLxnemvvKs48VlaSsSzu2B4X315FsjblREy4i3bA4sT
 X5S6U3EqwQKthhHzcvegsj5rZGFBe+g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-Tc3sOrDAMD2PKxTlW7JZyA-1; Wed,
 23 Apr 2025 03:37:16 -0400
X-MC-Unique: Tc3sOrDAMD2PKxTlW7JZyA-1
X-Mimecast-MFC-AGG-ID: Tc3sOrDAMD2PKxTlW7JZyA_1745393835
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DC31180034E; Wed, 23 Apr 2025 07:37:15 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE42C19560A3; Wed, 23 Apr 2025 07:37:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 27/29] tests/functional: Remove semicolons at the end of lines
Date: Wed, 23 Apr 2025 09:36:07 +0200
Message-ID: <20250423073610.271585-28-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Yes, we are all C coders who try to write Python code for testing...
but still, let's better avoid semicolons at the end of the lines
to keep "pylint" happy!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20250327201305.996241-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/aspeed.py                    |  2 +-
 tests/functional/test_aarch64_aspeed.py       |  2 +-
 tests/functional/test_arm_aspeed_ast2500.py   |  6 ++--
 tests/functional/test_arm_aspeed_ast2600.py   | 36 +++++++++----------
 tests/functional/test_arm_aspeed_bletchley.py |  4 +--
 tests/functional/test_arm_aspeed_palmetto.py  |  4 +--
 tests/functional/test_arm_aspeed_romulus.py   |  4 +--
 .../functional/test_arm_aspeed_witherspoon.py |  4 +--
 tests/functional/test_arm_bpim2u.py           |  2 +-
 tests/functional/test_arm_cubieboard.py       |  2 +-
 tests/functional/test_arm_orangepi.py         |  2 +-
 tests/functional/test_s390x_topology.py       | 12 +++----
 12 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
index 77dc8930fa4..7a40d5dda73 100644
--- a/tests/functional/aspeed.py
+++ b/tests/functional/aspeed.py
@@ -44,7 +44,7 @@ def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'
 
     def do_test_arm_aspeed_buildroot_poweroff(self):
         exec_command_and_wait_for_pattern(self, 'poweroff',
-                                          'System halted');
+                                          'System halted')
 
     def do_test_arm_aspeed_sdk_start(self, image):
         self.require_netdev('user')
diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
index c25c9662782..c7f3b3b319f 100755
--- a/tests/functional/test_aarch64_aspeed.py
+++ b/tests/functional/test_aarch64_aspeed.py
@@ -85,7 +85,7 @@ def start_ast2700_test(self, name):
 
         exec_command_and_wait_for_pattern(self,
             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
-            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d');
+            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d')
         exec_command_and_wait_for_pattern(self,
             'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '0')
         self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
diff --git a/tests/functional/test_arm_aspeed_ast2500.py b/tests/functional/test_arm_aspeed_ast2500.py
index 1ffba6c9953..ddc6459f710 100755
--- a/tests/functional/test_arm_aspeed_ast2500.py
+++ b/tests/functional/test_arm_aspeed_ast2500.py
@@ -22,17 +22,17 @@ def test_arm_ast2500_evb_buildroot(self):
         image_path = self.ASSET_BR2_202411_AST2500_FLASH.fetch()
 
         self.vm.add_args('-device',
-                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
+                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test')
         self.do_test_arm_aspeed_buildroot_start(image_path, '0x0',
                                                 'ast2500-evb login:')
 
         exec_command_and_wait_for_pattern(self,
              'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
-             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d');
+             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d')
         exec_command_and_wait_for_pattern(self,
                              'cat /sys/class/hwmon/hwmon1/temp1_input', '0')
         self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
-                    property='temperature', value=18000);
+                    property='temperature', value=18000)
         exec_command_and_wait_for_pattern(self,
                              'cat /sys/class/hwmon/hwmon1/temp1_input', '18000')
 
diff --git a/tests/functional/test_arm_aspeed_ast2600.py b/tests/functional/test_arm_aspeed_ast2600.py
index 6ae4ed636ac..5ef52f06595 100755
--- a/tests/functional/test_arm_aspeed_ast2600.py
+++ b/tests/functional/test_arm_aspeed_ast2600.py
@@ -27,38 +27,38 @@ def test_arm_ast2600_evb_buildroot(self):
         image_path = self.ASSET_BR2_202411_AST2600_FLASH.fetch()
 
         self.vm.add_args('-device',
-                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
+                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test')
         self.vm.add_args('-device',
-                         'ds1338,bus=aspeed.i2c.bus.3,address=0x32');
+                         'ds1338,bus=aspeed.i2c.bus.3,address=0x32')
         self.vm.add_args('-device',
-                         'i2c-echo,bus=aspeed.i2c.bus.3,address=0x42');
+                         'i2c-echo,bus=aspeed.i2c.bus.3,address=0x42')
         self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00',
                                                 'ast2600-evb login:')
 
         exec_command_and_wait_for_pattern(self,
              'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
-             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d');
+             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d')
         exec_command_and_wait_for_pattern(self,
                              'cat /sys/class/hwmon/hwmon1/temp1_input', '0')
         self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
-                    property='temperature', value=18000);
+                    property='temperature', value=18000)
         exec_command_and_wait_for_pattern(self,
                              'cat /sys/class/hwmon/hwmon1/temp1_input', '18000')
 
         exec_command_and_wait_for_pattern(self,
              'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-3/device/new_device',
-             'i2c i2c-3: new_device: Instantiated device ds1307 at 0x32');
+             'i2c i2c-3: new_device: Instantiated device ds1307 at 0x32')
         year = time.strftime("%Y")
-        exec_command_and_wait_for_pattern(self, 'hwclock -f /dev/rtc1', year);
+        exec_command_and_wait_for_pattern(self, 'hwclock -f /dev/rtc1', year)
 
         exec_command_and_wait_for_pattern(self,
              'echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-3/new_device',
-             'i2c i2c-3: new_device: Instantiated device slave-24c02 at 0x64');
+             'i2c i2c-3: new_device: Instantiated device slave-24c02 at 0x64')
         exec_command_and_wait_for_pattern(self,
-             'i2cset -y 3 0x42 0x64 0x00 0xaa i', '#');
+             'i2cset -y 3 0x42 0x64 0x00 0xaa i', '#')
         exec_command_and_wait_for_pattern(self,
              'hexdump /sys/bus/i2c/devices/3-1064/slave-eeprom',
-             '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff');
+             '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff')
         self.do_test_arm_aspeed_buildroot_poweroff()
 
     ASSET_BR2_202302_AST2600_TPM_FLASH = Asset(
@@ -90,10 +90,10 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
 
         exec_command_and_wait_for_pattern(self,
             'echo tpm_tis_i2c 0x2e > /sys/bus/i2c/devices/i2c-12/new_device',
-            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)');
+            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)')
         exec_command_and_wait_for_pattern(self,
             'cat /sys/class/tpm/tpm0/pcr-sha256/0',
-            'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431688E0');
+            'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431688E0')
 
         self.do_test_arm_aspeed_buildroot_poweroff()
 
@@ -107,9 +107,9 @@ def test_arm_ast2600_evb_sdk(self):
         self.archive_extract(self.ASSET_SDK_V806_AST2600_A2)
 
         self.vm.add_args('-device',
-            'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test');
+            'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
         self.vm.add_args('-device',
-            'ds1338,bus=aspeed.i2c.bus.5,address=0x32');
+            'ds1338,bus=aspeed.i2c.bus.5,address=0x32')
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2600-a2", "image-bmc"))
 
@@ -120,20 +120,20 @@ def test_arm_ast2600_evb_sdk(self):
 
         exec_command_and_wait_for_pattern(self,
             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-5/device/new_device',
-            'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d');
+            'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d')
         exec_command_and_wait_for_pattern(self,
              'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
         self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
-                    property='temperature', value=18000);
+                    property='temperature', value=18000)
         exec_command_and_wait_for_pattern(self,
              'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
 
         exec_command_and_wait_for_pattern(self,
              'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-5/device/new_device',
-             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32');
+             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32')
         year = time.strftime("%Y")
         exec_command_and_wait_for_pattern(self,
-             '/sbin/hwclock -f /dev/rtc1', year);
+             '/sbin/hwclock -f /dev/rtc1', year)
 
 if __name__ == '__main__':
     AspeedTest.main()
diff --git a/tests/functional/test_arm_aspeed_bletchley.py b/tests/functional/test_arm_aspeed_bletchley.py
index 0da856c5ed4..5a60b24b3d2 100644
--- a/tests/functional/test_arm_aspeed_bletchley.py
+++ b/tests/functional/test_arm_aspeed_bletchley.py
@@ -12,14 +12,14 @@ class BletchleyMachine(AspeedTest):
 
     ASSET_BLETCHLEY_FLASH = Asset(
         'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/bletchley-bmc/openbmc-20250128071329/obmc-phosphor-image-bletchley-20250128071329.static.mtd.xz',
-        'db21d04d47d7bb2a276f59d308614b4dfb70b9c7c81facbbca40a3977a2d8844');
+        'db21d04d47d7bb2a276f59d308614b4dfb70b9c7c81facbbca40a3977a2d8844')
 
     def test_arm_ast2600_bletchley_openbmc(self):
         image_path = self.uncompress(self.ASSET_BLETCHLEY_FLASH)
 
         self.do_test_arm_aspeed_openbmc('bletchley-bmc', image=image_path,
                                         uboot='2019.04', cpu_id='0xf00',
-                                        soc='AST2600 rev A3');
+                                        soc='AST2600 rev A3')
 
 if __name__ == '__main__':
     AspeedTest.main()
diff --git a/tests/functional/test_arm_aspeed_palmetto.py b/tests/functional/test_arm_aspeed_palmetto.py
index 35d832bc98e..ff0b821be65 100755
--- a/tests/functional/test_arm_aspeed_palmetto.py
+++ b/tests/functional/test_arm_aspeed_palmetto.py
@@ -12,14 +12,14 @@ class PalmettoMachine(AspeedTest):
 
     ASSET_PALMETTO_FLASH = Asset(
         'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/palmetto-bmc/openbmc-20250128071432/obmc-phosphor-image-palmetto-20250128071432.static.mtd',
-        'bce7c392eec75c707a91cfc8fad7ca9a69d7e4f10df936930d65c1cb9897ac81');
+        'bce7c392eec75c707a91cfc8fad7ca9a69d7e4f10df936930d65c1cb9897ac81')
 
     def test_arm_ast2400_palmetto_openbmc(self):
         image_path = self.ASSET_PALMETTO_FLASH.fetch()
 
         self.do_test_arm_aspeed_openbmc('palmetto-bmc', image=image_path,
                                         uboot='2019.04', cpu_id='0x0',
-                                        soc='AST2400 rev A1');
+                                        soc='AST2400 rev A1')
 
 if __name__ == '__main__':
     AspeedTest.main()
diff --git a/tests/functional/test_arm_aspeed_romulus.py b/tests/functional/test_arm_aspeed_romulus.py
index b97ed951b1f..0447212bbf0 100755
--- a/tests/functional/test_arm_aspeed_romulus.py
+++ b/tests/functional/test_arm_aspeed_romulus.py
@@ -12,14 +12,14 @@ class RomulusMachine(AspeedTest):
 
     ASSET_ROMULUS_FLASH = Asset(
         'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/romulus-bmc/openbmc-20250128071340/obmc-phosphor-image-romulus-20250128071340.static.mtd',
-        '6d031376440c82ed9d087d25e9fa76aea75b42f80daa252ec402c0bc3cf6cf5b');
+        '6d031376440c82ed9d087d25e9fa76aea75b42f80daa252ec402c0bc3cf6cf5b')
 
     def test_arm_ast2500_romulus_openbmc(self):
         image_path = self.ASSET_ROMULUS_FLASH.fetch()
 
         self.do_test_arm_aspeed_openbmc('romulus-bmc', image=image_path,
                                         uboot='2019.04', cpu_id='0x0',
-                                        soc='AST2500 rev A1');
+                                        soc='AST2500 rev A1')
 
 if __name__ == '__main__':
     AspeedTest.main()
diff --git a/tests/functional/test_arm_aspeed_witherspoon.py b/tests/functional/test_arm_aspeed_witherspoon.py
index ea1ce89b05c..51a2d47af28 100644
--- a/tests/functional/test_arm_aspeed_witherspoon.py
+++ b/tests/functional/test_arm_aspeed_witherspoon.py
@@ -12,14 +12,14 @@ class WitherspoonMachine(AspeedTest):
 
     ASSET_WITHERSPOON_FLASH = Asset(
         'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/witherspoon-bmc/openbmc-20240618035022/obmc-phosphor-image-witherspoon-20240618035022.ubi.mtd',
-        '937d9ed449ea6c6cbed983519088a42d0cafe276bcfe4fce07772ca6673f9213');
+        '937d9ed449ea6c6cbed983519088a42d0cafe276bcfe4fce07772ca6673f9213')
 
     def test_arm_ast2500_witherspoon_openbmc(self):
         image_path = self.ASSET_WITHERSPOON_FLASH.fetch()
 
         self.do_test_arm_aspeed_openbmc('witherspoon-bmc', image=image_path,
                                         uboot='2016.07', cpu_id='0x0',
-                                        soc='AST2500 rev A1');
+                                        soc='AST2500 rev A1')
 
 if __name__ == '__main__':
     AspeedTest.main()
diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/test_arm_bpim2u.py
index 8de6ccba881..8bed64b702f 100755
--- a/tests/functional/test_arm_bpim2u.py
+++ b/tests/functional/test_arm_bpim2u.py
@@ -163,7 +163,7 @@ def test_arm_bpim2u_openwrt_22_03_3(self):
                 self, 'Hit any key to stop autoboot:', '=>')
         exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
                                                 kernel_command_line + "'", '=>')
-        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
+        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...')
 
         self.wait_for_console_pattern(
             'Please press Enter to activate this console.')
diff --git a/tests/functional/test_arm_cubieboard.py b/tests/functional/test_arm_cubieboard.py
index b87a28154da..1eaca0272bb 100755
--- a/tests/functional/test_arm_cubieboard.py
+++ b/tests/functional/test_arm_cubieboard.py
@@ -128,7 +128,7 @@ def test_arm_cubieboard_openwrt_22_03_2(self):
                 self, 'Hit any key to stop autoboot:', '=>')
         exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
                                                 kernel_command_line + "'", '=>')
-        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
+        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...')
 
         self.wait_for_console_pattern(
             'Please press Enter to activate this console.')
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index 1815f56e027..f9bfa8c78d9 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -174,7 +174,7 @@ def test_arm_orangepi_armbian(self):
         exec_command_and_wait_for_pattern(self, ' ', '=>')
         exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
                                                 kernel_command_line + "'", '=>')
-        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
+        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...')
 
         self.wait_for_console_pattern('systemd[1]: Hostname set ' +
                                       'to <orangepipc>')
diff --git a/tests/functional/test_s390x_topology.py b/tests/functional/test_s390x_topology.py
index eefd9729cb2..1b5dc651353 100755
--- a/tests/functional/test_s390x_topology.py
+++ b/tests/functional/test_s390x_topology.py
@@ -217,12 +217,12 @@ def test_polarization(self):
         self.assertEqual(res['return']['polarization'], 'horizontal')
         self.check_topology(0, 0, 0, 0, 'medium', False)
 
-        self.guest_set_dispatching('1');
+        self.guest_set_dispatching('1')
         res = self.vm.qmp('query-s390x-cpu-polarization')
         self.assertEqual(res['return']['polarization'], 'vertical')
         self.check_topology(0, 0, 0, 0, 'medium', False)
 
-        self.guest_set_dispatching('0');
+        self.guest_set_dispatching('0')
         res = self.vm.qmp('query-s390x-cpu-polarization')
         self.assertEqual(res['return']['polarization'], 'horizontal')
         self.check_topology(0, 0, 0, 0, 'medium', False)
@@ -283,7 +283,7 @@ def test_entitlement(self):
         self.check_polarization('vertical:high')
         self.check_topology(0, 0, 0, 0, 'high', False)
 
-        self.guest_set_dispatching('0');
+        self.guest_set_dispatching('0')
         self.check_polarization("horizontal")
         self.check_topology(0, 0, 0, 0, 'high', False)
 
@@ -310,11 +310,11 @@ def test_dedicated(self):
         self.check_topology(0, 0, 0, 0, 'high', True)
         self.check_polarization("horizontal")
 
-        self.guest_set_dispatching('1');
+        self.guest_set_dispatching('1')
         self.check_topology(0, 0, 0, 0, 'high', True)
         self.check_polarization("vertical:high")
 
-        self.guest_set_dispatching('0');
+        self.guest_set_dispatching('0')
         self.check_topology(0, 0, 0, 0, 'high', True)
         self.check_polarization("horizontal")
 
@@ -360,7 +360,7 @@ def test_dedicated_error(self):
 
         self.check_topology(0, 0, 0, 0, 'high', True)
 
-        self.guest_set_dispatching('1');
+        self.guest_set_dispatching('1')
 
         self.check_topology(0, 0, 0, 0, 'high', True)
 
-- 
2.49.0



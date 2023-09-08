Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D821679853B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:57:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYE6-00079k-1i; Fri, 08 Sep 2023 05:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYE3-00077k-6V; Fri, 08 Sep 2023 05:56:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDy-0006la-DY; Fri, 08 Sep 2023 05:56:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D11E3200D1;
 Fri,  8 Sep 2023 12:56:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CF57226917;
 Fri,  8 Sep 2023 12:55:57 +0300 (MSK)
Received: (nullmailer pid 275967 invoked by uid 1000);
 Fri, 08 Sep 2023 09:55:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 09/23] tests/: spelling fixes
Date: Fri,  8 Sep 2023 12:55:06 +0300
Message-Id: <20230908095520.275866-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230908095520.275866-1-mjt@tls.msk.ru>
References: <20230908095520.275866-1-mjt@tls.msk.ru>
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

with some rewording in
 tests/qemu-iotests/298
 tests/qtest/fuzz/generic_fuzz.c
 tests/unit/test-throttle.c
as suggested by Eric.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/avocado/acpi-bits.py                      |  4 ++--
 tests/avocado/acpi-bits/bits-tests/testacpi.py2 |  4 ++--
 tests/decode/err_pattern_group_ident2.decode    |  2 +-
 tests/docker/common.rc                          |  2 +-
 tests/migration/guestperf-batch.py              |  2 +-
 tests/migration/guestperf.py                    |  2 +-
 tests/plugin/mem.c                              |  2 +-
 tests/qapi-schema/bad-if-not.json               |  2 +-
 tests/qemu-iotests/029                          |  2 +-
 tests/qemu-iotests/040                          |  8 ++++----
 tests/qemu-iotests/046                          |  2 +-
 tests/qemu-iotests/059                          |  2 +-
 tests/qemu-iotests/061                          |  2 +-
 tests/qemu-iotests/071                          |  2 +-
 tests/qemu-iotests/197                          |  2 +-
 tests/qemu-iotests/215                          |  2 +-
 tests/qemu-iotests/298                          |  4 ++--
 tests/qemu-iotests/pylintrc                     |  2 +-
 tests/qtest/ahci-test.c                         |  2 +-
 tests/qtest/bcm2835-dma-test.c                  |  2 +-
 tests/qtest/bios-tables-test.c                  |  2 +-
 tests/qtest/ds1338-test.c                       |  2 +-
 tests/qtest/fuzz/generic_fuzz.c                 |  6 +++---
 tests/qtest/libqos/qgraph.c                     |  4 ++--
 tests/qtest/libqos/qgraph_internal.h            |  2 +-
 tests/qtest/libqos/virtio-gpio.c                |  2 +-
 tests/qtest/libqtest.c                          |  4 ++--
 tests/qtest/migration-test.c                    |  6 +++---
 tests/qtest/npcm7xx_timer-test.c                |  2 +-
 tests/qtest/tpm-emu.c                           |  2 +-
 tests/qtest/tpm-tests.c                         |  2 +-
 tests/qtest/tpm-tests.h                         |  2 +-
 tests/qtest/tpm-tis-i2c-test.c                  |  2 +-
 tests/qtest/tpm-tis-util.c                      |  2 +-
 tests/qtest/vhost-user-blk-test.c               |  2 +-
 tests/qtest/virtio-net-test.c                   |  2 +-
 tests/qtest/vmgenid-test.c                      |  2 +-
 tests/tsan/suppressions.tsan                    |  2 +-
 tests/uefi-test-tools/Makefile                  |  2 +-
 tests/unit/check-qjson.c                        |  2 +-
 tests/unit/test-aio.c                           |  2 +-
 tests/unit/test-bdrv-graph-mod.c                | 12 ++++++------
 tests/unit/test-crypto-secret.c                 |  2 +-
 tests/unit/test-qobject-input-visitor.c         |  2 +-
 tests/unit/test-throttle.c                      |  8 ++++----
 tests/unit/test-util-filemonitor.c              |  2 +-
 tests/unit/test-xs-node.c                       |  2 +-
 tests/vm/Makefile.include                       |  2 +-
 tests/vm/ubuntuvm.py                            |  2 +-
 49 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/tests/avocado/acpi-bits.py b/tests/avocado/acpi-bits.py
index 3ed286dcbd..bb3f818689 100644
--- a/tests/avocado/acpi-bits.py
+++ b/tests/avocado/acpi-bits.py
@@ -1,6 +1,6 @@
 #!/usr/bin/env python3
 # group: rw quick
-# Exercize QEMU generated ACPI/SMBIOS tables using biosbits,
+# Exercise QEMU generated ACPI/SMBIOS tables using biosbits,
 # https://biosbits.org/
 #
 # This program is free software; you can redistribute it and/or modify
@@ -366,7 +366,7 @@ def tearDown(self):
         super().tearDown()
 
     def test_acpi_smbios_bits(self):
-        """The main test case implementaion."""
+        """The main test case implementation."""
 
         iso_file = os.path.join(self._workDir,
                                 'bits-%d.iso' %self._bitsInternalVer)
diff --git a/tests/avocado/acpi-bits/bits-tests/testacpi.py2 b/tests/avocado/acpi-bits/bits-tests/testacpi.py2
index f818a9cce6..7bf9075c1b 100644
--- a/tests/avocado/acpi-bits/bits-tests/testacpi.py2
+++ b/tests/avocado/acpi-bits/bits-tests/testacpi.py2
@@ -273,8 +273,8 @@ def test_rsdp():
 
     # Checksum the first 20 bytes per ACPI 1.0
     csum = sum(ord(c) for c in data[:20]) % 0x100
-    testsuite.test('ACPI 1.0 table first 20 bytes cummulative checksum must equal 0', csum == 0)
-    testsuite.print_detail("Cummulative checksum = {} (Expected 0)".format(csum))
+    testsuite.test('ACPI 1.0 table first 20 bytes cumulative checksum must equal 0', csum == 0)
+    testsuite.print_detail("Cumulative checksum = {} (Expected 0)".format(csum))
 
     test_table_checksum(data)
     rsdp = acpi.parse_rsdp()
diff --git a/tests/decode/err_pattern_group_ident2.decode b/tests/decode/err_pattern_group_ident2.decode
index bc859233b1..0abb7513e9 100644
--- a/tests/decode/err_pattern_group_ident2.decode
+++ b/tests/decode/err_pattern_group_ident2.decode
@@ -7,5 +7,5 @@
 {
   top      00000000 00000000 00000000 00000000
   sub1     00000000 00000000 00000000 ........ %sub1
-# comments are suposed to be indented
+# comments are supposed to be indented
 }
diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 9a33df2832..a611e6adf9 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -12,7 +12,7 @@
 # the top-level directory.
 
 # This might be set by ENV of a docker container... it is always
-# overriden by TARGET_LIST if the user sets it. We special case
+# overridden by TARGET_LIST if the user sets it. We special case
 # "none" to allow for other options like --disable-tcg to restrict the
 # builds we eventually do.
 if test "$DEF_TARGET_LIST" = "none"; then
diff --git a/tests/migration/guestperf-batch.py b/tests/migration/guestperf-batch.py
index ab6bdb9d38..9485eefe49 100755
--- a/tests/migration/guestperf-batch.py
+++ b/tests/migration/guestperf-batch.py
@@ -1,6 +1,6 @@
 #!/usr/bin/env python3
 #
-# Migration test batch comparison invokation
+# Migration test batch comparison invocation
 #
 # Copyright (c) 2016 Red Hat, Inc.
 #
diff --git a/tests/migration/guestperf.py b/tests/migration/guestperf.py
index e8cc127fd0..07182f211e 100755
--- a/tests/migration/guestperf.py
+++ b/tests/migration/guestperf.py
@@ -1,6 +1,6 @@
 #!/usr/bin/env python3
 #
-# Migration test direct invokation command
+# Migration test direct invocation command
 #
 # Copyright (c) 2016 Red Hat, Inc.
 #
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index f3b9f696a0..44e91065ba 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -98,7 +98,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             } else if (g_strcmp0(tokens[1], "rw") == 0) {
                 rw = QEMU_PLUGIN_MEM_RW;
             } else {
-                fprintf(stderr, "invaild value for argument track: %s\n", opt);
+                fprintf(stderr, "invalid value for argument track: %s\n", opt);
                 return -1;
             }
         } else if (g_strcmp0(tokens[0], "inline") == 0) {
diff --git a/tests/qapi-schema/bad-if-not.json b/tests/qapi-schema/bad-if-not.json
index 9fdaacc47b..660fc4feb2 100644
--- a/tests/qapi-schema/bad-if-not.json
+++ b/tests/qapi-schema/bad-if-not.json
@@ -1,3 +1,3 @@
-# check 'if not' with empy argument
+# check 'if not' with empty argument
 { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
   'if': { 'not': '' } }
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index bd71dd2f22..7f4849b97b 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 . ./common.pattern
 
-# Any format supporting intenal snapshots
+# Any format supporting internal snapshots
 _supported_fmt qcow2
 _supported_proto generic
 # Internal snapshots are (currently) impossible with refcount_bits=1,
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 30eb97829e..5601a4873c 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -845,7 +845,7 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.assertIsNone(self.vm.node_info('cow-2'))
         self.assertIsNotNone(self.vm.node_info('cow-1'))
 
-        # 2 has been comitted into 1
+        # 2 has been committed into 1
         self.pattern_files[2] = self.img1
 
     def test_commit_through_filter(self):
@@ -863,7 +863,7 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.assertIsNone(self.vm.node_info('bottom-filter'))
         self.assertIsNotNone(self.vm.node_info('cow-0'))
 
-        # 1 has been comitted into 0
+        # 1 has been committed into 0
         self.pattern_files[1] = self.img0
 
     def test_filtered_active_commit_with_filter(self):
@@ -900,7 +900,7 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         drv0 = next(dev for dev in blockdevs if dev['qdev'] == 'drv0')
         self.assertEqual(drv0['inserted']['node-name'], 'cow-2')
 
-        # 3 has been comitted into 2
+        # 3 has been committed into 2
         self.pattern_files[3] = self.img2
 
     def test_filtered_active_commit_without_filter(self):
@@ -916,7 +916,7 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.assertIsNone(self.vm.node_info('cow-3'))
         self.assertIsNotNone(self.vm.node_info('cow-2'))
 
-        # 3 has been comitted into 2
+        # 3 has been committed into 2
         self.pattern_files[3] = self.img2
 
 class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 517b162508..4c9ed4d26e 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -125,7 +125,7 @@ aio_flush
 EOF
 
 # Sequential write, but the next cluster is already allocated
-# and phyiscally in the right position
+# and physically in the right position
 cat  <<EOF
 write -P 89 0x80000 0x1000
 write -P 90 0x96000 0x8000
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index e8be217e1f..2bcb1f7f9c 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -182,7 +182,7 @@ done
 echo
 echo "=== Testing afl image with a very large capacity ==="
 _use_sample_img afl9.vmdk.bz2
-_img_info | grep -q 'Cannot allocate memory' && _notrun "Insufficent memory, skipped test"
+_img_info | grep -q 'Cannot allocate memory' && _notrun "Insufficient memory, skipped test"
 _img_info
 _cleanup_test_img
 
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 509ad247cd..53c7d428e3 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -49,7 +49,7 @@ _supported_os Linux
 # we have explicit tests for various cluster sizes, the remaining tests
 # require the default 64k cluster
 # we don't have explicit tests for zstd qcow2 compression type, as zstd may be
-# not compiled in. And we can't create compat images with comression type
+# not compiled in. And we can't create compat images with compression type
 # extension
 _unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)' data_file \
     cluster_size compression_type
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 27bc7305bf..331f8cfddc 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -41,7 +41,7 @@ _supported_fmt qcow2
 _supported_proto file fuse
 _require_drivers blkdebug blkverify
 # blkdebug can only inject errors on bs->file, not on the data_file,
-# so thie test does not work with external data files
+# so this test does not work with external data files
 _unsupported_imgopts data_file
 
 do_run_qemu()
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index f07a9da136..85d980c755 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -93,7 +93,7 @@ output=$($QEMU_IO -f qcow2 -C -c "read -P 0 1k $((2*1024*1024*1024 - 512))" \
         "$TEST_WRAP" 2>&1 | _filter_qemu_io)
 case $output in
     *allocate*)
-        _notrun "Insufficent memory to run test" ;;
+        _notrun "Insufficient memory to run test" ;;
     *) printf '%s\n' "$output" ;;
 esac
 $QEMU_IO -f qcow2 -C -c "read -P 0 $((3*1024*1024*1024 + 1024)) 1k" \
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index d464596f14..6babbcdc1f 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -95,7 +95,7 @@ output=$($QEMU_IO \
          2>&1 | _filter_qemu_io)
 case $output in
     *allocate*)
-        _notrun "Insufficent memory to run test" ;;
+        _notrun "Insufficient memory to run test" ;;
     *) printf '%s\n' "$output" ;;
 esac
 $QEMU_IO \
diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
index ad560e2941..9e75ac6975 100755
--- a/tests/qemu-iotests/298
+++ b/tests/qemu-iotests/298
@@ -140,8 +140,8 @@ class TestTruncate(iotests.QMPTestCase):
         stat = os.stat(disk)
         refstat = os.stat(refdisk)
 
-        # Probably we'll want preallocate filter to keep align to cluster when
-        # shrink preallocation, so, ignore small differece
+        # The preallocate filter may keep cluster alignment when shrinking,
+        # so ignore small differences
         self.assertLess(abs(stat.st_size - refstat.st_size), 64 * 1024)
 
         # Preallocate filter may leak some internal clusters (for example, if
diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
index f4f823a991..de2e0c2781 100644
--- a/tests/qemu-iotests/pylintrc
+++ b/tests/qemu-iotests/pylintrc
@@ -19,7 +19,7 @@ disable=invalid-name,
         too-many-public-methods,
         # pylint warns about Optional[] etc. as unsubscriptable in 3.9
         unsubscriptable-object,
-        # pylint's static analysis causes false positivies for file_path();
+        # pylint's static analysis causes false positives for file_path();
         # If we really care to make it statically knowable, we'll use mypy.
         unbalanced-tuple-unpacking,
         # Sometimes we need to disable a newly introduced pylint warning.
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index abab761c26..eea8b5f77b 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -330,7 +330,7 @@ static void ahci_test_pci_spec(AHCIQState *ahci)
     ASSERT_BIT_CLEAR(datal, ~0xFF);
     g_assert_cmphex(datal, !=, 0);
 
-    /* Check specification adherence for capability extenstions. */
+    /* Check specification adherence for capability extensions. */
     data = qpci_config_readw(ahci->dev, datal);
 
     switch (ahci->fingerprint) {
diff --git a/tests/qtest/bcm2835-dma-test.c b/tests/qtest/bcm2835-dma-test.c
index 8293d822b9..18901b76d2 100644
--- a/tests/qtest/bcm2835-dma-test.c
+++ b/tests/qtest/bcm2835-dma-test.c
@@ -25,7 +25,7 @@
 
 #define BCM2708_DMA_INT_STATUS 0xfe0
 
-/* DMA Trasfer Info fields: */
+/* DMA Transfer Info fields: */
 #define BCM2708_DMA_INT_EN     (1 << 0)
 #define BCM2708_DMA_D_INC      (1 << 4)
 #define BCM2708_DMA_S_INC      (1 << 8)
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index dd06e6300a..d1b80149f2 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -26,7 +26,7 @@
  * 4. Run
  *      make check V=2
  * this will produce a bunch of warnings about differences
- * beween actual and expected ACPI tables. If you have IASL installed,
+ * between actual and expected ACPI tables. If you have IASL installed,
  * they will also be disassembled so you can look at the disassembled
  * output. If not - disassemble them yourself in any way you like.
  * Look at the differences - make sure they make sense and match what the
diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index f6ade9a050..d12424d27f 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -38,7 +38,7 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
 
     i2c_read_block(i2cdev, 0, resp, sizeof(resp));
 
-    /* check retrieved time againt local time */
+    /* check retrieved time against local time */
     g_assert_cmpuint(bcd2bin(resp[4]), == , tm_ptr->tm_mday);
     g_assert_cmpuint(bcd2bin(resp[5]), == , 1 + tm_ptr->tm_mon);
     g_assert_cmpuint(2000 + bcd2bin(resp[6]), == , 1900 + tm_ptr->tm_year);
diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 11256abf6c..ec842e03c5 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -846,9 +846,9 @@ static void generic_pre_fuzz(QTestState *s)
  *          functionality B
  *
  * This function attempts to produce an input that:
- * Ouptut: maps a device's BARs, set up three DMA patterns, triggers
- *          functionality A device, replaces the DMA patterns with a single
- *          patten, and triggers device functionality B.
+ * Output: maps a device's BARs, set up three DMA patterns, triggers
+ *          device functionality A, replaces the DMA patterns with a single
+ *          pattern, and triggers device functionality B.
  */
 static size_t generic_fuzz_crossover(const uint8_t *data1, size_t size1, const
                                      uint8_t *data2, size_t size2, uint8_t *out,
diff --git a/tests/qtest/libqos/qgraph.c b/tests/qtest/libqos/qgraph.c
index 0a2dddfafa..2029bf9804 100644
--- a/tests/qtest/libqos/qgraph.c
+++ b/tests/qtest/libqos/qgraph.c
@@ -54,7 +54,7 @@ struct QOSStackElement {
     int length;
 };
 
-/* Each enty in these hash table will consist of <string, node/edge> pair. */
+/* Each entry in these hash table will consist of <string, node/edge> pair. */
 static GHashTable *edge_table;
 static GHashTable *node_table;
 
@@ -214,7 +214,7 @@ static QOSGraphEdge *search_list_edges(QOSGraphEdgeList *edgelist,
 /**
  * search_machine(): search for a machine @name in the node hash
  * table. A machine is the child of the root node.
- * This function forces the research in the childs of the root,
+ * This function forces the research in the children of the root,
  * to check the node is a proper machine
  *
  * Returns: on success: the %QOSGraphNode
diff --git a/tests/qtest/libqos/qgraph_internal.h b/tests/qtest/libqos/qgraph_internal.h
index 7d62fd17af..87fab1f9f0 100644
--- a/tests/qtest/libqos/qgraph_internal.h
+++ b/tests/qtest/libqos/qgraph_internal.h
@@ -197,7 +197,7 @@ char *qos_graph_edge_get_name(QOSGraphEdge *edge);
  * qos_graph_get_machine(): returns the machine assigned
  * to that @node name.
  *
- * It performs a search only trough the list of machines
+ * It performs a search only through the list of machines
  * (i.e. the QOS_ROOT child).
  *
  * Returns: on success: the %QOSGraphNode
diff --git a/tests/qtest/libqos/virtio-gpio.c b/tests/qtest/libqos/virtio-gpio.c
index f22d7b5eb5..9220d287fe 100644
--- a/tests/qtest/libqos/virtio-gpio.c
+++ b/tests/qtest/libqos/virtio-gpio.c
@@ -28,7 +28,7 @@ static void virtio_gpio_cleanup(QVhostUserGPIO *gpio)
 
 /*
  * This handles the VirtIO setup from the point of view of the driver
- * frontend and therefor doesn't present any vhost specific features
+ * frontend and therefore doesn't present any vhost specific features
  * and in fact masks of the re-used bit.
  */
 static void virtio_gpio_setup(QVhostUserGPIO *gpio)
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 471529e6cc..34b9c14b75 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -112,7 +112,7 @@ static int socket_accept(int sock)
     socklen_t addrlen;
     int ret;
     /*
-     * timeout unit of blocking receive calls is different among platfoms.
+     * timeout unit of blocking receive calls is different among platforms.
      * It's in seconds on non-Windows platforms but milliseconds on Windows.
      */
 #ifndef _WIN32
@@ -1697,7 +1697,7 @@ QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
 
     qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
 
-    /* send() may not have a matching protoype, so use a type-safe wrapper */
+    /* send() may not have a matching prototype, so use a type-safe wrapper */
     qts->ops.external_send = send;
     qtest_client_set_tx_handler(qts, send_wrapper);
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 62d3f37021..1b43df5ca7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -486,7 +486,7 @@ static void migrate_ensure_converge(QTestState *who)
  * transferred.
  *
  * Finally we go back to the source and read a byte just
- * before the marker untill we see it flip in value. This
+ * before the marker until we see it flip in value. This
  * is proof that start_address -> MAGIC_OFFSET_BASE
  * is now dirty again.
  *
@@ -826,7 +826,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
-     * It's valid becase QEMU has already opened this file
+     * It's valid because QEMU has already opened this file
      */
     if (args->use_shmem) {
         unlink(shmem_path);
@@ -2103,7 +2103,7 @@ static void test_migrate_auto_converge(void)
 
     /*
      * We want the test to be stable and as fast as possible.
-     * E.g., with 1Gb/s bandwith migration may pass without throttling,
+     * E.g., with 1Gb/s bandwidth migration may pass without throttling,
      * so we need to decrease a bandwidth.
      */
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_timer-test.c
index 83774a5b90..43711049ca 100644
--- a/tests/qtest/npcm7xx_timer-test.c
+++ b/tests/qtest/npcm7xx_timer-test.c
@@ -384,7 +384,7 @@ static void test_pause_resume(gconstpointer test_data)
     g_assert_true(qtest_get_irq(global_qtest, tim_timer_irq(td)));
 }
 
-/* Verifies that the prescaler can be changed while the timer is runnin. */
+/* Verifies that the prescaler can be changed while the timer is running. */
 static void test_prescaler_change(gconstpointer test_data)
 {
     const TestData *td = test_data;
diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
index f05fe12f01..2bf8ff4c86 100644
--- a/tests/qtest/tpm-emu.c
+++ b/tests/qtest/tpm-emu.c
@@ -77,7 +77,7 @@ static void *tpm_emu_tpm_thread(void *data)
             s->tpm_msg->code = cpu_to_be32(TPM_FAIL);
             break;
         default:
-            g_debug("unsupport TPM version %u", s->tpm_version);
+            g_debug("unsupported TPM version %u", s->tpm_version);
             g_assert_not_reached();
         }
         qio_channel_write(ioc, (char *)s->tpm_msg, be32_to_cpu(s->tpm_msg->len),
diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index 25073d1f9e..fb94496bbd 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -1,5 +1,5 @@
 /*
- * QTest TPM commont test code
+ * QTest TPM common test code
  *
  * Copyright (c) 2018 IBM Corporation
  * Copyright (c) 2018 Red Hat, Inc.
diff --git a/tests/qtest/tpm-tests.h b/tests/qtest/tpm-tests.h
index a5df35ab5b..07ba60d26e 100644
--- a/tests/qtest/tpm-tests.h
+++ b/tests/qtest/tpm-tests.h
@@ -1,5 +1,5 @@
 /*
- * QTest TPM commont test code
+ * QTest TPM common test code
  *
  * Copyright (c) 2018 IBM Corporation
  *
diff --git a/tests/qtest/tpm-tis-i2c-test.c b/tests/qtest/tpm-tis-i2c-test.c
index 7a590ac551..3a1af026f2 100644
--- a/tests/qtest/tpm-tis-i2c-test.c
+++ b/tests/qtest/tpm-tis-i2c-test.c
@@ -468,7 +468,7 @@ static void tpm_tis_i2c_test_check_access_reg_release(const void *data)
                            TPM_TIS_ACCESS_ACTIVE_LOCALITY);
         /*
          * highest locality should now be active; release it and make sure the
-         * next higest locality is active afterwards
+         * next highest locality is active afterwards
          */
         for (l = TPM_TIS_NUM_LOCALITIES - 2; l >= 0; l--) {
             if (l == locty) {
diff --git a/tests/qtest/tpm-tis-util.c b/tests/qtest/tpm-tis-util.c
index 728cd3e065..862bb53248 100644
--- a/tests/qtest/tpm-tis-util.c
+++ b/tests/qtest/tpm-tis-util.c
@@ -340,7 +340,7 @@ void tpm_tis_test_check_access_reg_release(const void *data)
                TPM_TIS_ACCESS_ACTIVE_LOCALITY);
         /*
          * highest locality should now be active; release it and make sure the
-         * next higest locality is active afterwards
+         * next highest locality is active afterwards
          */
         for (l = TPM_TIS_NUM_LOCALITIES - 2; l >= 0; l--) {
             if (l == locty) {
diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index dc37f5af4d..117b9acd10 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -961,7 +961,7 @@ static void *vhost_user_blk_test_setup(GString *cmd_line, void *arg)
  * Setup for hotplug.
  *
  * Since vhost-user server only serves one vhost-user client one time,
- * another exprot
+ * another export
  *
  */
 static void *vhost_user_blk_hotplug_test_setup(GString *cmd_line, void *arg)
diff --git a/tests/qtest/virtio-net-test.c b/tests/qtest/virtio-net-test.c
index dff43f0f60..fab5dd8b05 100644
--- a/tests/qtest/virtio-net-test.c
+++ b/tests/qtest/virtio-net-test.c
@@ -212,7 +212,7 @@ static void announce_self(void *obj, void *data, QGuestAllocator *t_alloc)
     g_assert_cmpint(*proto, ==, htons(ETH_P_RARP));
 
     /*
-     * Stop the announcment by settings rounds to 0 on the
+     * Stop the announcement by settings rounds to 0 on the
      * existing timer.
      */
     rsp = qmp("{ 'execute' : 'announce-self', "
diff --git a/tests/qtest/vmgenid-test.c b/tests/qtest/vmgenid-test.c
index 324db08c7a..29fee9e7c0 100644
--- a/tests/qtest/vmgenid-test.c
+++ b/tests/qtest/vmgenid-test.c
@@ -19,7 +19,7 @@
 
 #define VGID_GUID "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
 #define VMGENID_GUID_OFFSET 40   /* allow space for
-                                  * OVMF SDT Header Probe Supressor
+                                  * OVMF SDT Header Probe Suppressor
                                   */
 #define RSDP_ADDR_INVALID 0x100000 /* RSDP must be below this address */
 
diff --git a/tests/tsan/suppressions.tsan b/tests/tsan/suppressions.tsan
index 73414b9ebd..d9a002a2ef 100644
--- a/tests/tsan/suppressions.tsan
+++ b/tests/tsan/suppressions.tsan
@@ -7,7 +7,7 @@
 mutex:aio_context_acquire
 mutex:pthread_mutex_lock
 
-# TSan reports a race betwen pthread_mutex_init() and
+# TSan reports a race between pthread_mutex_init() and
 # pthread_mutex_lock().  Since this is outside of QEMU,
 # we choose to ignore it.
 race:pthread_mutex_init
diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Makefile
index 471f0de981..0c003f2877 100644
--- a/tests/uefi-test-tools/Makefile
+++ b/tests/uefi-test-tools/Makefile
@@ -87,7 +87,7 @@ Build/%.fat: Build/%.efi
 .NOTPARALLEL:
 
 # In turn, the "build" utility of edk2 BaseTools invokes another "make".
-# Although the outer "make" process advertizes its job server to all child
+# Although the outer "make" process advertises its job server to all child
 # processes via MAKEFLAGS in the environment, the outer "make" closes the job
 # server file descriptors (exposed in MAKEFLAGS) before executing a recipe --
 # unless the recipe is recognized as a recursive "make" recipe. Recipes that
diff --git a/tests/unit/check-qjson.c b/tests/unit/check-qjson.c
index c4e0f851bf..a89293ce51 100644
--- a/tests/unit/check-qjson.c
+++ b/tests/unit/check-qjson.c
@@ -1486,7 +1486,7 @@ int main(int argc, char **argv)
     g_test_add_func("/literals/keyword", keyword_literal);
 
     g_test_add_func("/literals/interpolation/valid", interpolation_valid);
-    g_test_add_func("/literals/interpolation/unkown", interpolation_unknown);
+    g_test_add_func("/literals/interpolation/unknown", interpolation_unknown);
     g_test_add_func("/literals/interpolation/string", interpolation_string);
 
     g_test_add_func("/dicts/simple_dict", simple_dict);
diff --git a/tests/unit/test-aio.c b/tests/unit/test-aio.c
index 519440eed3..71ed31a4db 100644
--- a/tests/unit/test-aio.c
+++ b/tests/unit/test-aio.c
@@ -454,7 +454,7 @@ static void test_timer_schedule(void)
 
     g_assert_cmpint(data.n, ==, 0);
 
-    /* timer_mod may well cause an event notifer to have gone off,
+    /* timer_mod may well cause an event notifier to have gone off,
      * so clear that
      */
     do {} while (aio_poll(ctx, false));
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index c522591531..36eed4b464 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -98,9 +98,9 @@ static BlockDriverState *exclusive_writer_node(const char *name)
  *                                    | perm: write, read
  *                                    | shared: except write
  *                                    v
- *  +-------------------+           +----------------+
- *  | passtrough filter |---------->|  null-co node  |
- *  +-------------------+           +----------------+
+ *  +--------------------+          +----------------+
+ *  | passthrough filter |--------->|  null-co node  |
+ *  +--------------------+          +----------------+
  *
  *
  * and then, tries to append filter under node. Expected behavior: fail.
@@ -114,9 +114,9 @@ static BlockDriverState *exclusive_writer_node(const char *name)
  *                         | perm: write, read
  *                         | shared: except write
  *                         v
- *                +-------------------+
- *                | passtrough filter |
- *                +-------------------+
+ *                +--------------------+
+ *                | passthrough filter |
+ *                +--------------------+
  *                       |   |
  *     perm: write, read |   | perm: write, read
  *  shared: except write |   | shared: except write
diff --git a/tests/unit/test-crypto-secret.c b/tests/unit/test-crypto-secret.c
index 147b4af828..ffd13ff70e 100644
--- a/tests/unit/test-crypto-secret.c
+++ b/tests/unit/test-crypto-secret.c
@@ -244,7 +244,7 @@ static void test_secret_keyring_bad_key_access_right(void)
     char key_str[16];
     Object *sec;
 
-    g_test_skip("TODO: Need responce from Linux kernel maintainers");
+    g_test_skip("TODO: Need response from Linux kernel maintainers");
     return;
 
     int32_t key = add_key("user", DESCRIPTION, PAYLOAD,
diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
index 9b3e2dbe14..024e26c49e 100644
--- a/tests/unit/test-qobject-input-visitor.c
+++ b/tests/unit/test-qobject-input-visitor.c
@@ -94,7 +94,7 @@ Visitor *visitor_input_test_init(TestInputVisitorData *data,
 
 /* similar to visitor_input_test_init(), but does not expect a string
  * literal/format json_string argument and so can be used for
- * programatically generated strings (and we can't pass in programatically
+ * programmatically generated strings (and we can't pass in programmatically
  * generated strings via %s format parameters since qobject_from_jsonv()
  * will wrap those in double-quotes and treat the entire object as a
  * string)
diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index 7adb5e6652..dc8739c1d6 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -135,7 +135,7 @@ static void test_compute_wait(void)
         g_assert(double_cmp(bkt.burst_level, 0));
         g_assert(double_cmp(bkt.level, (i + 1) * (bkt.max - bkt.avg) / 10));
         /* We can do bursts for the 2 seconds we have configured in
-         * burst_length. We have 100 extra miliseconds of burst
+         * burst_length. We have 100 extra milliseconds of burst
          * because bkt.level has been leaking during this time.
          * After that, we have to wait. */
         result = i < 21 ? 0 : 1.8 * NANOSECONDS_PER_SECOND;
@@ -375,11 +375,11 @@ static void test_is_valid_for_value(int value, bool should_be_valid)
 
 static void test_is_valid(void)
 {
-    /* negative number are invalid */
+    /* negative numbesr are invalid */
     test_is_valid_for_value(-1, false);
-    /* zero are valids */
+    /* zero is valid */
     test_is_valid_for_value(0, true);
-    /* positives numers are valids */
+    /* positives numbers are valid */
     test_is_valid_for_value(1, true);
 }
 
diff --git a/tests/unit/test-util-filemonitor.c b/tests/unit/test-util-filemonitor.c
index b629e10857..a22de27595 100644
--- a/tests/unit/test-util-filemonitor.c
+++ b/tests/unit/test-util-filemonitor.c
@@ -132,7 +132,7 @@ qemu_file_monitor_test_record_free(QFileMonitorTestRecord *rec)
  * the file monitor event handler. Since events are
  * emitted in the background thread running the event
  * loop, we can't assume there is a record available
- * immediately. Thus we will sleep for upto 5 seconds
+ * immediately. Thus we will sleep for up to 5 seconds
  * to wait for the event to be queued for us.
  */
 static QFileMonitorTestRecord *
diff --git a/tests/unit/test-xs-node.c b/tests/unit/test-xs-node.c
index b80d10ff98..ac94e7ed6c 100644
--- a/tests/unit/test-xs-node.c
+++ b/tests/unit/test-xs-node.c
@@ -362,7 +362,7 @@ static void test_xs_node_simple(void)
     g_assert(data->len == strlen("something"));
     g_assert(!memcmp(data->data, "something", data->len));
 
-    /* Even if we use an abolute path */
+    /* Even if we use an absolute path */
     g_byte_array_set_size(data, 0);
     err = xs_impl_read(s, DOMID_GUEST, XBT_NULL,
                        "/local/domain/1/some/relative/path", data);
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index f0f5d32fb0..bf12e0fa3c 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -81,7 +81,7 @@ endif
 	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
 	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds"
-	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
+	@echo "    V=1				 - Enable verbose output on host and guest commands"
 
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
 
diff --git a/tests/vm/ubuntuvm.py b/tests/vm/ubuntuvm.py
index 6689ad87aa..15c530c571 100644
--- a/tests/vm/ubuntuvm.py
+++ b/tests/vm/ubuntuvm.py
@@ -51,7 +51,7 @@ def build_image(self, img):
         # then we will jump right to the graceful shutdown
         if self._config['install_cmds'] != "":
             # Issue the install commands.
-            # This can be overriden by the user in the config .yml.
+            # This can be overridden by the user in the config .yml.
             install_cmds = self._config['install_cmds'].split(',')
             for cmd in install_cmds:
                 self.ssh_root(cmd)
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EB5785102
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 08:59:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYhm7-0005np-NA; Wed, 23 Aug 2023 02:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYhm3-0005ZE-0Z
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 02:55:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYhly-0001Xm-99
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 02:55:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EC14B1C410
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 09:54:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C73C7212B2;
 Wed, 23 Aug 2023 09:54:03 +0300 (MSK)
Received: (nullmailer pid 1919499 invoked by uid 1000);
 Wed, 23 Aug 2023 06:54:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 22/24] tests/: spelling fixes
Date: Wed, 23 Aug 2023 09:53:33 +0300
Message-Id: <20230823065335.1919380-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823055155.1917375-1-mjt@tls.msk.ru>
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
 tests/qemu-iotests/298                          |  2 +-
 tests/qemu-iotests/pylintrc                     |  2 +-
 tests/qtest/ahci-test.c                         |  2 +-
 tests/qtest/bcm2835-dma-test.c                  |  2 +-
 tests/qtest/bios-tables-test.c                  |  2 +-
 tests/qtest/ds1338-test.c                       |  2 +-
 tests/qtest/fuzz/generic_fuzz.c                 |  4 ++--
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
 tests/unit/test-throttle.c                      |  4 ++--
 tests/unit/test-util-filemonitor.c              |  2 +-
 tests/unit/test-xs-node.c                       |  2 +-
 tests/vm/Makefile.include                       |  2 +-
 tests/vm/ubuntuvm.py                            |  2 +-
 49 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/tests/avocado/acpi-bits.py b/tests/avocado/acpi-bits.py
index 3ed286dcbd..bb3f818689 100644
--- a/tests/avocado/acpi-bits.py
+++ b/tests/avocado/acpi-bits.py
@@ -1,5 +1,5 @@
 #!/usr/bin/env python3
 # group: rw quick
-# Exercize QEMU generated ACPI/SMBIOS tables using biosbits,
+# Exercise QEMU generated ACPI/SMBIOS tables using biosbits,
 # https://biosbits.org/
 #
@@ -367,5 +367,5 @@ def tearDown(self):
 
     def test_acpi_smbios_bits(self):
-        """The main test case implementaion."""
+        """The main test case implementation."""
 
         iso_file = os.path.join(self._workDir,
diff --git a/tests/avocado/acpi-bits/bits-tests/testacpi.py2 b/tests/avocado/acpi-bits/bits-tests/testacpi.py2
index f818a9cce6..7bf9075c1b 100644
--- a/tests/avocado/acpi-bits/bits-tests/testacpi.py2
+++ b/tests/avocado/acpi-bits/bits-tests/testacpi.py2
@@ -274,6 +274,6 @@ def test_rsdp():
     # Checksum the first 20 bytes per ACPI 1.0
     csum = sum(ord(c) for c in data[:20]) % 0x100
-    testsuite.test('ACPI 1.0 table first 20 bytes cummulative checksum must equal 0', csum == 0)
-    testsuite.print_detail("Cummulative checksum = {} (Expected 0)".format(csum))
+    testsuite.test('ACPI 1.0 table first 20 bytes cumulative checksum must equal 0', csum == 0)
+    testsuite.print_detail("Cumulative checksum = {} (Expected 0)".format(csum))
 
     test_table_checksum(data)
diff --git a/tests/decode/err_pattern_group_ident2.decode b/tests/decode/err_pattern_group_ident2.decode
index bc859233b1..0abb7513e9 100644
--- a/tests/decode/err_pattern_group_ident2.decode
+++ b/tests/decode/err_pattern_group_ident2.decode
@@ -8,4 +8,4 @@
   top      00000000 00000000 00000000 00000000
   sub1     00000000 00000000 00000000 ........ %sub1
-# comments are suposed to be indented
+# comments are supposed to be indented
 }
diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 9a33df2832..a611e6adf9 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -13,5 +13,5 @@
 
 # This might be set by ENV of a docker container... it is always
-# overriden by TARGET_LIST if the user sets it. We special case
+# overridden by TARGET_LIST if the user sets it. We special case
 # "none" to allow for other options like --disable-tcg to restrict the
 # builds we eventually do.
diff --git a/tests/migration/guestperf-batch.py b/tests/migration/guestperf-batch.py
index ab6bdb9d38..9485eefe49 100755
--- a/tests/migration/guestperf-batch.py
+++ b/tests/migration/guestperf-batch.py
@@ -1,5 +1,5 @@
 #!/usr/bin/env python3
 #
-# Migration test batch comparison invokation
+# Migration test batch comparison invocation
 #
 # Copyright (c) 2016 Red Hat, Inc.
diff --git a/tests/migration/guestperf.py b/tests/migration/guestperf.py
index e8cc127fd0..07182f211e 100755
--- a/tests/migration/guestperf.py
+++ b/tests/migration/guestperf.py
@@ -1,5 +1,5 @@
 #!/usr/bin/env python3
 #
-# Migration test direct invokation command
+# Migration test direct invocation command
 #
 # Copyright (c) 2016 Red Hat, Inc.
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index f3b9f696a0..44e91065ba 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -99,5 +99,5 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 rw = QEMU_PLUGIN_MEM_RW;
             } else {
-                fprintf(stderr, "invaild value for argument track: %s\n", opt);
+                fprintf(stderr, "invalid value for argument track: %s\n", opt);
                 return -1;
             }
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
@@ -40,5 +40,5 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.pattern
 
-# Any format supporting intenal snapshots
+# Any format supporting internal snapshots
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 30eb97829e..5601a4873c 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -846,5 +846,5 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.assertIsNotNone(self.vm.node_info('cow-1'))
 
-        # 2 has been comitted into 1
+        # 2 has been committed into 1
         self.pattern_files[2] = self.img1
 
@@ -864,5 +864,5 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.assertIsNotNone(self.vm.node_info('cow-0'))
 
-        # 1 has been comitted into 0
+        # 1 has been committed into 0
         self.pattern_files[1] = self.img0
 
@@ -901,5 +901,5 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.assertEqual(drv0['inserted']['node-name'], 'cow-2')
 
-        # 3 has been comitted into 2
+        # 3 has been committed into 2
         self.pattern_files[3] = self.img2
 
@@ -917,5 +917,5 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.assertIsNotNone(self.vm.node_info('cow-2'))
 
-        # 3 has been comitted into 2
+        # 3 has been committed into 2
         self.pattern_files[3] = self.img2
 
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 517b162508..4c9ed4d26e 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -126,5 +126,5 @@ EOF
 
 # Sequential write, but the next cluster is already allocated
-# and phyiscally in the right position
+# and physically in the right position
 cat  <<EOF
 write -P 89 0x80000 0x1000
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index e8be217e1f..2bcb1f7f9c 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -183,5 +183,5 @@ echo
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
@@ -50,5 +50,5 @@ _supported_os Linux
 # require the default 64k cluster
 # we don't have explicit tests for zstd qcow2 compression type, as zstd may be
-# not compiled in. And we can't create compat images with comression type
+# not compiled in. And we can't create compat images with compression type
 # extension
 _unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)' data_file \
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 27bc7305bf..331f8cfddc 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -42,5 +42,5 @@ _supported_proto file fuse
 _require_drivers blkdebug blkverify
 # blkdebug can only inject errors on bs->file, not on the data_file,
-# so thie test does not work with external data files
+# so this test does not work with external data files
 _unsupported_imgopts data_file
 
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index a2547bc280..08d9b49906 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -94,5 +94,5 @@ output=$($QEMU_IO -f qcow2 -C -c "read -P 0 1k $((2*1024*1024*1024 - 512))" \
 case $output in
     *allocate*)
-        _notrun "Insufficent memory to run test" ;;
+        _notrun "Insufficient memory to run test" ;;
     *) printf '%s\n' "$output" ;;
 esac
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index d464596f14..6babbcdc1f 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -96,5 +96,5 @@ output=$($QEMU_IO \
 case $output in
     *allocate*)
-        _notrun "Insufficent memory to run test" ;;
+        _notrun "Insufficient memory to run test" ;;
     *) printf '%s\n' "$output" ;;
 esac
diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
index ad560e2941..4e22567d95 100755
--- a/tests/qemu-iotests/298
+++ b/tests/qemu-iotests/298
@@ -142,5 +142,5 @@ class TestTruncate(iotests.QMPTestCase):
 
         # Probably we'll want preallocate filter to keep align to cluster when
-        # shrink preallocation, so, ignore small differece
+        # shrink preallocation, so, ignore small difference
         self.assertLess(abs(stat.st_size - refstat.st_size), 64 * 1024)
 
diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
index f4f823a991..de2e0c2781 100644
--- a/tests/qemu-iotests/pylintrc
+++ b/tests/qemu-iotests/pylintrc
@@ -20,5 +20,5 @@ disable=invalid-name,
         # pylint warns about Optional[] etc. as unsubscriptable in 3.9
         unsubscriptable-object,
-        # pylint's static analysis causes false positivies for file_path();
+        # pylint's static analysis causes false positives for file_path();
         # If we really care to make it statically knowable, we'll use mypy.
         unbalanced-tuple-unpacking,
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index abab761c26..eea8b5f77b 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -331,5 +331,5 @@ static void ahci_test_pci_spec(AHCIQState *ahci)
     g_assert_cmphex(datal, !=, 0);
 
-    /* Check specification adherence for capability extenstions. */
+    /* Check specification adherence for capability extensions. */
     data = qpci_config_readw(ahci->dev, datal);
 
diff --git a/tests/qtest/bcm2835-dma-test.c b/tests/qtest/bcm2835-dma-test.c
index 8293d822b9..18901b76d2 100644
--- a/tests/qtest/bcm2835-dma-test.c
+++ b/tests/qtest/bcm2835-dma-test.c
@@ -26,5 +26,5 @@
 #define BCM2708_DMA_INT_STATUS 0xfe0
 
-/* DMA Trasfer Info fields: */
+/* DMA Transfer Info fields: */
 #define BCM2708_DMA_INT_EN     (1 << 0)
 #define BCM2708_DMA_D_INC      (1 << 4)
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 47ba20b957..0e0b1db47d 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -27,5 +27,5 @@
  *      make check V=2
  * this will produce a bunch of warnings about differences
- * beween actual and expected ACPI tables. If you have IASL installed,
+ * between actual and expected ACPI tables. If you have IASL installed,
  * they will also be disassembled so you can look at the disassembled
  * output. If not - disassemble them yourself in any way you like.
diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index f6ade9a050..d12424d27f 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -39,5 +39,5 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     i2c_read_block(i2cdev, 0, resp, sizeof(resp));
 
-    /* check retrieved time againt local time */
+    /* check retrieved time against local time */
     g_assert_cmpuint(bcd2bin(resp[4]), == , tm_ptr->tm_mday);
     g_assert_cmpuint(bcd2bin(resp[5]), == , 1 + tm_ptr->tm_mon);
diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 11256abf6c..357e1f9dc2 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -847,7 +847,7 @@ static void generic_pre_fuzz(QTestState *s)
  *
  * This function attempts to produce an input that:
- * Ouptut: maps a device's BARs, set up three DMA patterns, triggers
+ * Output: maps a device's BARs, set up three DMA patterns, triggers
  *          functionality A device, replaces the DMA patterns with a single
- *          patten, and triggers device functionality B.
+ *          pattern, and triggers device functionality B.
  */
 static size_t generic_fuzz_crossover(const uint8_t *data1, size_t size1, const
diff --git a/tests/qtest/libqos/qgraph.c b/tests/qtest/libqos/qgraph.c
index 0a2dddfafa..2029bf9804 100644
--- a/tests/qtest/libqos/qgraph.c
+++ b/tests/qtest/libqos/qgraph.c
@@ -55,5 +55,5 @@ struct QOSStackElement {
 };
 
-/* Each enty in these hash table will consist of <string, node/edge> pair. */
+/* Each entry in these hash table will consist of <string, node/edge> pair. */
 static GHashTable *edge_table;
 static GHashTable *node_table;
@@ -215,5 +215,5 @@ static QOSGraphEdge *search_list_edges(QOSGraphEdgeList *edgelist,
  * search_machine(): search for a machine @name in the node hash
  * table. A machine is the child of the root node.
- * This function forces the research in the childs of the root,
+ * This function forces the research in the children of the root,
  * to check the node is a proper machine
  *
diff --git a/tests/qtest/libqos/qgraph_internal.h b/tests/qtest/libqos/qgraph_internal.h
index 7d62fd17af..87fab1f9f0 100644
--- a/tests/qtest/libqos/qgraph_internal.h
+++ b/tests/qtest/libqos/qgraph_internal.h
@@ -198,5 +198,5 @@ char *qos_graph_edge_get_name(QOSGraphEdge *edge);
  * to that @node name.
  *
- * It performs a search only trough the list of machines
+ * It performs a search only through the list of machines
  * (i.e. the QOS_ROOT child).
  *
diff --git a/tests/qtest/libqos/virtio-gpio.c b/tests/qtest/libqos/virtio-gpio.c
index f22d7b5eb5..9220d287fe 100644
--- a/tests/qtest/libqos/virtio-gpio.c
+++ b/tests/qtest/libqos/virtio-gpio.c
@@ -29,5 +29,5 @@ static void virtio_gpio_cleanup(QVhostUserGPIO *gpio)
 /*
  * This handles the VirtIO setup from the point of view of the driver
- * frontend and therefor doesn't present any vhost specific features
+ * frontend and therefore doesn't present any vhost specific features
  * and in fact masks of the re-used bit.
  */
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index c22dfc30d3..7bbac5b9d0 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -113,5 +113,5 @@ static int socket_accept(int sock)
     int ret;
     /*
-     * timeout unit of blocking receive calls is different among platfoms.
+     * timeout unit of blocking receive calls is different among platforms.
      * It's in seconds on non-Windows platforms but milliseconds on Windows.
      */
@@ -1692,5 +1692,5 @@ QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
     qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
 
-    /* send() may not have a matching protoype, so use a type-safe wrapper */
+    /* send() may not have a matching prototype, so use a type-safe wrapper */
     qts->ops.external_send = send;
     qtest_client_set_tx_handler(qts, send_wrapper);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 62d3f37021..1b43df5ca7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -487,5 +487,5 @@ static void migrate_ensure_converge(QTestState *who)
  *
  * Finally we go back to the source and read a byte just
- * before the marker untill we see it flip in value. This
+ * before the marker until we see it flip in value. This
  * is proof that start_address -> MAGIC_OFFSET_BASE
  * is now dirty again.
@@ -827,5 +827,5 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
-     * It's valid becase QEMU has already opened this file
+     * It's valid because QEMU has already opened this file
      */
     if (args->use_shmem) {
@@ -2104,5 +2104,5 @@ static void test_migrate_auto_converge(void)
     /*
      * We want the test to be stable and as fast as possible.
-     * E.g., with 1Gb/s bandwith migration may pass without throttling,
+     * E.g., with 1Gb/s bandwidth migration may pass without throttling,
      * so we need to decrease a bandwidth.
      */
diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_timer-test.c
index 83774a5b90..43711049ca 100644
--- a/tests/qtest/npcm7xx_timer-test.c
+++ b/tests/qtest/npcm7xx_timer-test.c
@@ -385,5 +385,5 @@ static void test_pause_resume(gconstpointer test_data)
 }
 
-/* Verifies that the prescaler can be changed while the timer is runnin. */
+/* Verifies that the prescaler can be changed while the timer is running. */
 static void test_prescaler_change(gconstpointer test_data)
 {
diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
index f05fe12f01..2bf8ff4c86 100644
--- a/tests/qtest/tpm-emu.c
+++ b/tests/qtest/tpm-emu.c
@@ -78,5 +78,5 @@ static void *tpm_emu_tpm_thread(void *data)
             break;
         default:
-            g_debug("unsupport TPM version %u", s->tpm_version);
+            g_debug("unsupported TPM version %u", s->tpm_version);
             g_assert_not_reached();
         }
diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index 25073d1f9e..fb94496bbd 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -1,4 +1,4 @@
 /*
- * QTest TPM commont test code
+ * QTest TPM common test code
  *
  * Copyright (c) 2018 IBM Corporation
diff --git a/tests/qtest/tpm-tests.h b/tests/qtest/tpm-tests.h
index a5df35ab5b..07ba60d26e 100644
--- a/tests/qtest/tpm-tests.h
+++ b/tests/qtest/tpm-tests.h
@@ -1,4 +1,4 @@
 /*
- * QTest TPM commont test code
+ * QTest TPM common test code
  *
  * Copyright (c) 2018 IBM Corporation
diff --git a/tests/qtest/tpm-tis-i2c-test.c b/tests/qtest/tpm-tis-i2c-test.c
index 7a590ac551..3a1af026f2 100644
--- a/tests/qtest/tpm-tis-i2c-test.c
+++ b/tests/qtest/tpm-tis-i2c-test.c
@@ -469,5 +469,5 @@ static void tpm_tis_i2c_test_check_access_reg_release(const void *data)
         /*
          * highest locality should now be active; release it and make sure the
-         * next higest locality is active afterwards
+         * next highest locality is active afterwards
          */
         for (l = TPM_TIS_NUM_LOCALITIES - 2; l >= 0; l--) {
diff --git a/tests/qtest/tpm-tis-util.c b/tests/qtest/tpm-tis-util.c
index 728cd3e065..862bb53248 100644
--- a/tests/qtest/tpm-tis-util.c
+++ b/tests/qtest/tpm-tis-util.c
@@ -341,5 +341,5 @@ void tpm_tis_test_check_access_reg_release(const void *data)
         /*
          * highest locality should now be active; release it and make sure the
-         * next higest locality is active afterwards
+         * next highest locality is active afterwards
          */
         for (l = TPM_TIS_NUM_LOCALITIES - 2; l >= 0; l--) {
diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index dc37f5af4d..117b9acd10 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -962,5 +962,5 @@ static void *vhost_user_blk_test_setup(GString *cmd_line, void *arg)
  *
  * Since vhost-user server only serves one vhost-user client one time,
- * another exprot
+ * another export
  *
  */
diff --git a/tests/qtest/virtio-net-test.c b/tests/qtest/virtio-net-test.c
index dff43f0f60..fab5dd8b05 100644
--- a/tests/qtest/virtio-net-test.c
+++ b/tests/qtest/virtio-net-test.c
@@ -213,5 +213,5 @@ static void announce_self(void *obj, void *data, QGuestAllocator *t_alloc)
 
     /*
-     * Stop the announcment by settings rounds to 0 on the
+     * Stop the announcement by settings rounds to 0 on the
      * existing timer.
      */
diff --git a/tests/qtest/vmgenid-test.c b/tests/qtest/vmgenid-test.c
index 324db08c7a..29fee9e7c0 100644
--- a/tests/qtest/vmgenid-test.c
+++ b/tests/qtest/vmgenid-test.c
@@ -20,5 +20,5 @@
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
@@ -8,5 +8,5 @@ mutex:aio_context_acquire
 mutex:pthread_mutex_lock
 
-# TSan reports a race betwen pthread_mutex_init() and
+# TSan reports a race between pthread_mutex_init() and
 # pthread_mutex_lock().  Since this is outside of QEMU,
 # we choose to ignore it.
diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Makefile
index 471f0de981..0c003f2877 100644
--- a/tests/uefi-test-tools/Makefile
+++ b/tests/uefi-test-tools/Makefile
@@ -88,5 +88,5 @@ Build/%.fat: Build/%.efi
 
 # In turn, the "build" utility of edk2 BaseTools invokes another "make".
-# Although the outer "make" process advertizes its job server to all child
+# Although the outer "make" process advertises its job server to all child
 # processes via MAKEFLAGS in the environment, the outer "make" closes the job
 # server file descriptors (exposed in MAKEFLAGS) before executing a recipe --
diff --git a/tests/unit/check-qjson.c b/tests/unit/check-qjson.c
index c4e0f851bf..a89293ce51 100644
--- a/tests/unit/check-qjson.c
+++ b/tests/unit/check-qjson.c
@@ -1487,5 +1487,5 @@ int main(int argc, char **argv)
 
     g_test_add_func("/literals/interpolation/valid", interpolation_valid);
-    g_test_add_func("/literals/interpolation/unkown", interpolation_unknown);
+    g_test_add_func("/literals/interpolation/unknown", interpolation_unknown);
     g_test_add_func("/literals/interpolation/string", interpolation_string);
 
diff --git a/tests/unit/test-aio.c b/tests/unit/test-aio.c
index 519440eed3..71ed31a4db 100644
--- a/tests/unit/test-aio.c
+++ b/tests/unit/test-aio.c
@@ -455,5 +455,5 @@ static void test_timer_schedule(void)
     g_assert_cmpint(data.n, ==, 0);
 
-    /* timer_mod may well cause an event notifer to have gone off,
+    /* timer_mod may well cause an event notifier to have gone off,
      * so clear that
      */
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index c522591531..36eed4b464 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -99,7 +99,7 @@ static BlockDriverState *exclusive_writer_node(const char *name)
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
@@ -115,7 +115,7 @@ static BlockDriverState *exclusive_writer_node(const char *name)
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
diff --git a/tests/unit/test-crypto-secret.c b/tests/unit/test-crypto-secret.c
index 147b4af828..ffd13ff70e 100644
--- a/tests/unit/test-crypto-secret.c
+++ b/tests/unit/test-crypto-secret.c
@@ -245,5 +245,5 @@ static void test_secret_keyring_bad_key_access_right(void)
     Object *sec;
 
-    g_test_skip("TODO: Need responce from Linux kernel maintainers");
+    g_test_skip("TODO: Need response from Linux kernel maintainers");
     return;
 
diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
index 9b3e2dbe14..024e26c49e 100644
--- a/tests/unit/test-qobject-input-visitor.c
+++ b/tests/unit/test-qobject-input-visitor.c
@@ -95,5 +95,5 @@ Visitor *visitor_input_test_init(TestInputVisitorData *data,
 /* similar to visitor_input_test_init(), but does not expect a string
  * literal/format json_string argument and so can be used for
- * programatically generated strings (and we can't pass in programatically
+ * programmatically generated strings (and we can't pass in programmatically
  * generated strings via %s format parameters since qobject_from_jsonv()
  * will wrap those in double-quotes and treat the entire object as a
diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index 7adb5e6652..9ba1c73c35 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -136,5 +136,5 @@ static void test_compute_wait(void)
         g_assert(double_cmp(bkt.level, (i + 1) * (bkt.max - bkt.avg) / 10));
         /* We can do bursts for the 2 seconds we have configured in
-         * burst_length. We have 100 extra miliseconds of burst
+         * burst_length. We have 100 extra milliseconds of burst
          * because bkt.level has been leaking during this time.
          * After that, we have to wait. */
@@ -380,5 +380,5 @@ static void test_is_valid(void)
     /* zero are valids */
     test_is_valid_for_value(0, true);
-    /* positives numers are valids */
+    /* positives numbers are valids */
     test_is_valid_for_value(1, true);
 }
diff --git a/tests/unit/test-util-filemonitor.c b/tests/unit/test-util-filemonitor.c
index b629e10857..a22de27595 100644
--- a/tests/unit/test-util-filemonitor.c
+++ b/tests/unit/test-util-filemonitor.c
@@ -133,5 +133,5 @@ qemu_file_monitor_test_record_free(QFileMonitorTestRecord *rec)
  * emitted in the background thread running the event
  * loop, we can't assume there is a record available
- * immediately. Thus we will sleep for upto 5 seconds
+ * immediately. Thus we will sleep for up to 5 seconds
  * to wait for the event to be queued for us.
  */
diff --git a/tests/unit/test-xs-node.c b/tests/unit/test-xs-node.c
index b80d10ff98..ac94e7ed6c 100644
--- a/tests/unit/test-xs-node.c
+++ b/tests/unit/test-xs-node.c
@@ -363,5 +363,5 @@ static void test_xs_node_simple(void)
     g_assert(!memcmp(data->data, "something", data->len));
 
-    /* Even if we use an abolute path */
+    /* Even if we use an absolute path */
     g_byte_array_set_size(data, 0);
     err = xs_impl_read(s, DOMID_GUEST, XBT_NULL,
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index c2a8ca1c17..e87dd7cd7a 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -82,5 +82,5 @@ endif
 	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds"
-	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
+	@echo "    V=1				 - Enable verbose output on host and guest commands"
 
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
diff --git a/tests/vm/ubuntuvm.py b/tests/vm/ubuntuvm.py
index 6689ad87aa..15c530c571 100644
--- a/tests/vm/ubuntuvm.py
+++ b/tests/vm/ubuntuvm.py
@@ -52,5 +52,5 @@ def build_image(self, img):
         if self._config['install_cmds'] != "":
             # Issue the install commands.
-            # This can be overriden by the user in the config .yml.
+            # This can be overridden by the user in the config .yml.
             install_cmds = self._config['install_cmds'].split(',')
             for cmd in install_cmds:
-- 
2.39.2



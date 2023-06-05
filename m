Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C314A722BD2
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:47:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CPA-0007m1-Ge; Mon, 05 Jun 2023 11:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CP4-0007jh-Nr
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CP2-0001IT-JY
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685979951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJ5wn2P538auDnJD+SuCeINdH4RRyR0W835mOsRnRm4=;
 b=EFP6ORSB1cjNSsBSaZtftaB0Bve8JwJrJihmSAXAYrrYNlyqwDQA9Iq3HvgYzIfGvanT6Z
 qJAcMNREeBgkfk1iwncDm6q4Sd+JzhiSmxKiconwwsVDOv+mqcVzeL8MIrZLifjoXuuqP+
 T4rAKShcRq5rLjBImF0gcaeiAG2qvzM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-hPtlzKnAOWqfY90joyBilA-1; Mon, 05 Jun 2023 11:45:50 -0400
X-MC-Unique: hPtlzKnAOWqfY90joyBilA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BA461C03369;
 Mon,  5 Jun 2023 15:45:50 +0000 (UTC)
Received: from localhost (unknown [10.39.194.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3DA12166B25;
 Mon,  5 Jun 2023 15:45:49 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/17] iotests/iov-padding: New test
Date: Mon,  5 Jun 2023 17:45:28 +0200
Message-Id: <20230605154541.1043261-5-hreitz@redhat.com>
In-Reply-To: <20230605154541.1043261-1-hreitz@redhat.com>
References: <20230605154541.1043261-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Test that even vectored IO requests with 1024 vector elements that are
not aligned to the device's request alignment will succeed.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20230411173418.19549-5-hreitz@redhat.com>
---
 tests/qemu-iotests/tests/iov-padding     | 85 ++++++++++++++++++++++++
 tests/qemu-iotests/tests/iov-padding.out | 59 ++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/iov-padding
 create mode 100644 tests/qemu-iotests/tests/iov-padding.out

diff --git a/tests/qemu-iotests/tests/iov-padding b/tests/qemu-iotests/tests/iov-padding
new file mode 100755
index 0000000000..b9604900c7
--- /dev/null
+++ b/tests/qemu-iotests/tests/iov-padding
@@ -0,0 +1,85 @@
+#!/usr/bin/env bash
+# group: rw quick
+#
+# Check the interaction of request padding (to fit alignment restrictions) with
+# vectored I/O from the guest
+#
+# Copyright Red Hat
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+seq=$(basename $0)
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+cd ..
+. ./common.rc
+. ./common.filter
+
+_supported_fmt raw
+_supported_proto file
+
+_make_test_img 1M
+
+IMGSPEC="driver=blkdebug,align=4096,image.driver=file,image.filename=$TEST_IMG"
+
+# Four combinations:
+# - Offset 4096, length 1023 * 512 + 512: Fully aligned to 4k
+# - Offset 4096, length 1023 * 512 + 4096: Head is aligned, tail is not
+# - Offset 512, length 1023 * 512 + 512: Neither head nor tail are aligned
+# - Offset 512, length 1023 * 512 + 4096: Tail is aligned, head is not
+for start_offset in 4096 512; do
+    for last_element_length in 512 4096; do
+        length=$((1023 * 512 + $last_element_length))
+
+        echo
+        echo "== performing 1024-element vectored requests to image (offset: $start_offset; length: $length) =="
+
+        # Fill with data for testing
+        $QEMU_IO -c 'write -P 1 0 1M' "$TEST_IMG" | _filter_qemu_io
+
+        # 1023 512-byte buffers, and then one with length $last_element_length
+        cmd_params="-P 2 $start_offset $(yes 512 | head -n 1023 | tr '\n' ' ') $last_element_length"
+        QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS_NO_FMT" $QEMU_IO \
+            -c "writev $cmd_params" \
+            --image-opts \
+            "$IMGSPEC" \
+            | _filter_qemu_io
+
+        # Read all patterns -- read the part we just wrote with writev twice,
+        # once "normally", and once with a readv, so we see that that works, too
+        QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS_NO_FMT" $QEMU_IO \
+            -c "read -P 1 0 $start_offset" \
+            -c "read -P 2 $start_offset $length" \
+            -c "readv $cmd_params" \
+            -c "read -P 1 $((start_offset + length)) $((1024 * 1024 - length - start_offset))" \
+            --image-opts \
+            "$IMGSPEC" \
+            | _filter_qemu_io
+    done
+done
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/iov-padding.out b/tests/qemu-iotests/tests/iov-padding.out
new file mode 100644
index 0000000000..e07a91fac7
--- /dev/null
+++ b/tests/qemu-iotests/tests/iov-padding.out
@@ -0,0 +1,59 @@
+QA output created by iov-padding
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+
+== performing 1024-element vectored requests to image (offset: 4096; length: 524288) ==
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 524288/524288 bytes at offset 4096
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 4096
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 4096
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 520192/520192 bytes at offset 528384
+508 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== performing 1024-element vectored requests to image (offset: 4096; length: 527872) ==
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 527872/527872 bytes at offset 4096
+515.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 527872/527872 bytes at offset 4096
+515.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 527872/527872 bytes at offset 4096
+515.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 516608/516608 bytes at offset 531968
+504.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== performing 1024-element vectored requests to image (offset: 512; length: 524288) ==
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 524288/524288 bytes at offset 512
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 512
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 512
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 523776/523776 bytes at offset 524800
+511.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== performing 1024-element vectored requests to image (offset: 512; length: 527872) ==
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 527872/527872 bytes at offset 512
+515.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 527872/527872 bytes at offset 512
+515.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 527872/527872 bytes at offset 512
+515.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 520192/520192 bytes at offset 528384
+508 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
-- 
2.40.1



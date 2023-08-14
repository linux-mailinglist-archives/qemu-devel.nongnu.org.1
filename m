Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD94677B4EE
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:59:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVTPT-0001uw-Gm; Mon, 14 Aug 2023 04:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qVTPS-0001ua-6d; Mon, 14 Aug 2023 04:58:46 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qVTPQ-0007EP-3m; Mon, 14 Aug 2023 04:58:45 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a7e68f4214so2196558b6e.1; 
 Mon, 14 Aug 2023 01:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692003522; x=1692608322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jATuWhSMVl4DK5GNTPcUtmJ9jZJkokdk3admZJrIA5U=;
 b=kzAHztZgtqw4w8yIB8Z6GZFyK0ML3S72SVBKBQ+mUCfY+kCoCLGZYRwcSwD3gylHCH
 Y9CqUbvuv9Wg9Ica6ttcrQeXa5dBorklaQh1YTOHHkZSwl5LG2tYRQHvOx0kpsJXTW4G
 /liinnoKJk32tqylDQGjj3Fb7t1/M3xgTneledvLXJ/S1iAC8DAU9mr8eZZBn60IPZXa
 FFKvl9SDcMuS0J6vY/dgKDXXFR3i7MW5XsROt1LhFveVYHDHB8f4L/oE01XSiQeSs/43
 ih2uAy3IrHkpQvWhV5u6x3ymwJTsAkBIQvFIW6G21+I2jY8HjOfts9HRa1fhiMbTJcOC
 GvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692003522; x=1692608322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jATuWhSMVl4DK5GNTPcUtmJ9jZJkokdk3admZJrIA5U=;
 b=TawKW8dzbWAbLlK1xYPd07N33NKJc8ZmHueR+CDQgKM4MAeieHFacLkhcGgqnGF98k
 gow2TAVrZY9C+AYw/+3NsBJyOxMcQrTrs7GZ+wEeWYCKqP65BoFhI5QrBGHF+Zm8MSm6
 kFIFqGX16T4mLv3bm17SNRCAP4bMgLJkIk+TredWYvv2319zVl9WaVWDlZpIQqzEKKnk
 TYt9okw7ffJUlPEADF3FVm2TzxsQc/fsr2Xi0PDTj3UD71pbVI2DAsatRhtb/mRedOwq
 Qjrw8dm/fo5rozT2JayciqclbBIRviHmlc4OqyaU+diX9KE0apZvnAoNC6L03N289cSo
 TEYQ==
X-Gm-Message-State: AOJu0Yy4pVQPvo4G0l3J6aQqHNcAjJhGcd3mUStS0JOPlzYqN4BUWw9O
 5i+BLcIP2g5juXRIgMvu4N50PNIlPBIQ+EGB0q8=
X-Google-Smtp-Source: AGHT+IFesj4VmMg29fJieMcj316FC5OLzk7DfVh1etXqSGiTZPzsyRjHhKXWoX7fkkig9Dm7HBLjvw==
X-Received: by 2002:a05:6358:528d:b0:133:a8e:6feb with SMTP id
 g13-20020a056358528d00b001330a8e6febmr5816624rwa.12.1692003521474; 
 Mon, 14 Aug 2023 01:58:41 -0700 (PDT)
Received: from fedlinux.. ([106.84.134.250]) by smtp.gmail.com with ESMTPSA id
 bt24-20020a632918000000b00528db73ed70sm8238890pgb.3.2023.08.14.01.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 01:58:41 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: hare@suse.de, Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 stefanha@redhat.com, dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v2 4/4] iotests: test the zoned format feature for qcow2 file
Date: Mon, 14 Aug 2023 16:58:02 +0800
Message-Id: <20230814085802.61459-5-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814085802.61459-1-faithilikerun@gmail.com>
References: <20230814085802.61459-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=faithilikerun@gmail.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The zoned format feature can be tested by:
$ tests/qemu-iotests/check zoned-qcow2

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 tests/qemu-iotests/tests/zoned-qcow2     | 135 ++++++++++++++++++++++
 tests/qemu-iotests/tests/zoned-qcow2.out | 140 +++++++++++++++++++++++
 2 files changed, 275 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

diff --git a/tests/qemu-iotests/tests/zoned-qcow2 b/tests/qemu-iotests/tests/zoned-qcow2
new file mode 100755
index 0000000000..473b462b50
--- /dev/null
+++ b/tests/qemu-iotests/tests/zoned-qcow2
@@ -0,0 +1,135 @@
+#!/usr/bin/env bash
+#
+# Test zone management operations for qcow2 file.
+#
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+status=1 # failure is the default!
+
+file_name="zbc.qcow2"
+_cleanup()
+{
+  _cleanup_test_img
+  _rm_test_img "$file_name"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ../common.rc
+. ../common.filter
+. ../common.qemu
+
+# This test only runs on Linux hosts with qcow2 image files.
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+echo
+echo "=== Initial image setup ==="
+echo
+
+$QEMU_IMG create -f qcow2 $file_name -o size=768M -o zone_size=64M \
+-o zone_capacity=64M -o zone_nr_conv=0 -o max_append_sectors=131072 \
+-o max_open_zones=0 -o max_active_zones=0 -o zoned_profile=zbc
+
+IMG="--image-opts -n driver=qcow2,file.driver=file,file.filename=$file_name"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+echo
+echo "=== Testing a qcow2 img with zoned format ==="
+echo
+echo "case 1: test if one zone operation works"
+
+echo "(1) report zones[0]:"
+$QEMU_IO $IMG -c "zrp 0 1"
+echo
+echo "report zones[0~9]:"
+$QEMU_IO $IMG -c "zrp 0 10"
+echo
+echo "report the last zone:"
+$QEMU_IO $IMG -c "zrp 0x2C000000 2" # 0x2C000000 / 512 = 0x160000
+echo
+echo
+echo "open zones[0]:"
+$QEMU_IO $IMG -c "zo 0 0x4000000" # 0x4000000 / 512 = 0x20000
+$QEMU_IO $IMG -c "zrp 0 1"
+echo
+echo "open zones[1]"
+$QEMU_IO $IMG -c "zo 0x4000000 0x4000000"
+$QEMU_IO $IMG -c "zrp 0x4000000 1"
+echo
+echo "open the last zone"
+$QEMU_IO $IMG -c "zo 0x2C000000 0x4000000"
+$QEMU_IO $IMG -c "zrp 0x2C000000 2"
+echo
+echo
+echo "close zones[0]"
+$QEMU_IO $IMG -c "zc 0 0x4000000"
+$QEMU_IO $IMG -c "zrp 0 1"
+echo
+echo "close the last zone"
+$QEMU_IO $IMG -c "zc 0x3e70000000 0x4000000"
+$QEMU_IO $IMG -c "zrp 0x3e70000000 2"
+echo
+echo
+echo "(4) finish zones[1]"
+$QEMU_IO $IMG -c "zf 0x4000000 0x4000000"
+$QEMU_IO $IMG -c "zrp 0x4000000 1"
+echo
+echo
+echo "(5) reset zones[1]"
+$QEMU_IO $IMG -c "zrs 0x4000000 0x4000000"
+$QEMU_IO $IMG -c "zrp 0x4000000 1"
+echo
+echo
+echo "(6) append write with (4k, 8k) data" # the physical block size of the device is 4096
+$QEMU_IO $IMG -c "zrp 0 12"
+echo "Append write zones[0] one time:"
+$QEMU_IO $IMG -c "zap -p 0 0x1000 0x2000"
+$QEMU_IO $IMG -c "zrp 0 1"
+echo
+echo "Append write zones[0] twice:"
+$QEMU_IO $IMG -c "zap -p 0 0x1000 0x2000"
+$QEMU_IO $IMG -c "zrp 0 1"
+echo
+echo "Append write zones[1] one time:"
+$QEMU_IO $IMG -c "zap -p 0x4000000 0x1000 0x2000"
+$QEMU_IO $IMG -c "zrp 0x4000000 1"
+echo
+echo "Append write zones[1] twice:"
+$QEMU_IO $IMG -c "zap -p 0x4000000 0x1000 0x2000"
+$QEMU_IO $IMG -c "zrp 0x4000000 1"
+echo
+echo "Reset all:"
+$QEMU_IO $IMG -c "zrs 0 768M"
+$QEMU_IO $IMG -c "zrp 0 12"
+echo
+echo
+echo "case 2: test a sets of ops that works or not"
+
+echo "(1) append write (4k, 4k) and then write to full"
+$QEMU_IO $IMG -c "zap -p 0 0x1000 0x1000"
+echo "wrote (4k, 4k):"
+$QEMU_IO $IMG -c "zrp 0 1"
+$QEMU_IO $IMG -c "zap -p 0 0x1000 0x3ffd000"
+echo "wrote to full:"
+$QEMU_IO $IMG -c "zrp 0 1"
+echo "Reset zones[0]:"
+$QEMU_IO $IMG -c "zrs 0 64M"
+$QEMU_IO $IMG -c "zrp 0 1"
+
+echo "(2) write in zones[0], zones[3], zones[8], and then reset all"
+$QEMU_IO $IMG -c "zap -p 0 0x1000 0x1000"
+$QEMU_IO $IMG -c "zap -p 0xc000000 0x1000 0x1000"
+$QEMU_IO $IMG -c "zap -p 0x20000000 0x1000 0x1000"
+echo "wrote three zones:"
+$QEMU_IO $IMG -c "zrp 0 12"
+echo "Reset all:"
+$QEMU_IO $IMG -c "zrs 0 768M"
+$QEMU_IO $IMG -c "zrp 0 12"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/zoned-qcow2.out b/tests/qemu-iotests/tests/zoned-qcow2.out
new file mode 100644
index 0000000000..0a6b21cb55
--- /dev/null
+++ b/tests/qemu-iotests/tests/zoned-qcow2.out
@@ -0,0 +1,140 @@
+QA output created by zoned-qcow2
+
+=== Initial image setup ===
+
+Formatting 'zbc.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib zoned_profile=zbc zone_size=67108864 zone_capacity=67108864 zone_nr_conv=0 max_append_sectors=131072 max_active_zones=0 max_open_zones=0 size=805306368 lazy_refcounts=off refcount_bits=16
+
+=== Testing a qcow2 img with zoned format ===
+
+case 1: test if one zone operation works
+(1) report zones[0]:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+
+report zones[0~9]:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+
+report the last zone:
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+
+
+open zones[0]:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:3, [type: 2]
+
+open zones[1]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:3, [type: 2]
+
+open the last zone
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:3, [type: 2]
+
+
+close zones[0]
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:4, [type: 2]
+
+close the last zone
+zone close failed: Input/output error
+qemu-io: offset 268167020544 is equal to or greater than thedevice capacity 805306368
+zone report failed: Invalid argument
+
+
+(4) finish zones[1]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:14, [type: 2]
+
+
+(5) reset zones[1]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+
+
+(6) append write with (4k, 8k) data
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:4, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:3, [type: 2]
+Append write zones[0] one time:
+After zap done, the append sector is 0x0
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x18, zcond:2, [type: 2]
+
+Append write zones[0] twice:
+After zap done, the append sector is 0x18
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x30, zcond:2, [type: 2]
+
+Append write zones[1] one time:
+After zap done, the append sector is 0x20000
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20018, zcond:2, [type: 2]
+
+Append write zones[1] twice:
+After zap done, the append sector is 0x20018
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20030, zcond:2, [type: 2]
+
+Reset all:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+
+
+case 2: test a sets of ops that works or not
+(1) append write (4k, 4k) and then write to full
+After zap done, the append sector is 0x0
+wrote (4k, 4k):
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x10, zcond:2, [type: 2]
+After zap done, the append sector is 0x10
+wrote to full:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x20000, zcond:14, [type: 2]
+Reset zones[0]:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+(2) write in zones[0], zones[3], zones[8], and then reset all
+After zap done, the append sector is 0x0
+After zap done, the append sector is 0x60000
+After zap done, the append sector is 0x100000
+wrote three zones:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x10, zcond:2, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60010, zcond:2, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100010, zcond:2, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+Reset all:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+*** done
-- 
2.40.1



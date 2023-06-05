Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FFF7223B7
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67ea-00022T-R0; Mon, 05 Jun 2023 06:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q67eY-00021h-Ve; Mon, 05 Jun 2023 06:41:35 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q67eX-0006oj-3a; Mon, 05 Jun 2023 06:41:34 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b01dac1a82so22443465ad.2; 
 Mon, 05 Jun 2023 03:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685961691; x=1688553691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOv8zkJcKH4/kd6DqV4AbYXN/AcmdfjqqCG+nmVbJg4=;
 b=sTbmHbp/g2AzrMfrBw9aH6zQcN8YNo4bcEv9yrS7ettrcrB35SF44SkVhf7UuT7EoW
 z8XN6+xoVhI+JVpkdynbSq9ux4l0rZ0tB8VCSO0OFL+lZa3jAhC9ArfhiNjOl83j6M8k
 OtpUpjXPbr8/1oOSxA6Qfx7IL3bjqtKtducSjkC8x171FQVxKGtpLYDnNYZTxY0KAGxM
 9vZwIAC1BZe11KD4ivsxcbvE+v3HcBU0AtJoBM7bTMKoRSq/SRimh71SxgON56i2ma4+
 ul3l2k09J+skDS5tZyWm7+jpTOXuEAGlXsCk2oreNc+8YWUJeIHYlnAiV7DIjl53IGC4
 0whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685961691; x=1688553691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UOv8zkJcKH4/kd6DqV4AbYXN/AcmdfjqqCG+nmVbJg4=;
 b=ZTc0ncyN2Mpr8pumv3jUOar086SGWUqjhFbzsHGNUdHFRhYFT3geFeIZgU9aT+r782
 0TG9CUTZfq6fRAIejWW6UjtRqt5jxIOsZcdciNx/uQi2jyQ8R/XIacykfvEW5Wt2KkQo
 v3ngGgbhIxaff9HsU/yqHTfg9SrNLCdxf4NwiP8slx2QmHp6xQOHOJBb4XB0U0YVmCT8
 31asc+wTLCWZfURWY7cZ8JzpBu8+JoBPzMg5GvKdEhrd9YwS152bWYS5+dPHh3RSyTYj
 lvWqu8msesCKpHV1hlgtInQF/KtgpxMDxiPqgUusemDSgLifQ8XM483LjjN2IMlSoPqa
 3vHQ==
X-Gm-Message-State: AC+VfDyq579q3QOMquThLl6Ui9HkkEBHLk5DVvZ9aDBs2BoFK5s2KuYv
 7MUjKJ3HNEfYeUVOHxJobwJe4WDg82WprJyT
X-Google-Smtp-Source: ACHHUZ6T9tTsvLdpfxOAVj/y+9yK+t1F9p4QaOJEpns9Q/65dL8f96oUeC7BJ96x3NVr7R5eVxDkzA==
X-Received: by 2002:a17:902:ed53:b0:1ab:160c:526d with SMTP id
 y19-20020a170902ed5300b001ab160c526dmr2774438plb.22.1685961690650; 
 Mon, 05 Jun 2023 03:41:30 -0700 (PDT)
Received: from fedlinux.. ([106.84.132.130]) by smtp.gmail.com with ESMTPSA id
 x4-20020a170902a38400b001b0457705e8sm6340141pla.140.2023.06.05.03.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 03:41:30 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, dmitry.fomichev@wdc.com, hare@suse.de,
 stefanha@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [RFC 4/4] iotests: test the zoned format feature for qcow2 file
Date: Mon,  5 Jun 2023 18:41:08 +0800
Message-Id: <20230605104108.125270-5-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605104108.125270-1-faithilikerun@gmail.com>
References: <20230605104108.125270-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=faithilikerun@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The zoned format feature can be tested by:
$ tests/qemu-iotests/check zoned-qcow2

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 tests/qemu-iotests/tests/zoned-qcow2     | 110 +++++++++++++++++++++++
 tests/qemu-iotests/tests/zoned-qcow2.out |  87 ++++++++++++++++++
 2 files changed, 197 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

diff --git a/tests/qemu-iotests/tests/zoned-qcow2 b/tests/qemu-iotests/tests/zoned-qcow2
new file mode 100755
index 0000000000..6aa5ab3a03
--- /dev/null
+++ b/tests/qemu-iotests/tests/zoned-qcow2
@@ -0,0 +1,110 @@
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
+_supported_proto file
+_supported_os Linux
+
+echo
+echo "=== Initial image setup ==="
+echo
+
+$QEMU_IMG create -f qcow2 $file_name -o size=768M -o zone_size=64M \
+-o zone_capacity=64M -o zone_nr_conv=0 -o max_append_sectors=512 \
+-o max_open_zones=0 -o max_active_zones=0 -o zoned_profile=zbc
+
+IMG="--image-opts -n driver=qcow2,file.driver=file,file.filename=$file_name"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+echo
+echo "=== Testing a qcow2 img with zoned format ==="
+echo
+echo "case 1: if the operations work"
+
+echo "(1) report the first zone:"
+$QEMU_IO $IMG -c "zrp 0 1"
+echo
+echo "report the first 10 zones"
+$QEMU_IO $IMG -c "zrp 0 10"
+echo
+echo "report the last zone:"
+$QEMU_IO $IMG -c "zrp 0x2C000000 2" # 0x2C000000 / 512 = 0x160000
+echo
+echo
+echo "(2) opening the first zone"
+$QEMU_IO $IMG -c "zo 0 0x4000000" # 0x4000000 / 512 = 0x20000
+echo "report after:"
+$QEMU_IO $IMG -c "zrp 0 1"
+echo
+echo "opening the second zone"
+$QEMU_IO $IMG -c "zo 0x4000000 0x4000000"
+echo "report after:"
+$QEMU_IO $IMG -c "zrp 0x4000000 1"
+echo
+echo "opening the last zone"
+$QEMU_IO $IMG -c "zo 0x2C000000 0x4000000"
+echo "report after:"
+$QEMU_IO $IMG -c "zrp 0x2C000000 2"
+echo
+echo
+echo "(3) closing the first zone"
+$QEMU_IO $IMG -c "zc 0 0x4000000"
+echo "report after:"
+$QEMU_IO $IMG -c "zrp 0 1"
+echo
+echo "closing the last zone"
+$QEMU_IO $IMG -c "zc 0x3e70000000 0x4000000"
+echo "report after:"
+$QEMU_IO $IMG -c "zrp 0x3e70000000 2"
+echo
+echo
+echo "(4) finishing the second zone"
+$QEMU_IO $IMG -c "zf 0x4000000 0x4000000"
+echo "After finishing a zone:"
+$QEMU_IO $IMG -c "zrp 0x4000000 1"
+echo
+echo
+echo "(5) resetting the second zone"
+$QEMU_IO $IMG -c "zrs 0x4000000 0x4000000"
+echo "After resetting a zone:"
+$QEMU_IO $IMG -c "zrp 0x4000000 1"
+echo
+echo
+echo "(6) append write" # the physical block size of the device is 4096
+$QEMU_IO $IMG -c "zrp 0 1"
+$QEMU_IO $IMG -c "zap -p 0 0x1000 0x2000"
+echo "After appending the first zone firstly:"
+$QEMU_IO $IMG -c "zrp 0 1"
+$QEMU_IO $IMG -c "zap -p 0 0x1000 0x2000"
+echo "After appending the first zone secondly:"
+$QEMU_IO $IMG -c "zrp 0 1"
+$QEMU_IO $IMG -c "zap -p 0x4000000 0x1000 0x2000"
+echo "After appending the second zone firstly:"
+$QEMU_IO $IMG -c "zrp 0x4000000 1"
+$QEMU_IO $IMG -c "zap -p 0x4000000 0x1000 0x2000"
+echo "After appending the second zone secondly:"
+$QEMU_IO $IMG -c "zrp 0x4000000 1"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/zoned-qcow2.out b/tests/qemu-iotests/tests/zoned-qcow2.out
new file mode 100644
index 0000000000..288bceffc4
--- /dev/null
+++ b/tests/qemu-iotests/tests/zoned-qcow2.out
@@ -0,0 +1,87 @@
+QA output created by zoned-qcow2
+
+=== Initial image setup ===
+
+Formatting 'zbc.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib zoned_profile=zbc zone_size=67108864 zone_capacity=67108864 zone_nr_conv=0 max_append_sectors=512 max_active_zones=0 max_open_zones=0 size=805306368 lazy_refcounts=off refcount_bits=16
+
+=== Testing a qcow2 img with zoned format ===
+
+case 1: if the operations work
+(1) report the first zone:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+
+report the first 10 zones
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
+(2) opening the first zone
+wps[0]: 0x0
+report after:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:3, [type: 2]
+
+opening the second zone
+wps[1]: 0x20000
+report after:
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:3, [type: 2]
+
+opening the last zone
+wps[11]: 0x160000
+report after:
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:3, [type: 2]
+
+
+(3) closing the first zone
+wps[0]: 0x0
+report after:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:4, [type: 2]
+
+closing the last zone
+zone close failed: Input/output error
+report after:
+start: 0x1f380000, len 0x20000, cap 0x20000, wptr 0x0, zcond:0, [type: 2]
+start: 0x1f3a0000, len 0x20000, cap 0x20000, wptr 0x0, zcond:0, [type: 2]
+
+
+(4) finishing the second zone
+wps[1]: 0x40000
+After finishing a zone:
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:14, [type: 2]
+
+
+(5) resetting the second zone
+wps[1]: 0x20000
+After resetting a zone:
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+
+
+(6) append write
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:4, [type: 2]
+wps[0]: 0x18
+After zap done, the append sector is 0x0
+After appending the first zone firstly:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x18, zcond:2, [type: 2]
+wps[0]: 0x30
+After zap done, the append sector is 0x18
+After appending the first zone secondly:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x30, zcond:2, [type: 2]
+wps[1]: 0x20018
+After zap done, the append sector is 0x20000
+After appending the second zone firstly:
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20018, zcond:2, [type: 2]
+wps[1]: 0x20030
+After zap done, the append sector is 0x20018
+After appending the second zone secondly:
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20030, zcond:2, [type: 2]
+*** done
-- 
2.40.1



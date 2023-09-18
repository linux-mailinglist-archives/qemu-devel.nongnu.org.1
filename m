Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ECC7A4676
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:55:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAyH-0004Qp-5d; Mon, 18 Sep 2023 05:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qiAyE-0004QF-LE; Mon, 18 Sep 2023 05:55:10 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qiAyB-0002YB-Pp; Mon, 18 Sep 2023 05:55:10 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68fb898ab3bso3218472b3a.3; 
 Mon, 18 Sep 2023 02:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695030905; x=1695635705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XEg6fx9X1yK3mjuewyeyVxc+jZW0WnORrc+Ci4vDo0=;
 b=Ei2rndtl3KGJcxUYKOZOwKW2BXcW9n6yzDvRiAzUX5I6eNVhYpBHc7a8qDM4qFc+tZ
 5ymEaaN3b6rpHCAhPurAwmUWICbxZA18KxBA71hmHk9wWwR8/+v/iM84uzyKN+3fSrGR
 +Wq/esQNmGyB4BppP8wKvhsRERJigLa8Nan28I/sU3aQpvwpPAEI7cvQ28cnaVaboPrw
 BpB8LmDFwIu5aIJ+h0SBjpZDf+1x4xznaXy+sfWI6wjrLENNhD1TBjcFeXV+YE9p37Hz
 IJej7TNsdz6pEBrrQxR6g+u5bLZR50GhytU8eJbIHuLf/TXANohm6BRIrH7eGlKXLRFC
 dkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695030905; x=1695635705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XEg6fx9X1yK3mjuewyeyVxc+jZW0WnORrc+Ci4vDo0=;
 b=gd0L4rb0lviiZ07q5KK6D6vSBehGjjB4Fxzn9da2rICVgpwkcsIitcGgrNDikLCCgp
 LtYbyY8c1cbSKKnAzJ1NHJrFBZMx1aQhQL/JqW1E1p2ySjZpmCdPdQZd2Gip02/+hmxS
 BwWulDA0T6yjK852rk1vB9yW7cUr8N85jEcbNzCTFKA1BvR8orXxsRVoLTjE4z/0iBJh
 MomUPHVSCTG0LJAFIsIfYTSgUH/KBm3dWwYStTNGP/P8o0ykS0oKverQe4BsRM9+k/Ev
 jOjr6R80sYPz1zsfcWcqxA0FMw+/Hnk5VLtQ5QsmxCAtv888mpESWQIxgbUyX/RHoNwI
 wPdQ==
X-Gm-Message-State: AOJu0Yy8epa/1WvvwsBrXqwBJwR3Rik43P+WPfJw6Dyl1Uwqsc6cokhi
 vQkRIgMYN/bNYAVOpjxnrQJgb2DWgJcFh1i1+aI=
X-Google-Smtp-Source: AGHT+IH/iZSniaAdBOFUw76BHi9AnBPpIShnLcJ5sb+lWghJHpgwci5W/KBMA8gt6Sj6BG04eQyL1A==
X-Received: by 2002:a05:6a20:5652:b0:155:2359:e28c with SMTP id
 is18-20020a056a20565200b001552359e28cmr6967267pzc.9.1695030904139; 
 Mon, 18 Sep 2023 02:55:04 -0700 (PDT)
Received: from fedlinux.. ([106.84.131.213]) by smtp.gmail.com with ESMTPSA id
 y24-20020aa78558000000b0068fb8080939sm6780553pfn.65.2023.09.18.02.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 02:55:03 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dmitry.fomichev@wdc.com, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com, hare@suse.de,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v4 4/4] iotests: test the zoned format feature for qcow2 file
Date: Mon, 18 Sep 2023 17:53:13 +0800
Message-Id: <20230918095313.5492-5-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918095313.5492-1-faithilikerun@gmail.com>
References: <20230918095313.5492-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=faithilikerun@gmail.com; helo=mail-pf1-x430.google.com
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
$ tests/qemu-iotests/check -qcow2 zoned-qcow2

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/tests/zoned-qcow2     | 129 ++++++++++++++++++++++
 tests/qemu-iotests/tests/zoned-qcow2.out | 133 +++++++++++++++++++++++
 2 files changed, 262 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

diff --git a/tests/qemu-iotests/tests/zoned-qcow2 b/tests/qemu-iotests/tests/zoned-qcow2
new file mode 100755
index 0000000000..22e34ff6a0
--- /dev/null
+++ b/tests/qemu-iotests/tests/zoned-qcow2
@@ -0,0 +1,129 @@
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
+-o zone_capacity=64M -o nr_conv_zones=0 -o max_append_sectors=131072 \
+-o max_open_zones=0 -o max_active_zones=0 -o zone_model=1
+
+IMG="--image-opts -n driver=qcow2,file.driver=file,file.filename=$file_name"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+echo
+echo "=== Testing a qcow2 img with zoned format ==="
+echo
+echo "case 1: test persistent zone states"
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
+echo "(2) finish zones[0]:"
+$QEMU_IO $IMG -c "zf 0 0x4000000" # 0x4000000 / 512 = 0x20000
+$QEMU_IO $IMG -c "zrp 0 1"
+echo
+echo "finish zones[1]"
+$QEMU_IO $IMG -c "zf 64M 64M"
+$QEMU_IO $IMG -c "zrp 0x4000000 1"
+echo
+echo "finish the last zone"
+$QEMU_IO $IMG -c "zf 0x2C000000 0x4000000"
+$QEMU_IO $IMG -c "zrp 0x2C000000 2"
+echo
+echo
+echo "(3) reset zones[0]: full => empty"
+$QEMU_IO $IMG -c "zrs 0 0x4000000" # 0x4000000 / 512 = 0x20000
+$QEMU_IO $IMG -c "zrp 0 1"
+echo
+echo "reset zones[1]:"
+$QEMU_IO $IMG -c "zrs 0x4000000 0x4000000"
+$QEMU_IO $IMG -c "zrp 0x4000000 1"
+echo
+echo "reset the last zone"
+$QEMU_IO $IMG -c "zrs 0x2C000000 0x4000000"
+$QEMU_IO $IMG -c "zrp 0x2C000000 2"
+echo
+echo
+echo "(4) append write with (4k, 8k) data" # the physical block size of the device is 4096
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
index 0000000000..5aab6f1572
--- /dev/null
+++ b/tests/qemu-iotests/tests/zoned-qcow2.out
@@ -0,0 +1,133 @@
+QA output created by zoned-qcow2
+
+=== Initial image setup ===
+
+Formatting 'zbc.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib zone_model=1 zone_size=67108864 zone_capacity=67108864 nr_conv_zones=0 max_append_sectors=131072 max_active_zones=0 max_open_zones=0 size=805306368 lazy_refcounts=off refcount_bits=16
+
+=== Testing a qcow2 img with zoned format ===
+
+case 1: test persistent zone states
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
+(2) finish zones[0]:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x20000, zcond:14, [type: 2]
+
+finish zones[1]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:14, [type: 2]
+
+finish the last zone
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x180000, zcond:14, [type: 2]
+
+
+(3) reset zones[0]: full => empty
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+
+reset zones[1]:
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+
+reset the last zone
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+
+
+(4) append write with (4k, 8k) data
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
+Append write zones[0] one time:
+After zap done, the append sector is 0x0
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x18, zcond:4, [type: 2]
+
+Append write zones[0] twice:
+After zap done, the append sector is 0x18
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x30, zcond:4, [type: 2]
+
+Append write zones[1] one time:
+After zap done, the append sector is 0x20000
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20018, zcond:4, [type: 2]
+
+Append write zones[1] twice:
+After zap done, the append sector is 0x20018
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20030, zcond:4, [type: 2]
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
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x10, zcond:4, [type: 2]
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
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x10, zcond:4, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60010, zcond:4, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100010, zcond:4, [type: 2]
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



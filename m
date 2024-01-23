Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B493F838685
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 06:06:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS8y7-0005yu-3y; Tue, 23 Jan 2024 00:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rS8y5-0005yS-9m
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 00:05:01 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rS8y2-0001iy-N1
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 00:05:00 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d71e24845aso20712745ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 21:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705986296; x=1706591096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6OnhMPqtndyR7XGRVCe7mUpR7VFez00ZDn2eDaXke6c=;
 b=iZmLJyUL0/BtwR/kJb07643XIyZPM15knRjrfLlAF4a7K3+eqk7EeFLstMHMj/kHPr
 2gMgItg/BSSRXWjNxNn9O6AM977qVl773xaIYQn0TbEXg6Q8bPvjj5hMIbEFxHWCYPO8
 hsB03Mmr/Qyw6k88w6QySG/399UbDYZlxj0EKyZc/wMo5fX2cwoEDLH7cxwKj1OZG+HR
 hCajE0drbkiOnWjtjgjls/2BM4f5d6ccEStD7AvOiYlboJVnOJUeuUJ8q+TKef3v72g1
 P614Vf0i3p/COSkKY3REdGE7muwvn9Zk0c+4hdBsB7mMfCtPsdjNHmIJqNb5I99Enaj9
 vJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705986296; x=1706591096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6OnhMPqtndyR7XGRVCe7mUpR7VFez00ZDn2eDaXke6c=;
 b=OgiWKfWTNFB7KgyP8L/TyaQqeVFq+6UWrR31FBEQkc5Njb0V4hZ9KTerhMbmUM/kBz
 ZP65MtihWhgeMw9MnMzRzSzEWyoH4iOyUbyK58fJ47hL3vNjgIfMC4bMNJepPn0iFz5T
 8vvxEKbKURAqnO1MkLtKIe1UKda8c+Y0odqLj7RIZ3RMMoeU0rg75dnd9/WwTtLQwQpG
 yt7Bkc/uWCqYTj3drg2pvlTMS+V3hpLUYMzKgLzOcUn4i12yfYkS/fMQoLF3dxlWrG6o
 dJPOOdpilK4wJMPdKpuKrqovp5gLaqDIFPiPoRzai0iVX4RUPJ/foKqiGtdua+lKChE8
 ceBg==
X-Gm-Message-State: AOJu0YxZ4pZCf11Nn2o9I+TfCW8rYQXiRMge0K5e8ywBiSya3UJ2K6Nb
 W3FpvcsXO1ZSx5ieZCNgvbuAjkm/qh118bEp46JwpFZ0eBn97RhQn1HF0fAMlSLfMw==
X-Google-Smtp-Source: AGHT+IFkoCxdVGgZGTJq1P5i1FjDgwdExCr+cXNoc31IuvugyW1XO9UVRmHHwvYrEj7MNFmItvVYOQ==
X-Received: by 2002:a17:903:428a:b0:1d0:b1f0:1005 with SMTP id
 ju10-20020a170903428a00b001d0b1f01005mr2546984plb.63.1705986296037; 
 Mon, 22 Jan 2024 21:04:56 -0800 (PST)
Received: from iuseotherswifi.notpua ([218.185.248.66])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902b78900b001d7207fa2a7sm6082222pls.152.2024.01.22.21.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 21:04:55 -0800 (PST)
From: Abhiram Tilak <atp.exp@gmail.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com,
	kwolf@redhat.com,
	Abhiram Tilak <atp.exp@gmail.com>
Subject: [PATCH v4] qemu-img: Fix Column Width and Improve Formatting in
 snapshot list
Date: Tue, 23 Jan 2024 10:33:55 +0530
Message-ID: <20240123050354.22152-2-atp.exp@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=atp.exp@gmail.com; helo=mail-pl1-x62d.google.com
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

When running the command `qemu-img snapshot -l SNAPSHOT` the output of
VM_CLOCK (measures the offset between host and VM clock) cannot to
accommodate values in the order of thousands (4-digit).

This line [1] hints on the problem. Additionally, the column width for
the VM_CLOCK field was reduced from 15 to 13 spaces in commit b39847a5
in line [2], resulting in a shortage of space.

[1]:
https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L753
[2]:
https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L763

This patch restores the column width to 15 spaces and makes adjustments
to the affected iotests accordingly. Furthermore, addresses a potential
source
of confusion by removing whitespace in column headers. Example, VM CLOCK
is modified to VM_CLOCK. Additionally a '--' symbol is introduced when
ICOUNT returns no output for clarity.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2062
Fixes: b39847a50553 (migration: introduce icount field for snapshots )
Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
---
 v4:
    * Fit the column width within 80 characters by shrinking 'ID' field
    * Add spaces between both fields and values for better spacing and
       printing
 v3:
    * Make a patch by avoid changing the .patch file
 v2:
    * Change email provider to 'gmail' to avoid auto-wrapping patches
    * Modify iotests for file 'qcow2-internal-snapshots.out'

 block/qapi.c                                  | 10 ++--
 tests/qemu-iotests/176.out                    | 16 +++----
 tests/qemu-iotests/267.out                    | 48 +++++++++----------
 .../tests/qcow2-internal-snapshots.out        | 14 +++---
 4 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 9e806fa230..5f2182c406 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -742,15 +742,15 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
     char *sizing = NULL;
 
     if (!sn) {
-        qemu_printf("%-10s%-17s%8s%20s%13s%11s",
-                    "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK", "ICOUNT");
+        qemu_printf("%-7s %-16s %8s %19s %15s %10s",
+                    "ID", "TAG", "VM_SIZE", "DATE", "VM_CLOCK", "ICOUNT");
     } else {
         g_autoptr(GDateTime) date = g_date_time_new_from_unix_local(sn->date_sec);
         g_autofree char *date_buf = g_date_time_format(date, "%Y-%m-%d %H:%M:%S");
 
         secs = sn->vm_clock_nsec / 1000000000;
         snprintf(clock_buf, sizeof(clock_buf),
-                 "%02d:%02d:%02d.%03d",
+                 "%04d:%02d:%02d.%03d",
                  (int)(secs / 3600),
                  (int)((secs / 60) % 60),
                  (int)(secs % 60),
@@ -759,8 +759,10 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
         if (sn->icount != -1ULL) {
             snprintf(icount_buf, sizeof(icount_buf),
                 "%"PRId64, sn->icount);
+        } else {
+            snprintf(icount_buf, sizeof(icount_buf), "--");
         }
-        qemu_printf("%-9s %-16s %8s%20s%13s%11s",
+        qemu_printf("%-7s %-16s %8s %19s %15s %10s",
                     sn->id_str, sn->name,
                     sizing,
                     date_buf,
diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
index 9d09b60452..dce1ca0446 100644
--- a/tests/qemu-iotests/176.out
+++ b/tests/qemu-iotests/176.out
@@ -37,8 +37,8 @@ Offset          Length          File
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
 0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
 Snapshot list:
-ID        TAG
-1         snap
+ID      TAG
+1       snap
 
 === Test pass snapshot.1 ===
 
@@ -78,8 +78,8 @@ Offset          Length          File
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
 0x83400000      0x200           TEST_DIR/t.IMGFMT
 Snapshot list:
-ID        TAG
-1         snap
+ID      TAG
+1       snap
 
 === Test pass snapshot.2 ===
 
@@ -119,8 +119,8 @@ Offset          Length          File
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
 0x83400000      0x200           TEST_DIR/t.IMGFMT
 Snapshot list:
-ID        TAG
-1         snap
+ID      TAG
+1       snap
 
 === Test pass snapshot.3 ===
 
@@ -157,8 +157,8 @@ Offset          Length          File
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
 0x83400000      0x200           TEST_DIR/t.IMGFMT
 Snapshot list:
-ID        TAG
-1         snap
+ID      TAG
+1       snap
 
 === Test pass bitmap.0 ===
 
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index 7176e376e1..f6f5d8715a 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -33,8 +33,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -44,8 +44,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -69,8 +69,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -94,8 +94,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -105,8 +105,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -119,8 +119,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -134,8 +134,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -145,15 +145,15 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
 Internal snapshots on overlay:
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 Internal snapshots on backing file:
 
 === -blockdev with NBD server on the backing file ===
@@ -166,17 +166,17 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
 Internal snapshots on overlay:
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 Internal snapshots on backing file:
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 *** done
diff --git a/tests/qemu-iotests/tests/qcow2-internal-snapshots.out b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
index 438f535e6a..fedb09224e 100644
--- a/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
+++ b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
@@ -14,8 +14,8 @@ wrote 524288/524288 bytes at offset 0
 (qemu) quit
 
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 No errors were found on the image.
 
 === Verify that loading the snapshot reverts to the old content ===
@@ -47,9 +47,9 @@ read 64512/64512 bytes at offset 66560
 (qemu) quit
 
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
-2         snap1                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
+2       snap1                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 No errors were found on the image.
 
 === qemu-img snapshot can revert to snapshots ===
@@ -79,8 +79,8 @@ read 64512/64512 bytes at offset 66560
 (qemu) quit
 
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 No errors were found on the image.
 
 === Error cases ===
-- 
2.42.1



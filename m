Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDEC82B429
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:32:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyte-0003AI-2t; Thu, 11 Jan 2024 12:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rNytI-00039T-Gu
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:30:52 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rNytA-0000wo-L1
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:30:49 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d595de968bso4044945ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704994239; x=1705599039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E6M8v2P914ljYAUSolw34Nw6Wxs2yrKklUlzq72RZNA=;
 b=YPldbSUuUxq8NaWPdzYTEZqO9mRiHWiZZ45t4sDxkmx4FR4fWg1y/lGal71aPQ7wLI
 9+7Qx7FvyxRED0N7A62SYWmWmoTzmfXBmKctupwYPrwcQP8qZA0vodVjIrQXTPSBxJRG
 gQBCJJZcNUGMGBMqd6P2mRNZuf1PfGFLJnpPcY3R/4gKrLfZUdKyenyq80OZ3UXIkj5Y
 edugRh4HBMA6XhaomoJX5axrt/Cj9AqcpbJ4iqNEGjXBH2utrylEFGoU83dSaclBsT67
 X3avOAiZ7HCVHCKTKQ8yC0BSogLzFSWofZalPMVgzNu5rBEgVa1FDmwIxS/VZXMwI0lN
 RLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704994239; x=1705599039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E6M8v2P914ljYAUSolw34Nw6Wxs2yrKklUlzq72RZNA=;
 b=p6ly/2CFXw2meAlV1jz5btGkjpz2rT3MyYOM42fnWeXwNkE63PhMT0G/s2y/DHNcy8
 v2oxh/MKZ9MVOzQhDxBs5FI3MUsymYiM+ANgGa1T8WUskUcnIJAC2LwsBHDQlLLEBG/M
 7rn3VZJsSgOQdLP8WSD/kntw9V/JwlKcywhkKZeTfSinEnLrVTMwUsXD+GsvfIofRqsP
 VJN7BTM5BtdgY4rN6EKhKWdTNa/AmvTm+zP+4Qj6akK0DstX0fMUcgwUfvWGeHK/31SW
 7Lxz5CBmfdPF1Y6UR/d/yRo6af9q1XOqMVwAuPbTwnsIWQOfPXCztwjraacF42CSZPyk
 b8ew==
X-Gm-Message-State: AOJu0YznYJBl8dHI6EoHSb0o2lXqW8BmmUzJ3i9d+nex2VyO8mmPl82R
 3WmNTZKBJk7bJ0QQe7PCbOsdvm+s0iCiYg==
X-Google-Smtp-Source: AGHT+IH3hXZ3+F84z0r2yIHVePhmJ9MO2ufRLAyCKMC4CmGcnkIU/nMP9muXmQ13uZmYtL87oi7UiA==
X-Received: by 2002:a17:902:6b02:b0:1d0:7adc:1af0 with SMTP id
 o2-20020a1709026b0200b001d07adc1af0mr38237plk.35.1704994239482; 
 Thu, 11 Jan 2024 09:30:39 -0800 (PST)
Received: from akshara-VivoBook-ASUSLaptop-X409DA-M409DA.mshome.net
 ([218.185.248.66]) by smtp.gmail.com with ESMTPSA id
 a20-20020a170902ee9400b001d3dacffde3sm1403941pld.226.2024.01.11.09.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 09:30:38 -0800 (PST)
From: Abhiram Tilak <atp.exp@gmail.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	hreitz@redhat.com,
	Abhiram Tilak <atp.exp@gmail.com>
Subject: [PATCH v3] qemu-img: Fix Column Width and Improve Formatting in
 snapshot list
Date: Thu, 11 Jan 2024 22:55:47 +0530
Message-Id: <20240111172546.823263-1-atp.exp@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=atp.exp@gmail.com; helo=mail-pl1-x62f.google.com
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

[1]: https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L753
[2]: https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L763

This patch restores the column width to 15 spaces and makes adjustments
to the affected iotests accordingly. Furthermore, addresses a potential source
of confusion by removing whitespace in column headers. Example, VM CLOCK
is modified to VM_CLOCK. Additionally a '--' symbol is introduced when
ICOUNT returns no output for clarity.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2062
Fixes: b39847a50553 (migration: introduce icount field for snapshots )
Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
---
 v3:
    * Make a patch by avoid changing the .patch file
 v2:
    * Change email provider to 'gmail' to avoid auto-wrapping patches
    * Modify iotests for file 'qcow2-internal-snapshots.out'

 block/qapi.c                                  | 10 ++--
 tests/qemu-iotests/267.out                    | 48 +++++++++----------
 .../tests/qcow2-internal-snapshots.out        | 10 ++--
 3 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 9e806fa230..ee066ee53c 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -742,15 +742,15 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
     char *sizing = NULL;
 
     if (!sn) {
-        qemu_printf("%-10s%-17s%8s%20s%13s%11s",
-                    "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK", "ICOUNT");
+        qemu_printf("%-10s%-17s%8s%20s%15s%11s",
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
+        qemu_printf("%-9s %-16s %8s%20s%15s%11s",
                     sn->id_str, sn->name,
                     sizing,
                     date_buf,
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index 7176e376e1..21339e67ad 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -33,8 +33,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID        TAG               VM_SIZE                DATE       VM_CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -44,8 +44,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID        TAG               VM_SIZE                DATE       VM_CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -69,8 +69,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID        TAG               VM_SIZE                DATE       VM_CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -94,8 +94,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID        TAG               VM_SIZE                DATE       VM_CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -105,8 +105,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID        TAG               VM_SIZE                DATE       VM_CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -119,8 +119,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID        TAG               VM_SIZE                DATE       VM_CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -134,8 +134,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID        TAG               VM_SIZE                DATE       VM_CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -145,15 +145,15 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID        TAG               VM_SIZE                DATE       VM_CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
 Internal snapshots on overlay:
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID        TAG               VM_SIZE                DATE       VM_CLOCK     ICOUNT
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 Internal snapshots on backing file:
 
 === -blockdev with NBD server on the backing file ===
@@ -166,17 +166,17 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID        TAG               VM_SIZE                DATE       VM_CLOCK     ICOUNT
+--        snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
 Internal snapshots on overlay:
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID        TAG               VM_SIZE                DATE       VM_CLOCK     ICOUNT
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 Internal snapshots on backing file:
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID        TAG               VM_SIZE                DATE       VM_CLOCK     ICOUNT
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 *** done
diff --git a/tests/qemu-iotests/tests/qcow2-internal-snapshots.out b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
index 438f535e6a..c324131561 100644
--- a/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
+++ b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
@@ -14,8 +14,8 @@ wrote 524288/524288 bytes at offset 0
 (qemu) quit
 
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID        TAG               VM_SIZE                DATE       VM_CLOCK     ICOUNT
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 No errors were found on the image.
 
 === Verify that loading the snapshot reverts to the old content ===
@@ -48,8 +48,8 @@ read 64512/64512 bytes at offset 66560
 
 Snapshot list:
 ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
-2         snap1                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
+2         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 No errors were found on the image.
 
 === qemu-img snapshot can revert to snapshots ===
@@ -80,7 +80,7 @@ read 64512/64512 bytes at offset 66560
 
 Snapshot list:
 ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+1         snap0                SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000         --
 No errors were found on the image.
 
 === Error cases ===
-- 
2.40.1



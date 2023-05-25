Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF01710E39
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:22:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BlI-0004iF-TH; Thu, 25 May 2023 10:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2BlA-0004gN-0T
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bl7-0007fc-UN
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nl9YV0klK4c1Ul2Mo+osatIzoXVRjqjEwHKUgZuQG0k=;
 b=AByi5opGCRAKHQad0otfcv1GaDtTZIrsQuvAYv84CUA6KYHq8vWKfOZFPNWhdbjdz/M5QS
 LB1+WvLmhnNOnuJcoYCov3SA4SzMyU8OSlrXjSejj0yPqrfpuRKjE45zSTgrZIClIOOO2k
 w/qXDNOokMIALrYmpandetUI8fy7Zs8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Cl4a1RUrMCqO22nAoYX4bQ-1; Thu, 25 May 2023 10:15:59 -0400
X-MC-Unique: Cl4a1RUrMCqO22nAoYX4bQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-96f6fee8123so71057166b.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024157; x=1687616157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nl9YV0klK4c1Ul2Mo+osatIzoXVRjqjEwHKUgZuQG0k=;
 b=jxpXv+dUIWp1bBO8RwqT3wSdz1YD+KP9nceiLa48sI136vKlCGCRPtRp83UEMRejz0
 f7VlZXGGkgQh9hkKRuzC0fRdqPW6Y7O8hzDohPeQH8vrH5YLejqMTyWjrhE+6JghHmtv
 uexdpPhBMPe0QRTLRFfUoGdm8k5T7K22G4MlbizhXoz5yOoaZnxffCIY8GXqClEe8G49
 j+t0vAAYmCm7kKBawjTkoYH/JpXXQ0CmW7J6X8Ezf9n4ABFhh+EAkZqBbx1MySWDZIpN
 RTlmKR8llLkEtgG2Vv0qvICn10ntVS7i4L0B7siPW8cFU+UfXFFnWKEAsu1qK8MJgrKQ
 xkYQ==
X-Gm-Message-State: AC+VfDxKM5efzPQPO+AvPzJ7s0/KlxOlAaHwbgWU6B8eknl/MyV8xp1i
 ceTJlqi+yxvdZFVkQT9XeWj1VTUgsrLtbybTe9ITNllzooF8T8VcnElJPEeFauutbX2M0MWoENS
 UYMo/h2hPKMEP08F7zqv7rVxw6bIN4D58OPkREaA1zkOLxQhJyu0j+JvQafJeq1/UvGe+JhFeb5
 U=
X-Received: by 2002:a17:907:a0a:b0:971:5a79:29ff with SMTP id
 bb10-20020a1709070a0a00b009715a7929ffmr1562420ejc.48.1685024157087; 
 Thu, 25 May 2023 07:15:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76WxchKBj9jYIH4J4u/jA35DHx9fWY5rBgjwjYyYcuYxpV2kOqbFP1L79eFihFSUnwdTfGpQ==
X-Received: by 2002:a17:907:a0a:b0:971:5a79:29ff with SMTP id
 bb10-20020a1709070a0a00b009715a7929ffmr1562389ejc.48.1685024156597; 
 Thu, 25 May 2023 07:15:56 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 v24-20020a170906b01800b0096f6e2f4d9esm880665ejy.83.2023.05.25.07.15.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/20] monitor: do not use mb_read/mb_set for suspend_cnt
Date: Thu, 25 May 2023 16:15:27 +0200
Message-Id: <20230525141532.295817-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Clean up monitor_event to just use monitor_suspend/monitor_resume,
using mon->mux_out to protect against incorrect nesting (especially
on startup).

The only remaining case of reading suspend_cnt is in the can_read
callback, which is just advisory and can use qatomic_read.

As an extra benefit, mux_out is now simply protected by mon_lock.
Also, moving the prompt to the beginning of the main loop removes
it from the output in some error cases where QEMU does not actually
start successfully.  It is not a full fix and it would be nice to
also remove the monitor heading, but this is already a small (though
unintentional) improvement.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/hmp.c                 | 41 ++++++++++++++++-------------------
 monitor/monitor-internal.h    |  3 +--
 monitor/monitor.c             |  9 ++++++--
 tests/qemu-iotests/051.out    |  4 ++--
 tests/qemu-iotests/051.pc.out | 20 ++++++++---------
 5 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 5cab56d355c8..69c1b7e98abb 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1401,45 +1401,42 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
 static void monitor_event(void *opaque, QEMUChrEvent event)
 {
     Monitor *mon = opaque;
-    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
 
     switch (event) {
     case CHR_EVENT_MUX_IN:
         qemu_mutex_lock(&mon->mon_lock);
-        mon->mux_out = 0;
-        qemu_mutex_unlock(&mon->mon_lock);
-        if (mon->reset_seen) {
-            readline_restart(hmp_mon->rs);
+        if (mon->mux_out) {
+            mon->mux_out = 0;
             monitor_resume(mon);
-            monitor_flush(mon);
-        } else {
-            qatomic_mb_set(&mon->suspend_cnt, 0);
         }
+        qemu_mutex_unlock(&mon->mon_lock);
         break;
 
     case CHR_EVENT_MUX_OUT:
-        if (mon->reset_seen) {
-            if (qatomic_mb_read(&mon->suspend_cnt) == 0) {
-                monitor_printf(mon, "\n");
-            }
-            monitor_flush(mon);
-            monitor_suspend(mon);
-        } else {
-            qatomic_inc(&mon->suspend_cnt);
-        }
         qemu_mutex_lock(&mon->mon_lock);
-        mon->mux_out = 1;
+        if (!mon->mux_out) {
+            if (mon->reset_seen && !mon->suspend_cnt) {
+                monitor_puts_locked(mon, "\n");
+            } else {
+                monitor_flush_locked(mon);
+            }
+            monitor_suspend(mon);
+            mon->mux_out = 1;
+        }
         qemu_mutex_unlock(&mon->mon_lock);
         break;
 
     case CHR_EVENT_OPENED:
         monitor_printf(mon, "QEMU %s monitor - type 'help' for more "
                        "information\n", QEMU_VERSION);
-        if (!mon->mux_out) {
-            readline_restart(hmp_mon->rs);
-            readline_show_prompt(hmp_mon->rs);
-        }
+        qemu_mutex_lock(&mon->mon_lock);
         mon->reset_seen = 1;
+        if (!mon->mux_out) {
+            /* Suspend-resume forces the prompt to be printed.  */
+            monitor_suspend(mon);
+            monitor_resume(mon);
+        }
+        qemu_mutex_unlock(&mon->mon_lock);
         mon_refcount++;
         break;
 
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 53e3808054c7..61c9b6916db3 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -94,7 +94,6 @@ typedef struct HMPCommand {
 
 struct Monitor {
     CharBackend chr;
-    int reset_seen;
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool is_qmp;
     bool skip_flush;
@@ -115,8 +114,8 @@ struct Monitor {
     QLIST_HEAD(, mon_fd_t) fds;
     GString *outbuf;
     guint out_watch;
-    /* Read under either BQL or mon_lock, written with BQL+mon_lock.  */
     int mux_out;
+    int reset_seen;
 };
 
 struct MonitorHMP {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 20e33e28d20d..15f97538ef2b 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -569,10 +569,15 @@ static void monitor_accept_input(void *opaque)
 {
     Monitor *mon = opaque;
 
-    if (!monitor_is_qmp(mon)) {
+    qemu_mutex_lock(&mon->mon_lock);
+    if (!monitor_is_qmp(mon) && mon->reset_seen) {
         MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
         assert(hmp_mon->rs);
+        readline_restart(hmp_mon->rs);
+        qemu_mutex_unlock(&mon->mon_lock);
         readline_show_prompt(hmp_mon->rs);
+    } else {
+        qemu_mutex_unlock(&mon->mon_lock);
     }
 
     qemu_chr_fe_accept_input(&mon->chr);
@@ -603,7 +608,7 @@ int monitor_can_read(void *opaque)
 {
     Monitor *mon = opaque;
 
-    return !qatomic_mb_read(&mon->suspend_cnt);
+    return !qatomic_read(&mon->suspend_cnt);
 }
 
 void monitor_list_append(Monitor *mon)
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index e5ddb03bda1d..d46215640506 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -74,7 +74,7 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=foo#12: Invalid node-name: 'fo
 
 Testing: -device virtio-scsi -device scsi-hd
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device scsi-hd: drive property not set
+QEMU_PROG: -device scsi-hd: drive property not set
 
 
 === Overriding backing file ===
@@ -134,7 +134,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive if=virtio
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive if=virtio: Device needs media, but drive is empty
+QEMU_PROG: -drive if=virtio: Device needs media, but drive is empty
 
 
 === Attach to node in non-default iothread ===
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index bade1ff3b929..4d4af5a486df 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -74,7 +74,7 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=foo#12: Invalid node-name: 'fo
 
 Testing: -device virtio-scsi -device scsi-hd
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device scsi-hd: drive property not set
+QEMU_PROG: -device scsi-hd: drive property not set
 
 
 === Overriding backing file ===
@@ -142,11 +142,11 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive if=ide
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Device needs media, but drive is empty
+QEMU_PROG: Device needs media, but drive is empty
 
 Testing: -drive if=virtio
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -drive if=virtio: Device needs media, but drive is empty
+QEMU_PROG: -drive if=virtio: Device needs media, but drive is empty
 
 Testing: -drive if=none,id=disk -device ide-cd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -158,22 +158,22 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive if=none,id=disk -device ide-hd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device ide-hd,drive=disk: Device needs media, but drive is empty
+QEMU_PROG: -device ide-hd,drive=disk: Device needs media, but drive is empty
 
 Testing: -drive if=none,id=disk -device lsi53c895a -device scsi-hd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device scsi-hd,drive=disk: Device needs media, but drive is empty
+QEMU_PROG: -device scsi-hd,drive=disk: Device needs media, but drive is empty
 
 
 === Attach to node in non-default iothread ===
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device ide-hd,drive=disk,share-rw=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device ide-hd,drive=disk,share-rw=on: Cannot change iothread of active block backend
+QEMU_PROG: -device ide-hd,drive=disk,share-rw=on: Cannot change iothread of active block backend
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device virtio-blk-pci,drive=disk,share-rw=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device virtio-blk-pci,drive=disk,share-rw=on: Cannot change iothread of active block backend
+QEMU_PROG: -device virtio-blk-pci,drive=disk,share-rw=on: Cannot change iothread of active block backend
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device lsi53c895a,id=lsi0 -device scsi-hd,bus=lsi0.0,drive=disk,share-rw=on
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -185,7 +185,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device virtio-blk-pci,drive=disk,iothread=thread0,share-rw=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device virtio-blk-pci,drive=disk,iothread=thread0,share-rw=on: Cannot change iothread of active block backend
+QEMU_PROG: -device virtio-blk-pci,drive=disk,iothread=thread0,share-rw=on: Cannot change iothread of active block backend
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device virtio-scsi,id=virtio-scsi1,iothread=thread0 -device scsi-hd,bus=virtio-scsi1.0,drive=disk,share-rw=on
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -204,7 +204,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=ide,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Block node is read-only
+QEMU_PROG: Block node is read-only
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=virtio,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -220,7 +220,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device ide-hd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device ide-hd,drive=disk: Block node is read-only
+QEMU_PROG: -device ide-hd,drive=disk: Block node is read-only
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device lsi53c895a -device scsi-hd,drive=disk
 QEMU X.Y.Z monitor - type 'help' for more information
-- 
2.40.1



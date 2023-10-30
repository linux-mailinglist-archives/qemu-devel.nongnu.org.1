Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 372167DBDFE
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:34:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVDL-0003bu-QV; Mon, 30 Oct 2023 12:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxVDH-0003ZC-LZ
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxVDF-0002ei-SE
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698683640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n72f+wW5+nHH0hrvaXv+6sujX9qgSyymTozlBQoTr/0=;
 b=A2dD5DdMctkeJfhaWqZHADNLtkHOxF4UGbPTgx2bUlR6/ncWPSow4IPxNHILE5KPppYQO7
 b0plHrnS1Q+goGqXUz1Ea9qmHw7Ty6az7uieAydGACQKheaad/0YB9HClHT4UIkRj16InT
 ISHSq/ZGWX6zBB3Rdu5pyQPCFLqzPPs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-w5zZZP9sOweHN-sd_gcNVw-1; Mon, 30 Oct 2023 12:33:59 -0400
X-MC-Unique: w5zZZP9sOweHN-sd_gcNVw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41cd9e05c8bso5543201cf.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 09:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698683638; x=1699288438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n72f+wW5+nHH0hrvaXv+6sujX9qgSyymTozlBQoTr/0=;
 b=d5XtYsTzevzLHUr0LM7dazPMhR9zmMco4ay1nFdpCvMW8b0HzlTRUmzFmtilA/7Ks9
 UHDNGxkAHWNb3hyLkZyz3ZBqOPdn4oGnFu+Ds2CsrfeGkDvJ9wk4MTh1xABU7LLhDrSy
 KizvZaVhOWmXMnNCY8gfm71ZFhfXScZh8MEV7dWYlLtY1feX8i5srVhqt72IsWbcifqR
 eWZpQ7bx34hNxzNAwbRB2adTM9fJwJkGLAemxSlJaCArxfXJJwe3K7ruVbmtQrKCO3km
 dieycKQryGbqoDwxMk0yRj9M03hQob20J3bEcDdainTlx+BqCD4K1HPJuWBbtccJJVtA
 Zxnw==
X-Gm-Message-State: AOJu0YyEa+emOmdiZRUlqUW+oKPE91J1YuvoI6Q/C8Ldi9MP7pPZSL4b
 YsFFIxBbbcfWkOKb3KvvXxBFa/gmwPwZgLEAaOxPIy4WcUKabn271hPgEIox1bLfT5jk0Y1c8i+
 nHZ/duBAFWKnkIzkqm9ZWQEsl7gm+a5pleeN7qMnRwn1Y0Z0F7798BDP2frp1YFOxwp6xSbdN
X-Received: by 2002:ac8:7741:0:b0:41e:49e9:fb18 with SMTP id
 g1-20020ac87741000000b0041e49e9fb18mr9410865qtu.0.1698683638471; 
 Mon, 30 Oct 2023 09:33:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiYuxKmquYKgUDZeKHAEAqk4Rqrmvcd22fxDfcMkno5M9zWKArIcp/0/Vi+MF3CudfyG9mvQ==
X-Received: by 2002:ac8:7741:0:b0:41e:49e9:fb18 with SMTP id
 g1-20020ac87741000000b0041e49e9fb18mr9410846qtu.0.1698683638093; 
 Mon, 30 Oct 2023 09:33:58 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 l15-20020ac84ccf000000b004198ae7f841sm3531111qtv.90.2023.10.30.09.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 09:33:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 3/5] migration: Add per vmstate downtime tracepoints
Date: Mon, 30 Oct 2023 12:33:44 -0400
Message-ID: <20231030163346.765724-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030163346.765724-1-peterx@redhat.com>
References: <20231030163346.765724-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We have a bunch of savevm_section* tracepoints, they're good to analyze
migration stream, but not always suitable if someone would like to analyze
the migration downtime.  Two major problems:

  - savevm_section* tracepoints are dumping all sections, we only care
    about the sections that contribute to the downtime

  - They don't have an identifier to show the type of sections, so no way
    to filter downtime information either easily.

We can add type into the tracepoints, but instead of doing so, this patch
kept them untouched, instead of adding a bunch of downtime specific
tracepoints, so one can enable "vmstate_downtime*" tracepoints and get a
full picture of how the downtime is distributed across iterative and
non-iterative vmstate save/load.

Note that here both save() and load() need to be traced, because both of
them may contribute to the downtime.  The contribution is not a simple "add
them together", though: consider when the src is doing a save() of device1
while the dest can be load()ing for device2, so they can happen
concurrently.

Tracking both sides make sense because device load() and save() can be
imbalanced, one device can save() super fast, but load() super slow, vice
versa.  We can't figure that out without tracing both.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c     | 49 ++++++++++++++++++++++++++++++++++++++----
 migration/trace-events |  2 ++
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 8622f229e5..cd6d6ba493 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1459,6 +1459,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
 static
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 {
+    int64_t start_ts_each, end_ts_each;
     SaveStateEntry *se;
     int ret;
 
@@ -1475,6 +1476,8 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
                 continue;
             }
         }
+
+        start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
         trace_savevm_section_start(se->idstr, se->section_id);
 
         save_section_header(f, se, QEMU_VM_SECTION_END);
@@ -1486,6 +1489,9 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
             qemu_file_set_error(f, ret);
             return -1;
         }
+        end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
+        trace_vmstate_downtime_save("iterable", se->idstr, se->instance_id,
+                                    end_ts_each - start_ts_each);
     }
 
     return 0;
@@ -1496,6 +1502,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
                                                     bool inactivate_disks)
 {
     MigrationState *ms = migrate_get_current();
+    int64_t start_ts_each, end_ts_each;
     JSONWriter *vmdesc = ms->vmdesc;
     int vmdesc_len;
     SaveStateEntry *se;
@@ -1507,11 +1514,17 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
             continue;
         }
 
+        start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
+
         ret = vmstate_save(f, se, vmdesc);
         if (ret) {
             qemu_file_set_error(f, ret);
             return ret;
         }
+
+        end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
+        trace_vmstate_downtime_save("non-iterable", se->idstr, se->instance_id,
+                                    end_ts_each - start_ts_each);
     }
 
     if (inactivate_disks) {
@@ -2506,9 +2519,12 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 }
 
 static int
-qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
+qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis,
+                               uint8_t type)
 {
+    bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
     uint32_t instance_id, version_id, section_id;
+    int64_t start_ts, end_ts;
     SaveStateEntry *se;
     char idstr[256];
     int ret;
@@ -2557,12 +2573,23 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
         return -EINVAL;
     }
 
+    if (trace_downtime) {
+        start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
+    }
+
     ret = vmstate_load(f, se);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%"PRIx32" of"
                      " device '%s'", instance_id, idstr);
         return ret;
     }
+
+    if (trace_downtime) {
+        end_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
+        trace_vmstate_downtime_load("non-iterable", se->idstr,
+                                    se->instance_id, end_ts - start_ts);
+    }
+
     if (!check_section_footer(f, se)) {
         return -EINVAL;
     }
@@ -2571,8 +2598,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
 }
 
 static int
-qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
+qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis,
+                             uint8_t type)
 {
+    bool trace_downtime = (type == QEMU_VM_SECTION_END);
+    int64_t start_ts, end_ts;
     uint32_t section_id;
     SaveStateEntry *se;
     int ret;
@@ -2597,12 +2627,23 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
         return -EINVAL;
     }
 
+    if (trace_downtime) {
+        start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
+    }
+
     ret = vmstate_load(f, se);
     if (ret < 0) {
         error_report("error while loading state section id %d(%s)",
                      section_id, se->idstr);
         return ret;
     }
+
+    if (trace_downtime) {
+        end_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
+        trace_vmstate_downtime_load("iterable", se->idstr,
+                                    se->instance_id, end_ts - start_ts);
+    }
+
     if (!check_section_footer(f, se)) {
         return -EINVAL;
     }
@@ -2791,14 +2832,14 @@ retry:
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
-            ret = qemu_loadvm_section_start_full(f, mis);
+            ret = qemu_loadvm_section_start_full(f, mis, section_type);
             if (ret < 0) {
                 goto out;
             }
             break;
         case QEMU_VM_SECTION_PART:
         case QEMU_VM_SECTION_END:
-            ret = qemu_loadvm_section_part_end(f, mis);
+            ret = qemu_loadvm_section_part_end(f, mis, section_type);
             if (ret < 0) {
                 goto out;
             }
diff --git a/migration/trace-events b/migration/trace-events
index fa9486dffe..5820add1f3 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -48,6 +48,8 @@ savevm_state_cleanup(void) ""
 savevm_state_complete_precopy(void) ""
 vmstate_save(const char *idstr, const char *vmsd_name) "%s, %s"
 vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
+vmstate_downtime_save(const char *type, const char *idstr, uint32_t instance_id, int64_t downtime) "type=%s idstr=%s instance_id=%d downtime=%"PRIi64
+vmstate_downtime_load(const char *type, const char *idstr, uint32_t instance_id, int64_t downtime) "type=%s idstr=%s instance_id=%d downtime=%"PRIi64
 postcopy_pause_incoming(void) ""
 postcopy_pause_incoming_continued(void) ""
 postcopy_page_req_sync(void *host_addr) "sync page req %p"
-- 
2.41.0



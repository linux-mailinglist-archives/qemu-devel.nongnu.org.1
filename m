Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E117D8650
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:54:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2gJ-0005rs-6A; Thu, 26 Oct 2023 11:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw2gI-0005rk-4S
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw2gG-0000sb-F8
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698335635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n72f+wW5+nHH0hrvaXv+6sujX9qgSyymTozlBQoTr/0=;
 b=JgKaiXEJ3vMb6Dejc3xieBSkzXKzCLw2pwQAR30+/+K/GqaWUe1Nw+EDUQjREwuUl6Qd5L
 WdaubxBULxHP0tUgXTfZSCHcsmfHJ38/kZvGer2LVfju/4K8sq2InV8ZKA+z2NEG0hEp1y
 ULG2VIwy0hGaVcF78PlGnCwuUM/78B8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-PSz1so38P0uq4mJSPFL5qg-1; Thu, 26 Oct 2023 11:53:54 -0400
X-MC-Unique: PSz1so38P0uq4mJSPFL5qg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4197468d5caso2536481cf.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698335634; x=1698940434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n72f+wW5+nHH0hrvaXv+6sujX9qgSyymTozlBQoTr/0=;
 b=wPJJfEwF47pMwGO35uCHz253NyuM/zlOYUWzkoQadzGeOLBKY1OWiGjvXWKwmfbSTu
 BRLaljk46LFPYPwhS089AaBm2OkMRwxnNhv7ycuoymrKczlOl8hZquYmgbQ19D7i/1FN
 jxUc+6g9AvBFamhMU0bV/XTUNHf3D/2qWkxUok7KyfkZxC1xbFovYEcENtYTHn8DcKNY
 JGTMiSIenCJUjdfSDwexxAjJv8aGtJB5I7Q1Wqde5ZGO4eyHXMKDmYzQ5N6W/LUyS4v9
 vU6qcKtTti7XWuIk6lB1QJmba/CRDPe1oXbF2e3WS0bkv2W90tkxv9R/ppQn2Fw0lA67
 M2Xg==
X-Gm-Message-State: AOJu0YynjmthDhCSs7IvibztnBCM8GZsKeI9Tz9iMbqtr0kxRwNerNc/
 IiPWTRoSQppd1CDK3cEI8xLiLFkdR5zzRMvmnH4sl/30tzgVXVSR78SJkTnYX7dt57r52oI5h4C
 JbF9xIZSO86m36e7iLcahk+4OnGYW0zy4M8utAJbYDj9hRo9N/hGmPrlGcz0kJAEgCJLTeSV3
X-Received: by 2002:a05:622a:11d3:b0:415:141e:fa21 with SMTP id
 n19-20020a05622a11d300b00415141efa21mr21450096qtk.6.1698335633695; 
 Thu, 26 Oct 2023 08:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG4w1H5dYiK3bjo9M4QIfSul37sf4LHAdQESwwpu5IvliqOCwf8h+HtG5uHYQKRehavhlyqg==
X-Received: by 2002:a05:622a:11d3:b0:415:141e:fa21 with SMTP id
 n19-20020a05622a11d300b00415141efa21mr21450070qtk.6.1698335633211; 
 Thu, 26 Oct 2023 08:53:53 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 f15-20020ac840cf000000b004181f542bcbsm5066580qtm.11.2023.10.26.08.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:53:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 3/3] migration: Add per vmstate downtime tracepoints
Date: Thu, 26 Oct 2023 11:53:37 -0400
Message-ID: <20231026155337.596281-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026155337.596281-1-peterx@redhat.com>
References: <20231026155337.596281-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



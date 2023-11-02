Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 919D87DF185
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:44:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyW7M-00088U-Lf; Thu, 02 Nov 2023 07:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW6n-0005IP-P1
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW6c-0005rx-E7
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wlltny6SsZfybCdSb+V6HIflnOr0x+IHQz2evKolZpE=;
 b=Df+MXyCQ+5KHEENE/YkDscmNjR3rVFAvdI0Yn7UxWqXpJ3H5QWTbAfb9RVkSHOey7cMRnB
 brr8ffNuWY0yDpCGxd68sKqsQuKod8gFtcQb7eajbO/bszKLvsAU4gmjlC+dudqG3bXZF1
 Mun098WqAlgtyZVN0KeuiPQa6o3Y+Oc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-6wX--IUaOcS-1KThQNJqaQ-1; Thu,
 02 Nov 2023 07:43:15 -0400
X-MC-Unique: 6wX--IUaOcS-1KThQNJqaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DD131C01E90;
 Thu,  2 Nov 2023 11:43:13 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D4C82026D4C;
 Thu,  2 Nov 2023 11:43:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Corey Minyard <minyard@acm.org>,
 John Snow <jsnow@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Juan Quintela <quintela@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 17/40] migration: Add per vmstate downtime tracepoints
Date: Thu,  2 Nov 2023 12:40:31 +0100
Message-ID: <20231102114054.44360-18-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-1-quintela@redhat.com>
References: <20231102114054.44360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

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
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231030163346.765724-4-peterx@redhat.com>
---
 migration/savevm.c     | 49 ++++++++++++++++++++++++++++++++++++++----
 migration/trace-events |  2 ++
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 2095ddd6f8..99ce42b6f3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1491,6 +1491,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
 static
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 {
+    int64_t start_ts_each, end_ts_each;
     SaveStateEntry *se;
     int ret;
 
@@ -1507,6 +1508,8 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
                 continue;
             }
         }
+
+        start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
         trace_savevm_section_start(se->idstr, se->section_id);
 
         save_section_header(f, se, QEMU_VM_SECTION_END);
@@ -1518,6 +1521,9 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
             qemu_file_set_error(f, ret);
             return -1;
         }
+        end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
+        trace_vmstate_downtime_save("iterable", se->idstr, se->instance_id,
+                                    end_ts_each - start_ts_each);
     }
 
     return 0;
@@ -1528,6 +1534,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
                                                     bool inactivate_disks)
 {
     MigrationState *ms = migrate_get_current();
+    int64_t start_ts_each, end_ts_each;
     JSONWriter *vmdesc = ms->vmdesc;
     int vmdesc_len;
     SaveStateEntry *se;
@@ -1539,11 +1546,17 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
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
@@ -2537,9 +2550,12 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
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
@@ -2588,12 +2604,23 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
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
@@ -2602,8 +2629,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
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
@@ -2628,12 +2658,23 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
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
@@ -2822,14 +2863,14 @@ retry:
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



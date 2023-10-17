Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BDD7CCE02
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:28:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqeV-0000t1-TG; Tue, 17 Oct 2023 16:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqeS-0000i9-RO
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqeL-0000lc-3D
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697574403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rp5YQ9xMfI27gHt4gsSUZxlCP9AGS7NHKrCi4hwJoAM=;
 b=bu6S3QVzk7t3IpoAwVypMZG66LmeBM96+4IBW/i2YWd9O1uljguPIKY4vVmsgHvBuUfdSm
 W+C67DciZBRF4/3scomHGwc6cfLyJOcXWjdy+Nn+HTOy4wlkDLFcgB+YxQ6nV/LhJPFBX2
 VMOnZHrIGxk/P+Y6a2IMTuCumkm14Rg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-_jigtFY3OhC74L-Gucg1Uw-1; Tue, 17 Oct 2023 16:26:42 -0400
X-MC-Unique: _jigtFY3OhC74L-Gucg1Uw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66011f0d521so8490546d6.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 13:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697574401; x=1698179201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rp5YQ9xMfI27gHt4gsSUZxlCP9AGS7NHKrCi4hwJoAM=;
 b=tlQveCjhg7j+7QeOY1UNAR+KW6Z41pOYa379Mtq3MqMPIvJZwe0+p+smjDaQfLu6Ql
 2RozEsslu23eD/ufISBEDvvRQiPpPfiT2yPVsgigaHfgvvAgc2Gj0yKCVs6wH0o+fUSV
 edHk/5vWhgwV4kpqsD6ambOakQFXyKGyszzqV4JlLrolzF8DjSKLMS/BcHQj+4912wuM
 P+/zbyhAuVZKE0U5yAznGSH8enYy7fhUD03HsIRWGefdI0YTHMgaJJu79kMugUweGZFl
 +jnYXEXzEDhQYkyFDCsBJFedv885vCn8hJLeiAkrHtjPBAeaZQORH9gdYSRM9X/lA4YE
 Pfaw==
X-Gm-Message-State: AOJu0YwQWvlrJkn3UCuhNSixwbtoue5Dnd+kGlz73hVdwQMcQd9yDhCL
 Pkl/YAIi+2IPSzPF9QJDzwhaAcmlRy1eV/vuUwKLSBODFNRMaoIhEnOfP2UruWF+21TXFbNyRSR
 VUbcMb6Wdl1m7DORNOwNIfHEVOjvPS/QS4e8QmmfOHssgIykwaJ4i8RW0HnK4W7ahH/7mR0Q5
X-Received: by 2002:a05:620a:6c0d:b0:778:8ae9:2247 with SMTP id
 ui13-20020a05620a6c0d00b007788ae92247mr2161246qkn.5.1697574400790; 
 Tue, 17 Oct 2023 13:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH75v9ptweOv0T1qw86ziZSF/tdYOfONUeQ7eOv6BmR7cVpN3kLPc0iMNBWfGG2l1UBI5Cy9Q==
X-Received: by 2002:a05:620a:6c0d:b0:778:8ae9:2247 with SMTP id
 ui13-20020a05620a6c0d00b007788ae92247mr2161231qkn.5.1697574400457; 
 Tue, 17 Oct 2023 13:26:40 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 s17-20020ae9f711000000b0076f16e98851sm931879qkg.102.2023.10.17.13.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 13:26:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v4 5/5] migration: Change ram_save_queue_pages() retval to bool
Date: Tue, 17 Oct 2023 16:26:33 -0400
Message-ID: <20231017202633.296756-6-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017202633.296756-1-peterx@redhat.com>
References: <20231017202633.296756-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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

After we have errp which contains the more detailed error message, make
ram_save_queue_pages() returns bool in its stack.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.h       |  4 ++--
 migration/migration.c | 16 ++++++++--------
 migration/ram.c       | 18 +++++++++---------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/migration/ram.h b/migration/ram.h
index af0290f8ab..e22a6b0d1c 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -51,8 +51,8 @@ uint64_t ram_bytes_total(void);
 void mig_throttle_counter_reset(void);
 
 uint64_t ram_pagesize_summary(void);
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
-                         Error **errp);
+bool ram_save_queue_pages(const char *rbname, ram_addr_t start,
+                          ram_addr_t len, Error **errp);
 void ram_postcopy_migrated_memory_release(MigrationState *ms);
 /* For outgoing discard bitmap */
 void ram_postcopy_send_discard_bitmap(MigrationState *ms);
diff --git a/migration/migration.c b/migration/migration.c
index dfb8b48dcb..50bf8422c7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1820,8 +1820,10 @@ static struct rp_cmd_args {
  * Process a request for pages received on the return path,
  * We're allowed to send more than requested (e.g. to round to our page size)
  * and we don't need to send pages that have already been sent.
+ *
+ * Returns true if succeed, false otherwise.
  */
-static void
+static bool
 migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
                             ram_addr_t start, size_t len, Error **errp)
 {
@@ -1837,10 +1839,10 @@ migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
         !QEMU_IS_ALIGNED(len, our_host_ps)) {
         error_setg(errp, "MIG_RP_MSG_REQ_PAGES: Misaligned page request, start:"
                    RAM_ADDR_FMT " len: %zd", start, len);
-        return;
+        return false;
     }
 
-    ram_save_queue_pages(rbname, start, len, errp);
+    return ram_save_queue_pages(rbname, start, len, errp);
 }
 
 static bool migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name,
@@ -1990,8 +1992,7 @@ static void *source_return_path_thread(void *opaque)
         case MIG_RP_MSG_REQ_PAGES:
             start = ldq_be_p(buf);
             len = ldl_be_p(buf + 8);
-            migrate_handle_rp_req_pages(ms, NULL, start, len, &err);
-            if (err) {
+            if (!migrate_handle_rp_req_pages(ms, NULL, start, len, &err)) {
                 goto out;
             }
             break;
@@ -2012,9 +2013,8 @@ static void *source_return_path_thread(void *opaque)
                            header_len, expected_len);
                 goto out;
             }
-            migrate_handle_rp_req_pages(ms, (char *)&buf[13], start, len,
-                                        &err);
-            if (err) {
+            if (!migrate_handle_rp_req_pages(ms, (char *)&buf[13], start, len,
+                                             &err)) {
                 goto out;
             }
             break;
diff --git a/migration/ram.c b/migration/ram.c
index ca77444e18..aca9ae5846 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1948,15 +1948,15 @@ static void migration_page_queue_free(RAMState *rs)
  *
  * A request from postcopy destination for example.
  *
- * Returns zero on success or negative on error
+ * Returns true on success or false on error (detailed error put in @errp)
  *
  * @rbname: Name of the RAMBLock of the request. NULL means the
  *          same that last one.
  * @start: starting address from the start of the RAMBlock
  * @len: length (in bytes) to send
  */
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
-                         Error **errp)
+bool ram_save_queue_pages(const char *rbname, ram_addr_t start,
+                          ram_addr_t len, Error **errp)
 {
     RAMBlock *ramblock;
     RAMState *rs = ram_state;
@@ -1974,7 +1974,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
              * it's the 1st request.
              */
             error_setg(errp, "MIG_RP_MSG_REQ_PAGES has no previous block");
-            return -1;
+            return false;
         }
     } else {
         ramblock = qemu_ram_block_by_name(rbname);
@@ -1982,7 +1982,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
         if (!ramblock) {
             /* We shouldn't be asked for a non-existent RAMBlock */
             error_setg(errp, "MIG_RP_MSG_REQ_PAGES has no block '%s'", rbname);
-            return -1;
+            return false;
         }
         rs->last_req_rb = ramblock;
     }
@@ -1992,7 +1992,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
                    "start=" RAM_ADDR_FMT " len="
                    RAM_ADDR_FMT " blocklen=" RAM_ADDR_FMT,
                    start, len, ramblock->used_length);
-        return -1;
+        return false;
     }
 
     /*
@@ -2003,7 +2003,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
         ram_addr_t page_start = start >> TARGET_PAGE_BITS;
         size_t page_size = qemu_ram_pagesize(ramblock);
         PageSearchStatus *pss = &ram_state->pss[RAM_CHANNEL_POSTCOPY];
-        int ret = 0;
+        bool ret = true;
 
         qemu_mutex_lock(&rs->bitmap_mutex);
 
@@ -2026,7 +2026,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
                 error_setg(errp, "ram_save_host_page_urgent() failed: "
                            "ramblock=%s, start_addr=0x"RAM_ADDR_FMT,
                            ramblock->idstr, start);
-                ret = -1;
+                ret = false;
                 break;
             }
             /*
@@ -2057,7 +2057,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
     migration_make_urgent_request();
     qemu_mutex_unlock(&rs->src_page_req_mutex);
 
-    return 0;
+    return true;
 }
 
 static bool save_page_use_compression(RAMState *rs)
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C407BA49A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQrq-00016T-DJ; Thu, 05 Oct 2023 12:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoQrP-0000sI-8p
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoQrN-00013E-4F
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696521955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ffx9fbijpkXF1Cf2hr1pnr6PDP3Gv4iCtodh4DnzIpg=;
 b=HOx+9+PTm2wI8oA00aJ/FoWoMyHM8tWAlTykCD99q4oQSqupcjySP0A0ta3a4stLmPzTgc
 ARxFP7pkJNqL3eHpqqEXOQhuAIl6KGUBOxk3zs+DMsfPVbrAd+w8CMumun6dtvOFJOVcA1
 vejMguRbFs45fAppqN+SDvPWcTalOJQ=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-3uqM2-P-M3mGqQxslUlsFg-1; Thu, 05 Oct 2023 12:05:53 -0400
X-MC-Unique: 3uqM2-P-M3mGqQxslUlsFg-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3ae35e37ff8so313975b6e.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696521952; x=1697126752;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ffx9fbijpkXF1Cf2hr1pnr6PDP3Gv4iCtodh4DnzIpg=;
 b=NgBGJ1ujQmZeed+9t2aaN/cJVW8MBw4Hu7uv7hnhKlA2b2/dsN1A5knd2lq7xpj2xj
 JuTfIKCN05sUMK9mz+/FMDFpc9m56gi0cpzDFOf2xKXljAJOsIke8JcqM8tExvM9BGrG
 SKBvuaYQ2/VsQQ8tXXWDfO27kF964k3ojZOfXvne8cs+crzIaFIaIA2xky/bLHeFt/Lj
 ORV/tZ/f92/141VQx7jbt4Vez39mDpUjuDpKATFGFjvJiX+1SBU+Z5YMZoXJ3A6mov1q
 m0RPqmMRp8GvCPV4C5bBbFyrD3F04NImbgcfJrJxTEu5xmOX0RyDIw3PDcpSycTTIykf
 q1aw==
X-Gm-Message-State: AOJu0YwQ8RqFKCvRVe4K0F09bp72WfbRWoOrc1ceQfquByjsb4k2ae+8
 wukp8c1Jv5QU4dOa/iFQH56HXwIItH5fWtbIHVTpWQveDnEsFp0uKV4EbptqOTG56Apnejdhzv+
 q3GwitZFwIUtsiiU=
X-Received: by 2002:a05:6808:15a8:b0:3ad:f3c0:5da3 with SMTP id
 t40-20020a05680815a800b003adf3c05da3mr6451714oiw.3.1696521952639; 
 Thu, 05 Oct 2023 09:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd0m8RlJ4h4GYMvsoOGw3fRCnhBp/MCDKymXSAAXfaAc5sQoOQkKeWzeYa0UqlRsLrsp5Bsw==
X-Received: by 2002:a05:6808:15a8:b0:3ad:f3c0:5da3 with SMTP id
 t40-20020a05680815a800b003adf3c05da3mr6451693oiw.3.1696521952332; 
 Thu, 05 Oct 2023 09:05:52 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d9-20020a0cf0c9000000b00646e0411e8csm597736qvl.30.2023.10.05.09.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 09:05:52 -0700 (PDT)
Date: Thu, 5 Oct 2023 12:05:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 03/10] migration: Refactor error handling in source
 return path
Message-ID: <ZR7e3cmxCH9LAdnS@x1n>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-4-peterx@redhat.com>
 <f60f3687-d778-3d8e-41f6-39fbcad8f0f8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f60f3687-d778-3d8e-41f6-39fbcad8f0f8@linaro.org>
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

On Thu, Oct 05, 2023 at 08:11:33AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Peter,
> 
> On 5/10/23 00:02, Peter Xu wrote:
> > rp_state.error was a boolean used to show error happened in return path
> > thread.  That's not only duplicating error reporting (migrate_set_error),
> > but also not good enough in that we only do error_report() and set it to
> > true, we never can keep a history of the exact error and show it in
> > query-migrate.
> > 
> > To make this better, a few things done:
> > 
> >    - Use error_setg() rather than error_report() across the whole lifecycle
> >      of return path thread, keeping the error in an Error*.
> > 
> >    - Use migrate_set_error() to apply that captured error to the global
> >      migration object when error occured in this thread.
> > 
> >    - With above, no need to have mark_source_rp_bad(), remove it, alongside
> >      with rp_state.error itself.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   migration/migration.h  |   1 -
> >   migration/ram.h        |   5 +-
> >   migration/migration.c  | 123 ++++++++++++++++++-----------------------
> >   migration/ram.c        |  41 +++++++-------
> >   migration/trace-events |   4 +-
> >   5 files changed, 79 insertions(+), 95 deletions(-)
> 
> 
> > -int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
> > +int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
> >   {
> >       int ret = -EINVAL;
> >       /* from_dst_file is always valid because we're within rp_thread */
> 
> 
> > @@ -4193,16 +4194,16 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
> >       ret = qemu_file_get_error(file);
> >       if (ret || size != local_size) {
> > -        error_report("%s: read bitmap failed for ramblock '%s': %d"
> > -                     " (size 0x%"PRIx64", got: 0x%"PRIx64")",
> > -                     __func__, block->idstr, ret, local_size, size);
> > +        error_setg(errp, "read bitmap failed for ramblock '%s': %d"
> > +                   " (size 0x%"PRIx64", got: 0x%"PRIx64")",
> > +                   block->idstr, ret, local_size, size);
> >           ret = -EIO;
> >           goto out;
> >       }
> >       if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
> > -        error_report("%s: ramblock '%s' end mark incorrect: 0x%"PRIx64,
> > -                     __func__, block->idstr, end_mark);
> > +        error_setg(errp, "ramblock '%s' end mark incorrect: 0x%"PRIx64,
> > +                   block->idstr, end_mark);
> >           ret = -EINVAL;
> >           goto out;
> >       }
> 
> This function returns -EIO/-EINVAL errors, propagated to its 2 callers
>  - migrate_handle_rp_recv_bitmap()
>  - migrate_handle_rp_resume_ack()

It was only called in migrate_handle_rp_recv_bitmap(), but I think I see
what you meant..

> which are only used in source_return_path_thread() where the return
> value is only checked as boolean.
> 
> Could we simplify them returning a boolean (which is the pattern with
> functions taking an Error** as last parameter)?

Yes, with errp passed in, the "int" retcode is slightly duplicated.  I can
add one more patch on top of this as further cleanup, as below.

Thanks,

===8<===
From b1052befd72beb129012afddf5647339fe4e257c Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 5 Oct 2023 12:03:44 -0400
Subject: [PATCH] migration: Change ram_dirty_bitmap_reload() retval to bool
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now we have a Error** passed into the return path thread stack, which is
even clearer than an int retval.  Change ram_dirty_bitmap_reload() and the
callers to use a bool instead to replace errnos.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.h       |  2 +-
 migration/migration.c | 18 +++++++++---------
 migration/ram.c       | 24 +++++++++++-------------
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/migration/ram.h b/migration/ram.h
index 14ed666d58..af0290f8ab 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -72,7 +72,7 @@ void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
 int64_t ramblock_recv_bitmap_send(QEMUFile *file,
                                   const char *block_name);
-int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
+bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
 bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start);
 void postcopy_preempt_shutdown_file(MigrationState *s);
 void *postcopy_preempt_thread(void *opaque);
diff --git a/migration/migration.c b/migration/migration.c
index 1a7f214fcf..e7375810be 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1837,29 +1837,29 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
     ram_save_queue_pages(rbname, start, len, errp);
 }
 
-static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name,
-                                         Error **errp)
+static bool migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name,
+                                          Error **errp)
 {
     RAMBlock *block = qemu_ram_block_by_name(block_name);
 
     if (!block) {
         error_setg(errp, "MIG_RP_MSG_RECV_BITMAP has invalid block name '%s'",
                    block_name);
-        return -EINVAL;
+        return false;
     }
 
     /* Fetch the received bitmap and refresh the dirty bitmap */
     return ram_dirty_bitmap_reload(s, block, errp);
 }
 
-static int migrate_handle_rp_resume_ack(MigrationState *s,
-                                        uint32_t value, Error **errp)
+static bool migrate_handle_rp_resume_ack(MigrationState *s,
+                                         uint32_t value, Error **errp)
 {
     trace_source_return_path_thread_resume_ack(value);
 
     if (value != MIGRATION_RESUME_ACK_VALUE) {
         error_setg(errp, "illegal resume_ack value %"PRIu32, value);
-        return -1;
+        return false;
     }
 
     /* Now both sides are active. */
@@ -1869,7 +1869,7 @@ static int migrate_handle_rp_resume_ack(MigrationState *s,
     /* Notify send thread that time to continue send pages */
     migration_rp_kick(s);
 
-    return 0;
+    return true;
 }
 
 /*
@@ -2021,14 +2021,14 @@ static void *source_return_path_thread(void *opaque)
             }
             /* Format: len (1B) + idstr (<255B). This ends the idstr. */
             buf[buf[0] + 1] = '\0';
-            if (migrate_handle_rp_recv_bitmap(ms, (char *)(buf + 1), &err)) {
+            if (!migrate_handle_rp_recv_bitmap(ms, (char *)(buf + 1), &err)) {
                 goto out;
             }
             break;
 
         case MIG_RP_MSG_RESUME_ACK:
             tmp32 = ldl_be_p(buf);
-            if (migrate_handle_rp_resume_ack(ms, tmp32, &err)) {
+            if (!migrate_handle_rp_resume_ack(ms, tmp32, &err)) {
                 goto out;
             }
             break;
diff --git a/migration/ram.c b/migration/ram.c
index 2565f53f5c..982fbbeee1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4157,23 +4157,25 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
  * Read the received bitmap, revert it as the initial dirty bitmap.
  * This is only used when the postcopy migration is paused but wants
  * to resume from a middle point.
+ *
+ * Returns true if succeeded, false for errors.
  */
-int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
+bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
 {
-    int ret = -EINVAL;
     /* from_dst_file is always valid because we're within rp_thread */
     QEMUFile *file = s->rp_state.from_dst_file;
     unsigned long *le_bitmap, nbits = block->used_length >> TARGET_PAGE_BITS;
     uint64_t local_size = DIV_ROUND_UP(nbits, 8);
     uint64_t size, end_mark;
     RAMState *rs = ram_state;
+    bool result = false;
 
     trace_ram_dirty_bitmap_reload_begin(block->idstr);
 
     if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
         error_setg(errp, "Reload bitmap in incorrect state %s",
                    MigrationStatus_str(s->state));
-        return -EINVAL;
+        return false;
     }
 
     /*
@@ -4191,26 +4193,22 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
     if (size != local_size) {
         error_setg(errp, "ramblock '%s' bitmap size mismatch (0x%"PRIx64
                    " != 0x%"PRIx64")", block->idstr, size, local_size);
-        ret = -EINVAL;
         goto out;
     }
 
     size = qemu_get_buffer(file, (uint8_t *)le_bitmap, local_size);
     end_mark = qemu_get_be64(file);
 
-    ret = qemu_file_get_error(file);
-    if (ret || size != local_size) {
-        error_setg(errp, "read bitmap failed for ramblock '%s': %d"
-                   " (size 0x%"PRIx64", got: 0x%"PRIx64")",
-                   block->idstr, ret, local_size, size);
-        ret = -EIO;
+    if (qemu_file_get_error(file) || size != local_size) {
+        error_setg(errp, "read bitmap failed for ramblock '%s': "
+                   "(size 0x%"PRIx64", got: 0x%"PRIx64")",
+                   block->idstr, local_size, size);
         goto out;
     }
 
     if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
         error_setg(errp, "ramblock '%s' end mark incorrect: 0x%"PRIx64,
                    block->idstr, end_mark);
-        ret = -EINVAL;
         goto out;
     }
 
@@ -4243,10 +4241,10 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
      */
     migration_rp_kick(s);
 
-    ret = 0;
+    result = true;
 out:
     g_free(le_bitmap);
-    return ret;
+    return result;
 }
 
 static int ram_resume_prepare(MigrationState *s, void *opaque)
-- 
2.41.0


-- 
Peter Xu



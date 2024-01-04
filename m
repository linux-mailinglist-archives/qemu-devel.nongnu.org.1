Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F678239E0
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:50:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs3-0008Iq-9o; Wed, 03 Jan 2024 19:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrj-0008Gi-7P
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:43 -0500
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrg-0007Pc-4b
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:42 -0500
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7817070291eso2135185a.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329138; x=1704933938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMy4NMIhXcnDdY8+K24R1SqpFWCiVNdmSfW4XipbhMw=;
 b=QvMG96gihDTgQ3LJZtQxas23EzmM/lPfTIhFwUCr0TGwyJfspJnWlDRCMG9dBIjXMs
 Xq9bg95NHVDNeVPJlAAfUBbwcuuS4KLMd4xzfNRYJGnSbZhWQZntNd25MyqjlnDeR0UK
 LQlUJmjh5KuZ3aXusVtwHjhJk7e65Baw1TQPxVSTaRXZfwlj+Nfgx5u6CLmUuYkVUVHf
 MVd0CQXarPALXTBntC3KW4vkhsomUIAKHpA3ChxbBp9Gmimbw2LuH4oLN45wYBeoqACH
 mzRmzFY4dZcB4o6usD1AekljTySFs7J/6Xalk+B6nlwoRA1WnXVesLJKcLFylcEUbWqA
 B2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329138; x=1704933938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMy4NMIhXcnDdY8+K24R1SqpFWCiVNdmSfW4XipbhMw=;
 b=t55rdYI0QHSWXopTN804RDwPptwSgbiZ9cHZ77PYBGtPifM5BL+wWrDtwgB5w7pI0A
 7fjVw0UpjOjWTjI9cPP3NQWY/9nsKmn35muuXxVaRofChoMP6Vs9tasj8GEVKIB+I99+
 GLhB6D3uw5wMt6WTQg9VHb8RmCXe7A2Zyo09NDDVCGmEyeh3SVketh4xF/PJq3ve+Jx1
 tk6pw85RwlSWWEhRJeWZ5hMC2EKkw+F2sOzP6iIfdRjnD5EM2ImttQ8ly0S+vDRX58Sn
 FWg39Kvxd925nW9H/KqUKLweixyxw7kKZViQSGr7o2pZo8PHsD58xv0fbQN63TcPN4sM
 JqCw==
X-Gm-Message-State: AOJu0YyK3Be5w6q/7/KHV+TyYcqgq32DvjUDgagPZfFIEKUlN5tGjSze
 3eBdwQOjz500JJwFeO+EbxOmts+1+Ql0Vw==
X-Google-Smtp-Source: AGHT+IFdVfoEgKaD6ZJa7oxgcAsOlaCp8tHjyvi2MDRwV/wyg8PEiMN2W/0zXvZZ2/9fbQO4+5fV+A==
X-Received: by 2002:a05:620a:1103:b0:781:7073:2047 with SMTP id
 o3-20020a05620a110300b0078170732047mr12631057qkk.72.1704329138426; 
 Wed, 03 Jan 2024 16:45:38 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:37 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>
Subject: [PATCH v3 03/20] multifd: Zero pages transmission
Date: Thu,  4 Jan 2024 00:44:35 +0000
Message-Id: <20240104004452.324068-4-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x736.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Juan Quintela <quintela@redhat.com>

This implements the zero page dection and handling.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/multifd.c | 41 +++++++++++++++++++++++++++++++++++++++--
 migration/multifd.h |  5 +++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 5a1f50c7e8..756673029d 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/rcu.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
@@ -279,6 +280,12 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
 
         packet->offset[i] = cpu_to_be64(temp);
     }
+    for (i = 0; i < p->zero_num; i++) {
+        /* there are architectures where ram_addr_t is 32 bit */
+        uint64_t temp = p->zero[i];
+
+        packet->offset[p->normal_num + i] = cpu_to_be64(temp);
+    }
 }
 
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
@@ -361,6 +368,18 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
         p->normal[i] = offset;
     }
 
+    for (i = 0; i < p->zero_num; i++) {
+        uint64_t offset = be64_to_cpu(packet->offset[p->normal_num + i]);
+
+        if (offset > (p->block->used_length - p->page_size)) {
+            error_setg(errp, "multifd: offset too long %" PRIu64
+                       " (max " RAM_ADDR_FMT ")",
+                       offset, p->block->used_length);
+            return -1;
+        }
+        p->zero[i] = offset;
+    }
+
     return 0;
 }
 
@@ -664,6 +683,8 @@ static void *multifd_send_thread(void *opaque)
     MultiFDSendParams *p = opaque;
     MigrationThread *thread = NULL;
     Error *local_err = NULL;
+    /* qemu older than 8.2 don't understand zero page on multifd channel */
+    bool use_zero_page = !migrate_use_main_zero_page();
     int ret = 0;
     bool use_zero_copy_send = migrate_zero_copy_send();
 
@@ -689,6 +710,7 @@ static void *multifd_send_thread(void *opaque)
         qemu_mutex_lock(&p->mutex);
 
         if (p->pending_job) {
+            RAMBlock *rb = p->pages->block;
             uint64_t packet_num = p->packet_num;
             uint32_t flags;
             p->normal_num = 0;
@@ -701,8 +723,16 @@ static void *multifd_send_thread(void *opaque)
             }
 
             for (int i = 0; i < p->pages->num; i++) {
-                p->normal[p->normal_num] = p->pages->offset[i];
-                p->normal_num++;
+                uint64_t offset = p->pages->offset[i];
+                if (use_zero_page &&
+                    buffer_is_zero(rb->host + offset, p->page_size)) {
+                    p->zero[p->zero_num] = offset;
+                    p->zero_num++;
+                    ram_release_page(rb->idstr, offset);
+                } else {
+                    p->normal[p->normal_num] = offset;
+                    p->normal_num++;
+                }
             }
 
             if (p->normal_num) {
@@ -1155,6 +1185,13 @@ static void *multifd_recv_thread(void *opaque)
             }
         }
 
+        for (int i = 0; i < p->zero_num; i++) {
+            void *page = p->host + p->zero[i];
+            if (!buffer_is_zero(page, p->page_size)) {
+                memset(page, 0, p->page_size);
+            }
+        }
+
         if (flags & MULTIFD_FLAG_SYNC) {
             qemu_sem_post(&multifd_recv_state->sem_sync);
             qemu_sem_wait(&p->sem_sync);
diff --git a/migration/multifd.h b/migration/multifd.h
index d587b0e19c..13762900d4 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -53,6 +53,11 @@ typedef struct {
     uint32_t unused32[1];    /* Reserved for future use */
     uint64_t unused64[3];    /* Reserved for future use */
     char ramblock[256];
+    /*
+     * This array contains the pointers to:
+     *  - normal pages (initial normal_pages entries)
+     *  - zero pages (following zero_pages entries)
+     */
     uint64_t offset[];
 } __attribute__((packed)) MultiFDPacket_t;
 
-- 
2.30.2



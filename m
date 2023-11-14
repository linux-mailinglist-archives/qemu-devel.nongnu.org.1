Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C45517EAA2A
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:42:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBB-0007Ax-Ka; Tue, 14 Nov 2023 00:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mB9-0007AG-0h
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:39 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mB7-0001Re-Cp
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:41:38 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7781bc3783fso347000685a.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940496; x=1700545296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m7yOYF2wvI8zWlizu/0wvN4KIBvmGhSdtNfjdan8Svs=;
 b=h481S6gicIS7lvBG19h6kmCCNVOl2R3ou9gCUtP3t3vDY4OAr5BXuP6hc7Jy4oKIrI
 pw8kh9jxAE6DzAVEY662q9UcrQRQpvpFZr/B/gKLEzHIejyIA/X3zMs7LODBYlFe/tvt
 Wrhxjac/UuA0EIR8eW6gQaCo3oxVdToYtAfNuOkRUNIupTIT3HPZ/FNGqWv/ck3Z7m/Q
 uB0GCJmhYfNA/PWVWckusi3SkrXpIO79d4GFIfIHMS866bYvnPP9EtGkdCggUBqiCV+Y
 XGw2ZyXJL8YCkOOCxx1QM+/oOtePBDngdhPRHiC+2RgK+UYjztMj0h+QchDTBOzLI9uI
 KyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940496; x=1700545296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7yOYF2wvI8zWlizu/0wvN4KIBvmGhSdtNfjdan8Svs=;
 b=BHQiz9bSEh0qz1wfyx3C+ylqnyaug4dqhfrPLadLF5+Pnku9T29HYYXw9XESNSixfN
 69sXML+joxA5i4jaGyoMeg5U3LW/0Wdk6h26LaHx0V8Titn+hwf5KUhc+qT1C3Q8Bc9k
 Hl0hlgIR5uloZIV/Nd5yETdXakhfw6RC+jCg6C9pUSswia4Lu8jRsB46hD5WOwoCjaj1
 u1UR+II/tZ+f1hyx9jioZRV3H6aOWiUz9AkEMFOggLTgBSLTahcpHIjpO01+laI4tAIm
 BNodn92IDs5Eguubw0qbpFSOPBpsVpNn8IprhL4IaxoCHW8P3SKf1ozyAU03pjuPlp2u
 KBNg==
X-Gm-Message-State: AOJu0Yww80oMSNOZb8ukVY1H5KHTPDTxb9NwNF7pBJ6zRRqFrVQ5YTmK
 BmyRuyQSqD7/877N7aXJG6a1Ug==
X-Google-Smtp-Source: AGHT+IFoWUVfRtXAcPY2um3Za+B4d76wIjlGb5VeES5aWZsXkzcSdP0lY89WFdppRJums7U1Oo+6+Q==
X-Received: by 2002:a05:620a:44cb:b0:77a:6dcd:3fce with SMTP id
 y11-20020a05620a44cb00b0077a6dcd3fcemr1785792qkp.11.1699940495853; 
 Mon, 13 Nov 2023 21:41:35 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:41:35 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Subject: [PATCH v2 03/20] multifd: Zero pages transmission
Date: Tue, 14 Nov 2023 05:40:15 +0000
Message-Id: <20231114054032.1192027-4-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72f.google.com
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
index d28ef0028b..1b994790d5 100644
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
@@ -1156,6 +1186,13 @@ static void *multifd_recv_thread(void *opaque)
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6607D7493
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:42:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjjI-0000tw-Cc; Wed, 25 Oct 2023 15:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjG-0000tk-JF
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:46 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjE-0006AK-RO
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:46 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-777754138bdso10726785a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262784; x=1698867584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LaMy1tZU02hq5CY5DrbMQay4vRzC3DngqtrEhWmQFqM=;
 b=emkscCTqE413IQH684jqpOXVbbEo+NNIPWkdgrSQK378rJtF2EqbOSCu//czQzHO5f
 l2vlnXjcY1CQfW6TjdyvC+q/n7LDqVPqGdGA9cm55SvLMX7c+61RNeXdj80KN4dab0Ei
 DzQMO4MZ6eU8zLhbOqdDKjBBAQ+x8xS7mR2PUkKOoge+NYZPVC56nbtnLa88pPZmXENX
 b15w4uqHIgyVtyuYyDVeQW1oX0ZLwLk8uRsFjI3es4dTi9QKNsjo4G+JRjhLtZdBIa6E
 5kjIETPVEPdYQY0LDuFGIKmEN9GBZ1RRmBckgK/Uaq+b25ofjhJcsgQpw7YUhkU8TsCX
 YJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262784; x=1698867584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LaMy1tZU02hq5CY5DrbMQay4vRzC3DngqtrEhWmQFqM=;
 b=U9IJqGf7u/JqF79OjUIe9DZLrkKT0Jvqwpe8htUzJiCzuT+Atncl46zHNQ0Vv0JxMf
 uHHniZPyk92cU6/JPyiWy56nW53f0ZA3Ji14SRocyJ2II/5q8mVrODgICX5UNdwD4g0l
 AUb6OqrR+fy6YGj+w7glXh9WD8zqik67CoKyG+0v34Qpn71HRw4+gDuyJ/IF+J4AavC+
 O4ibo7RnahLiR27k76UG0Zmw7Re0cyPAKUGXXDQRQjmeLgKTd1NAMOvM6pmWT+DnFoF/
 fzuS7ptSkLf2aV6fgd/einmUmyK8QVu53jnzGvWuGTG9QflsVppxZ7f473Wm5pBUaWJu
 9aFQ==
X-Gm-Message-State: AOJu0YzOfilQfcRfVJHZzPn+6CUQyb1IpKD6umJjUObPBwh9h36U61TF
 WGm90kqqhDcllxCq2oiQ8lR2WQ==
X-Google-Smtp-Source: AGHT+IGtqN1Zn8q4jz0CxuXgQRMUxrGp/9KdXc7XISKwfzhPIM2xNXorrbpmNDhjfEk2r1s3OVJFYA==
X-Received: by 2002:a05:620a:8806:b0:777:6fc2:cb2 with SMTP id
 qj6-20020a05620a880600b007776fc20cb2mr15429844qkn.71.1698262783876; 
 Wed, 25 Oct 2023 12:39:43 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:39:43 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 10/16] migration/multifd: Enable DSA offloading in multifd
 sender path.
Date: Wed, 25 Oct 2023 19:38:16 +0000
Message-Id: <20231025193822.2813204-11-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025193822.2813204-1-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x732.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Multifd sender path gets an array of pages queued by the migration
thread. It performs zero page checking on every page in the array.
The pages are classfied as either a zero page or a normal page. This
change uses Intel DSA to offload the zero page checking from CPU to
the DSA accelerator. The sender thread submits a batch of pages to DSA
hardware and waits for the DSA completion thread to signal for work
completion.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/multifd.c | 101 +++++++++++++++++++++++++++++++++++++-------
 migration/multifd.h |   3 ++
 2 files changed, 89 insertions(+), 15 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 452fb158b8..79fecbd3ae 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -13,6 +13,8 @@
 #include "qemu/osdep.h"
 #include "qemu/rcu.h"
 #include "qemu/cutils.h"
+#include "qemu/dsa.h"
+#include "qemu/memalign.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
 #include "exec/ramblock.h"
@@ -555,6 +557,8 @@ void multifd_save_cleanup(void)
             qemu_thread_join(&p->thread);
         }
     }
+    dsa_stop();
+    dsa_cleanup();
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
         Error *local_err = NULL;
@@ -571,6 +575,11 @@ void multifd_save_cleanup(void)
         p->name = NULL;
         multifd_pages_clear(p->pages);
         p->pages = NULL;
+        g_free(p->addr);
+        p->addr = NULL;
+        buffer_zero_batch_task_destroy(p->dsa_batch_task);
+        qemu_vfree(p->dsa_batch_task);
+        p->dsa_batch_task = NULL;
         p->packet_len = 0;
         g_free(p->packet);
         p->packet = NULL;
@@ -675,13 +684,71 @@ int multifd_send_sync_main(QEMUFile *f)
     return 0;
 }
 
+static void set_page(MultiFDSendParams *p, bool zero_page, uint64_t offset)
+{
+    RAMBlock *rb = p->pages->block;
+    if (zero_page) {
+        p->zero[p->zero_num] = offset;
+        p->zero_num++;
+        ram_release_page(rb->idstr, offset);
+    } else {
+        p->normal[p->normal_num] = offset;
+        p->normal_num++;
+    }
+}
+
+static void buffer_is_zero_use_cpu(MultiFDSendParams *p)
+{
+    const void **buf = (const void **)p->addr;
+    assert(!migrate_use_main_zero_page());
+    assert(!dsa_is_running());
+
+    for (int i = 0; i < p->pages->num; i++) {
+        p->dsa_batch_task->results[i] = buffer_is_zero(buf[i], p->page_size);
+    }
+}
+
+static void buffer_is_zero_use_dsa(MultiFDSendParams *p)
+{
+    assert(!migrate_use_main_zero_page());
+    assert(dsa_is_running());
+
+    buffer_is_zero_dsa_batch_async(p->dsa_batch_task,
+                                   (const void **)p->addr,
+                                   p->pages->num,
+                                   p->page_size);
+}
+
+static void multifd_zero_page_check(MultiFDSendParams *p)
+{
+    /* older qemu don't understand zero page on multifd channel */
+    bool use_multifd_zero_page = !migrate_use_main_zero_page();
+    bool use_multifd_dsa_accel = dsa_is_running();
+
+    RAMBlock *rb = p->pages->block;
+
+    for (int i = 0; i < p->pages->num; i++) {
+        p->addr[i] = (ram_addr_t)(rb->host + p->pages->offset[i]);
+    }
+
+    if (!use_multifd_zero_page || !use_multifd_dsa_accel) {
+        buffer_is_zero_use_cpu(p);
+    } else {
+        buffer_is_zero_use_dsa(p);
+    }
+
+    for (int i = 0; i < p->pages->num; i++) {
+        uint64_t offset = p->pages->offset[i];
+        bool zero_page = p->dsa_batch_task->results[i];
+        set_page(p, zero_page, offset);
+    }
+}
+
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
     MigrationThread *thread = NULL;
     Error *local_err = NULL;
-    /* older qemu don't understand zero page on multifd channel */
-    bool use_multifd_zero_page = !migrate_use_main_zero_page();
     int ret = 0;
     bool use_zero_copy_send = migrate_zero_copy_send();
 
@@ -707,7 +774,6 @@ static void *multifd_send_thread(void *opaque)
         qemu_mutex_lock(&p->mutex);
 
         if (p->pending_job) {
-            RAMBlock *rb = p->pages->block;
             uint64_t packet_num = p->packet_num;
             p->flags = 0;
             if (p->sync_needed) {
@@ -725,18 +791,7 @@ static void *multifd_send_thread(void *opaque)
                 p->iovs_num = 1;
             }
 
-            for (int i = 0; i < p->pages->num; i++) {
-                uint64_t offset = p->pages->offset[i];
-                if (use_multifd_zero_page &&
-                    buffer_is_zero(rb->host + offset, p->page_size)) {
-                    p->zero[p->zero_num] = offset;
-                    p->zero_num++;
-                    ram_release_page(rb->idstr, offset);
-                } else {
-                    p->normal[p->normal_num] = offset;
-                    p->normal_num++;
-                }
-            }
+            multifd_zero_page_check(p);
 
             if (p->normal_num) {
                 ret = multifd_send_state->ops->send_prepare(p, &local_err);
@@ -958,11 +1013,15 @@ int multifd_save_setup(Error **errp)
     int thread_count;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     uint8_t i;
+    const char *dsa_parameter = migrate_multifd_dsa_accel();
 
     if (!migrate_multifd()) {
         return 0;
     }
 
+    dsa_init(dsa_parameter);
+    dsa_start();
+
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
@@ -981,6 +1040,10 @@ int multifd_save_setup(Error **errp)
         p->pending_job = 0;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
+        p->addr = g_new0(ram_addr_t, page_count);
+        p->dsa_batch_task = 
+            (struct buffer_zero_batch_task *)qemu_memalign(64, sizeof(*p->dsa_batch_task));
+        buffer_zero_batch_task_init(p->dsa_batch_task, page_count);
         p->packet_len = sizeof(MultiFDPacket_t)
                       + sizeof(uint64_t) * page_count;
         p->packet = g_malloc0(p->packet_len);
@@ -1014,6 +1077,7 @@ int multifd_save_setup(Error **errp)
             return ret;
         }
     }
+
     return 0;
 }
 
@@ -1091,6 +1155,8 @@ void multifd_load_cleanup(void)
 
         qemu_thread_join(&p->thread);
     }
+    dsa_stop();
+    dsa_cleanup();
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -1225,6 +1291,7 @@ int multifd_load_setup(Error **errp)
     int thread_count;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     uint8_t i;
+    const char *dsa_parameter = migrate_multifd_dsa_accel();
 
     /*
      * Return successfully if multiFD recv state is already initialised
@@ -1234,6 +1301,9 @@ int multifd_load_setup(Error **errp)
         return 0;
     }
 
+    dsa_init(dsa_parameter);
+    dsa_start();
+
     thread_count = migrate_multifd_channels();
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
@@ -1270,6 +1340,7 @@ int multifd_load_setup(Error **errp)
             return ret;
         }
     }
+
     return 0;
 }
 
diff --git a/migration/multifd.h b/migration/multifd.h
index e8f90776bb..297b055e2b 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -114,6 +114,9 @@ typedef struct {
      * pending_job != 0 -> multifd_channel can use it.
      */
     MultiFDPages_t *pages;
+    /* Address of each pages in pages */
+    ram_addr_t *addr;
+    struct buffer_zero_batch_task *dsa_batch_task;
 
     /* thread local variables. No locking required */
 
-- 
2.30.2



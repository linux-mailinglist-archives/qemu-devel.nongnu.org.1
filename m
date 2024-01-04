Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 929418239CA
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:47:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs8-0008Lr-GN; Wed, 03 Jan 2024 19:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrt-0008IJ-0K
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:53 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBrq-0007UY-DV
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:45:51 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67f7bd86cafso48896d6.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329149; x=1704933949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kkm9xzp/SiR1hwWq4Nj+cCiiQt+6ofwhVjHRdTcH6kI=;
 b=efjfHv+jwmyYoQCVTUUsRv6OTgWicw/F8mzrnpX/cmEsVcTkDcpm0gF4/w/GFdh1NE
 6jy/VIPqhrVs0mlxqAjKFrTw/hZl+yoXUe2IAVqQ8kQwOYZ/xxoW+zPmRnOm+rKfrjRf
 BioKIyd3vMMkSsqWIrOt9RqgHKjJgARQz1aHCH0lUzlBqyVfL7KooWtwwMAgaMeRQF6q
 2MrmVLXhUlGzmn0ABrtpFV0Frow3i1SRe555MRnYLLfEw7s2WmLo9mBNrL5bqEWKvuw+
 nYE/J3VRBW+K+34E5sHl33ZnWZoJcNv1TRBeR+odEHWXvTOamBFuUp/b0kj3Bx6SpFw8
 KvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329149; x=1704933949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kkm9xzp/SiR1hwWq4Nj+cCiiQt+6ofwhVjHRdTcH6kI=;
 b=Lkv0ccfWmXfda855TdW/ollk7JlODu78mRKozJ8XD/b/WL+GZjjZtdVy4edRQ7EscB
 0ULqjeMaZavhSfzKZNWlyVwk+YVQOpIo3SItzyPy6JO2+NYVCJg9vgC4qIJT5kNKrYu3
 4rj6S8p/neCKiyyac0+iBzR6NfBZQYU1jmKBUlNBYqa2yRuhXeO9prpvDSpAjBNZa4JR
 9FXcrc/AbkJ7AKhqlkXh9dvVriVUO0Ek/eb99V6REhPbDYeT0jkwdFB8Oee/2GTn9x4X
 BcLEFlRdVcoryPw3qI2cNGp5FYGxlbkbGRbFxYSP/UU1R3FuRmBHXr7jtjqtXh5lAj+F
 To9w==
X-Gm-Message-State: AOJu0Ywk4pR4oDsLhODs7mI+NNMjLuoYQ2jJn+B1z0KnBLAyRQgdB/8U
 zkvoQYpB5hygiWEjOunIsodw7I++Kjyr5g==
X-Google-Smtp-Source: AGHT+IFBNoFnAuZl2249Ke9kr8+/21j+J7jdf6OWbVTWEUzqfP8ei8Ox2jZ8pxbi4rvE4cAy932qwA==
X-Received: by 2002:ad4:46cc:0:b0:67f:eac6:1be8 with SMTP id
 pm12-20020ad446cc000000b0067feac61be8mr18057747qvb.99.1704329149288; 
 Wed, 03 Jan 2024 16:45:49 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:48 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 14/20] migration/multifd: Enable DSA offloading in multifd
 sender path.
Date: Thu,  4 Jan 2024 00:44:46 +0000
Message-Id: <20240104004452.324068-15-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qv1-xf2c.google.com
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

Multifd sender path gets an array of pages queued by the migration
thread. It performs zero page checking on every page in the array.
The pages are classfied as either a zero page or a normal page. This
change uses Intel DSA to offload the zero page checking from CPU to
the DSA accelerator. The sender thread submits a batch of pages to DSA
hardware and waits for the DSA completion thread to signal for work
completion.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/multifd.c | 51 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index e7c549b93e..6e73d995b0 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -560,6 +560,7 @@ void multifd_save_cleanup(void)
             qemu_thread_join(&p->thread);
         }
     }
+    dsa_cleanup();
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
         Error *local_err = NULL;
@@ -699,6 +700,7 @@ static void buffer_is_zero_use_cpu(MultiFDSendParams *p)
 {
     const void **buf = (const void **)p->batch_task->addr;
     assert(!migrate_use_main_zero_page());
+    assert(!dsa_is_running());
 
     for (int i = 0; i < p->pages->num; i++) {
         p->batch_task->results[i] = buffer_is_zero(buf[i], p->page_size);
@@ -707,15 +709,29 @@ static void buffer_is_zero_use_cpu(MultiFDSendParams *p)
 
 static void set_normal_pages(MultiFDSendParams *p)
 {
+    assert(migrate_use_main_zero_page());
+
     for (int i = 0; i < p->pages->num; i++) {
         p->batch_task->results[i] = false;
     }
 }
 
+static void buffer_is_zero_use_dsa(MultiFDSendParams *p)
+{
+    assert(!migrate_use_main_zero_page());
+    assert(dsa_is_running());
+
+    buffer_is_zero_dsa_batch_async(p->batch_task,
+                                   (const void **)p->batch_task->addr,
+                                   p->pages->num,
+                                   p->page_size);
+}
+
 static void multifd_zero_page_check(MultiFDSendParams *p)
 {
     /* older qemu don't understand zero page on multifd channel */
     bool use_multifd_zero_page = !migrate_use_main_zero_page();
+    bool use_multifd_dsa_accel = dsa_is_running();
 
     RAMBlock *rb = p->pages->block;
 
@@ -723,7 +739,9 @@ static void multifd_zero_page_check(MultiFDSendParams *p)
         p->batch_task->addr[i] = (ram_addr_t)(rb->host + p->pages->offset[i]);
     }
 
-    if (use_multifd_zero_page) {
+    if (use_multifd_dsa_accel && use_multifd_zero_page) {
+        buffer_is_zero_use_dsa(p);
+    } else if (use_multifd_zero_page) {
         buffer_is_zero_use_cpu(p);
     } else {
         /* No zero page checking. All pages are normal pages. */
@@ -997,11 +1015,23 @@ int multifd_save_setup(Error **errp)
     int thread_count;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     uint8_t i;
+    const char *dsa_parameter = migrate_multifd_dsa_accel();
+    int ret;
+    Error *local_err = NULL;
 
     if (!migrate_multifd()) {
         return 0;
     }
 
+    ret = dsa_init(dsa_parameter);
+    if (ret != 0) {
+        error_setg(&local_err, "multifd: Sender failed to initialize DSA.");
+        error_propagate(errp, local_err);
+        return ret;
+    }
+
+    dsa_start();
+
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
@@ -1046,8 +1076,6 @@ int multifd_save_setup(Error **errp)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
-        Error *local_err = NULL;
-        int ret;
 
         ret = multifd_send_state->ops->send_setup(p, &local_err);
         if (ret) {
@@ -1055,6 +1083,7 @@ int multifd_save_setup(Error **errp)
             return ret;
         }
     }
+
     return 0;
 }
 
@@ -1132,6 +1161,7 @@ void multifd_load_cleanup(void)
 
         qemu_thread_join(&p->thread);
     }
+    dsa_cleanup();
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -1266,6 +1296,9 @@ int multifd_load_setup(Error **errp)
     int thread_count;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     uint8_t i;
+    const char *dsa_parameter = migrate_multifd_dsa_accel();
+    int ret;
+    Error *local_err = NULL;
 
     /*
      * Return successfully if multiFD recv state is already initialised
@@ -1275,6 +1308,15 @@ int multifd_load_setup(Error **errp)
         return 0;
     }
 
+    ret = dsa_init(dsa_parameter);
+    if (ret != 0) {
+        error_setg(&local_err, "multifd: Receiver failed to initialize DSA.");
+        error_propagate(errp, local_err);
+        return ret;
+    }
+
+    dsa_start();
+
     thread_count = migrate_multifd_channels();
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
@@ -1302,8 +1344,6 @@ int multifd_load_setup(Error **errp)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
-        Error *local_err = NULL;
-        int ret;
 
         ret = multifd_recv_state->ops->recv_setup(p, &local_err);
         if (ret) {
@@ -1311,6 +1351,7 @@ int multifd_load_setup(Error **errp)
             return ret;
         }
     }
+
     return 0;
 }
 
-- 
2.30.2



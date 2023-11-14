Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6727EAA3A
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:44:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBn-0007IF-7h; Tue, 14 Nov 2023 00:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBU-0007FW-7a
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:42:01 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBS-0001Tj-2S
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:42:00 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7789cc5c8ccso437322685a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940517; x=1700545317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xlsyQY8WI2WTqdEKVrbd/ZHNlkVulCz9X5dqbIEoOs=;
 b=D2KTBLxjEso/CYD1+4XxlQolGIiIO/q3jc97nIbkQEHAgrSCmMvL6J+klv8O6RTVIm
 QtM+xxm68ZvhRxHens4dKAS6tSsctkp2Jlz78JBleczaloHcBYer8b28gR6Pbu59bTZq
 eRGThWzUgcWkz6mKadFuKNPy3o0wm5q+1wKAk77CELLUrkqGRSocg6FSFMSiboQcFDTC
 9a65itN0oRWZjhF0Nb/JZ2RKq/zzlbS4MWUQ/1ReLTi1Pmrksoxo2vv8VyX1vbHSIOJB
 RG98j3CZeczH+s25I3xecx4AUxGfnXevKSl+spAhLqbVBA4+SsutIl5dPiBHpmjaT4ZL
 YKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940517; x=1700545317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0xlsyQY8WI2WTqdEKVrbd/ZHNlkVulCz9X5dqbIEoOs=;
 b=BknIYv+25T63rIR2wJ0axbjGiJr0HQbA0SnsL45Ypt4oGJsgjima8qbIxQ+EM0Jglj
 YU+SqCSmSC/kGOgCXLyXov3d7J51HAvrJ5Jm5mYnEzU1RL1s6vCc3qbwhQEnv7vdqdAZ
 utiwWcnGLfCALJrxpmjP0mZvN2Gt2nQLo8/3dgQ3BNiuZzWBJYRFBRdr5Pc8rSvtblT9
 KGCogsV3lLvLYjS9aIYRT5g2PAZS5NA6M7cTNOAlBuNxtR1k7vAdH6er2sOXN/gaDIj6
 H0tQztWIRftojvqnuLpNx0OCFnLTwUZUC+YNdP7R5cpuzLVsNk2UZs1eDPptaSt/pt0E
 foDg==
X-Gm-Message-State: AOJu0YzQx6v/k20hlYPtgKAwGWm3VCAtyBfeleoBYMOryffoR38Qdx7Z
 xeMsqdttuWwNTKvvmJ3B8pmYIZ05aD3cOuuVtn0=
X-Google-Smtp-Source: AGHT+IG9RihCKn9sme494WAgj7CNwJbavzmMX5AuBNqazVGN8mnK45cNLBLt4lEfo5XtB7aGPWrOWQ==
X-Received: by 2002:a05:620a:4089:b0:77a:5247:730a with SMTP id
 f9-20020a05620a408900b0077a5247730amr2044202qko.20.1699940517318; 
 Mon, 13 Nov 2023 21:41:57 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:41:57 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 14/20] migration/multifd: Enable DSA offloading in multifd
 sender path.
Date: Tue, 14 Nov 2023 05:40:26 +0000
Message-Id: <20231114054032.1192027-15-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72c.google.com
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
 migration/multifd.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 68ab97f918..2f635898ed 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -560,6 +560,8 @@ void multifd_save_cleanup(void)
             qemu_thread_join(&p->thread);
         }
     }
+    dsa_stop();
+    dsa_cleanup();
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
         Error *local_err = NULL;
@@ -702,6 +704,7 @@ static void buffer_is_zero_use_cpu(MultiFDSendParams *p)
 {
     const void **buf = (const void **)p->addr;
     assert(!migrate_use_main_zero_page());
+    assert(!dsa_is_running());
 
     for (int i = 0; i < p->pages->num; i++) {
         p->batch_task->results[i] = buffer_is_zero(buf[i], p->page_size);
@@ -710,15 +713,29 @@ static void buffer_is_zero_use_cpu(MultiFDSendParams *p)
 
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
+                                   (const void **)p->addr,
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
 
@@ -726,7 +743,9 @@ static void multifd_zero_page_check(MultiFDSendParams *p)
         p->addr[i] = (ram_addr_t)(rb->host + p->pages->offset[i]);
     }
 
-    if (use_multifd_zero_page) {
+    if (use_multifd_dsa_accel && use_multifd_zero_page) {
+        buffer_is_zero_use_dsa(p);
+    } else if (use_multifd_zero_page) {
         buffer_is_zero_use_cpu(p);
     } else {
         // No zero page checking. All pages are normal pages.
@@ -1001,11 +1020,15 @@ int multifd_save_setup(Error **errp)
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
@@ -1061,6 +1084,7 @@ int multifd_save_setup(Error **errp)
             return ret;
         }
     }
+
     return 0;
 }
 
@@ -1138,6 +1162,8 @@ void multifd_load_cleanup(void)
 
         qemu_thread_join(&p->thread);
     }
+    dsa_stop();
+    dsa_cleanup();
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -1272,6 +1298,7 @@ int multifd_load_setup(Error **errp)
     int thread_count;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     uint8_t i;
+    const char *dsa_parameter = migrate_multifd_dsa_accel();
 
     /*
      * Return successfully if multiFD recv state is already initialised
@@ -1281,6 +1308,9 @@ int multifd_load_setup(Error **errp)
         return 0;
     }
 
+    dsa_init(dsa_parameter);
+    dsa_start();
+
     thread_count = migrate_multifd_channels();
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
@@ -1317,6 +1347,7 @@ int multifd_load_setup(Error **errp)
             return ret;
         }
     }
+
     return 0;
 }
 
-- 
2.30.2



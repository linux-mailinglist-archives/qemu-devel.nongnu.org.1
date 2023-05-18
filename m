Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C761707DE7
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:19:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzaiV-0008Qd-TA; Thu, 18 May 2023 06:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaiS-00089Q-Nw
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaiR-0004oH-5G
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684405114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XAlu0C1AW8k1irt69rl1xQFZoyTCaUGINn+k0Ms/AEs=;
 b=f55fW4Z3u5kET5/b44GhxJqtQCYlFPi+Q0lRac0AAht58KD61GMnzxM6ebvhwmmCznG7oR
 uTuOtN6CLWIYaXoJugicJ55vIPAoMD1TpxQzdDMBRfhpqum7aMZxrhcoUcMi+0xMYGfGmx
 zMNXH4C5wb7rpYHCrRgkhy4IGFRhP1c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-eLTtV8r1NHm7pRC2HHxmgA-1; Thu, 18 May 2023 06:18:33 -0400
X-MC-Unique: eLTtV8r1NHm7pRC2HHxmgA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9662ead7bf8so211032866b.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684405112; x=1686997112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAlu0C1AW8k1irt69rl1xQFZoyTCaUGINn+k0Ms/AEs=;
 b=FQcr3IRKOdHFgKtuP+PE6+8F5tFCSVqj61/jP4xXZPMi1rnJrlokfdpNGi2ExdnSpe
 FSkHSJS79/ERDpdAP3E2LlJ89E4AXv92YI3jSFNMyy9FxuDK/rONqo4V++A5itjNjkLe
 eR9Z3fYsJ9K0NMBzqgTHJp881OUw1VZP/SSKWS+PlVJiZDdKgNN4gf/Kmg+6bu3ZToVV
 9DrcbH15F9Qs5PnxnDWcxRXt7hABoGuQkneEF4dGFdnaUjhuDo3NRSEyFe0+3+wHVy9O
 7+eX6A5qWrZtHBtl8NnD6XPM2an9twbu/bAwN+Fq/0YQiDh+/pFK6uPaUNCmESUJYngq
 Y0aQ==
X-Gm-Message-State: AC+VfDydXDOzsnQdNNOKtHqGecI6wnTGigIL4Qp1xaTLStM7gRwroKKM
 kSbZchr0v63rle6AejpSMaHK/o36eI7eBW6V8V3Z3jE75dHBRJ8SOF1ADkI9kjnKrz3Wan9OoG1
 7w1blekc4yUG+YoGcJtwQMaI1jIojUOVS4sfE/6ToTTOGNemTcAlTIlUBv/VJM5s3qmAyrNbHqH
 w=
X-Received: by 2002:a17:907:7282:b0:96a:4654:9a49 with SMTP id
 dt2-20020a170907728200b0096a46549a49mr23855246ejc.67.1684405111813; 
 Thu, 18 May 2023 03:18:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6vNyv5j9fWGZYqwapLBhytRqF28856eEvVOpjSY3J5ejPn5+nKki+bWc6lGWxx95L+g9RzOA==
X-Received: by 2002:a17:907:7282:b0:96a:4654:9a49 with SMTP id
 dt2-20020a170907728200b0096a46549a49mr23855223ejc.67.1684405111452; 
 Thu, 18 May 2023 03:18:31 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 c14-20020aa7c74e000000b0050bc13e5aa9sm411540eds.63.2023.05.18.03.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:18:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	kwolf@redhat.com
Subject: [PATCH 4/5] monitor: extract request dequeuing to a new function
Date: Thu, 18 May 2023 12:18:22 +0200
Message-Id: <20230518101823.992158-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518101823.992158-1-pbonzini@redhat.com>
References: <20230518101823.992158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/qmp.c | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index baa1f6652e07..9ec28be2ee10 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -199,11 +199,6 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
     Monitor *mon;
     MonitorQMP *qmp_mon;
 
-    /* On shutdown, don't take any more requests from the queue */
-    if (qmp_dispatcher_co_shutdown) {
-        return NULL;
-    }
-
     QTAILQ_FOREACH(mon, &mon_list, entry) {
         if (!monitor_is_qmp(mon)) {
             continue;
@@ -231,14 +226,9 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
     return req_obj;
 }
 
-void coroutine_fn monitor_qmp_dispatcher_co(void *data)
+static QMPRequest *monitor_qmp_dispatcher_pop_any(void)
 {
-    QMPRequest *req_obj = NULL;
-    QDict *rsp;
-    bool oob_enabled;
-    MonitorQMP *mon;
-
-    while (true) {
+    for (;;) {
         /*
          * busy must be set to true again by whoever
          * rescheduled us to avoid double scheduling
@@ -253,19 +243,36 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
         qatomic_mb_set(&qmp_dispatcher_co_busy, false);
 
         WITH_QEMU_LOCK_GUARD(&monitor_lock) {
+            QMPRequest *req_obj;
+
+            /* On shutdown, don't take any more requests from the queue */
+            if (qmp_dispatcher_co_shutdown) {
+                return NULL;
+            }
+
             req_obj = monitor_qmp_requests_pop_any_with_lock();
+            if (req_obj) {
+                return req_obj;
+            }
         }
 
-        if (!req_obj) {
-            /*
-             * No more requests to process.  Wait to be reentered from
-             * handle_qmp_command() when it pushes more requests, or
-             * from monitor_cleanup() when it requests shutdown.
-             */
-            qemu_coroutine_yield();
-            continue;
-        }
+        /*
+         * No more requests to process.  Wait to be reentered from
+         * handle_qmp_command() when it pushes more requests, or
+         * from monitor_cleanup() when it requests shutdown.
+         */
+        qemu_coroutine_yield();
+    }
+}
 
+void coroutine_fn monitor_qmp_dispatcher_co(void *data)
+{
+    QMPRequest *req_obj;
+    QDict *rsp;
+    bool oob_enabled;
+    MonitorQMP *mon;
+
+    while ((req_obj = monitor_qmp_dispatcher_pop_any()) != NULL) {
         trace_monitor_qmp_in_band_dequeue(req_obj,
                                           req_obj->mon->qmp_requests->length);
 
-- 
2.40.1



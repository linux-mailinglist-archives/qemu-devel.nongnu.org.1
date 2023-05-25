Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C796710E2F
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:20:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BlN-0004om-H1; Thu, 25 May 2023 10:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2BlC-0004gl-9n
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2BlA-0007gI-OZ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsCB2PpMqLAI751TxRUVX6LSKdDhP9H0kd0ajUo5CnM=;
 b=Q3sv/sjSvYn+bi6OV4mlPbHRgY6ggumshbpKl3uw4TVQh4qRE/VTuuaeZuxxTs6OTHBQw1
 6fIh/PruAn0XCkDC3r7GO8YDJQ/Uru1rOMbr2simxR3otEiCsgF2zimb6s3aAT2boI9S0l
 LuJMBWwFw9vqEqtzZ3UuHhNFOq7aMoA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-xSna5nl8PD2_JvixCFW1mA-1; Thu, 25 May 2023 10:16:04 -0400
X-MC-Unique: xSna5nl8PD2_JvixCFW1mA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-96f46e5897eso85694366b.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024162; x=1687616162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WsCB2PpMqLAI751TxRUVX6LSKdDhP9H0kd0ajUo5CnM=;
 b=bFxveOmVR7Ik1vwc5wzLNoPt12zMf7EjKWoMb48KitP1asC+DHOW0ZEnSs0mTgENLS
 erNva6FABdbIqMhRNgh5v1n8YBE0gB2QOfCrBPz1mcn+kPIx6oVwospLbfUONDVGxA2Q
 01sw7qzrz8nwygYIowITptJTyZrEvWd3jifIpLdVoqoKS81kZACwXj1spPqW6Y9Z/PjC
 2clW/7Z0u6NnBW+XjoSU2mDNMhdnstH0XzPEoJVB2AIX+7lWY6q8Nn7O09bIE2elR09D
 ZZ046Wg/RF5eQO0qRDeo2J41LSqRs+G668yYbFukquW2sd+eCtVBVgcUAg4fMWfR/ep5
 slqg==
X-Gm-Message-State: AC+VfDxbVaEw+f3rlbiPNlCeZeEOMc7vgem/pjp93OTTiLoTfsiyqoV+
 gHkpkStdS/6yr8aeSOwA4qDGVBisr9jbYD9oiccYSOMPG4BuQh4Lu9LHAIU/dphP1mX4qMlzfda
 pdx2t+UBmITVEqgKTqByU7cEiM2qDokvyLIhOoN9R3pwRiWoya/xGOVJsrgIz1OzwLq/1QSjoYb
 8=
X-Received: by 2002:a17:906:6a0c:b0:96f:3e35:748a with SMTP id
 qw12-20020a1709066a0c00b0096f3e35748amr2240381ejc.6.1685024162372; 
 Thu, 25 May 2023 07:16:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Sj7MfAmZe1b5yQuqy2xxgN8jtur90fXy9yjlCagLg1XzrrKw7aEd89vVqltIPNfO5Ne9VtA==
X-Received: by 2002:a17:906:6a0c:b0:96f:3e35:748a with SMTP id
 qw12-20020a1709066a0c00b0096f3e35748amr2240362ejc.6.1685024162102; 
 Thu, 25 May 2023 07:16:02 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 oz2-20020a170906cd0200b00932fa67b48fsm897651ejb.183.2023.05.25.07.16.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:16:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/20] monitor: extract request dequeuing to a new function
Date: Thu, 25 May 2023 16:15:31 +0200
Message-Id: <20230525141532.295817-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
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
 monitor/qmp.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 613b74ec74a7..e6b1043c9f7b 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -226,13 +226,8 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
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
     while (true) {
         /*
          * busy must be set to true again by whoever
@@ -248,24 +243,36 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
         qatomic_mb_set(&qmp_dispatcher_co_busy, false);
 
         WITH_QEMU_LOCK_GUARD(&monitor_lock) {
+            QMPRequest *req_obj;
+
             /* On shutdown, don't take any more requests from the queue */
             if (qmp_dispatcher_co_shutdown) {
                 return NULL;
             }
 
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



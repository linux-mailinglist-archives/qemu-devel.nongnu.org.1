Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1121712206
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:19:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Sea-0005jD-62; Fri, 26 May 2023 04:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2SeP-0005go-F3
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2SeM-0006CJ-8h
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685089093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zuw7Holfez9ATPR6YXDW73l2bSz4hijPrC+U7I0eCnE=;
 b=FLfrd2oZUwPPoeRgzMjLPFmG7c+5b3mSgosDg3BFgPpkKz0QkfCGkp2zWqOq1gTJrfWtF7
 1vaZFTaJRLtlObsGYViRjm5Y8iczBWVTDv1QpuGRUxa8Q5m3fYf89QC4GwcEuUl9OV9FW3
 VWWaqnQpIKMBBs4TvZ+l/VCxRFoWqxI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-Jej8ahe7N-uy5avnUgOLFA-1; Fri, 26 May 2023 04:18:11 -0400
X-MC-Unique: Jej8ahe7N-uy5avnUgOLFA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96faa650a3fso59625066b.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685089090; x=1687681090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zuw7Holfez9ATPR6YXDW73l2bSz4hijPrC+U7I0eCnE=;
 b=Hfv/J+GroBuWWS2vOv5dXFJ/on1PO+OlEr7zKTypYAVDyNvaRum04v//cuXzR6MIaD
 worzZ4WdCNFr6Birt6mCE4XYJ/ouJDbETtRum1FXEstJIg0Jh0992XG0o53MjLJBbC2e
 Dv97e/5+24cl//m/8a9SUrYnJDz/HPfpOK96pcqtMwBt5FWWquDi+aI0DerC8l9gKx/2
 RYmaBuAFznWesHhZHGKuU6KmM87GIPUcBox01UYjJg7ixuZ635ICU2rLhJ8503R2Vj0i
 tHZ1rNJqBrvXako07ycAc73YWm0kG+sGeVDR7Xo035z5k74OESs4hO5N35QARVml68F6
 bCdA==
X-Gm-Message-State: AC+VfDx6P30KvZTb6seV6x4TDeeOcw5tT5NDuEOK+w7FM9xEatpE8Bka
 9cNqLxXjsSFbtsufjRUDq3kma/CPDhLV+GAYNCuU/+sKRusXtwkGcCmaRxCQmwmZ01Eft97+F9P
 DFnnhE+GqnItKgCKShoLZvJSmQyRHmu7g8MUC/9aUrDfaMJLnjQaSaWxzXm6nSe23uY3StWunwI
 E=
X-Received: by 2002:a17:907:dac:b0:960:ddba:e5c5 with SMTP id
 go44-20020a1709070dac00b00960ddbae5c5mr1242587ejc.11.1685089090367; 
 Fri, 26 May 2023 01:18:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4j0xT/MYETsbsc79Vq7MmDf1tnLaErGdW6EK+Al3OufGxEb6P8hvM07cs95EZFVY+vSxCgdA==
X-Received: by 2002:a17:907:dac:b0:960:ddba:e5c5 with SMTP id
 go44-20020a1709070dac00b00960ddbae5c5mr1242575ejc.11.1685089089978; 
 Fri, 26 May 2023 01:18:09 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 k12-20020a170906128c00b00965a52d2bf6sm1793512ejb.88.2023.05.26.01.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 01:18:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] monitor: remove more unnecessary atomics
Date: Fri, 26 May 2023 10:18:08 +0200
Message-Id: <20230526081808.423277-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
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

Simplify monitor_cleanup by:

- using main_loop_wait() to poll both the block layer AioContext
  and the I/O handlers

- using a bottom half to clear qmp_dispatcher_co; this removes the
  atomics but also forces an exit out of main_loop_wait.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/monitor.c | 7 ++++---
 monitor/qmp.c     | 7 ++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index dc352f9e9d95..01d6aabf41db 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -666,9 +666,10 @@ void monitor_cleanup(void)
     }
     qmp_dispatcher_co_wake();
 
-    AIO_WAIT_WHILE_UNLOCKED(NULL,
-                   (aio_poll(iohandler_get_aio_context(), false),
-                    qatomic_read(&qmp_dispatcher_co)));
+    /* Loop until sync_with_main_loop_bh runs.  */
+    while (qmp_dispatcher_co) {
+        main_loop_wait(false);
+    }
 
     /*
      * We need to explicitly stop the I/O thread (but not destroy it),
diff --git a/monitor/qmp.c b/monitor/qmp.c
index c8e0156974d9..8b465d80fb1a 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -271,6 +271,11 @@ static QMPRequest *monitor_qmp_dispatcher_pop_any(void)
     }
 }
 
+static void sync_with_main_loop_bh(void *opaque)
+{
+    qmp_dispatcher_co = NULL;
+}
+
 void coroutine_fn monitor_qmp_dispatcher_co(void *data)
 {
     QMPRequest *req_obj;
@@ -365,7 +370,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
         aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
         qemu_coroutine_yield();
     }
-    qatomic_set(&qmp_dispatcher_co, NULL);
+    aio_bh_schedule_oneshot(qemu_get_aio_context(), sync_with_main_loop_bh, NULL);
 }
 
 void qmp_dispatcher_co_wake(void)
-- 
2.40.1



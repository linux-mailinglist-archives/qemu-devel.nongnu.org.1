Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3580D707DED
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:19:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzaiW-0008RO-8i; Thu, 18 May 2023 06:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaiU-0008Na-IY
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaiS-0004oU-V7
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684405116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3DIkeHi4eqsWbxNFyJ78KEvxq2ca7sFGIK3jJY+FtD8=;
 b=GnFQVfX0eEOr5WyF/+aKH5KhjwzyNwj6OKiBqf3H82FVOsqiL9XIVGM0WInR7NxKbIzCQo
 EFfUt27pUZr5fDWC9zEAoiqCvMTEZRzlBn08qcs8i+fjdMk2cCqo/mYGbtza0v4eXmH2zF
 3+ZByZWrjTawcLYTzo3H/8F9u5bZyQU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-oMIigJ-lPqCGv5plBcIrgQ-1; Thu, 18 May 2023 06:18:35 -0400
X-MC-Unique: oMIigJ-lPqCGv5plBcIrgQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-506b21104faso371537a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684405113; x=1686997113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DIkeHi4eqsWbxNFyJ78KEvxq2ca7sFGIK3jJY+FtD8=;
 b=bHnH0l4whGLYi4koi9TI6injT8wjH3g881d69mkB+SV3ca3RWmf2l7ZF48YWB3EQdV
 tlgh4GWc8kdGqN2WDIaFg86T4SgwyjydJfxWaTjqUKk+xiZx9XtJ38AyMpUgLNeFasjM
 pT7vJlu0tWFFFFCiraXN2CODPasTKipahoq8pJrHOPyuotlKsuutEpeVh4Tyr20H11O4
 EK6mLPipQsIk3so0YUahe5Zmpstiuf0wVbMa1bhgubXDWn45jbq0iRpdbXZQaRiXJRP3
 BevUxAQywzeM9LsRmsFgz/YHOeykJWl81ZaqqBqtqqZBM2vBYuP41kBlpBiIft4t3njm
 hc9Q==
X-Gm-Message-State: AC+VfDxKRbwnQvd1eqwWNPA68zr4bojgeef6I1QKkeDscGspJL9MbgHc
 5OieGmfp5wzhAKYkvFv/i8ZDAq0kp0nEXbVpmIrIADc7HogyO3mHvP64hegXjFToIdOOIxGIwst
 NHTw3N2VGAWMgzTfDf/AskOn3hOvoUUqXyOM+Al7dfebgyQYChlADKaaTt6IqS6TqMYkGfFlkVU
 4=
X-Received: by 2002:a17:907:1c21:b0:96f:2315:da2 with SMTP id
 nc33-20020a1709071c2100b0096f23150da2mr2328667ejc.18.1684405113441; 
 Thu, 18 May 2023 03:18:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ54IZ0tOStDxLkqK5Ss4npKaRE1Bq2+nI9B/g9tPQlqUGsP5uw/NSwhGYvHip4GU7624nJ4dg==
X-Received: by 2002:a17:907:1c21:b0:96f:2315:da2 with SMTP id
 nc33-20020a1709071c2100b0096f23150da2mr2328641ejc.18.1684405112997; 
 Thu, 18 May 2023 03:18:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a170906274c00b0095850aef138sm782638ejd.6.2023.05.18.03.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:18:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	kwolf@redhat.com
Subject: [PATCH 5/5] monitor: do not use mb_read/mb_set
Date: Thu, 18 May 2023 12:18:23 +0200
Message-Id: <20230518101823.992158-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518101823.992158-1-pbonzini@redhat.com>
References: <20230518101823.992158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Instead of relying on magic memory barriers, document the pattern that
is being used.  It is the one based on Dekker's algorithm, and in this
case it is embodied as follows:

    enqueue request;              sleeping = true;
    smp_mb();                     smp_mb();
    if (sleeping) kick();         if (!have a request) yield();

qatomic_mb_set() can be kept---but it will be shortly renamed to
qatomic_set_mb() to clarify that the write occurs _before_ the
barrier, just in the right column of the pseudocode above.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/qmp.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 9ec28be2ee10..aee8ce4cf006 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -39,13 +39,16 @@
  * coroutine never gets scheduled a second time when it's already
  * scheduled (scheduling the same coroutine twice is forbidden).
  *
- * It is true if the coroutine is active and processing requests.
- * Additional requests may then be pushed onto mon->qmp_requests,
- * and @qmp_dispatcher_co_shutdown may be set without further ado.
- * @qmp_dispatcher_co_busy must not be woken up in this case.
+ * It is true if the coroutine will process at least one more request
+ * before going to sleep.  Either it has been kicked already, or it
+ * is active and processing requests.  Additional requests may therefore
+ * be pushed onto mon->qmp_requests, and @qmp_dispatcher_co_shutdown may
+ * be set without further ado.  @qmp_dispatcher_co must not be woken up
+ * in this case.
  *
- * If false, you also have to set @qmp_dispatcher_co_busy to true and
- * wake up @qmp_dispatcher_co after pushing the new requests.
+ * If false, you have to wake up @qmp_dispatcher_co after pushing new
+ * requests. You also have to set @qmp_dispatcher_co_busy to true
+ * before waking up the coroutine.
  *
  * The coroutine will automatically change this variable back to false
  * before it yields.  Nobody else may set the variable to false.
@@ -230,15 +233,18 @@ static QMPRequest *monitor_qmp_dispatcher_pop_any(void)
 {
     for (;;) {
         /*
-         * busy must be set to true again by whoever
-         * rescheduled us to avoid double scheduling
+         * To avoid double scheduling, busy is true on entry to
+         * monitor_qmp_dispatcher_co(), and must be set again before
+         * aio_co_wake()-ing it.
          */
-        assert(qatomic_mb_read(&qmp_dispatcher_co_busy) == true);
+        assert(qatomic_read(&qmp_dispatcher_co_busy) == true);
 
         /*
          * Mark the dispatcher as not busy already here so that we
          * don't miss any new requests coming in the middle of our
          * processing.
+         *
+         * Clear qmp_dispatcher_co_busy before reading request.
          */
         qatomic_mb_set(&qmp_dispatcher_co_busy, false);
 
@@ -364,6 +370,9 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
 
 void qmp_dispatcher_co_wake(void)
 {
+    /* Write request before reading qmp_dispatcher_co_busy.  */
+    smp_mb__before_rmw();
+
     if (!qatomic_xchg(&qmp_dispatcher_co_busy, true)) {
         aio_co_wake(qmp_dispatcher_co);
     }
-- 
2.40.1



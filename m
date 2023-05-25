Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBE8710E1B
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:17:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BlM-0004nZ-FD; Thu, 25 May 2023 10:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2BlC-0004go-RD
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2BlB-0007gS-B2
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLqngycXeoMkwV+TcVmJCMGv/WB1nSRpyxhzsgGE6qc=;
 b=OEnTCH2vb20D9UOLF3MCtMBb1iaGqgxI0sgTNFC3JP3wQKyj+RyBRioqsCjo1nBEJnslfE
 rudPZ6rAjgsMsr1hxQ4NHTXI47BSF4AkgJ9EmrqYrU2iFAy+6DPMNG8I896DQIemGQc6Y5
 nGZZBJkeL4KLmN4hi8l0i2i90hx7tf4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282--pg1nnwlN0-jdEkvAEbBwA-1; Thu, 25 May 2023 10:16:05 -0400
X-MC-Unique: -pg1nnwlN0-jdEkvAEbBwA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96fa4c724fdso77876066b.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024164; x=1687616164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLqngycXeoMkwV+TcVmJCMGv/WB1nSRpyxhzsgGE6qc=;
 b=icxW60gbAmXHmhB8Ancddl9d1/hCmukEphtuwtfn2+4VEwtzJAk5Upv2B1U7UN/Fp0
 EldahbuR6IQL4Oswm059k+qBcfL1Eti5lgXaZhRc0ivhF9KgJNzqInMNDVKgsI0GDoGl
 NXcRu53dy2FyGzZKuV2TNhhXuiGLH+zgSjQAhNQffKALPovXESzQVkQEn6rAe4J2Hv27
 H3B86zlPjj32SVTJ/MwtvmUp62fvAEiBlc5Q0bjjj7H/7IIqi3LM1qYYLnBqpC/Sm59W
 nZxcTc7Uk1SfmynB6hFhjENt3px8ZifaeHcSY2mC4GOA3aaB2jzFTrvtGprr9NZXLn3w
 NY1Q==
X-Gm-Message-State: AC+VfDwONbFtYRm9amhXCjeDaQxo311BvO1s/YjsiOd28Z3lY36F8GmA
 jk7gg5kRZIh5PwAUmDnEYZuDzAnClav5N80qAB+nwQKuFe0+g82QgKIym5RJbI41CmRZCDXIOpe
 ED49Yxc1nPRJZ7xJnpCur1vh+ebvQzAI6AG3/dTqXGEG6DKPPtbrTMniZnpCn2zkylIdimErWx+
 E=
X-Received: by 2002:a17:907:94c3:b0:94a:653b:ba41 with SMTP id
 dn3-20020a17090794c300b0094a653bba41mr1770087ejc.15.1685024164163; 
 Thu, 25 May 2023 07:16:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5rDyFnkTOAlsKEe+DbVshcclrylxsfiEv0l5hrWDZswX+AyGuVyl/DKhCCmi+WyX9ziPyFHg==
X-Received: by 2002:a17:907:94c3:b0:94a:653b:ba41 with SMTP id
 dn3-20020a17090794c300b0094a653bba41mr1770061ejc.15.1685024163756; 
 Thu, 25 May 2023 07:16:03 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 lr7-20020a170906fb8700b009659fed3612sm904340ejb.24.2023.05.25.07.16.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:16:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/20] monitor: do not use mb_read/mb_set
Date: Thu, 25 May 2023 16:15:32 +0200
Message-Id: <20230525141532.295817-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
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

Instead of relying on magic memory barriers, document the pattern that
is being used.  It is the one based on Dekker's algorithm, and in this
case it is embodied as follows:

    enqueue request;              sleeping = true;
    smp_mb();                     smp_mb();
    if (sleeping) kick();         if (!have a request) yield();

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/qmp.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index e6b1043c9f7b..c8e0156974d9 100644
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
     while (true) {
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



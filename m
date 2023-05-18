Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48995707DE9
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:19:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzaiQ-0007un-VM; Thu, 18 May 2023 06:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaiN-0007p4-TA
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaiM-0004nX-D1
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684405109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJIcYdZiEX3LyHd3jqDR3lyTstBBflPYOIz6+wi9CP8=;
 b=MSSgrKyXE6CYxi5GnjM+5MkxYfKX1iQg12pG2Z+S8ow0ayiRDX7GlsoxR1H5Tx7hU530g7
 Onz5V0a/dO+2WeOsDqFRU67bkDwOFKyJz4aBmbiODRc87dyr5IvY1R/6H4/hCzFX1q5Zaj
 g0bb/f38ZeMUIDujpcF832DWtuQg7ow=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-p9UuvD2sNnm55fEMzz35wg-1; Thu, 18 May 2023 06:18:28 -0400
X-MC-Unique: p9UuvD2sNnm55fEMzz35wg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94f7a2b21fdso38969966b.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684405107; x=1686997107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJIcYdZiEX3LyHd3jqDR3lyTstBBflPYOIz6+wi9CP8=;
 b=adIqC6/oc9spDEQ7IbPO35mc/cHIsrWlCCP8paz49jpalIxF5h0kPUoCD3LxkG5qVw
 B38U289VlupKDUIMUYnFGXZHnUzT/mLVsgiDfqr5lkX4FSuVeSNgtEYxaacVP65iIFC9
 r6HZLpauouH6fpygHdes50rTradiVOOtdMv7PHfAhpb6XPP0MSdZEcIuflYtNdf9PmlJ
 cXYWdElX5sLNPmyshfxBmP6sGLglynYmfTzeP+fsE1BWriQljfv/ycNcgJjq9cHFKiFm
 l20tkUAoyi70TBkMCOxGgbY3veHQ2PitGKZZHXapWsiX+IYy8cSGr+UkNuIgYymIWOW/
 sTqQ==
X-Gm-Message-State: AC+VfDyb/uZkqsruKVg3px14t5CZs7NrJ4EGJQfZ+Ww8mSf+1arcR87M
 ICxU+FCAjIYoY2yPUbChitQqpB1NtDamcQrtxKlSnTX+XiWxHoVD7kkIzmnjmMOjsaK9Hwcr7TH
 Bn6uhem8L2HyM/d93mYci/ul9f6SrKyHJEgkzJxW2cRoaNjPZ2USUZKeY7cLvOY+fQP3uGyLlf4
 4=
X-Received: by 2002:a17:907:9605:b0:93e:fa12:aa1a with SMTP id
 gb5-20020a170907960500b0093efa12aa1amr40710359ejc.1.1684405106824; 
 Thu, 18 May 2023 03:18:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Jxn3sDcTRpKZpJlBQzuxTAiqjsx+dO7Ru7KQBH8uLAF8AfuofQnzPF+nFAf8FI4ujxnfHcA==
X-Received: by 2002:a17:907:9605:b0:93e:fa12:aa1a with SMTP id
 gb5-20020a170907960500b0093efa12aa1amr40710341ejc.1.1684405106437; 
 Thu, 18 May 2023 03:18:26 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a170906410100b0096b55be592asm780668ejk.92.2023.05.18.03.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:18:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	kwolf@redhat.com
Subject: [PATCH 1/5] monitor: cleanup detection of qmp_dispatcher_co shutting
 down
Date: Thu, 18 May 2023 12:18:19 +0200
Message-Id: <20230518101823.992158-2-pbonzini@redhat.com>
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

Instead of overloading qmp_dispatcher_co_busy, make the coroutine
pointer NULL.  This will make things break spectacularly if somebody
tries to start a request after monitor_cleanup().

AIO_WAIT_WHILE_UNLOCKED() does not need qatomic_mb_read(), because
the macro contains all the necessary memory barriers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/monitor.c | 2 +-
 monitor/qmp.c     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 15f97538ef2b..c4ed2547c25f 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -686,7 +686,7 @@ void monitor_cleanup(void)
 
     AIO_WAIT_WHILE_UNLOCKED(NULL,
                    (aio_poll(iohandler_get_aio_context(), false),
-                    qatomic_mb_read(&qmp_dispatcher_co_busy)));
+                    qatomic_read(&qmp_dispatcher_co)));
 
     /*
      * We need to explicitly stop the I/O thread (but not destroy it),
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 092c527b6fc9..f0cc6dc886f8 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -226,6 +226,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
 
         /* On shutdown, don't take any more requests from the queue */
         if (qmp_dispatcher_co_shutdown) {
+            qatomic_set(&qmp_dispatcher_co, NULL);
             return;
         }
 
@@ -250,6 +251,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
              * yielded and were reentered from monitor_cleanup()
              */
             if (qmp_dispatcher_co_shutdown) {
+                qatomic_set(&qmp_dispatcher_co, NULL);
                 return;
             }
         }
-- 
2.40.1



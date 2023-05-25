Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA768710E38
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:22:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BlL-0004mT-Mq; Thu, 25 May 2023 10:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bl7-0004fQ-SY
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bl5-0007ez-Px
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJIcYdZiEX3LyHd3jqDR3lyTstBBflPYOIz6+wi9CP8=;
 b=UtZ2gzGdBMS8pfEr6uvILoptOdIQkNWwXrajh3Gmi2FS7Sr+6M5dUv7ewySOq7/zqvYWzS
 n1xExujEH4SoLMZknld8IXADbhBSJyWPnxIjMSrBzVzg6DINkrI6PkhE9XAXGIR+/aIT46
 /gwV48doR8T63mN9M9elD2/YDjli2AI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-LpJ4kMZPMr-qBc7tzOw8kQ-1; Thu, 25 May 2023 10:16:01 -0400
X-MC-Unique: LpJ4kMZPMr-qBc7tzOw8kQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96f4f1bb838so69138866b.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024158; x=1687616158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJIcYdZiEX3LyHd3jqDR3lyTstBBflPYOIz6+wi9CP8=;
 b=RSP1yu/Lyt8klckyuwMMRoP1FD72UmbW/xz+yrbvofJhrGgFXsrZRjK38H9EfbmBt4
 +Z5UDwqHbfol3hJllUfQN7rpyCk5LD98HQyGp4jPzH7VDCSpZUNYp48Io9wkqXFZ1ncR
 lPmv+OI2J3CW2qUlIOnHsQUEMQUgu8XAHorlIqrrPj6vuIkTIo6Z9A1P4g+8YwHJy3Gj
 Lni1Ohj1E8fTatoS+SJWG6f2aZZt1P18DAS2IZUyqTU3gpDaQaEdV5cAOpGX/qcic1DX
 aemmlhCsEMCgPHOMU/rxmUQTJQ4bKtzVuCT2YrsIEPGz2MDhJP4h9SaL5a6Sguls4+Be
 n4xw==
X-Gm-Message-State: AC+VfDzEoc8mXgK03nRzMWlDrNA6eCRAByCe/OCxIOyyIvrgG9gFm679
 AbHcVXtw1jx3C7kt/uHUahzfbneLU2cQWnX0RKHm1oUuowrZwVJzRDxBEvzsg7PWVDTzHp73Sm9
 gfMFR4UHFQDTOKrVlehrak0T+ryFa+CJqV86xRbyAYQvmKkKsRxJ4Yb2FFDO6fQWDoE2FnKOdSG
 w=
X-Received: by 2002:a17:907:707:b0:96b:1608:3563 with SMTP id
 xb7-20020a170907070700b0096b16083563mr1767506ejb.58.1685024158138; 
 Thu, 25 May 2023 07:15:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6pOLYk1iCVewesqi5FE8h4Yhkx2gKELsU1EeMazv7m6VNEnoOs4mXiV3dvgVVG96EEbBoRQg==
X-Received: by 2002:a17:907:707:b0:96b:1608:3563 with SMTP id
 xb7-20020a170907070700b0096b16083563mr1767479ejb.58.1685024157704; 
 Thu, 25 May 2023 07:15:57 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 k12-20020a170906128c00b00965a52d2bf6sm876614ejb.88.2023.05.25.07.15.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/20] monitor: cleanup detection of qmp_dispatcher_co shutting
 down
Date: Thu, 25 May 2023 16:15:28 +0200
Message-Id: <20230525141532.295817-17-pbonzini@redhat.com>
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



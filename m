Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F56F7D25C5
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 22:14:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1queoa-0005GI-AS; Sun, 22 Oct 2023 16:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoV-0005D3-55
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoT-000618-HK
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698005560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3Z7cHyCISTXqbo3tI+yi6RkFj6TgXVXNtX2A4hjFww=;
 b=PN3GE4OnzJyXlymJZFz1ZaaD74dyLgNIPOpcR5s9B0Xx3grnqIhKmn9x+KEhyp/xGIqElB
 JTx/YbboBJo49b6C286zV/hYS7RoR7+Z92hsKQ7WAhK7wbNx+EDCBHUPBsA+JM3wy1dg/x
 Sz+QZfo5SNlbegwMpIsrZxrVFUNg5bE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-lH_YLdjsPYOMSp8zgs6XLQ-1; Sun, 22 Oct 2023 16:12:38 -0400
X-MC-Unique: lH_YLdjsPYOMSp8zgs6XLQ-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-581e7b03855so1204145eaf.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 13:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698005557; x=1698610357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w3Z7cHyCISTXqbo3tI+yi6RkFj6TgXVXNtX2A4hjFww=;
 b=PzIAmCLSB0BLQU9aVooeL33OeXOsHPmTPiLgaiMGirpC2//qPDXLZG0+C1Ko5PlnCK
 RCphhFTVquzEHnV4IIcziCAMs4G57ngQgWlZiqK3fuX9cdgTkFZU5mWSLeHtFYEGdxKs
 sGPcmM0gM7fCT3BDXWRW3jFIAuvNWi41Ql+N5NtaTXLOjztRAX1s8QmxnqQpX9l+Vbqa
 d59rK85Ofe1xj85R7x80tLjVI+NPM1LnRLj3HhzKzLjLSyjkB69aIvIhRQtQjq0+KIdD
 azNpInPb/jhzj/N3XRvBXQ5+l16RcRbX+AD3Q8zNzvUrAW2wE64K2JEH4hrECQd+No7Z
 eZfQ==
X-Gm-Message-State: AOJu0Yx7J/Hcn9ggcxbrb6sA7uR92MxSFcnJIbIzfANMX09GBc0InBQY
 BUQjMEpj6peum/2QDhTkKvKfzSLmf30LTcZyqH4T4gt0t+nlBfPhbtO2M+UWT5wD5dxj9pGHUyY
 C9aX3j8pRsaaHDistUT6VO1OQG1e+rzMMQAhTwqeNufiS5hhxjHnwK7e0ZUfGDvdXFXMdsuuA
X-Received: by 2002:a05:6870:9d98:b0:1e9:a8ff:67e3 with SMTP id
 pv24-20020a0568709d9800b001e9a8ff67e3mr9408267oab.4.1698005557639; 
 Sun, 22 Oct 2023 13:12:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkNJYSq0/lLd+0nSdmJm31J7B4r3mkNSq3AAVPho0SEqm8bWrECoEmgczYLxJa5HB12SfRRg==
X-Received: by 2002:a05:6870:9d98:b0:1e9:a8ff:67e3 with SMTP id
 pv24-20020a0568709d9800b001e9a8ff67e3mr9408252oab.4.1698005557310; 
 Sun, 22 Oct 2023 13:12:37 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a0cfe0b000000b0065af657ddf7sm2330515qvr.144.2023.10.22.13.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 13:12:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PATCH RFC 3/7] migration: multifd_send_kick_main()
Date: Sun, 22 Oct 2023 16:12:07 -0400
Message-ID: <20231022201211.452861-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231022201211.452861-1-peterx@redhat.com>
References: <20231022201211.452861-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When a multifd sender thread hit errors, it always needs to kick the main
thread by kicking all the semaphores that it can be waiting upon.

Provide a helper for it and deduplicate the code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 4afdd88602..33fb21d0e4 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -374,6 +374,18 @@ struct {
     MultiFDMethods *ops;
 } *multifd_send_state;
 
+/*
+ * The migration thread can wait on either of the two semaphores.  This
+ * function can be used to kick the main thread out of waiting on either of
+ * them.  Should mostly only be called when something wrong happened with
+ * the current multifd send thread.
+ */
+static void multifd_send_kick_main(MultiFDSendParams *p)
+{
+    qemu_sem_post(&p->sem_sync);
+    qemu_sem_post(&multifd_send_state->channels_ready);
+}
+
 /*
  * How we use multifd_send_state->pages and channel->pages?
  *
@@ -746,8 +758,7 @@ out:
         assert(local_err);
         trace_multifd_send_error(p->id);
         multifd_send_terminate_threads(local_err);
-        qemu_sem_post(&p->sem_sync);
-        qemu_sem_post(&multifd_send_state->channels_ready);
+        multifd_send_kick_main(p);
         error_free(local_err);
     }
 
@@ -787,8 +798,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
      * is not created, and then tell who pay attention to me.
      */
     p->quit = true;
-    qemu_sem_post(&multifd_send_state->channels_ready);
-    qemu_sem_post(&p->sem_sync);
+    multifd_send_kick_main(p);
     error_free(err);
 }
 
@@ -859,8 +869,7 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
 {
      migrate_set_error(migrate_get_current(), err);
      /* Error happen, we need to tell who pay attention to me */
-     qemu_sem_post(&multifd_send_state->channels_ready);
-     qemu_sem_post(&p->sem_sync);
+     multifd_send_kick_main(p);
      /*
       * Although multifd_send_thread is not created, but main migration
       * thread need to judge whether it is running, so we need to mark
-- 
2.41.0



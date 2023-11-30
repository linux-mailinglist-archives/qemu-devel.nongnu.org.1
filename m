Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 301EC7FED16
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 11:42:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8eTt-0006Rc-Lq; Thu, 30 Nov 2023 05:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r8eTq-0006R4-96
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 05:41:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r8eTo-0005iw-8c
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 05:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701340871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcCCTVK1Z87QQ5nNgkuMaXelRZHuKE6tNmJWlhMclKo=;
 b=WuICUDyzUf7b5ytBYDgVeDlJCwnDLo8Of/Um3l4WVO4ILp7FARLz5fd5xM/iGEUMxBlqgG
 T2CQ7mjvaezbRi6ZxWAEeRMx6WSBmbMkilvsZAPmgJiyhAbSfKI+PQMFXtJmIghh5Hx81P
 kYF7wv8dSbO7mfPepp4cy0uOMxPzCho=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-EcaUBrbJMM2i8xHL7G9ciA-1; Thu, 30 Nov 2023 05:41:07 -0500
X-MC-Unique: EcaUBrbJMM2i8xHL7G9ciA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48F3D84AC61;
 Thu, 30 Nov 2023 10:41:07 +0000 (UTC)
Received: from secure.mitica1 (unknown [10.39.195.135])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E6E62026D4C;
 Thu, 30 Nov 2023 10:41:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Subject: [PULL 1/2] migration/multifd: Stop setting p->ioc before connecting
Date: Thu, 30 Nov 2023 11:41:02 +0100
Message-ID: <20231130104103.28672-2-quintela@redhat.com>
In-Reply-To: <20231130104103.28672-1-quintela@redhat.com>
References: <20231130104103.28672-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fabiano Rosas <farosas@suse.de>

This is being shadowed but the assignments at
multifd_channel_connect() and multifd_tls_channel_connect() .

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20231110200241.20679-2-farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/multifd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ec58c58082..409460684f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -883,8 +883,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 
     trace_multifd_new_send_channel_async(p->id);
     if (!qio_task_propagate_error(task, &local_err)) {
-        p->c = ioc;
-        qio_channel_set_delay(p->c, false);
+        qio_channel_set_delay(ioc, false);
         p->running = true;
         if (multifd_channel_connect(p, ioc, &local_err)) {
             return;
-- 
2.43.0



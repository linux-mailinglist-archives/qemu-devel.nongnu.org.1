Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D76E47916DF
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:09:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd895-00028W-Qa; Mon, 04 Sep 2023 07:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd893-00027k-VQ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd88y-0008KP-Uu
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZULp9uURUYZ5vuQM7Zdzo/UPLgc6jaoFcYBHycmZZWM=;
 b=VSlWmIC0I+Huxy3wftbOU2mNfM9ty3TD6ympz4c3rai+uWUsRiAaWvVaFdauAi03xLnKyT
 0mKYjdRA+deAm/NzYyXwiIP2csyra9COdZVmq7kBOh+iMe+SfoKXBpBKX0WrAuyMWIa7VK
 FJryshxOrE2GLHkPyMt5b6QTmHLlJrQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-v4q_fTjCNxaFzYiE6ovBzg-1; Mon, 04 Sep 2023 07:53:22 -0400
X-MC-Unique: v4q_fTjCNxaFzYiE6ovBzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7E82380671E
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:53:22 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B38640C206F;
 Mon,  4 Sep 2023 11:53:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 07/52] ui/console: call dpy_gfx_update() regardless of have_gfx
Date: Mon,  4 Sep 2023 15:52:04 +0400
Message-ID: <20230904115251.4161397-8-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The function will handle the case when no listeners are gfx, without
extra meaningful cost.

This allows to get rid of DisplayState dependency in VC implementation.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-8-marcandre.lureau@redhat.com>
---
 ui/console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index 14717a6f4d..2bc4c153de 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1087,7 +1087,7 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
         console_putchar(s, buf[i]);
     }
     console_show_cursor(s, 1);
-    if (s->ds->have_gfx && s->update_x0 < s->update_x1) {
+    if (s->update_x0 < s->update_x1) {
         dpy_gfx_update(s, s->update_x0, s->update_y0,
                        s->update_x1 - s->update_x0,
                        s->update_y1 - s->update_y0);
-- 
2.41.0



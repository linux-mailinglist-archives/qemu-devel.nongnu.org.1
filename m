Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 746907B691E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:37:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnedG-0006Xw-OH; Tue, 03 Oct 2023 08:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qned6-0006X3-0T
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qned3-0000Dl-Oj
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DtEZxjJVOZxPUVf7ZJtIcJLP0glL+KhvGvzz1Br3Giw=;
 b=HScMv8J6InUITiJ+Q0WTBOti5qWVZT16vId0sXy3J6Bkl0brSsVmbav5myOC1SBWsH93+a
 XWPmNCRqnglszNWhezP0JjqaWAW4pf0fup2lClnZNDUvDN5EbAvwL+4gAe4+KHRnQW21m/
 GwoXFVT7BTDE1A3t+7APOBg33VAZ+M0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-x8MzOt6kNZO0w-tjQqBKkg-1; Tue, 03 Oct 2023 08:35:55 -0400
X-MC-Unique: x8MzOt6kNZO0w-tjQqBKkg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B342811E7B
 for <qemu-devel@nongnu.org>; Tue,  3 Oct 2023 12:35:55 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C35E2156701;
 Tue,  3 Oct 2023 12:35:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 02/13] ui/console: make qemu_console_is_multihead() static
Date: Tue,  3 Oct 2023 16:35:31 +0400
Message-ID: <20231003123543.1360795-3-marcandre.lureau@redhat.com>
In-Reply-To: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
References: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Laszlo Ersek <lersek@redhat.com>

qemu_console_is_multihead() is only called from within "ui/console.c";
make it static.

Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com> (odd fixer:Graphics)
Cc: Gerd Hoffmann <kraxel@redhat.com> (odd fixer:Graphics)
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230913144959.41891-2-lersek@redhat.com>
---
 include/ui/console.h | 1 -
 ui/console.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 28882f15a5..acb61a7f15 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -422,7 +422,6 @@ bool qemu_console_is_visible(QemuConsole *con);
 bool qemu_console_is_graphic(QemuConsole *con);
 bool qemu_console_is_fixedsize(QemuConsole *con);
 bool qemu_console_is_gl_blocked(QemuConsole *con);
-bool qemu_console_is_multihead(DeviceState *dev);
 char *qemu_console_get_label(QemuConsole *con);
 int qemu_console_get_index(QemuConsole *con);
 uint32_t qemu_console_get_head(QemuConsole *con);
diff --git a/ui/console.c b/ui/console.c
index 4a4f19ed33..d17b4ee397 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1434,7 +1434,7 @@ bool qemu_console_is_gl_blocked(QemuConsole *con)
     return con->gl_block;
 }
 
-bool qemu_console_is_multihead(DeviceState *dev)
+static bool qemu_console_is_multihead(DeviceState *dev)
 {
     QemuConsole *con;
     Object *obj;
-- 
2.41.0



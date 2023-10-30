Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 804CB7DB88A
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 11:50:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxPpW-0002hq-H3; Mon, 30 Oct 2023 06:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qxPpN-0002VW-IQ
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qxPpL-0002cs-Qd
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 06:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698662938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OF57uTjyyH4Nb4VhTNI4KzssnPCjcAVOb7bSOaBnuvo=;
 b=dl/8eAmnu53LNWGaFrg895Q/7BQnzxwNOU3mNZTbmFfFMw87rkDco0ERIP8XZBSEuGEb3J
 3duZ6dX1ib5LFZ6IhKHOYNWaF5AtU12eUXE2YqWRpz5HC1tUyCubuHBp/gNVR2upjPzdih
 6VmjfITW5qPlRVzKVEyxPtr1hnaIo6s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-EerqOkbTO_CkQ5poJROsWA-1; Mon, 30 Oct 2023 06:48:54 -0400
X-MC-Unique: EerqOkbTO_CkQ5poJROsWA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C494811E7E;
 Mon, 30 Oct 2023 10:48:54 +0000 (UTC)
Received: from localhost (unknown [10.39.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FA81492BFC;
 Mon, 30 Oct 2023 10:48:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v7 11/23] qmp/hmp: disable screendump if PIXMAN is missing
Date: Mon, 30 Oct 2023 14:47:42 +0400
Message-ID: <20231030104755.124188-12-marcandre.lureau@redhat.com>
In-Reply-To: <20231030104755.124188-1-marcandre.lureau@redhat.com>
References: <20231030104755.124188-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The command requires color conversion and line-by-line feeding. We could
have a simple fallback for simple formats though.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 qapi/ui.json     | 3 ++-
 ui/ui-hmp-cmds.c | 2 ++
 ui/ui-qmp-cmds.c | 2 ++
 hmp-commands.hx  | 2 ++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 006616aa77..e74cc3efb6 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -200,7 +200,8 @@
 { 'command': 'screendump',
   'data': {'filename': 'str', '*device': 'str', '*head': 'int',
            '*format': 'ImageFormat'},
-  'coroutine': true }
+  'coroutine': true,
+  'if': 'CONFIG_PIXMAN' }
 
 ##
 # == Spice
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index c671389473..26c8ced1f2 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -437,6 +437,7 @@ void sendkey_completion(ReadLineState *rs, int nb_args, const char *str)
     }
 }
 
+#ifdef CONFIG_PIXMAN
 void coroutine_fn
 hmp_screendump(Monitor *mon, const QDict *qdict)
 {
@@ -458,6 +459,7 @@ hmp_screendump(Monitor *mon, const QDict *qdict)
 end:
     hmp_handle_error(mon, err);
 }
+#endif
 
 void hmp_client_migrate_info(Monitor *mon, const QDict *qdict)
 {
diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index debc07d678..d772e1cb7f 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -212,6 +212,7 @@ void qmp_client_migrate_info(const char *protocol, const char *hostname,
     error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "protocol", "'spice'");
 }
 
+#ifdef CONFIG_PIXMAN
 #ifdef CONFIG_PNG
 /**
  * png_save: Take a screenshot as PNG
@@ -391,3 +392,4 @@ qmp_screendump(const char *filename, const char *device,
         }
     }
 }
+#endif /* CONFIG_PIXMAN */
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 63eac22734..c343d82fbc 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -252,6 +252,7 @@ SRST
 
 ERST
 
+#ifdef CONFIG_PIXMAN
     {
         .name       = "screendump",
         .args_type  = "filename:F,format:-fs,device:s?,head:i?",
@@ -267,6 +268,7 @@ SRST
 ``screendump`` *filename*
   Save screen into PPM image *filename*.
 ERST
+#endif
 
     {
         .name       = "logfile",
-- 
2.41.0



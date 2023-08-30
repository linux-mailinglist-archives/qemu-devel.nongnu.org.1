Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C517C78D4E6
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:47:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHiu-0004EV-KM; Wed, 30 Aug 2023 05:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHib-0003vA-Pz
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHiZ-0001ku-8g
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chWSO6X8vyK4o0XUVN0AJ+0L1O/tB3GJG5P1z2/f7Qs=;
 b=HzrgT7OWzQnpzwSFBXp93MuTN9L78zmkpe9FgSz/nu2S8WLjiidVg+HD9trbzezqx3Gur+
 yLM66U3UIorK7V1R94YAmVveEDl/uZEtDgQ/cBz7QOO3bWUsYXUuCbuExxruIYJeicL1Xh
 EFJWGPpAVf8NlRdA5QlF7eZ0fXEqv8U=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-690-l_-YZW8FObykq8eBPPNV0A-1; Wed, 30 Aug 2023 05:42:27 -0400
X-MC-Unique: l_-YZW8FObykq8eBPPNV0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D1581C07822;
 Wed, 30 Aug 2023 09:42:27 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAD2B40C6F4C;
 Wed, 30 Aug 2023 09:42:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 55/67] qmp/hmp: disable screendump if PIXMAN is missing
Date: Wed, 30 Aug 2023 13:38:29 +0400
Message-ID: <20230830093843.3531473-56-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

The command requires color conversion and line-by-line feeding. We could
have a simple fallback for simple formats though.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index 2cbd0f77a0..bfb2e2d5e2 100644
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



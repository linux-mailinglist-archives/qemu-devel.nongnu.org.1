Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A807D7406
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjFX-0004lY-3w; Wed, 25 Oct 2023 15:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvjFS-0004kA-35
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvjFQ-0000LK-3x
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698260935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=523l5CFDQhMe/8iz9cuQcGu7DmK05F4Kg7km6pZrlLc=;
 b=KSbRVw5aAwNoQyPP91dCH1tEzDx8LnWtc646xV6WJk0IMCZfetis8aBojOX+Je/cEr4g6Q
 LNlUpZMgIzV01Pu4Nh1CtnXWNE5oXk+PunaupPaqUdjH5sgWVHccxLdof/tjENFOuGxKXD
 DiQXVqhs4p0vEnST9HFYxaCe/9SU9tU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-rPE0f_bOMY61CP-97BgJKg-1; Wed,
 25 Oct 2023 15:08:49 -0400
X-MC-Unique: rPE0f_bOMY61CP-97BgJKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEBA738062AC;
 Wed, 25 Oct 2023 19:08:48 +0000 (UTC)
Received: from localhost (unknown [10.39.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84E552166B26;
 Wed, 25 Oct 2023 19:08:47 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 06/23] qemu-options: define -vnc only #ifdef CONFIG_VNC
Date: Wed, 25 Oct 2023 23:08:00 +0400
Message-ID: <20231025190818.3278423-7-marcandre.lureau@redhat.com>
In-Reply-To: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
References: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c     | 13 +++++++++----
 ui/vnc-stubs.c  | 12 ------------
 qemu-options.hx |  2 ++
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 3be1a78a9d..de6df188da 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1095,13 +1095,14 @@ DisplayOptions *qmp_query_display_options(Error **errp)
 
 static void parse_display(const char *p)
 {
-    const char *opts;
-
     if (is_help_option(p)) {
         qemu_display_help();
         exit(0);
     }
 
+#ifdef CONFIG_VNC
+    const char *opts;
+
     if (strstart(p, "vnc", &opts)) {
         /*
          * vnc isn't a (local) DisplayType but a protocol for remote
@@ -1113,9 +1114,11 @@ static void parse_display(const char *p)
             error_report("VNC requires a display argument vnc=<display>");
             exit(1);
         }
-    } else {
-        parse_display_qapi(p);
+        return;
     }
+#endif
+
+    parse_display_qapi(p);
 }
 
 static inline bool nonempty_str(const char *str)
@@ -3344,9 +3347,11 @@ void qemu_init(int argc, char **argv)
                 machine_parse_property_opt(qemu_find_opts("smp-opts"),
                                            "smp", optarg);
                 break;
+#ifdef CONFIG_VNC
             case QEMU_OPTION_vnc:
                 vnc_parse(optarg);
                 break;
+#endif
             case QEMU_OPTION_no_acpi:
                 warn_report("-no-acpi is deprecated, use '-machine acpi=off' instead");
                 qdict_put_str(machine_opts_dict, "acpi", "off");
diff --git a/ui/vnc-stubs.c b/ui/vnc-stubs.c
index b4eb3ce718..a96bc86236 100644
--- a/ui/vnc-stubs.c
+++ b/ui/vnc-stubs.c
@@ -10,15 +10,3 @@ int vnc_display_pw_expire(const char *id, time_t expires)
 {
     return -ENODEV;
 };
-void vnc_parse(const char *str)
-{
-    if (strcmp(str, "none") == 0) {
-        return;
-    }
-    error_setg(&error_fatal, "VNC support is disabled");
-}
-int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
-{
-    error_setg(errp, "VNC support is disabled");
-    return -1;
-}
diff --git a/qemu-options.hx b/qemu-options.hx
index e26230bac5..edc8ca6e30 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2424,8 +2424,10 @@ SRST
     OBP.
 ERST
 
+#ifdef CONFIG_VNC
 DEF("vnc", HAS_ARG, QEMU_OPTION_vnc ,
     "-vnc <display>  shorthand for -display vnc=<display>\n", QEMU_ARCH_ALL)
+#endif
 SRST
 ``-vnc display[,option[,option[,...]]]``
     Normally, if QEMU is compiled with graphical window support, it
-- 
2.41.0



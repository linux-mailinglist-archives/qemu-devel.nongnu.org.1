Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 306597E1DA1
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:56:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzwL9-0006Cm-C7; Mon, 06 Nov 2023 04:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzwL8-0006Cd-8w
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:56:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzwL6-0008OK-Mn
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699264572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IX1Ru8tgVxYqEZYqMU0WhGMD54ZY3eu7+DSfIUlkMbI=;
 b=WV9EEQFRl2mrlIfETz2A9//7G5o10GoJskqiSN0uqYM5123S5wnEvHHigVYwgQUn/4PFO8
 zx64e0mlo5xTbDw1XoRb2xNFMunFShyQMxCUYHgkYgLdDnAM7ceJG3P3VvGbmKYVGp0r5x
 H4WC05h8bnFZmWwo3je7cPhxDUYciNs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-VtPft6RLNeWsKkN08Btd_Q-1; Mon, 06 Nov 2023 04:56:10 -0500
X-MC-Unique: VtPft6RLNeWsKkN08Btd_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C14483BA88;
 Mon,  6 Nov 2023 09:56:10 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EC002166B26;
 Mon,  6 Nov 2023 09:56:09 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 06/24] qemu-options: define -vnc only #ifdef CONFIG_VNC
Date: Mon,  6 Nov 2023 13:55:23 +0400
Message-ID: <20231106095542.1852973-7-marcandre.lureau@redhat.com>
In-Reply-To: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
References: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 system/vl.c     | 13 +++++++++----
 ui/vnc-stubs.c  | 12 ------------
 qemu-options.hx |  2 ++
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index fb0389e4d0..19aef762e4 100644
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



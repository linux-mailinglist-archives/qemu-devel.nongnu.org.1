Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5637E35B8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 08:20:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0GNS-0007wh-7n; Tue, 07 Nov 2023 02:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0GNQ-0007wS-Sn
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:19:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0GNP-0002gm-Ab
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699341594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M54gQLSG4hl5cyIhNJVcqh5G5aW09v6yaGtld5kgbuA=;
 b=EAc/VOaPseVhwTr3IptPSh5cyGQ8hx7W0kLyCcVLkHY+KFBeimfot7s0W+CEr3+S7/cEKp
 MWzOnmD+qn+opgENPrMA4mrnlgOrHG8jWAXndvqWYpSxibimolrxYhOEY0lVI7xyxGcvPE
 WtAUzRb4+sgbXHvu8wuE8o3J7EuL+Og=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-JN6wmPKwOBevixMbG7nTmQ-1; Tue,
 07 Nov 2023 02:19:47 -0500
X-MC-Unique: JN6wmPKwOBevixMbG7nTmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEFD93C10427;
 Tue,  7 Nov 2023 07:19:46 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCE6F40C6EB9;
 Tue,  7 Nov 2023 07:19:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 stefanha@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v8 06/24] qemu-options: define -vnc only #ifdef CONFIG_VNC
Date: Tue,  7 Nov 2023 11:18:56 +0400
Message-ID: <20231107071915.2459115-7-marcandre.lureau@redhat.com>
In-Reply-To: <20231107071915.2459115-1-marcandre.lureau@redhat.com>
References: <20231107071915.2459115-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 7809036d8c..5b6d16ed58 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2428,8 +2428,10 @@ SRST
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A05B0520E
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 08:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZMe-00038V-E9; Tue, 15 Jul 2025 02:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubZEa-00037v-QD
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:33:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubZEY-0003fz-Uw
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752561226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNyD+uj7UBvMq6QcPJobSQ1qYoFoeus0kbmfWveaUS0=;
 b=PoNa3XYB6VzHhDWnc0nfa83Xlx4hyWiB7md7RoPHTDrM+VnnqyHclrThrK2AzHZDYP/BNy
 TMt/+c5VLJsJfJ9mpCeFeB2icjWQeH52t87Kh9V9ocFsfxcz+71JcxNb8I2Ftre4RbEMPP
 jobNKoDfzm4W1FeljlJrcjGG4aTbne8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-OWfWCeNkO_W4KyHG2NgFQg-1; Tue,
 15 Jul 2025 02:33:42 -0400
X-MC-Unique: OWfWCeNkO_W4KyHG2NgFQg-1
X-Mimecast-MFC-AGG-ID: OWfWCeNkO_W4KyHG2NgFQg_1752561221
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21C20195609F; Tue, 15 Jul 2025 06:33:41 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5F9E1977000; Tue, 15 Jul 2025 06:33:39 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL v2 05/13] ui/spice: Add an option for users to provide a
 preferred video codec
Date: Tue, 15 Jul 2025 10:32:51 +0400
Message-ID: <20250715063301.145191-6-marcandre.lureau@redhat.com>
In-Reply-To: <20250715063301.145191-1-marcandre.lureau@redhat.com>
References: <20250715063301.145191-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Vivek Kasireddy <vivek.kasireddy@intel.com>

Giving users an option to choose a particular codec will enable
them to make an appropriate decision based on their hardware and
use-case. Note that, the Spice server would use this codec with
Gstreamer encoder and only when gl=on is specified.

If no codec is provided, then the codec gstreamer:h264 would be used
as default. And, for the case where gl=off, the default codec to be
used is determined by the Spice server.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Cc: Daniel P. Berrangé <berrange@redhat.com>
[ Marc-Andre - fix unused variables warnings ]
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Message-Id: <20250617043546.1022779-4-vivek.kasireddy@intel.com>
---
 ui/spice-core.c | 16 ++++++++++++++++
 qemu-options.hx |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 5acbdd3955..51bdcef1af 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -488,6 +488,9 @@ static QemuOptsList qemu_spice_opts = {
         },{
             .name = "streaming-video",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "video-codec",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "agent-mouse",
             .type = QEMU_OPT_BOOL,
@@ -837,7 +840,20 @@ static void qemu_spice_init(void)
     if (qemu_opt_get_bool(opts, "gl", 0)) {
         if ((port != 0) || (tls_port != 0)) {
 #if SPICE_SERVER_VERSION >= 0x000f03 /* release 0.15.3 */
+            const char *video_codec = NULL;
+            g_autofree char *enc_codec = NULL;
+
             spice_remote_client = 1;
+
+            video_codec = qemu_opt_get(opts, "video-codec");
+            if (video_codec) {
+                enc_codec = g_strconcat("gstreamer:", video_codec, NULL);
+            }
+            if (spice_server_set_video_codecs(spice_server,
+                                              enc_codec ?: "gstreamer:h264")) {
+                error_report("invalid video codec");
+                exit(1);
+            }
 #else
             error_report("SPICE GL support is local-only for now and "
                          "incompatible with -spice port/tls-port");
diff --git a/qemu-options.hx b/qemu-options.hx
index 1f862b19a6..8f6a228a89 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2281,6 +2281,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
     "       [,streaming-video=[off|all|filter]][,disable-copy-paste=on|off]\n"
     "       [,disable-agent-file-xfer=on|off][,agent-mouse=[on|off]]\n"
     "       [,playback-compression=[on|off]][,seamless-migration=[on|off]]\n"
+    "       [,video-codec=<codec>\n"
     "       [,gl=[on|off]][,rendernode=<file>]\n"
     "                enable spice\n"
     "                at least one of {port, tls-port} is mandatory\n",
@@ -2369,6 +2370,13 @@ SRST
     ``seamless-migration=[on|off]``
         Enable/disable spice seamless migration. Default is off.
 
+    ``video-codec=<codec>``
+        Provide the preferred codec the Spice server should use with the
+        Gstreamer encoder. This option is only relevant when gl=on is
+        specified. If no codec is provided, then the codec gstreamer:h264
+        would be used as default. And, for the case where gl=off, the
+        default codec to be used is determined by the Spice server.
+
     ``gl=[on|off]``
         Enable/disable OpenGL context. Default is off.
 
-- 
2.50.0



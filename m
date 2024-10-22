Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B90DF9AB1FD
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Oct 2024 17:26:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Gkl-00089s-VS; Tue, 22 Oct 2024 11:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3Gki-000840-HO
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3Gkg-00051o-Sh
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729610694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OsVg9LKAx4ynICHdhBCnNQId5jUOMnNKGUPWtgNz6/Q=;
 b=HABNq4uGo/VJMDbiGR2NNPGlAMoVfdW7rziCwT4Kl08ndo2ImaatEP5mQArWgxfYTpAnr1
 dKdRcp1f0mLq7pNsNtCynpqLMtmwbSQAYIJgDGEVHENW8nmByvJ0fa0PMiDxRjw0WYaDE2
 bR4JTfHEFHH6nBeaUVdh4RpBlCPrG3g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-CXrmnBCaNeW1lhg5fLeJJA-1; Tue,
 22 Oct 2024 11:24:48 -0400
X-MC-Unique: CXrmnBCaNeW1lhg5fLeJJA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5EAD195421E; Tue, 22 Oct 2024 15:24:47 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA3C51955F39; Tue, 22 Oct 2024 15:24:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 10/14] ui/vnc: fix skipping SASL SSF on UNIX sockets
Date: Tue, 22 Oct 2024 16:24:11 +0100
Message-ID: <20241022152415.1632556-11-berrange@redhat.com>
In-Reply-To: <20241022152415.1632556-1-berrange@redhat.com>
References: <20241022152415.1632556-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The 'is_unix' flag is set on the VNC server during startup, however,
a regression in:

  commit 8bd22f477f68bbd7a9c88e926e7a58bf65605e39
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Fri Feb 3 12:06:46 2017 +0000

    ui: extract code to connect/listen from vnc_display_open

meant we stopped setting the 'is_unix' flag when QEMU listens for
VNC sockets, only setting when QEMU does a reverse VNC connection.

Rather than fixing setting of the 'is_unix' flag, remove it, and
directly check the live client socket address. This is more robust
to a possible situation where the VNC server was listening on a
mixture of INET and UNIX sockets.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc-auth-sasl.c | 14 +++++++++++---
 ui/vnc.c           |  3 ---
 ui/vnc.h           |  1 -
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index edf19deb3b..43515447fb 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -551,6 +551,13 @@ vnc_socket_ip_addr_string(QIOChannelSocket *ioc,
     return 0;
 }
 
+static bool
+vnc_socket_is_unix(QIOChannelSocket *ioc)
+{
+    SocketAddress *addr = qio_channel_socket_get_local_address(ioc, NULL);
+    return addr && addr->type == SOCKET_ADDRESS_TYPE_UNIX;
+}
+
 void start_auth_sasl(VncState *vs)
 {
     const char *mechlist = NULL;
@@ -627,10 +634,11 @@ void start_auth_sasl(VncState *vs)
     memset (&secprops, 0, sizeof secprops);
     /* Inform SASL that we've got an external SSF layer from TLS.
      *
-     * Disable SSF, if using TLS+x509+SASL only. TLS without x509
-     * is not sufficiently strong
+     * Disable SSF, if using TLS+x509+SASL only, or UNIX sockets.
+     * TLS without x509 is not sufficiently strong, nor is plain
+     * TCP
      */
-    if (vs->vd->is_unix ||
+    if (vnc_socket_is_unix(vs->sioc) ||
         (vs->auth == VNC_AUTH_VENCRYPT &&
          vs->subauth == VNC_AUTH_VENCRYPT_X509SASL)) {
         /* If we've got TLS or UNIX domain sock, we don't care about SSF */
diff --git a/ui/vnc.c b/ui/vnc.c
index 93a8dbd253..5fcb35bf25 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3430,7 +3430,6 @@ static void vnc_display_close(VncDisplay *vd)
     if (!vd) {
         return;
     }
-    vd->is_unix = false;
 
     if (vd->listener) {
         qio_net_listener_disconnect(vd->listener);
@@ -3932,8 +3931,6 @@ static int vnc_display_connect(VncDisplay *vd,
         error_setg(errp, "Expected a single address in reverse mode");
         return -1;
     }
-    /* TODO SOCKET_ADDRESS_TYPE_FD when fd has AF_UNIX */
-    vd->is_unix = saddr_list->value->type == SOCKET_ADDRESS_TYPE_UNIX;
     sioc = qio_channel_socket_new();
     qio_channel_set_name(QIO_CHANNEL(sioc), "vnc-reverse");
     if (qio_channel_socket_connect_sync(sioc, saddr_list->value, errp) < 0) {
diff --git a/ui/vnc.h b/ui/vnc.h
index e5fa2efa3e..acc53a2cc1 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -168,7 +168,6 @@ struct VncDisplay
 
     const char *id;
     QTAILQ_ENTRY(VncDisplay) next;
-    bool is_unix;
     char *password;
     time_t expires;
     int auth;
-- 
2.46.0



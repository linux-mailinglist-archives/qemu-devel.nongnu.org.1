Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7CEA2668E
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 23:28:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf4uo-0001ak-H5; Mon, 03 Feb 2025 17:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tf4um-0001a9-F1
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tf4uk-0002KF-Rm
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738621654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5PPLbPnvn/o8UsoNFBQa96u/qIfp1WNk3jNRu4z5OHw=;
 b=b2m6gMNPBcwaSWGtCggZtPhYLe5pzfAUNENp20iONpJr/JCZIWIjTLBxgJAXotarSW5HXE
 1RW1MvHk4X64UVFqensLT6eL8usy+UtgWF/bq4E49WNcQPlE0kZa2uWCp8PH0WEijmPLU5
 RVkJd/0t529BSRds1hIUjhh6K+lu5w0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-2rsSlNxdOXaRAjbfm-2YEg-1; Mon,
 03 Feb 2025 17:27:30 -0500
X-MC-Unique: 2rsSlNxdOXaRAjbfm-2YEg-1
X-Mimecast-MFC-AGG-ID: 2rsSlNxdOXaRAjbfm-2YEg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A43E51801F24; Mon,  3 Feb 2025 22:27:28 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.73])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7269F19560AD; Mon,  3 Feb 2025 22:27:27 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 1/2] qemu-nbd: Allow users to adjust handshake limit
Date: Mon,  3 Feb 2025 16:26:06 -0600
Message-ID: <20250203222722.650694-5-eblake@redhat.com>
In-Reply-To: <20250203222722.650694-4-eblake@redhat.com>
References: <20250203222722.650694-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Although defaulting the handshake limit to 10 seconds was a nice QoI
change to weed out intentionally slow clients, it can interfere with
integration testing done with manual NBD_OPT commands over 'nbdsh
--opt-mode'.  Expose a command line option to allow the user to alter
the timeout away from the default.  This option is unlikely to be used
in enough scenarios to warrant a short option letter.

The option --handshake-limit intentionally differs from the name of
the constant added in commit fb1c2aaa98 (limit instead of max_secs)
and the QMP name to be added in the next commit; this is because
typing a longer command-line name is undesirable and there is
sufficient --help text to document the units.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/tools/qemu-nbd.rst |  5 +++++
 qemu-nbd.c              | 41 ++++++++++++++++++++++++++---------------
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/docs/tools/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
index 4f21b7904ac..f82ea5fd77b 100644
--- a/docs/tools/qemu-nbd.rst
+++ b/docs/tools/qemu-nbd.rst
@@ -156,6 +156,11 @@ driver options if :option:`--image-opts` is specified.
   Set the NBD volume export description, as a human-readable
   string.

+.. option:: --handshake-limit=N
+
+  Set the timeout for a client to successfully complete its handshake
+  to N seconds (default 10), or 0 for no limit.
+
 .. option:: -L, --list

   Connect as a client and list all details about the exports exposed by
diff --git a/qemu-nbd.c b/qemu-nbd.c
index e7a961a5562..2eb32bc700c 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -57,19 +57,20 @@
 #define HAVE_NBD_DEVICE 0
 #endif

-#define SOCKET_PATH                "/var/lock/qemu-nbd-%s"
-#define QEMU_NBD_OPT_CACHE         256
-#define QEMU_NBD_OPT_AIO           257
-#define QEMU_NBD_OPT_DISCARD       258
-#define QEMU_NBD_OPT_DETECT_ZEROES 259
-#define QEMU_NBD_OPT_OBJECT        260
-#define QEMU_NBD_OPT_TLSCREDS      261
-#define QEMU_NBD_OPT_IMAGE_OPTS    262
-#define QEMU_NBD_OPT_FORK          263
-#define QEMU_NBD_OPT_TLSAUTHZ      264
-#define QEMU_NBD_OPT_PID_FILE      265
-#define QEMU_NBD_OPT_SELINUX_LABEL 266
-#define QEMU_NBD_OPT_TLSHOSTNAME   267
+#define SOCKET_PATH                  "/var/lock/qemu-nbd-%s"
+#define QEMU_NBD_OPT_CACHE           256
+#define QEMU_NBD_OPT_AIO             257
+#define QEMU_NBD_OPT_DISCARD         258
+#define QEMU_NBD_OPT_DETECT_ZEROES   259
+#define QEMU_NBD_OPT_OBJECT          260
+#define QEMU_NBD_OPT_TLSCREDS        261
+#define QEMU_NBD_OPT_IMAGE_OPTS      262
+#define QEMU_NBD_OPT_FORK            263
+#define QEMU_NBD_OPT_TLSAUTHZ        264
+#define QEMU_NBD_OPT_PID_FILE        265
+#define QEMU_NBD_OPT_SELINUX_LABEL   266
+#define QEMU_NBD_OPT_TLSHOSTNAME     267
+#define QEMU_NBD_OPT_HANDSHAKE_LIMIT 268

 #define MBR_SIZE 512

@@ -80,6 +81,7 @@ static int nb_fds;
 static QIONetListener *server;
 static QCryptoTLSCreds *tlscreds;
 static const char *tlsauthz;
+static int handshake_limit = NBD_DEFAULT_HANDSHAKE_MAX_SECS;

 static void usage(const char *name)
 {
@@ -101,6 +103,7 @@ static void usage(const char *name)
 "  -v, --verbose             display extra debugging information\n"
 "  -x, --export-name=NAME    expose export by name (default is empty string)\n"
 "  -D, --description=TEXT    export a human-readable description\n"
+"      --handshake-limit=N   limit client's handshake to N seconds (default 10)\n"
 "\n"
 "Exposing part of the image:\n"
 "  -o, --offset=OFFSET       offset into the image\n"
@@ -390,8 +393,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,

     nb_fds++;
     nbd_update_server_watch();
-    /* TODO - expose handshake timeout as command line option */
-    nbd_client_new(cioc, NBD_DEFAULT_HANDSHAKE_MAX_SECS,
+    nbd_client_new(cioc, handshake_limit,
                    tlscreds, tlsauthz, nbd_client_closed, NULL);
 }

@@ -569,6 +571,8 @@ int main(int argc, char **argv)
         { "object", required_argument, NULL, QEMU_NBD_OPT_OBJECT },
         { "export-name", required_argument, NULL, 'x' },
         { "description", required_argument, NULL, 'D' },
+        { "handshake-limit", required_argument, NULL,
+          QEMU_NBD_OPT_HANDSHAKE_LIMIT },
         { "tls-creds", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
         { "tls-hostname", required_argument, NULL, QEMU_NBD_OPT_TLSHOSTNAME },
         { "tls-authz", required_argument, NULL, QEMU_NBD_OPT_TLSAUTHZ },
@@ -815,6 +819,13 @@ int main(int argc, char **argv)
         case QEMU_NBD_OPT_SELINUX_LABEL:
             selinux_label = optarg;
             break;
+        case QEMU_NBD_OPT_HANDSHAKE_LIMIT:
+            if (qemu_strtoi(optarg, NULL, 0, &handshake_limit) < 0 ||
+                handshake_limit < 0) {
+                error_report("Invalid handshake limit '%s'", optarg);
+                exit(EXIT_FAILURE);
+            }
+            break;
         }
     }

-- 
2.48.1



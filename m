Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAB7B4FE51
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Sep 2025 15:56:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvym1-0000qn-Sh; Tue, 09 Sep 2025 09:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvylX-0000jG-BS
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvylQ-0005Ea-2Y
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757425922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BENAf1qfrvCW0Si6gdrn46mToEtpgfMW8Mt+POWA6i4=;
 b=JY+YNMLSwXBA2LHAl7e7ayiJizFJ5KcbPyxQ7Tmnjdx0nGhZGxf2TtWhNQ9XqTA3mNP60I
 ZVkz90ZjAStJnaalxHQ9OEu28tcsA4cXTkkCXpxqlu7dCBiBXQspmyA/QDMAMnaF0TStxO
 OJQovO9Udz+NevLIBK6FKksQxcj4ESw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-fciiJx_2Ozir6Xa6NVT87A-1; Tue,
 09 Sep 2025 09:52:01 -0400
X-MC-Unique: fciiJx_2Ozir6Xa6NVT87A-1
X-Mimecast-MFC-AGG-ID: fciiJx_2Ozir6Xa6NVT87A_1757425920
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64A39195608A; Tue,  9 Sep 2025 13:52:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3B4C18003FC; Tue,  9 Sep 2025 13:51:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 05/23] ui/vnc: Fix crash when specifying [vnc] without id in
 the config file
Date: Tue,  9 Sep 2025 15:51:29 +0200
Message-ID: <20250909135147.612345-6-thuth@redhat.com>
In-Reply-To: <20250909135147.612345-1-thuth@redhat.com>
References: <20250909135147.612345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently crashes when there is a [vnc] section in the config
file that does not have an "id = ..." line:

 $ echo "[vnc]" > /tmp/qemu.conf
 $ ./qemu-system-x86_64 -readconfig /tmp/qemu.conf
 qemu-system-x86_64: ../../devel/qemu/ui/vnc.c:4347: vnc_init_func:
  Assertion `id' failed.
 Aborted (core dumped)

The required "id" is only set up automatically while parsing the command
line, but not when reading the options from the config file.
Thus let's move code that automatically adds the id (if it does not
exist yet) to the init function that needs the id for the first time,
replacing the assert() statement there.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2836
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250821145130.845104-1-thuth@redhat.com>
---
 ui/vnc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 68ca4a68e7a..9054fc81253 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4309,8 +4309,9 @@ void vnc_display_add_client(const char *id, int csock, bool skipauth)
     }
 }
 
-static void vnc_auto_assign_id(QemuOptsList *olist, QemuOpts *opts)
+static char *vnc_auto_assign_id(QemuOpts *opts)
 {
+    QemuOptsList *olist = qemu_find_opts("vnc");
     int i = 2;
     char *id;
 
@@ -4320,23 +4321,18 @@ static void vnc_auto_assign_id(QemuOptsList *olist, QemuOpts *opts)
         id = g_strdup_printf("vnc%d", i++);
     }
     qemu_opts_set_id(opts, id);
+
+    return id;
 }
 
 void vnc_parse(const char *str)
 {
     QemuOptsList *olist = qemu_find_opts("vnc");
     QemuOpts *opts = qemu_opts_parse_noisily(olist, str, !is_help_option(str));
-    const char *id;
 
     if (!opts) {
         exit(1);
     }
-
-    id = qemu_opts_id(opts);
-    if (!id) {
-        /* auto-assign id if not present */
-        vnc_auto_assign_id(olist, opts);
-    }
 }
 
 int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
@@ -4344,7 +4340,11 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
     Error *local_err = NULL;
     char *id = (char *)qemu_opts_id(opts);
 
-    assert(id);
+    if (!id) {
+        /* auto-assign id if not present */
+        id = vnc_auto_assign_id(opts);
+    }
+
     vnc_display_init(id, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.51.0



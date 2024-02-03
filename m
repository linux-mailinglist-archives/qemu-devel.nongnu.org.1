Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2E5848476
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Feb 2024 09:03:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWAz5-0003as-SM; Sat, 03 Feb 2024 03:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWAz3-0003a8-3L
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:02:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWAz0-00081N-Qk
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706947357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xSzUmRyT+qwqIWg/3Aoa3SJhsF3PyTfkmawV/Z8HWCU=;
 b=h7kmvtB6CU2jhcuZzT2Ows0YxyUvkFjtz6dV3iqi/l7pjEsOBpBKSshFq+CBZ3KGjjrbK/
 AMozoXxWAIsKugzKAnu/nWoQJRESNMl543jZYTcPxY+eTj/dSLFFmd09La3fqfn+26nJO+
 Dh1i/zfAbuKjUx7BlXtobkLrlgQxSpE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-c4-zetiqNESawtyFtvb1GA-1; Sat,
 03 Feb 2024 03:02:34 -0500
X-MC-Unique: c4-zetiqNESawtyFtvb1GA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECAA41C05ACD;
 Sat,  3 Feb 2024 08:02:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9DE251D5;
 Sat,  3 Feb 2024 08:02:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C793621E66F6; Sat,  3 Feb 2024 09:02:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com
Subject: [PATCH 3/4] qapi/char: Make backend types properly conditional
Date: Sat,  3 Feb 2024 09:02:27 +0100
Message-ID: <20240203080228.2766159-4-armbru@redhat.com>
In-Reply-To: <20240203080228.2766159-1-armbru@redhat.com>
References: <20240203080228.2766159-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Character backends are actually QOM types.  When a backend's
compile-time conditional QOM type is not compiled in, creation fails
with "'FOO' is not a valid char driver name".  Okay, except
introspecting chardev-add with query-qmp-schema doesn't work then: the
backend type is there even though the QOM type isn't.

A management application can work around this issue by using
qom-list-types instead.

Fix the issue anyway: add the conditionals to the QAPI schema.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/char.json | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index 6c6ad3b10c..2d74e66746 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -472,8 +472,8 @@
 ##
 { 'enum': 'ChardevBackendKind',
   'data': [ 'file',
-            'serial',
-            'parallel',
+            { 'name': 'serial', 'if': 'HAVE_CHARDEV_SERIAL' },
+            { 'name': 'parallel', 'if': 'HAVE_CHARDEV_PARALLEL' },
             'pipe',
             'socket',
             'udp',
@@ -482,10 +482,10 @@
             'mux',
             'msmouse',
             'wctablet',
-            'braille',
+            { 'name': 'braille', 'if': 'CONFIG_BRLAPI' },
             'testdev',
             'stdio',
-            'console',
+            { 'name': 'console', 'if': 'CONFIG_WIN32' },
             { 'name': 'spicevmc', 'if': 'CONFIG_SPICE' },
             { 'name': 'spiceport', 'if': 'CONFIG_SPICE' },
             { 'name': 'qemu-vdagent', 'if': 'CONFIG_SPICE_PROTOCOL' },
@@ -614,8 +614,10 @@
   'base': { 'type': 'ChardevBackendKind' },
   'discriminator': 'type',
   'data': { 'file': 'ChardevFileWrapper',
-            'serial': 'ChardevHostdevWrapper',
-            'parallel': 'ChardevHostdevWrapper',
+            'serial': { 'type': 'ChardevHostdevWrapper',
+                        'if': 'HAVE_CHARDEV_SERIAL' },
+            'parallel': { 'type': 'ChardevHostdevWrapper',
+                          'if': 'HAVE_CHARDEV_PARALLEL' },
             'pipe': 'ChardevHostdevWrapper',
             'socket': 'ChardevSocketWrapper',
             'udp': 'ChardevUdpWrapper',
@@ -624,10 +626,12 @@
             'mux': 'ChardevMuxWrapper',
             'msmouse': 'ChardevCommonWrapper',
             'wctablet': 'ChardevCommonWrapper',
-            'braille': 'ChardevCommonWrapper',
+            'braille': { 'type': 'ChardevCommonWrapper',
+                         'if': 'CONFIG_BRLAPI' },
             'testdev': 'ChardevCommonWrapper',
             'stdio': 'ChardevStdioWrapper',
-            'console': 'ChardevCommonWrapper',
+            'console': { 'type': 'ChardevCommonWrapper',
+                         'if': 'CONFIG_WIN32' },
             'spicevmc': { 'type': 'ChardevSpiceChannelWrapper',
                           'if': 'CONFIG_SPICE' },
             'spiceport': { 'type': 'ChardevSpicePortWrapper',
-- 
2.43.0



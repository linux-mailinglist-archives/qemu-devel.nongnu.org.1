Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A99498CDF0
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Oct 2024 09:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svu1w-0006pJ-6N; Wed, 02 Oct 2024 03:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svu1t-0006nt-Qb
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svu1r-0008OQ-TY
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 03:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727855051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XhTwsk5bH554T+RvcRjXa11m2S/y9I12RihPOE1Qctk=;
 b=PPInhrGWtAsDK7UgVMxW+uOSfB3a4TmmOY+swaGsbSm1dy67GZ1LCRb+jDgEdEIKJ5ccUb
 Yr3BbdKKWjCMx/dmebAJ328QBqQliDXLfsQDhRE4zChfzuwWRu5rOcP+MRcB0AtUWTI7lb
 kdkmSvGFMw0IN9BLoMnmynk8aseDbSs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-TJaY_KQxMs-1_ds3DMc7Yw-1; Wed,
 02 Oct 2024 03:44:09 -0400
X-MC-Unique: TJaY_KQxMs-1_ds3DMc7Yw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67F781955F41; Wed,  2 Oct 2024 07:44:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B50411956054; Wed,  2 Oct 2024 07:44:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D51E721E691E; Wed,  2 Oct 2024 09:44:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 01/10] qapi/char: Supply missing member documentation
Date: Wed,  2 Oct 2024 09:43:55 +0200
Message-ID: <20241002074404.1983368-2-armbru@redhat.com>
In-Reply-To: <20241002074404.1983368-1-armbru@redhat.com>
References: <20241002074404.1983368-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since we neglect to document several members of ChardevBackendKind,
their description in the QEMU QMP Reference manual is "Not
documented".  Fix that, and improve the existing member documentation.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240911112545.2248881-2-armbru@redhat.com>
---
 qapi/char.json   | 44 ++++++++++++++++++++++++++++----------------
 qapi/pragma.json |  1 -
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index ef58445cee..0d6de1ee35 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -434,37 +434,49 @@
 ##
 # @ChardevBackendKind:
 #
-# @pipe: Since 1.5
+# @file: regular files
 #
-# @udp: Since 1.5
+# @serial: serial host device
 #
-# @mux: Since 1.5
+# @parallel: parallel host device
 #
-# @msmouse: Since 1.5
+# @pipe: pipes (since 1.5)
 #
-# @wctablet: Since 2.9
+# @socket: stream socket
 #
-# @braille: Since 1.5
+# @udp: datagram socket (since 1.5)
 #
-# @testdev: Since 2.2
+# @pty: pseudo-terminal
 #
-# @stdio: Since 1.5
+# @null: provides no input, throws away output
 #
-# @console: Since 1.5
+# @mux: (since 1.5)
 #
-# @spicevmc: Since 1.5
+# @msmouse: emulated Microsoft serial mouse (since 1.5)
 #
-# @spiceport: Since 1.5
+# @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
 #
-# @qemu-vdagent: Since 6.1
+# @braille: Baum Braille device (since 1.5)
 #
-# @dbus: Since 7.0
+# @testdev: device for test-suite control (since 2.2)
 #
-# @vc: v1.5
+# @stdio: standard I/O (since 1.5)
 #
-# @ringbuf: Since 1.6
+# @console: Windows console (since 1.5)
 #
-# @memory: Since 1.5
+# @spicevmc: spice vm channel (since 1.5)
+#
+# @spiceport: Spice port channel (since 1.5)
+#
+# @qemu-vdagent: Spice vdagent (since 6.1)
+#
+# @dbus: D-Bus channel (since 7.0)
+#
+# @vc: virtual console (since 1.5)
+#
+# @ringbuf: memory ring buffer (since 1.6)
+#
+# @memory: synonym for @ringbuf (since 1.5)
 #
 # Features:
 #
diff --git a/qapi/pragma.json b/qapi/pragma.json
index fad3a31628..d5ae397293 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -46,7 +46,6 @@
         'BlockdevSnapshotSyncWrapper',
         'BlockdevSnapshotWrapper',
         'BlockdevVmdkAdapterType',
-        'ChardevBackendKind',
         'CxlCorErrorType',
         'DisplayProtocol',
         'DriveBackupWrapper',
-- 
2.46.0



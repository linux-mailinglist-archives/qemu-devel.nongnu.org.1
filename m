Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 835D1AFB0F7
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Jul 2025 12:18:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYiuD-0005gr-Lt; Mon, 07 Jul 2025 06:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uYirm-00048V-EY
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 06:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uYirk-0004rm-Oa
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 06:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751883263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FWkwiqBFaRLBMG3UDMNwPpavjNOu5LNmqrRpFle3uWg=;
 b=C2LNcCupEHhWNrwTZr49U/YUCXL9eUuhL+XATeIYzEYc0YCa0BhIzEq6HiuilCsi3xPDKC
 rdo1qniw5euqZ/IPRYGlXYaS2z8/VYLBsIa4kJt1HolsbuRynDvK3bGWmiwf7gQ5Uq59yx
 U2n/ioaf3To53Z6tRwFlt7dYMSOIrN4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-9sdrZfjMM2eC0PrFG4paIA-1; Mon,
 07 Jul 2025 06:14:19 -0400
X-MC-Unique: 9sdrZfjMM2eC0PrFG4paIA-1
X-Mimecast-MFC-AGG-ID: 9sdrZfjMM2eC0PrFG4paIA_1751883258
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48E7C18002E4; Mon,  7 Jul 2025 10:14:18 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E403E19560AD; Mon,  7 Jul 2025 10:14:16 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, yanqzhan@redhat.com, peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2] tpm: "qemu -tpmdev help" should return success
Date: Mon,  7 Jul 2025 14:14:12 +0400
Message-ID: <20250707101412.2055581-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Like other "-foo help" CLI, the qemu process should return 0 for
"-tpmdev help".

While touching this, switch to is_help_option() utility function as
suggested by Peter Maydell.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/tpm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/system/tpm.c b/system/tpm.c
index 8df0f6e72b..903b29c043 100644
--- a/system/tpm.c
+++ b/system/tpm.c
@@ -21,6 +21,7 @@
 #include "system/tpm.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/help_option.h"
 
 static QLIST_HEAD(, TPMBackend) tpm_backends =
     QLIST_HEAD_INITIALIZER(tpm_backends);
@@ -179,9 +180,9 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optstr)
 {
     QemuOpts *opts;
 
-    if (!strcmp(optstr, "help")) {
+    if (is_help_option(optstr)) {
         tpm_display_backend_drivers();
-        return -1;
+        exit(EXIT_SUCCESS);
     }
     opts = qemu_opts_parse_noisily(opts_list, optstr, true);
     if (!opts) {
-- 
2.50.0



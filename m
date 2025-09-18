Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3984B1E43A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Aug 2025 10:10:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukI9V-00073f-Gs; Fri, 08 Aug 2025 04:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9R-00071w-F2
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukI9P-0006TG-Se
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 04:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754640511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/0BFU3f3t2hzCViZolGUTl+gEXGzgiRRyktDZUPX6Ko=;
 b=UEbM5O2nrFLKiGLdRu8MFDnz2WWi/VFXL0kwAUDmRlgY52IHMo55YDZtliGuKjpXP4F8Pc
 8eKax01Kp9JDETkk9ihX5/VkMIbcgGTuYbjFIiaTnRqaw1V+/OGC5+q1TMSka0CpKfcsUF
 VMH+OGRKKvy3Dz1L892uWeKBRiyL9xs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-_36Awsz4N06cdVMUJhtifw-1; Fri,
 08 Aug 2025 04:08:27 -0400
X-MC-Unique: _36Awsz4N06cdVMUJhtifw-1
X-Mimecast-MFC-AGG-ID: _36Awsz4N06cdVMUJhtifw_1754640507
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EA9F195608F; Fri,  8 Aug 2025 08:08:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D7E21954185; Fri,  8 Aug 2025 08:08:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5370521E6768; Fri, 08 Aug 2025 10:08:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH 04/12] migration/cpr: Clean up error reporting in
 cpr_resave_fd()
Date: Fri,  8 Aug 2025 10:08:15 +0200
Message-ID: <20250808080823.2638861-5-armbru@redhat.com>
In-Reply-To: <20250808080823.2638861-1-armbru@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qapi/error.h advises:

 * Please don't error_setg(&error_fatal, ...), use error_report() and
 * exit(), because that's more obvious.

Do that.

The error message starts with "internal error: ", so maybe this should
assert() instead.

Cc: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/cpr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/cpr.c b/migration/cpr.c
index 42ad0b0d50..908bcf83b2 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "hw/vfio/vfio-device.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
@@ -100,10 +101,10 @@ void cpr_resave_fd(const char *name, int id, int fd)
     if (old_fd < 0) {
         cpr_save_fd(name, id, fd);
     } else if (old_fd != fd) {
-        error_setg(&error_fatal,
-                   "internal error: cpr fd '%s' id %d value %d "
-                   "already saved with a different value %d",
-                   name, id, fd, old_fd);
+        error_report("internal error: cpr fd '%s' id %d value %d "
+                     "already saved with a different value %d",
+                     name, id, fd, old_fd);
+        exit(1);
     }
 }
 
-- 
2.49.0



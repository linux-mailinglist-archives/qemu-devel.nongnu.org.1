Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A2BD2C37
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Oct 2025 13:22:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8GcH-0006jE-Mr; Mon, 13 Oct 2025 07:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8GcE-0006ir-5Q
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8Gc7-0005D8-NY
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760354469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tZdDJ2XLpcAXL13+XN0Wl55eE4UJ4vhjm1ynAm0LlRc=;
 b=R7sHsQEC53H9nl5EVhMN+lq/c9TpDSNbbi+2cGJN87vvbUro1gtKennDMd1g3swgoDGwPi
 wB3qoa2GulinrU2HlSun9d2sviJ2uuf2GhgUiDGs4lvsQjIIOy/Al/C4nZ4nEAwmC7vZ0N
 YNi1So0uBnrBrITczyFlKcfyF5oMzTE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-ZUHOhjhgOreW45Vd9rr_Kw-1; Mon,
 13 Oct 2025 07:21:05 -0400
X-MC-Unique: ZUHOhjhgOreW45Vd9rr_Kw-1
X-Mimecast-MFC-AGG-ID: ZUHOhjhgOreW45Vd9rr_Kw_1760354465
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1B0F180035C; Mon, 13 Oct 2025 11:21:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DF091954102; Mon, 13 Oct 2025 11:21:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 09E4F21E6A27; Mon, 13 Oct 2025 13:21:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] ui/pixman: Fix crash in qemu_pixman_shareable_free()
Date: Mon, 13 Oct 2025 13:21:02 +0200
Message-ID: <20251013112102.2396012-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reported-by: Bernhard Beschow <shentey@gmail.com>
Fixes: b296b29d3414 (ui/pixman: Consistent error handling in qemu_pixman_shareable_free())
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 ui/qemu-pixman.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index e46c6232cf..aea09755b9 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -291,7 +291,9 @@ qemu_pixman_shareable_free(qemu_pixman_shareable handle,
     Error *err = NULL;
 
     qemu_win32_map_free(ptr, handle, &err);
-    error_report_err(err);
+    if (err) {
+        error_report_err(err);
+    }
 #else
     qemu_memfd_free(ptr, size, handle);
 #endif
-- 
2.49.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A10CC06748
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Oct 2025 15:20:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHi2-0005R3-Bu; Fri, 24 Oct 2025 09:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHhx-0005Qe-Uk
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCHhv-0004kH-BB
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761311989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3G2BT9iAz6T+va4TbFNMAz7RB+55LcofTHMiALdTMPQ=;
 b=c5DD78cwMa3mdtkYrnb+5pVOWsOlpUTAbuGPffRBsd6PTRkKESTTv5F//DXQ5/+vGmal0L
 dMRa2b3qK4+HGYQZtc6PhKo/SQCEeWk8u2DeliV/aVGDCM9HVKbP09gnbtbg2svxsIToNY
 XSPKI8eY90uKvBklAWPGpk+tHvGSfyY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-0a2Wm7NtOeulIve7k4uylg-1; Fri,
 24 Oct 2025 09:19:45 -0400
X-MC-Unique: 0a2Wm7NtOeulIve7k4uylg-1
X-Mimecast-MFC-AGG-ID: 0a2Wm7NtOeulIve7k4uylg_1761311984
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C119B180035A; Fri, 24 Oct 2025 13:19:44 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 48AAF19540EB; Fri, 24 Oct 2025 13:19:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 02/13] qom: use ERRP_GUARD in user_creatable_complete
Date: Fri, 24 Oct 2025 14:19:26 +0100
Message-ID: <20251024131937.56673-3-berrange@redhat.com>
In-Reply-To: <20251024131937.56673-1-berrange@redhat.com>
References: <20251024131937.56673-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

With error_propagate, the stack trace from any error_abort/fatal
usage will start from the error_propagate() call, which is largely
useless. Using ERRP_GUARD ensures the stack trace starts from
the origin that reported the error.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object_interfaces.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 1ffea1a728..415cbee8c5 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -24,13 +24,12 @@
 bool user_creatable_complete(UserCreatable *uc, Error **errp)
 {
     UserCreatableClass *ucc = USER_CREATABLE_GET_CLASS(uc);
-    Error *err = NULL;
+    ERRP_GUARD();
 
     if (ucc->complete) {
-        ucc->complete(uc, &err);
-        error_propagate(errp, err);
+        ucc->complete(uc, errp);
     }
-    return !err;
+    return !*errp;
 }
 
 bool user_creatable_can_be_deleted(UserCreatable *uc)
-- 
2.50.1



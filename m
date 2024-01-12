Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF57D82C74F
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:32:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQ2I-0005nH-QN; Fri, 12 Jan 2024 17:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2E-0005lc-VF
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:29:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2D-0005yz-8N
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705098592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gM2RN5pO+GmMhml+Um5Q9FyOvYDJTH7vM7O4jpR3G1s=;
 b=eiUa0pRhxqjBP50uKVezJDFfzLkFOAuFQUbhUgoy6CwRZnm8NY3ZWy8Dl3DUaYo2jK1OQ/
 SDgNNbYs1MTte7URYOY4r1CdkvpU6UgN/jVBxWrbFolxzaSwIu4smNPtpu9+HzZxDuB1Ot
 cr9Ysxz3FSc5bifXsiq8EzheKHm6f+s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-l3itgijKPz-WTW2kwwItDA-1; Fri, 12 Jan 2024 17:29:48 -0500
X-MC-Unique: l3itgijKPz-WTW2kwwItDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3672185A781;
 Fri, 12 Jan 2024 22:29:47 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.17.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E141C25AC8;
 Fri, 12 Jan 2024 22:29:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 04/19] qapi/schema: declare type for
 QAPISchemaObjectTypeMember.type
Date: Fri, 12 Jan 2024 17:29:30 -0500
Message-ID: <20240112222945.3033854-5-jsnow@redhat.com>
In-Reply-To: <20240112222945.3033854-1-jsnow@redhat.com>
References: <20240112222945.3033854-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

declare, but don't initialize the type of "type" to be QAPISchemaType -
and allow the value to be initialized during check(). This creates a
form of delayed initialization for QAPISchemaType objects where the
static typing only represents the fully-realized object, which occurs
after check() has been called.

This avoids the need for several "assert type is not None" statements
littered throughout the code by asserting it "will always be set."

Note that the static typing information for this object will be
incorrect prior to check() being called. If this field is accessed
before it is initialized in check(), you'll be treated to an
AttributeError exception.

Fixes stuff like this:

qapi/schema.py:657: error: "None" has no attribute "alternate_qtype"  [attr-defined]
qapi/schema.py:662: error: "None" has no attribute "describe"  [attr-defined]

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index e39ed972a80..48a51dcd188 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -794,7 +794,7 @@ def __init__(self, name, info, typ, optional, ifcond=None, features=None):
             assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self._type_name = typ
-        self.type = None
+        self.type: QAPISchemaType  # set during check()
         self.optional = optional
         self.features = features or []
 
-- 
2.43.0



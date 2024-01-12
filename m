Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A39F82C74B
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:32:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQ2g-00068Y-Vc; Fri, 12 Jan 2024 17:30:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2L-0005nm-C4
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:30:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2J-00063A-Hn
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705098598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/suOZ3blaFRxCrUqLq4Zy1YqoQBjjA9QrB9FjEwk4A=;
 b=Us4zGQQpuNykNhLBB79356yn0eFtsqhw8AwgNH7RPhT9WuOBf/AoKt1vTMZ8TiLldFzDHB
 Rd+WySp7Wejntr52pzyqfvJ5DTehXThbXQYl/jsJzNpkbwf3ses28/ctwIAFFxmZ4pXfOt
 Jub9DLMzthHVWMDMff9nRqOoxF5J1qg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652--i4pPLpKNvmf5cZu9ze2gg-1; Fri,
 12 Jan 2024 17:29:49 -0500
X-MC-Unique: -i4pPLpKNvmf5cZu9ze2gg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B4CA3C100BD;
 Fri, 12 Jan 2024 22:29:49 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.17.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4702BC25AC8;
 Fri, 12 Jan 2024 22:29:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 09/19] qapi/schema: allow resolve_type to be used for
 built-in types
Date: Fri, 12 Jan 2024 17:29:35 -0500
Message-ID: <20240112222945.3033854-10-jsnow@redhat.com>
In-Reply-To: <20240112222945.3033854-1-jsnow@redhat.com>
References: <20240112222945.3033854-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

allow resolve_type to be used for both built-in and user-specified
type definitions. In the event that the type cannot be resolved, assert
that 'info' and 'what' were both provided in order to create a usable
QAPISemError.

In practice, 'info' will only be None for built-in definitions, which
*should not fail* type lookup.

As a convenience, allow the 'what' and 'info' parameters to be elided
entirely so that it can be used as a can-not-fail version of
lookup_type.

Note: there are only three callsites to resolve_type at present where
"info" is perceived to be possibly None:

    1) QAPISchemaArrayType.check()
    2) QAPISchemaObjectTypeMember.check()
    3) QAPISchemaEvent.check()

    Of those three, only the first actually ever passes None; the other two
    are limited by their base class initializers which accept info=None, but
    neither actually use it in practice.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 66a78f28fd4..a77b51d1b96 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1001,9 +1001,10 @@ def lookup_type(self, name):
         assert typ is None or isinstance(typ, QAPISchemaType)
         return typ
 
-    def resolve_type(self, name, info, what):
+    def resolve_type(self, name, info=None, what=None):
         typ = self.lookup_type(name)
         if not typ:
+            assert info and what  # built-in types must not fail lookup
             if callable(what):
                 what = what(info)
             raise QAPISemError(
-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36582C746
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:32:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQ2O-0005nP-27; Fri, 12 Jan 2024 17:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2F-0005mL-KG
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:29:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2D-0005z5-Kv
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705098592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ygr8tvTNkt4R+eN6f23w4cpW3E+QkRRf1xXw5wo7LZQ=;
 b=amL+JDGE3MkNpSPE7lmTUdgX0K5TTYCTePYv6NhgsQctdTTwnJQizfGOZVzO0L6pJoxzr9
 8DjKbL8KK65VurTqc4RqonQUhU1SifTU/12qX9ehLErnjMNa3Pgkn7Hy458lLFvA85LGM+
 RL0oSOnbnWr8XV7C9m/02VOyhckvWj4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-uOUuMe3ZMDCfOVFb9hlsBg-1; Fri, 12 Jan 2024 17:29:51 -0500
X-MC-Unique: uOUuMe3ZMDCfOVFb9hlsBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01AC182DFE1;
 Fri, 12 Jan 2024 22:29:51 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.17.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1765C25AC8;
 Fri, 12 Jan 2024 22:29:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 13/19] qapi/schema: split "checked" field into "checking"
 and "checked"
Date: Fri, 12 Jan 2024 17:29:39 -0500
Message-ID: <20240112222945.3033854-14-jsnow@redhat.com>
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

differentiate between "actively in the process of checking" and
"checking has completed". This allows us to clean up the types of some
internal fields such as QAPISchemaObjectType's members field which
currently uses "None" as a test for determining if check has been run
already or not.

This simplifies the typing from a cumbersome Optional[List[T]] to merely
a List[T], which is more pythonic: it is safe to iterate over an empty
list with "for x in []" whereas with an Optional[List[T]] you have to
rely on the more cumbersome "if L: for x in L: ..."

Note that it is valid to have an empty members list, see the internal
q_empty object as an example.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index eefa58a798b..0d9a70ab4cb 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -20,7 +20,7 @@
 from collections import OrderedDict
 import os
 import re
-from typing import List, Optional
+from typing import List, Optional, cast
 
 from .common import (
     POINTER_SUFFIX,
@@ -457,22 +457,24 @@ def __init__(self, name, info, doc, ifcond, features,
         self.base = None
         self.local_members = local_members
         self.variants = variants
-        self.members = None
+        self.members: List[QAPISchemaObjectTypeMember] = []
+        self._checking = False
 
     def check(self, schema):
         # This calls another type T's .check() exactly when the C
         # struct emitted by gen_object() contains that T's C struct
         # (pointers don't count).
-        if self.members is not None:
-            # A previous .check() completed: nothing to do
-            return
-        if self._checked:
+        if self._checking:
             # Recursed: C struct contains itself
             raise QAPISemError(self.info,
                                "object %s contains itself" % self.name)
+        if self._checked:
+            # A previous .check() completed: nothing to do
+            return
 
+        self._checking = True
         super().check(schema)
-        assert self._checked and self.members is None
+        assert self._checked and not self.members
 
         seen = OrderedDict()
         if self._base_name:
@@ -489,13 +491,17 @@ def check(self, schema):
         for m in self.local_members:
             m.check(schema)
             m.check_clash(self.info, seen)
-        members = seen.values()
+
+        # check_clash is abstract, but local_members is asserted to be
+        # List[QAPISchemaObjectTypeMember]. Cast to the narrower type.
+        members = cast(List[QAPISchemaObjectTypeMember], list(seen.values()))
 
         if self.variants:
             self.variants.check(schema, seen)
             self.variants.check_clash(self.info, seen)
 
-        self.members = members  # mark completed
+        self.members = members
+        self._checking = False  # mark completed
 
     # Check that the members of this type do not cause duplicate JSON members,
     # and update seen to track the members seen so far. Report any errors
-- 
2.43.0



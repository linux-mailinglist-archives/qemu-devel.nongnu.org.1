Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9448A5821E
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Mar 2025 09:45:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCAm-0007Lj-RK; Sun, 09 Mar 2025 04:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAa-0006rS-Si
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAZ-0002ab-8h
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JuA7SVDgD0ex81fpF0cRX+zQ5amNxByPpkZFbXngsX4=;
 b=cnYTXHAs+vEWgNWwOH1n9KGvdDqqE7HD0OzWVwkZ30VoM4c3VUJ8YQFJKuiUBJEwxiL/sA
 LasoHZoky8c/sEB4L9HtBNznTpVcmXlnSiCvURJx5/S2oYbNEfpQpHRdnFWGC6Dfi3VsbC
 SGnnNqGsklg6mmeMXXi58lRybbLsa6E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-HMzQy2GgM2GBa8dK4ZTXRg-1; Sun,
 09 Mar 2025 04:37:54 -0400
X-MC-Unique: HMzQy2GgM2GBa8dK4ZTXRg-1
X-Mimecast-MFC-AGG-ID: HMzQy2GgM2GBa8dK4ZTXRg_1741509473
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20E791956048; Sun,  9 Mar 2025 08:37:53 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3106B19560AB; Sun,  9 Mar 2025 08:37:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 47/62] docs/qapidoc: add add_field() and generate_field()
 helper methods
Date: Sun,  9 Mar 2025 04:35:34 -0400
Message-ID: <20250309083550.5155-48-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

These are simple rST generation methods that assist in getting the types
and formatting correct for a field list entry. add_field() is a more
raw, direct call while generate_field() is intended to be used for
generating the correct field from a member object.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 0f895a3624a..b87ce288837 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -136,6 +136,20 @@ def ensure_blank_line(self) -> None:
             # +2: correct for zero/one index, then increment by one.
             self.add_line_raw("", fname, line + 2)
 
+    def add_field(
+        self,
+        kind: str,
+        name: str,
+        body: str,
+        info: QAPISourceInfo,
+        typ: Optional[str] = None,
+    ) -> None:
+        if typ:
+            text = f":{kind} {typ} {name}: {body}"
+        else:
+            text = f":{kind} {name}: {body}"
+        self.add_lines(text, info)
+
     def format_type(
         self, ent: Union[QAPISchemaDefinition | QAPISchemaMember]
     ) -> Optional[str]:
@@ -160,6 +174,16 @@ def format_type(
 
         return ret
 
+    def generate_field(
+        self,
+        kind: str,
+        member: QAPISchemaMember,
+        body: str,
+        info: QAPISourceInfo,
+    ) -> None:
+        typ = self.format_type(member)
+        self.add_field(kind, member.name, body, info, typ)
+
     # Transmogrification helpers
 
     def visit_paragraph(self, section: QAPIDoc.Section) -> None:
-- 
2.48.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4082A29D5E
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Feb 2025 00:17:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfobN-00067Q-ET; Wed, 05 Feb 2025 18:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfobA-00050X-Dq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:14:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfob8-0005mU-NZ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738797262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFwRHJBuGsYcGLiNHZZ8biZPsF+DncQMI1zu0iuDMjs=;
 b=FYe5go9YianNCRiQjp6qwLs565HLJUiCJ+/xggM/QLNGkpL5NWE/F0KqiJXwcN7fm4bTfl
 Nxrd5AVQZUsU3OkApCNk6z66/coYgllEsl/rk4MGRO3GVnTdDJ/kANiH6syLhLIAr0Ht3P
 ntpMAKxbWw9DmzHLUVw0Fpz9QWKtSqE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-QWGW0Qc-Ol6V1U0Pz1yYeA-1; Wed,
 05 Feb 2025 18:14:18 -0500
X-MC-Unique: QWGW0Qc-Ol6V1U0Pz1yYeA-1
X-Mimecast-MFC-AGG-ID: QWGW0Qc-Ol6V1U0Pz1yYeA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E0F01956089; Wed,  5 Feb 2025 23:14:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71FD41800570; Wed,  5 Feb 2025 23:14:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 20/42] docs/qapidoc: add visit_sections() method
Date: Wed,  5 Feb 2025 18:11:46 -0500
Message-ID: <20250205231208.1480762-21-jsnow@redhat.com>
In-Reply-To: <20250205231208.1480762-1-jsnow@redhat.com>
References: <20250205231208.1480762-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Implement the actual main dispatch method that processes and handles the
list of doc sections for a given QAPI entity.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 5f00615ae32..73076a7d6ae 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -277,6 +277,29 @@ def preamble(self, ent: QAPISchemaEntity) -> None:
 
         self.ensure_blank_line()
 
+    def visit_sections(self, ent: QAPISchemaEntity) -> None:
+        sections = ent.doc.all_sections if ent.doc else []
+
+        # Add sections *in the order they are documented*:
+        for section in sections:
+            if section.kind == QAPIDoc.Kind.PLAIN:
+                self.visit_paragraph(section)
+            elif section.kind == QAPIDoc.Kind.MEMBER:
+                self.visit_member(section)
+            elif section.kind == QAPIDoc.Kind.FEATURE:
+                self.visit_feature(section)
+            elif section.kind in (QAPIDoc.Kind.SINCE, QAPIDoc.Kind.TODO):
+                # Since is handled in preamble, TODO is skipped intentionally.
+                pass
+            elif section.kind == QAPIDoc.Kind.RETURNS:
+                self.visit_returns(section)
+            elif section.kind == QAPIDoc.Kind.ERRORS:
+                self.visit_errors(section)
+            else:
+                assert False
+
+        self.ensure_blank_line()
+
     # Transmogrification core methods
 
     def visit_module(self, path: str) -> None:
-- 
2.48.1



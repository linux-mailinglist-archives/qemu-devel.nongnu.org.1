Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3009A58221
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Mar 2025 09:45:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCC1-00028R-Co; Sun, 09 Mar 2025 04:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCB3-0000RA-V2
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCB2-0002fq-0A
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiS6F4Z4h9f5NiOC8YGbXGzyPIxRv70P+PjXWg5jVWM=;
 b=ZMFtkdLZuhvgup94HKS/mqpw2Orpyjzl9J4kiEbdOGTxrVw+CWymYHoGjJwYf8GjXlRoFy
 soNMnPVG0NE0vcskz1LimlJ9jznDlaEu02xDf0FKa1OQsJLcNnBxg/72kjfN//QwCUVidJ
 52Fzasvig1pI3U9of0zIK9NAoI+RkOY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-AJJ8Olm7MlSZGY7W47PAZQ-1; Sun,
 09 Mar 2025 04:38:23 -0400
X-MC-Unique: AJJ8Olm7MlSZGY7W47PAZQ-1
X-Mimecast-MFC-AGG-ID: AJJ8Olm7MlSZGY7W47PAZQ_1741509502
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BA5A1809CA5; Sun,  9 Mar 2025 08:38:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF10B19560AB; Sun,  9 Mar 2025 08:38:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 59/62] qapi/parser: add undocumented stub members to
 all_sections
Date: Sun,  9 Mar 2025 04:35:46 -0400
Message-ID: <20250309083550.5155-60-jsnow@redhat.com>
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

This helps simplify the new doc generator if it doesn't have to check
for undocumented members, it can just blindly operate on a sequence of
QAPIDoc.Section instances.

NB: If there is no existing 'member' section, these undocumented stub
members will be inserted directly after the leading section.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 11c11bb09e5..58cb9f41ae8 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -789,8 +789,21 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
                 raise QAPISemError(member.info,
                                    "%s '%s' lacks documentation"
                                    % (member.role, member.name))
-            self.args[member.name] = QAPIDoc.ArgSection(
+            section = QAPIDoc.ArgSection(
                 self.info, QAPIDoc.Kind.MEMBER, member.name)
+            self.args[member.name] = section
+
+            # Insert stub documentation section for missing member docs.
+            # Determine where to insert stub doc - it should go at the
+            # end of the members section(s), if any. Note that index 0
+            # is assumed to be an untagged intro section, even if it is
+            # empty.
+            index = 1
+            if len(self.all_sections) > 1:
+                while self.all_sections[index].kind == QAPIDoc.Kind.MEMBER:
+                    index += 1
+            self.all_sections.insert(index, section)
+
         self.args[member.name].connect(member)
 
     def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
-- 
2.48.1



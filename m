Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A78FA4F5B9
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Mar 2025 04:51:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpflS-0006BI-Fg; Tue, 04 Mar 2025 22:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfkw-0004u0-9i
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:49:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfku-0006Qe-IQ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eIml+bdV/p1otVFgQ8rtuT2HtOqCWjt8m6j6hmwpw64=;
 b=cXO0s5ZZlRyApGMljYpa+dsTdc6spjDHAam1kWUTl03BD2e9nFSM93+4sUzUMidiL33I5U
 h8IvoD6GknNn7NROlEA65w2VDAJaLFAlbQmh1yxB5yvdqLMmrPT1Yuk6Y5Zb9b80ZL2IqC
 obF/IopxoIovHu+YO9rByZTwv9MVcxE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-JEnN4Il1MCCX6EhzA19pyA-1; Tue,
 04 Mar 2025 22:49:10 -0500
X-MC-Unique: JEnN4Il1MCCX6EhzA19pyA-1
X-Mimecast-MFC-AGG-ID: JEnN4Il1MCCX6EhzA19pyA_1741146549
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77F7A1955BC5; Wed,  5 Mar 2025 03:49:09 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 188341956095; Wed,  5 Mar 2025 03:49:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 47/57] docs/qapidoc: prepare to record entity being
 transmogrified
Date: Tue,  4 Mar 2025 22:45:56 -0500
Message-ID: <20250305034610.960147-48-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

Prepare to keep a record of which entity we're working on documenting
for the purposes of being able to change certain generative features
conditionally and create stronger assertions.

If you find yourself asking: "Wait, but where does the current entity
actually get recorded?!", you're right! That part comes with the
visit_entity() implementation, which gets added later.

This patch is front-loaded for the sake of type checking in the
forthcoming commits before visit_entity() is ready to be added.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index eaea19af7ac..834f12ba6e9 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -78,9 +78,15 @@
 
 class Transmogrifier:
     def __init__(self) -> None:
+        self._curr_ent: Optional[QAPISchemaDefinition] = None
         self._result = StringList()
         self.indent = 0
 
+    @property
+    def entity(self) -> QAPISchemaDefinition:
+        assert self._curr_ent is not None
+        return self._curr_ent
+
     # General-purpose rST generation functions
 
     def get_indent(self) -> str:
-- 
2.48.1



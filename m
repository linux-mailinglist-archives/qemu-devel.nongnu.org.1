Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F60A5820E
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Mar 2025 09:43:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCA1-0003dT-7P; Sun, 09 Mar 2025 04:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC9n-0002p8-6r
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC9l-0002Ro-Mi
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4NWkQ4ouYUL+mKJBAl/nb9/STXk2k++zJ8lVadQp84=;
 b=PVCZduGIKZUlH5Oc9zqtY7k10DHtenHhvwF/T4czdFPjZjFozb2u/Qblp633r3UUXo5FWK
 83TFqUUIUyH2W06nbdM7idboNPPXSIcv3MSPHE621n81iFjlH/e8Zrvx2m3su0p6SY8Z63
 K0CpBuSzrndeMYcGxwSSTDsGvgttfnU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-dGMRpGuGOaawMvEHKL_saA-1; Sun,
 09 Mar 2025 04:37:05 -0400
X-MC-Unique: dGMRpGuGOaawMvEHKL_saA-1
X-Mimecast-MFC-AGG-ID: dGMRpGuGOaawMvEHKL_saA_1741509424
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82655180899B; Sun,  9 Mar 2025 08:37:04 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C50A19560AB; Sun,  9 Mar 2025 08:37:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Harmonie Snow <harmonie@gmail.com>
Subject: [PATCH v2 28/62] docs/qapi-domain: add CSS styling
Date: Sun,  9 Mar 2025 04:35:15 -0400
Message-ID: <20250309083550.5155-29-jsnow@redhat.com>
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

Improve the general look and feel of generated QAPI docs.

Attempt to limit line lengths to offer a more comfortable measure on
maximized windows, and improve some margin and spacing for field lists.

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx-static/theme_overrides.css | 56 +++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index 3fd326613d9..92f395054a8 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -18,8 +18,8 @@ h1, h2, .rst-content .toctree-wrapper p.caption, h3, h4, h5, h6, legend {
 
 .rst-content dl:not(.docutils) dt {
     border-top: none;
-    border-left: solid 3px #ccc;
-    background-color: #f0f0f0;
+    border-left: solid 5px #bcc6d2;
+    background-color: #eaedf1;
     color: black;
 }
 
@@ -211,6 +211,18 @@ div[class^="highlight"] pre {
 
 /* QAPI domain theming */
 
+/* most content in a qapi object definition should not eclipse about
+   80ch, but nested field lists are explicitly exempt due to their
+   two-column nature */
+.qapi dd *:not(dl) {
+    max-width: 80ch;
+}
+
+/* but the content column itself should still be less than ~80ch. */
+.qapi .field-list dd {
+    max-width: 80ch;
+}
+
 .qapi-infopips {
     margin-bottom: 1em;
 }
@@ -250,3 +262,43 @@ div[class^="highlight"] pre {
     border-radius: 15px;
     margin: 5px;
 }
+
+/* code blocks */
+.qapi div[class^="highlight"] {
+    width: fit-content;
+    background-color: #fffafd;
+    border: 2px solid #ffe1f3;
+}
+
+/* note, warning, etc. */
+.qapi .admonition {
+    width: fit-content;
+}
+
+/* pad the top of the field-list so the text doesn't start directly at
+   the top border; primarily for the field list labels, but adjust the
+   field bodies as well for parity. */
+dl.field-list > dt:first-of-type, dl.field-list > dd:first-of-type {
+    padding-top: 0.3em;
+}
+
+dl.field-list > dt:last-of-type, dl.field-list > dd:last-of-type {
+    padding-bottom: 0.3em;
+}
+
+/* pad the field list labels so they don't crash into the border */
+dl.field-list > dt {
+    padding-left: 0.5em;
+    padding-right: 0.5em;
+}
+
+/* Add a little padding between field list sections */
+dl.field-list > dd:not(:last-child) {
+    padding-bottom: 1em;
+}
+
+/* Sphinx 3.x: unresolved xrefs */
+.rst-content *:not(a) > code.xref {
+    font-weight: 400;
+    color: #333333;
+}
-- 
2.48.1



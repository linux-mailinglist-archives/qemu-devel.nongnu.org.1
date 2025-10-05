Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30876BB99CA
	for <lists+qemu-devel@lfdr.de>; Sun, 05 Oct 2025 18:53:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Ruo-0000AW-JI; Sun, 05 Oct 2025 12:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Ruk-00009K-Rt; Sun, 05 Oct 2025 12:48:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Rui-00073g-1i; Sun, 05 Oct 2025 12:48:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7B02815AA2E;
 Sun, 05 Oct 2025 19:48:41 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id F2B5E2996EC;
 Sun,  5 Oct 2025 19:48:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 67/81] ui/icons/qemu.svg: Add metadata information
 (author, license) to the logo
Date: Sun,  5 Oct 2025 19:47:47 +0300
Message-ID: <20251005164822.442861-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Thomas Huth <thuth@redhat.com>

We've got two versions of the QEMU logo in the repository, one with
the whole word "QEMU" (pc-bios/qemu_logo.svg) and one that only contains
the letter "Q" (ui/icons/qemu.svg). While qemu_logo.svg contains the
proper metadata with license and author information, this is missing
from the ui/icons/qemu.svg file. Copy the meta data there so that
people have a chance to know the license of the file if they only
look at the qemu.svg file.

Closes: https://gitlab.com/qemu-project/qemu/-/issues/3139
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20250930071419.117592-1-thuth@redhat.com>
(cherry picked from commit 9163424c50981dbc4ded9990228ac01a3b193656)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/icons/qemu.svg b/ui/icons/qemu.svg
index 24ca23a1e9..f2500de339 100644
--- a/ui/icons/qemu.svg
+++ b/ui/icons/qemu.svg
@@ -918,7 +918,26 @@
         <dc:format>image/svg+xml</dc:format>
         <dc:type
            rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
-        <dc:title />
+        <dc:title>Kew the Angry Emu</dc:title>
+        <dc:creator>
+          <cc:Agent>
+            <dc:title>Benoît Canet</dc:title>
+          </cc:Agent>
+        </dc:creator>
+        <dc:rights>
+          <cc:Agent>
+            <dc:title>CC BY 3.0</dc:title>
+          </cc:Agent>
+        </dc:rights>
+        <dc:publisher>
+          <cc:Agent>
+            <dc:title>QEMU Community</dc:title>
+          </cc:Agent>
+        </dc:publisher>
+        <dc:date>2012-02-15</dc:date>
+        <cc:license
+           rdf:resource="http://creativecommons.org/licenses/by/3.0/" />
+        <dc:source>https://lists.gnu.org/archive/html/qemu-devel/2012-02/msg02865.html</dc:source>
       </cc:Work>
     </rdf:RDF>
   </metadata>
-- 
2.47.3



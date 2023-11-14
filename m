Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 962C87EB542
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:03:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wl9-0006xl-Pe; Tue, 14 Nov 2023 11:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wkq-0006jD-70; Tue, 14 Nov 2023 11:59:12 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wkn-0004wc-CJ; Tue, 14 Nov 2023 11:59:11 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CB9973326C;
 Tue, 14 Nov 2023 19:59:00 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9B2B2351F3;
 Tue, 14 Nov 2023 19:58:42 +0300 (MSK)
Received: (nullmailer pid 2949090 invoked by uid 1000);
 Tue, 14 Nov 2023 16:58:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH trivial 06/21] docs/devel/migration.rst: spelling fix: doen't
Date: Tue, 14 Nov 2023 19:58:19 +0300
Message-Id: <20231114165834.2949011-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114165834.2949011-1-mjt@tls.msk.ru>
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Fixes: 1aefe2ca1423 "migration/doc: Add documentation for backwards compatiblity"
Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/devel/migration.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 5adf4f12f7..51b1f61f5e 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -1061,7 +1061,7 @@ QEMU version, in this case pc-5.1.
 
 4 - qemu-5.1 -M pc-5.2  -> migrates to -> qemu-5.1 -M pc-5.2
 
-  This combination is not possible as the qemu-5.1 doen't understand
+  This combination is not possible as the qemu-5.1 does't understand
   pc-5.2 machine type.  So nothing to worry here.
 
 Now it comes the interesting ones, when both QEMU processes are
@@ -1214,7 +1214,7 @@ machine types to have the right value::
          ...
      };
 
-A device with diferent features on both sides
+A device with different features on both sides
 ---------------------------------------------
 
 Let's assume that we are using the same QEMU binary on both sides,
@@ -1294,12 +1294,12 @@ Host B:
 
 $ qemu-system-x86_64 -cpu host,taa-no=off
 
-And you would be able to migrate between them.  It is responsability
+And you would be able to migrate between them.  It is responsibility
 of the management application or of the user to make sure that the
 configuration is correct.  QEMU doesn't know how to look at this kind
 of features in general.
 
-Notice that we don't recomend to use -cpu host for migration.  It is
+Notice that we don't recommend to use -cpu host for migration.  It is
 used in this example because it makes the example simpler.
 
 Other devices have worse control about individual features.  If they
-- 
2.39.2



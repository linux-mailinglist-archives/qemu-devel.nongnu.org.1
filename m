Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 393A996EB1D
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 08:56:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smSrl-00041f-QS; Fri, 06 Sep 2024 02:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSrj-0003zq-6R; Fri, 06 Sep 2024 02:54:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSrg-0002xc-Nb; Fri, 06 Sep 2024 02:54:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9C32E8C236;
 Fri,  6 Sep 2024 09:53:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 623501333EE;
 Fri,  6 Sep 2024 09:54:29 +0300 (MSK)
Received: (nullmailer pid 43303 invoked by uid 1000);
 Fri, 06 Sep 2024 06:54:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, John Snow <jsnow@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 01/53] qapi/qom: Document feature unstable of
 @x-vfio-user-server
Date: Fri,  6 Sep 2024 09:53:31 +0300
Message-Id: <20240906065429.42415-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
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

From: Markus Armbruster <armbru@redhat.com>

Commit 8f9a9259d32c added ObjectType member @x-vfio-user-server with
feature unstable, but neglected to explain why it is unstable.  Do
that now.

Fixes: 8f9a9259d32c (vfio-user: define vfio-user-server object)
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: John G Johnson <john.g.johnson@oracle.com>
Cc: Jagannathan Raman <jag.raman@oracle.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240703095310.1242102-1-armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
[Indentation fixed]
(cherry picked from commit 3becc939081097ccfed6968771f33d65ce8551eb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qapi/qom.json b/qapi/qom.json
index c53ef978ff..1e7e97f8f1 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -905,7 +905,8 @@
 #
 # Features:
 #
-# @unstable: Member @x-remote-object is experimental.
+# @unstable: Members @x-remote-object and @x-vfio-user-server are
+#     experimental.
 #
 # Since: 6.0
 ##
-- 
2.39.2



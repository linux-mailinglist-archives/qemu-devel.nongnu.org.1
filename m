Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C69E4852A66
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Feb 2024 09:03:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZnkT-0004Lu-4R; Tue, 13 Feb 2024 03:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rZnk4-0004BM-Rf; Tue, 13 Feb 2024 03:02:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rZnk2-0007BZ-HW; Tue, 13 Feb 2024 03:02:12 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 33B2F4CBD2;
 Tue, 13 Feb 2024 11:01:57 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5DB0F7CF20;
 Tue, 13 Feb 2024 11:01:52 +0300 (MSK)
Received: (nullmailer pid 160911 invoked by uid 1000);
 Tue, 13 Feb 2024 08:01:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 09/15] qemu-nbd: mention --tls-hostname option in qemu-nbd
 --help
Date: Tue, 13 Feb 2024 11:01:45 +0300
Message-Id: <20240213080151.160839-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213080151.160839-1-mjt@tls.msk.ru>
References: <20240213080151.160839-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This option was not documented.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1240
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index bac0b5e3ec..d7b3ccab21 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -114,6 +114,7 @@ static void usage(const char *name)
 "  --tls-creds=ID            use id of an earlier --object to provide TLS\n"
 "  --tls-authz=ID            use id of an earlier --object to provide\n"
 "                            authorization\n"
+"  --tls-hostname=HOSTNAME   override hostname used to check x509 certificate\n"
 "  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
 "                            specify tracing options\n"
 "  --fork                    fork off the server process and exit the parent\n"
-- 
2.39.2



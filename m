Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0B296F2D3
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 13:21:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWyk-00050c-6h; Fri, 06 Sep 2024 07:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWyc-0004Hg-W9; Fri, 06 Sep 2024 07:18:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWyb-0008E7-91; Fri, 06 Sep 2024 07:18:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D25B88C4A4;
 Fri,  6 Sep 2024 14:12:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DE60413370D;
 Fri,  6 Sep 2024 14:13:27 +0300 (MSK)
Received: (nullmailer pid 353712 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Woodhouse <dwmw@amazon.co.uk>,
 Hans <sungdgdhtryrt@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: [Stable-9.0.3 51/69] net: Fix '-net nic,
 model=' for non-help arguments
Date: Fri,  6 Sep 2024 14:13:00 +0300
Message-Id: <20240906111324.353230-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
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

From: David Woodhouse <dwmw@amazon.co.uk>

Oops, don't *delete* the model option when checking for 'help'.

Fixes: 64f75f57f9d2 ("net: Reinstate '-net nic, model=help' output as documented in man page")
Reported-by: Hans <sungdgdhtryrt@gmail.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit fa62cb989a9146c82f8f172715042852f5d36200)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/net.c b/net/net.c
index e6ca2529bb..897bb936cf 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1748,7 +1748,7 @@ void net_check_clients(void)
 
 static int net_init_client(void *dummy, QemuOpts *opts, Error **errp)
 {
-    const char *model = qemu_opt_get_del(opts, "model");
+    const char *model = qemu_opt_get(opts, "model");
 
     if (is_nic_model_help_option(model)) {
         return 0;
-- 
2.39.2



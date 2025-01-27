Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1F6A1D832
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Jan 2025 15:24:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ1N-000866-Dt; Mon, 27 Jan 2025 09:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ1J-0007z4-S9; Mon, 27 Jan 2025 09:23:21 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ1I-0002v7-Cw; Mon, 27 Jan 2025 09:23:21 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id F2958E0F55;
 Mon, 27 Jan 2025 17:22:47 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 8095351D85; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 16/41] migration/multifd: Fix compile error caused by
 page_size usage
Date: Mon, 27 Jan 2025 17:17:30 +0300
Message-Id: <20250127141803.3514882-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

>From Commit 90fa121c6c07 ("migration/multifd: Inline page_size and
page_count") onwards page_size is not part of MutiFD*Params but uses
an inline constant instead.

However, it missed updating an old usage, causing a compile error.

Fixes: 90fa121c6c07 ("migration/multifd: Inline page_size and page_count")
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20241203124943.52572-1-shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
(cherry picked from commit d127294f265e6a17f8d614f2bef7df8455e81f56)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index 6e6a290ae9..6895c1f65a 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -169,7 +169,7 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
             .src_len = page_size,
             .dst     = buf,
             /* Set dst_len to double the src in case compressed out >= page_size */
-            .dst_len = p->page_size * 2,
+            .dst_len = page_size * 2,
         };
 
         if (uadk_data->handle) {
-- 
2.39.5



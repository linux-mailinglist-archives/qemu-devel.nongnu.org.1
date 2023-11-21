Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 408467F2C72
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 13:01:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PQc-0002y2-0J; Tue, 21 Nov 2023 07:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b5dddee4e6bb4f7a8ff0+7394+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1r5PQG-0002vL-U7
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:00:10 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b5dddee4e6bb4f7a8ff0+7394+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1r5PQD-0005ra-Up
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=S2rxj4tGYfiSjRTzAA0gVxxr1WmbaLvxmp6exqiHiuc=; b=rVpQxKgZJNF4QIchshpRU2sEZh
 eDC0PXqK/RnzwZsUbMuiTQjmgO+o2UNfrmD0weg2of543ihngxrFOxJIgepxF6pLU2pmKfd5OjLsh
 srmPL5EhvnYhe5Xs1CzuR5YohcDlHB7F7Hcse2+5rlgdnq93/RtY8q9rQeP8QRXPwTfbFBEZDgpK5
 ldPWfsUBtj066E1i2YTlHhg8muqx6n5oDg48DjAXD72vxwJ8Nln3cAU8TpN5RaSQw89ylPehUtmDt
 XAgp83uK0LxQh7BW5ORSjYFU2An8nO2I4lSODw24oSItIn+Xl2m3yFQQA8I+DAj2AJJVI8Elv2FA9
 PtxeaYEA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1r5PQ7-00BQUf-0T; Tue, 21 Nov 2023 11:59:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96.2 #2 (Red
 Hat Linux)) id 1r5PQ5-005fd8-2e; Tue, 21 Nov 2023 11:59:57 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Paul Durrant <paul@xen.org>
Subject: [PULL for-8.2 2/2] hw/xen: clean up xen_block_find_free_vdev() to
 avoid Coverity false positive
Date: Tue, 21 Nov 2023 11:59:57 +0000
Message-ID: <20231121115957.1351656-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121115957.1351656-1-dwmw2@infradead.org>
References: <20231121115957.1351656-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+b5dddee4e6bb4f7a8ff0+7394+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Coverity couldn't see that nr_existing was always going to be zero when
qemu_xen_xs_directory() returned NULL in the ENOENT case (CID 1523906).

Perhaps more to the point, neither could Peter at first glance. Improve
the code to hopefully make it clearer to Coverity and human reviewers
alike.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/block/xen-block.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 6d64ede94f..aed1d5c330 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -91,9 +91,27 @@ static bool xen_block_find_free_vdev(XenBlockDevice *blockdev, Error **errp)
 
     existing_frontends = qemu_xen_xs_directory(xenbus->xsh, XBT_NULL, fe_path,
                                                &nr_existing);
-    if (!existing_frontends && errno != ENOENT) {
-        error_setg_errno(errp, errno, "cannot read %s", fe_path);
-        return false;
+    if (!existing_frontends) {
+        if (errno == ENOENT) {
+            /*
+             * If the frontend directory doesn't exist because there are
+             * no existing vbd devices, that's fine. Just ensure that we
+             * don't dereference the NULL existing_frontends pointer, by
+             * checking that nr_existing is zero so the loop below is not
+             * entered.
+             *
+             * In fact this is redundant since nr_existing is initialized
+             * to zero, but setting it again here makes it abundantly clear
+             * to Coverity, and to the human reader who doesn't know the
+             * semantics of qemu_xen_xs_directory() off the top of their
+             * head.
+             */
+            nr_existing = 0;
+        } else {
+            /* All other errors accessing the frontend directory are fatal. */
+            error_setg_errno(errp, errno, "cannot read %s", fe_path);
+            return false;
+        }
     }
 
     memset(used_devs, 0, sizeof(used_devs));
-- 
2.41.0



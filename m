Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C13076AECA
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 11:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQlsF-0003DB-6s; Tue, 01 Aug 2023 05:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570bccec8=anthony.perard@citrix.com>)
 id 1qQls4-00036b-Ug
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:40:56 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570bccec8=anthony.perard@citrix.com>)
 id 1qQls3-0005B8-59
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1690882850;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M3jbWill5Sy9NGpPrccd8eNlL4c/zG31nNIP3712Yu4=;
 b=XZ1s1GAu/2m5NYG+bZBFWQrVkWIOIR0YgWZNewCbjEvJNSjN2inOiXfd
 YLbrqdvgbJkjf5wFZbXGyQ13O/No+EjP9k5Knw6SOTf/Lo91PseQm8j7b
 QQnnTdvnmhN1jy8Nir/j29ax4d5Ou1SfcQhXagMIkUkB7e5i9xPn/gTMB o=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 117381814
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:vJrMnqyAqZ4Ynv8hNfl6t+dYxirEfRIJ4+MujC+fZmUNrF6WrkVUz
 GNNXWGBOv6LZ2ujKd12YYm1oU8D68eBnNVmSVZt+CAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTrafYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EoHUMja4mtC5QRhPqkT5zcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KU4Q2
 vZJb2AIVSiogr+u4pTlavVIgv12eaEHPKtH0p1h5TTQDPJgSpHfWaTao9Rf2V/chOgXQ6yYP
 ZBAL2MyMlKZOUYn1lQ/UfrSmM+hgGX/dDtJ7kqYv6Mt70DYzRBr0airO93QEjCPbZwMwR3I/
 zKfowwVBDkDGMCn8Qfa6EiOxeHAjSz8VbwJFfqBo6sCbFq7mTVIVUx+uUGAieC0j1P7V99BJ
 kg8/C0ooq4vskuxQbHVUwK9v1aNuxcOXNwWGOp89QLl90bPy1/HXC5eFGcHMYF48pZsHlTGy
 2NlgfvGWxNl4frFTEml3bLJtRGUZwgJCWs7MHpsoRQ+3zXznG0ipkuRH44zT/Hv14Wd9SLYm
 G7T8nVn71kHpYtSjvjgowia6965jsKRJjPZ8Dk7SY5MAulRQIe+L7Kl5lHAhRqrBNbIFwLR1
 JTodiX30QzvMX1uvHbXKAn1NOv1j8tpyRWF6bKVI7Ev9i6251modp1K7Td1KS9Ba5hVIW+zM
 BOM5V8Lu/e/2UdGiocuMuqM5zkCl/C8RbwJqNiKBjaxXnSBXFDep3w/DaJh92vsjFItgckC1
 WSzKK6R4YIhIf0/llKeHr5NuYLHMwhinQs/s7inlUX4uVdfDVbJIYo43KymNLBltfnZ8VqPq
 r6y9aKikn1ibQE3WQGPmaZ7ELzABSJT6UzewyCPStO+Hw==
IronPort-HdrOrdr: A9a23:UrP68q4pht2IwiGwMgPXwKvXdLJyesId70hD6qkRc3xom6mj/P
 xG88536faZslwssRIb+OxoRpPufZq0z/cc3WB7B9uftWfd1leVEA==
X-Talos-CUID: =?us-ascii?q?9a23=3Al8Tz0GmARsf6cByuIV/OOGojuNjXOVKD432BZB+?=
 =?us-ascii?q?9Ml5CTeCNa3nO2L9Al/M7zg=3D=3D?=
X-Talos-MUID: 9a23:fCGVhAoUXqNl4JEPHkUezyhOKP9Q3vu0MmJOn5oWtM6JCzdxfA7I2Q==
X-IronPort-AV: E=Sophos;i="6.01,246,1684814400"; d="scan'208";a="117381814"
To: <qemu-devel@nongnu.org>
CC: David Woodhouse <dwmw@amazon.co.uk>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 1/5] hw/xen: Clarify (lack of) error handling in
 transaction_commit()
Date: Tue, 1 Aug 2023 10:40:34 +0100
Message-ID: <20230801094038.11026-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801094038.11026-1-anthony.perard@citrix.com>
References: <20230801094038.11026-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.155.175;
 envelope-from=prvs=570bccec8=anthony.perard@citrix.com;
 helo=esa6.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: David Woodhouse <dwmw@amazon.co.uk>

Coverity was unhappy (CID 1508359) because we didn't check the return of
init_walk_op() in transaction_commit(), despite doing so at every other
call site.

Strictly speaking, this is a false positive since it can never fail. It
only fails for invalid user input (transaction ID or path), and both of
those are hard-coded to known sane values in this invocation.

But Coverity doesn't know that, and neither does the casual reader of the
code.

Returning an error here would be weird, since the transaction *is*
committed by this point; all the walk_op is doing is firing watches on
the newly-committed changed nodes. So make it a g_assert(!ret), since
it really should never happen.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20076888f6bdf06a65aafc5cf954260965d45b97.camel@infradead.org>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/kvm/xenstore_impl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/i386/kvm/xenstore_impl.c b/hw/i386/kvm/xenstore_impl.c
index 305fe75519..d9732b567e 100644
--- a/hw/i386/kvm/xenstore_impl.c
+++ b/hw/i386/kvm/xenstore_impl.c
@@ -1022,6 +1022,7 @@ static int transaction_commit(XenstoreImplState *s, XsTransaction *tx)
 {
     struct walk_op op;
     XsNode **n;
+    int ret;
 
     if (s->root_tx != tx->base_tx) {
         return EAGAIN;
@@ -1032,7 +1033,16 @@ static int transaction_commit(XenstoreImplState *s, XsTransaction *tx)
     s->root_tx = tx->tx_id;
     s->nr_nodes = tx->nr_nodes;
 
-    init_walk_op(s, &op, XBT_NULL, tx->dom_id, "/", &n);
+    ret = init_walk_op(s, &op, XBT_NULL, tx->dom_id, "/", &n);
+    /*
+     * There are two reasons why init_walk_op() may fail: an invalid tx_id,
+     * or an invalid path. We pass XBT_NULL and "/", and it cannot fail.
+     * If it does, the world is broken. And returning 'ret' would be weird
+     * because the transaction *was* committed, and all this tree walk is
+     * trying to do is fire the resulting watches on newly-committed nodes.
+     */
+    g_assert(!ret);
+
     op.deleted_in_tx = false;
     op.mutating = true;
 
-- 
Anthony PERARD



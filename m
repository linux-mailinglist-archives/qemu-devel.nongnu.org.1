Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A637A237C
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:22:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBYc-0005KZ-HF; Fri, 15 Sep 2023 12:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhBYP-0005CV-87; Fri, 15 Sep 2023 12:20:25 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhBYN-0000Rq-2G; Fri, 15 Sep 2023 12:20:24 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qhBUx-00Ezdu-0n;
 Fri, 15 Sep 2023 18:20:15 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 1/8] qemu-img: rebase: stop when reaching EOF of old
 backing file
Date: Fri, 15 Sep 2023 19:20:09 +0300
Message-Id: <20230915162016.141771-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
From:  Andrey Drobyshev via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

In case when we're rebasing within one backing chain, and when target image
is larger than old backing file, bdrv_is_allocated_above() ends up setting
*pnum = 0.  As a result, target offset isn't getting incremented, and we
get stuck in an infinite for loop.  Let's detect this case and proceed
further down the loop body, as the offsets beyond the old backing size need
to be explicitly zeroed.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 qemu-img.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index a48edb7101..50660ba920 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3805,6 +3805,8 @@ static int img_rebase(int argc, char **argv)
             }
 
             if (prefix_chain_bs) {
+                uint64_t bytes = n;
+
                 /*
                  * If cluster wasn't changed since prefix_chain, we don't need
                  * to take action
@@ -3817,9 +3819,18 @@ static int img_rebase(int argc, char **argv)
                                  strerror(-ret));
                     goto out;
                 }
-                if (!ret) {
+                if (!ret && n) {
                     continue;
                 }
+                if (!n) {
+                    /*
+                     * If we've reached EOF of the old backing, it means that
+                     * offsets beyond the old backing size were read as zeroes.
+                     * Now we will need to explicitly zero the cluster in
+                     * order to preserve that state after the rebase.
+                     */
+                    n = bytes;
+                }
             }
 
             /*
-- 
2.39.3



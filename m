Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0F67D1877
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:57:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtxTx-0003qQ-34; Fri, 20 Oct 2023 17:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTs-0003mU-EM; Fri, 20 Oct 2023 17:56:32 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTq-0008G3-NA; Fri, 20 Oct 2023 17:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=Xc0s5rzni+x47c5YoKWzgM1EXDpgmhujUFkXgIBX2Ec=; b=Ys4kzVyyw8Ap
 cHO1/oos/k/dlUAxWrB8wpwE5gT2fbCiawE1Upl9KOr2hW+MTJ5M3B/ilCOP40UfUhr2E9lok61+4
 cXhi/1ReNLVfDS6ysR+HqKUgG3KSy2Tt9IGSPXKjnT1uV+9SRgyRU5yvQyQbleGIYUYAmYj1gYZi6
 myocjmAJWTzATKJXBNJc+sMcw7Yr4bzR7nz+bt4tU7G2JR5CSBhwJn1YORKviMDyZdOGAnV/UEIb6
 WzAcnP0QJC5Z4bK0Hfl/UStde/4DH5+ynEtfvznLt92XoTReD2GOslURBQFeKJSJ+uO4C6AyOpRFu
 4yT35uXrG8HQ8kzr1OPW7Q==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qtxTT-00A9pF-2d;
 Fri, 20 Oct 2023 23:56:20 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH 6/7] iotests/common.rc: add disk_usage function
Date: Sat, 21 Oct 2023 00:56:21 +0300
Message-Id: <20231020215622.789260-7-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Move the definition from iotests/250 to common.rc.  This is used to
detect real disk usage of sparse files.  In particular, we want to use
it for checking subclusters-based discards.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/250       | 5 -----
 tests/qemu-iotests/common.rc | 6 ++++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
index af48f83aba..c0a0dbc0ff 100755
--- a/tests/qemu-iotests/250
+++ b/tests/qemu-iotests/250
@@ -52,11 +52,6 @@ _unsupported_imgopts data_file
 # bdrv_co_truncate(bs->file) call in qcow2_co_truncate(), which might succeed
 # anyway.
 
-disk_usage()
-{
-    du --block-size=1 $1 | awk '{print $1}'
-}
-
 size=2100M
 
 _make_test_img -o "cluster_size=1M,preallocation=metadata" $size
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 95c12577dd..5d2ea26c7f 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -140,6 +140,12 @@ _optstr_add()
     fi
 }
 
+# report real disk usage for sparse files
+disk_usage()
+{
+    du --block-size=1 $1 | awk '{print $1}'
+}
+
 # Set the variables to the empty string to turn Valgrind off
 # for specific processes, e.g.
 # $ VALGRIND_QEMU_IO= ./check -qcow2 -valgrind 015
-- 
2.39.3



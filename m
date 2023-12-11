Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3F880CB15
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:33:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgOw-0000XS-Il; Mon, 11 Dec 2023 08:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rCgOe-00007S-Jn; Mon, 11 Dec 2023 08:32:32 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rCgOb-00029U-Bp; Mon, 11 Dec 2023 08:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=MrAjrlwGGat3xO6OBtrWFbhQBphjfZVOk2fzVKzqyfs=; b=qm9at66Z14fs
 HqAirXrXWEDZhTMjMSPC7fYJQcYBDxtSHFUR4DkM4keyNs4ROb/FebCykpHYnoW6E3CuK9NqvUf1e
 NJOTLY04VhrFlFzPD7qGd/3vEFWaC2KuSbmPP2OV0T2NAIXduJ2GiFY4UCYoLLQX+Hua9Z0WTV4kH
 mDuwD5OdX3UtCXIzRrlDsvleh/kg7Xv2kth+FPrE31cTi4P3WEfCQgtADEK8RkMzRFeudFal1n99o
 jSG16YP87GskXkq3CyyTj24uu8mE6P7lq8OvJMAOH9MEiLFhCZu9hfCktAjAv3B4WRsiYYgcuqzXX
 2TYdwXaVayxfpVmYpzGL2A==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rCgMg-000OBz-2v;
 Mon, 11 Dec 2023 14:32:15 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH] iotests: don't run tests requiring cached writes in
 '-nocache' mode
Date: Mon, 11 Dec 2023 15:32:23 +0200
Message-Id: <20231211133223.695048-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There're tests whose logic implies running without O_DIRECT set,
otherwise they fail when running iotests in '-nocache' mode.  For these
tests let's add _require_no_o_direct() helper which can be put in the
preabmle and which makes sure '-nocache' isn't set.  Use it to skip
running the following tests:

  * 271: creates files with unaligned sizes, thus producing multiple
    errors like:

qemu-io: can't open device /path/to/t.qcow2.raw: Cannot get 'write'
permission without 'resize': Image size is not a multiple of request alignment

  * 308, file-io-error: use fuse exports.  Though fuse does have
    'direct-io' mode (see https://docs.kernel.org/filesystems/fuse-io.html)
    we aren't using it yet, thus getting errors like:

qemu-io: can't open device /path/to/t.qcow2.fuse: Could not open
'/path/to/t.qcow2.fuse': filesystem does not support O_DIRECT

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/271                 | 1 +
 tests/qemu-iotests/308                 | 2 ++
 tests/qemu-iotests/common.rc           | 7 +++++++
 tests/qemu-iotests/tests/file-io-error | 1 +
 4 files changed, 11 insertions(+)

diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
index 59a6fafa2f..1424b6954d 100755
--- a/tests/qemu-iotests/271
+++ b/tests/qemu-iotests/271
@@ -44,6 +44,7 @@ _supported_fmt qcow2
 _supported_proto file nfs
 _supported_os Linux
 _unsupported_imgopts extended_l2 compat=0.10 cluster_size data_file refcount_bits=1[^0-9]
+_require_no_o_direct
 
 l2_offset=$((0x40000))
 
diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index de12b2b1b9..535455e5b1 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -52,6 +52,8 @@ _unsupported_fmt vpc
 _supported_proto file # We create the FUSE export manually
 _supported_os Linux # We need /dev/urandom
 
+_require_no_o_direct
+
 # $1: Export ID
 # $2: Options (beyond the node-name and ID)
 # $3: Expected return value (defaults to 'return')
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 95c12577dd..f61eae73b4 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -857,6 +857,13 @@ _check_o_direct()
     [[ "$out" != *"O_DIRECT"* ]]
 }
 
+_require_no_o_direct()
+{
+    if [ $CACHEMODE == "none" ] || [ $CACHEMODE == "directsync" ]; then
+        _notrun "not suitable for cache mode: $CACHEMODE (implies O_DIRECT)"
+    fi
+}
+
 _require_o_direct()
 {
     if ! _check_o_direct; then
diff --git a/tests/qemu-iotests/tests/file-io-error b/tests/qemu-iotests/tests/file-io-error
index 88ee5f670c..2b8dc7f009 100755
--- a/tests/qemu-iotests/tests/file-io-error
+++ b/tests/qemu-iotests/tests/file-io-error
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Format-agnostic (we do not use any), but we do test the file protocol
 _supported_proto file
 _require_drivers blkdebug null-co
+_require_no_o_direct
 
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     # We need `$QEMU_IO -f file` to work; IMGOPTSSYNTAX uses --image-opts,
-- 
2.39.3



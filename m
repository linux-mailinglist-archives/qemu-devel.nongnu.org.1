Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B01DA78D57
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Apr 2025 13:43:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzwUS-0008Hu-HR; Wed, 02 Apr 2025 07:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tzwU5-0008AP-Eq
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 07:42:18 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tzwU2-0005CF-Ve
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 07:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=eoXv/xyCBvc7s2R5XFDgF88Pd1Lj63Pw7DD6aVldapg=; b=OzfEX1nr7rcZJ4X
 fxWAEW030zb16+A6NewtVvkBsh6Lb9+rGTzxGIvapnLILcnMTYTH1JOUcvFnF4ey12updskgJjyo0
 45QMqUMAgBoc1TgudwYuaC1X7hXsuGsPCaBxAKhjGmQ1KZZngoyXfFK75r+xoLdYVKEr11HK7sdHh
 7A=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, brian.cain@oss.qualcomm.com,
 philmd@linaro.org
Subject: [PATCH v2 1/2] target/hexagon: Replace `prepare` script with meson
 target
Date: Wed,  2 Apr 2025 13:42:58 +0200
Message-ID: <20250402114259.21953-2-anjo@rev.ng>
In-Reply-To: <20250402114259.21953-1-anjo@rev.ng>
References: <20250402114259.21953-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The purpose of the prepare script is to invoke `cpp` to preprocess input
to idef-parser by expanding a few select macros.  On macOS `cpp`
expands into `clang ... -traditional-cpp` which breaks macro
concatenation.  Replace `cpp` with `${compiler} -E`
and replace the script with a meson custom_target.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/idef-parser/prepare | 24 ------------------------
 target/hexagon/meson.build         |  3 ++-
 2 files changed, 2 insertions(+), 25 deletions(-)
 delete mode 100755 target/hexagon/idef-parser/prepare

diff --git a/target/hexagon/idef-parser/prepare b/target/hexagon/idef-parser/prepare
deleted file mode 100755
index cb3622d4f8..0000000000
--- a/target/hexagon/idef-parser/prepare
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/usr/bin/env bash
-
-#
-#  Copyright(c) 2019-2021 rev.ng Labs Srl. All Rights Reserved.
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
-
-set -e
-set -o pipefail
-
-# Run the preprocessor and drop comments
-cpp "$@"
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index bb4ebaae81..abcf00ca1f 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -280,12 +280,13 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
         command: [python, files('gen_idef_parser_funcs.py'), semantics_generated, '@OUTPUT@'],
     )
 
+    compiler = meson.get_compiler('c').get_id()
     preprocessed_idef_parser_input_generated = custom_target(
         'idef_parser_input.preprocessed.h.inc',
         output: 'idef_parser_input.preprocessed.h.inc',
         input: idef_parser_input_generated,
         depend_files: [idef_parser_dir / 'macros.h.inc'],
-        command: [idef_parser_dir / 'prepare', '@INPUT@', '-I' + idef_parser_dir, '-o', '@OUTPUT@'],
+        command: [compiler, '-x', 'c', '-E', '-I', idef_parser_dir, '-o', '@OUTPUT@', '@INPUT@'],
     )
 
     flex = generator(
-- 
2.47.1



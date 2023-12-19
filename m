Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A1D8185B8
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 11:54:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFXib-0002um-16; Tue, 19 Dec 2023 05:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ncopa@alpinelinux.org>)
 id 1rFXiV-0002uS-UT; Tue, 19 Dec 2023 05:52:52 -0500
Received: from smtp.alpinelinux.org ([2a01:7e00:e000:2fc::20]
 helo=gbr-app-1.alpinelinux.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ncopa@alpinelinux.org>)
 id 1rFXiS-0007SS-TA; Tue, 19 Dec 2023 05:52:50 -0500
Received: from ncopa-desktop.lan (ti0056a400-5190.bb.online.no [85.167.243.86])
 (Authenticated sender: ncopa@alpinelinux.org)
 by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id BC363225CC6;
 Tue, 19 Dec 2023 10:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
 s=smtp; t=1702983165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=W7DKH0RcWpSv8kJA0aFEnnjLWfZkfoyM//6B54IwXh0=;
 b=OSDPBwHAEjca3TNID7/KH/Dlzk6GVL18MbOMVVwk/IpifVDxiZ+x9jmnjQgMveC7sp9vbd
 DhRDji4q/hWUo9YsG3j4URXx/Q+7xYzCIlXsgKVajUyFF73RZvIVFpwMlRAYWGi5/cdTxs
 JjDYc930IA892H9/6+0C41adnbZeN4Y=
From: Natanael Copa <ncopa@alpinelinux.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Natanael Copa <ncopa@alpinelinux.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] util: fix build with musl libc on ppc64le
Date: Tue, 19 Dec 2023 11:51:29 +0100
Message-ID: <20231219105236.7059-1-ncopa@alpinelinux.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:7e00:e000:2fc::20;
 envelope-from=ncopa@alpinelinux.org; helo=gbr-app-1.alpinelinux.org
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

Use PPC_FEATURE2_ISEL and PPC_FEATURE2_VEC_CRYPTO from linux headers
instead of the GNU specific PPC_FEATURE2_HAS_ISEL and
PPC_FEATURE2_HAS_VEC_CRYPTO. This fixes build with musl libc.

Fixes: 623d7e3551a6 (util: Add cpuinfo-ppc.c)
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1861

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---
 util/cpuinfo-ppc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
index 1ea3db0ac8..b2d8893a06 100644
--- a/util/cpuinfo-ppc.c
+++ b/util/cpuinfo-ppc.c
@@ -6,10 +6,10 @@
 #include "qemu/osdep.h"
 #include "host/cpuinfo.h"
 
+#include <asm/cputable.h>
 #ifdef CONFIG_GETAUXVAL
 # include <sys/auxv.h>
 #else
-# include <asm/cputable.h>
 # include "elf.h"
 #endif
 
@@ -40,7 +40,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         info |= CPUINFO_V2_06;
     }
 
-    if (hwcap2 & PPC_FEATURE2_HAS_ISEL) {
+    if (hwcap2 & PPC_FEATURE2_ISEL) {
         info |= CPUINFO_ISEL;
     }
     if (hwcap & PPC_FEATURE_HAS_ALTIVEC) {
@@ -53,7 +53,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
              * always have both anyway, since VSX came with Power7
              * and crypto came with Power8.
              */
-            if (hwcap2 & PPC_FEATURE2_HAS_VEC_CRYPTO) {
+            if (hwcap2 & PPC_FEATURE2_VEC_CRYPTO) {
                 info |= CPUINFO_CRYPTO;
             }
         }
-- 
2.43.0



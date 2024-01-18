Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC89831982
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:52:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRrc-0003pr-Rk; Thu, 18 Jan 2024 07:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQRrZ-0003ob-M8; Thu, 18 Jan 2024 07:51:17 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQRrX-0000Wx-P8; Thu, 18 Jan 2024 07:51:17 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7BABB452CD;
 Thu, 18 Jan 2024 15:51:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3EE2E668C1;
 Thu, 18 Jan 2024 15:50:57 +0300 (MSK)
Received: (nullmailer pid 2502749 invoked by uid 1000);
 Thu, 18 Jan 2024 12:50:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Natanael Copa <ncopa@alpinelinux.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.5 08/11] util: fix build with musl libc on ppc64le
Date: Thu, 18 Jan 2024 15:50:46 +0300
Message-Id: <20240118125056.2502687-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.5-20240118154659@cover.tls.msk.ru>
References: <qemu-stable-8.1.5-20240118154659@cover.tls.msk.ru>
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

From: Natanael Copa <ncopa@alpinelinux.org>

Use PPC_FEATURE2_ISEL and PPC_FEATURE2_VEC_CRYPTO from linux headers
instead of the GNU specific PPC_FEATURE2_HAS_ISEL and
PPC_FEATURE2_HAS_VEC_CRYPTO. This fixes build with musl libc.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1861
Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
Fixes: 63922f467a ("tcg/ppc: Replace HAVE_ISEL macro with a variable")
Fixes: 68f340d4cd ("tcg/ppc: Enable Altivec detection")
Message-Id: <20231219105236.7059-1-ncopa@alpinelinux.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 1d513e06d96697f44de4a1b85c6ff627c443e306)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/cpuinfo-ppc.c b/util/cpuinfo-ppc.c
index 7212afa45d..990e62e141 100644
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
2.39.2



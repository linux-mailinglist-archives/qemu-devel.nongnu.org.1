Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD09A1D86C
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Jan 2025 15:31:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQ5G-000166-PO; Mon, 27 Jan 2025 09:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ57-0000nv-Gj; Mon, 27 Jan 2025 09:27:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcQ55-0003Pi-S1; Mon, 27 Jan 2025 09:27:17 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id EBCF0E0F97;
 Mon, 27 Jan 2025 17:26:46 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id BBF0F51DB5; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Tao Su <tao1.su@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 40/41] i386/cpu: Mark avx10_version filtered when
 prefix is NULL
Date: Mon, 27 Jan 2025 17:17:54 +0300
Message-Id: <20250127141803.3514882-40-mjt@tls.msk.ru>
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

From: Zhao Liu <zhao1.liu@intel.com>

In x86_cpu_filter_features(), if host doesn't support AVX10, the
configured avx10_version should be marked as filtered regardless of
whether prefix is NULL or not.

Check prefix before warn_report() instead of checking for
have_filtered_features.

Cc: qemu-stable@nongnu.org
Fixes: commit bccfb846fd52 ("target/i386: add AVX10 feature and AVX10 version property")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241106030728.553238-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit cf4c263551886964c5d58bd7b675b13fd497b402)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index aff5e917db..348771bd74 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7719,8 +7719,10 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
             env->avx10_version = version;
             have_filtered_features = true;
         }
-    } else if (env->avx10_version && prefix) {
-        warn_report("%s: avx10.%d.", prefix, env->avx10_version);
+    } else if (env->avx10_version) {
+        if (prefix) {
+            warn_report("%s: avx10.%d.", prefix, env->avx10_version);
+        }
         have_filtered_features = true;
     }
 
-- 
2.39.5



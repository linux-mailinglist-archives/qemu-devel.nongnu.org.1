Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD467A8720B
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Apr 2025 15:01:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3wwR-0000vf-1E; Sun, 13 Apr 2025 09:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1u3wwB-0000ry-BW; Sun, 13 Apr 2025 08:59:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1u3ww9-0007v3-MB; Sun, 13 Apr 2025 08:59:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5BFD7116A4F;
 Sun, 13 Apr 2025 15:57:57 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E9D451EEE7C;
 Sun, 13 Apr 2025 15:59:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D4EF858527; Sun, 13 Apr 2025 15:59:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 3/3] docs: Document removal of 64-bit on 32-bit emulation
Date: Sun, 13 Apr 2025 15:59:37 +0300
Message-Id: <20250413125937.2448971-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250413125937.2448971-1-mjt@tls.msk.ru>
References: <20250413125937.2448971-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

With acce728cbc6c we disallowed configuring 64-bit guests on
32-bit hosts, but forgot to document that in removed-features.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/about/removed-features.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 2527a91795..790a5e481c 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -858,6 +858,15 @@ QEMU.  Since all recent x86 hardware from the past >10 years is
 capable of the 64-bit x86 extensions, a corresponding 64-bit OS should
 be used instead.
 
+32-bit hosts for 64-bit guests (removed in 10.0)
+''''''''''''''''''''''''''''''''''''''''''''''''
+
+In general, 32-bit hosts cannot support the memory space or atomicity
+requirements of 64-bit guests.  Prior to 10.0, QEMU attempted to
+work around the atomicity issues in system mode by running all vCPUs
+in a single thread context; in user mode atomicity was simply broken.
+From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
+
 Guest Emulator ISAs
 -------------------
 
-- 
2.39.5



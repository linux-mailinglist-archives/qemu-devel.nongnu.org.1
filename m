Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A58829D1FFA
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Nov 2024 07:07:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDHLy-000162-6U; Tue, 19 Nov 2024 01:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tDHLt-00012Z-DD; Tue, 19 Nov 2024 01:04:41 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tDHLr-0004eJ-5m; Tue, 19 Nov 2024 01:04:41 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D04A4A6264;
 Tue, 19 Nov 2024 09:04:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 042E91738DA;
 Tue, 19 Nov 2024 09:04:19 +0300 (MSK)
Received: (nullmailer pid 2368938 invoked by uid 1000);
 Tue, 19 Nov 2024 06:04:18 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 62/72] accel/tcg: Fix user-only probe_access_internal
 plugin check
Date: Tue, 19 Nov 2024 09:04:03 +0300
Message-Id: <20241119060418.2368866-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241118224223@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241118224223@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The acc_flag check for write should have been against PAGE_WRITE_ORG,
not PAGE_WRITE.  But it is better to combine two acc_flag checks
to a single check against access_type.  This matches the system code
in cputlb.c.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2647
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: 20241111145002.144995-1-richard.henderson@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
(cherry picked from commit 2a339fee450638b512c5122281cb5ab49331cfb8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 7ddc47b0ba..4c269daf7d 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -805,7 +805,7 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
     if (guest_addr_valid_untagged(addr)) {
         int page_flags = page_get_flags(addr);
         if (page_flags & acc_flag) {
-            if ((acc_flag == PAGE_READ || acc_flag == PAGE_WRITE)
+            if (access_type != MMU_INST_FETCH
                 && cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
                 return TLB_MMIO;
             }
-- 
2.39.5



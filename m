Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FF589EC5B
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Apr 2024 09:40:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSNF-00030q-TI; Wed, 10 Apr 2024 03:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSM2-0008GV-Ew; Wed, 10 Apr 2024 03:26:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSLy-0004fU-2x; Wed, 10 Apr 2024 03:26:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4DBA95D698;
 Wed, 10 Apr 2024 10:25:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E4668B02D8;
 Wed, 10 Apr 2024 10:23:06 +0300 (MSK)
Received: (nullmailer pid 4191768 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tao Su <tao1.su@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 40/87] target/i386: Revert monitor_puts() in
 do_inject_x86_mce()
Date: Wed, 10 Apr 2024 10:22:13 +0300
Message-Id: <20240410072303.4191455-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Tao Su <tao1.su@linux.intel.com>

monitor_puts() doesn't check the monitor pointer, but do_inject_x86_mce()
may have a parameter with NULL monitor pointer. Revert monitor_puts() in
do_inject_x86_mce() to fix, then the fact that we send the same message to
monitor and log is again more obvious.

Fixes: bf0c50d4aa85 (monitor: expose monitor_puts to rest of code)
Reviwed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Message-ID: <20240320083640.523287-1-tao1.su@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 7fd226b04746f0be0b636de5097f1b42338951a0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 2070dd0dda..23ccb23a5b 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -430,7 +430,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
         if (need_reset) {
             emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
                                       recursive);
-            monitor_puts(params->mon, msg);
+            monitor_printf(params->mon, "%s", msg);
             qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;
-- 
2.39.2



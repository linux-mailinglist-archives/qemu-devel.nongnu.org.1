Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3EE9C2C86
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 13:09:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kGp-0000Je-RB; Sat, 09 Nov 2024 07:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kGm-0000B8-Hr; Sat, 09 Nov 2024 07:08:48 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kGk-0003mx-SC; Sat, 09 Nov 2024 07:08:48 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4D3C0A15F3;
 Sat,  9 Nov 2024 15:07:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 14BB1167F81;
 Sat,  9 Nov 2024 15:08:02 +0300 (MSK)
Received: (nullmailer pid 3295283 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 11/57] linux-user/flatload: Take mmap_lock in
 load_flt_binary()
Date: Sat,  9 Nov 2024 15:07:13 +0300
Message-Id: <20241109120801.3295120-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
References: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

load_flt_binary() calls load_flat_file() -> page_set_flags().

page_set_flags() must be called with the mmap_lock held,
otherwise it aborts:

  $ qemu-arm -L stm32/lib/ stm32/bin/busybox
  qemu-arm: ../accel/tcg/user-exec.c:505: page_set_flags: Assertion `have_mmap_lock()' failed.
  Aborted (core dumped)

Fix by taking the lock in load_flt_binary().

Fixes: fbd3c4cff6 ("linux-user/arm: Mark the commpage executable")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2525
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240822095045.72643-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit a9ee641bd46f5462eeed183ac3c3760bddfc2600)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 5b62aa0a2b..6278655574 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -747,7 +747,10 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
     stack_len += (bprm->envc + 1) * 4; /* the envp array */
 
 
+    mmap_lock();
     res = load_flat_file(bprm, libinfo, 0, &stack_len);
+    mmap_unlock();
+
     if (is_error(res)) {
             return res;
     }
-- 
2.39.5



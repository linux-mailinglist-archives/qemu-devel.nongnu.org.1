Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABBD9C2CD1
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 13:17:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kKI-0007is-B5; Sat, 09 Nov 2024 07:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kKB-0007Uv-E0; Sat, 09 Nov 2024 07:12:19 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kK9-0004Kw-74; Sat, 09 Nov 2024 07:12:19 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A6B78A1608;
 Sat,  9 Nov 2024 15:07:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6E251167F96;
 Sat,  9 Nov 2024 15:08:03 +0300 (MSK)
Received: (nullmailer pid 3295351 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yao Zi <ziyao@disroot.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 32/57] linux-user/riscv: Fix definition of
 RISCV_HWPROBE_EXT_ZVFHMIN
Date: Sat,  9 Nov 2024 15:07:34 +0300
Message-Id: <20241109120801.3295120-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
References: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Yao Zi <ziyao@disroot.org>

Current definition yields a negative 32bits value, messing up hwprobe
result when Zvfhmin extension presents. Replace it by using a 1ULL bit
shift value as done in kernel upstream.

Link: https://github.com/torvalds/linux/commit/5ea6764d9095e234b024054f75ebbccc4f0eb146
Fixes: a3432cf227 ("linux-user/riscv: Sync hwprobe keys with Linux")
Cc: qemu-stable@nongnu.org
Signed-off-by: Yao Zi <ziyao@disroot.org>
Message-ID: <20241022160136.21714-2-ziyao@disroot.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 310df7a9fe400f32cde8a7edf80daad12cd9cf02)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index caa91c3b1d..8b29b07e47 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8855,7 +8855,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define     RISCV_HWPROBE_EXT_ZFHMIN        (1 << 28)
 #define     RISCV_HWPROBE_EXT_ZIHINTNTL     (1 << 29)
 #define     RISCV_HWPROBE_EXT_ZVFH          (1 << 30)
-#define     RISCV_HWPROBE_EXT_ZVFHMIN       (1 << 31)
+#define     RISCV_HWPROBE_EXT_ZVFHMIN       (1ULL << 31)
 #define     RISCV_HWPROBE_EXT_ZFA           (1ULL << 32)
 #define     RISCV_HWPROBE_EXT_ZTSO          (1ULL << 33)
 #define     RISCV_HWPROBE_EXT_ZACAS         (1ULL << 34)
-- 
2.39.5



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3007708E6
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:21:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0ID-0000Ge-Ro; Fri, 04 Aug 2023 15:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IB-0000GB-Ef; Fri, 04 Aug 2023 15:16:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0I9-0006sg-NV; Fri, 04 Aug 2023 15:16:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 94FFC18452;
 Fri,  4 Aug 2023 22:17:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 330E41B895;
 Fri,  4 Aug 2023 22:16:49 +0300 (MSK)
Received: (nullmailer pid 1875686 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 04/63] linux-user: Fix fcntl() and fcntl64() to return
 O_LARGEFILE for 32-bit targets
Date: Fri,  4 Aug 2023 22:16:15 +0300
Message-Id: <20230804191647.1875608-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
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

From: Helge Deller <deller@gmx.de>

When running a 32-bit guest on a 64-bit host, fcntl[64](F_GETFL) should
return with the TARGET_O_LARGEFILE flag set, because all 64-bit hosts
support large files unconditionally.

But on 64-bit hosts, O_LARGEFILE has the value 0, so the flag
translation can't be done with the fcntl_flags_tbl[]. Instead add the
TARGET_O_LARGEFILE flag afterwards.

Note that for 64-bit guests the compiler will optimize away this code,
since TARGET_O_LARGEFILE is zero.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit e0ddf8eac9f83c0bc5a3d39605d873ee0fe53421)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 333e6b7026..011cadb281 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7132,6 +7132,10 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
         ret = get_errno(safe_fcntl(fd, host_cmd, arg));
         if (ret >= 0) {
             ret = host_to_target_bitmask(ret, fcntl_flags_tbl);
+            /* tell 32-bit guests it uses largefile on 64-bit hosts: */
+            if (O_LARGEFILE == 0 && HOST_LONG_BITS == 64) {
+                ret |= TARGET_O_LARGEFILE;
+            }
         }
         break;
 
-- 
2.39.2



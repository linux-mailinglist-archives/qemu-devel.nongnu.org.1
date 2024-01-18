Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EC583137A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:58:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNED-0000Q2-MN; Thu, 18 Jan 2024 02:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNEA-0000Of-PO; Thu, 18 Jan 2024 02:54:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNE9-0007KT-89; Thu, 18 Jan 2024 02:54:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2E0C245030;
 Thu, 18 Jan 2024 10:54:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5A05C66199;
 Thu, 18 Jan 2024 10:54:05 +0300 (MSK)
Received: (nullmailer pid 2381646 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 06/38] configure: use a native non-cross compiler for
 linux-user
Date: Thu, 18 Jan 2024 10:52:33 +0300
Message-Id: <20240118075404.2381519-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Commit c2118e9e1ab ("configure: don't try a "native" cross for linux-user",
2023-11-23) sought to avoid issues with using the native compiler with a
cross-endian or cross-bitness setup.  However, in doing so it ended up
requiring a cross compiler setup (and most likely a slow compiler setup)
even when building TCG tests that are native to the host architecture.
Always allow the host compiler in that case.

Cc: qemu-stable@nongnu.org
Fixes: c2118e9e1ab ("configure: don't try a "native" cross for linux-user", 2023-11-23)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 007531586aa8ef6dccdadd927b89a50af62288d1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/configure b/configure
index bdda912f36..d7e0926ff1 100755
--- a/configure
+++ b/configure
@@ -1387,8 +1387,8 @@ probe_target_compiler() {
   done
 
   try=cross
-  # For softmmu/roms we might be able to use the host compiler
-  if [ "${1%softmmu}" != "$1" ]; then
+  # For softmmu/roms also look for a bi-endian or multilib-enabled host compiler
+  if [ "${1%softmmu}" != "$1" ] || test "$target_arch" = "$cpu"; then
       case "$target_arch:$cpu" in
         aarch64_be:aarch64 | \
         armeb:arm | \
-- 
2.39.2



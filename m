Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8727A3242
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 21:34:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhb2H-00024A-Eg; Sat, 16 Sep 2023 15:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1qhb2F-00023G-Na; Sat, 16 Sep 2023 15:32:55 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1qhb2E-0001wR-CC; Sat, 16 Sep 2023 15:32:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3ADE360FE2;
 Sat, 16 Sep 2023 19:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1436AC433C7;
 Sat, 16 Sep 2023 19:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694892772;
 bh=J5VDXnfGUZvK4hLnh4py748vturUYsSJflWPNbJhQno=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UkNbRBXzu3NVRey9XpqkHMY3QJ26VQiyNRhZ9dwi7mHLwnKsY/ifB1iR1+ezx11nE
 1XfaOJlaCXg+s9TpQikxlzBKfkBi19zEQldPbTsh0f3Thh97Dh6ebRck/u0uzXG8Am
 hjY4fsBLOiuth1FQOzpuWzurI6nhBoUmLzqAuk8i9tYyCjihtMGxXznmqkTnm4Bm+c
 FeWmkNR7++IuDAuwKDcmwOyTzNxmAm/lAxbeocsyYXFZIUlLpjADHcweuhASbAcrU1
 FhHi+aTS2RhNMqBn7tXG5ojnrWyDGsZoJJQQD3NoEdYIoXtieMGgmGMrhUiIMQKxm8
 Dr6XRIkiBZPBQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Mikulas Patocka <mpatocka@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL 8/8] linux-user/hppa: lock both words of function descriptor
Date: Sat, 16 Sep 2023 21:32:34 +0200
Message-ID: <20230916193235.169988-9-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230916193235.169988-1-deller@kernel.org>
References: <20230916193235.169988-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mikulas Patocka <mpatocka@redhat.com>

The code in setup_rt_frame reads two words at haddr, but locks only one.
This patch fixes it to lock both.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Acked-by: Helge Deller <deller@gmx.de>
Cc: qemu-stable@nongnu.org
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/hppa/signal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index 3a976ac693..bda6e54655 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -149,12 +149,13 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         target_ulong *fdesc, dest;
 
         haddr &= -4;
-        if (!lock_user_struct(VERIFY_READ, fdesc, haddr, 1)) {
+        fdesc = lock_user(VERIFY_READ, haddr, 2 * sizeof(target_ulong), 1);
+        if (!fdesc) {
             goto give_sigsegv;
         }
         __get_user(dest, fdesc);
         __get_user(env->gr[19], fdesc + 1);
-        unlock_user_struct(fdesc, haddr, 1);
+        unlock_user(fdesc, haddr, 0);
         haddr = dest;
     }
     env->iaoq_f = haddr;
-- 
2.41.0



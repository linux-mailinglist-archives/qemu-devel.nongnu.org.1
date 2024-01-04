Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2008824848
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 19:38:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLSaJ-0001Q5-4q; Thu, 04 Jan 2024 13:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSaG-0001Lj-5w
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSaE-0005F4-KK
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:47 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 82300B817F7;
 Thu,  4 Jan 2024 18:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C2CC433C7;
 Thu,  4 Jan 2024 18:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704393403;
 bh=35KORY9Rmi3mVoZDzWl33N1x9Mw3dv1eRweBzzDXlA8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CSAXTa+Fots42o2wiXnqKlnIkGZCz6fk8Ji/G4Dy7KojPY7PW5Rsd51IOACYJF8NW
 YG+Iw1x8tElI8zBDbKid5CZfTtsIdHdN6pq65E1uojNIc9gUFxKScNgvWJ0MQutVoI
 7A6rahTfxLxTosBw7Oh0GC0V8dRx/l+kMh1iJ1fod9ecUdZCTZ43hZiXxRvPlMAxG+
 1BoQhKkYJnl+rLTjj3U7P0zaB8EObvL7GbZAttb9c1drC1YNMyVqRZmrdika4rGZV9
 wmg5rv+MHm4QM8E9JkdEWUj7TqICFGSzxX2c4WtdPXZVNBJnE5ym8raja0/Q38zvW6
 4jWovFdzTNfiQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
Subject: [PATCH 6/9] target/hppa: Strip upper 32-bits of IOR on unaligned
 access error
Date: Thu,  4 Jan 2024 19:36:25 +0100
Message-ID: <20240104183628.101366-7-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104183628.101366-1-deller@kernel.org>
References: <20240104183628.101366-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.68.75; envelope-from=deller@kernel.org;
 helo=ams.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

Limit IOR to the lower 32-bits on failure.
Keep patch short for easier backporting.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 04de1689d7..bc30bfe4c7 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -112,7 +112,7 @@ void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     cs->exception_index = EXCP_UNALIGN;
     if (env->psw & PSW_Q) {
         /* ??? Needs tweaking for hppa64.  */
-        env->cr[CR_IOR] = addr;
+        env->cr[CR_IOR] = (uint32_t) addr;
         env->cr[CR_ISR] = addr >> 32;
     }
 
-- 
2.43.0



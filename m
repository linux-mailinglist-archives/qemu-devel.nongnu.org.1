Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E55F9B280A8
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Aug 2025 15:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umuX8-0006Th-ST; Fri, 15 Aug 2025 09:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nir@lichtman.org>) id 1umqIW-0003Hv-BP
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 05:00:28 -0400
Received: from lichtman.org ([149.28.33.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nir@lichtman.org>) id 1umqIU-0004LD-R4
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 05:00:28 -0400
Received: by lichtman.org (Postfix, from userid 1000)
 id 403A8176EAD; Fri, 15 Aug 2025 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
 t=1755248425; bh=Q5YYzQXApQU7LtEY5C9TY0FysNqnlncOXa6EMh4/CSg=;
 h=Date:From:To:Cc:Subject:From;
 b=YrX84ZpER38ouFvWL8Eq+VrkByDuQlC/qm48fLT1q5y0UOXFIVRSNGReQUSbreody
 /cw73RdwuTvwfZ7oThXAmXnYLWEimc9EzCSw4R5fdcwnX/8VJyLKHSYtHA7why25tB
 WANs1OHo676EUhryY4qxFx562e8jCJkjxHmjVycoJvlS9bhaE1nSaLmjxycpmRKP8W
 1k0kfb/nD3nDuVdZW07DOlmf8jn06otI8ygdd61tuFBHSagu1YkYcLLYtwNXGVenT5
 Bk7TLjGMU1Dpa2nHPTROqYp5wzcYd6QBz0aAJtAy73qnn2e6/LtICwcv9ZCK9nhXmw
 9jKbOUG5odh5A==
Date: Fri, 15 Aug 2025 09:00:25 +0000
From: Nir Lichtman <nir@lichtman.org>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH] docs/system/keys: fix incorrect reset scaling key binding
Message-ID: <20250815090025.GA1464436@lichtman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=149.28.33.109; envelope-from=nir@lichtman.org;
 helo=lichtman.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 15 Aug 2025 09:31:48 -0400
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

Fix incorrect key binding for resetting the graphical frontends scaling

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 docs/system/keys.rst.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/keys.rst.inc b/docs/system/keys.rst.inc
index c28ae1a..3b5307b 100644
--- a/docs/system/keys.rst.inc
+++ b/docs/system/keys.rst.inc
@@ -21,7 +21,7 @@ while ``-display sdl,grab-mod=rctrl`` changes it to the right :kbd:`Ctrl` key.
   * - :kbd:`Ctrl+Alt+-`
     - Shrink the screen
 
-  * - :kbd:`Ctrl+Alt+u`
+  * - :kbd:`Ctrl+Alt+0`
     - Restore the screen's un-scaled dimensions
 
   * - :kbd:`Ctrl+Alt+n`
-- 
2.39.5



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A347813E44
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 00:32:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDvAY-0007Mx-PE; Thu, 14 Dec 2023 18:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rDvAU-0007MP-F8
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 18:31:02 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rDvAR-0005kK-Vy
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 18:31:02 -0500
Received: from buffy.. (buffy [192.168.147.6])
 by zoidberg.rfc1149.net (Postfix) with ESMTP id 4DAF580026;
 Fri, 15 Dec 2023 00:30:56 +0100 (CET)
Authentication-Results: zoidberg.rfc1149.net;
 dmarc=fail (p=none dis=none) header.from=rfc1149.net
Authentication-Results: zoidberg.rfc1149.net;
 spf=fail smtp.mailfrom=rfc1149.net
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH 1/2] tcg: Remove unreachable code
Date: Fri, 15 Dec 2023 00:30:54 +0100
Message-ID: <20231214233055.2505387-2-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214233055.2505387-1-sam@rfc1149.net>
References: <20231214233055.2505387-1-sam@rfc1149.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The `fail_rx`/`fail` block is only entered while `buf_rx` is equal to
its initial value `MAP_FAILED`. The `munmap(buf_rx, size);` was never
executed.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2030
Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 tcg/region.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 86692455c0..6d657e8c33 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -597,9 +597,6 @@ static int alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
  fail_rx:
     error_setg_errno(errp, errno, "failed to map shared memory for execute");
  fail:
-    if (buf_rx != MAP_FAILED) {
-        munmap(buf_rx, size);
-    }
     if (buf_rw) {
         munmap(buf_rw, size);
     }
-- 
2.42.0



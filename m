Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC552818FBC
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 19:23:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFejZ-0001pV-Ho; Tue, 19 Dec 2023 13:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rFejX-0001p3-JU
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:22:23 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rFejW-0001Ao-1o
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:22:23 -0500
Received: from buffy.. (buffy [192.168.147.6])
 by zoidberg.rfc1149.net (Postfix) with ESMTP id CE1B380026;
 Tue, 19 Dec 2023 19:22:19 +0100 (CET)
Authentication-Results: zoidberg.rfc1149.net;
 dmarc=fail (p=none dis=none) header.from=rfc1149.net
Authentication-Results: zoidberg.rfc1149.net;
 spf=fail smtp.mailfrom=rfc1149.net
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH v2 2/2] tcg: Make the cleanup-on-error path unique
Date: Tue, 19 Dec 2023 19:22:12 +0100
Message-ID: <20231219182212.455952-3-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231219182212.455952-1-sam@rfc1149.net>
References: <20231219182212.455952-1-sam@rfc1149.net>
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

By calling `error_setg_errno()` before jumping to the cleanup-on-error
path at the `fail` label, the cleanup path is clearer.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 tcg/region.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 467e51cf6f..478ec051c4 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -584,7 +584,9 @@ static int alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
 
     buf_rx = mmap(NULL, size, host_prot_read_exec(), MAP_SHARED, fd, 0);
     if (buf_rx == MAP_FAILED) {
-        goto fail_rx;
+        error_setg_errno(errp, errno,
+                         "failed to map shared memory for execute");
+        goto fail;
     }
 
     close(fd);
@@ -594,8 +596,6 @@ static int alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
 
     return PROT_READ | PROT_WRITE;
 
- fail_rx:
-    error_setg_errno(errp, errno, "failed to map shared memory for execute");
  fail:
     /* buf_rx is always equal to MAP_FAILED here and does not require cleanup */
     if (buf_rw) {
-- 
2.42.0



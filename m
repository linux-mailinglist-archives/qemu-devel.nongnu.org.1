Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B72A7F72C9
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:33:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UQ4-0003Jc-IF; Fri, 24 Nov 2023 06:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1r6UPz-0003Fu-Tf; Fri, 24 Nov 2023 06:32:19 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1r6UPx-0006s5-NO; Fri, 24 Nov 2023 06:32:19 -0500
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1700825530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pu9NU45BXErFOacHk+M+S/D8MM3PFGCAXvanrcLKpYk=;
 b=LvH55AComKV6WKCFb3sazJrpwq4HgBk6hmB7tpsghIlJKtcYxMGHOWnKbSck8swLFXatLS
 yzoLZPkV7Vl+5duDLivC5KpXXfKyG7Q3EQio0RPvsM3aA0AmuWDXlfOkdPaIOvWJ/l7eH1
 0uc7KbFhN/xmbGF4Riu7DiMY57Nt+d0=
To: kwolf@redhat.com,
	hreitz@redhat.com,
	qemu-block@nongnu.org
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] block/monitor: blk_bs() return value check
Date: Fri, 24 Nov 2023 14:30:38 +0300
Message-Id: <20231124113037.2477645-1-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

blk_bs() may return NULL, which will be dereferenced without a check in
bdrv_commit().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 block/monitor/block-hmp-cmds.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index c729cbf1eb..ade627bc27 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -221,7 +221,13 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
             return;
         }
 
-        bs = bdrv_skip_implicit_filters(blk_bs(blk));
+        bs = blk_bs(blk);
+        if (!bs) {
+            error_report("Device '%s' is invalid", device);
+            return;
+        }
+
+        bs = bdrv_skip_implicit_filters(bs);
         aio_context = bdrv_get_aio_context(bs);
         aio_context_acquire(aio_context);
 
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF277BF901
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 12:50:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqAJG-0004WZ-CQ; Tue, 10 Oct 2023 06:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1qqAJD-0004Ux-4j
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 06:49:51 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1qqAJA-0007hl-9y
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 06:49:50 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1696934982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ERKNBRgpdrA6t5WeubWreFcdB8u4YHHlL72l5T0lRbg=;
 b=dEYJD3zpAF2tX5p63xxAEzQgzBLvWzztrQmbdh+r8pHLTXOyVLNl79Myu0urVNL+tfXy5D
 gIPExUZ65Dtri17pR6pazMJfRqOQUzpJXmHf9zxOkeMKZdq7k8yjL5UoShXKLN/bZXQlw+
 f3lH9/EGFxdyfcO1a0qAPa157Le+OzQ=
To: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org,
	Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH v1] migration: fix RAMBlock add NULL check
Date: Tue, 10 Oct 2023 13:48:53 +0300
Message-Id: <20231010104851.802947-1-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

qemu_ram_block_from_host() may return NULL, which will be dereferenced w/o
check. Usualy return value is checked for this function.
Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c7c0e72408df5e7821c0e995122fb2fe0ac001f1 ("migration/ram: Handle RAM block resizes during precopy")
Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 migration/ram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index e4bfd39f08..bd4b7574e1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4281,6 +4281,11 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
     RAMBlock *rb = qemu_ram_block_from_host(host, false, &offset);
     Error *err = NULL;
 
+    if (!rb) {
+        error_report("RAM block not found");
+        return;
+    }
+
     if (migrate_ram_is_ignored(rb)) {
         return;
     }
-- 
2.34.1



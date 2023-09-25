Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4117ADFB0
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrSJ-0002ha-Ng; Mon, 25 Sep 2023 15:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSG-0002ev-DB
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:17 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSD-0004mt-F7
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 140D660153;
 Mon, 25 Sep 2023 22:41:11 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6422::1:2a])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id geUBjG0OhCg0-5oRQ8Zbd; Mon, 25 Sep 2023 22:41:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695670870;
 bh=TDaHag51snfRqyz98agZxwCE0S8VXdIHLEWvamoUc1c=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=xD518qmlSt7Qhd5eSNufxV55PpGgrXuebEtfjSY2nWPyewivk+ddbrdEyTfUEK13s
 1ve+qLPa6VfvO0xI/1ApMrhSfc52apckYlt5m2oBLvX8AYqJ9S0yAKK16WRd7Z80OC
 v+tbLrSXxg3fw90l++dG9fcgd8QanXDviT4fs0tw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru,
 Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 05/12] device_tree: qmp_dumpdtb(): stronger assertion
Date: Mon, 25 Sep 2023 22:40:33 +0300
Message-Id: <20230925194040.68592-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925194040.68592-1-vsementsov@yandex-team.ru>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

Coverity mark this size, got from the buffer as untrasted value, it's
not good to use it as length when writing to file. Make the assertion
more strict to also check upper bound.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 softmmu/device_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/softmmu/device_tree.c b/softmmu/device_tree.c
index 30aa3aea9f..adc4236e21 100644
--- a/softmmu/device_tree.c
+++ b/softmmu/device_tree.c
@@ -660,7 +660,7 @@ void qmp_dumpdtb(const char *filename, Error **errp)
 
     size = fdt_totalsize(current_machine->fdt);
 
-    g_assert(size > 0);
+    g_assert(size > 0 && size <= FDT_MAX_SIZE);
 
     if (!g_file_set_contents(filename, current_machine->fdt, size, &err)) {
         error_setg(errp, "Error saving FDT to file %s: %s",
-- 
2.34.1



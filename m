Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6557EA13C
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 17:26:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Zks-0007sV-Hm; Mon, 13 Nov 2023 11:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2Zko-0007s1-L4
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:25:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2Zkn-00067B-At
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 11:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699892736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UQa1dJA2ZNQnfTyoD4OPTHJafGWz96a13UVUR7iEohI=;
 b=ELtqdYqm7rjp9kEpPDYn8B6+TlcOVlaOyYg+23mP9IsJmxG5CCxFHM/XiPZ1yDr8Wcuugg
 V2i8KKuHIZJ2bCCqQgbHFQ+xvEYf7jQgRe/a0Da6RObxbF3uSIxCqZeUKS7yLCWfa2RJeK
 sdOWGToMn9p8jmllhso0DthoDlFnpjA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-eoSktUKAO_isrFtxbMK1nA-1; Mon,
 13 Nov 2023 11:25:32 -0500
X-MC-Unique: eoSktUKAO_isrFtxbMK1nA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 715FD3806282;
 Mon, 13 Nov 2023 16:25:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B65F1C060AE;
 Mon, 13 Nov 2023 16:25:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] tests/data/qobject/qdict.txt: Avoid non-inclusive words
Date: Mon, 13 Nov 2023 17:25:29 +0100
Message-ID: <20231113162529.54276-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

qdict.txt only consists of more or less random test data. We
can simply drop the lines with the problematic words here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/data/qobject/qdict.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/data/qobject/qdict.txt b/tests/data/qobject/qdict.txt
index 122fda4524..e2edc88161 100644
--- a/tests/data/qobject/qdict.txt
+++ b/tests/data/qobject/qdict.txt
@@ -1866,10 +1866,6 @@ blackfin: 4096
 blackfin.c: 7552
 blackfin.h: 1089
 blackfin_sram.h: 1207
-blacklist.c: 8658
-blacklist.h: 108
-blackstamp.c: 9838
-BlackStamp_defconfig: 27434
 blinken.h: 617
 blizzard.c: 41338
 blizzard.h: 249
-- 
2.41.0



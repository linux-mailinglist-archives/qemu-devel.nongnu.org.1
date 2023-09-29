Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0357C7B2EAC
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:57:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Di-0005F0-97; Fri, 29 Sep 2023 04:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DX-00055g-CK
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DC-0005cJ-Qd
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RblW5yTCxDRLJKGfYdaOTh+OR9JgnGGeaSPLNcKIiEI=;
 b=IFvyYqqszX13OwwLKTHRJiD5b5shUey++K2sQWRYT5orypy41WdE3yI8HEkFzNWKPVb8ao
 y2fBjW4bwwrSH8NyNCqG7UBGPHGTa0zocYF/9eTns8oez/aVZN0KO8wtmdSuIHnBjMnwCG
 guTdd2zkf7OHlbNisFgKgYSofaOtgDs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-4mEqS7yhOa-bqshfaQiCSg-1; Fri, 29 Sep 2023 04:50:58 -0400
X-MC-Unique: 4mEqS7yhOa-bqshfaQiCSg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03CE31C08974;
 Fri, 29 Sep 2023 08:50:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A0D614171B6;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 896F021E6884; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 20/56] net/eth: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:17 +0200
Message-ID: <20230929085053.2789105-21-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fix:

  net/eth.c:435:20: error: declaration shadows a local variable [-Werror,-Wshadow]
            size_t input_size = iov_size(pkt, pkt_frags);
                   ^
  net/eth.c:413:16: note: previous declaration is here
        size_t input_size = iov_size(pkt, pkt_frags);
               ^

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904161235.84651-16-philmd@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 net/eth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 649e66bb1f..3f680cc033 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -432,8 +432,6 @@ _eth_get_rss_ex_src_addr(const struct iovec *pkt, int pkt_frags,
         }
 
         if (opthdr.type == IP6_OPT_HOME) {
-            size_t input_size = iov_size(pkt, pkt_frags);
-
             if (input_size < opt_offset + sizeof(opthdr)) {
                 return false;
             }
-- 
2.41.0



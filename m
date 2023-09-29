Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E36F7B2E75
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:53:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Dk-0005Gl-In; Fri, 29 Sep 2023 04:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DQ-00050A-VQ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DB-0005cg-Pm
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EzuqQcLXPkEwoJkgWGFTACoAmjwA24zZHh83aGo4fhg=;
 b=OVuAXnWaRL+awcw95w845dYhzOzbhuc/yTdUVKwnXqdHFrTRkjsJRiYlw0NFzO+R7VACRs
 mPy9px+rfB9SussUmJtYRodTieUdEK/tmsD7kE2JKrIkxXXDUo4y7VN/spGDs7nU5iHm5W
 TsPtEhhZa8No098qYOdaXWY89bTPnGE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-693-1RxhfZimOkSXlzdINSbOpg-1; Fri, 29 Sep 2023 04:50:57 -0400
X-MC-Unique: 1RxhfZimOkSXlzdINSbOpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8F6A185A79B;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86C29C15BB8;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 91D6A21E6887; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/56] linux-user/strace: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:20 +0200
Message-ID: <20230929085053.2789105-24-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  linux-user/strace.c: In function ‘print_sockaddr’:
  linux-user/strace.c:370:17: warning: declaration of ‘i’ shadows a previous local [-Wshadow=compatible-local]
    370 |             int i;
        |                 ^
  linux-user/strace.c:361:9: note: shadowed declaration is here
    361 |     int i;
        |         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904161235.84651-20-philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 linux-user/strace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index e0ab8046ec..cf26e55264 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -367,7 +367,6 @@ print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
         switch (sa_family) {
         case AF_UNIX: {
             struct target_sockaddr_un *un = (struct target_sockaddr_un *)sa;
-            int i;
             qemu_log("{sun_family=AF_UNIX,sun_path=\"");
             for (i = 0; i < addrlen -
                             offsetof(struct target_sockaddr_un, sun_path) &&
-- 
2.41.0



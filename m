Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE4F7B2ED0
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 11:02:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Ma-0001lb-Kc; Fri, 29 Sep 2023 05:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9MS-0001i7-Nn
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9MM-0008BV-J6
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695978029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2+QjRvp3xEKiyrdGhfSbaHvdWg1xeZJy16DjtM+7W3I=;
 b=ixba2SUKG31U/xdq3fVI6NInNIIwC9vi3SafOHMyUl7LSIIhDki7ETqgZ+Bwbsjj4QawxL
 lQ+QSzVXuFq2owKWqOq2AYjzj70IpoktCxjZ1EMXeamHco4stF/C5M+srn7ogEUogAz9M7
 TLB0hNacZD0sXGRKZlsRnhKk+BhlAs4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-xdb59CrMO4K0qrLgeHKuiw-1; Fri, 29 Sep 2023 05:00:27 -0400
X-MC-Unique: xdb59CrMO4K0qrLgeHKuiw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7163C3806737;
 Fri, 29 Sep 2023 09:00:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D4AAC15BB8;
 Fri, 29 Sep 2023 09:00:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DA23121E68A3; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 46/56] aspeed/timer: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:43 +0200
Message-ID: <20230929085053.2789105-47-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Cédric Le Goater <clg@kaod.org>

commit 8137355e850f ("aspeed/timer: Fix behaviour running Linux")
introduced a MAX() expression to calculate the next timer deadline :

    return calculate_time(t, MAX(MAX(t->match[0], t->match[1]), 0));

The second MAX() is not necessary since the compared values are an
unsigned and 0. Simply remove it and fix warning :

  ../hw/timer/aspeed_timer.c: In function ‘calculate_next’:
  ../include/qemu/osdep.h:396:31: warning: declaration of ‘_a’ shadows a previous local [-Wshadow=compatible-local]
    396 |         typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
        |                               ^~
  ../hw/timer/aspeed_timer.c:170:12: note: in expansion of macro ‘MAX’
    170 |     next = MAX(MAX(calculate_match(t, 0), calculate_match(t, 1)), 0);
        |            ^~~
  ../hw/timer/aspeed_timer.c:170:16: note: in expansion of macro ‘MAX’
    170 |     next = MAX(MAX(calculate_match(t, 0), calculate_match(t, 1)), 0);
        |                ^~~
  /home/legoater/work/qemu/qemu-aspeed.git/include/qemu/osdep.h:396:31: note: shadowed declaration is here
    396 |         typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
        |                               ^~
  ../hw/timer/aspeed_timer.c:170:12: note: in expansion of macro ‘MAX’
    170 |     next = MAX(MAX(calculate_match(t, 0), calculate_match(t, 1)), 0);
        |            ^~~

Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230922155924.1172019-5-clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/timer/aspeed_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 9c20b3d6ad..72161f07bb 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -167,7 +167,7 @@ static uint64_t calculate_next(struct AspeedTimer *t)
         qemu_set_irq(t->irq, t->level);
     }
 
-    next = MAX(MAX(calculate_match(t, 0), calculate_match(t, 1)), 0);
+    next = MAX(calculate_match(t, 0), calculate_match(t, 1));
     t->start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
     return calculate_time(t, next);
-- 
2.41.0



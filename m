Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D69457CDCE6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6IG-0006du-3C; Wed, 18 Oct 2023 09:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HT-0004eJ-V4
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HR-00083a-5u
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GdJoVYhU7RQIhJeFF6OrBxeBGJUQ6x9Gmhs3GG8upeI=;
 b=NldHcAKbY2GML0F50KkJhxilLWz+iKoLg3H/Qg5OHIjLGrwecRMSBAbAJpFbV6wcXU6sBW
 Y/5A4tIvoW158qaaXtO7/5wB9iQiIymjmc6ZmMkYPGj9dpHiEDCEBKC5S08z0SKzy3/tar
 N7ddVJEgboCRkQM5ODszrx63xclOha0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-geX-YYx7NH-BRoFRG_0yVg-1; Wed, 18 Oct 2023 09:07:57 -0400
X-MC-Unique: geX-YYx7NH-BRoFRG_0yVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F07788B7A6;
 Wed, 18 Oct 2023 13:07:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 083CD20268C8;
 Wed, 18 Oct 2023 13:07:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 22/25] hw/s390x: Clean up global variable shadowing in
 quiesce_powerdown_req()
Date: Wed, 18 Oct 2023 15:07:13 +0200
Message-ID: <20231018130716.286638-23-thuth@redhat.com>
In-Reply-To: <20231018130716.286638-1-thuth@redhat.com>
References: <20231018130716.286638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

  hw/s390x/sclpquiesce.c:90:22: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      QuiesceNotifier *qn = container_of(n, QuiesceNotifier, notifier);
                       ^
  hw/s390x/sclpquiesce.c:86:3: note: previous declaration is here
  } qn;
    ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231009094747.54240-7-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/sclpquiesce.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index ce07b16884..a641089929 100644
--- a/hw/s390x/sclpquiesce.c
+++ b/hw/s390x/sclpquiesce.c
@@ -78,12 +78,10 @@ static const VMStateDescription vmstate_sclpquiesce = {
      }
 };
 
-typedef struct QuiesceNotifier QuiesceNotifier;
-
-static struct QuiesceNotifier {
+typedef struct QuiesceNotifier {
     Notifier notifier;
     SCLPEvent *event;
-} qn;
+} QuiesceNotifier;
 
 static void quiesce_powerdown_req(Notifier *n, void *opaque)
 {
@@ -97,6 +95,8 @@ static void quiesce_powerdown_req(Notifier *n, void *opaque)
 
 static int quiesce_init(SCLPEvent *event)
 {
+    static QuiesceNotifier qn;
+
     qn.notifier.notify = quiesce_powerdown_req;
     qn.event = event;
 
-- 
2.41.0



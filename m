Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72251BF5A2D
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 11:50:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB90C-0004CB-Pw; Tue, 21 Oct 2025 05:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vB907-0004B6-UL
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vB906-0001wX-CQ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761040193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTc/Y2BbGU73M3MBZFTDitmXc0v4yNOWDYQPB/QlnjU=;
 b=WlUIujBsAkvmY4fuwMD5UTi35Wv+FlIup+MxIqkXmUrfZ0S/a+q531IWEljHxlNGPqK3Xk
 uBvTSyuZ2ypMZS9VlcS9u7eXui+emmPy3wlVf6vyH6CxA95iMd3+WOfr0PqjNdfdHH7+Ys
 8k5gukhMn/mE1F1gDDV8/JBJMp2czlg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-8Ul9t4oiObKFBOfUUKZEcQ-1; Tue,
 21 Oct 2025 05:49:49 -0400
X-MC-Unique: 8Ul9t4oiObKFBOfUUKZEcQ-1
X-Mimecast-MFC-AGG-ID: 8Ul9t4oiObKFBOfUUKZEcQ_1761040187
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96C201800741; Tue, 21 Oct 2025 09:49:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F56819560A2; Tue, 21 Oct 2025 09:49:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EFC421E6924; Tue, 21 Oct 2025 11:49:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/1] ui/pixman: Fix crash in qemu_pixman_shareable_free()
Date: Tue, 21 Oct 2025 11:49:43 +0200
Message-ID: <20251021094943.3585876-2-armbru@redhat.com>
In-Reply-To: <20251021094943.3585876-1-armbru@redhat.com>
References: <20251021094943.3585876-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reported-by: Bernhard Beschow <shentey@gmail.com>
Fixes: b296b29d3414 (ui/pixman: Consistent error handling in qemu_pixman_shareable_free())
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251013112102.2396012-1-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
---
 ui/qemu-pixman.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index e46c6232cf..aea09755b9 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -291,7 +291,9 @@ qemu_pixman_shareable_free(qemu_pixman_shareable handle,
     Error *err = NULL;
 
     qemu_win32_map_free(ptr, handle, &err);
-    error_report_err(err);
+    if (err) {
+        error_report_err(err);
+    }
 #else
     qemu_memfd_free(ptr, size, handle);
 #endif
-- 
2.49.0



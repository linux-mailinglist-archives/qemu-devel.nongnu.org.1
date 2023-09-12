Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BED8779D8D9
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 20:43:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8Kd-0004Uz-Gv; Tue, 12 Sep 2023 14:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg8KX-0004Tc-3w
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg8KU-0001R3-3H
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694544101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmz3fnUyyNHeeq0yChyHiqQDJDibl5/ScPj+H4Udnqs=;
 b=UUGDy8PZ5niu5eO0J6mvqwflsWTPIQJgE5PRfo1tqOOV0E9DJNqYlrBeruEmftXicFjk4E
 g+SeVSgzxcj5kB09ih9lvsi//FMplPodHEmHAPCqXoaN0zd/NyG4XXeaMjT27/lgOW/rd5
 0Vb84dWzzfQuU8e9GSU6UnnM74n5pjQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-681-yQX6Wp6JMdGc5unjBWGJDA-1; Tue, 12 Sep 2023 14:41:37 -0400
X-MC-Unique: yQX6Wp6JMdGc5unjBWGJDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 297003C0EAA0;
 Tue, 12 Sep 2023 18:41:37 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9823B7B62;
 Tue, 12 Sep 2023 18:41:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/4] qtest: kill orphaned qtest QEMU processes on FreeBSD
Date: Tue, 12 Sep 2023 19:41:28 +0100
Message-ID: <20230912184130.3056054-3-berrange@redhat.com>
In-Reply-To: <20230912184130.3056054-1-berrange@redhat.com>
References: <20230912184130.3056054-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Linux we use PR_SET_PDEATHSIG to kill orphaned QEMU processes
if we fail to call qtest_quit(), or the test program aborts/segvs.
This prevents meson from hanging forever due to the orphaned
process keeping stdout open.

On FreeBSD we can achieve the same using PROC_PDEATHSIG_CTL, which
gives us the equivalent protection against hangs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/libqtest.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 34b9c14b75..b1eba71ffe 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -24,6 +24,9 @@
 #ifdef __linux__
 #include <sys/prctl.h>
 #endif /* __linux__ */
+#ifdef __FreeBSD__
+#include <sys/procctl.h>
+#endif /* __FreeBSD__ */
 
 #include "libqtest.h"
 #include "libqmp.h"
@@ -414,6 +417,10 @@ static QTestState *G_GNUC_PRINTF(1, 2) qtest_spawn_qemu(const char *fmt, ...)
          */
         prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 #endif /* __linux__ */
+#ifdef __FreeBSD__
+        int sig = SIGKILL;
+        procctl(P_PID, getpid(), PROC_PDEATHSIG_CTL, &sig);
+#endif /* __FreeBSD__ */
         if (!g_setenv("QEMU_AUDIO_DRV", "none", true)) {
             exit(1);
         }
-- 
2.41.0



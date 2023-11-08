Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFEE7E5B25
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 17:25:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0lMk-00043u-1c; Wed, 08 Nov 2023 11:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smitterl@redhat.com>)
 id 1r0lMb-000434-FS
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 11:25:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smitterl@redhat.com>)
 id 1r0lMZ-0004Cq-R3
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 11:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699460706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z+Kd8D4ZxwpH7Ta3ZCRieR1Dc6Cf83zEOrRIhJPJel0=;
 b=blFG9MCyVvQKyozd4yUV4P4CX4Q4lGLMhkL5AP5xEkH6cgZeJ35k/ggPf/KKUVwY+JFwfv
 cKGeZeczxYYwtglENq7CdZMYIh/kIZVmGbKZtOOg81dZqMkboIJD2RKRXa3ldr/ghwDrh/
 GifUWVDxWexCTfZTfFYwStniCFg1ac4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-XRzlwM11OTSx-RW5HdxXXw-1; Wed, 08 Nov 2023 11:23:57 -0500
X-MC-Unique: XRzlwM11OTSx-RW5HdxXXw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0750A83DE2D;
 Wed,  8 Nov 2023 16:23:57 +0000 (UTC)
Received: from s390x-kvm-006.lab.eng.rdu2.redhat.com
 (s390x-kvm-006.lab.eng.rdu2.redhat.com [10.0.160.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F28B9492BEF;
 Wed,  8 Nov 2023 16:23:56 +0000 (UTC)
From: Sebastian Mitterle <smitterl@redhat.com>
To: peter.maydell@linaro.org
Cc: thuth@redhat.com,
	qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] risu: Add test summary
Date: Wed,  8 Nov 2023 11:23:56 -0500
Message-ID: <20231108162356.36670-1-smitterl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=smitterl@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently, a successful test run finishes silently with exit code 0.
The last message on the console is "starting image" which can leave
the user wondering if they executed the commands correctly.

Now add a summary of the number of executed instructions in case
of success. Don't add that message when printing the trace to
stdout (`-t -`).

Tested:
a) master/apprentice mode
b) trace mode to file
c) trace mode to stdout

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Sebastian Mitterle <smitterl@redhat.com>
---
 risu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/risu.c b/risu.c
index 36fc82a..740663a 100644
--- a/risu.c
+++ b/risu.c
@@ -551,6 +551,7 @@ int main(int argc, char **argv)
     struct option *longopts;
     char *shortopts;
     stack_t ss;
+    int ret;
 
     longopts = setup_options(&shortopts);
 
@@ -635,8 +636,15 @@ int main(int argc, char **argv)
     arch_init();
 
     if (ismaster) {
-        return master();
+        ret = master();
     } else {
-        return apprentice();
+        ret = apprentice();
     }
+
+    if (ret == EXIT_SUCCESS && (!trace || (trace  && strcmp(trace_fn, "-") != 0))) {
+        fprintf(stderr, "No mismatches found. Executed %zd checkpoints.\n",
+                signal_count);
+    }
+
+    return ret;
 }
-- 
2.41.0



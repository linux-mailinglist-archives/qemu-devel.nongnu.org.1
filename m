Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D12B70BC55
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:51:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144C-0005SH-21; Mon, 22 May 2023 07:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143X-0005AB-3n
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143V-0007Wg-F5
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FeS9PDazdw93oPnt1Z1wmuikBMsBZ3FARh431c5igA0=;
 b=Ye4bqbX1s3/exK+nIkMj716IIc4NYrcNH/GeVtDOT+sHjvRbeg3mPnX9Ofz+lPzlsugieD
 BO+teeGdDRelriW37sUME8Dy3iwrqJ45nI0Id1q8zC3JOGK5jvlAVHMF3x1dE3uaqVQWZq
 TG84dAseFrm0aQg5GqmXIKrKC2Uvcow=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-JwCek5vhPxCCpZc_4lMcSQ-1; Mon, 22 May 2023 07:50:21 -0400
X-MC-Unique: JwCek5vhPxCCpZc_4lMcSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 479D2185A78E;
 Mon, 22 May 2023 11:50:21 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 830B32166B26;
 Mon, 22 May 2023 11:50:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 04/20] softmmu/vl.c: Disable default NIC if it has not been
 compiled into the binary
Date: Mon, 22 May 2023 13:49:58 +0200
Message-Id: <20230522115014.1110840-5-thuth@redhat.com>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
References: <20230522115014.1110840-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Don't try to instantiate a default NIC if it is not available (since
this will cause QEMU to abort). Emit a warning instead.

Message-Id: <20230512124033.502654-5-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 softmmu/vl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 43d3b972da..b0b96f67fa 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1294,6 +1294,13 @@ static void qemu_disable_default_devices(void)
         default_monitor = 0;
         default_net = 0;
         default_vga = 0;
+    } else {
+        if (default_net && machine_class->default_nic &&
+            !module_object_class_by_name(machine_class->default_nic)) {
+            warn_report("Default NIC '%s' is not available in this binary",
+                        machine_class->default_nic);
+            default_net = 0;
+        }
     }
 }
 
-- 
2.31.1


